Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9A31F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936495AbeF2BXY (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:24 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:53008 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936475AbeF2BXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:21 -0400
Received: by mail-io0-f201.google.com with SMTP id n21-v6so5713955iob.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/LZXeZjMsBe+yWoMz4Qqd3yiG1bJIjkkLFiSnkYXo+Q=;
        b=kHcGAb2q4InNXeTRcpweLxTl69jdxf9qlZ1klhcADxZcuySE2WYPKBTGbnk53MlXWI
         ZnAj+7wsW+lCTrJ3isnolN0S7cfaxM6ypOI6lb980Jf//d4a3wUKAkxu4heblulUxEJh
         111X8dMYN7VByRsMb5v2HNpSNkUK34HBkDXQ10tFzIqOzG/UJjSNGN0AgCI86wtVFcGB
         5Vl3xgtkjmAbWHECUGSPFZC3EZ14HJSj4G6dnK97qfRgz3sJEK8fY25xtyRuC+T3JUHw
         Gpkv3BiYNaISDAPnztuFhth79Bq5faweAWKzDT0Cwr1Bt16skL7HNhjjs7WLHA8Pemvt
         wd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/LZXeZjMsBe+yWoMz4Qqd3yiG1bJIjkkLFiSnkYXo+Q=;
        b=CHk3KHMa+c8nImJB5xs4jGouqM+qvsox+yUxxPRgNjy+ME5iUBfMFTi9OGZeX8W+5U
         nhaoADaB7ioaIcud+502uHipOqpVCaHLMQ++3rekAtfQ7ej3sn0EtmwzEgOnUH4Rw4Ic
         FrYgvpXfvL8C5qIHts/sAxfu1L42ic6oErnFOBhxNggo/dZVkk+7V3BCZl60jN5p+yev
         qBrE/9fv9+wlp8W4EIJmOHHEQXU1kURc5WVkfQlGSOEjidw2662UtygdpriK2EEoYkh2
         HQLiTObym1bc77gmwhrVfyXKZAtIOmNEB9ctTeB90O5IYi8Xa8RtlYMPjpzXPi3JSADx
         CRng==
X-Gm-Message-State: APt69E0QKWHJt6WTM4qqgirT1Kyufa/IFM4P6HgbfYQjUsxBzoDTfHmL
        3kCt1yNW7bGahfD8x8s7+r1lQZ/ZB+yE2C6/i+QF6JanYieQHcrM88R8bSLGe+dp678CicX36Jn
        Um6N8/oTC8DnD5jsttjFIkUSrMoeT84UhlhtjIHIlBntPoSTzfPEILkFof1Ng
X-Google-Smtp-Source: AAOMgpc6tr78u0wZ5ikXF9eQG2ISyNQlEt6ppPxJxrJzy7OtCkwcdcmDHACk/DltHrA8anl7wYQbFJhy5uOR
MIME-Version: 1.0
X-Received: by 2002:a24:35c1:: with SMTP id k184-v6mr81867ita.43.1530235401145;
 Thu, 28 Jun 2018 18:23:21 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:11 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-22-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 21/32] tag: allow lookup_tag to handle arbitrary repositories
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
 tag.c | 10 +++++-----
 tag.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index fbb4659325b..46b5882ee12 100644
--- a/tag.c
+++ b/tag.c
@@ -92,13 +92,13 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag_the_repository(const struct object_id *oid)
+struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_tag_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_TAG, 0);
+		return create_object(r, oid->hash,
+				     alloc_tag_node(r));
+	return object_as_type(r, obj, OBJ_TAG, 0);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tag.h b/tag.h
index 45b0b08b1f6..6a160c91875 100644
--- a/tag.h
+++ b/tag.h
@@ -11,8 +11,7 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-#define lookup_tag(r, o) lookup_tag_##r(o)
-extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
+extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
 #define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
 extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-- 
2.18.0.399.gad0ab374a1-goog

