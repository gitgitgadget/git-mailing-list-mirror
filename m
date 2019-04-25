Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C00A1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfDYPve (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:51:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45924 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfDYPvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:51:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so6976186pls.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVvf7mO3OB63Yr7gaYToOtJpsoKT66F3aylKffHa2no=;
        b=WzVaPVxiYlWww2fqJgMKZWiAgF40/FlugkeFjTi5TWs2nPto3TvkIWF2wbS/UYl4rm
         Ijtm2K2LyM2E+s5Vq1G0kGn7/D/z8S729Atm4JdEe1coAQUPYQ6xcybj2rURglCaw7HF
         Q4+gK8VoHLHKo6k2hwLb6m8RWkrtlAzO9a+sl/mbhxB43Wa9ZdR5xT9QDuohIulxrNrE
         cZCHS7KiaPFpSl9m6SBMG+TKCOqldHCRyFcED9ph2XPQR2eUQ0iczx1hdLGDP0zEAh5p
         02+NyNF3JfZKOU0jtqv/5kHcugLZTIuNXZ9w/0glp+/9SHzMx0eLi53q6MCgNFX4B9bp
         OypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVvf7mO3OB63Yr7gaYToOtJpsoKT66F3aylKffHa2no=;
        b=pJ9cgzB85OzhVNmogkENm8Ts1xBdQtwtBw5X3pO11+Q8M7SaI7cE+hBxYoyBJL2V+W
         JbfOQ84x0Ts/LhxUb2NN7+h3fmweoW7gtE4izeNJ0vNKQrDIHBtCFzCi+Z/9MOad6IsG
         koRIzGVtE+nPFrNwqciS0JO1cvIV9D1KwyjGVJM6zB6uVTtA2RcEC1s6PYKDcVDzvDL3
         Nw0qKm8+Slm0jpgWBFDiDuGSXQpa7tLAxLznXEGH26PbE3VvRmZgsfcYjgPgYWDpSpyJ
         ra7hloTKD+ydU9plYgl2Z8FgxDMRVjhtXBN4U3GEut+Jnt+Iv8XYgEpl7g3IUtQLOJA6
         4p3Q==
X-Gm-Message-State: APjAAAXMF2aV+CucaGXCxGqITzcr0CEd9a9SN9MCvPl+aUDLwHVgIN+V
        IQndE501nvloudNdzwdVVvyc9kZV
X-Google-Smtp-Source: APXvYqzbyXbwIoz6qJ76SDozH0WdbYbyqb1Hulrfom0Uf3p8qr8iYXeSY1uPDc7UcIByh7955a7B5A==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr8187767plr.40.1556207490612;
        Thu, 25 Apr 2019 08:51:30 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id e6sm15244914pfe.158.2019.04.25.08.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:51:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/5] fast-export: differentiate between explicitly utf-8 and implicitly utf-8
Date:   Thu, 25 Apr 2019 08:51:17 -0700
Message-Id: <20190425155118.7918-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gb6cebc4909
In-Reply-To: <20190425155118.7918-1-newren@gmail.com>
References: <20190425155118.7918-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The find_encoding() function returned the encoding used by a commit
message, returning a default of git_commit_encoding (usually utf-8).
Although the current code does not differentiate between a commit which
explicitly requested utf-8 and one where we just assume utf-8 because no
encoding is set, it will become important when we try to preserve the
encoding header.  Since is_encoding_utf8() returns true when passed
NULL, we can just return NULL from find_encoding() instead of returning
git_commit_encoding.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7734a9f5a5..66331fa401 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -453,7 +453,7 @@ static const char *find_encoding(const char *begin, const char *end)
 	bol = memmem(begin, end ? end - begin : strlen(begin),
 		     needle, strlen(needle));
 	if (!bol)
-		return git_commit_encoding;
+		return NULL;
 	bol += strlen(needle);
 	eol = strchrnul(bol, '\n');
 	*eol = '\0';
-- 
2.21.0.779.g2f4b9c5032

