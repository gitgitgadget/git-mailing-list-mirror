From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v7 2/3] submodule update: add --remote for submodule's
 upstream changes
Date: Wed, 12 Dec 2012 12:43:23 -0500
Message-ID: <CABURp0oLmSjiZAOJxEzwSmL+jimpVj8DcDi-odPTzCpCcyH8yA@mail.gmail.com>
References: <20121204001717.GA17375@odin.tremily.us> <cover.1355251862.git.wking@tremily.us>
 <64d109da03c521303ad87b8370bf09ab28a5c09f.1355251862.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:44:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqLk-0002Zx-9N
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab2LLRnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 12:43:46 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56867 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab2LLRnp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 12:43:45 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so663704eek.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8u96pSdyWqfendNHp02Y/xJUGkDWXGBZrUgkgW3O+qA=;
        b=AkwbsLsNw07KetwM/uoNmuINh4dTHIF19/sLKyIcWWGIAVzFwkZ49nUxxuPPcs8DFw
         ATREv+/uVo4NJf12hBsaRN6bFDCkJ6Mzc1XpLIdxcDnTNDgJUlvr8Quw4rAw80tB5BE5
         5P4TPfc/i7iZWHYPDxdTfCF3t81KMbxxMYSz2fWS8mjSoNVk9rVo7PBV1Ja2ROrT75RL
         7a/ZFsz/jhkX0zMgdOgpdj2DfslvTKfT9fAMCX7INsU99reCJTQ1Ga6ztt4HXpG0V8XQ
         cKbceZJaeHK1qdii1mgVYLiglpPtjA+WW5tfGGaXAaAi5TA4M0kvD5eT45bh1wxlNgFG
         ZAfQ==
Received: by 10.14.194.195 with SMTP id m43mr4663676een.44.1355334223987; Wed,
 12 Dec 2012 09:43:43 -0800 (PST)
Received: by 10.223.195.135 with HTTP; Wed, 12 Dec 2012 09:43:23 -0800 (PST)
In-Reply-To: <64d109da03c521303ad87b8370bf09ab28a5c09f.1355251862.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211371>

Thanks for looking after this.


On Tue, Dec 11, 2012 at 1:58 PM, W. Trevor King <wking@tremily.us> wrot=
e:
> From: "W. Trevor King" <wking@tremily.us>
>
> The current `update` command incorporates the superproject's gitlinke=
d
> SHA-1 ($sha1) into the submodule HEAD ($subsha1).  Depending on the
> options you use, it may checkout $sha1, rebase the $subsha1 onto
> $sha1, or merge $sha1 into $subsha1.  This helps you keep up with
> changes in the upstream superproject.
>
> However, it's also useful to stay up to date with changes in the
> upstream subproject.  Previous workflows for incorporating such
> changes include the ungainly:
>
>   $ git submodule foreach 'git checkout $(git config --file $toplevel=
/.gitmodules submodule.$name.branch) && git pull'
>
> With this patch, all of the useful functionality for incorporating
> superproject changes can be reused to incorporate upstream subproject
> updates.  When you specify --remote, the target $sha1 is replaced wit=
h
> a $sha1 of the submodule's origin/master tracking branch.  If you wan=
t
> to merge a different tracking branch, you can configure the
> `submodule.<name>.branch` option in `.gitmodules`.  You can override
> the `.gitmodules` configuration setting for a particular superproject
> by configuring the option in that superproject's default configuratio=
n
> (using the usual configuration hierarchy, e.g. `.git/config`,
> `~/.gitconfig`, etc.).
>
> Previous use of submodule.<name>.branch
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Because we're adding a new configuration option, it's a good idea to
> check if anyone else is already using the option.  The foreach-pull
> example above was described by =C6var in
>
>   commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
>   Author: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
>   Date:   Fri May 21 16:10:10 2010 +0000
>
>     git-submodule foreach: Add $toplevel variable
>
> Gerrit uses the same interpretation for the setting, but because
> Gerrit has direct access to the subproject repositories, it updates
> the superproject repositories automatically when a subproject changes=
=2E
> Gerrit also accepts the special value '.', which it expands into the
> superproject's branch name.
>
> Although the --remote functionality is using `submodule.<name>.branch=
`
> slightly differently, the effect is the same.  The foreach-pull
> example uses the option to record the name of the local branch to
> checkout before pulls.  The tracking branch to be pulled is recorded
> in `.git/modules/<name>/config`, which was initialized by the module
> clone during `submodule add` or `submodule init`.  Because the branch
> name stored in `submodule.<name>.branch` was likely the same as the
> branch name used during the initial `submodule add`, the same branch
> will be pulled in each workflow.
>
> Implementation details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In order to ensure a current tracking branch state, `update --remote`
> fetches the submodule's remote repository before calculating the
> SHA-1.  However, I didn't change the logic guarding the existing fetc=
h:
>
>   if test -z "$nofetch"
>   then
>     # Run fetch only if $sha1 isn't present or it
>     # is not reachable from a ref.
>     (clear_local_git_env; cd "$path" &&
>       ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>        test -z "$rev") || git-fetch)) ||
>     die "$(eval_gettext "Unable to fetch in submodule path '\$path'")=
"
>   fi
>
> There will not be a double-fetch, because the new $sha1 determined
> after the `--remote` triggered fetch should always exist in the
> repository.  If it doesn't, it's because some racy process removed it
> from the submodule's repository and we *should* be re-fetching.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/config.txt        |  7 ++++++-
>  Documentation/git-submodule.txt | 25 ++++++++++++++++++++++++-
>  Documentation/gitmodules.txt    |  5 +++++
>  git-submodule.sh                | 22 +++++++++++++++++++++-
>  t/t7406-submodule-update.sh     | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 11f320b..6f4663c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1998,7 +1998,12 @@ submodule.<name>.update::
>         for a submodule.  These variables are initially populated
>         by 'git submodule init'; edit them to override the
>         URL and other values found in the `.gitmodules` file.  See
> -       linkgit:git-submodule[1] and linkgit:gitmodules[5] for detail=
s.
> +
> +submodule.<name>.branch::
> +       The remote branch name for a submodule, used by `git submodul=
e
> +       update --remote`.  Set this option to override the value foun=
d in
> +       the `.gitmodules` file.  See linkgit:git-submodule[1] and
> +       linkgit:gitmodules[5] for details.
>
>  submodule.<name>.fetchRecurseSubmodules::
>         This option can be used to control recursive fetching of this
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-subm=
odule.txt
> index b4683bb..72dd52f 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>               [--reference <repository>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> +'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]=
 [--rebase]
>               [--reference <repository>] [--merge] [--recursive] [--]=
 [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-=
limit) <n>]
>               [commit] [--] [<path>...]
> @@ -236,6 +236,29 @@ OPTIONS
>         (the default). This limit only applies to modified submodules=
=2E The
>         size is always limited to 1 for added/deleted/typechanged sub=
modules.
>
> +--remote::
> +       This option is only valid for the update command.  Instead of=
 using
