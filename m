Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD3D202A7
	for <e@80x24.org>; Sat,  1 Jul 2017 09:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdGAJKf (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 05:10:35 -0400
Received: from mout.web.de ([212.227.15.3]:50120 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbdGAJKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 05:10:34 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfHUw-1d6q1m45xS-00Omdt; Sat, 01
 Jul 2017 11:10:29 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] apply: use starts_with() in gitdiff_verify_name()
Message-ID: <185fd8c0-e0bf-2522-77e3-3f9fce8a5d44@web.de>
Date:   Sat, 1 Jul 2017 11:10:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Uqx8rPIfwxcPJGTA3yQ4iMZV2TV0QwhRG3YjYOhh9JQGLXE2OgH
 soQxbU4z1zttNmayO9F3f3qer2mp6+MJaDE7JoWYAGDSCGa1vqNrA5M9kIQEZlSSyLmOm90
 zgO+jKvV5rf6XKvd6/o8k+NSlvFVDR+mgkUHZIy5VbwlqGF+nuzUaoK86/ViN+eVGw6FlgP
 oh1zuSeTkX01tsJd+Z8Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9sRLXvPZ7II=:hGdxFAPqnF37BiGLTU0qlJ
 +VqMTbne1QKaV7/W4P4u+YMHXJso1gRUySzruhcW80WWkq0ofhYsN/ivrj+1AHxB7ftiedJhf
 pfi2bYF3d3LrOcyYCXcHZmlK6wTpw2m80cYRIA7y0ZVZRG4MFUPFhxcJPhM4xwB5IXAtnF0+1
 FCctyvsEDaqOSf8wKLIZW+PrHwcBmt3VZc6DjhjlWKw9FeD/BgjfigxyzeDxk1djyjQzxlko4
 cB2A5NKshvJWBWjBzZYAlTCiUTEzc3LeXv2+O+1GKVvbuTz7OCngm0ZKTArWbYvIi4iYGS6C1
 H7KzRxHtD4RLl3Zlxp+yFQDnqOpDVIcOC4xsBzMGLVOr6+HNAKhj4gq8c0VDVytjwH2fXdZsb
 NvaumSAgndAUCAjAYeebKe0Cvwz0ei5oLzco9nsrqVGBEXpDFvOk0ZHTjCOUfySgyqsGhbHog
 R2sI7gyL+5LNYsXLq9FyznScosmKp4ztcwNxU4Uoou2PrM7Fp/+TxIspTnzRdlCScHEHoB5OG
 BusHuJHFfezdSRQnT5Ff5lB6da+jaz/uEBSbI6EMueGSrb5SepZ5PBW2RvAFypc2kwcn8GM+q
 ytb0rzbkQRi1tm9xJqrjgaHsc1zi4rM/HvRnuDMcSXxy5Tui0qxaX8OxXP2dyH0pAoSH8AWcJ
 jNJnftEmZOIoMZJHHw6ITKujKyjZe6dVjLwkq5eICMKtlqU7nIc6L1S56Fxx+wOP84ReFtuLe
 s4nk46t2xeNVw7Lqx/37lRikeV+si9VJm6EdvwFF2Xa6dKIET6gSY4AShVpy5MYrZh9FMkHtv
 thvZAsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid running over the end of line -- a C string whose length is not
known to this function -- by using starts_with() instead of memcmp(3)
for checking if it starts with "/dev/null".  Also simply include the
newline in the string constant to compare against.  Drop a comment that
just states the obvious.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index c442b89328..946be4d2f5 100644
--- a/apply.c
+++ b/apply.c
@@ -976,8 +976,7 @@ static int gitdiff_verify_name(struct apply_state *state,
 		}
 		free(another);
 	} else {
-		/* expect "/dev/null" */
-		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
+		if (!starts_with(line, "/dev/null\n"))
 			return error(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 	}
 
-- 
2.13.2
