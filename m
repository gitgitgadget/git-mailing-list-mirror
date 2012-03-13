From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Tue, 13 Mar 2012 16:05:25 -0700
Message-ID: <7v1uowt83u.fsf@alter.siamese.dyndns.org>
References: <4F5E3298.5030502@seap.minhap.es>
 <7vk42pr3c7.fsf@alter.siamese.dyndns.org> <4F5F41FF.4000204@seap.minhap.es>
 <7vy5r4wfru.fsf@alter.siamese.dyndns.org>
 <20120313220411.GA28357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 00:05:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7amc-0004i8-30
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 00:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760551Ab2CMXF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 19:05:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759928Ab2CMXF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 19:05:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2FA601C;
	Tue, 13 Mar 2012 19:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=koL9N/JMOBpm27a01apnVbppDlI=; b=snIptB
	O9Fl69D2ox1TuJeliY1tjtBiFqXrVEKcDJMvbp2WcNjJdG4k+6wFLNIUHGgCnlJz
	V+QHLbQn2WJGWP6cqDNL13reaaAZVcO2EtpMaWHm+aYRuKpjkhF6i/fyoPWuO99L
	6rPmBn6G1e6165YRPYJ/8xlrCmPRckM1AsXOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJ5E60T1NBytiY/QOGPUVF5OjZ6QqUbP
	yq2fgCkZFBVD7oNBvv9Jq3p8pLRBpO7Dvwow8qmDzveTPn0vPf149PVkSfPds3CQ
	j5ZPMZ5NG/b80/pwzK54gNVduGiS0fF0dPnm8pLukNcpCz5clVabMkooi51AtEFJ
	YRdELKRGW2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64D11601B;
	Tue, 13 Mar 2012 19:05:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4CCE601A; Tue, 13 Mar 2012
 19:05:26 -0400 (EDT)
In-Reply-To: <20120313220411.GA28357@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Mar 2012 18:04:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05640EEA-6D61-11E1-8DF4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193078>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 13, 2012 at 10:51:33AM -0700, Junio C Hamano wrote:
>
>> Either has AUTH as a substring in it, and leaves a door open for us to
>> later introduce HTTP_RETRY to tell the machinery that drives cURL library
>> to retry the request, so in that sense I am OK with either, but as your
>> log message said, we want to make it clear that this is not about doing
>> the authentication again (re-auth) but retrying the authentication, so
>> HTTP_AUTH_RETRY would be more logical name.
>
> I suggested RETRY because that is all the caller needs to know: the
> http_request machinery said "please call me again". Keep in mind that
> this is a private interface within http.c, and this return code should
> never make it out at all. Nor is it something anybody else would feed
> us.

Oh, the potential "retry when a request failed" in the future I had in
mind was also contained within http.c.  Perhaps HTTP_RETRY could be used
for the same purpose?  The places I had in mind that we may potentially
want to retry are where we got 50x from one of the servers in the pool
that serves the name we are accessing, we got 401 from the server to let
us realize we gave it a wrong credential, or we got 407 from the proxy to
notify a similar situation, and all are potential candidate for retrying
in the client may help. The credential might have been mistyped for 40x,
or we may hit a healthy server in the same pool for 50x.
