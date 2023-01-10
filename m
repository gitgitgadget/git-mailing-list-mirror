Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB88C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAJFpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAJFoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC441D6B
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vm8so25801298ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1OwbEEsy2sPzLTZbmkdC9lxrYZERuEx+7/I0upOelU=;
        b=SvzbsFae609Oe/Cj9iZQz9O/myFC9a4X3Gc3yg+q3lhD5/IYJY3LKmjY1IM5Mbr/h0
         DZhPtE3jxWE9+bwkXrRTPiuaOhkVO9H+Q6iEQED4wEBsKiKR8TUTiSd3EuNmIBJauO1o
         stAtVyfjv/4f37uemnNOI/qFnhIh00oK6LCN+eGIp9PLPf2E/nYGak2hA+D7yn2bHl4X
         PAwfRm9OH86wg+jTb2qCJwUXdBtd7AcimAx/WhNAeUdPK0K6xtFGQ2r8iEBA3+fOO9q3
         KxSVremEJ64QdN3pUoKlcrurJqZGEsk85CXoohLiDU+F5r3KgT+BfjUG1gkzT2Xbybwi
         LQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1OwbEEsy2sPzLTZbmkdC9lxrYZERuEx+7/I0upOelU=;
        b=LeX0OD4gx+Ywg9JzqxxRY0P2qt+qm7vSnRKDWLpkDoW2cp6+11f1/uCvf11l4bRDxH
         ykQsF88162NhmvthibmSRK3g5HH8nXCt7JVVIjkH+889Bw2DQS/5izpP4+1EgPpYz3sn
         f+GKTDB+a6apkC4PkOvj4rP8bH1mTgkWFuB+Cm6bDcvkAH5pwCTPP4/f9/7+c4aGHseq
         GhpFwWCCN1CseCr4T3LuvfMo8wfDo/Zts4OWgR4KeiMzLK1JJ6MxQ3DehgskDgEdOh5S
         vJ1dC+dn0VbB8mqMPl6G5ThnHJRGIlOiUrXQM2Aaz3Nt+7hagxbZL41qhS+pD2zbbSrx
         YFDw==
X-Gm-Message-State: AFqh2krtQM9g5P7RS82pq0Fti3BE5RJJ3Ghp/DKjpMaQWYCBs8w60X+0
        90qget7MsWC1rQF8llvBk7Jkg0sgbGPbJg==
X-Google-Smtp-Source: AMrXdXs5Gz+obgBuQ2nAuhkRB6YNrSO3mFPzqX3C6pmk4/FIaX38Cr4DldU2pMAvQmrZ6HWk/EyYmA==
X-Received: by 2002:a17:906:8478:b0:84d:373b:39dc with SMTP id hx24-20020a170906847800b0084d373b39dcmr8666073ejc.25.1673329446395;
        Mon, 09 Jan 2023 21:44:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/19] grep API: plug memory leaks by freeing "header_list"
Date:   Tue, 10 Jan 2023 06:43:37 +0100
Message-Id: <patch-v3-17.19-e4bd46a343e-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1] it wasn't made
to free the list using loop added for the adjacent "pattern_list"
member, see [2] for when we started freeing it.

This makes e.g. this command leak-free when run on git.git:

	./git -P log -1 --color=always --author=A origin/master

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)
2. b48fb5b6a95 (grep: free expressions and patterns when done.,
   2006-09-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index a4450df4559..c908535e0d8 100644
--- a/grep.c
+++ b/grep.c
@@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
 void free_grep_patterns(struct grep_opt *opt)
 {
 	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.0.1195.gabc92c078c4

