Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7784EC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC8F61108
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhJVTiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhJVTin (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A315C061226
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m42so3874701wms.2
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/LYFwkbjkuKt53+fEH9/R5ibanDzRFHAtDpAb5au8w=;
        b=fydYYV2zZawdBQbY8SgqPXsTv2iQfohpQXBv0v+JyNW2s8DebnWFMshBL18q8CB52O
         LJSFNF+RmOdJSUDCr+ccABPzKCY863hWGjAWBWohVQszm4F77eLHMQTueoT9FaZTCUq9
         +Vc0/3E/QBtzJ+4Jy2fnaPKv3fSn55E269zCwqhlgbgvh1ZvgsJ8KibAKse4ARfEKCJT
         UJ0aItWPqHIJJkoMr6Sz15OIMuwW2AuU3jHTeuLRbsQ615xB3tfA1qNRsA3lYnNwr32q
         fI9NqB4PqW5sT0Z96wNtj6GJ/yWKPnbUkziz2DLUewhTTojHc8tn3XldJgDhEFulLDFn
         RlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/LYFwkbjkuKt53+fEH9/R5ibanDzRFHAtDpAb5au8w=;
        b=0VHaRijYKds449GeZHkp35wnXJU/pPx5o31LZE95yUj6uT1YyvN1HJYZPYHmfaR8GY
         C5qt59An9AHcIKTEW/s+TwxQlwarjWIb42Hr9xir/pnQcAUNC6asTNlrD/e8VUSyST+s
         r0me2ptdE0LF5I9K4Bv7iRoxeoq6gXfe44JGWhU4MotWIX601MwBU+vaqT22ow+2WaTt
         LsKFSRdGmcBLlHc8lwGuebXG1Km/kBI/y7I5XrDK9i9cKIuZoPw+yW5DIb5lWTkT3OLA
         hSMfvoitY0RQchCvGlg2iL08d9dU/Fff1TZgGp3l633L1mflOmTWF0hrJrMvan0I1Cdv
         xoBA==
X-Gm-Message-State: AOAM533W/Rr62bAndFzsnzycXMKJ6LMl63S4fSz0vZzoXGVBRBqmgxQ9
        gzeHXyghb+Us93oKgaNiLKsiQJggq44OSA==
X-Google-Smtp-Source: ABdhPJz7TRDcyoEIZ/Ue70hjA/rBCmAwkjArQWbr1Fk7ZnkyzuTuPHm0uafwCBQpii8fV77mQfmTVg==
X-Received: by 2002:a1c:a182:: with SMTP id k124mr1877808wme.96.1634931381492;
        Fri, 22 Oct 2021 12:36:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
Date:   Fri, 22 Oct 2021 21:36:10 +0200
Message-Id: <patch-v2-06.10-e0b11514b8d-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

This is just a small code reduction. There is a small probability that
the new code breaks when the category list is empty. But that would be
noticed during the compile step.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index e517c33710a..a1ab2b1f077 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -67,10 +67,7 @@ print_command_list () {
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		for cat in $(echo "$rest" | get_category_line)
-		do
-			printf " | CAT_$cat"
-		done
+		printf " | CAT_%s" $(echo "$rest" | get_category_line)
 		echo " },"
 	done
 	echo "};"
-- 
2.33.1.1505.g075a284c562

