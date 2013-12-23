From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Mon, 23 Dec 2013 18:48:09 +0100
Message-ID: <52B87759.2090901@web.de>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com> <1387789361-29036-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, tfnico@gmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 23 18:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vv9cr-0005A7-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Dec 2013 18:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab3LWRsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Dec 2013 12:48:19 -0500
Received: from mout.web.de ([212.227.17.11]:58334 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932361Ab3LWRsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Dec 2013 12:48:16 -0500
Received: from [192.168.37.101] ([87.146.154.79]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MfHsM-1W6ciK1RjG-00Omln for <git@vger.kernel.org>;
 Mon, 23 Dec 2013 18:48:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387789361-29036-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:Jkw4ZsGEAgjnzz/HPkVpgIyN+wvHnyk8zpgHPkDhPJEXTpbLvmh
 FU2WAdgqb5KQgBc4yLsr9P9JlgbaFZwlnQvWCatswhdiuAa/JOo8nNZIThQbtUsfC1CPZzS
 96gfvO25pWDPB50pd8UqNTI9sj5M2ITrYGSssBauQorX+7vAYrhpF7ZrPIoLR9HqOmstDuZ
 vBxnMyjc6gqYAaRLMA/DA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239654>

On 2013-12-23 10.02, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This behavior was added in 07d7bed (add: don't complain when adding
> empty project root - 2009-04-28) then broken by 84b8b5d (remove
> match_pathspec() in favor of match_pathspec_depth() -
> 2013-07-14). Reinstate it.
>=20
> Noticed-by: Thomas Ferris Nicolaisen <tfnico@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/add.c  | 2 +-
>  t/t3700-add.sh | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/add.c b/builtin/add.c
> index 226f758..fbd3f3a 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
> =20
>  		for (i =3D 0; i < pathspec.nr; i++) {
>  			const char *path =3D pathspec.items[i].match;
> -			if (!seen[i] &&
> +			if (!seen[i] && pathspec.items[i].match[0] &&
>  			    ((pathspec.items[i].magic &
>  			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
>  			     !file_exists(path))) {
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index aab86e8..1535d8f 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -307,4 +307,8 @@ test_expect_success 'git add --dry-run --ignore-m=
issing of non-existing file out
>  	test_i18ncmp expect.err actual.err
>  '
> =20
> +test_expect_success 'git add -A on empty repo does not error out' '
> +	git init empty && ( cd empty && git add -A . )
> +'
> +
>  test_done
>=20
I am (a little bit) confused.

This is what git does:
 rm -rf test && mkdir test && cd test && git init && touch A && mkdir D=
 && cd D && touch B && git add . && git status
Initialized empty Git repository in /Users/tb/test/test/.git/
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   B

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        ../A
----------------
And the behaviour is in line with
https://www.kernel.org/pub/software/scm/git/docs/git-add.html

"." stands for the current directory somewhere in the worktree,
not only the "project root".
-----------------

Could it make sense to mention that replace
[PATCH] add: don't complain when adding empty project root
with
[PATCH] add: don't complain when adding empty directory.

(and similar in the commit message)
/Torsten
