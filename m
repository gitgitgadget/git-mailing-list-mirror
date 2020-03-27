Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B77C2D0EF
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9F6206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duX2OsKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgC0AtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:23 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36668 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC0AtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:15 -0400
Received: by mail-wr1-f53.google.com with SMTP id 31so9474204wrs.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=diEoLJ+RCZcUMznOcM44HHVtmUhP2+nSzdW3yYAozHw=;
        b=duX2OsKjDuzbQixs7ksuCUTlIV+PcKwDBZB8Fm73RvaFWWAKLoMJZMoFMvyLyw26wS
         63YiZVUJT1Hj4oy413slDjfKPqeF7+WG4W5pmOjS1SLNrLf5qJDhzBsRHebJ8vcCCQ4R
         n6vUUBkRH9ITmVhgB0tC8kMkBupn7FX5R+pzQuXg292DPIWAh/+9/Z/zqTQbY4faeqEu
         9R2t7myGZk500n9aBk489LJqYlWwGL2QLVwo91UYaOtYsQotLuN5GnF/f/EYh/zqIInU
         HIK2+p01G2UNEXUjjlLku6ByBgIoIgRcbFJx7umrVnVo2GhV4i+iOxGoixzVJdleAaPu
         i6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=diEoLJ+RCZcUMznOcM44HHVtmUhP2+nSzdW3yYAozHw=;
        b=BlciutAnNxCwqWTbo0zpMy3hMrY49KaifZMjqQnB7lf9OH9AqaDGujZbmyWLmmSnKN
         1BikIptffcaeMM3Hi6BNaxu9YJDS2VJermlyfewWQE7p3rf/wBX1aX1IG/4pa9CJkA7h
         X5w5Pqb1sHRs97MFEUu+TrFuyvgnOicZs5WjjCIplmRFIFFlorzJakBTgtqpF17xT/Ra
         ixQzIzHSBo2W1FWBZ7AZSNl9Lp8GC+/pk6nDvYDDpu9TcnFtYPX48uA/y/ykl3AlXBW6
         NrXqXkcKVASkAmt0yR9qf0vop5YQ3OGhGQNiS28oHPECVRgVCPH6gvOcyN0n4+SKat4/
         S6sw==
X-Gm-Message-State: ANhLgQ0nLbpioWdlyH9WDRx2+ovGM0Nzc+JaDbRfeLzvWXcTPxG5Eg+Q
        8to/vsiL45O+lsZuIE+nkCd/82T2
X-Google-Smtp-Source: ADFU+vtUZ2ZVgymZna+ZaY17qg9579Ve4gW2Dk4Wcm0GZLqdUa+YM7d0It2+2k8tVGwqLqbxyENfkQ==
X-Received: by 2002:a5d:53ce:: with SMTP id a14mr1102609wrw.129.1585270152526;
        Thu, 26 Mar 2020 17:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z203sm5980649wmg.12.2020.03.26.17.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:12 -0700 (PDT)
Message-Id: <c3741107a9d59ca8c97f1f4cb4768061fd1d2b2d.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:55 +0000
Subject: [PATCH v3 12/18] unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE
 earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A minor change, but we want to convert the sparse messages to warnings
and this allows us to group warnings and errors.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 12 ++++++------
 unpack-trees.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index a5bc0a3a16d..eeac309e30e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -43,15 +43,14 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_BIND_OVERLAP */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
 
+	/* ERROR_WOULD_LOSE_SUBMODULE */
+	"Submodule '%s' cannot checkout new HEAD.",
+
 	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
 	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
-
-
-	/* ERROR_WOULD_LOSE_SUBMODULE */
-	"Submodule '%s' cannot checkout new HEAD.",
 };
 
 #define ERRORMSG(o,type) \
@@ -166,12 +165,13 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	 */
 	msgs[ERROR_BIND_OVERLAP] = _("Entry '%s' overlaps with '%s'.  Cannot bind.");
 
+	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
+		_("Cannot update submodule:\n%s");
+
 	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
 		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
-	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
-		_("Cannot update submodule:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
diff --git a/unpack-trees.h b/unpack-trees.h
index 5cf41ef5b53..3e996a6c0a9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -22,9 +22,9 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
+	ERROR_WOULD_LOSE_SUBMODULE,
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
 	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
-	ERROR_WOULD_LOSE_SUBMODULE,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
-- 
gitgitgadget

