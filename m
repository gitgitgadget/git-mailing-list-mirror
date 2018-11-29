Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5BBD1F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeK2Lbb (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:31 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35217 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2Lbb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:31 -0500
Received: by mail-qk1-f201.google.com with SMTP id k203so198609qke.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hh5iajLx3HhWu+SUvl7wG1EKAL6uFfs9Ft4PKk/aPKE=;
        b=eyYSZsoJDltFh8x8E0xOQ6joReX732ks9a5m0Ch1OgfSVGGSJJ02XfquMTuS5FASKH
         QTOOG4qEyH2qSk/XVerpIT7o/2A/QWI1rqw9y0w1jYNJKpSmi/51K1G6dGan7tONFJ//
         VQubFeo00Ah+Sdl5mLTUMB6UaZr51ICRSK3sOUEDDVZxchQsuSTH9l849cdkpYMdO9sk
         hOPCuVDvHNEKtwjEn0D/QK19ZqDCw1EtmpfgPyglk4tQX0L7ffiQz5QAybeos7Apm/5A
         Ezahzy6mjFn+vHQR0iIe3gJD+5fJ4XxldTp5suXjV9oVgA7im2OtU1buhgmoCzT04//0
         +jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hh5iajLx3HhWu+SUvl7wG1EKAL6uFfs9Ft4PKk/aPKE=;
        b=Z5psMrjKJCmXENftwR8FBr7MlxrQl3CuQROE2bbdqUhRyqqZkg6Sc7UvkuQf9ZIix4
         dxGB5RnfVqAyNQ45og08zCp7f0gBQU4dQX9gwVOnOcX9vmDU9OQsQ6vhLpEO9scfgLrV
         4WhnrS10bdQlkT5WL19C4XCZqcOgMQkEwTbUJw/pBVI0eDQnCYJxfZYD9sj14z6ZTkX5
         WRZp3zY6iH4RKtUH5akOwdM6qXLflY7vkqQQyz3gRhw1z+mZPCSd3VaAJF81qxe+B2TN
         XlofBMZstUQdIXvQdsuztmh+h1RrjQdH9+ZCsgIlgm68lBcZhKvOVSdSaoAUFJqs/Qrs
         e0QA==
X-Gm-Message-State: AA+aEWZzmrGH35tZDBXbO+vAbzwp8LxCQEcqr/ZU2rwWi4cbgVKLgoMm
        L41vLdwSkYgDFFEC8y7UNsmUInGKM9VASjrs9ZPTOY4y5yUjX0ISxSl22unOTup4mFkwjElX/s9
        0RdrDOmbMwoUl12+X1umIkBBWpTh1qPiY7ul0A8Y7/pllDRzg+ipN1APILeGQ
X-Google-Smtp-Source: AFSGD/WE/VVWYsK7AAJp9BhfZTkp2fVbQgYtijXTVAeXWuv2YEzhvEiEn/dwgEyps8MsQjBuxr8iaY+NNy2k
X-Received: by 2002:a37:12e1:: with SMTP id 94mr5035772qks.25.1543451283395;
 Wed, 28 Nov 2018 16:28:03 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:48 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 1/9] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.20.0.rc1.387.gf8505762e3-goog

