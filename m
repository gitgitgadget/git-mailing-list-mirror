Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567841F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbeACBMu (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:12:50 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:38864 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeACBMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:12:47 -0500
Received: by mail-io0-f194.google.com with SMTP id 87so566353ior.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4SCF3405fN86u+vqQ3GkvoNheqVX9ukAH4PIgdikh4=;
        b=s1LKh5LwiV+7/VxTW/Km6sGC3CuVkNPsegVtul/65aQD53C5vnQqaSrp3vawlvWqNE
         e2mdzPtywdW7lWrA/mHCk8/7Jb2g//Ny7Qm5SXlD951t4KZ+vYMh1yKIiSUXjxN/LPef
         gqx95VnXQTjyMTPv9n2QIVrygBXHd5HU09Tm6GmFG7wuiS03Mvv01XzydM8z0yIHTzgn
         McyUAxQpUA5iyotj7SQdqq2rdjPyVUMVND2F6YtRefMoLZy21x1yPCXtPBsMN3W0DbEY
         K9vLCyuqDnqf5K0mL+BdOheUj/UAUH4BBmRXoGzJegbgEUHI6rRUSXwi79t9uteBsyC0
         i0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4SCF3405fN86u+vqQ3GkvoNheqVX9ukAH4PIgdikh4=;
        b=FA8JDVCTOhZImMveEn30GJGT2CfGrDbW4U702K8/x5mIUQovlKK/oYpi6TqRm9azy8
         QuM33J4hnkWiUZcZbMghbd8SfUouvlH26Morz7dlb4VxwrT8Xv1KR7sKU9S0PDwWx/On
         XNSZEmEUVCki2QOzRgtwRjEVcauYuLBr9zMvsMhL/5G45PQkvUVwtRvFkjFp1oRlYU0Q
         btg6UBcn2tN+hjMDuRp8q9FvulLJY7AzDVwu5HrW9Y9cZoiSkaYjdHaIyahTXgTB772N
         DZVopm8w6rM4dVTYh7FloJA76yIZAl35/1+3MCT/QMLxCksxHa6ls2mjMVNlcDzF84z4
         SsQA==
X-Gm-Message-State: AKGB3mLC4uN8EhHWO7Gn+kXvj149Srk24Xpw5OzYqYKy12MzR8ENFvd9
        ckvFQzRdmIH7Trvad+uPFPc3hA==
X-Google-Smtp-Source: ACJfBotCXTWKvht02qN7kKKQxBB9+CG0o105cyhmjWI9qaZeAYT+idfZse/n0C9bqT/p2yxS1YmJgw==
X-Received: by 10.107.132.75 with SMTP id g72mr57891318iod.46.1514941959727;
        Tue, 02 Jan 2018 17:12:39 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v22sm9871617iog.2.2018.01.02.17.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 17:12:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 4/5] unpack-trees: oneway_merge to update submodules
Date:   Tue,  2 Jan 2018 17:12:25 -0800
Message-Id: <20180103011226.160185-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103011226.160185-1-sbeller@google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
 <20180103011226.160185-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is a one way merge, each submodule needs to be one way merged
as well, if we're asked to recurse into submodules.

In case of a submodule, check if it is up-to-date, otherwise set the
flag CE_UPDATE, which will trigger an update of it in the phase updating
the tree later.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index bf8b602901..7657d6ecdd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2139,6 +2139,9 @@ int oneway_merge(const struct cache_entry * const *src,
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
 		}
+		if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
+		    o->update && !verify_uptodate(old, o))
+			update |= CE_UPDATE;
 		add_entry(o, old, update, 0);
 		return 0;
 	}
-- 
2.15.1.620.gb9897f4670-goog

