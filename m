Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D92C7EE2F
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjFJOvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjFJOvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 10:51:38 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E530E5
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686408682; x=1687013482; i=l.s.r@web.de;
 bh=2m380pGhk78pmFpfDL7sBCWdTNLalishKtHdlvgnCvc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WFdtp0c6dxN9oI6o2zAy4TnWT0lE83KEd8KkkmLK9+D2trjEHvj3F/57ovLYQcOKvrJbfli
 S2SltIsc+Uif3GJZNDnTpCFfr4EkIzOItCP2Jlfz6UDJLleXrH8UI7Nz8VonEILLH4MQ3vmRn
 RqEnNiggH1GxGwzoQaNwql0TDEurMtMpry1q4Ofe25FEsDNv6uo3Gafyyoxk4cd3xZ2jyE8ld
 R7YiXMG3wtncq2+LKKNZPNa/FbRIDqfR6TeySKsu8IktEk26y3AawiR1aJfqqlJECfX4cvPyY
 pJsekAYvobDMLC9qbTyj3p0h+B3+tjNnSthXpZLgPEfhAetYKTEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.146.76]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc7b-1qKPzr1V37-00ETOj; Sat, 10
 Jun 2023 16:51:22 +0200
Message-ID: <753d6b82-580d-bcff-c0c2-e7ad53f13b21@web.de>
Date:   Sat, 10 Jun 2023 16:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: [PATCH 2/2] run-command: report exec error even on ENOENT
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
 <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
 <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
 <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
 <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
 <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
 <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
 <28d808e4-77b4-d91e-8a86-c21287019b56@web.de> <xmqqwn0h4ek3.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwn0h4ek3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z0rDEB5s6bejqnQp5xFBPXrbvjCX+0Bb2CKjo2iHcfQeCq1MXZv
 2lT7fWsm5LvmzQbpYNmzfq0zfmKoNBB2Hormoc2Nxr/ygZFJWOKhGti3n6JEt2HCcgxvAI8
 2k30LO0Qzu36N9dw4aa9blRw3/MU481tAEWxglaySO6S/bV9Ct5mbC4r/Mt0UYQ1rhOQXfy
 06YZBPOCSA9Q+MZlcnpjw==
UI-OutboundReport: notjunk:1;M01:P0:KXdqfD5vRkE=;weyosRkKYyhRHf0fxReXMoNGyZa
 eQaQ/ytru5Ufb7jYrX9YaqH9d6d+SQ0DVWqQyoMfEYV3M54K7drqPg8SdnTBKkaLufUQqWGNc
 Oz5TwVkXRe5/2LEV7BdDfyjQVsfBPP3EEZ2do0TpvaIXnZtYJJ+i4DPD4XtupEnjLKNz3DQ+t
 cnlz/iiQBIwpUsgWY989kmd7+YM0bx77jfBqIX5BpRQdGvAQJPNZbHe8FHM4HOEb+l6m3zA1j
 yOVrkuBkL3B+IkQxCIn+qQejx/Li4eDnp9mUN6+jtmj3ECBeUOmwFYjj/NE7ObbQzK2Yh0kzY
 nnOL31z37RbvxI+YT6K0PxzUSjjs/o4rpCLBP+EUlO4JarGBLOlAPqUTPsgtuOZbYS9JZyTWt
 MWmvNqoeRyk21Xe5vPUtZCrKXatHeP9nZFg5ULUAdxoy6e8CEL4nMmkFVQQB0Tl2fphGS90lo
 UDUfS/Tv7Rek+50r3Rpb8fgqajtFqH6nbkOgnztNicmw64mVVY5DlJeB5ZqXOgBX1VZXB3tWN
 B1ITIwfEqYBD+yUcppWsSDUCx5hRn3n0ZxHUutq7Us2kepOsrz9bu8+ceGfoVf6hiOeEKkLsx
 G5f3MRjbEQrzIBU9OLCrLbxNCMz35xK7vRhcX3pbmK52MZMcMXiPhk2sDSSVN1QAB0VV721D/
 gOYnw98moDKdjhFciByElQnof2kmT4a97JxZOpSRRCGtWAEp6O0cLf0etmcFxYogBBLFG+MfN
 An5Lir2PtTyaX/W53tFxIjGaVyju1icidEu9UDj7uWZ5CPqnxZ/Ajl8nw3ksNeNoIEiIOHk5L
 B5WmZuMhnFHhVW8zdnG7tNy8QWF6ZiWSr2vmNjgUK9NxGL7VLXR7AgRZyFzLrATcALHCuORA2
 9bK/pq3mnvNrbZqX2cRYzg7dKt7LWBWpvdtS89OptzHfNZyfp2UuQAPd9/oYfvSUYgzDWuINI
 LtmAOQv/WPoNyzpn/onLH2zIACU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If execve(2) fails with ENOENT and we report the error, we use the
