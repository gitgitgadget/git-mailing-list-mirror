Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D569C55199
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759E021835
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXmtbsGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgD0Inv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0Inv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 04:43:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1FFC061A0F
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 01:43:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so7468495pfv.8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7AJEhx5zDpW0f9QL5ddzipEihWB3lJJIyStvdIWPy4=;
        b=FXmtbsGfgy49JRWKhOdo11xF0/Hk14viHOpCSG99s6fp6I98tE+D4EwTgSJmtVsuwA
         dXMBDQ1Sr2hKLYvIaN74S/LBrnCgkU1EuZqXTkRDbuIjs9+IYNZuFZTrU6rsJyK2wYYi
         JCfdemz7UP3Mo+8jz9K5PFUJ4DjpzNQAkjkO6GhAx2As9yfHybrY2aklc5CHjp81/Mv0
         kN9moguqzwfJL38p/BQBShs6f1T+9jQvBhDwCEstJEzGSLw0zWF5v5h6WQGFrM7k29Zz
         HXuTEFeN0Q/wKAkfCGK3eUVaiCRy28DEghz6DdqIflf/zOAXZvSRmHUviU6x6kL4iD2r
         rOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7AJEhx5zDpW0f9QL5ddzipEihWB3lJJIyStvdIWPy4=;
        b=k6TO26wo7sxzy4jGlXvC+oDeUx4w6B9EoEtPXtBu6KTyXhVKcArk0Sf6eqj5zOvCwj
         qH+VYbRL3mB2SA4TAEOnhQJ31Ov/U/V4KiR2LcFLvA2ozGM77cXKKqhj+VxR3Qb2YD1G
         aZXPULKHhPdAYkbogKFtsmExVrJ6Gg9N2XNbId1DLfDQdlx311ONpe+bFZo639FHCIee
         s0IxvzbSva/Es2CJUBRP7zd1b+JRRhITtu6XFl/ZLqIIEZaxY2VD4MLl60rHbAzBCy/G
         u84t63PKcrT1sheFwjMaG/bTZJWeK7UdPr0DbgRXUoboQMhnqczCf9aE8eGJ2hBZMl0J
         mMlg==
X-Gm-Message-State: AGi0PuaRGfBpipgDr7AIH/87x4dHaGXjra9VyLnsGuQC8PxbpwEcbRW2
        gdcjSrxnRdf4y6HtlD+TskVgPLCg
X-Google-Smtp-Source: APiQypKWlCqIeerLTpPb08IHhXSypZTTLrGJX4QHRajBFaddQGMKBAoCRUJboRjwzUVturCru3vSEg==
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr4842099pgh.427.1587977029990;
        Mon, 27 Apr 2020 01:43:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 141sm12453490pfz.171.2020.04.27.01.43.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:43:49 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] git-credential-store: skip empty lines and comments from store
Date:   Mon, 27 Apr 2020 01:42:35 -0700
Message-Id: <20200427084235.60798-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200426234750.40418-1-carenas@gmail.com>
References: <20200426234750.40418-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported failing[1] to parse as valid credentials.

instead of passing every line to the matcher for processing, trim
them from spaces and skip the ones that will be otherwise empty or
that start with "#" (assumed to be comments)

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* use a here-doc for clarity as suggested by Eric
* improve commit message and include documentation

 Documentation/git-credential-store.txt |  7 +++++++
 credential-store.c                     |  3 +++
 t/t0302-credential-store.sh            | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 693dd9d9d7..7f7b53e4da 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -101,6 +101,13 @@ username (if we already have one) match, then the password is returned
 to Git. See the discussion of configuration in linkgit:gitcredentials[7]
 for more information.
 
+Note that the file used is not a configuration file and should be ideally
+managed only through git, as any manually introduced typos will compromise
+the validation of credentials.
+
+The parser will ignore any lines starting with the '#' character during
+the processing of credentials, though.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..b2f160890d 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,6 +24,9 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
+		strbuf_trim(&line);
+		if (line.len == 0 || *line.buf == '#')
+			continue;
 		credential_from_url(&entry, line.buf);
 		if (entry.username && entry.password &&
 		    credential_match(c, &entry)) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..0d13318255 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,23 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: allow for empty lines or comments in store file' '
+	q_to_cr >"$HOME/.git-credentials" <<-\EOF &&
+	#this is a comment and the next line contains leading spaces
+	    Q
+	https://user:pass@example.com
+	Q
+	EOF
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
 test_done
-- 
2.26.2.569.g1d74ac4d14

