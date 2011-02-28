From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 10:11:17 -0800
Message-ID: <7vy650hvwa.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 19:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7ZI-0004SL-Go
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 19:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab1B1SLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 13:11:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1B1SLb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 13:11:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 873124C16;
	Mon, 28 Feb 2011 13:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sF32N43kaKsn9VsGk177ybm696U=; b=LKSRFD
	dlt/SShzkPyKcc1ok4u0x9y8hn3Y4Bx8kKUckp47gDhEmRcVYKHY6lujNT2CYASD
	IDT48VnVluJU+P008P2jcGmyc6zDU9Zx4wHUulWm94cGPkRknPZd0elNpG6Krfp4
	oZd6nUkDvtn4o8RFTpbe/v5u5B9cyhXKW2PWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CdO6RNqtQ6SZzn63c+3gXxN48nH7kwBz
	PWeBtqdPTPVH+klr5yoVPOvgFEQVAAIspbzjn05564its0/lRBlggku/UKrHoDWK
	gliz7iqis8RMfN3sHHrFTReQPE6XDwGduITUD2HSCUqZnhG0HeUQ74Jg791MxrTV
	v6eVGzO0mj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 465E44C12;
	Mon, 28 Feb 2011 13:12:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BDD5D4C0C; Mon, 28 Feb 2011
 13:12:38 -0500 (EST)
In-Reply-To: <20110228122335.GB5197@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 28 Feb 2011 07\:23\:35 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56C2D198-4366-11E0-AE26-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168128>

Jeff King <peff@peff.net> writes:

> Actually, thinking on this a bit more, I guess "-M" and "-C" are usable
> without the sha1. In fact, we don't even provide it for a strict 100%
> rename, and for a rename-with-patch, you can apply the patch, assuming
> you have the original file in any form.

Yes, you got it correctly.  A patch is about giving you an ability to
propagate a change to a similar tree, that does not have to be identical
to yours (otherwise you can just send tarball of the whole thing ;-)).

And a patch is not purely technical; it has human component in that the
recipient needs to know enough about the context of the patch to be able
to judge if the change is applicable to his tree.  By seeing some context
lines in -M/-C (many of them are not pure renames), the recipient can be
sure that the patch is being applied to his tree that is "similar enough"
to what the patch was originally produced against.  It would certainly
help to have git-apply that understands the rename patches to apply such a
patch mechanically, but that is not a strict requirement; the recipient
can move or copy the original file to manually create the target and apply
the patch by hand to produce the desired result, so "do you have git?" is
mostly irrelevant.

The proposed -D would apply to any tree that happens to have the path
being mentioned in the patch regardless of how similar the target tree is
to the original.  Pure renaming -M/-C patch shares the same risk, but
unlike these modes, -D goes one step too far by making it impossible to
recover from lossage without having a backup.

But all of the above is only about principles.  As I said, I am not
strongly opposed to have an output mode that is primarily for reviewing,
just like we have --color-words, that are not suitable for patch
application, as long as users understand the implications.

It may make sense to show such a patch still with a bit of context,
perhaps like this:

     README |   54 ------------------------------------------------------
     1 files changed, 0 insertions(+), 54 deletions(-)

    diff --git -D a/README b/README
    deleted file mode 100644
    index 67cfeb2..0000000
    --- a/README
    +++ /dev/null
    @@ -1,54 +0,0 @@
    -////////////////////////////////////////////////////////////////
    -
    -	GIT - the stupid content tracker
    -...
    -the discussion following them on the mailing list give a good
    -reference for project status, development direction and
    -remaining tasks.

so that the reader can have some warm and fuzzy feeling that the correct
file is being deleted, though.
