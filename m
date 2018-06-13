Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352DA1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936035AbeFMXGp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:45 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:45753 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936032AbeFMXGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:43 -0400
Received: by mail-ua0-f202.google.com with SMTP id n7-v6so1339981uak.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=QyQtfGpVF0XyCcXqyvEK01FKzdYHpUpm5VYhJJjtQKQ=;
        b=DJjWIG/YGSZk7NTpqGW4wvSJ4A+FqK2eba6BVZDuetCAploaD2x/ShPyk1D71UQINi
         s7+XdvtfyTazmc5emOtA6FQ4wtp+OKToKK7A6J/n+olztvnJ5oJvELjECL+3mbCSCxWG
         X8Bl12DiNXnpheG0tJNu6fkc12j6rtDmS6txOESQJA/WnqXawU4box5qZsOZhVuEz3/j
         dIXL6K7IdCJNHDP1yuArGbtqktO/nfaYmwUqUPZ9epwWWJsZC0gl8py8OAOB6KVlml9e
         fEBlYm7K02RqbKtsjSK/mKHDIeRlxF4cRNuhzvq2DGpI8DGOwjB4XSeDoTdBYZlVn1y5
         N/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=QyQtfGpVF0XyCcXqyvEK01FKzdYHpUpm5VYhJJjtQKQ=;
        b=Rg8Ynn2rVc2fH01+V3Yn61FpzvcvktUISKLPacTox4UR/n5CR6laM30/cvd/gLgl1I
         kPIEx9kWWIGr6FaQSafDhnStaJeoSxm1609FoM8kGqYROvyIZBbCRGEzu8SMXgWQ8lJw
         muqsKLa4oGgblokiwWPO9r4TT828k5IQ2e6NvS8JuQ3G4aYHjl+oX7UHSrVydnovSWA3
         v+WY1l7HIjM4qeJVHUc99hwKBkT4dwwlS2YPGVhZjXkurSTMolbu+fADxoasdxvvUTlZ
         0Hy8DK8W2mJKD9+NjIBi8xfUAdEeczv/kLXemr7f69GZXl5MIHGUJJRY7PAJl3XMgx1d
         hLuw==
X-Gm-Message-State: APt69E1PrCREdZJRQaAVVf0geaeisieHyMyGaT2J+sNns9+KhzLyrzfn
        n2bREw2ooGeil6boaVwYn/PLJxms+KW1sLNJ4DHVTYUU72qOUMyNBnBri/E7zXa/pDQK5Mclk4M
        xRnwALx4qbNed9mhIWOUEAJQfE9EkN/2OsM+irzm+TPt5XsOk878+PbEBp8gN
X-Google-Smtp-Source: ADUXVKITnSK2xFhQ1yKME9ikci5F8JPljdDtu7BTyXUR4C/ND5iivieZaRzBM7ahiSgp1uDZzheAjS+j3Rgz
MIME-Version: 1.0
X-Received: by 2002:a1f:365:: with SMTP id 98-v6mr78584vkd.1.1528931202995;
 Wed, 13 Jun 2018 16:06:42 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:20 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-30-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 29/31] tag.c: allow deref_tag to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 5 ++---
 tag.h | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tag.c b/tag.c
index 682e7793059..94a89b21cb5 100644
--- a/tag.c
+++ b/tag.c
@@ -64,12 +64,11 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	return ret;
 }
 
-struct object *deref_tag_the_repository(struct object *o, const char *warn, int warnlen)
+struct object *deref_tag(struct repository *r, struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(the_repository,
-					 &((struct tag *)o)->tagged->oid);
+			o = parse_object(r, &((struct tag *)o)->tagged->oid);
 		else
 			o = NULL;
 	if (!o && warn) {
diff --git a/tag.h b/tag.h
index efd4c7da67c..e669c3e497a 100644
--- a/tag.h
+++ b/tag.h
@@ -15,8 +15,7 @@ extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
-#define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
-extern struct object *deref_tag_the_repository(struct object *, const char *, int);
+extern struct object *deref_tag(struct repository *r, struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
-- 
2.18.0.rc1.244.gcf134e6275-goog

