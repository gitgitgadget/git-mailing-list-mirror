Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A441F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeEPW67 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:58:59 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:55579 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeEPW66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:58 -0400
Received: by mail-vk0-f74.google.com with SMTP id f1-v6so2131949vkc.22
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xXvgX2d1jPkzcd9fc94WLoUl+Pnu9jSeEfNAA8vLiWY=;
        b=jjFt13xX1gao/Io1P0TPDPU4BLq7YZKdYCnV52qoZ6CXOrYeJ81AMezrxLZmMDEyEf
         X6yAHFDzsUifgXQoDKHt0q92QqT0r3q9QNM9PHH9mXlzFlKPkpKDiFADMOyggJ30gZ3I
         oYwdlvxJw1/L1k3RBkogCj6xFlGlth5x1LcfOxdfCywLfFKTYxx4QjfXgPvHp47f2FaT
         h4oV/dsYkiSFkNYbtOPAkZPCycXRe6a6VzkWDU8jIh1JkJcbtwjHoHRHTY9Dxbmnbxkk
         3G5uG2noqeGQoJj5rlpVnRWp8jnXd1UVJvNM5fCekp846GcQnOiqN2vNKpXjXYkSS2Uu
         raCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xXvgX2d1jPkzcd9fc94WLoUl+Pnu9jSeEfNAA8vLiWY=;
        b=fBjngLt6cG5sFLGlgnAY2cJV51Yy+nichxTnL4d2tBzometzhHXQAr/E4nV2r5XNwa
         fH7IMqcDfQpD4XVYXbiGu94hiBBsMMLeNy1Ink1zlXwVkEYDFSqqKtFc2CwHSsX+Qxde
         ehaePV96q+ApfX42ZtSCPPBF/3L8w3Qa/CngFsyAcZyQW7UndyZIPxyijBimcdwaK+EI
         VZZxeHBjebpqgaLu2VakbI+lLV45ObGBRVfzV2lZE0ASfh2AO2vl9pQ7o2dvCSAy9JH0
         S3u9eL3wdCHks5VX28UuOr6H6Bou9urRpBCJeNcRHM1ZLvoIYWdIboihl6+BF58y1Wre
         NgsA==
X-Gm-Message-State: ALKqPwcEhjA7g7ooUuyjZDva3xVUYL7DQhTPiK7ZieU3XwDrMujH/zuy
        lhsHdUvROGDrs1DthbyN2Svsfi4KDwqIIeFcmu4oSQq6DCuTmB7cF/xi6gh0ccen1G9IO0FY+K9
        T7DMbH1GQY+05XtjnblLEfNW6n0xUO0mWytV/HVmdMRf/xPU01+LtycY79Q==
X-Google-Smtp-Source: AB8JxZqrMNLGDbQYVQqeMghvZnp8mKFeFG+KbtiUSGAOrVpvcK9ZH5LfdFah3P5LHK67ffOFbhQhGL5pJVQ=
MIME-Version: 1.0
X-Received: by 2002:ab0:12c5:: with SMTP id o5-v6mr2415459uac.82.1526511537358;
 Wed, 16 May 2018 15:58:57 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:55 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-9-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 08/36] transport: convert transport_push to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the logic in 'transport_push()' which calculates a list of
ref-prefixes to use 'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index 3ad4d37dc..181db4d4d 100644
--- a/transport.c
+++ b/transport.c
@@ -1111,21 +1111,22 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
-		struct refspec_item *tmp_rs;
+		struct refspec tmp_rs = REFSPEC_INIT_PUSH;
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		tmp_rs = parse_push_refspec(refspec_nr, refspec);
-		for (i = 0; i < refspec_nr; i++) {
+		refspec_appendn(&tmp_rs, refspec, refspec_nr);
+		for (i = 0; i < tmp_rs.nr; i++) {
+			const struct refspec_item *item = &tmp_rs.items[i];
 			const char *prefix = NULL;
 
-			if (tmp_rs[i].dst)
-				prefix = tmp_rs[i].dst;
-			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
-				prefix = tmp_rs[i].src;
+			if (item->dst)
+				prefix = item->dst;
+			else if (item->src && !item->exact_sha1)
+				prefix = item->src;
 
 			if (prefix) {
 				const char *glob = strchr(prefix, '*');
@@ -1142,7 +1143,7 @@ int transport_push(struct transport *transport,
 							       &ref_prefixes);
 
 		argv_array_clear(&ref_prefixes);
-		free_refspec(refspec_nr, tmp_rs);
+		refspec_clear(&tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.17.0.441.gb46fe60e1d-goog