> +       the superproject's recorded SHA-1 to update the submodule, us=
e the
> +       status of the submodule's remote tracking branch.  The remote=
 used
> +       is branch's remote (`branch.<name>.remote`), defaulting to `o=
rigin`.
> +       The remote branch used defaults to `master`, but the branch n=
ame may
> +       be overridden by setting the `submodule.<name>.branch` option=
 in
> +       either `.gitmodules` or `.git/config` (with `.git/config` tak=
ing
> +       precedence).
> ++
> +This works for any of the supported update procedures (`--checkout`,
> +`--rebase`, etc.).  The only change is the source of the target SHA-=
1.
> +For example, `submodule update --remote --merge` will merge upstream
> +submodule changes into the submodules, while `submodule update
> +--merge` will merge superproject gitlink changes into the submodules=
=2E
> ++
> +In order to ensure a current tracking branch state, `update --remote=
`
> +fetches the submodule's remote repository before calculating the
> +SHA-1.  This makes `submodule update --remote --merge` similar to
> +running `git pull` in the submodule.  If you don't want to fetch (fo=
r
> +something closer to `git merge`), you should use `submodule update
> +--remote --no-fetch --merge`.

I assume the same can be said for 'submodue update --remote --rebase',
right?  I wonder if this can be made merge/rebase-agnostic.  Is it
still true if I word it like this?:

   In order to ensure a current tracking branch state, `update --remote=
