Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B9C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F66124C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhJDCAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhJDCAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:00:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C6C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:58:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k7so27652917wrd.13
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBLtQ7SqIiRBDJWmzxObPdpeRfGhIBYNh5qpoduwBog=;
        b=NXPio6zb1o87NelylsaYG5OlygE7cXFm4EuEOSLf9XPC7wVBnUrxMv3dF075KxH9eY
         R85MoqDY83HIlBtqmOKRh75ynXQAA5T+aZnFDjkIpwrAaHSwoDVuC3P+CCf0FsLsflLa
         msk1rH+WKjh6EpVu4O1gpJ2zlIEm/CBecFnXAs91WpnB2PLgmkkH0Y0w/h0otrcB8djQ
         Z7N9QuftNSg5t+hlj7GCxTgaZ2dh5hs22fMXk7I2GItqoXAKtOWab9mVo5ujtigJCDWP
         vZNE0jx+69fVuc0GVdcfkzPlmkWAXhNIBnmXg7lcCp80AL5d+RNelQYJsPjRkXhhgvpd
         isGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBLtQ7SqIiRBDJWmzxObPdpeRfGhIBYNh5qpoduwBog=;
        b=GctRGZfXxqKrpkYMfc/yOxAXTfKKIdY4IT/MX76dWWZtX/5Tg0OhSEJEd3wyqKXjaw
         KVmhULFhky5SHMovRANoU+SJLhkwqebfGqpsu55sQhDA9yx65FtturpjBrEjecQ5OKqb
         JZE9S9XIRl+Lv4+BcPm3cRwT6VcLbKkupACGkgUUAqFEpKkcm8LS6RyJ2QS7VMv7IUqh
         85V5o3Tz42hyy/jpeulwwm4uQI4EkQRbZEZaPFSxrjX5ST6cJxH9qzdwG1w17KkuTbPY
         ObkBR/t/352xhVV+GtSlWVDOh6aRrx63MRsZhNEW83P/Zm26pfZDORe5roCnOuLQZ1Rb
         qKKg==
X-Gm-Message-State: AOAM530FLEvdXGewCHgzBWh2aLj2OrrhA9EpHZYcHXFta1bwEq8/Dd9O
        gcyV+dZWFpMwC4+MSowapfYwgDHRY6rLkg==
X-Google-Smtp-Source: ABdhPJxgJAMMLjzvQgtmpOl1c3FzT+azygXUIXvkvhMwyRu47Xe4ooarxrVsU3Xq+uR4YG1ESJzy5g==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr11244703wrc.102.1633312707870;
        Sun, 03 Oct 2021 18:58:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y23sm15349355wmi.16.2021.10.03.18.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:58:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] advice output: emit empty lines as "hint:", not "hint: "
Date:   Mon,  4 Oct 2021 03:58:21 +0200
Message-Id: <patch-2.5-5b5754ebfd2-20211004T015432Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's not needlessly add this trailing whitespace to empty "hint:"
lines, this makes copy/pasting them better, and also makes the tests
more straightforward.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c       | 9 +++++++--
 t/t7004-tag.sh | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 2f5499a5e18..9691c7e7899 100644
--- a/advice.c
+++ b/advice.c
@@ -90,10 +90,15 @@ static void vadvise(const char *advice, int display_instructions,
 		strbuf_addf(&buf, turn_off_instructions, key);
 
 	for (cp = buf.buf; *cp; cp = np) {
+		int len;
+
 		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("%shint: %.*s%s\n"),
+		len = np - cp;
+
+		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
 			advise_get_color(ADVICE_COLOR_HINT),
-			(int)(np - cp), cp,
+			len ? " " : "",
+			len, cp,
 			advise_get_color(ADVICE_COLOR_RESET));
 		if (*np)
 			np++;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 082be85dffc..a7041e64ccf 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1749,10 +1749,10 @@ test_expect_success '--points-at finds annotated tags of tags' '
 '
 
 test_expect_success 'recursive tagging should give advice' '
-	sed -e "s/|$//" <<-EOF >expect &&
+	cat <<-EOF >expect &&
 	hint: You have created a nested tag. The object referred to by your new tag is
 	hint: already a tag. If you meant to tag the object that it points to, use:
-	hint: |
+	hint:
 	hint: 	git tag -f nested annotated-v4.0^{}
 	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
-- 
2.33.0.1404.g7bcfc82b295

