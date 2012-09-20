From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "retry request without query when info/refs?query
 fails"
Date: Wed, 19 Sep 2012 23:31:32 -0700
Message-ID: <7vhaqtciij.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <1348120680-24788-1-git-send-email-spearce@spearce.org>
 <7vlig5cilt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 08:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEaIZ-0005Tc-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 08:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905Ab2ITGbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 02:31:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006Ab2ITGbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 02:31:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FE2E9DA0;
	Thu, 20 Sep 2012 02:31:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uibZNPWH3lBC40FgE8uM5HjU39M=; b=nS8jTH
	4aheQA9uisphbBvpR92BY9rPuvh0x3y1E2B6MgTwOq7QOkYgPKWWLLW4MaTdt7Qf
	WnrNdElhFzzRQPgSYRirfn2ZLEr1X2G/Ugpea1VGtcv7ycecx8Sj+RJ7LfoSDiZr
	7+7fUkgvKmUM6GFz3S0DbPbsl1n4ml5WjNiS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YvMfHODNW+9ncaP+Yk/AR3d65ZVwwepi
	vENy0FxjYKGgOjtGZTSlkrfTSB8j1ra9ZfbIaxb3nfHf7kR/ljdSWhRT2VhDCMwT
	wXQxaMAw2P9s0w6zLze39V6AOyB9mbVAVU9KuFw8adW7eEG0XUEOjwqxy7Fh+03g
	ai50NBRgsRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C4F29D9F;
	Thu, 20 Sep 2012 02:31:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A832A9D9E; Thu, 20 Sep 2012
 02:31:33 -0400 (EDT)
In-Reply-To: <7vlig5cilt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 19 Sep 2012 23:29:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D23847EE-02EC-11E2-9F99-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206038>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> This reverts commit 703e6e76a14825e5b0c960d525f34e607154b4f7.
>>
>> Retrying without the query parameter was added as a workaround
>> for a single broken HTTP server at git.debian.org[1]. The server
>> was misconfigured to route every request with a query parameter
>> into gitweb.cgi. Admins fixed the server's configuration within
>> 16 hours of the bug report to the Git mailing list, but we still
>> patched Git with this fallback and have been paying for it since.
>
> As the consequence of the above, the only two things we know about
> the servers in the wild are (1) a misconfiguration that requires
> this retry was once made, so it is not very unlikely others did the
> same misconfiguration, and (2) those unknown number of servers have
> been happily serving the current clients because the workaround
> patch have been hiding the misconfiguration ever since.
>
> But as long as the failure diagnosis from updated clients that
> revert this workaround is sufficient to allow such misconfigured
> servers, I think it is OK.  We might see a large number of small

s/servers,/servers diagnosed,/;

> people having to run around and fix the configuration as a fallout,
> though.
>
>> Most Git hosting services configure the smart HTTP protocol and the
>> retry logic confuses users when there is a transient HTTP error as
>> Git dropped the real error from the smart HTTP request. Removing the
>> retry makes root causes easier to identify.
>
> Does that hold true also for dumb only small people installations?
> They are the ones that need more help than the large installations
> staffed sufficiently and run smart http gateway.

In any case, will queue.
