Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD52FA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ3Ltr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Ltq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:49:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41AB852
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130578; bh=3mOJrWY80LHqXpkDaeJlVPJZQfdngJVNQB8xErYRF/k=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=B6IJRXvu1sBXfZWnXh985M79SpZNzItszlBs2UIl52v/B1uUHHwD+v/bojk1V+Ub3
         CoWrhXdtG6vX3siRyVkR6ElA8j7JFgzKmrvKWmvkrOkdixt9NXJzZxvgRHuRv3tTiu
         xeYWto4EJOvXHHSYdh6WBibYZUSpcOQQMZgejk/ezWQr+PDi8nkIpL8mzTUUzWW5Am
         0udJIHSZDKKv90oBLq2ew6ztn1ngb6y1JXLxPbRXiTOzYi0wuZrQp5c6QKbGAN2euH
         fg3mEwf20XbrR/8D4QGcFm3wLB0XWlT44RcYEXnmBA7sXeKRWahGUsM73+GgIFuKwb
         mXTTo/My365IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1oRgNZ0cqd-00O0Ef; Sun, 30
 Oct 2022 12:49:38 +0100
Message-ID: <3ba55be2-c0f7-77e6-1b40-323786ccc2bb@web.de>
Date:   Sun, 30 Oct 2022 12:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 06/12] sequencer: simplify building argument list in
 do_exec()
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
X-Provags-ID: V03:K1:zW5fwTCLN+SxDYlIN2V6TDVm1Y620gutSPHu/unEQ9H+y+m4RmT
 wKsBuzJ1B0QB/gqgs72q2fmrbC6NFfh8/m3ExZk/7nhPuDQA4PyP0qM0bh9EUxjPNrj9Eru
 sVQeVY6OfNonlXXNtXxTL2U1TgRyetoqrCBuCcaVn7x8zxQXAg5SzAs2UupiMys7R2o0367
 4Q3J8CpHUP6RZ1b0dh1gw==
UI-OutboundReport: notjunk:1;M01:P0:BJ0OXUDRlu8=;fy0EurksraJ+0Zc+UZzgQrNniD+
 Fn4jxPWtjdukSt5lqP2f2jgzNHYG/TwGSshgF5c6mWJ+3oY9gmwpZz+jmMOXEwr1Cqt9zlq3w
 V5F4JAIDOlK7EDvySorD+26U5EqIlsjHQTnelAFD9kT39Mf7G52n0Uj1blXU87jbCGNd/8P4+
 1IZDlA1a3IhD2qRxaCAQlxmWjLIwQ7L4BM5hoQ/XlTwNodtqnlFHD5fqoNYN8Psm+Dp2q+Pnp
 cv7YDKeBb/ZinkVr3pdK+RQIE9Uvr9WaqtoSXezbXMkqN8pvD8aj/949w7AxOvUfurNBKnFBB
 hugruVwgy50D7HDWvaXjglmFtR0/8jjrag6UTJ1ReYwDS4kJl/lHrvwtW0PMfZxtsDikc3+xJ
 geflRB/T0FICxeOprKLg2sQ7LQJCksndbo5mMtvAMKtatOTKB8wcTDeMN+4wsYUZUjmK+Eo05
 JA0IOG4Tzk/jPzUXr4K63WUZiUYe0Twa3OhXfBOtdbbwKHxp7MNxUUFV4hfi6QPn94Ynvo6mz
 5LXkbyzxHHwwAnrjAp4WY+EFR/Yk8/eh/xtMcLYwdTA2PmbtLX/x1Z827AbDGzmcR893PGD8/
 NmhcfPZ5moCQ5YAqv+0ymLGFFzG1PNaGpkbLAA8iraIjobOSz3GaldiL9BHwtgeoAElmtyPeq
 +unq3TSFhVgYRA4Q1VTIHtrCo/pyT2dFj/OZqfti9ffLZWq2D6vOO7AMH50QCjio3tylu7THU
 ZyK70wThPjnS2D0ccuuXckYJxU9UMvK9OsQOQNq68p70bAm+DqEEOyL3sU/ui7SxGSmPQOMaR
 SQST40aJ30Guzd8DZ9yW/DcKHUTNg48oMpwSRAxkLezdzGDf70GZ+vVjnH+6d0aDu+HKBKUav
 W9fN+xE5scR19xsdqP8thd0MTKyhiHGEeYv2wCFuvZfRX0FCYK12u4y3LWhrQc+ow7WO9WdcW
 0WzB/LwJkTTUvn1rAbwqpxTPTs4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build child_argv during initialization, taking advantage of the C99
support for initialization expressions that are not compile time
constants.  This avoids the use of a magic index constant and is shorter
and simpler.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 sequencer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index debb2ecbaf..66eedd2c76 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -3558,11 +3558,10 @@ static int error_failed_squash(struct repository *=
r,

 static int do_exec(struct repository *r, const char *command_line)
 {
-	const char *child_argv[] =3D { NULL, NULL };
+	const char *child_argv[] =3D { command_line, NULL };
 	int dirty, status;

 	fprintf(stderr, _("Executing: %s\n"), command_line);
-	child_argv[0] =3D command_line;
 	status =3D run_command_v_opt(child_argv, RUN_USING_SHELL);

 	/* force re-reading of the cache */
=2D-
2.38.1
