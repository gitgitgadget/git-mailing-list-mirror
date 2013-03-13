From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool: Make directory diff symlink working tree
Date: Wed, 13 Mar 2013 16:01:34 +0000
Message-ID: <20130313160134.GJ2317@serenity.lan>
References: <CAJELnLEbYrDWUjZH6iWnovEFDh8xFvpJL5wtEcPGOpkhPo+XEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFo85-0000zG-1M
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933124Ab3CMQBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 12:01:46 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51080 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932656Ab3CMQBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:01:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4B950606554;
	Wed, 13 Mar 2013 16:01:45 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8fg+YfWm3D1; Wed, 13 Mar 2013 16:01:44 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 397FF606538;
	Wed, 13 Mar 2013 16:01:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJELnLEbYrDWUjZH6iWnovEFDh8xFvpJL5wtEcPGOpkhPo+XEA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218061>

On Wed, Mar 13, 2013 at 11:21:40AM -0400, Matt McClure wrote:
> On Wed, Mar 13, 2013 at 4:24 AM, David Aguilar <davvid@gmail.com> wrote:
> > This is a nice straightforward approach.
> >
> > As Junio mentioned, a good next step would be this patch
> > in combination with making the truly temporary files
> > created by dir-diff readonly.
> >
> > Will that need a win32 platform check?
> > Does anyone want to take this and whip it into a proper patch?
> 
> An attempt:
> 
> From 429ae282ffd7202b6d2fb024a92dea543b8af376 Mon Sep 17 00:00:00 2001
> From: Matt McClure <matthewlmcclure@gmail.com>
> Date: Wed, 13 Mar 2013 11:14:22 -0400
> Subject: [PATCH] difftool: Make directory diff symlink working tree
> 
> ...primarily so that a user can edit working tree files in his difftool.

Please don't continue the subject like this, look at some recent commits
in git.git to see how commits are normally formatted.

The subject here is also inaccurate since difftool already symlinks the
working tree in some situations.

> difftool -d formerly knew how to symlink to the working tree when the
> work tree contains uncommitted changes. In practice, prior to this
> change, it would not symlink to the working tree in case there were no
> uncommitted changes, even when the user invoked difftool with the form:
> 
>     git difftool -d [--options] <commit> [--] [<path>...]
>         This form is to view the changes you have in your working tree
>         relative to the named <commit>. You can use HEAD to compare it
>         with the latest commit, or a branch name to compare with the tip
>         of a different branch.
> 
> Instead, prior to this change, difftool would use the file's blob SHA1
> to find its content in the index rather than use the working tree
> content. This change teaches `git difftool` to compare the blob SHA1 to
> the file's working tree blob SHA1 and use the working tree file if the
> SHA1s are the same.

You don't need to say things like "formerly..." and "prior to this",
write in the imperative describing how the commit changes things.  A
better commit message might be:

    difftool -d: symlink working tree files matching RHS

    Change the behaviour of git-difftool's directory diff mode so that
    instead of symlinking to working tree files only when they have
    unstaged changes we now symlink to any files where the working tree
    matches the RHS of the diff.

    This helps users who like to edit files in their diff tool and
    expect to have those changes reflected in the working tree.

> Author: John Keeping <john@keeping.me.uk>

The correct way to credit authorship is via a "From: " header at the top
of the message.  In this particular case, I think this change also
requires a documentation update and some test coverage, so it would be
appropriate for whoever adds those to take the credit for the commit and
add a "Based-on-patch-by: John Keeping <john@keeping.me.uk>" footer.

You should also add your own "Signed-off-by:" line.

If no-one else gets there first I'm hoping to have a bit of time to add
the documentation and test case in 4 hours or so.

> Conversation:
> http://thread.gmane.org/gmane.comp.version-control.git/217979/focus=218014

This isn't necessary, just reply to relevant message in that thread and
it will show up correctly in people's mail clients.

> ---
>  git-difftool.perl | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 0a90de4..5f093ae 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -83,6 +83,21 @@ sub exit_cleanup
>  	exit($status | ($status >> 8));
>  }
> 
> +sub use_wt_file
> +{
> +	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
> +	my $null_sha1 = '0' x 40;
> +
> +	if ($sha1 eq $null_sha1) {
> +		return 1;
> +	} elsif (not $symlinks) {
> +		return 0;
> +	}
> +
> +	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> +	return $sha1 eq $wt_sha1;
> +}
> +
>  sub setup_dir_diff
>  {
>  	my ($repo, $workdir, $symlinks) = @_;
> @@ -159,10 +174,10 @@ EOF
>  		}
> 
>  		if ($rmode ne $null_mode) {
> -			if ($rsha1 ne $null_sha1) {
> -				$rindex .= "$rmode $rsha1\t$dst_path\0";
> -			} else {
> +			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
>  				push(@working_tree, $dst_path);
> +			} else {
> +				$rindex .= "$rmode $rsha1\t$dst_path\0";
>  			}
>  		}
>  	}
> -- 
> 1.8.1.5
