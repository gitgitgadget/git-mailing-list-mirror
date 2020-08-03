Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A130C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39231207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xfbjt72b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHCS5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4776C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so29035093qtg.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtctLu256av06ik5IHDWiQKbEbZ8S9fTFgXOJvN+Mvg=;
        b=xfbjt72bw5MiqOKOa5MS7i2Ij1d6H07p5WHmdlZFWJErt6oaaXhVaozbeCGOsPuArC
         Di9GTr89Dk77JB/5eJb2YfvI+2sepip8frny3UVApjAnXNnk3CenpOW2lxCrLQjILVpt
         nObePyx3DJUdkltCY3wXezoXgyRRvH4vjlUPQZyUOJV0Zg6hw8w2D7ERSoqM0XRmsHET
         kQCu2TJBxVO54fo0Szg56fv3LOHJQNuUC/zYg3WLhfJww+zrIuFzBhFcQr0NF+6hqPBk
         /WGruTbehtdq4q/M59T2GSZV3j8BkjUMKiisGkA2s5dffktc39eLgknJ1q2ItzwHiz8U
         QuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtctLu256av06ik5IHDWiQKbEbZ8S9fTFgXOJvN+Mvg=;
        b=tfKIY6Spk4QZ3AyavHJJGwCotzwI3CfmvTrK6/Un5swtuHFtmiS2ApTtrNcLJctW6u
         nlhkmFCl18eDwOjKr+JGec31BqklTQSo5NGR1Teqg3qHKLqAXVbsLlciHJ8jiePsMpWD
         4jLH2+p9Qpt9ArIU1RC+k4WoU99Hakd6mLDs5Gf2Ojy8IsO4OK/QKQ2RyOMw9xDdyLm7
         gGmXOvbwsPY9HH/Ej2DwC2lRnuG1vdmRRuBS6iGxPdwOEj4oQTQl5IKD2d1334hrAnkx
         zuOHiH818avOry5B05eS6IQ1baOMgdeeN4icP9D4TQ3rd9sdYqHB1LBXgP5pnJMtVcVh
         +81g==
X-Gm-Message-State: AOAM5334/uxb9PdAerVgYCSM32IbwGDq+sWf+T5IL59edF6kZV+fOqA6
        iQ4Eyc5zzKOUOflYCjkrYkqnlYPwOyX1vw==
X-Google-Smtp-Source: ABdhPJyIvzyDxOz4uylLYl2JUiBkbbCzEYmXXIhEto3kc9KDzePgF+abbCbeYnIlM+loTSrINnyBMg==
X-Received: by 2002:aed:2a82:: with SMTP id t2mr18012654qtd.280.1596481043747;
        Mon, 03 Aug 2020 11:57:23 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id k24sm22986844qtb.26.2020.08.03.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:23 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 04/10] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <42a0ca9549090c879d5c4d9cb53732d8dc4f0ef5.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read-graph test-tool is used by a number of the commit-graph test to
assert various properties about a commit-graph. Previously, this program
never ran 'prepare_repo_settings()'. There was no need to do so, since
none of the commit-graph machinery is affected by the repo settings.

In the next patch, the commit-graph machinery's behavior will become
dependent on the repo settings, and so loading them before running the
rest of the test tool is critical.

As such, teach the test tool to call 'prepare_repo_settings()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..5f585a1725 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
+	prepare_repo_settings(the_repository);
+
 	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
-- 
2.28.0.rc1.13.ge78abce653

