Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2891FA3741
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiJ0Qiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiJ0Qit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:38:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C918708A
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888722; bh=2P13dpoQKpDKEfMy9keH6WbEiRmKq5S+PicwbVBHZuI=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=tEeT9udQTjcdE/hLLeswAyiYCyAb1ab50V+VDLH/Gxt+sXgLjvbCkWKwV0uFDhnrS
         p4OTISUJYmiGAPiXItX8Bj/vJFsI6BgYVkAaGqzZuDSDMpDab/OH0G/fR45ryZTs4n
         WWUJGOdAAqrzsRQZREyy42UE7ulpTgsj24sM1uX5XYrTcRgVWDoIVvMGbbarp2L2Vk
         +kQ3NA0k13tLdaUv0E4wd6HwDWU+cQd1vPB6QYJfDKqVIhayM90Twpcqr7TCr/Nai8
         uv22+O1OTENZG0gRBDYUtCJN9RGyb+fZEMi31qg9PCfRYPCwwyq9tdVES1z5mzs+5l
         pdE9jBv/F/1xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6b8s-1p8KWC0WQo-0180aq; Thu, 27
 Oct 2022 18:38:42 +0200
Message-ID: <e72a1abe-3098-e4fb-f064-a8b5c8f14239@web.de>
Date:   Thu, 27 Oct 2022 18:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 5/8] replace and remove run_command_v_opt_cd_env()
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
X-Provags-ID: V03:K1:HY2hWvk98oNy1Yk0JegJ09RtRDorP4yEoLR8gNYNS7jrR3+vSdA
 8zqXRZPcxeafl6kYDplZIiosC2L1xOWQmMbtcdfc8s7Sdm/ckzjfKdQpIabqyQLnrZABFlw
 QrcBXkqNanLRgAhNwhacioOeSMQpdpFgQDIZflept0d+KGS1Uunz847IfQJ5rR8o0uC8c8h
 HJAMwGKtrdySwiMNMu8mA==
UI-OutboundReport: notjunk:1;M01:P0:sVguxXUPKOw=;jmER3pH4j+zd/FgVEiw39sK3kxy
 0ctuV7ZmN217h7xW5jpTfpelxh2juv8F4bMYV/pb1h+FvQBPwyJwxTFeQytZz3eIR/oIKHEJH
 Vde1u5aRuALA5h7ot6CDBCPQoSwq1QcdYK2Kz/oIPL49UF9DXViLrnzuQWUU4thTgYlTSb8vk
 FsZNppBWbEdHvzy6//Gv5Trrj/8D48UGm7pLNBOuHEHg5vlTIGA//bRMpCQLTOx2t510iJYaA
 evDNSFuFIoHGqATbuToU9dKnDbEZmMvEG/8Ne/C4zpDPcz7rQ03NbRNnbHDlrRZjDuRwvFjjL
 fXMJLZ2NB6kIXfErkuqgj8Ebg2Hj8sGXte7QI8ZGnDerNoAGRPq9jyjp7IgkVyCQn3nXa9/7h
 TlICt/yVI0yyGfty9tcrKOGjx+ncZO98fXIlnEIGD4JYE1y26JwkJ36RIGT+T+6wqZIjRDUdN
 jj59EcAMS/XYw0uTrfvOk5X7HvQPJtoIhUZVbgFqE4CYlrgijy2DvoG7UiPNr5d1kFmxk3pGa
 c3BRz3ivtB4D4WAtFPRpUJVkfzyIp0GY0ShLAb+2qzavL8RgItsPsxNkSlSKtbi9rpKj+l/BN
 tNOsrrIbNPP0ZHYQdxeiKSoimWckTMFChx3N0tNdgoHMyfBxZMYC/vJc0E4toHIvOoch6fctw
 fXaPSckwFGEbA3PrvO8/rcu+SrFfHRGpQzSNEaGu40FwefuUZNBreZWV89unGTbS3DWOm6p3g
 mm60324xO5WoYvc58+UuV6QGyJBh834pfzya/r+nyLsPlhSCGGWLUGepkwyMwX2toQw3B8Ojw
 DqVvazvP/dCvWVrXkaQLTMSNolouQpq9dZ0Tq6g4XzX2+eBamjps4K+BxGi5yeMKOVLN4dZcK
 E1tFMf70EYOPgzNldwSKNcXY51gmrtTMAudnzXuk0yQ98gCeJV58becCdfdO1POwSFwoo11gW
 Gn5n1w49MVi/siZnOXBOXkq+5us=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

run_command_v_opt_cd_env() is only used in an example in a comment.  Use
the struct child_process member "env" and run_command() directly instead
and then remove the unused convenience function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 run-command.c | 7 +------
 run-command.h | 4 +---
 tmp-objdir.h  | 4 ++--
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5ec3a46dcc..1c9ed510f8 100644
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
index 0e85e5846a..a5e210fd1a 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -151,8 +151,7 @@ struct child_process {

 /**
  * The functions: child_process_init, start_command, finish_command,
- * run_command, run_command_v_opt, run_command_v_opt_cd_env, child_proces=
s_clear
- * do the following:
+ * run_command, run_command_v_opt, child_process_clear do the following:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnost=
ic
  *   is printed.
@@ -250,7 +249,6 @@ int run_command_v_opt_tr2(const char **argv, int opt, =
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
index 76efc7edee..615b188573 100644
=2D-- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -11,8 +11,8 @@
  * Example:
  *
  *	struct tmp_objdir *t =3D tmp_objdir_create("incoming");
- *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
- *	    !tmp_objdir_migrate(t))
+ *	strvec_pushv(&cmd.env, tmp_objdir_env(t));
+ *	if (!run_command(&cmd)) && !tmp_objdir_migrate(t))
  *		printf("success!\n");
  *	else
  *		die("failed...tmp_objdir will clean up for us");
=2D-
2.38.1
