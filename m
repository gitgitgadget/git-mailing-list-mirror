From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH] git-svn: support rebase --preserve-merges
Date: Tue, 22 May 2012 13:32:25 -0400
Message-ID: <CAK8d-aLFr3Bk6LU-H8FgR8kKQM9sLvectneZ1QnaHDzg_08P-g@mail.gmail.com>
References: <CAHkK2boS2ffnz+vz1jRqKHy1vQcrcd6FHEdWgY-btHZaCapdkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, avarab@gmail.com,
	git@vger.kernel.org
To: Avishay Lavie <avishay.lavie@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:32:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsx1-0001J8-RK
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab2EVRcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 13:32:47 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46641 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2EVRcq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 13:32:46 -0400
Received: by qcro28 with SMTP id o28so4186109qcr.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QZCLe1eNQYpZIwuaBtnstxCtTcEU7BeVBbL2zdI3L1o=;
        b=gRSGi6yyvjeUHHFm297WxaPDOoypkAyaoqBneNYX/tPHDobWu2Bkrs5pDM9+FzH5/1
         ezsaNGhLghVaMOMXSTcfN0MRXfdGd17Txf35rbNsv1VxJW5DfyVBnLD3AysZVL6puq9W
         00UMCm9Un78oquDMv/qY2Wm9sIUVoSe2wyLQpn+Dxv617th/xWpX19vSG8lt2GlIlEod
         Ks2QTeEOYY/Hdb/Hu+eAQUCwu3WaH9pOeI9lUwezbWTFlmIZBdPyD98qJ9PtCFfD7x/5
         p6JTPxeezzOJETOorWVS6S3dio8of6s2YCqqMjkC3vI6BmLAL8dUJ1OKZE19Q4d4VnId
         4HmA==
Received: by 10.224.105.202 with SMTP id u10mr492681qao.54.1337707965719; Tue,
 22 May 2012 10:32:45 -0700 (PDT)
Received: by 10.224.182.143 with HTTP; Tue, 22 May 2012 10:32:25 -0700 (PDT)
In-Reply-To: <CAHkK2boS2ffnz+vz1jRqKHy1vQcrcd6FHEdWgY-btHZaCapdkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198209>

Signed-Off-By: Steven Walter <stevenrwalter@gmail.com>

On Tue, May 15, 2012 at 8:09 AM, Avishay Lavie <avishay.lavie@gmail.com=
> wrote:
> (Adding previous authors of git-svn.perl)
>
> ---------- Forwarded message ----------
> From: Avishay Lavie <avishay.lavie@gmail.com>
> Date: Tue, May 15, 2012 at 12:09 PM
> Subject: PATCH: git-svn: support rebase --preserve-merges
> To: git@vger.kernel.org
>
>
> From: Avishay Lavie <avishay.lavie@gmail.com>
> Date: Tue, 15 May 2012 11:45:50 +0300
> Subject: [PATCH] git-svn: support rebase --preserve-merges
>
> When git svn rebase is performed after an unpushed merge, the
> rebase operation follows both parents and replays both the user's
> local commits and those from the merged branch. This is usually
> not the intended behavior.
> This patch adds support for the --preserve-merges/-p flag which
> allows for a better workflow by re-applying merge commits as merges.
>
> Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
> ---
> =A0Documentation/git-svn.txt | =A0 =A02 ++
> =A0git-svn.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +++-
> =A02 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 34ee785..0d52997 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -572,6 +572,8 @@ config key: svn.repackflags
> =A0--merge::
> =A0-s<strategy>::
> =A0--strategy=3D<strategy>::
> +-p::
> +--preserve-merges::
> =A0 =A0 =A0 =A0These are only used with the 'dcommit' and 'rebase' co=
mmands.
> =A0+
> =A0Passed directly to 'git rebase' when using 'dcommit' if a
> diff --git a/git-svn.perl b/git-svn.perl
> index ca038ec..e86d60b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -84,7 +84,7 @@ my ($_stdin, $_help, $_edit,
> =A0 =A0 =A0 =A0$_message, $_file, $_branch_dest,
> =A0 =A0 =A0 =A0$_template, $_shared,
> =A0 =A0 =A0 =A0$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
> - =A0 =A0 =A0 $_merge, $_strategy, $_dry_run, $_local,
> + =A0 =A0 =A0 $_merge, $_strategy, $_preserve_merges, $_dry_run, $_lo=
cal,
> =A0 =A0 =A0 =A0$_prefix, $_no_checkout, $_url, $_verbose,
> =A0 =A0 =A0 =A0$_git_format, $_commit_url, $_tag, $_merge_info, $_int=
eractive);
> =A0$Git::SVN::_follow_parent =3D 1;
> @@ -233,6 +233,7 @@ my %cmd =3D (
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'local|l' =3D> \$_=
local,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'fetch-all|all' =3D=
> \$_fetch_all,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'dry-run|n' =3D> \=
$_dry_run,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 'preserve-merges|p'=
 =3D> \$_preserve_merges
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0%fc_opts } ],
> =A0 =A0 =A0 =A0'commit-diff' =3D> [ \&cmd_commit_diff,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 'Commit a diff be=
tween two trees',
> @@ -1570,6 +1571,7 @@ sub rebase_cmd {
> =A0 =A0 =A0 =A0push @cmd, '-v' if $_verbose;
> =A0 =A0 =A0 =A0push @cmd, qw/--merge/ if $_merge;
> =A0 =A0 =A0 =A0push @cmd, "--strategy=3D$_strategy" if $_strategy;
> + =A0 =A0 =A0 push @cmd, "--preserve-merges" if $_preserve_merges;
> =A0 =A0 =A0 =A0@cmd;
> =A0}
>
> --
> 1.7.9.msysgit.0



--=20
-Steven Walter <stevenrwalter@gmail.com>
"The rotter who simpers that he sees no difference between the power
of the dollar and the power of the whip, ought to learn the difference
on his own hide."
=A0 =A0 -Francisco d'Anconia, Atlas Shrugged
