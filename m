Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CBDC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4CB2073F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 09:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FGds6BTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfKZJGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:06:47 -0500
Received: from mout.web.de ([212.227.15.3]:60357 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfKZJGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 04:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574759199;
        bh=+AgQKlcJPEsq6M4xtLlR+Kja84sqkDYH0+sm9fpVj+Y=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=FGds6BTh4cUGyPl5KXpiQkQStBXGsi3I3sMAwT8B8yJ3q7FqeQHa2bl2voC7trnD5
         7JV31fM16cCFPZEsEpjNjLB3GX+yboHQgrSAwpM217XYOV51mCSepZsSJ+6/gwoGgt
         emk1+xRcdIvOQiq880/9WBFIGZzR3VQXJwPD59KY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrsGE-1hoXE90r4Y-013hIU; Tue, 26
 Nov 2019 10:06:39 +0100
To:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] run-command: use prepare_git_cmd() in prepare_cmd()
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <51662178-1002-2f69-fc96-20d603353c11@web.de>
Date:   Tue, 26 Nov 2019 10:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s6BExHdrtKpYy/zL4l4rTmsPiTglSVAdfNUEldBJudExk+Jjdmv
 1vcBKR2zttuZYKY3aMYbr9v7NJF4bxSaoPsiHfY8E97Uiv5SQ/5fEfgacXYK+cOAy8KuHIn
 g6FxIHd9PwKuK8wowOrPzH6T8RwCK6geZQGNHMIQNQN0t+d+E5oSuBE4yJFjYF91lErHIoe
 GROWX2J6GQ94XI2fjOHng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VhxcoqHx6J0=:ZTKsBtZ/9opibsUJUHAWpC
 hOuCEZ8rPgbhZPO/+nIgMk8LghCu+SIZAPdopL3w0ReaFkZ68nzs94Le7bNXqY/ImMqApHqep
 uHsLb/dCyDggmIsnv7xFy2nrWINXO5x8zg0OX3MhiiTsZt+NnULSdDAXRfG+nPTtwCPGm6Bhj
 hxJwlg4OnSikyfnzPclAW77cWiZc1LB/LdoQUiPNidJVHmd/dRzL+GzGXD+wPdvaLrpuX9jnn
 sYgv/IyAiSkOB8auj9rtnwQFw6WWeDNO9k663B/3pgDaeE69shfFaVsn9EL1+UWatxaVGYmNQ
 wyyErfZWtHzcvhLT5vPpDFdxWTJaeTA9xbV5E3qqpUgQWOIF6SCypZCWHfFj4Gbn5q2ENz3Fr
 lLmERFSlo1VIoTJ8ie7akGS1NWxgDLNZnQalLXv0gCLlfFEy9IEa+jjxunOeYeOyDkHbE3CzD
 aEqIjokT23ftH4vCWIn2WF5xh1a+ZvsfoWJD51GRg2yJQYUGpNgFEyJw4eGV6roct7W4X0syQ
 Fmu790t0irEio5QaopkqZPHEf2NucoxtMyWZe+fPcSxWuKss2aJ/MI6IhyAC63Sabc2BIEqOH
 a/Wek7BIXyG5eIZRSKXYYKox0nGXlNEghKFdpakEAU/Ih9VmPSHXQ/gqKLQkF8CmuMyiua3Ee
 Y9C7YhuXYRJKGn2o0w85Noi4oLgaYI2xplIMdcEIcTl0puMajZk4H7UV+emJzTuWy0jGiVewF
 Le+n7HO4EeDSBZInffigJnaNTl4VOC7B2OsFpBdjHzDL0gBueQHnG+mVEdcOBdvRYyKOqoO1K
 tawQ1HiVJ7Ymbl+PRcUn21XHBZBe9qRuQErlZwi/gS04W3gw8jMQp4o1m0r7hk6FHJ/McHNAL
 ch/fJV1hYAWnpjY0lqeePJXk3uXxWiYCMmJNRDIj+dTqXGPmlz9zBSf+56Uv8m2/7XgfZz1/r
 AONuPiRZtmofpLZc6NIbSqMqbUR7zKL105uMj66MgHsTaOAvikpOgEPsrjUvYUMBGFdcx+64r
 5HzRaUaD/JVLpYaGYiahno4GuaApNAzDNF5hfNeth/jUY2H+5VG9C6PkB5ouymYe9/snAaay7
 4q0reEmtd8OBLq1DmBSzQwRQQz8EfDFcHt2n3S+5IPGRkn3Kf6GAgw2rqYJUzkVha5Oi3XM8s
 Y6NoyhYPD2llLyhZ7jUSKWXw3a852IRyRxTRUAE1nViLgDPD4XJN7Ptrepoyqj11p7cEpBQni
 vC5DBUrI4j5YwHvK8gzSdG6jX5PmE6OLnNs+KdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call prepare_git_cmd() instead of open-coding it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 run-command.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3449db319b..9942f120a9 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -412,8 +412,7 @@ static int prepare_cmd(struct argv_array *out, const s=
truct child_process *cmd)
 	argv_array_push(out, SHELL_PATH);

 	if (cmd->git_cmd) {
-		argv_array_push(out, "git");
-		argv_array_pushv(out, cmd->argv);
+		prepare_git_cmd(out, cmd->argv);
 	} else if (cmd->use_shell) {
 		prepare_shell_cmd(out, cmd->argv);
 	} else {
=2D-
2.24.0
