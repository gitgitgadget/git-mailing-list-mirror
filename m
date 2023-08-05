Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED5BC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHEOwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHEOwt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:52:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642F4224
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691247162; x=1691851962; i=l.s.r@web.de;
 bh=Fhy5TETtvnwPALwdwUr9h0Y9IJ5VEykcHblc/XrfwkM=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=OwCFGM1t0y5tFpvpIxnIdv/3TdXyDk2uyeUkvj1+xBvJG+WIdWuyaXMbZ7Vtn51pYX2kuao
 yuyvyg0IMJ08OnjdFTf5zr7gBWkxrBLuZAOO4hpPuTXXm71PzP6MQA/4IGuJuvQFeX5FlGx1t
 Re4CundfWaVD+2LLGJDayQNd/qoctbu0igfswwbRXg/AjiQhl4md6yuO93ZBDcQlvdwp7fmwu
 CbrvAY0JmDPaW6x0V7G6sJjHSutqdEb/A1D7UNZr1kduSI0rSZhP746Xmk5xaJMUX8RrOQNun
 IcndeXu36gXDk3hcBKDRvNwoubGhbTvbmefUpONdvAYJWJwzZSrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9431-1pnNnB38vX-0165Ys; Sat, 05
 Aug 2023 16:52:42 +0200
Message-ID: <a3a93950-9a0c-d68c-a32a-06c83819d72b@web.de>
Date:   Sat, 5 Aug 2023 16:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 8/8] parse-options: simplify usage_padding()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
In-Reply-To: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xp6kkT0eUScakfRHKyvIJHF1r6B70THnHsnHSNEQIbfeWxEumJr
 E93i64E/uW78K8ZGHT5kSTLLGDMpZdgkSMOKFslcTgEgJ93UPxZ0T06R1x65qxtB+pAVkZZ
 5hjm4OAHOiVg1X7K3s6RTaINbsy8JmIjQN+ZPKqVyDpW3QeBbZLqTmcJmVmw7WZJii5hSqx
 YW7mG3HPmNuhCnDctamsw==
UI-OutboundReport: notjunk:1;M01:P0:6b3ljiP9AAM=;nfYtRW9uwr8ZeobxMbqcmNRO75+
 cwpPTN8RmFcoKilAw5pkZLout8QKimgBsPkkMNG1LcWA7XGUBZDEfnEq0J22aJixcR36XYTiu
 Z7+GND3UgKTAxFg3zINVDKCtz4BGwyB/0iZcLkbgTLafeqTs299oVU6IfHycJGjZ96TNQt5My
 0OcouWF9zjXLn7RP4L3CZyMQqQF9zKwrz1srIU3EDiaWqKBeGAj8nziRM42IgcciVWqLg3gCI
 LwvOFIGb+i0b0tVFlO3TvIt7ulhoD70bICZVvvM7S73IV2oTWVzjqN/Od3JVCsyd5GngLx+hG
 rENofUoGstYKFXOQTsJC+cU9iL2t/dy0Qij43ksqRn6xUzUm/aWsLu9UPkU2uE60JdUleF7Lo
 ldLtdNFXkanIHXB2P1keEW9v0Nyocdl0nTXaJpz9Qbty31b7Anp3PHL9MnYNg8dcsKSHn6gvY
 mcts6akqnSEk59vwnJ3YZAdad6jl2J0eLjGvlm90BItLQyGVhRhKc+u97vVV9HltT08dAl0aT
 mmhegPoKsB/jM2JUMswJ3oZlDEvyvYiuyG9AmCrO8NhSOD4h1BjTNjbSTcp9eYCLjgSuu5clc
 YGN1IbIFqsUf/u3sEGtGdnLNpV8dYQtKLSt05vy3n4dUa5SyEY9FAqz5qS7f44E42/yDPkKJ3
 piYz0F3GL7JADkTWTs5FWJXxzxnJTj44xqh+6MhDUvrE/Ek6Gir+ip6tvD9GQcxl9FXIg7NrS
 gLeKSpYddPcY2zxxqT0nejI0CyCipEunFbRE47pxtegWb+YK9w3bNq6j2hhnoXguPRPM96cOC
 tN92tI4eC0+3n4NcnzRfii0+RuL4ImaZ38YJHCRuUNDKoyck6FA4MUDUoNCqmwxznJM1jh2YM
 1C17Clf8tCZLpUFXq9m1qUxYL1tzR3uDxbcpH5oot7rqx7FgN3jWq0OBRNj2zF6zUFtI3iUbI
 AkI0XJndJXyVP1Q5bTYwYSkHhqg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c512643e67 (short help: allow a gap smaller than USAGE_GAP, 2023-07-18)
effectively did away with the two-space gap between options and their
description; one space is enough now.  Incorporate USAGE_GAP into
USAGE_OPTS_WIDTH, merge the two cases with enough space on the line and
incorporate the newline into the format for the remaining case.  The
output remains the same.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Removed an extra empty line added mid-submission, so the cover letter
stats are off by one.

 parse-options.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4a8d380ceb..b00d868816 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -1025,21 +1025,14 @@ static int usage_indent(FILE *outfile)
 	return fprintf(outfile, "    ");
 }

-#define USAGE_OPTS_WIDTH 24
-#define USAGE_GAP         2
+#define USAGE_OPTS_WIDTH 26

 static void usage_padding(FILE *outfile, size_t pos)
 {
-	int pad;
-	if (pos =3D=3D USAGE_OPTS_WIDTH + 1)
-		pad =3D -1;
-	else if (pos <=3D USAGE_OPTS_WIDTH)
-		pad =3D USAGE_OPTS_WIDTH - pos;
-	else {
-		fputc('\n', outfile);
-		pad =3D USAGE_OPTS_WIDTH;
-	}
-	fprintf(outfile, "%*s", pad + USAGE_GAP, "");
+	if (pos < USAGE_OPTS_WIDTH)
+		fprintf(outfile, "%*s", USAGE_OPTS_WIDTH - (int)pos, "");
+	else
+		fprintf(outfile, "\n%*s", USAGE_OPTS_WIDTH, "");
 }

 static const struct option *find_option_by_long_name(const struct option =
*opts,
=2D-
2.41.0
