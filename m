Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6442F20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfDPJgX (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37587 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so10125005pfr.4
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uz9R+PqbuYzGdOKlwZFS/uMQjQLrusrJjz/EgM7SJU=;
        b=skgJZnQCvIamTGm9FdD52aqz5OzdhC9E+QFcPykF+LrMA+Mgyd8CCOvDxd4ltdyjXH
         h/D9dcs2w0+3hQ0fikXR5dSKp6XRG+Sk9mdbh+lVOSTFt+VJo1Pcb9ohgBhKI1Cnncwf
         gb/TqmKDXdRyJ37vhwqiQRAw1i8Cx9EQH43467pmk4BX+yeagUc8jmSX21lbX3DFXNwk
         wRDYiI367kTt/kKmBwadKfxPh6wAw+CsHhErXn07jA7zbXlYGCTOQRVquVTltkSltpI1
         HS6d4YIQbjfwhUJ96Dd/DdK0Nx8qkS/wwiniwDYpPKeHrHhhGtIJOqBn5+37DAcNRqYs
         XD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uz9R+PqbuYzGdOKlwZFS/uMQjQLrusrJjz/EgM7SJU=;
        b=oEN5ZepWVykykggZx9kg/Xztin+uo8vdJa26LJxiC5Ne1R0VICP4tlMvQYTkDD1dQN
         jbIWsPYpSNg3dnGcYOlZokiW2hE7TTpO+BE7Ce2UmmTP15BTTOHXgBbJcXXx8iz11Jsw
         edHln69b2FUVInxZSBDYvUtWbYmS1KP/c2gYsPiKjvGiCxuLLtV5MHdH6JTqINR/McD5
         TROcljZmjUflAou4sCgXkyE2OuewX1NZTlLnA4TBP1crEU66JZYdPaBPzt8VBD792zc5
         QsBQXa3WJrN4WkMjcA/nzrDdSef22WcXfNN/KF8o1eW7XPJdWSZjvsWDvzz3yY8eXm4Q
         kk9g==
X-Gm-Message-State: APjAAAVxWBku948cQPWRx4Vzs4YGQ8MrYRs8YDzG2TjXtXoXTpyWY8kp
        i9BpC9MDLH0FCmgtPu7xdtI=
X-Google-Smtp-Source: APXvYqzgNeh+IpgiCqr5/LOejHk3EC3M8LvAcLjecexFFFSfITt5cU2hpcgH2UdJZvaK8yuovnfgcQ==
X-Received: by 2002:a65:6489:: with SMTP id e9mr74869499pgv.364.1555407382624;
        Tue, 16 Apr 2019 02:36:22 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id e21sm69458436pfd.177.2019.04.16.02.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 18/34] sha1-name.c: remove the_repo from get_short_oid()
Date:   Tue, 16 Apr 2019 16:33:25 +0700
Message-Id: <20190416093341.17079-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index cdcf84b826..2643b75b54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -436,7 +436,8 @@ static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
 	sort_ambiguous_repo = NULL;
 }
 
-static enum get_oid_result get_short_oid(const char *name, int len,
+static enum get_oid_result get_short_oid(struct repository *r,
+					 const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
 {
@@ -444,7 +445,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
+	if (init_object_disambiguation(r, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -482,8 +483,8 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 			ds.fn = NULL;
 
 		advise(_("The candidates are:"));
-		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		sort_ambiguous_oid_array(the_repository, &collect);
+		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
+		sort_ambiguous_oid_array(r, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
@@ -855,7 +856,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
+	     !get_short_oid(the_repository,
+			    str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -1109,7 +1111,8 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(cp, len, oid, flags);
+				return get_short_oid(the_repository,
+						     cp, len, oid, flags);
 			}
 		}
 	}
@@ -1163,7 +1166,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 	if (!ret)
 		return FOUND;
 
-	return get_short_oid(name, len, oid, lookup_flags);
+	return get_short_oid(the_repository, name, len, oid, lookup_flags);
 }
 
 /*
-- 
2.21.0.682.g30d2204636

