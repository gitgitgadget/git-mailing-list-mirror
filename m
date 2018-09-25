Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B1C1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeIZB5O (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:14 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:40645 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:14 -0400
Received: by mail-it1-f202.google.com with SMTP id k143-v6so9130735ite.5
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8Pj1l1qpHHAI3KTncoubtJ8GKbEYHB+cWW0tdRyGZrg=;
        b=ijvi20nbbbVY1gW74LUli6N31tRaOsMJ85Epq0rBCM5gNBCX04orOSSA0NJCnf05od
         QXdcn11QI7ct/TobbHGFDshZS+T8zS/F1MqB+GfI2WD77JqimNkJkpMmF2sfkR4Ko+gY
         28VZgrFyg3YjA9zOCtlSuPX5t06+Srgt9+ITSYYA2qKHPewBCA9SyNKM/BuIYUuBEy9e
         eSChdP3acEQn//o5EHOSyNmw3c8qAbfHZlvunrEwRidaqubzOkOc/spVhw/Hl5QoQqnF
         T0DLHTt6v7Qrm5WPVfFVnYvtCBRC6kDLdIGBEn8bNQxNEJnwbQDpLmZfIwF5pKkJcwOI
         uMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8Pj1l1qpHHAI3KTncoubtJ8GKbEYHB+cWW0tdRyGZrg=;
        b=GwzkzV0+7t4ikdl4rfdAnlaM9Z1SNrS8PfPMAf9oP35rEjoAh8cJSFOt+0BYKLDucF
         TdEkYex1/PSv2XpWmRedgpb6dh6lVrxpvRN2qhu1OWcymnqydxTQ3ZesGMCXbZizQmzz
         S4GgL/ZrouGVW94mwaq+iIS4fuDvhMIW+20M4XYcYNQIjYa0L2Y5doLUJ3aKiLHTC2xO
         11lEBe1keDiTd9tqumSEx66GfY7c0Mjx+kp3JY442dSYo9DeC513Q7aAVJQkDztgWvZ9
         E2jD4WEB7tOuQaVhdGxKJ1e7cMNbs2zb26fbOstM5ezfnLZBZQ2W+h1jdP9BO4uwEqF4
         Fjtg==
X-Gm-Message-State: ABuFfoibx2CAo4qgoOsKCrWBZdPHCENFIRZ6bHttvGXek45wb0ltLZiw
        C2eD14Fyis+5xdWb3+JsJnobj9j0MoaJ9V9lUOVw62YL2w13pgAFnFS4AD3khj56LjZ2Z7Y6+o2
        T1gffRtAhmJm0wW937AoxeBKoZnMfegUh6XzcSKllciYRTGOMYCWUdKFrOj7d
X-Google-Smtp-Source: ACcGV60hjg2MDwj8KMB0IsltPnx2NTaENCUSsY/bsfhhqVrTYy+yNt84B23lb5cQcRmymS0gGMIg91GihGFP
X-Received: by 2002:a24:d49:: with SMTP id 70-v6mr1884334itx.5.1537904885357;
 Tue, 25 Sep 2018 12:48:05 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:47 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 1/9] sha1-array: provide oid_array_filter
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
index 9febfb1d528..c97428c2c34 100644
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
index b94e0ec0f5e..d922e94e3fc 100644
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
index 232bf950172..55d016c4bf7 100644
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
2.19.0.605.g01d371f741-goog

