Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568031F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJZIHR (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:17 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:56279 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeJZIHR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:17 -0400
Received: by mail-io1-f73.google.com with SMTP id o7-v6so8377463ioh.22
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+rOFzW5bJHQCIBM022kwARqDlluGnq5Nr5y183LRgpg=;
        b=JW+2/Rik53yBG5VNMaxrUZtm5saq3w0k5IaGdMDXHaEAj+i6ywFU487GiJbUDbqr7I
         bQMfvioS2LK569ivVDWcmNvGlm3yWksmMoLaP1KU98V1ibOu+MakPAPnDpMdA31QgAAs
         V5XJVQXAzEz/n/ANNopRRl8H1KuNZ3iKlw7KSLc5WsrqGV+OmMWaWHe6wQpyxkG2RyGJ
         yK8G8O3DGM2pcbR1HJv7GAQHWEQFTooutW3vQNin9MvI0t7CtsAU8KPgfN0bPMaIHHZH
         E2A3NzvotJ2d5ZtWK4wqDKzsQrUYCPoicBO4pjlmv5O3LSGL/yfow6tk9p4+soetO/RI
         felQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+rOFzW5bJHQCIBM022kwARqDlluGnq5Nr5y183LRgpg=;
        b=Jev2fmSunK/T5d5VPamfxh5r0aZPFxcUkUsvWJAcnQTaFNYx+w3r8XfPyBYs2M5uSQ
         gB3a2lC/wrlVuoygERD8N3mWuXcaEyaegbawh2jC1ANgD253PkvrevwPAzC6xyfHv3bT
         ObAOSdBpSdT5kxbXF72WhlxWEqrFG5LMpEwgcAW4jnFLQtBcUmyZRtbQdPphqLbv/WdY
         ZvKMIpbETIUcmry0vzjNwIOi0qlRXrYNPxcLeMzOzHQKSRJz34VQnontCPisHZ+CzN6I
         1yxKEUegjYNhycOpzN7MSVKoBgjOxwZfj5zXUW7Jvz4h/KWy28AaZSEO71zAX6bB0PsZ
         A+Dw==
X-Gm-Message-State: AGRZ1gJodU18B8yJdO8Yo9S4Toj3Gpi/EsVdOZGYbxMzKjrmTDTKVOA5
        1iYM5uOmUJdx/YqV0rovWMsWAySmx3jJ
X-Google-Smtp-Source: AJdET5cLlnTjR/FDW2TnMfbvgaLyl9cB7buaZbOoDQrcC0NDKLpetQTUaLS8MFHHvo2gc6tMgZZ79/ePcgqq
X-Received: by 2002:a24:6955:: with SMTP id e82-v6mr1016165itc.23.1540510358934;
 Thu, 25 Oct 2018 16:32:38 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:22 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 01/10] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
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
index 265941fbf4..d505a004bb 100644
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

