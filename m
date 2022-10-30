Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD69FA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJ3Lwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJ3Lwt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:52:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26EC763
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130760; bh=jK6l5u0ox8IwbsczueR08s5F/LyA/aGjVHFSNfJ84Ms=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=i+UtU3g0M+LmZ0TfSmb0apVHZedgiP451+Xg4oUBJi43vWZ324uDOTacztbmGQehl
         KyW43X/bEgh9hTgtqsnFog05flaqVepCic87sxEkwcnLUWlQwogjzJzCOP87Ji/G9D
         zeOwmZumIL+X/hGOq8gLyyskynS3WswhePZxut2khGYpUlgVxrVCeBxF08uKmBBgpo
         HTa8wTo6MT236aSsky2H3gzLm5JetmdJGP8wEnJjaKkBjRAwgGeKrNix5Fgpesxsqb
         UNV0IUveCXPRzuZ5gpEccTY/dSzRTOkBA4ShvGOU3dJKU3rkQUZC363HIDrol9rSAQ
         e0WRpiiwj+yjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1pSHNq1wFm-00n8Eq; Sun, 30
 Oct 2022 12:52:40 +0100
Message-ID: <be37291d-d77d-611c-feed-b4a9c932f2d1@web.de>
Date:   Sun, 30 Oct 2022 12:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 10/12] replace and remove run_command_v_opt_tr2()
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
X-Provags-ID: V03:K1:J4Cowx5Ru9wQpYB41y4DpEb189aMlJr5EozG8zVtpUVKIpWiq1J
 jBYC5bRGp1JeK/Tpi6zS64URTEIr1QNf841bdcQg3F/LY3FwDhOGqfH38dujqAOREOOWrvO
 /dC0SWdM4kzoTFvP1Z2hS8Bru8jTwNSsEeQaJk9xIU8XtN7InxqnxBZR0O2yZCDJ4+I+/H1
 Ha8ED6r0BVGqIoRRkwfSg==
UI-OutboundReport: notjunk:1;M01:P0:7cAF4+GIyzE=;yxh1i+V3ht4N1lYaerR3HEPJlL6
 cfMhnLRtya73ZPrAnHdKTIF6gkwlDc5fnE44dNtjgJYFWjsfXsBnBr/fc7n9jL+TAAt8wGij9
 BKAAWX5zL8xolAwF3C1iztTErI05oHPQhRkWKmZ0LbEtGr/AAB2IQI0HryP7K9BBNpJcTIR2O
 owYvO8kfyxqz2fgjcTpFwTPQ2GX1LvJTceqkNr6z4WxbtTrEMogXlVWpN43QyNrKfScO45bBq
 FpbSpRKEmKRWkxLotDp1agB4PknoQOoPb278o+Vg/7g7JV3YxJyGpClFNjG50upg38lfNSSbm
 eXYTrVsUGTYivjBWCVeqO+WgFutu43Wcqqu3fsY24wC2sboBK097p7yQ6T5IcXK2YOHLfJ2tj
 ugFz+Oo1lF30/ufgVVScZsxIVdzzDmZ6wTGVJZIZv1FGX/z4a6mk/QXjFq+y2Q4Qak51wMHGx
 F1QNUn4pSky9yKaJ3capYoJaaOBz8zGOLYYyp0o88cqcUdpqzLliMFCjF+1L41Gm0i1s+WKKZ
 Alp+MuZgDu1o8/fXrfHjjHev6IoFEdc48BUXCdq7a3xfrseXoTX2rPgBTGz2YNmHTAvieAGfC
 U39Ur4Anr4JENh3Rh+Ncs8Y89zw4IA6tFj9Wx/QqexjF18IH+6JX/1fIgrQrnJzJdaqikzA79
 blrb7uMKawjlZADzP2ebpAmK4i5mLR22NeR57MV2QtkPCG95UBZSFYAYahmauCvNm8cbTLkHT
 uUubr5ngwCqGCbRw4YVNL0kp0L2F5ICo/0vfgYmctuR/TUIYUeZNl7TvY8ObovNHQAcsJyjfN
 T1Zei4aWpp2Ssxc+Vboz7y95BOajdw/At8gY6kln4QvhuD9QmC6BC4gnAENPD3SEVXXPZ231m
 HKbs7IqkEixiT5cSmS9Ek23mdTHpd1heLrMyL/hJS96hfYcD99hURS6ckdG/Cwk0ukS957LNj
 y24o9HPDS+G54KUuLMuhUlTRxXk=
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
index 954257abb5..3a8d578f72 100644
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
index 05c02485df..ac67791c81 100644
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
