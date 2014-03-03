From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] *.sh: avoid hardcoding $GIT_DIR/hooks/...
Date: Mon, 3 Mar 2014 03:31:46 -0500
Message-ID: <CAPig+cSOityd484g3x7tD9s90YXTrP7Jc-Obxmw6iKAEh-+RBA@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:31:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKOHv-00028w-BC
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 09:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbaCCIbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 03:31:47 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:48556 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaCCIbq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 03:31:46 -0500
Received: by mail-yh0-f51.google.com with SMTP id f10so2797175yha.24
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 00:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=aIe51AeHKm3xy3FK2iK3oHRp8qW9etkKz6RVDVM0yqY=;
        b=lHVoi36BbTJfGve+s+ajrHnFn95Fy5pJLPZlYo1dFHNLzAMlmvPTBtocNRJUjKsOCA
         nne84knAqU4U4lYATCN504+UZedoeBS7DbSWI9KwzXp5Nrc/WVsS3aiWzIorhWJlJEVT
         t/+avULbfXwDYC1FgzUQFmQnBntonI5ILATA1z5LsbLzyKxQje/YFytX/tOmGZFXNeSX
         5mopijaMECdvehsercTRqvZd++A9pE3/DIJbXfHg88KvltSxNsC9epRCh9RiRPpwwcWx
         xDB5czXWj4Ug/olMVy8K9u9TdAR4MZ2ODkxpCBWQ/aWTWLgdLIYzx8tB/48zRPitfXf0
         YlcA==
X-Received: by 10.236.17.34 with SMTP id i22mr98847yhi.110.1393835506150; Mon,
 03 Mar 2014 00:31:46 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 00:31:46 -0800 (PST)
In-Reply-To: <1393675983-3232-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Wj5EnyQLCuhbl-laWHtXT8TUO-A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243198>

On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> If $GIT_COMMON_DIR is set, it should be $GIT_COMMON_DIR/hooks/, not
> $GIT_DIR/hooks/. Just let rev-parse --git-path handle it.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  git-am.sh                              | 22 +++++++++++-----------
>  git-rebase--interactive.sh             |  6 +++---
>  git-rebase--merge.sh                   |  6 ++----
>  git-rebase.sh                          |  4 ++--
>  templates/hooks--applypatch-msg.sample |  4 ++--
>  templates/hooks--pre-applypatch.sample |  4 ++--
>  6 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index bbea430..dfa0618 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -803,10 +803,10 @@ To restore the original branch and stop patchin=
g run \"\$cmdline --abort\"."
>                 continue
>         fi
>
> -       if test -x "$GIT_DIR"/hooks/applypatch-msg
> +       hook=3D"`git rev-parse --git-path hooks/applypatch-msg`"

Did you want to use $(...) rather than `...`?

Same question for the remainder of the patch.

