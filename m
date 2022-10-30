Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8222C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJ3LwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:52:05 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD1BF65
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130716; bh=Fv1hB6tG5iiVpp6Rw+u+dNHfWLutR6Zt9i9eoxFbfrE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=qnpcQDPgBT5ppGp1KeG39002QihR6WLgobTHgVG577o5XopbtBGzQgvFdQXMQL6t4
         gFyba+9IYZoy8irmBz/cAhTm3IApr7r8C9oJNi+Egvu36T634mB3xpIc3Whpu5GtCO
         a4hujIUAm4CNQ6DL/vgaTJvsYq8mwaAs+3/LG+HEUWsJqof3SXfuS9sbrSfY3742fx
         VI6MOzB7DkV8zDEfIcF3qfem9A2TdTIS7uhbtnQzD14y5RJrj86heejG4SZcg2yFoK
         M1lGsQn+Eca+f7xVPAlwjsioBYjuoAZQlSu+9xCkrfNABLB749gGtuxBztw5zBjh1d
         XCm5sia+qpVkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpuw-1pNti23H5W-00Zuq1; Sun, 30
 Oct 2022 12:51:56 +0100
Message-ID: <d5896e6f-df69-d683-ec16-f83a0179a2fb@web.de>
Date:   Sun, 30 Oct 2022 12:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 09/12] replace and remove run_command_v_opt_cd_env()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ibnxsrebPLEzKFFT81Rk1UhKwDai2lZgq4BLpc/p4Wt5yY6sDy0
 LQeqWXaHRzMAne4YJ3WSUoZdBfqfE3dwOjECOKzxolByEFTbuOFzfSOjmfI6ath/4ItX09x
 lUT1qz1RXHFP58x301us7IutMgHi0JRoRnG5S0X2364dErcXqQm98SWt/fbMUzGz7oTHL4L
 yMw0EOrWJXND6pvnDLSrg==
UI-OutboundReport: notjunk:1;M01:P0:2Et6/IyJKQk=;BuTPtJCV4gZNkHtTcfsoFX0hiGK
 oW2cgNcv2Q1F2KC6hRD3VhfUJjVpyhK9HxZTforqGpCpWpXO1u4rI4p2bT+7HhNp3eDaSuiaU
 5savr413KDokJN3kLotznXSh//hqmX3kB0/thzpXe//xvzzXwjhp5dC/aKOBfE9S5C1sRh5is
 Q3IlxrkS6wIaIlfFAc0E7knaeKpYlmYT0UtEPDtIW2MhrnDlaLgYFngyKraqwZXyczG/eYt4r
 JbBnZDn0Oiy/A2QoFnedFkK8/KfDNunbHBh2dbLe3dgAsWpaiHClkl4BucKsly8PtHF59fFjS
 Y9cfxrM4vE2uOkwZwdRYfSV9H9a/FGb3A1iUfthvGa51HZwBRteXAcRAqnbZXfsZGc4VK2Q1I
 YVkzkCTqaf5XPMDq3ML9CBnveezPlzwBvHrNv8DamAHN8aQGGeaHamoUyrxKFwsMzuCX8F+Pk
 LorccQbX3mVV2/4IXAEbjvLXgW8OWGQxCww/fbvWJ8H05NrwmagzOAYM30Mf9Bso4uvyQNSS2
 eDwd8H0cKtlVNV8Fp30SdPcX3cWmcBe4xTnFp5RQ2fF+rhpqY8c7/Sy67bGpe0AEAd2Nrc78P
 lpU1y9CAfUXpDGomsLcbBWizw2dxqgIBua8fo1az1sY7bxqtR1Yccc6YMyNF/zASpYGE9MQ1w
 gWVaNu+VgFlXPoI5WCgezHDmdCeOLYnva8ZZdpwGD+UgbJve4VtMk+xKVjq/C7xDv8EiZJc9y
 KBTi8grB0ZbsueaVcZpSNcWa5BwVAyviMUZQoWZglnkNLd2irz55pO5BaChwc4EVlX+m7OM8g
 sunAJWBrEhX6ysfdjUZl7bm063d7fIWe3Pl4Pn8tN3V9f4KOT/ZP1Fhi48l3cdRDv72M0wJfB
 JiOdUUxPydczsceMTfdLUwyvxZ9igCfDyr+wcBC4/NHNlhm0A8jcqd17xNW5KCX+O0Tp0UCSx
 gJXFzjzEO21rJNqk95TwZgIvZQ0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

run_command_v_opt_cd_env() is only used in an example in a comment.  Use
the struct child_process member "env" and run_command() directly instead
and then remove the unused convenience function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 run-command.c | 7 +------
 run-command.h | 3 +--
 tmp-objdir.h  | 6 ++++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index c772acd743..954257abb5 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -1006,7 +1006,7 @@ int run_command(struct child_process *cmd)

 int run_command_v_opt(const char **argv, int opt)
 {
-	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
+	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
 }

 int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_cla=
ss)
@@ -1014,11 +1014,6 @@ int run_command_v_opt_tr2(const char **argv, int op=
t, const char *tr2_class)
 	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
 }

-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir,=
 const char *const *env)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
-}
-
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
 				 const char *const *env, const char *tr2_class)
 {
diff --git a/run-command.h b/run-command.h
index 820fc25b02..05c02485df 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -151,7 +151,7 @@ struct child_process {

 /**
  * The functions: start_command, finish_command, run_command,
- * run_command_v_opt, run_command_v_opt_cd_env do the following:
+ * run_command_v_opt do the following:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnost=
ic
  *   is printed.
@@ -249,7 +249,6 @@ int run_command_v_opt_tr2(const char **argv, int opt, =
const char *tr2_class);
  * env (the environment) is to be formatted like environ: "VAR=3DVALUE".
  * To unset an environment variable use just "VAR".
  */
-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir,=
 const char *const *env);
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
 				 const char *const *env, const char *tr2_class);

diff --git a/tmp-objdir.h b/tmp-objdir.h
index 76efc7edee..237d96b660 100644
=2D-- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -10,9 +10,11 @@
  *
  * Example:
  *
+ *	struct child_process child =3D CHILD_PROCESS_INIT;
  *	struct tmp_objdir *t =3D tmp_objdir_create("incoming");
- *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
- *	    !tmp_objdir_migrate(t))
+ *	strvec_push(&child.args, cmd);
+ *	strvec_pushv(&child.env, tmp_objdir_env(t));
+ *	if (!run_command(&child)) && !tmp_objdir_migrate(t))
  *		printf("success!\n");
  *	else
  *		die("failed...tmp_objdir will clean up for us");
=2D-
2.38.1
