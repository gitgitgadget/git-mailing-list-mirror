From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/9] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Sun, 17 Feb 2013 18:23:11 -0800
Message-ID: <7v621qe4xc.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <31c45d95acaf062428f171c33c4c164d80b4becb.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7GOQ-0004gP-PT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab3BRCXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:23:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456Ab3BRCXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:23:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D958B0F8;
	Sun, 17 Feb 2013 21:23:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T+9hmPBFTbBHr3jEwvY3Kz0ReB0=; b=SjhR26
	GLckTQ2UeKJGp4H22KZQ3J0wFVrUAd2OiKlp3XxvCKy6YoR5FbmC30aWfF5NXHES
	mLDHlLTpprCGYvgQhecBD5AvOVIx95T/wTguRTJ+6oFzI8Hs9QcMDjncHZSJkr6t
	er+qMU6JGD+d1SzwXMdSttqnEA7eu+lGeS3bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wuBxCoyqk14472BMtC1jF4rB8h2HOGfF
	17XzKpx4amTQ56FM/7AvsGEdUpT4fe/qjsF5nBio/lcku7XaNgU44Inhp9Dmw86z
	LFJDRfrgauivR2hQniqidfKKtEJ4r9Ez8FZzFjocfbUUaQ7HdwHGGeawb4iY9RCN
	3tiMpcTkiZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21D81B0F7;
	Sun, 17 Feb 2013 21:23:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 500A2B0E6; Sun, 17 Feb 2013
 21:23:13 -0500 (EST)
In-Reply-To: <31c45d95acaf062428f171c33c4c164d80b4becb.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:15:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2549D3D4-7972-11E2-8E3D-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216429>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> I think this interface is often more convenient than extended cherry
> picking or using 'git format-patch'.  In fact, I removed the
> cherry-pick section entirely.  The entry-level suggestions for
> rerolling are now:
>
> 1. git commit --amend
> 2. git format-patch origin
>    git reset --hard origin
>    ...edit and reorder patches...
>    git am *.patch
> 3. git rebase -i origin
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 110 ++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 47 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index a060eb6..dbffd0a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2538,6 +2538,12 @@ return mywork to the state it had before you started the rebase:
>  $ git rebase --abort
>  -------------------------------------------------
>  
> +If you need to reorder or edit a number of commits in a branch, it may
> +be easier to use `git rebase -i`, which allows you to reorder and
> +squash commits, as well as marking them for individual editing during
> +the rebase.  See <<interactive-rebase>> for details, and
> +<<reordering-patch-series>> for alternatives.
> +
>  [[rewriting-one-commit]]
>  Rewriting a single commit
>  -------------------------
> @@ -2552,71 +2558,81 @@ $ git commit --amend
>  which will replace the old commit by a new commit incorporating your
>  changes, giving you a chance to edit the old commit message first.
>  

... A lot of lines removed here ...

> +[[reordering-patch-series]]

This change makes the [[rewriting-one-commit]] section say "We
already saw you can do 'commit --amend'" and nothing else.  It makes
me wonder if the remaining section is worth keeping if we go this
route.


> +[[reordering-patch-series]]
> +Reordering or selecting from a patch series
> +-------------------------------------------
>  
> +Sometimes you want to edit a commit deeper in your history.  One
> +approach is to use `git format-patch` to create a series of patches,
> +then reset the state to before the patches:
>  
>  -------------------------------------------------
> +$ git format-patch origin
> +$ git reset --hard origin
>  -------------------------------------------------
>  
> +Then modify, reorder, or eliminate patches as preferred before applying
> +them again with linkgit:git-am[1]:
>  
>  -------------------------------------------------
> +$ git am *.patch
>  -------------------------------------------------

It may be just me, but s/preferred/needed/, perhaps?

> +This will open your editor with a list of the commits you're rebasing
>  
>  -------------------------------------------------
> +pick deadbee The oneline of this commit
> +pick fa1afe1 The oneline of the next commit
> +...
>  
> +# Rebase c0ffeee..deadbee onto c0ffeee
> +#
> +# Commands:
> ...
> +# Note that empty commits are commented out
> +-------------------------------------------------
> +
> +As explained in the comments, you can reorder commits, squash them
> +together, edit commit messages, etc. by editing the list.  Once you
> +are satisfied, save the list and close your editor, and the rebase
> +will begin.
> +
> +The rebase will stop when `pick` has been replaced with `edit` or when
> +a command fails due to merge errors. When you are done editing and/or
> +resolving conflicts...

I am afraid that "due to merge errors" and "resolving conflicts" do
not look corresponding to each other for a new reader.  Also here we
say "when a command fails", but the explanation before this part
never says "list of commands".  Besides, "command" itself is not a
very good word to use as "pick" is not really a "command" (we do not
have "git pick" or "git squash"---that is why I almost always call
this "insn sheet" myself, by the way).

A way to reword the above to reduce possible confusion may be to
start with:

	This will open your editor with a list of steps to be taken
        to perform your rebase.

and then say

	... with `edit` or when a step in the list fails to
	mechanically resolve conflicts and needs your help.  When
	you are done editing ...

or something.