`
   fetches the submodule's remote repository before calculating the
   SHA-1.  If you don't want to fetch, you should use `submodule update
    --remote --no-fetch`.


> +
>  -N::
>  --no-fetch::
>         This option is only valid for the update command.
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.=
txt
> index 4effd78..4004fa6 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -47,6 +47,11 @@ submodule.<name>.update::
>         This config option is overridden if 'git submodule update' is=
 given
>         the '--merge', '--rebase' or '--checkout' options.
>
> +submodule.<name>.branch::
> +       A remote branch name for tracking updates in the upstream sub=
module.
> +       If the option is not specified, it defaults to 'master'.  See=
 the
> +       `--remote` documentation in linkgit:git-submodule[1] for deta=
ils.
> +
>  submodule.<name>.fetchRecurseSubmodules::
>         This option can be used to control recursive fetching of this
>         submodule. If this option is also present in the submodules e=
ntry in
> diff --git a/git-submodule.sh b/git-submodule.sh
> index f969f28..1395079 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,7 +8,8 @@ dashless=3D$(basename "$0" | sed -e 's/-/ /')
>  USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposi=
tory>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<pa=
th>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--for=
ce] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] =
[<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch=
] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recur=
sive] [--] [<path>...]
> +ges

I think there's an unintentionally added line here with "ges".

>     or: $dashless [--quiet] summary [--cached|--files] [--summary-lim=
it <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--] [<path>...]"
> @@ -26,6 +27,7 @@ cached=3D
>  recursive=3D
>  init=3D
>  files=3D
> +remote=3D
>  nofetch=3D
>  update=3D
>  prefix=3D
> @@ -535,6 +537,9 @@ cmd_update()
>                 -i|--init)
>                         init=3D1
>                         ;;
> +               --remote)
> +                       remote=3D1
> +                       ;;
>                 -N|--no-fetch)
>                         nofetch=3D1
>                         ;;
> @@ -595,6 +600,7 @@ cmd_update()
>                 fi
>                 name=3D$(module_name "$sm_path") || exit
>                 url=3D$(git config submodule."$name".url)
> +               branch=3D$(get_submodule_config "$name" branch master=
)
>                 if ! test -z "$update"
>                 then
>                         update_module=3D$update
> @@ -629,6 +635,20 @@ Maybe you want to use 'update --init'?")"
>                         die "$(eval_gettext "Unable to find current r=
evision in submodule path '\$sm_path'")"
>                 fi
>
> +               if test -n "$remote"
> +               then
> +                       if test -z "$nofetch"
> +                       then
> +                               # Fetch remote before determining tra=
cking $sha1
> +                               (clear_local_git_env; cd "$sm_path" &=
& git-fetch) ||

You should 'git fetch $remote_name' here, and of course, initialize
remote_name before this.  But how can we know the remote_name in the
first place?  Is it safe to assume the submodule remote names will
match those in the superproject?

> +                               die "$(eval_gettext "Unable to fetch =
in submodule path '\$sm_path'")"
> +                       fi
> +                       remote_name=3D$(get_default_remote)

This get_default_remote finds the remote for the remote-tracking
branch for HEAD in the superproject.  It is possible that HEAD !=3D
$branch, so we have very few clues to go on here to get a more
reasonable answer, so I do not have any good suggestions to improve
this.

One option would be to find the remote given for
submodule."$branch".merge, but this would suppose there is some
remote-tracking branch configured in the submodule, and that is not
likely to be the case.

> +                       sha1=3D$(clear_local_git_env; cd "$sm_path" &=
&
> +                               git rev-parse --verify "${remote_name=
}/${branch}") ||

This does assume the submodule remote names will match those in the
superproject.  Is this safe?

> +                       die "$(eval_gettext "Unable to find current $=
{remote_name}/${branch} revision in submodule path '\$sm_path'")"
> +               fi
> +
>                 if test "$subsha1" !=3D "$sha1" -o -n "$force"
>                 then
>                         subforce=3D$force
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.s=
h
> index 1542653..a567834 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -135,6 +135,37 @@ test_expect_success 'submodule update --force fo=
rcibly checks out submodules' '
>         )
>  '
>
> +test_expect_success 'submodule update --remote should fetch upstream=
 changes' '
> +       (cd submodule &&
> +        echo line4 >> file &&
> +        git add file &&
> +        test_tick &&
> +        git commit -m "upstream line4"
> +       ) &&
> +       (cd super &&
> +        git submodule update --remote --force submodule &&
> +        cd submodule &&
> +        test "$(git log -1 --oneline)" =3D "$(GIT_DIR=3D../../submod=
ule/.git git log -1 --oneline)"
> +       )
> +'
> +
> +test_expect_success 'local config should override .gitmodules branch=
' '
> +       (cd submodule &&
> +        git checkout -b test-branch &&
> +        echo line5 >> file &&
> +        git add file &&
> +        test_tick &&
> +        git commit -m "upstream line5" &&
> +        git checkout master
> +       ) &&
> +       (cd super &&
> +        git config submodule.submodule.branch test-branch &&
> +        git submodule update --remote --force submodule &&
> +        cd submodule &&
> +        test "$(git log -1 --oneline)" =3D "$(GIT_DIR=3D../../submod=
ule/.git git log -1 --oneline test-branch)"
> +       )
> +'
> +
>  test_expect_success 'submodule update --rebase staying on master' '
>         (cd super/submodule &&
>           git checkout master
> --
> 1.8.0
>
