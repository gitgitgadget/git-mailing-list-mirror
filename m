Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8CFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiJ0Qk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiJ0Qk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:40:26 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7E6A49B
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888816; bh=cIgRqmfIPkhIt8vmDvIqDHQIItQgwe5viELbamMQzgg=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=rBtbcJQ0tpVJPJZyHrTpWEM4zZwfSHWNbO2ZoS+UJi/WEh1qdGArU64ViE0GH8Qt8
         hZDllVgDFCJ6mqueSkNm7w9/Kol9R03YKYDa7PdjJHXG+EfFRfxLIjDHAVWfuUOH3u
         xWKBau9z10/9MBORi8gLBz3gcEhbUk0iuCc+e0WbkgIL+WRHJ+iRmCFxB8HiML5Ecu
         lOUflfZA7PV81DUVN34uxk7n6i587bF4x6TWC59LEb2k5p6Sswawx7IWp7Ck5K31eu
         GvnWz6FVKqaO9O8L/Hi5CcNUpyvlIyzARNBqTYYPkV3lM3mnBPEth15CM6hzP4XF3C
         E8pmYkmMixQQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1oWq9p060f-00HyPe; Thu, 27
 Oct 2022 18:40:16 +0200
Message-ID: <f26f7974-3e87-2ddf-6eeb-5d97f80a4e0d@web.de>
Date:   Thu, 27 Oct 2022 18:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 7/8] replace and remove run_command_v_opt_cd_env_tr2()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FBcwbDhjsJXXqhmuH9V+1Q7nmO2RAuRzqZbPwhUa6aVaVI6BnVp
 uLYomR5OGec2lrXbMKdCSZ/zEeAmOF+PMnQ9KtRBoaRxFu44fEOZ2pnr/GJ67heENDsuyoA
 qcNsWQGgzgc3HkT2/8/YgNxwGfIeVo9Bf+Dae+hP/duS5+HdM9zPGvm/PhGlJ2WVXplmhwH
 6xDCTqPb3JjYZtu3oITww==
UI-OutboundReport: notjunk:1;M01:P0:U5vGscs+8hU=;qzQRDMtADq6P8vKu9KWOuiLT5vu
 CHkeHRV1rWpGe7QSpUnnThM70O7C+4sEQuEY5tQD/ctHJU1iJtwbuoFcmXPWCI8Nh+ggeLUok
 KfO8rQaDVZs1BHW3OnsbhINyOILQwliGZKztuhWwjhb56h0jXwgpyYFmYxQU6zeoqlYYPnV5E
 UxDnA6qnjZr53Z1qbM2UiMSV+8JDi8mYNdgfb7skcV9xz5O0op5NEZ5tqFUGWnS4ojwNWcWOQ
 OZuaeJwpz1E9udxc47U3KZuGAjRvwUF+36O0Pipd6pvNVRvXCPP79rKbWMdBBK4pdeCqefMJ6
 WhSEauPO5B44AacelH/cGz4BPfXiRMi/lIMq6y7VNLO7xRWOgpuei6/DaBpWNohKDHRXq9uI5
 E7UvB4cBoUte1sJ6VXEWhRc0D/DcbR5khaQ0/eUtjnYMeQ4PMqrOAZBfl5MFh8MC5DTMxtK/Z
 K4AzY5U+cB2f9bQkc7SsjsGEyP4dzaXENJh/gxblwkMg3bAG/7u86yO39VfAixHfb+tDi7T92
 oG6aJxxhIBLVNPtoXs8Rylpo5cDzy3XSyBvXbKtV0ereOMz258okeqxnJXjgiEgmEtX1njzIp
 mH5updNRzPAu5p7yRlo2OXdWaDNNJ63h1FNJR6cwLl8zZY8dt8zCHTlwkI/axS6yS7t6tF5NO
 jVtnh9RDbiqh/iUDG61hRZ7zizOoe3MWFY+co+u0ExxUxLsD9o2QLzI+85MxSc7QWlG2hP8RZ
 mdRh47bDU7Rth3mwfR+kDpuxG9t0y7pYfanHvstsyqt+DP6jtgzd9a1Ft2ze+7TcO1v7mr4oD
 stcsIVH5yFgZQ6/qckf4e4xlzVDbVARzGWiZoenQOlTLW9FEcPDkI8DgTBYQ73lEsUzG48KX7
 envRAxmLJbonSMOZLj1LRQRbO0Srcmdl/epKGPdWBca6e2D0+Rkzmym0ZtAvzwfy1UOOcDYI+
 pJhKBHjAIOcxJF8/qhfW4EHSGw8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The convenience function run_command_v_opt_cd_env_tr2() has no external
callers left.  Inline it and remove it from the API.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 run-command.c | 10 ----------
 run-command.h | 10 +---------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/run-command.c b/run-command.c
index 32fa4b0ed6..923bad37fe 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -1005,12 +1005,6 @@ int run_command(struct child_process *cmd)
 }

 int run_command_v_opt(const char **argv, int opt)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
-}
-
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
-				 const char *const *env, const char *tr2_class)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	strvec_pushv(&cmd.args, argv);
@@ -1022,10 +1016,6 @@ int run_command_v_opt_cd_env_tr2(const char **argv,=
 int opt, const char *dir,
 	cmd.clean_on_exit =3D opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd.wait_after_clean =3D opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
 	cmd.close_object_store =3D opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
-	cmd.dir =3D dir;
-	if (env)
-		strvec_pushv(&cmd.env, (const char **)env);
-	cmd.trace2_child_class =3D tr2_class;
 	return run_command(&cmd);
 }

diff --git a/run-command.h b/run-command.h
index 482da7f60c..04bd07dc7a 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -233,23 +233,15 @@ int run_auto_maintenance(int quiet);
 #define RUN_CLOSE_OBJECT_STORE		(1<<7)

 /**
- * Convenience functions that encapsulate a sequence of
+ * Convenience function that encapsulate a sequence of
  * start_command() followed by finish_command(). The argument argv
  * specifies the program and its arguments. The argument opt is zero
  * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
  * `RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
  * that correspond to the members .no_stdin, .git_cmd,
  * .stdout_to_stderr, .silent_exec_failure of `struct child_process`.
- * The argument dir corresponds the member .dir. The argument env
- * corresponds to the member .env.
  */
 int run_command_v_opt(const char **argv, int opt);
-/*
- * env (the environment) is to be formatted like environ: "VAR=3DVALUE".
- * To unset an environment variable use just "VAR".
- */
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
-				 const char *const *env, const char *tr2_class);

 /**
  * Execute the given command, sending "in" to its stdin, and capturing it=
s
=2D-
2.38.1
