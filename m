Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C89CC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjEIAoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEIAoM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:44:12 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FFF59EE
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:44:11 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-54cbb666aa5so2759025eaf.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683593050; x=1686185050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeTtSvLWvKq63jLFgDFyDhx6WIlw4bVy6Kht1V0/E5s=;
        b=fWNCLr1DOD+eHkUpU7zUXbHVt1AaMmgTxlc9lLjjB14X1T9Oubjjcvzg68K2lF6gJP
         Nbif2+YCv6KHtrbtNeC/pMP+8R5fY2jPhQtFfhNb9uLKvW+x21Vt7JJT3UPaza8SCtmh
         871iZO6hlZgawYR5uJnm95J93rUQLPRXYKLtPP6fbCK88QTHEr1u4Dbt2olxX9Z1iWp1
         hF5M566blK+aKRdA37U4l1CiNfw9+0AqVKujZ6jWzkdexTzwuf491UFTi9QsQocvICnS
         /EuAAVZT0AXSrEEz34BsZR2oRD5e+thSGbvEGGq5hTpF0B5WXsVgXJPndaLJ12sXgAPq
         AwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593050; x=1686185050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeTtSvLWvKq63jLFgDFyDhx6WIlw4bVy6Kht1V0/E5s=;
        b=R8ZMe7G3r++NT1v2+LynYlmjQ9MFp++4KDrOU7Uoeok/IKf1Ve02Hq94x+4IigsKyq
         w0CkX1NNkmxuqm4NKg8OsQQ/XQom+l64jFguGZdZN/u/yF63jBwPp90pmcxKYlPmTMj9
         W1wgIB4868TPEZfWOVUzMEXNvsc/lUdxKQpu0rRlkMiQLuuK+PPzOePll6SS+u5GiDsq
         1f2BmM2BGoiwdps9f4JcuotX8kCeiyalIzgh2DKpLkV5OrVNBs66+2kTeGj1GlpOESev
         LDVpnGHkcIkqZqFVD/Zp6V0alF7Y6S4kUoEHytNFe0QupY60dNSOTDV+gHfk4hKoLV9u
         5g8Q==
X-Gm-Message-State: AC+VfDyZU3em/OFJh0rL1kZsJrtAbcwgj9gImODJpepbvDAyVjmubqTR
        a9Vq8dRKWGT2dlxCwkeEJDnrLZ5+SEo=
X-Google-Smtp-Source: ACHHUZ643xk0qHhs+x4hdLErSUwG5/9w9etH6Izf7BFImZywp1wzZW61uzcMtNB+T3W9/ay9fJNBaQ==
X-Received: by 2002:a4a:9c4d:0:b0:54f:629a:f581 with SMTP id c13-20020a4a9c4d000000b0054f629af581mr393633ook.7.1683593050082;
        Mon, 08 May 2023 17:44:10 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f17-20020a9d5e91000000b006a647f65d03sm4836564otl.41.2023.05.08.17.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:44:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 2/4] line-log: set patch format explicitly by default
Date:   Mon,  8 May 2023 18:44:04 -0600
Message-Id: <20230509004406.1786033-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230509004406.1786033-1-felipe.contreras@gmail.com>
References: <20230509004406.1786033-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will help further changes.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c | 5 +++++
 line-log.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4f162ff4d0..568207916b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -889,6 +889,11 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	opt.revarg_opt = REVARG_COMMITTISH;
 	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+
+	if (!rev.diffopt.output_format)
+		if (rev.line_level_traverse)
+			rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+
 	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
diff --git a/line-log.c b/line-log.c
index 10c19daec4..4499fd0c59 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1140,7 +1140,7 @@ int line_log_print(struct rev_info *rev, struct commit *commit)
 {
 
 	show_log(rev);
-	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
+	if (rev->diffopt.output_format & DIFF_FORMAT_PATCH) {
 		struct line_log_data *range = lookup_line_range(rev, commit);
 		dump_diff_hacky(rev, range);
 	}
-- 
2.40.0+fc1

