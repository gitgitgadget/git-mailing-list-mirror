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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E5EC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1735C610C7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhDIPDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhDIPDN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED0C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:02:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f6so5944870wrv.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmXMEhcx/PHm0GNmC7uAxnTv/YkkrnwWD8gL1JsPVrI=;
        b=GA9cAh4B7Vx3wnlqnzdKIdeXMbWIn8Cx2gPR9UhmlVRSQdopwlsAtv2hh/ys4d6KSj
         sHajZwUDAYe9GxMee15/gtIBHoFeVIHKd4XraDHS8oTgJK+TWIxW1YKgGp/QTGtFBHrI
         Q6Pb3NbgBa89tGvdVKibqVdRpU1W+QvQ8khnlvdC87WgZwrEkj65ikfwV8xmvESgdZfM
         PhXjXdordyUlMlRp7vlt0a2nm63YjNg8w2yHFtjrt3+4xiBTJnenOCGH3RnIDkC1uwF8
         1bdo/OeZtndo+uCjL9LBTt4U9O2zkApyh8EZa+3ljn1WyBylSLWvLnDoRDiSGBhaW/+H
         bdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmXMEhcx/PHm0GNmC7uAxnTv/YkkrnwWD8gL1JsPVrI=;
        b=V/lGA8k3qEyYHn5mLcTWfSDoiSf0ikFp4wx/lu8zCW7TufqSlsGZGMNH79l8l6+h+j
         6961GRTvMwh6oWc0aarEmxle4UtQYxwBgb9iWN7N+Xi/qtIYuKa3rt40MAjDsjogWyCJ
         McTP02k8bazKE5Novl7fkiX0XmkZUI/Ra6xwBhixu3faIXsJh8YXQDbTvdPpFOW7/+8E
         IcQ2pqqnMZRFKcfnTBUyhFVQCmY2JJUH3/NSgd/5jM0Xc2OKVxO/ogE/PcFwXDhRy3d4
         U2oafZeZKgOEETfFho+vPojijo5xVX2SAdism1IOhD6nkOAMjh948SkeFOUqsHzplOCv
         5VVw==
X-Gm-Message-State: AOAM53385c8zg0ajVznt3hHNN9FeYFMVDbVCMnE/WeULN/iWlqu+yEoC
        lx6dQoqfiCSarxpvd1y5TFd4B8L5KEBdbg==
X-Google-Smtp-Source: ABdhPJzXHvbn4seYJ4i0vYMrOFvFIhKQp/h3XS/aKsjXjNAQgZHiz1PRj1q9p5mYTQL/4MxvBSRliw==
X-Received: by 2002:adf:efca:: with SMTP id i10mr9492031wrp.362.1617980578144;
        Fri, 09 Apr 2021 08:02:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:02:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
Date:   Fri,  9 Apr 2021 17:02:46 +0200
Message-Id: <patch-3.7-29545543bd-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend this script added in ab81411ced (ci: validate "linkgit:" in
documentation, 2016-05-04) to pass under "use strict", and add a "use
warnings" for good measure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/lint-gitlink.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 476cc30b83..35230875c2 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -1,5 +1,7 @@
 #!/usr/bin/perl
 
+use strict;
+use warnings;
 use File::Find;
 use Getopt::Long;
 
@@ -45,7 +47,7 @@ sub lint {
 				report($where, $target, "no such source");
 				next;
 			}
-			$real_section = grab_section($page);
+			my $real_section = grab_section($page);
 			if ($real_section != $section) {
 				report($where, $target,
 					"wrong section (should be $real_section)");
-- 
2.31.1.622.g1b8cc22e65

