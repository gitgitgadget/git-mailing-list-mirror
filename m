Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C265CC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJ3Lxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Lxt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:53:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C6BE03
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130821; bh=bX0rHYHmphu/qealS7JFhJdLCrrcBuifUie9wQgq+G0=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=UUSDtp2v01Xt/AF1525VrB/594b0UUzgTetoSjLcLVqSFwBj70isjlUau1IkgB10U
         FneDDzxGvBX+tv9E7/kEDh/T7BFgT+kprtQDStj2Nrj8QPJgzrKDW3gQZcut9TYFJX
         nT+HEtjk+kNdG2HZ/G+0Ggnc75vyahsm1kq24kFC07NvcbRuHTJdyb31w3i3OLCMsz
         P8eonyU1MtylXmXbFKLhZIvpTXeGa0UCbtM9+FScUNL7aUllLnr72qkK6TJj7fxAlP
         AOYzr7nEcG5BmzCbCTKL2W823pwUMRrlqZmyc0eBvHmTxxnajnGW7w4j8uGICiUx84
         zz89AvgMVEQtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrft-1ofNR20Hjx-00RmBu; Sun, 30
 Oct 2022 12:53:41 +0100
Message-ID: <44d50eb3-210e-d946-625b-6df06898b629@web.de>
Date:   Sun, 30 Oct 2022 12:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 11/12] replace and remove run_command_v_opt_cd_env_tr2()
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
X-Provags-ID: V03:K1:+gU/MQZ+ZCXkMmnJlUj/W/kZV6Ttph2VIFug0EnxXmieVXeYoq/
 uLrkOA9ty3lqEoU6cqJIBKSRNpHrxZeLVGsponxsxuaMIjxhgF722MDLLnwTuSAE9V+xpBs
 jxKsfxtnpVH2bGKOVoB/xKHERpEPhxNuuO0NuVstNtCcyf8EgSsadrwjFHk0wqf0fAKZkTL
 HmgPLOAsAkiV94Hp8mn/A==
UI-OutboundReport: notjunk:1;M01:P0:/sxTnirqx2Y=;DQHMhHXeAu1XjaXweZ20m2yP//6
 QEojs2yX3xQuWqB4ZVG0Nif/vwIvqDe1AnSme7QnNDdBtuTtTaEYsh0GLIY+OoZeJ8Z3RW8yc
 mU5IZl8Sl9wyqqlri3/pLT+VsKcXYUyMuJmqKb71XYb0vTBBg63KWjk6XVKEVdTDj7AgBBpi2
 rk+IC4n3KngThygSBU1v9MsEO79+RJBDawotNqTvo1Ig7KG2XH/AJxvPLwqJ4/mMt4Hn+TbL8
 CtwU/JM7Yo+rN1WTIUEl41cQ4oh+yGuw43cvj/Jz1ZBm/Eja3DVvWWbXfIijp71TQEiyY25fq
 YIjT2m7s5rX70HVIxgpOOsNNDDlhCP3b7h/oAKj4AXwjlP4p1lgzMs5m9B5GBn6UNiV6970mc
 xuv8bODMuoFuNK6kDGDOkCCLkKilZC+/ls6RRnYwD+sdN4z2zQUeJwQttiNHw912io1MkdS5L
 xcbKtivNky4h45NSBIO7SovZY9Uu8/XWgydAb187/eZZALkuBY5FTfg6QzdNYnV1r3Mor4SHo
 k7AHcMdrd0ewrxYiwhPQxZwgfmssTuOf+McMNFZcWcowIFxlkKr5nUA2C+PRS5r61vQt5qmAN
 pD/vsEBRV6Yjj0L7NJv8wkzukJDhl5mKPm0Gv3SToYmNSj5TB5bE7Cou4XEEWmk4lWyE281p2
 L0SNFrBOnhaIWsYqYy1tCEq+79B7VgssaiQhaFBWYXgOaZhDNND1BcZ3sf/rm8Utya2MCv3L7
 cvSHcu1VIV/EKjjBN1JtGtm8h4hRTTctwR/Yo2Ay9iD6zBTizW3aeNaQr8fjwu0OF+eZsxJ0l
 8Zjct+ka0Czg+yvagREhRhfuK3eGzjDituVhlSndxuCUIahJvDWmCKpMSmPD8BCftpT+P9+eE
 qlRsNrMLiNXTTSCisV2AP3gk7PMoF7w7xa1zO9EEBhN/Mhy1kSsY60/IYAx9SCxeqDpEV2dyU
 VAXPRUdrBvIIc0tUZCfRTBkIQVs=
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
index 3a8d578f72..f8f810d755 100644
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
index ac67791c81..4391696bf0 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -233,23 +233,15 @@ int run_auto_maintenance(int quiet);
 #define RUN_CLOSE_OBJECT_STORE		(1<<7)

 /**
- * Convenience functions that encapsulate a sequence of
+ * Convenience function that encapsulates a sequence of
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
