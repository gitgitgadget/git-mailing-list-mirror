From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Sun, 2 Mar 2014 03:53:12 -0500
Message-ID: <CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK297-0004Nl-Qw
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 09:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbaCBIxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 03:53:13 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:41388 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaCBIxM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 03:53:12 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so7246622ykr.9
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=YMB50u0VrMQj9KycZWDNiAHFYKhOPcUnJ6YCNAFyMH4=;
        b=LoN+dymfQb7I49DO7gpGciUkb6iH3af3btSqeqMnuk0xbN7hQGqzI62HOWaqRRbz4D
         xtTnB/zllS5zPGYxMcwbJBbAm40iVbf0xxh+qynUFC03ucDUiqjluEnQg9xpbwxHseKR
         tPKHIPLljDjo83otAxzjvsjZnfK/+l7dBd1HSVs709lbP46FsFjf1cIvP1ejnx3ZKxuF
         1LbXrS+aDe17s1UqcJWcNcnNXlRr7aciBZQHCrkFRixiMvZacQn1OgFE+Z5R6zfqxIO6
         u7Nm/XXEJ+lo2e/A18TxWadlg3XgkFGcC1Xgm+jnt0FmlAMo9y+/41Wi6zHRn8fVtU2n
         G1Bg==
X-Received: by 10.236.37.105 with SMTP id x69mr14022338yha.15.1393750392421;
 Sun, 02 Mar 2014 00:53:12 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 00:53:12 -0800 (PST)
In-Reply-To: <1393728794-29566-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: K5sfLzSKNu6mPr-idE81flJBQRo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243142>

On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This is "rev-list style", where people can do "git rev-list -3" in
> addition to "git rev-list HEAD~3". A lot of commands are driven by th=
e
> revision machinery and also accept this form. This addition to rebase
> is just for convenience.

I'm seeing some pretty strange results with this. If I use -1, -2, or
-3 then it rebases the expected commits, however, -4 gives me 9
commits, and -5 rebases 35 commits. Am I misunderstanding how this
works?

I'm testing on a branch based on master with these three patches applie=
d.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-rebase.txt | 3 +++
>  git-rebase.sh                | 9 +++++++++
>  t/t3400-rebase.sh            | 6 ++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 2a93c64..52c3561 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -223,6 +223,9 @@ As a special case, you may use "A\...B" as a shor=
tcut for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
>
> +-<number>::
> +       Specify <upstream> as "HEAD~<number>".
> +
>  <upstream>::
>         Upstream branch to compare against.  May be any valid commit,
>         not just an existing branch name. Defaults to the configured
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5f6732b..33face1 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -43,6 +43,7 @@ continue!          continue
>  abort!             abort and check out the original branch
>  skip!              skip current patch and continue
>  edit-todo!         edit the todo list during an interactive rebase
> +-NUM               equivalent of HEAD~<NUM>
>  "
>  . git-sh-setup
>  . git-sh-i18n
> @@ -335,6 +336,9 @@ do
>         --gpg-sign=3D*)
>                 gpg_sign_opt=3D"-S${1#--gpg-sign=3D}"
>                 ;;
> +       -NUM=3D*)
> +               NUM=3D"${1#-NUM=3D}"
> +               ;;
>         --)
>                 shift
>                 break
> @@ -342,6 +346,11 @@ do
>         esac
>         shift
>  done
> +if [ -n "$NUM" ]
> +then
> +       test $# -gt 0 && usage
> +       set -- "$@" "HEAD~$NUM"
> +fi
>  test $# -gt 2 && usage
>
>  if test -n "$cmd" &&
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6d94b1f..11db7ea 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -215,4 +215,10 @@ test_expect_success 'rebase commit with an ancie=
nt timestamp' '
>         grep "author .* 34567 +0600$" actual
>  '
>
> +test_expect_success 'rebase -<number>' '
> +       git reset --hard &&
> +       test_must_fail git rebase -2 HEAD^^ &&
> +       git rebase -2
> +'
> +
>  test_done
> --
> 1.9.0.40.gaa8c3ea
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
