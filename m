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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4EDC47084
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF35610CB
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhEXHyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhEXHyl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED3C061756
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p7so23770191wru.10
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdFLprq+Ozwp2Gg9PeKD5KBYE+gU65EEKjG/hgCM4uc=;
        b=URoSCZydDNmkmPkiF0wlFWTB6EwfkkblRRtwvnyaXF5Q7OYc86NHiYDHCFphXX64Ym
         /kW+WEsQgh/YehJK2iaeC+4yhntjg1BQ6F93XYJpw/fBrQNNIDOFe+Oc79uT02Hy1hNO
         zwvmfdYg4Y8dSbIEIVbnM1kKpXY6wk0uFfHx+KSbQMTBQU9DzSnnwkMAQcc0b19B89TH
         bp+m3yjd+UWncax4W3zXXz5XZFIo9NsHEOrpUvtXdUwdnaZqxWvinnhyzECht2Bcgz0U
         HIad7F8ac5qNVmZGo1DaeVmbopttQqyv/iUcxy7O/HbB8RBR0RVelLPVIM86Y/vigCXE
         lfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdFLprq+Ozwp2Gg9PeKD5KBYE+gU65EEKjG/hgCM4uc=;
        b=M3P7Ke0EHheLQ7JhOhcGrp80zQY8oleeyr9vzWdBCvjW1vtG6X86VbX6iNzlGY/fQP
         IwZRZ63TWW4YpawAmFdCIZU2Ayl6bvwtrnY67HVXz6Zlj3ecEQMmzU/o8QxWjyqp/WRE
         6lLzhZFne6Wg24gpR89aqsrqDuBgXziQDUjHUOzpSqa/O4SRDqg0bynK0i//GZTzq4th
         gHeUcZ5wAJkBEGX0WJcQw/yF1qEzKW1a+G/dAvyN+t14sIvD00bvo0JM0eKJtB5YBKLE
         u7MjumpVtz9fsLrNQi5W9bcLqGgP/X7vMD+qvS2kamviPsX2w5c0xZWAuBxDwPvkVBn2
         TKbQ==
X-Gm-Message-State: AOAM533bVo8HwWbGEc12pE713IkrFPj9F4bAD1LQ2Ixj8G8PhtQnT2M5
        p2D8tFlLIorPdQ6B3oQ7ipuhFVnn0A8A6LoM
X-Google-Smtp-Source: ABdhPJwJ0aaWbNFSSeUgoxylT2nlHYYlvqdCQyIjN/zpKN3elgM0KxichXXXJOxDuNBq+GlH0SRpVw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr20926229wrr.37.1621842789933;
        Mon, 24 May 2021 00:53:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/13] send-email: copy "config_regxp" into git-send-email.perl
Date:   Mon, 24 May 2021 09:52:54 +0200
Message-Id: <patch-05.13-cce0f89143b-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config_regexp() function was added in dd84e528a3 (git-send-email:
die if sendmail.* config is set, 2020-07-23) for use in
git-send-email, and it's the only in-tree user of it.

However, the consensus is that Git.pm is a public interface, so even
though it's a recently added function we can't change it. So let's
copy over a minimal version of it to git-send-email.perl itself. In a
subsequent commit it'll be changed further for our own use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d8362b5f07..95a69d4c51f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -380,6 +380,24 @@ sub read_config {
 	}
 }
 
+sub config_regexp {
+	my ($regex) = @_;
+	my @ret;
+	eval {
+		@ret = Git::command(
+			'config',
+			'--name-only',
+			'--get-regexp',
+			$regex,
+		);
+		1;
+	} or do {
+		# If we have no keys we're OK, otherwise re-throw
+		die $@ if $@->value != 1;
+	};
+	return @ret;
+}
+
 # sendemail.identity yields to --identity. We must parse this
 # special-case first before the rest of the config is read.
 $identity = Git::config(@repo, "sendemail.identity");
@@ -478,7 +496,7 @@ sub read_config {
     usage();
 }
 
-if ($forbid_sendmail_variables && (scalar Git::config_regexp("^sendmail[.]")) != 0) {
+if ($forbid_sendmail_variables && (scalar config_regexp("^sendmail[.]")) != 0) {
 	die __("fatal: found configuration options for 'sendmail'\n" .
 		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
 		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
-- 
2.32.0.rc1.385.g46e826f1e55

