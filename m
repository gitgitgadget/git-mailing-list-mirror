Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C501E1F461
	for <e@80x24.org>; Mon, 13 May 2019 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEMXRk (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:17:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38711 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfEMXRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:17:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so7545740pgl.5
        for <git@vger.kernel.org>; Mon, 13 May 2019 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5KGWlgLIaFfGbNmAYY2dGdpfN8dIpTvYhklN2HMICA=;
        b=RMNU14uBAkFuHHNH7SNM4TzBnAvzILqjR/1+IcO3Hu92Lzjn+R3d/e8XetVyf8e259
         1drMpfhA+GBl66qnhOBAoNzWOX5/OvCLoT0jdTG1bMpgQk5iqQoHACsAHK60V7lIEUc3
         E3B5EHM3zTbMlYibxNoFeolATJQNMrSj1Zlijsa9GZxYmm/xHNGRaZUDjKnWOUXPFcg8
         bWLSx+D9IaDeYRVOHHE85a13K7gbKg5uXACN9fGzIycQpaYEaIMiQaPNE7wQFU37GZ5W
         y7v2r0M5wJrksvB1wXmjwe4M4HQG0VRaazJDr08pdu8i6FYDp0zILJ9jrTJZEBLy/Lwa
         chsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5KGWlgLIaFfGbNmAYY2dGdpfN8dIpTvYhklN2HMICA=;
        b=DmI95x+wT2TlhaNQXV+E/gRzo8kmwextLh74Kfh08ZNO2bkgngSwambgiDxkXX9kjZ
         dVCuz+AxBZHEDv8APi6k5IOxdRpkXKn7IIX38PjBuiD/f57kBVfEj8UCXviv/YVae9qY
         ghg1mUYooaxUW8fDqhnYozJfA4DcQTt6RLnm9obgKxDJ8vY0+r2/muEqaZ9cQo9Rtg0E
         /kDKZtwZRpq9M45+S38JAa6b9dMV7bdImafCI+60bcoz6vn94Pf3Lehh/AjT5IQ4nDxs
         k0YYjF3g27oHVMrXhrPQXVbXXMWwk7RxdDr2sckrR+2uwpGtyrW7xzt3bLl5gKMLSdqU
         4how==
X-Gm-Message-State: APjAAAU6uu9MR/EUlIT5mrb7xvm3HBr+uqD08xBNvJrW9W1buwK85m75
        GqvPfZb0lETrUny7w6oKoN4=
X-Google-Smtp-Source: APXvYqwd+sPwDnZZxF8W4fUPkIcU2cJG9950XqLzDt4RoMUXSa0z7RYmHKKjEPzgd+iPQ0Z7DOAgZQ==
X-Received: by 2002:aa7:808d:: with SMTP id v13mr5819870pff.198.1557789459251;
        Mon, 13 May 2019 16:17:39 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id g10sm30664307pfg.153.2019.05.13.16.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 16:17:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 4/5] fast-export: differentiate between explicitly utf-8 and implicitly utf-8
Date:   Mon, 13 May 2019 16:17:25 -0700
Message-Id: <20190513231726.16218-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd8be4ee826
In-Reply-To: <20190513231726.16218-1-newren@gmail.com>
References: <20190513164722.31534-1-newren@gmail.com>
 <20190513231726.16218-1-newren@gmail.com>
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
2.21.0.782.gd8be4ee826

