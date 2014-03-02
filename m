From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Sun, 2 Mar 2014 03:37:45 -0500
Message-ID: <CAPig+cTj1hBOFDLA5LecXwrVN4FG6pAzSDTAyLchHQbOkoEnEA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Mar 02 09:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK1uA-00077M-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 09:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaCBIhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 03:37:47 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:60288 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaCBIhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 03:37:46 -0500
Received: by mail-yk0-f175.google.com with SMTP id 131so5786347ykp.6
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 00:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=QEFtRwU/daLFRsk0o+mG8ujJh9hnQdGZkEUTscqs2+g=;
        b=EPTUNe8DKENz3ucmo/w1fsHJvnSd05ZUHVyLZwBTnGItGQ9wzsWqdy1ea3EKx6X295
         OhnGQG3YCqxG8nz2lhQnwG2OTFswYdcYvXh+tLMHkFEPJeqnHG+wGME3AiqLhavHd78m
         BybYcYl14TdgesayDplHJJPX5QWBGhSLyafLOxvekJ9RPcSacbz/BEiQRiozMQtnee8K
         DGd6cc8fErV2hHLfYu7EBYOxWQkJh0hiVRqo50aUBSOs1eoMUN4zF2nFEvZDoMp1zCi1
         Gs1muT0i7aGdzxRsyBlx3a6IYIqXoMswhzUuvIJpS90Qg8KQXWCtQVwqu16mY4OKGjY2
         wK2g==
X-Received: by 10.236.207.73 with SMTP id m49mr14307225yho.5.1393749465903;
 Sun, 02 Mar 2014 00:37:45 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 00:37:45 -0800 (PST)
In-Reply-To: <1393728794-29566-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 2b-dkKyhKt5mUvPzjWrGxWQkMPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243140>

On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This is "rev-list style", where people can do "git rev-list -3" in
> addition to "git rev-list HEAD~3". A lot of commands are driven by th=
e
> revision machinery and also accept this form. This addition to rebase
> is just for convenience.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5f6732b..33face1 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -342,6 +346,11 @@ do
>         esac
>         shift
>  done
> +if [ -n "$NUM" ]

With the exception of one errant "if [...]", git-rebase.sh uniformly
uses "if test ...".

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
