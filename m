Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009BE1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeJKFOT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:19 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35158 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:19 -0400
Received: by mail-yw1-f74.google.com with SMTP id i20-v6so3781789ywe.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1iXIDOW89tjebeBqF/Oz1JJUe+ARiDAxPsK7dMrUv6o=;
        b=tL2z01TC/pgOV4o9+X1qB7QmFTDEtVcV4Q1bXakLRLMOpHWiCVGRYdSa566sxxYe4u
         Rq0zsuDIILWExCuY7dWVbUdDlXE0uj5h0nheka3DRvGx++lXGcMOa+SBrS0BkycEaY30
         CpiIYIySa/52oHg7GXvu7rDDCqCiAjoT4LddzmFhrLNShc7zpmp7NAk96eUxQX1tdGq6
         HAkmQfPgfTFP15UCSD3LQmScbW596ZpPNNjNam6HwD/NWtB2dqL2hiog3q9a1AUSr0PV
         UKafO7fi3o8kjhL8uLaryyHUDWQ/RPtpOdQSWvkDlpJ6JratLE0O5Y1ohEPv+qfY1Drj
         BJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1iXIDOW89tjebeBqF/Oz1JJUe+ARiDAxPsK7dMrUv6o=;
        b=Y218qlzDpNXESY04+o9eD3FWf8tIzv/PQoWcOJJ3/OPQvylYsdtWuVUH+w1b41ZxMg
         E67jIe0ElWFvmHS2Uc6AZvQCEjxOEk41t6HieDxAUkMjqX9WKn+APePAVyr1y2IfZ6+l
         n28rcdOv/63YY3t/0ngwqyhIwJTNU6BcOMwzVZ8YEH3MrprHhzs3Gdvva90l/acyhAoP
         aW6VR6CQl7hcqV9nbNtT43Hzj8RZ5tcnDjZ6aWVS0/6vKUyZp0/+gvtuWGy79dhMr9rA
         HxYFhsbCHeXysZqrSJmcnWOjD0OJfBXzAhWjHaofWLJXY3dYzL4NHERKkDjtLh6DTpfW
         M8xA==
X-Gm-Message-State: ABuFfohHXNHDi+9UmUsgn4ib/+BlFdCpvLzXmj6C7f8Dno72WC66imDT
        y6tBRY67f0K3nGWwK+jc7s4ddsxB0iRjRJzJx/wC5iRW3/FCAqHZA5Swk+kHlcJYkltsM3Jpo+/
        gcewkZK9lJ6a59c2+1v3bpZykQGKzKvS9F1vTVn5wCONK/smJ7YxkAZjK41sz
X-Google-Smtp-Source: ACcGV62Vg4lCM+hdWWy+HwLUCkgEouLhPsfg3wGnEj1wLUPWp5dzYEWKGXhFy26CLBzAMXHb2kR52Yar2Oac
X-Received: by 2002:a25:1286:: with SMTP id 128-v6mr17493997ybs.30.1539208213800;
 Wed, 10 Oct 2018 14:50:13 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:00 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 1/9] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-oid-array.txt |  5 +++++
 sha1-array.c                              | 17 +++++++++++++++++
 sha1-array.h                              |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
index 9febfb1d52..c97428c2c3 100644
--- a/Documentation/technical/api-oid-array.txt
+++ b/Documentation/technical/api-oid-array.txt
@@ -48,6 +48,11 @@ Functions
 	is not sorted, this function has the side effect of sorting
 	it.
 
+`oid_array_filter`::
+	Apply the callback function `want` to each entry in the array,
+	retaining only the entries for which the function returns true.
+	Preserve the order of the entries that are retained.
+
 Examples
 --------
 
diff --git a/sha1-array.c b/sha1-array.c
index b94e0ec0f5..d922e94e3f 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -77,3 +77,20 @@ int oid_array_for_each_unique(struct oid_array *array,
 	}
 	return 0;
 }
+
+void oid_array_filter(struct oid_array *array,
+		      for_each_oid_fn want,
+		      void *cb_data)
+{
+	unsigned nr = array->nr, src, dst;
+	struct object_id *oids = array->oid;
+
+	for (src = dst = 0; src < nr; src++) {
+		if (want(&oids[src], cb_data)) {
+			if (src != dst)
+				oidcpy(&oids[dst], &oids[src]);
+			dst++;
+		}
+	}
+	array->nr = dst;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf95017..55d016c4bf 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -22,5 +22,8 @@ int oid_array_for_each(struct oid_array *array,
 int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
+void oid_array_filter(struct oid_array *array,
+		      for_each_oid_fn want,
+		      void *cbdata);
 
 #endif /* SHA1_ARRAY_H */
-- 
2.19.0

