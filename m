Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F665C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 04:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiGMEUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 00:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGMEUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 00:20:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB8D9E20
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 21:20:20 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10c0d96953fso12823286fac.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 21:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nugkGuyEX9x4KpCa8nxt4+B+MIyVPr+tIxWA5PgccP0=;
        b=ytmKWMTFDcK26m9KEnlH4Ngbl5RmGEZowXsBcODXqqqV77kyYaqweiKUnS0lmT6hMl
         KOwlaSpl1xEbzg8p/4ka20W2k2+Hoz9VU+5zRYjEZOJWJEguLWdour3UBCYHAHkTI3vB
         cnqpXe/lNv7b5aiZfrNXdbjGyzBPbWdJtDYFEkms2IIdjruigg5EP57/OTZup+5XHwxS
         WWcQsihbi2GR+Bg7jawwazHYfrzd/NjYfmJXjgOUrQukXRViqK/QBkIlex6LVFWQ7z/1
         lFWC6UEgsN8HS/KeE7Vt1S3s2+1SJtnLrqVIRSuiR5qfWEV6vCP/MSVcbGN1LRIdxAau
         HrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nugkGuyEX9x4KpCa8nxt4+B+MIyVPr+tIxWA5PgccP0=;
        b=jQVOmtAP18jLiYQWxllJGkfBLE/ZDgtmSujSJEolrKZecx0dcY1r9rybltzlIC4Hce
         vGt4msJStco2+iFeYnS6Fs329b3iKl08lwck4hLrMJHtqwI/E4/M49ZnFbmZQQXWTYv1
         /L5revkbfSAKWnURTwXVUS1gsZMx5W4lZL3YQegZcw0/78QxOkLcRPZ7zjVf1coaYlaF
         DvppjByyBCvutKm/b7/ZXbOsjd8oA3EFg/J8XFXpREDtmzDj9E1sC6zKMif9NuLv5So/
         f8auPpGL+NV+TyzwtA+FNY2hMHKAR2lxnu8A0DK5zvVzsTGtJBX9aE2PSvZgJ0TZ6ZX3
         bSCg==
X-Gm-Message-State: AJIora+ns195grqSawxFaflT21yT1XjCD/mUUKbTpvJpbdM4AS0eertK
        5527KmjEER9BjX08hxO8xGctESA9HyjBDQ==
X-Google-Smtp-Source: AGRyM1tntER0fEAgPqpVHFff1e0s98fZpA4xlwsp9QYyyct21Oqsg5GxPQMWz0i+WNB4E0XYf7ehvQ==
X-Received: by 2002:a05:6870:d251:b0:10b:e3d1:a24b with SMTP id h17-20020a056870d25100b0010be3d1a24bmr3612377oac.297.1657686019226;
        Tue, 12 Jul 2022 21:20:19 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b000f342d078fasm5649062oab.52.2022.07.12.21.20.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:20:18 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] checkout: document bug where delayed checkout counts entries twice
Date:   Wed, 13 Jul 2022 01:19:55 -0300
Message-Id: <694aeb19f57297d9b9d07d47897385bdbedd309c.1657685948.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657685948.git.matheus.bernardino@usp.br>
References: <cover.1657685948.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the end of a `git checkout <pathspec>` operation, git reports how
many paths were checked out with a message like "Updated N paths from
the index". However, entries that end up on the delayed checkout queue
(as requested by a long-running process filter) get counted twice,
producing a wrong number in the final report. We will fix this bug in an
upcoming commit. For now, only document/demonstrate it with a
test_expect_failure.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t0021-conversion.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bad37abad2..00df9b5c18 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -1132,4 +1132,26 @@ do
 	'
 done
 
+test_expect_failure PERL 'delayed checkout correctly reports the number of updated entries' '
+	rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		git config filter.delay.process "../rot13-filter.pl delayed.log clean smudge delay" &&
+		git config filter.delay.required true &&
+
+		echo "*.a filter=delay" >.gitattributes &&
+		echo a >test-delay10.a &&
+		echo a >test-delay11.a &&
+		git add . &&
+		git commit -m files &&
+
+		rm *.a &&
+		git checkout . 2>err &&
+		grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delayed.log &&
+		grep "IN: smudge test-delay11.a .* \\[DELAYED\\]" delayed.log &&
+		grep "Updated 2 paths from the index" err
+	)
+'
+
 test_done
-- 
2.37.0

