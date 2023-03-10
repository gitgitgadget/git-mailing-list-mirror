Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338BEC64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 13:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJNEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCJNEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 08:04:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156EBDF705
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 05:04:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3403131wmo.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 05:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678453474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T5HzheaOTb9ra2tGacRbxRsgnd4G+SoixmPF8pIu3s4=;
        b=i0Ln+fs1umLswPdNeju3I2kXSONr+igHmVOgKCKAeuRKApC8P2462xumOhsbGZrRfJ
         3GSUv2GbJrNEI+gS+kgG4S1JonAMWiaWZGbCdLM5dVPaXukats7N8o/bTZ6KlrdCLT4Q
         1K9ztxe8UBtbEtCXTXUtILjDPphim/9dBL/MFcEhI/ukq7ov3vJOR1vov5Jw9PtOng7U
         o2gTZTpaWN/4KO8CqMH8TflZFeO5SC0vQhkdrw0HyJi82+6W/Yh7MFVoUa4la0ZWpab7
         0nDGiIUmsnNNTJtDVjrm41dDZnBI/6AgPjEnkfVcAgBKlm+7OX+702DMrM1WsIWix6xD
         2Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678453474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5HzheaOTb9ra2tGacRbxRsgnd4G+SoixmPF8pIu3s4=;
        b=r4AeRanOO81Z9T1QXkDa98+TL5m1SD8NuWPbB0hvcUkpa0xZLvBCFcPCten23ZrWIv
         YqqI2xEifAA3ztKGAYSsZXka3H+rbvdXa1DkyTb0LwWY03ortvaC/QhmPCG1aQK+6Dri
         ukiamI0UzDjWbCISKFyPAwTD+U6p1wGHPvTkyvEKGelrbQTv/urfXcILsBFAh5vBId2L
         G18Mg17AhKwoLsfTkrpi0HpMaVk8ryfG7AOJMzoQIgvEb8wRR9iqh2jlFiBDsPtD0BZQ
         eL1cbKEBndzdyI95k/p7h7phgx6Cr5GGk+r+T8Qsk7BZAZeFNMTqUF6+XnuILi/S++zP
         q8IQ==
X-Gm-Message-State: AO0yUKXhk8ym0vmYJj8PQxDU6RRbumnr/VW8DVlAIYljhrIRqeL0FDBv
        MbgqGk4ii9sqJM9Ka/uxA8A5inm/kp0=
X-Google-Smtp-Source: AK7set85+ERYrS/q36rUV90dpDwA/kV/5PXKCyKvL5O0rYYaOAaTENcg12SqRL6m/TLf2PcId9G25Q==
X-Received: by 2002:a05:600c:a4c:b0:3ea:d611:e1 with SMTP id c12-20020a05600c0a4c00b003ead61100e1mr2722837wmq.21.1678453474208;
        Fri, 10 Mar 2023 05:04:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c228300b003dc521f336esm2136883wmf.14.2023.03.10.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:04:33 -0800 (PST)
Message-Id: <pull.1465.git.git.1678453473484.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 13:04:33 +0000
Subject: [PATCH] ls-files: fix "--format" output of relative paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>, Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

Fix a bug introduced with the "--format" option in
ce74de931d, where relative paths were computed
using the output buffer, which could lead to
random data in the output.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    ls-files: fix "--format" output of relative paths
    
    ce74de931d introduced with the "--format" option to ls-files. This
    commit had a bug: using --format='%(path)' with the "top" pathspec from
    within a subdirectory would lead to random memory being added to the
    output. For example, within the Documentation/ directory in Git’s own
    repository:
    
    $ git ls-files --format='%(path)' ':/' | head -n 2
    ../.cirrus.yml�뻤��
    ../.clang-format�뻤��
    
    
    This is due to reuse of a string buffer for calculating the relative
    path. The attached patch fixes this by using a fresh buffer, the same
    pattern used in other places where relative paths are computed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1465%2Fadamchainz%2Ffix-ls-files-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1465/adamchainz/fix-ls-files-format-v1
Pull-Request: https://github.com/git/git/pull/1465

 builtin/ls-files.c         |  5 ++++-
 t/t3013-ls-files-format.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a236483..02b9bbe7eb4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -89,12 +89,15 @@ static void write_name(const char *name)
 
 static void write_name_to_buf(struct strbuf *sb, const char *name)
 {
-	const char *rel = relative_path(name, prefix_len ? prefix : NULL, sb);
+	struct strbuf buf = STRBUF_INIT;
+	const char *rel = relative_path(name, prefix_len ? prefix : NULL, &buf);
 
 	if (line_terminator)
 		quote_c_style(rel, sb, NULL, 0);
 	else
 		strbuf_addstr(sb, rel);
+
+	strbuf_release(&buf);
 }
 
 static const char *get_tag(const struct cache_entry *ce, const char *tag)
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index efb7450bf1e..ef6fb53f7f1 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -54,6 +54,22 @@ test_expect_success 'git ls-files --format path v.s. -s' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --format with relative path' '
+	cat >expect <<-\EOF &&
+	../o1.txt
+	../o2.txt
+	../o3.txt
+	../o4.txt
+	../o5.txt
+	../o6.txt
+	EOF
+	mkdir sub &&
+	cd sub &&
+	git ls-files --format="%(path)" ":/" >../actual &&
+	cd .. &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git ls-files --format with -m' '
 	echo change >o1.txt &&
 	cat >expect <<-\EOF &&

base-commit: 768bb238c4843bf52847773a621de4dffa6b9ab5
-- 
gitgitgadget
