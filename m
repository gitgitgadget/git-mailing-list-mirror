Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C469C433FE
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiACOrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 09:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiACOrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 09:47:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A10C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 06:47:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r17so70321495wrc.3
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3xEi0GzwO3pJ210HIyppg03Rk7RBaWeMVlmPpH+mMEc=;
        b=DU+W8pXv/AGI32fJs6dEMZILFKngJ0NokkVQ1J2uPCURdWRAl5P9a7HXaqEjb0QQLm
         nX2D6BiRoHIKl3qeACB6XxA8X3SzvVo2MitKh6hZ4zoydHkDEc+NtaI0K8Z2ouEubuOu
         dkYTT/wLP7whCxK9aVtOxax9s+XZKegr+corZiY1GvziKrLws9K7bZFkkWj/B/Nu6a/P
         328eu8s3Hua1LrYbYN3anvTROTaLWDiMZ74H7gjUNSzySQhOdVgPPavZ7uX/WiD63ehD
         sSXh0s0Z12Us20XBAXp3cGESBjjIKCLS+q3Nf7jfd2mlM65HdA1cgvurNExxFLfPG6eK
         rsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3xEi0GzwO3pJ210HIyppg03Rk7RBaWeMVlmPpH+mMEc=;
        b=VrEAlqcBQQ/eMCN7RqCizAfHU31bMtQ/c8hStlcYUtGogObHaSEXZGT8lbgHq5bknA
         0rzgtH/AkuHl8vRSHEzgQL3long2E8T1D7a0YA+Sl9913WBe23MHXQehpWvmEv1Quy2h
         UzUp6CGCxt/H0v/iG+U4HGZeS2bPdGs5hZkf+AcW25aUZPuhSNlmmQ9/mx+Fu/A3vMeX
         mZO0bPw2BraaWGvxRuI/tpHAcsIJGUhjaF3ValnYKkHKoxSRHNOovgdOpfH0kEAPOxN+
         6HoJ8ESuMgJdfI+Mgzk13X43w2LSVHL5zbTgeO2ZOd1wTyM3XlF4zztAXuku+Kqs62Mw
         1FQQ==
X-Gm-Message-State: AOAM531i44Hulflb5fLAinN4djAf1XdF/H+OOpettW8fwrqxdf129Mka
        HRkG1bC0mG2W+sQ5uAYDc1xz4TVZ0Vk=
X-Google-Smtp-Source: ABdhPJxEkBlq8vwukHvEEf1FB4iAz6gl7S3WeqJLfknxhPc0a1EQ+mUKGyiZEzxhD8Rj7FrUbjnlZw==
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr39465397wrx.62.1641221263916;
        Mon, 03 Jan 2022 06:47:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm27909867wmq.30.2022.01.03.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 06:47:43 -0800 (PST)
Message-Id: <e4bd09ccf75d48e7c6e8c4901395449bf79aa3c3.1641221261.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
        <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 14:47:41 +0000
Subject: [PATCH v3 2/2] name-rev.c: use strbuf_getline instead of limited size
 buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Using a buffer limited to 2048 is unnecessarily limiting. Switch to
using a string buffer to read in stdin for annotation.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/name-rev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 21370afdaf9..85993bc2b38 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -625,12 +625,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (annotate_stdin) {
 		struct strbuf sb = STRBUF_INIT;
 
-		while (!feof(stdin)) {
-			char *p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
-				break;
-			name_rev_line(p, &data);
+		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+			name_rev_line(sb.buf, &data);
 		}
+		strbuf_release(&sb);
 	} else if (all) {
 		int i, max;
 
-- 
gitgitgadget
