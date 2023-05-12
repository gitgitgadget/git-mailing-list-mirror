Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467CC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjELIDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbjELIDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:43 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1CF2D46
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-392116ae103so4946842b6e.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878621; x=1686470621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNDdc/JH/4Jq+Ldo4fv8pu7IHguxkA5oDJjQTKV9K+s=;
        b=Z9r+BiSeHTWBskKUWv83ItRSwW8lJCIp+vTsOX84xJgyDoOf5T7yNQVJ1NFklv2rta
         U2QqZDz0Tu7rfrNKplukDPnBORmcWpCMfE181zRhjMUvyjdH6ivXkn2rfqFLZBdXT5Tx
         vNoz/jdKuQayRdYhy4SCMop3WBpFQJxMPhC38UFCN4UlX6HL4WblyshLVXziVa9MnUTJ
         QcqDCmkWDtk2nzStAN2OkVz0+nuarBKzlhvcX+67CkfOuSvzY1m2UnwxL4NfvMD4HCxU
         lxLxdZUaDs4KtEnp1tQKWQ9mwwB5JyO0bL5uMhhvRq4dYkMBRpfv3RPk7+XW26Ac8yBD
         z7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878621; x=1686470621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNDdc/JH/4Jq+Ldo4fv8pu7IHguxkA5oDJjQTKV9K+s=;
        b=PqMU01yz1QoG66BaV32+1qO0NEH4ClZZLGkCSP4waYe4HnMy0l0/d3rIa3VrQBNYhV
         JPzC3qOvAEu0P8fHtgXNbW0UgiLc5tzPfF6ZrlBLghR2AP+kh+c418gX49l76Jb8ygm5
         2vIJdA0DBXSHoi4n3S9EuKnwLDlkFVdiBPoURrEIuKpQvepR0gV8Rn+5Jryi2K904yrl
         RS66BWqU9ntdyVtPFOEuz76qUSNL+v/OG6E/NLCpGJ2Xv+fFRsOypzpcqN48ZgEVPAtz
         sgYEGFtLsns+2lVTMKucARaSjwh7PA9W/+4unqgnyn71hGCEi2H7n/nhMCbqw5HgJPcY
         49eQ==
X-Gm-Message-State: AC+VfDwOGMkdJ+hPpOBmOcFXj28kIxdoBwHK0G/bTJVBch5O7v5zECJ+
        vDnBWaa3cn5pDacKYr+daW3Af/6BHS8=
X-Google-Smtp-Source: ACHHUZ4/C6dap/Z1BrmNc28eQSyvmoZrGoKaTX2ptNvlzVCI2RSRvx+ziDS29OafJ7uMa9vw7Wqc3w==
X-Received: by 2002:a05:6808:6341:b0:38c:581f:6c90 with SMTP id eb1-20020a056808634100b0038c581f6c90mr5690676oib.57.1683878621609;
        Fri, 12 May 2023 01:03:41 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i3-20020aca3b03000000b0039208555951sm4294320oia.29.2023.05.12.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 1/7] line-log: set patch format explicitly by default
Date:   Fri, 12 May 2023 02:03:33 -0600
Message-Id: <20230512080339.2186324-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
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
index 676de107d6..712bfbf5c2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -890,6 +890,11 @@ int cmd_log(int argc, const char **argv, const char *prefix)
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
index 6a7ac312a4..7466366860 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1141,7 +1141,7 @@ int line_log_print(struct rev_info *rev, struct commit *commit)
 {
 
 	show_log(rev);
-	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
+	if (rev->diffopt.output_format & DIFF_FORMAT_PATCH) {
 		struct line_log_data *range = lookup_line_range(rev, commit);
 		dump_diff_hacky(rev, range);
 	}
-- 
2.40.0+fc1

