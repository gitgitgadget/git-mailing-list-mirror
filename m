Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723BF1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeILEvl (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:41 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:44607 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeILEvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:41 -0400
Received: by mail-yb1-f202.google.com with SMTP id 189-v6so120460ybz.11
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YfBDaNAD0rN0MtBEkxpcso45kYioPIIIjy45WTOmugM=;
        b=ua619HBwvnkhyub2Q7VoihDBy2wjlSCuhDwZiWjw3c3gZ+ceGg2cX9dBNfPZIQQwlb
         /3GnIRCRN0iIhIzXT2gSyKuGj8SFR2qvgC2sDY5oTW5jpPjIknOHjOM3XB8dnS7/ujR7
         6i3x5ZZAhg/wfrWyJVDXxFF2QHlohehfI1VG9kWjdVTYaFncEi8mHoLjOXV1hAgw9Ge+
         PU2vdFsZV2DovKOoR2+mJPNYDHYJPXKdUx29rHT/+ulMfGugwmc0Nrhau3ns7Jd8sW8U
         4Jk+YY1LQmA6eMayS8/8qTEpp34t1mC8Hf5p2KpbudxzB+hrjvvUGFlC4QnstKy8RzRU
         syUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YfBDaNAD0rN0MtBEkxpcso45kYioPIIIjy45WTOmugM=;
        b=WGDQ07exlpr4z5OIOWg7IF0ABqpCu8pwvGL+svtmlvHoALnHwIObbVylE3fFRJENIq
         Oik7ujW5DRmaU+7Iosgw4ahLNJjf2vxUroumRfhE95lOO2fjNS0Vp5nt2HzOfJr3fCIn
         rIMW4ag2IWlucH+DuxL4aKY2iNHwD0AEbiUEca58A7uPWfmian+jZF36/MSktMel/KLa
         fvEb5hKOtZYZREka/dUC3WkBS/S7JHdDLiobB0g/xSMpfQ5X9Ig1EmwTgBAljFAEcO/h
         HuI5ecjLPKhvjpAxk1HmN/xAt9JRluM8jFsvZ56zd0Uhdn83mdekrcSJ+unFSxizvtv5
         Pc3A==
X-Gm-Message-State: APzg51CFj+ZyPeJ5/cWeOMSidqY0SPOOAE8M1uHy35+fHs9/sLxPxDYR
        2ID757nDIf7Q5IuLFyXuel9gIA+zYXozyzUlWy1uynW5x5dFoF77baFnnzyH4jJ28TgJcUSPqew
        W3HVfeOwHWblcZB18zG5gdX0NRc/v5er5bV8Kb74cXKBLGEqCA8ftdL5egs41
X-Google-Smtp-Source: ANB0VdYyf8i9xez1vcEMCQ9dQ1n0UASEumIkPJSboGqvv0HRm208N3uMApIS9CWm9pXorwxDWsIek0GWunqe
X-Received: by 2002:a81:a092:: with SMTP id x140-v6mr7961607ywg.52.1536709802586;
 Tue, 11 Sep 2018 16:50:02 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:44 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 2/9] sha1-array: provide oid_array_filter
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
 sha1-array.c | 18 ++++++++++++++++++
 sha1-array.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index 265941fbf40..76323935dd7 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -77,3 +77,21 @@ int oid_array_for_each_unique(struct oid_array *array,
 	}
 	return 0;
 }
+
+int oid_array_filter(struct oid_array *array,
+		     for_each_oid_fn fn,
+		     void *cbdata)
+{
+	int src, dst;
+
+	for (src = dst = 0; src < array->nr; src++) {
+		if (fn(&array->oid[src], cbdata)) {
+			if (dst < src)
+				oidcpy(&array->oid[dst], &array->oid[src]);
+			dst++;
+		}
+	}
+	array->nr = dst;
+
+	return 0;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf950172..a2d7c210835 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -23,4 +23,9 @@ int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
 
+/* Call fn for each oid, and remove it if fn returns 0, retain it otherwise */
+int oid_array_filter(struct oid_array *array,
+		     for_each_oid_fn fn,
+		     void *cbdata);
+
 #endif /* SHA1_ARRAY_H */
-- 
2.19.0.397.gdd90340f6a-goog

