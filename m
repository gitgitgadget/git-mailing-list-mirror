From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 00:09:37 -0800
Message-ID: <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 09:09:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrnJg-0005lz-79
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 09:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab1BVIJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 03:09:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1BVIJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 03:09:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3CBB2DDC;
	Tue, 22 Feb 2011 03:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=EfP1bnGGu30MumNOFEIDfOAvOzs=; b=t2/kMD
	n/DJ2eXBUC7jCOHsgcT1m6HktjtIOWRG1T/rYlzF4mgu8kgD/6jTnX2PAa4DsWWU
	bgWqHt9xkxSwxXE36BQpe8WY9lYA8BZZf2BAcqp6EIAXWfpabdy8hd0e1rG85lwe
	Nk9syIl8iC52r0GX56drxFkMWA2fAJv2gR9es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfMC1KIEXQnmdBD6ApTJIm7hyU5UC4Gu
	ncJy+mTKoIqRH5SCy12vlR6rjLNYkzFP1NCJawa099pvB2lovohkyRT8dscckChR
	Vh3d65idSiRzOHyZUFbie22mu82g8hfykqllXwfjcpy/yZAv41wnFLs0aTjDy/CP
	NkGQ2QVLB7Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6E712DDA;
	Tue, 22 Feb 2011 03:10:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 64D4F2DD9; Tue, 22 Feb 2011
 03:10:51 -0500 (EST)
In-Reply-To: <20110222080305.GA11177@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 22 Feb 2011 03\:03\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45E118B8-3E5B-11E0-841B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167533>

Jeff King <peff@peff.net> writes:

> It sounds a lot saner to me to fix "git tag", then, to ignore certain
> uninteresting bits of the tag namespace. We already do allow pattern
> matching the tags shown, but:
>
>   1. It's an fnmatch, so I don't think there is a way to do a negative
>      match like "ignore everything that matches release/*".
>
>   2. It can only be specified on the command-line, whereas obviously you
>      would want this as the default for a repo when you type "git tag".
>
> So I think we could do something like the patch below, which allows:
>
>   # set up some boring and interesting tags
>   for i in boring more-boring interesting; do
>     for j in one two three; do
>       git tag $i/$j
>     done
>   done
>
>   # tell git to ignore boring stuff
>   git config tag.ignore 'boring/*'
>   git config --add tag.ignore 'more-boring/*'

Hmph, isn't that what "grep -v" was invented for?

Also it is unclear if the boring tags will or will not be propagated (or
should or should not be, for that matter) to outer world when you do "git
push --tags" with your "ignore".  Most likely some people do want to see
them hidden (e.g. when publishing), and some others do want to be pushed
(e.g. when backing the repository up).
