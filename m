From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH v14 8/9] difftool: teach difftool to handle directory diffs
Date: Fri, 20 Apr 2012 13:54:22 -0700
Message-ID: <xmqqipgum8e9.fsf@junio.mtv.corp.google.com>
References: <1334940988-8940-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:54:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKqb-00080t-Ag
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab2DTUyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:54:24 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:59426 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2DTUyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:54:23 -0400
Received: by yhgm50 with SMTP id m50so1146973yhg.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZD30NFYd6CHMsuVI6WB73/BOe8XnQzkP0RwfDZKM5Go=;
        b=QXoL8zjuDIJb4zAkqTa69S/VXoyrfb71xCmZHaEtTSjbLngDFcF++fp0uBmboP2u4H
         wrInUGMG3d5zTOOEckcOuKBBFlTXpaoE4pF+JPcQX+MLgjYIewMfJkkW1gxcb9OkarI2
         zJukhybMdx6oW1wxrdz3BkpQboRvVMZpK/bWIJMMh1IukZAO1el230qh17FXLv5cvKci
         S06NYRab+rUrmBiR8dQEN3wjV35LQe9bXZ6cB1uCDDPfp47Q2Rk5XZkUNaXD5cHcblny
         U533VBdGIKIvknn29ZgPV4zjtgmiSn9NLxHFTDKz7nZ/anF6hTs8dcya+YcKcB0oT0dq
         uMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=ZD30NFYd6CHMsuVI6WB73/BOe8XnQzkP0RwfDZKM5Go=;
        b=fz9m8VjdQ05Jsas3qTZsKksz1x+TJ+B+Z52ujAasX95rG2hzgv0hw9M1QuxFSE9D38
         wkzUF1QE6yqcBM0vM3AYcuBE2WJSczliMrhtcuuOpqoALW9+AfhiEVj7cpiSDqsBaRKL
         xJaYykSFFtyryCfrorfGUDpDs/N8S0gJwPhB4HygzVtlLXdft7mW9AimbUwU/Tf3bRwK
         /kX3C9iBkVo+6SFQ/V8y18tk+HPkn0DBKZTR7d6exYsECyYrCp5KmaKR5wuIGhvJMspC
         TZ6Oh2NCltxCR/AVWvWY6fO6gN59u0KxhMy8tfv9m2oh+J3D7+aJG3BGPOSo0BAXSV3A
         Nw9w==
Received: by 10.236.125.170 with SMTP id z30mr9004609yhh.4.1334955262971;
        Fri, 20 Apr 2012 13:54:22 -0700 (PDT)
Received: by 10.236.125.170 with SMTP id z30mr9004583yhh.4.1334955262873;
        Fri, 20 Apr 2012 13:54:22 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i36si1095827anp.0.2012.04.20.13.54.22
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 13:54:22 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id AF76D1E0119;
	Fri, 20 Apr 2012 13:54:22 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 42BA4E120A; Fri, 20 Apr 2012 13:54:22 -0700 (PDT)
