Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429071F406
	for <e@80x24.org>; Thu, 10 May 2018 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeEJT7H (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:59:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37636 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeEJT7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:59:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id e9-v6so1577086pfi.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfGX/KEY0AfHzI7lPRM7neHstopDADuGJFRzJUEjyZQ=;
        b=HNDn8HNd5ZLnP89WgtfCJSrqJXC3p4JtKGNOYkwpX1JRDUw5HAl3L9iB00xX8WXWkv
         fBwuo/ka32o+rLlOOEEXM0TwwfbrV+bsujeojBnTrx1zNVyPkbGmSSLHsHr/xjdKP2et
         96x6wcWRDLKWOeiN+INW5PojgDGQ5f4tUnmw0LocjXqk6kAQSfxoov5wgruKF1vwiU4L
         u0OcPilItCeLgUsXe8eAbZSKrgFMpDRGvSaFaY8gAmmtQYsNO81B5qGXnsuW2vWnrJHB
         20ADsFIDynysH/01K/0mOsuCVFua72YM21JD/Aonx6eel/736YrxCMkDj7Z6/bLFSVol
         R6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LfGX/KEY0AfHzI7lPRM7neHstopDADuGJFRzJUEjyZQ=;
        b=FRPF0H+LzqiXi62/463mMM1+Dogtj5i1IgOdNLmeaIyqPDMHJ/Kmq6Frf0ADnHXFk3
         MjnPL8SnnoDh7PvCZ8+JbV9+9D/fbC2nK0Iy21XBLGK4CH4bp3iD9UOJWYj5sJEZUvFI
         tIjhHq4QL5Y4g5X+d//H1M+o2IEJr+CmsyHLjph6JkB+FOhSc7AqkomoR72bmYmfHCcv
         /sY+eF0Tj6+otbOXLBtGq+hgbQzla88CVOKSmX3momkoGi2ctYPE1bWHHJBZhe3q/yfV
         aX3fANJiZWjaQTy1yQrrXf+4ZjFQhde0hd5Vs9C3i/Y+51k6BXVj1DgMBzJFmCXXVH0S
         RU5A==
X-Gm-Message-State: ALKqPwdF0r9ThtfiHc8p11UVNdYwqghgrluur3MdsSclTwypbACUlenf
        tZtTOUkrbY1UVsAtnh7n/xudXw==
X-Google-Smtp-Source: AB8JxZqR3dGV9krCI2z2/C6WdpZohE44YEYre4PtXbkR+ganGni6DjjDv1YI5yR8m9B7QyUoTKNryQ==
X-Received: by 2002:a65:4944:: with SMTP id q4-v6mr2183923pgs.424.1525982340849;
        Thu, 10 May 2018 12:59:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l9-v6sm4585345pfg.146.2018.05.10.12.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:59:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 4/4] replace-object.c: remove the_repository from prepare_replace_object
Date:   Thu, 10 May 2018 12:58:49 -0700
Message-Id: <20180510195849.28023-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510195849.28023-1-sbeller@google.com>
References: <20180510195849.28023-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was missed in 5982da9d2ce (replace-object: allow
prepare_replace_object to handle arbitrary repositories, 2018-04-11)

Technically the code works correctly as the replace_map is the same
size in different repositories, however it is hard to read. So convert
the code to the familiar pattern of dereferencing the pointer that we
assign in the sizeof itself.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replace-object.c b/replace-object.c
index 246b98cd4f1..801b5c16789 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -37,7 +37,7 @@ static void prepare_replace_object(struct repository *r)
 		return;
 
 	r->objects->replace_map =
-		xmalloc(sizeof(*the_repository->objects->replace_map));
+		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
 	for_each_replace_ref(r, register_replace_ref, NULL);
-- 
2.17.0.255.g8bfb7c0704

