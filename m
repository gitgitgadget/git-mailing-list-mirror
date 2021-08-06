Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C3C432BE
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA7361102
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbhHFMCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbhHFMCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AFC061799
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so22469900pjs.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bC3LVEeg6ZqTUnpofrbrencrwjSmmnhJTnEsJIT6aqw=;
        b=CfVB7XKheD96RmFTE3He/PnutHr/G/TNeoslxE3YUfEOPPDvp4DyjnNkO3mxRM4ctb
         R5Hil5WO5KiFHy8HZQ+LmMwkkO10nurTGgadUYd/kF17AM5jTq0FSstf/oPIL7yafmUn
         GzyUVkkwafRGhsfvbu/YCUpOY4zo7Exjoos7ukCSWBVQaKJNmBpBSffmb+PRtHohVkZP
         qBkyA2A+Cx75EtpyEAeDRIIKFYZYEnTmUKpB46QGGXElw4dNQ/G14euty4e5lFpq6RW3
         vjBMv6PAHIiNgCZ2lRH0PT+oen9NrtuoClkrhqXjplGdsQ1vrSs7iKga/8X20XLzVRtZ
         JhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bC3LVEeg6ZqTUnpofrbrencrwjSmmnhJTnEsJIT6aqw=;
        b=XlkujAH8vlhG6cWlyNdQzzwLlPwNzapkurn5zE97Q8UMyAqbbW02BJ/ynLOkg1M6Md
         TLlG0eu0vlO/PXOlOLJXYvKOnhcAVuL5O4F7hrm/XGFYaApd2qQzlRNTDGU38MRDhNR9
         yBK1NSX0VHS6DCNbW6p0HUKMJulPnyVpKB7tfxZpO4avFRL16s0G/hddDrX7RoACpF0C
         Pe0Pw7l692rImGLHHbGTHsyXI5+LD3fJD9IWGBw+aDTubZC/HEORpx3arOj+8rtlSII5
         VCVw4tfhVzqsg2Mo32skpkT4rrfxk9U+s5uplSAMg5RipHhRVdCL6uybokOtCGlwnl2l
         CqVA==
X-Gm-Message-State: AOAM533CTKeS0CP+d3ib+q8t4Jf69bZef/QeMhy3k6+sXSrpA0vZzMzS
        nmJkvQFQlQWd1UukvVNAdDc=
X-Google-Smtp-Source: ABdhPJxK2C61iVqDOwBv+i98Bcr4BGcSZ8jqFqQZ6+ktWaZXQNIkEjso5nrzmdZiQ8HqekskowKIIg==
X-Received: by 2002:a17:902:f253:b029:12c:438a:fa7b with SMTP id j19-20020a170902f253b029012c438afa7bmr8406489plc.22.1628251340493;
        Fri, 06 Aug 2021 05:02:20 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:20 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 3/8] submodule--helper: remove repeated code in sync_submodule()
Date:   Fri,  6 Aug 2021 17:31:42 +0530
Message-Id: <20210806120147.73349-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This part of `sync_submodule()` is doing the same thing that
`compute_submodule_clone_url()` is doing. Let's reuse that helper here.

Note that this change adds a small overhead where we allocate and free
the 'remote' twice, but that is a small price to pay for the higher
level of abstraction we get.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4b496bac6..9b676c12f8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
-			char *remote_url, *up_path;
-			char *remote = get_default_remote();
-			strbuf_addf(&sb, "remote.%s.url", remote);
-
-			if (git_config_get_string(sb.buf, &remote_url))
-				remote_url = xgetcwd();
-
-			up_path = get_up_path(path);
-			sub_origin_url = relative_url(remote_url, sub->url, up_path);
-			super_config_url = relative_url(remote_url, sub->url, NULL);
-
-			free(remote);
+			char *up_path = get_up_path(path);
+			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
+			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
 			free(up_path);
-			free(remote_url);
 		} else {
 			sub_origin_url = xstrdup(sub->url);
 			super_config_url = xstrdup(sub->url);
-- 
2.32.0