In-Reply-To: <1334940988-8940-1-git-send-email-tim.henigan@gmail.com> (Tim
	Henigan's message of "Fri, 20 Apr 2012 12:56:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn4kkLUQF2imO/KVSRl5PXjp2vl85t+Ez6g+FQaCE0qkGch+yWoFIcJ0eGoSA/8OvOuYeYhiuOZ+OkbLUmLxytP6zmGuvf528BrIDySKW6PsEWkg6KkLDndNVycXMB/aDM8+AxEOZtKPvEgpsKtJSXVqumJBJrU2lzWMA8ALCkCeYl9sY0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196024>

Tim Henigan <tim.henigan@gmail.com> writes:

> When 'difftool' is called to compare a range of commits that modify
> more than one file, it opens a separate instance of the diff tool for
> each file that changed.
>
> The new '--dir-diff' option copies all the modified files to a temporary
> location and runs a directory diff on them in a single instance of the
> diff tool.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
> This replaces 7fbdc6c on the th/difftool-diffall branch [1].
>
> Changes in v14:
>
>   - Fixed use of unitialized vars in the find_worktree function. A warning
>     was seen when run on msysgit, but not other platforms.
>
>   - Added a helper function (write_to_file) to replace repeated logic.
>
>   - Fixed handling of symbolic links. The diff shown in the external tool
>     now matches what is seen in the output of 'git diff'.
>
>   - Added support for the diff format used for renames and copies. In the
>     external tool, these will still appear as delete/add pairs.
>
>   - Added logic to detect and abort if a combined diff ('--cc' or '-c')
>     is commanded at the same time as directory diff ('--dir-diff').
>
> [1]: https://github.com/gitster/git/tree/th/difftool-diffall
>
>
>  Documentation/git-difftool.txt |    6 +
>  git-difftool--helper.sh        |   19 ++-
>  git-difftool.perl              |  261 +++++++++++++++++++++++++++++++++++++---
>  t/t7800-difftool.sh            |   39 ++++++
>  4 files changed, 299 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index fe38f66..aba5e76 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -19,6 +19,12 @@ linkgit:git-diff[1].
>  
>  OPTIONS
>  -------
> +-d::
> +--dir-diff::
> +	Copy the modified files to a temporary location and perform
> +	a directory diff on them. This mode never prompts before
> +	launching the diff tool.
> +
>  -y::
>  --no-prompt::
>  	Do not prompt before launching a diff tool.
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index e6558d1..3d0fe0c 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -73,9 +73,16 @@ then
>  	fi
>  fi
>  
> -# Launch the merge tool on each path provided by 'git diff'
> -while test $# -gt 6
> -do
> -	launch_merge_tool "$1" "$2" "$5"
> -	shift 7
> -done
> +if test -n "$GIT_DIFFTOOL_DIRDIFF"
> +then
> +	LOCAL="$1"
> +	REMOTE="$2"
> +	run_merge_tool "$merge_tool" false
> +else
> +	# Launch the merge tool on each path provided by 'git diff'
> +	while test $# -gt 6
> +	do
> +		launch_merge_tool "$1" "$2" "$5"
> +		shift 7
> +	done
> +fi
> diff --git a/git-difftool.perl b/git-difftool.perl
> index aba3d2f..7211f1e 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -1,21 +1,31 @@
> -#!/usr/bin/env perl
> +#!/usr/bin/perl
>  # Copyright (c) 2009, 2010 David Aguilar
> +# Copyright (c) 2012 Tim Henigan
>  #
>  # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
>  # git-difftool--helper script.
>  #
>  # This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
> -# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, and GIT_DIFF_TOOL
> -# are exported for use by git-difftool--helper.
> +# The GIT_DIFF* variables are exported for use by git-difftool--helper.
>  #
>  # Any arguments that are unknown to this script are forwarded to 'git diff'.
>  
>  use 5.008;
>  use strict;
>  use warnings;
> +use File::Basename qw(dirname);
> +use File::Copy;
> +use File::stat;
> +use File::Path qw(mkpath);
> +use File::Temp qw(tempdir);
>  use Getopt::Long qw(:config pass_through);
>  use Git;
>  
> +my @working_tree;
> +my $rc;
> +my $repo = Git->repository();
> +my $repo_path = $repo->repo_path();
> +
>  sub usage
>  {
>  	my $exitcode = shift;
> @@ -24,15 +34,202 @@ usage: git difftool [-t|--tool=<tool>]
>                      [-x|--extcmd=<cmd>]
>                      [-g|--gui] [--no-gui]
>                      [--prompt] [-y|--no-prompt]
> +                    [-d|--dir-diff]
>                      ['git diff' options]
>  USAGE
>  	exit($exitcode);
>  }
>  
> +sub find_worktree
> +{
> +	# Git->repository->wc_path() does not honor changes to the working
> +	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
> +	# config variable.
> +	my $worktree;
> +	my $env_worktree = $ENV{GIT_WORK_TREE};
> +	my $core_worktree = Git::config('core.worktree');
> +
> +	if (defined($env_worktree) and (length($env_worktree) > 0)) {
> +		$worktree = $env_worktree;
> +	} elsif (defined($core_worktree) and (length($core_worktree) > 0)) {
> +		$worktree = $core_worktree;
> +	} else {
> +		$worktree = $repo->wc_path();
> +	}
> +
> +	return $worktree;
> +}
> +
> +my $workdir = find_worktree();
> +
> +sub setup_dir_diff
> +{
> +	# Run the diff; exit immediately if no diff found
> +	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
> +	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
> +	# by Git->repository->command*.
> +	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
> +	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
> +	exit(0) if (length($diffrtn) == 0);
> +
> +	if ($diffrtn =~ /::/) {
> +		print "Combined diff formats ('-c' and '--cc') are not supported in directory diff mode.\n";

Can't a pathname happen to have these two-letter sequence?  /^::/ perhaps?
Also what does "command_oneline()" return, when there is a file with LF
in their pathname?

> +		exit(1);
> +	}
> +
> +	# Setup temp directories
> +	my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
> +	my $ldir = "$tmpdir/left";
> +	my $rdir = "$tmpdir/right";
> +	mkpath($ldir) or die $!;
> +	mkpath($rdir) or die $!;
> +
> +	# Build index info for left and right sides of the diff
> +	my $submodule_mode = "160000";
> +	my $symlink_mode = "120000";
> +	my $null_mode = "0" x 6;
> +	my $null_sha1 = "0" x 40;
> +	my $lindex = "";
> +	my $rindex = "";
> +	my %submodule;
> +	my %symlink;
> +	my @rawdiff = split(':', $diffrtn);
> +	for (my $i=1; $i<@rawdiff; $i++) {

Huh?  Can't a pathname happen to have ':' in it?  This really is not the
way to parse --raw -z format.  Cut them into tokens at '\0' boundary
first, and decide how many paths there are when interpreting the status
field, to collect one record worth of NUL-delimited tokens, and then
process.
