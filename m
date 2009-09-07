From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Mon, 07 Sep 2009 01:18:58 -0700
Message-ID: <7vljkryxot.fsf@alter.siamese.dyndns.org>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Tom Preston-Werner <tom@mojombo.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZRZ-0001jK-Ak
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbZIGITM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZIGITL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:19:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbZIGITL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:19:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F6DE4791C;
	Mon,  7 Sep 2009 04:19:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dIZhyijDyOPn2nJ76mg32KBsz0E=; b=ZYmlJH
	xYxYwf8w81oBm9jOjCiQvPa37wsW/0tT0EdD8aCaKkizhTjxRLdBrP70M0ETw3aA
	J0Rc6DgSsnueWSmupgt+3Hv8t5QGRisoatKAdmuUFtUpvjkQZPXqDkTEz93EX2Ld
	1OMhzLcraPPecbfOAQbofZrGf1Va0AZDp2fE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtfzbQiBF2JUZ2R2XtdvEtZwF+jwERrd
	y74Qlmpvd9oZSKL5kAHgkGM4D1yC7yAE2kJMsBYajDca7h734jnqyalm/XFvuZnB
	1835eNaE9uAoT8Sdg6HJ1Y1fzidb6m78ZxMvT3bYyFAccDZoF4bqBAYn74LJkX9x
	NZvVhYJFdt4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB9054791A;
	Mon,  7 Sep 2009 04:19:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA66347919; Mon,  7 Sep 2009
 04:19:00 -0400 (EDT)
In-Reply-To: <7vocpn44dg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 07 Sep 2009 00\:10\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D14C9AC-9B87-11DE-B009-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127901>

Junio C Hamano <gitster@pobox.com> writes:

> In order to support fetch/clone over HTTP, a server at least must respond
> to requests to the follwoing locations sensibly, meaning that it gives us
> back the data without frills if they exist, and give us Not found if they
> don't.
>
>  - $URL/objects/info/refs
>
>    This must list all the refs available in the repository and must be
>    up-to-date.  We do not run PROPFIND, nor parse $URL/refs/index.htm, but
>    trust this file's contents and start from there.

Correction.  This is $URL/info/refs and the github repository in question
does respond correctly.  Sorry about the confusion.

Recent code makes CURLOPT_NOBODY request, which will turn into a HEAD
request over HTTP, to packfiles, in order to see if they exist.  Perhaps
github is not prepared to handle that and returns 500, even though it will
give the pack correctly if asked with a GET request?
