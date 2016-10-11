Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6A020989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbcJKAVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:46 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35875 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752737AbcJKAVm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:42 -0400
Received: by mail-pa0-f53.google.com with SMTP id ry6so3886508pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0HPw3jFv7UW+9gQGeu2gIDXy5nMvvsY8X5Zo2DEPooI=;
        b=Cb2/cpC3h24olmP3/Sj98Wbak/aCNP2oM23EMgU85IfMYvw+DvPL1gxBZNlLUceyUm
         46uNh7r4Yx2sKVbeSDDw19ayZM4t+KZXrhN88c0l4YDe4iatd2Jc3aJL+UAhnmZTDpGH
         Yk3A1ubJ37AaMgbJR8SbIkwFvW+NLtF6OELq4Trxbnrj4tqD3Tdq2l0FU8RNHe8mvNQ+
         kOxhZr+r+YoRajh8QesJaHEDO6rsMwbfDTkOYfy13DeNv5FYGqXqpc41Z03V9Mqq+Eho
         f0iHoqLetVO6m9ZIFETx2kyaRcps4P8IHIA9zeKZZRnozfi57maYr+/crRCDJbfQf5zx
         XrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0HPw3jFv7UW+9gQGeu2gIDXy5nMvvsY8X5Zo2DEPooI=;
        b=bNIn5jHOF6ZNM3MJnLWVjBOFRgNuz5nhWhvHFilzbPcK8rjXdaZIqJcRQTTtUl8Zdj
         rWfZSbDLVAVrRbIJSSqYUfvv5WYFmu/6wWzEo6gNMgAdVLf2ui44Hs9ScHa64YfP7QM3
         uHspQDMdhcrFgAOu9NRo3OvxVZqx2Du2YMpSDR25GIoRhxQc9JG0AbDzpa2nzBTHs16x
         xNS2F+gHDqhyE3D3xhn9f4dMdABH+LiLtHQs2f2v8hzlflesmtJZeuUEsRKJFKYUaLJ+
         QTvj9EQj2UH03jP3zUvPg7wJrbG9cfPGsgWoZpY6H3m81SV2I92SCDlTo7L1H6g4JmCh
         nH5w==
X-Gm-Message-State: AA6/9Rleaiwocbz+nnbBY+TGW8nWIYPakwiTQyl4qQ1pDbKA009ce7Is+mk5Yhscu+pv1BvT
X-Received: by 10.66.180.17 with SMTP id dk17mr1662798pac.212.1476145296775;
        Mon, 10 Oct 2016 17:21:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id a4sm537945pax.8.2016.10.10.17.21.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/28] attr.c: tighten constness around "git_attr" structure
Date:   Mon, 10 Oct 2016 17:20:55 -0700
Message-Id: <20161011002115.23312-9-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 7bfeef3..5c35d42 100644
--- a/attr.c
+++ b/attr.c
@@ -43,7 +43,7 @@ static int cannot_trust_maybe_real;
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
-char *git_attr_name(struct git_attr *attr)
+const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
 }
diff --git a/attr.h b/attr.h
index 8b08d33..00d7a66 100644
--- a/attr.h
+++ b/attr.h
@@ -25,7 +25,7 @@ extern const char git_attr__false[];
  * Unset one is returned as NULL.
  */
 struct git_attr_check {
-	struct git_attr *attr;
+	const struct git_attr *attr;
 	const char *value;
 };
 
@@ -34,7 +34,7 @@ struct git_attr_check {
  * return value is a pointer to a null-delimited string that is part
  * of the internal data structure; it should not be modified or freed.
  */
-char *git_attr_name(struct git_attr *);
+extern const char *git_attr_name(const struct git_attr *);
 
 int git_check_attr(const char *path, int, struct git_attr_check *);
 
-- 
2.10.1.382.ga23ca1b.dirty

