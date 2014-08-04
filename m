From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Mon, 04 Aug 2014 09:58:44 -0700
Message-ID: <xmqq38dctcmz.fsf@gitster.dls.corp.google.com>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
	<1406994383-5076-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:59:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XELb9-00066W-L7
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 18:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbaHDQ64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 12:58:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56474 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbaHDQ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 12:58:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D7A52E1FB;
	Mon,  4 Aug 2014 12:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ques2OAbQH74wcE+QJ/xKG4mBcI=; b=DmgJn8
	Xh82Mx4wYmtpB3FcuaYhMtIuEqhhMZDWzVNEMY0nwRVoxFJLjwwUUTVyJbMOsfzv
	+yOStjnoFEE9MYH8QDiYUXwwmgNP4uWuMNA/NiG2OxT29Y5mrkJPWd2CLngHnhKw
	aiQsV6jO9DVAm/eQvMdAR/BduXWlbogqkgQn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=se8kvG1eOuvpD+1NCD5PMNGdDBEKeGi6
	wH1Cj6SRGvIeujQIsHgo3kfNYrpCSThdQn21LVM6dcijZ5knHVmeRfwlz0+NGDBd
	W7E89ZxtUn2ekAmFTOfDccLNpA9kiHpfuw9zqYYmb0V2bsB99qnE0/63FrzD3oiu
	DGrhdnIN36k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02CF42E1FA;
	Mon,  4 Aug 2014 12:58:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9758D2E1E8;
	Mon,  4 Aug 2014 12:58:45 -0400 (EDT)
In-Reply-To: <1406994383-5076-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sat, 2 Aug 2014 16:46:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98BCA736-1BF8-11E4-BBEF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254745>

Philip Oakley <philipoakley@iee.org> writes:

> Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch used
> 'origin' as the upstream branch name. That name is now used as the nominal
> name for the upstream remote.
>
> While 'origin' would be DWIMmed (do what I mean) to be that remote's
> primary branch, do not assume the reader is ready for such magic.

Good thinking.

> Likewise, do not use 'origin/master' which may not be up to date with the
> remote, nor reflect the reader's master branch. The patch series should be
> relative to the reader's view of 'git show-branch HEAD master'.

This however is backwards, no?  The history on 'origin/master' may
not be up-to-date in the sense that if you run 'git fetch' you might
get more, but it absolutely is up-to-date in the sense that it shows
what the origin has to the best of your repository's current
knowledge.

Compared to that, what the user's local 'master' has is much less
relevant.  For one thing, if a more recent commit that is on the
remote repository is missing on 'origin/master' because you haven't
fetched recently, by definition that commit will not be on your
'master' either, so you have the same staleness issue to the exact
degree.  Even worse, when you are developing a topic to upstream, it
is a good practice to merge your topic to your own 'master' to check
it with the wider project codebase that is more recent than where
your topic earlier forked from, and it makes little sense to tell
'exclude what I have on my master' to format-patch when extracting
changes to upstream out of such a topic.  You send what the other
side has, not what you do not have on your local 'master' branch.

> Use the more modern 'master' as the reference branch name.

There is nothing 'modern' in 'master'.

I think the original description was written before we switched to
the separate remote layout.  What is in 'refs/remote/origin/master'
these days was stored and updated at 'refs/heads/origin' and no
other branch from the remote repository was tracked back then.  The
changes to be upstreamed are output by grabbing what are not in
'origin', whose modern equivalent is 'origin/master'.

In short, if your patch were s|origin|origin/master|, instead of
s|origin|master|, that would be an adjustment to the more modern
world that is still faithful to the intent of the original.

> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/git-format-patch.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index c0fd470..b0f041f 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -523,25 +523,25 @@ $ git format-patch -k --stdout R1..R2 | git am -3 -k
>  ------------
>  
>  * Extract all commits which are in the current branch but not in the
> -origin branch:
> +master branch:
>  +
>  ------------
> -$ git format-patch origin
> +$ git format-patch master
>  ------------
>  +
>  For each commit a separate file is created in the current directory.
>  
> -* Extract all commits that lead to 'origin' since the inception of the
> +* Extract all commits that lead to 'master' since the inception of the
>  project:
>  +
>  ------------
> -$ git format-patch --root origin
> +$ git format-patch --root master
>  ------------
>  
>  * The same as the previous one:
>  +
>  ------------
> -$ git format-patch -M -B origin
> +$ git format-patch -M -B master
>  ------------
>  +
>  Additionally, it detects and handles renames and complete rewrites
