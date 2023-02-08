Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F2C636D6
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBHTVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBHTVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:21:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC756498
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:21:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p9so7717928ejj.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD/udz68tVw54g+vFm4Vjo0YIwfa9GkUBWib6qtPmWM=;
        b=CZDAw/JlObEnvek94VsmcKGNcixIbnQOxiV/5QSIAkEY/1bl/xUAgjTzL3pfIS67Ah
         No0y2xXqHLWlsx2YPV1ryjfUB33G8MpbmTP6xvooYOK34Mu57ySQtmRF04PuTHidgmre
         ANAiaI49jWWxELiz4lMoD8/I8hsaJN1WGqBZ/XmnMw9ygKG9/6U3er630F9rt7mMhiKo
         FIeHRP0+bJMKgTR3p1aemUgI7VbHavl4h/pwXaE8gv8Yi8o6AHFZJ7I5sWfrG2E53KN5
         HNhkvhgkOnz/pEDfVmeMEngrSBuiXmIhKpmnlUTck3Z7R7j/lujFIS0JqfdEHyRHDIRd
         /V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD/udz68tVw54g+vFm4Vjo0YIwfa9GkUBWib6qtPmWM=;
        b=7Hs8CCiSVWfmNRwtFr8QzyLmlaHJjNnmVFAaIATeFajpKOIv/yvqwt971ggKNfPM9w
         8Y9htdr6wW03D3FOkiS5FAT+CikwYFa7RwmZ+4u89VHPaYfekuandFRQ026XhFgNzPaW
         mVzqLFDTttVGj+S5vDuwABzACQ23754ZF2ldluAQzp7hcllVntqhPZElzsMy33fszxJW
         56lE8cVPxciH1hvp0bWVIOaecWqnXCFiRubJLZRh08++5xoAllrPn4dhD67IqZEvEJz5
         QcEDkuNJ9UfHjJSFhlg/8oimckeghb4APZZCTL/t2VoGrgpF96wtoN2Pgp6Xx+VSYFXt
         nBbQ==
X-Gm-Message-State: AO0yUKUWVG/Siex1azr0utUicjKwIy0WuX9gIzgKZnUBKg7Oe89GVQi3
        TmPTRSceYsl161zLbLcza3EA1MW+9TqKx8jC
X-Google-Smtp-Source: AK7set8o8Uj9G6xSeoJIk9h+RvS1Z2FlTDbIe+AHIEdPaqIpLJJrX3fjvVABDo5jA2ejxYrOQhH7lQ==
X-Received: by 2002:a17:906:db0d:b0:878:61d8:d7c2 with SMTP id xj13-20020a170906db0d00b0087861d8d7c2mr12424162ejb.39.1675884094165;
        Wed, 08 Feb 2023 11:21:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm6244227ejh.155.2023.02.08.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:21:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] run-command.c: remove dead assignment in while-loop
Date:   Wed,  8 Feb 2023 20:21:11 +0100
Message-Id: <patch-v2-1.5-488b24e1c98-20230208T191924Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that's been unused since it was added in
c553c72eed6 (run-command: add an asynchronous parallel child
processor, 2015-12-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 50cc011654e..b439c7974ca 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1632,9 +1632,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 			     const struct run_process_parallel_opts *opts,
 			     int output_timeout)
 {
-	int i;
-
-	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
+	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp, opts);
-- 
2.39.1.1475.gc2542cdc5ef