> +       if test -x "$hook"
>         then
> -               "$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit=
" ||
> -               stop_here $this
> +               "$hook" "$dotest/final-commit" || stop_here $this
>         fi
>
>         if test -f "$dotest/final-commit"
> @@ -880,9 +880,10 @@ did you forget to use 'git add'?"
>                 stop_here_user_resolve $this
>         fi
>
> -       if test -x "$GIT_DIR"/hooks/pre-applypatch
> +       hook=3D"`git rev-parse --git-path hooks/pre-applypatch`"
> +       if test -x "$hook"
>         then
> -               "$GIT_DIR"/hooks/pre-applypatch || stop_here $this
> +               "$hook" || stop_here $this
>         fi
>
>         tree=3D$(git write-tree) &&
> @@ -908,18 +909,17 @@ did you forget to use 'git add'?"
>                 echo "$(cat "$dotest/original-commit") $commit" >> "$=
dotest/rewritten"
>         fi
>
> -       if test -x "$GIT_DIR"/hooks/post-applypatch
> -       then
> -               "$GIT_DIR"/hooks/post-applypatch
> -       fi
> +       hook=3D"`git rev-parse --git-path hooks/post-applypatch`"
> +       test -x "$hook" && "$hook"
>
>         go_next
>  done
>
>  if test -s "$dotest"/rewritten; then
>      git notes copy --for-rewrite=3Drebase < "$dotest"/rewritten
> -    if test -x "$GIT_DIR"/hooks/post-rewrite; then
> -       "$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
> +    hook=3D"`git rev-parse --git-path hooks/post-rewrite`"
> +    if test -x "$hook"; then
> +       "$hook" rebase < "$dotest"/rewritten
>      fi
>  fi
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 43c19e0..d741b04 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -632,9 +632,9 @@ do_next () {
>                 git notes copy --for-rewrite=3Drebase < "$rewritten_l=
ist" ||
>                 true # we don't care if this copying failed
>         } &&
> -       if test -x "$GIT_DIR"/hooks/post-rewrite &&
> -               test -s "$rewritten_list"; then
> -               "$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_li=
st"
> +       hook=3D"`git rev-parse --git-path hooks/post-rewrite`"
> +       if test -x "$hook" && test -s "$rewritten_list"; then
> +               "$hook" rebase < "$rewritten_list"
>                 true # we don't care if this hook failed
>         fi &&
>         warn "Successfully rebased and updated $head_name."
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index e7d96de..68f5d09 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -93,10 +93,8 @@ finish_rb_merge () {
>         if test -s "$state_dir"/rewritten
>         then
>                 git notes copy --for-rewrite=3Drebase <"$state_dir"/r=
ewritten
> -               if test -x "$GIT_DIR"/hooks/post-rewrite
> -               then
> -                       "$GIT_DIR"/hooks/post-rewrite rebase <"$state=
_dir"/rewritten
> -               fi
> +               hook=3D"`git rev-parse --git-path hooks/post-rewrite`=
"
> +               test -x "$hook" && "$hook" rebase <"$state_dir"/rewri=
tten
>         fi
>         say All done.
>  }
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 8a3efa2..1cf8dba 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -195,9 +195,9 @@ run_specific_rebase () {
>
>  run_pre_rebase_hook () {
>         if test -z "$ok_to_skip_pre_rebase" &&
> -          test -x "$GIT_DIR/hooks/pre-rebase"
> +          test -x "`git rev-parse --git-path hooks/pre-rebase`"
>         then
> -               "$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
> +               "`git rev-parse --git-path hooks/pre-rebase`" ${1+"$@=
"} ||
>                 die "$(gettext "The pre-rebase hook refused to rebase=
=2E")"
>         fi
>  }
> diff --git a/templates/hooks--applypatch-msg.sample b/templates/hooks=
--applypatch-msg.sample
> index 8b2a2fe..28b843b 100755
> --- a/templates/hooks--applypatch-msg.sample
> +++ b/templates/hooks--applypatch-msg.sample
> @@ -10,6 +10,6 @@
>  # To enable this hook, rename this file to "applypatch-msg".
>
>  . git-sh-setup
> -test -x "$GIT_DIR/hooks/commit-msg" &&
> -       exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
> +commitmsg=3D"`git rev-parse --git-path hooks/commit-msg`"
> +test -x "$commitmsg" && exec "$commitmsg" ${1+"$@"}
>  :
> diff --git a/templates/hooks--pre-applypatch.sample b/templates/hooks=
--pre-applypatch.sample
> index b1f187c..51aa244 100755
> --- a/templates/hooks--pre-applypatch.sample
> +++ b/templates/hooks--pre-applypatch.sample
> @@ -9,6 +9,6 @@
>  # To enable this hook, rename this file to "pre-applypatch".
>
>  . git-sh-setup
> -test -x "$GIT_DIR/hooks/pre-commit" &&
> -       exec "$GIT_DIR/hooks/pre-commit" ${1+"$@"}
> +precommit=3D"`git rev-parse --git-path hooks/pre-commit`"
> +test -x "$precommit" && exec "$precommit" ${1+"$@"}
>  :
> --
> 1.9.0.40.gaa8c3ea
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