format "cannot run %s", followed by the actual error message.  For other
errors we use "cannot exec '%s'".

Stop making this subtle distinction and use the second format for all
execve(2) errors.  This simplifies the code and makes the prefix more
precise by indicating the failed operation.  It also allows us to
slightly simplify t1800.16.

On Windows -- which lacks execve(2) -- we already use a single format in
all cases: "cannot spawn %s".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with -U6 for easier review.

 run-command.c   | 14 +++-----------
 t/t1800-hook.sh |  2 +-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index 60c9419866..758f8534da 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -304,13 +304,12 @@ static int child_notifier =3D -1;

 enum child_errcode {
 	CHILD_ERR_CHDIR,
 	CHILD_ERR_DUP2,
 	CHILD_ERR_CLOSE,
 	CHILD_ERR_SIGPROCMASK,
-	CHILD_ERR_ENOENT,
 	CHILD_ERR_SILENT,
 	CHILD_ERR_ERRNO
 };

 struct child_err {
 	enum child_errcode err;
@@ -387,15 +386,12 @@ static void child_err_spew(struct child_process *cmd=
, struct child_err *cerr)
 	case CHILD_ERR_CLOSE:
 		error_errno("close() in child failed");
 		break;
 	case CHILD_ERR_SIGPROCMASK:
 		error_errno("sigprocmask failed restoring signals");
 		break;
-	case CHILD_ERR_ENOENT:
-		error_errno("cannot run %s", cmd->args.v[0]);
-		break;
 	case CHILD_ERR_SILENT:
 		break;
 	case CHILD_ERR_ERRNO:
 		error_errno("cannot exec '%s'", cmd->args.v[0]);
 		break;
 	}
@@ -843,19 +839,15 @@ int start_command(struct child_process *cmd)
 		execve(argv.v[1], (char *const *) argv.v + 1,
 		       (char *const *) childenv);
 		if (errno =3D=3D ENOEXEC)
 			execve(argv.v[0], (char *const *) argv.v,
 			       (char *const *) childenv);

-		if (errno =3D=3D ENOENT) {
-			if (cmd->silent_exec_failure)
-				child_die(CHILD_ERR_SILENT);
-			child_die(CHILD_ERR_ENOENT);
-		} else {
-			child_die(CHILD_ERR_ERRNO);
-		}
+		if (cmd->silent_exec_failure && errno =3D=3D ENOENT)
+			child_die(CHILD_ERR_SILENT);
+		child_die(CHILD_ERR_ERRNO);
 	}
 	atfork_parent(&as);
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->args.v[0]);
 	else if (cmd->clean_on_exit)
 		mark_child_for_cleanup(cmd->pid, cmd);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index c156d6decc..8b0234cf2d 100755
=2D-- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -161,13 +161,13 @@ test_expect_success 'git hook run a hook with a bad =
shebang' '
 		hook run test-hook >out 2>err &&
 	test_must_be_empty out &&

 	# TODO: We should emit the same (or at least a more similar)
 	# error on MINGW (essentially Git for Windows) and all other
 	# platforms.. See the OS-specific code in start_command()
-	grep -E "^(error|fatal): cannot (exec|run|spawn) .*bad-hooks/test-hook" =
err
+	grep -E "^(error|fatal): cannot (exec|spawn) .*bad-hooks/test-hook" err
 '

 test_expect_success 'stdin to hooks' '
 	write_script .git/hooks/test-hook <<-\EOF &&
 	echo BEGIN stdin
 	cat
=2D-
2.41.0

