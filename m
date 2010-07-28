From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo") in  log options.
Date: Wed, 28 Jul 2010 16:00:23 +0200
Message-ID: <vpq39v3670o.fsf@bauges.imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
	<1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikzL-sgysKD+0CZ100xHWZro=-hDgDgUL2Pb3yw@mail.gmail.com>
	<vpq8w4vhmkj.fsf@bauges.imag.fr>
	<AANLkTi=TRzn-QWduEYH7qO-4=a-nGqCGSMkZCGn2iB=W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 16:01:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7CJ-0001HA-6v
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0G1OBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 10:01:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57232 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089Ab0G1OBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:01:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6SDwbxL001841
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 15:58:37 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oe7BH-0003oQ-Ka; Wed, 28 Jul 2010 16:00:23 +0200
In-Reply-To: <AANLkTi=TRzn-QWduEYH7qO-4=a-nGqCGSMkZCGn2iB=W@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Wed\, 28
 Jul 2010 12\:56\:49 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 15:58:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6SDwbxL001841
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280930319.64302@HBJ/jS+MgTiY/vLPVKNX3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152087>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:


> DISCUSSION in git-commit(1) and gittutorial(7) mention 50 characters
> explicitly though, and a lot of tools that present commits in short
> form use that as a soft limit, e.g. gitweb and github.

Where does github have this limitation?

On http://github.com/git/git/commits/master, I can see messages like
this:

git-read-tree.txt: acknowledge the directory matching bug in sparse che=
ckout

76 chars-wide, untruncated.

> I'll submit a patch to SubmittingPatches citing the 50 char soft
> limit.

git$ git log --format=3D'%s' | wc -l
22700
git$ git log --format=3D'%s' | grep '..................................=
=2E...............' | wc -l    =20
9392

Almost half of the commits already there do not comply with this
supposed rule.

I'm fine with rewriting the subject, but the claim that commit
messages should be <50 chars is just not reasonable and has never been
applied to git.git.

> I only saw two test_expect_success additions in your v2 series, maybe
> I missed one.

I'm putting the diff for the t/ directory below to sum up the tests
added.

> Not for everything it seems, but the coverage is pretty good:
>
>     http://v.nix.is/~avar/cover_db_html/parse-options-c.html
>     http://v.nix.is/~avar/cover_db_html/test-parse-options-c.html

You're precisely illustrating my point: these coverage results are
about parse-option, not about the places where it is used. For
example:

git/t$ git grep -e '--message'
git/t$

=3D> git commit --message is not tested, at all (but git commit -m
obviously is).

In my case, I didn't gcov it, but I think I've got 100% coverage on
the helper functions (short_opt and diff_long_opt), just not 100% on
the places where they're used.

> Anyway, here's how you can easily get almost complete coverage at
> almost no cost for this series, first make a t/lib-log.sh like this:
>
>     #!/bin/sh
>
>     log_expect_success() {
>         desc=3D$1
>         text=3D$2
>         test_expect_success "Phony test with attached options: $1" "$=
2"
>         mocked=3D$(echo "$2" | sed -r 's/([A-Za-z-]+)=3D/\1 /')
>         test_expect_success "Phony test with detached options: $1" "$=
mocked"
>     }

You should check whether "$mocked" =3D=3D "$2" to avoid useless re-run.

> I can submit something like that later if I get around to it,

Go ahead, I've exhausted my git time budget ;-).



diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dae6358..8036e00 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -208,6 +208,7 @@ log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
 log -SF master
+log -S F master
 log -SF -p master
 log --decorate --all
 log --decorate=3Dfull --all
diff --git a/t/t4013/diff.log_-S_F_master b/t/t4013/diff.log_-S_F_maste=
r
new file mode 100644
index 0000000..978d2b4
--- /dev/null
+++ b/t/t4013/diff.log_-S_F_master
@@ -0,0 +1,7 @@
+$ git log -S F master
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+$
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2230e60..f912589 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -101,11 +101,16 @@ test_expect_success 'oneline' '
 test_expect_success 'diff-filter=3DA' '
=20
 	actual=3D$(git log --pretty=3D"format:%s" --diff-filter=3DA HEAD) &&
+	actual_detached=3D$(git log --pretty=3D"format:%s" --diff-filter A HE=
AD) &&
 	expect=3D$(echo fifth ; echo fourth ; echo third ; echo initial) &&
 	test "$actual" =3D "$expect" || {
 		echo Oops
 		echo "Actual: $actual"
 		false
+	} &&
+	test "$actual" =3D "$actual_detached" || {
+		echo Oops. Detached form broken
+		echo "Actual_detached: $actual_detached"
 	}
=20
 '
@@ -203,6 +208,13 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'log --grep option parsing' '
+	echo second >expect &&
+	git log -1 --pretty=3D"tformat:%s" --grep sec >actual &&
+	test_cmp expect actual &&
+	test_must_fail git log -1 --pretty=3D"tformat:%s" --grep
+'
+
 test_expect_success 'log -i --grep' '
 	echo Second >expect &&
 	git log -1 --pretty=3D"tformat:%s" -i --grep=3Dsec >actual &&
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 58428d9..fb8291c 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -123,6 +123,12 @@ test_expect_success 'rev-list --glob=3Drefs/heads/=
subspace/*' '
=20
 '
=20
+test_expect_success 'rev-list --glob refs/heads/subspace/*' '
+
+	compare rev-list "subspace/one subspace/two" "--glob refs/heads/subsp=
ace/*"
+
+'
+
 test_expect_success 'rev-list --glob=3Dheads/subspace/*' '
=20
 	compare rev-list "subspace/one subspace/two" "--glob=3Dheads/subspace=
/*"

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
