Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A119BECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiJ0Qjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiJ0Qjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:39:45 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77E13E16
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888769; bh=n99LfgTxiuToT6Jg+NLMc59z8PevqBP9I8mq7sUc6+g=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=sSp6wpkcV+7O+Fp1LJ4nc2Q0NeqKCnw23qMDx3xZATGVJEBfSg7B/KA57q0iqALQS
         hhOBYk+YRp4vCDTHFNT738tZetE3FbX1NDTMOHwVfwmyirGcpaVELXOpJ8JbXVUz87
         /kJfIfGX/aV86No1jevBVuEifefoLbk6cUVD89vtE0mm6C5vHI5ZWRErNeMJ4eZzyr
         rqWdCdBZaGVOlo8yk4Wr6tB7Kc6eJpt9cThtpIJr60LXefY1hrofKriJ77ZMTDft1X
         ersIuC13FqPvaAwejNKRiaMgR7Jw/lTVMRpx6EuxBA2WG99jpuXtwiCBQ0t6tS+rQy
         +3YYvGokFGEJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1pJHny45qA-00fOco; Thu, 27
 Oct 2022 18:39:29 +0200
Message-ID: <65f44b18-b23e-5d1a-2b57-6d326c05f4f5@web.de>
Date:   Thu, 27 Oct 2022 18:39:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 6/8] replace and remove run_command_v_opt_tr2()
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
X-Provags-ID: V03:K1:TlMGAgyz+fiLt2NYEq2f5YGd4Rp3e0DPe76SjmYzjGa2n98TGKg
 NouRRzZeJnk7wi3GBubGrUcjxrAfmZu52vXKoivmcz42THMI4u8c1IvyX8joleTBqdhSzBp
 aDDAcVyQgk2SWmFRcikolitM9JbBIX2qQGUio2iCnpaSwXZSMyrjqYA1CqdEazuXILJhANC
 o6h/El41o1E7VL3tjg3kA==
UI-OutboundReport: notjunk:1;M01:P0:4Zoy7+Q3E7c=;sACHpEts4IttCjJLOrHcLC1FH98
 ysebyx2jF4Rv7GtZUBvM17XqmZM80L/q1byv4wccMoAE7eiPSE2LvRbCDix3exQst9o+OzR3I
 pu/lG2SV4KJ7fs+NXT6VGlwsuoqMq5Dx4CQ1N1mE9k5yX9J4rjtDlf6+/S4TI9FArPOfPAPAN
 EQ0sOI72w+1RGXP48+T9hhTHIzZMuC9owyb4OPUrYPlM2D8+eASA7nXYmH+GgFRNzkUvh0Qs+
 43xHKlxve9R53OifF5TL00Reml29LXurJjlf3phhdX53DdFf2mJF46sCU+O45kwLK8tqiLl02
 G5Hqza60+epZCFZYBSjbG/MVCxMFJDtR9RAVZ5wsQQPbSKOii/ZMn+3cxMPdH/vsVhYQWN6uz
 xRizcsXjqGFgxuU2qdnvHW0+3GIFR+ZB7Q/YvcA5lM2PbbTNQWarzjjaCVAeZM8MaO6d7H6By
 BFRUtd47OJHdMcijR1WiUx5oRieGqppDngKIUokCv5O7YtBmL9bGmbMekLUuiXnQPXqaOt7o9
 aggufYjuaCFEKgu9QMrcHETRXFmzEXBL7sWbMw/HgGbcO/ZYxki/uvxfJQ00Fn5lOpQh40AKg
 Yj8Ma51MeID7u4TxEoxsGnCEL8by7v8nCms1ArWPNi7r2oyXrvOtaluMZ05f6zW3cWy89iQwP
 xQHwGBKSfG9p8xRlTvksjGXfRsgMfyan9lblKizhCRJMQ0CA2NHAj0j7UX5WrH1csdILcffL5
 JDyjORqlYDFn2GzdMtjjDki79MSyknA+2fIObrdNB0ieKgRE7m6aJYcZ0hUTi2vxjbe6jUq0z
 XsJdSWRa7GcXNS9/tjvDr7A9f+UMYv1ytk4qTJP9Ptn0+QsncDdkoZSaeprt6nq8PEnq7fZ6j
 QrRfkEzBdqBYXWRDHEvRRRSXxABQlQSI000bJtW/awfxdijayhZpxRO7FUW9V6YAPl+GnQMrC
 /ZeDzq3NlLvF//QcWGUVUP7qdMY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The convenience function run_command_v_opt_tr2() is only used by a
single caller.  Use struct child_process and run_command() directly
instead and remove the underused function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 fsmonitor-ipc.c | 10 +++++++---
 run-command.c   |  5 -----
 run-command.h   |  1 -
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index c0f42301c8..19d772f0f3 100644
=2D-- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -54,10 +54,14 @@ enum ipc_active_state fsmonitor_ipc__get_state(void)

 static int spawn_daemon(void)
 {
-	const char *args[] =3D { "fsmonitor--daemon", "start", NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
-				    "fsmonitor");
+	cmd.git_cmd =3D 1;
+	cmd.no_stdin =3D 1;
+	cmd.trace2_child_class =3D "fsmonitor";
+	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
+
+	return run_command(&cmd);
 }

 int fsmonitor_ipc__send_query(const char *since_token,
diff --git a/run-command.c b/run-command.c
index 1c9ed510f8..32fa4b0ed6 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -1009,11 +1009,6 @@ int run_command_v_opt(const char **argv, int opt)
 	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
 }

-int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_cla=
ss)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
-}
-
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
 				 const char *const *env, const char *tr2_class)
 {
diff --git a/run-command.h b/run-command.h
index a5e210fd1a..482da7f60c 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -244,7 +244,6 @@ int run_auto_maintenance(int quiet);
  * corresponds to the member .env.
  */
 int run_command_v_opt(const char **argv, int opt);
-int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_cla=
ss);
 /*
  * env (the environment) is to be formatted like environ: "VAR=3DVALUE".
  * To unset an environment variable use just "VAR".
=2D-
2.38.1
