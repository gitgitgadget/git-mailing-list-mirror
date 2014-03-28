From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Thu, 27 Mar 2014 23:43:47 -0400
Message-ID: <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com>
References: <20140328030556.GD25485@odin.tremily.us>
	<c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTNhw-0000Zo-FT
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336AbaC1Dns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 23:43:48 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:63704 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056AbaC1Dnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 23:43:47 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so3258191ykp.29
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 20:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nqZHhMEcVknstpvN26Od12IX+W/7SIM3YTWlg0QoNb8=;
        b=SZwS0gR3ZmuW3QQgDAm1e7o81DcCCWjgnpyVSGn1K1fb+duNjKyl+SVyGFsc2IRw2v
         eXVJuy1jyIxflm5MwXaA2VNr05rTO6Wa8Uh2R/3pOFI3u2TIQzseQVJzjOPyt1WBr/dm
         zsPInJcVCA+E2xVrKUyvzaaQZsCisohV4NklT2ZuOrOu7rxNSmRTw9kSbDsgLrW/XN4+
         N76OA0D9of+6J9062XFciiCYSex9zF+NJoPvAW2ltkDXHYYR8iuHxk7XtR6/WMDuVk//
         xABCZhI9cQuXc4uwTJgm7+UwOItztbgXNCu2EWYPvdrJTBA2pqXHb6XZaeNA8OfqLWh1
         UilQ==
X-Received: by 10.236.191.67 with SMTP id f43mr7680687yhn.60.1395978227334;
 Thu, 27 Mar 2014 20:43:47 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 20:43:47 -0700 (PDT)
In-Reply-To: <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
X-Google-Sender-Auth: RkJ2sRVVyHeRNCtj5C9F1cBKULE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245358>

On Thu, Mar 27, 2014 at 11:36 PM, W. Trevor King <wking@tremily.us> wrote:
> gitmodule(5) mentioned 'master' as the default remote branch, but
> folks using checkout-style updates are unlikely to care which upstream
> branch their commit comes from (they only care that the clone fetches
> that commit).  If they haven't set submodule.<name>.branch, it makes
> more sense to mirror 'git clone' and use the subproject's HEAD than to
> default to 'master' (which may not even exist).
>
> After the initial clone, subsequent updates may be local or remote.
> Local updates (integrating gitlink changes) have no need to fetch a
> specific remote branch, and get along just fine without
> submodule.<name>.branch.  Remote updates do need a remote branch, but
> HEAD works as well here as it did for the initial clone.
>
> Reported-by: Johan Herland <johan@herland.net>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 46c1eeb..c485a17 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -284,7 +284,7 @@ OPTIONS
>         the superproject's recorded SHA-1 to update the submodule, use the
>         status of the submodule's remote-tracking branch.  The remote used
>         is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
> -       The remote branch used defaults to `master`, but the branch name may
> +       The remote branch used defaults to `HEAD`, but the branch name may
>         be overridden by setting the `submodule.<name>.branch` option in
>         either `.gitmodules` or `.git/config` (with `.git/config` taking
>         precedence).
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index f539e3f..1aecce9 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -53,8 +53,9 @@ submodule.<name>.update::
>
>  submodule.<name>.branch::
>         A remote branch name for tracking updates in the upstream submodule.
> -       If the option is not specified, it defaults to 'master'.  See the
> -       `--remote` documentation in linkgit:git-submodule[1] for details.
> +       If the option is not specified, it defaults to the subproject's

Did you mean s/subproject/submodule/ ?

> +       HEAD.  See the `--remote` documentation in linkgit:git-submodule[1]
> +       for details.
>  +
>  This branch name is also used for the local branch created by
>  non-checkout cloning updates.  See the `update` documentation in
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 6135cfa..5f08e6c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -819,8 +819,8 @@ cmd_update()
>                 name=$(module_name "$sm_path") || exit
>                 url=$(git config submodule."$name".url)
>                 config_branch=$(get_submodule_config "$name" branch)
> -               branch="${config_branch:-master}"
> -               local_branch="$branch"
> +               branch="${config_branch:-HEAD}"
> +               local_branch="$config_branch"
>                 if ! test -z "$update"
>                 then
>                         update_module=$update
> @@ -860,7 +860,12 @@ Maybe you want to use 'update --init'?")"
>
>                 if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>                 then
> -                       start_point="origin/${branch}"
> +                       if test -n "$config_branch"
> +                       then
> +                               start_point="origin/$branch"
> +                       else
> +                               start_point=""
> +                       fi
>                         module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$start_point" "$local_branch" || exit
>                         cloned_modules="$cloned_modules;$name"
>                         subsha1=
> --
> 1.9.1.352.gd393d14.dirty
