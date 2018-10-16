Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B712D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJQH2z (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:55 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50990 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:54 -0400
Received: by mail-pl1-f202.google.com with SMTP id ba5-v6so15666020plb.17
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7A3DKYGMNIc9XIZGWKquN69jLzxcxWQvlX+UIOP8c+A=;
        b=u6X+OKFcNyK9QcYjq+0vlXmAXjzGXxrlaAjTaGOrUFOKCcifDuI1E+ecviMBlvVThs
         PBQOslKN1JYmIIoOwYnbbvn81/GPwJdWRd2NfACXHKWZnvs19Da1nPUHvMzPfmxX6BjU
         gDJAhxOQqShu1+lNaRnlF5eYDqHnqp0QqZ2yxlT4z+7D6TaSkm28vNxBWeZGFWRD95tM
         ttRsCSdgGwsdWqy8r+b6azZfa8xtTO1OdPYNI9Yv2nt6QdInb0gmuKL5G7ZqZT8lQj1V
         5rHt9GR3zdGYjfdfDweu5nR4LaTN9eDgUh4cvt2D9n00LeOGkYAr0TRbn2h1XagfCCbY
         nOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7A3DKYGMNIc9XIZGWKquN69jLzxcxWQvlX+UIOP8c+A=;
        b=K/mSqzQsSXKy57sKEcXHf3meJhhT8raQ4I+180ckVEumeoXRGFmOkqChAz249k3JDq
         BWS+YYcJ+D8/cbRxY8IdwbWnSBuIwoG2Hrjc/muDRZOuUQGGeQ5GHMj+WisabwyEg0Cu
         XktiWpNTL41PzcnygYNZIVCLb8n0GwAX90lnYWcx2v+3KDmCOvcSK4qcxzOpPSNnaXmI
         lay0d5NCR482+kyq4O97ol4gzkaEXg1ejzLm/TFAnIPYCmNen8boec2XGe6qXLGxQvzP
         mMUhWReW9HLlV6WP+ZY3QwFNLxSXVlyQ2fCH5g1sR9no9ECPo8vw/0BguRbaHxMop6VQ
         mJHQ==
X-Gm-Message-State: ABuFfojZTaqwRcEvZf+Sp1IlyN3le0G8aHVu+DdICPgtjHTVxtClNa7U
        2EBf/lBvaDP5gb7yU+yVDcCiAVgyHHp9TWjB0hlhyRQ+WqbFmLH+vnRMQepSC2WFZmD88aQxw3U
        Gqs7WzOMT0VGcgkbKBbZ0VFZ7+lCok+WAKGDnW0aEx3nkGwTp3Radqck+/Qcn
X-Google-Smtp-Source: ACcGV60Gkuc/S2d97SiKihwY7YRmBW5Rl3GwLn+fe7eXZ4zN22gyyDIWBoHzkGvblKT3eZt9uqVaxlhrau3e
X-Received: by 2002:a63:7d0a:: with SMTP id y10-v6mr4005172pgc.62.1539732969880;
 Tue, 16 Oct 2018 16:36:09 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:37 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 06/19] object: parse_object to honor its repository argument
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8e4b0b6047 (object.c: allow parse_object to handle
arbitrary repositories, 2018-06-28), we forgot to pass the
repository down to the read_object_file.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object.c b/object.c
index 51c4594515..a32afa14df 100644
--- a/object.c
+++ b/object.c
@@ -259,8 +259,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
-	    (!obj && has_object_file(oid) &&
+	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
+	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
 			error(_("sha1 mismatch %s"), oid_to_hex(oid));
@@ -270,7 +270,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 		return lookup_object(r, oid->hash);
 	}
 
-	buffer = read_object_file(oid, &type, &size);
+	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-- 
2.19.0

