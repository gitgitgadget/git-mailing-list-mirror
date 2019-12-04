Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB84C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8E206DF
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epSI8Nil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfLDVZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:25:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40893 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDVZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:25:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so252042plp.7
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vkWyVPTtrMK6GEWgIf/a1BR/PZo9PO1eeJ9G6m+Xhk=;
        b=epSI8NilMrzO++S8EyCOujsdOuCcOnpU4uwqlG8bXOEGRaXd3GA2RWryVei7Ovgs7H
         iLxpuHe45ts/WNlpRb29ibQkNmmmx6cbIL9lpE3a0Hpi652hanRtctkK9d8DVJohRsfg
         oskVvOGLypBcOD5DlQhjDKq8EuWeCYLVbG+Da7gaT0AQ1KrLUFOBwo+wiJxAe02O3Yyz
         K6BfcpVCtxq9/Z+WVokV4M/oja5Us5iRCAFbbVqlojr17+ZW1vyzu1hUhKhgHZxfLoR3
         SrXsC+24YwscpVbunM0JKhdTSzA0hBHIhrj3KqsikFBZb5nhhR5/NqaAc7z3MohmEmrK
         lV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vkWyVPTtrMK6GEWgIf/a1BR/PZo9PO1eeJ9G6m+Xhk=;
        b=KViVIuWaI/w2H2COpLaftvDxvHQELjhPjdw8WPQgV/VzfPjANX5zGeOXoqUfNnwJ4k
         /76ZiC/X2lAvZP9yV/tsdbTHkaS4ct8HHYbsWfuEyv05ayEko3yYzjLfuD7BRrbBfITK
         QEShVCeZLleKSJN9TdKwkKM45cCjA4J227cSIc5Uzlf3QtsKMv8OajfycOLdn1cbv886
         j3PWVxKtgmrxBVupEAQ17yFFUkQl/xEP1rfHdxd/IqwLIKFMUnN2cmROtEUtOwIO9uU8
         gSX+NyYBFqQe281LYbgKnyzRa/BORu24kzTfdHU0tS3WhDg2+k8SliXAYJYGmemNxU2Z
         O+fw==
X-Gm-Message-State: APjAAAVTZBilxoY0sv8mBnk5QWjeAx4VqUI4YsX+s5qZ1FNlFzwNhaI4
        yI6Y96OqCYlL4M1k+zbVTbv+H7kl
X-Google-Smtp-Source: APXvYqyMh/SIWvPTpkN6FYJsqfcx2mom0awIYoZarKkMcxSkawmoxqyX6H5xDQjNGbeWuUPDBoSqtw==
X-Received: by 2002:a17:902:409:: with SMTP id 9mr5443449ple.306.1575494700406;
        Wed, 04 Dec 2019 13:25:00 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id d22sm5252429pfo.187.2019.12.04.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:24:59 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:24:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 2/5] format-patch: fix indentation
Message-ID: <0464bd61c26109bc6d98ac56bb8bf1fe9d1a6864.1575494618.git.liu.denton@gmail.com>
References: <cover.1575445582.git.liu.denton@gmail.com>
 <cover.1575494617.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575494617.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index a26f223ab4..9c44682f61 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1350,7 +1350,7 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 		string_list_clear(&extra_to, 0);
 		string_list_clear(&extra_cc, 0);
 	} else {
-	    add_header(arg);
+		add_header(arg);
 	}
 	return 0;
 }
-- 
2.24.0.578.g4820254054

