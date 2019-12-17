Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0210C2D0C8
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A740320717
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0ldDlnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLQIdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:33:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45804 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 03:33:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so6086871wrj.12
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QYtpG0EJIfqD8aukHuJx6kFiaeuf/fLGGUOp35jgAuY=;
        b=b0ldDlnvha4dCz+UtIN+LF8PA6ZEw8+rn3uAZWbUGYczAD6mvouJC4X1kjTc05t/Tu
         YtdBg5SghyLOnWI7e2Tf2wAabKttmNObTFPiKB6FQs0+oRDxRvTSG4T64OcjFPrG0fop
         KKpxNyqG2vmgOj2JEFg1IDB1BhzeT5G4KvxuQMhvY+iEeJPcwTn1E0EOkOp0pRFd9hYW
         amfMnMXS8FJLDkEMkxVF+LokZzQMF5NjEfJ+4y4STEls+/xxqgLY6tjiGjbR1VQ9rXc1
         iWPSBAOfMD5B3uGIyfKI4FMUnqERZLi1XHzhwNWexQ9n5sMQ8Rl73I1qjUYls3JyCZTE
         s8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QYtpG0EJIfqD8aukHuJx6kFiaeuf/fLGGUOp35jgAuY=;
        b=NtZKKYXSS74owAQzABqTfjPZH8JOjO7ZcxS+DiPxyOfDt/d0D1296mDiV39NLSa0Jw
         zXr6+m3gFpSscDa1U1RL1qdkfmCFUdEDHW4hsq2EOdMKNLieQg4y9JZsttZ9MlJqvUxn
         t0/A1ARK9lUfog0lUfVjMXZlX1BfHpYyRTbRUDPl67GYDIc6BED9i5Gd2ewdz+qNYVrS
         0pUaTn5k8ciJmItNhxSy3EXvo8unkVb3CUNnsY/TAgxIiQg6CuDF9H9fnl0Ph1J9hYXl
         w2JfAiSi7jAQrMHtLojiSdBsfmLPQ7zE53gJtuy1eRYEC0RKjPn/7o20ULJElp41RcBp
         1s3w==
X-Gm-Message-State: APjAAAUz/a4yZLi0u7n2MgRoBP5cJQd52MLg/lBCVzCWVwVBo79mOK4E
        K6kFhqcJkF0W4+mQB0PwnhqT9cuG
X-Google-Smtp-Source: APXvYqyqtI3VkkGZ5VdPwnb0h3t4Koir34f1ZwkXKFbnkAS3xPPyLc0DQQR/Tj4/g8fVIwEXFD1fcg==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr32362736wrt.267.1576571589857;
        Tue, 17 Dec 2019 00:33:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h66sm2268246wme.41.2019.12.17.00.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 00:33:09 -0800 (PST)
Message-Id: <49b0b628dbc898fc2dd93603b4bc23d41037e569.1576571586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
        <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 08:33:05 +0000
Subject: [PATCH v3 2/3] dir: remove stray quote character in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 61f559f980..13c0c2333c 100644
--- a/dir.c
+++ b/dir.c
@@ -373,7 +373,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
-		/* name" doesn't match up to the first wild character */
+		/* name doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
 		    ps_strncmp(item, match, name,
 			       item->nowildcard_len - prefix))
-- 
gitgitgadget

