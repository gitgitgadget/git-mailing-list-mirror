Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D5520248
	for <e@80x24.org>; Thu, 28 Mar 2019 17:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfC1RR4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 13:17:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41114 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfC1RR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 13:17:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so16210390wrq.8
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SLhjRdKqdGMkk/almrjdvnpSk+ZwIzdmxeVAGcOkLg=;
        b=W8qpINTjg7xVtJ9a1H05sVi2c7JmPcjv3Wu5mv3qulmV7cW4vtVXbkohLWB3MFzHpD
         Dv5dgSpgHetr0rgb2UTEudxb+MP9voXiG1E+f2uwdaCBmN2M4kNA6oVyqbQq3B/ob0r3
         iOTHeUOtCmJmmg+qCspfTuBhxYNWBvk7AdsrlGqPpCmDJsGrf+DB9JRMjY+z41JI9aar
         xRW3jqCiR478pZFvW531AQ+JaAGNMhsePHSTMHcogAFwFJO0SvADOV3HbrXJ1+NR8Iir
         DTVi65t37qIIyt9E7hIaAQnzJh6roTomeLKorUMeXere/K5ekPFrKgS1rDjC2bBx4kUd
         LT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SLhjRdKqdGMkk/almrjdvnpSk+ZwIzdmxeVAGcOkLg=;
        b=nXiOyNE7WWWTpeb+9a2Q5pdMRC4Yr3CuS3v5OlL6Qx1QfiobliCYNL2USD6MkNAjzw
         nJkdmcNnu0/U35pM0M5+GZ8eBLVY7dJPvQCFxbPjBE/1D9fxL6WSn4N6AE7veolPACQO
         zFx2jSOS8oYUTaa3olyiZ9Re0gECIJSUIkGOjOSjxEUgnk+Yqe+yTnObSKVoh7+pmDZr
         4OueoEmo49rwV8MStMvcVkbsXQXAPFuNjkC/W65ubz1CtT43HgZRNvLwUQdNUKC8M4Rh
         /D4wAWmkXFxBDWPTE59PIS7mJN/kCVC1HL6Kne2qvOIRwMW+xsPyHdv5btGY7kD1p9BB
         9krQ==
X-Gm-Message-State: APjAAAUHX+2cKBtutFzI1k1D0/asNJzO1XTSgYIRzicj6hb9YOV19Vio
        SRJU+IvSMZDcsAeb/DbWFD5hK48H
X-Google-Smtp-Source: APXvYqwIQ3ITj8YFFaoC5jpFA2ofXwkudxhKe5WHM8AxRAkiq63sB+dwcpmbJMmJsLl6L0uNszG6Gg==
X-Received: by 2002:adf:f488:: with SMTP id l8mr27753762wro.213.1553793474428;
        Thu, 28 Mar 2019 10:17:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1085:dfe0:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id d17sm25837369wrw.88.2019.03.28.10.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:17:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] replace: fix --graft when passing a tag
Date:   Thu, 28 Mar 2019 18:17:22 +0100
Message-Id: <20190328171722.9753-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.68.gd997bba285.dirty
In-Reply-To: <20190328171722.9753-1-chriscool@tuxfamily.org>
References: <20190328171722.9753-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When passing a tag as a parent argument to `git replace --graft`,
it can be useful to accept it and use the underlying commit as a
parent.

This already works for lightweight tags, but unfortunately
for annotated tags we have been using the hash of the tag object
instead of the hash of the underlying commit as a parent in the
replacement object we create.

This created invalid objects, but the replace succeeded even if
it showed an error like:

error: object A is a tag, not a commit

This patch fixes that by using the hash of the underlying commit
when an annotated tag is passed.

While at it, let's also update an error message to make it
clearer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This doesn't fix issues when an annotated tag is passed as the
replaced object, that is when the tag is the first argument after
`git replace --graft`. But this can be done in subsequent patches
I already started to work on. 

 builtin/replace.c  |  9 ++++++---
 t/t6050-replace.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index f5701629a8..b0a9227f9a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -370,16 +370,19 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 	/* prepare new parents */
 	for (i = 0; i < argc; i++) {
 		struct object_id oid;
+		struct commit *commit;
+
 		if (get_oid(argv[i], &oid) < 0) {
 			strbuf_release(&new_parents);
 			return error(_("not a valid object name: '%s'"),
 				     argv[i]);
 		}
-		if (!lookup_commit_reference(the_repository, &oid)) {
+		commit = lookup_commit_reference(the_repository, &oid);
+		if (!commit) {
 			strbuf_release(&new_parents);
-			return error(_("could not parse %s"), argv[i]);
+			return error(_("could not parse %s as a commit"), argv[i]);
 		}
-		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
+		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&commit->object.oid));
 	}
 
 	/* replace existing parents with new ones */
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 5cb8281bab..72075983ac 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -405,6 +405,17 @@ test_expect_success '--graft with and without already replaced object' '
 	git replace -d $HASH5
 '
 
+test_expect_success '--graft using a tag as the new parent' '
+	git tag new_parent $HASH5 &&
+	git replace --graft $HASH7 new_parent &&
+	commit_has_parents $HASH7 $HASH5 &&
+	git replace -d $HASH7 &&
+	git tag -a -m "annotated new parent tag" annotated_new_parent $HASH5 &&
+	git replace --graft $HASH7 annotated_new_parent &&
+	commit_has_parents $HASH7 $HASH5 &&
+	git replace -d $HASH7
+'
+
 test_expect_success GPG 'set up a signed commit' '
 	echo "line 17" >>hello &&
 	echo "line 18" >>hello &&
-- 
2.21.0.68.gd997bba285.dirty

