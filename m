From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 1/2] t5520-pull: Add testcases showing spurious 
	conflicts from git pull --rebase
Date: Sun, 8 Aug 2010 18:43:37 -0600
Message-ID: <AANLkTikNEF=TaJmgTpuoJ=vKhM+r51m0FzwExcQDL=JG@mail.gmail.com>
References: <1281300917-5610-1-git-send-email-newren@gmail.com>
	<1281300917-5610-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	avarab@gmail.com, Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 09 02:43:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiGT5-0007dl-3d
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 02:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab0HIAnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 20:43:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40090 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0HIAnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 20:43:39 -0400
Received: by fxm14 with SMTP id 14so4702612fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UkpRCKs/lvhklH17EY/ZZerFPgKWg5tWr1yaHCpIAoI=;
        b=Tj1EOZ5aUeA/RbR7Ccjyqj+388ZDhwPZN9QbScMZkSBr78YBRN4f6bDFQdVT/51qsU
         XWk681EGQliT9wj4/roQ8H7Arhj/GI7sOekOqSsiMsrJbi3li+1rm6/yzgKW9UP8ynku
         u3AUz1jpW8gpUPLBXE1YPrXuR6VysyUjN+kzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q2eGzPEmcOALwQUUHJWlyXsJHQw5HvIGcqHej6O4WJ7bZcc5e9vYO/QSFowjzS6wH7
         oC6NDXmbhn83LZLRNlMHPN13u11uvn/Jk25LW0e8RHtpZ0mqidegRmYsMIkKz8Ybu0BD
         +vfJTfXPUx+uexO0K5b8YP+pkIqJrAqqDO7Ko=
Received: by 10.223.119.198 with SMTP id a6mr15899784far.66.1281314617932; 
	Sun, 08 Aug 2010 17:43:37 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Sun, 8 Aug 2010 17:43:37 -0700 (PDT)
In-Reply-To: <1281300917-5610-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152940>

On Sun, Aug 8, 2010 at 2:55 PM, Elijah Newren <newren@gmail.com> wrote:
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> =C2=A0t/t5520-pull.sh | =C2=A0 63 +++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 63 insertions(+), 0 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 319e389..9099e55 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -4,6 +4,11 @@ test_description=3D'pulling into void'
>
> =C2=A0. ./test-lib.sh
>
> +modify () {
> + =C2=A0 =C2=A0 =C2=A0 sed -e "$1" < "$2" > "$2".x &&
> + =C2=A0 =C2=A0 =C2=A0 mv "$2".x "$2"
> +}
> +
> =C2=A0D=3D`pwd`
>
> =C2=A0test_expect_success setup '
> @@ -160,4 +165,62 @@ test_expect_success 'pull --rebase works on bran=
ch yet to be born' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect actual
> =C2=A0'
>
> +test_expect_success 'setup for detecting upstreamed changes' '
> + =C2=A0 =C2=A0 =C2=A0 mkdir src &&
> + =C2=A0 =C2=A0 =C2=A0 (cd src &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git init &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in $(seq 1 10); do echo $i; done >=
 stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git add stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "Initial revision"
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 git clone src dst &&
> + =C2=A0 =C2=A0 =C2=A0 (cd src &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/5/43/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "5->43" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/6/42/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Make it bigger" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0correct=3D$(git rev-parse HEAD)
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/5/43/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Independent discovery =
of 5->43"
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_failure 'git pull --rebase detects upstreamed changes' '
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git pull --rebase &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0test -z "$(git ls-files -u)"
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_success 'setup for avoiding reapplying old patches' '
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git rebase --abort;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard origin/master
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 git clone --bare src src-replace.git &&
> + =C2=A0 =C2=A0 =C2=A0 rm -rf src &&
> + =C2=A0 =C2=A0 =C2=A0 mv src-replace.git src &&
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/2/22/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Change 2" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/3/33/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Change 3" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/4/44/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Change 4" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git push &&
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0modify s/44/55/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit --amend -a -m "Modified Chang=
e 4"
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_failure 'git pull --rebase does not reapply old patches'=
 '
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git pull --rebase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0test 1 =3D $(find .git/rebase-apply -nam=
e "000*" | wc -l)
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> =C2=A0test_done
> --

Interdiff addressing Hannes' comments (given on previous series):

diff -u b/t/t5520-pull.sh b/t/t5520-pull.sh
--- b/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -169,7 +169,7 @@
 	mkdir src &&
 	(cd src &&
 	 git init &&
-	 for i in $(seq 1 10); do echo $i; done > stuff &&
+	 printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > stuff &&
 	 git add stuff &&
 	 git commit -m "Initial revision"
 	) &&
@@ -178,8 +178,7 @@
 	 modify s/5/43/ stuff &&
 	 git commit -a -m "5->43" &&
 	 modify s/6/42/ stuff &&
-	 git commit -a -m "Make it bigger" &&
-	 correct=3D$(git rev-parse HEAD)
+	 git commit -a -m "Make it bigger"
 	) &&
 	(cd dst &&
 	 modify s/5/43/ stuff &&
@@ -196,7 +195,7 @@

 test_expect_success 'setup for avoiding reapplying old patches' '
 	(cd dst &&
-	 git rebase --abort;
+	 test_might_fail git rebase --abort &&
 	 git reset --hard origin/master
 	) &&
 	git clone --bare src src-replace.git &&
@@ -218,7 +217,7 @@

 test_expect_failure 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
-	 git pull --rebase;
+	 test_must_fail git pull --rebase &&
 	 test 1 =3D $(find .git/rebase-apply -name "000*" | wc -l)
 	)
 '
