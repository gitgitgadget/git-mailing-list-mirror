Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7681F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFGBJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:28 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48758 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:28 -0400
Received: by mail-qt1-f202.google.com with SMTP id q13so488617qtj.15
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/b3fJha4NM5K/TtuszksBb/HFoPjGHpcomOcmLu4Xts=;
        b=E3llYSPW/la4DRslopFlTe8SlOR5cstuE3N7ohZbRTaU1pp+q87RiC5xQzEXl95Qio
         SGGZLKrv297YzxWIKzLhDhQdkwVHEMkdJwELuBeHF3dOKrITr02v4Uw+5DfhZRezAqT6
         UHeGCTqK60ZpSgNa1yTXqgtEfhFOiBTva08Ji9jqC4fGbt+H4BrTr3BVku357wWFaN87
         8ThofDpj+XfGe/IeTHZspLQcZT7yCvoPXptK98poJu/P1rFyANx4pI2tz2v1JAwsTF41
         3tzUqDxt3Ayyxq6EdueUPs0d9Gj5X3H746QpyB7EUhkseLDNVgKPyqE4Ps5mPRLF/vBZ
         H80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/b3fJha4NM5K/TtuszksBb/HFoPjGHpcomOcmLu4Xts=;
        b=KiAqjKQ6N14nXn7ZWWTqkvz1514OxEa3jQCgxmvNLiZlnVAZMQCEPGwB1IhHGzXQeh
         dxeKvoqDju7HBo2yHiSLNkgLoS2H0cuci25DbDJKwzp5y7W2KhvY7mEBbXDYmeWvl9D1
         HcEjY9t2/wBLGZ2keyH7F792SjbjXJ2HfCKl0uPFVdhteuP6cHzv8yOtjNBL3xH/oqXJ
         d0/BClARr1wrvOtDdOMvcyNbo1H3Lu3GGlwfw8zVGwk+9JfF8QbIRgeU2cnrbK9gtaKS
         RqiCCaxCOt2T1Io2Zt3dMTPwt+ELcVkdo3TP0dcj1v3ta6VBlmZCcx7oFHDZ4VZpY5Mp
         lOfQ==
X-Gm-Message-State: APjAAAWOKM2kdsJ2lpyOKHlMAkChV49aQERuuUUJIJSNbPamnh14z5DV
        vYAzBZnmtaVubunnEUB5hBAa9+bVxJl0QLTmL8CnRuWCqTLUvYalYiNHlWmzEKfZo9o0VJPlMd3
        DMrcwi1G14Z5x5CFE6JTqIlJ+DJ4cU+RDDb7xdZMITYfwjFpwg29MuipCayft6hkQk5c/XbM7YA
        ==
X-Google-Smtp-Source: APXvYqyFjdEosH0GauAD2ENpmQoABGqhXB+InOWCLLU0Co3JmLkeaaRRLkyloqZBPIKa6lmADrM+XplQhVyTmU0Md2o=
X-Received: by 2002:ae9:f209:: with SMTP id m9mr21201343qkg.251.1559869767025;
 Thu, 06 Jun 2019 18:09:27 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:11 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 13/13] walken: reverse the object walk order
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate that just like commit walks, object walks can have their
order reversed. Additionally, add verbose logging of objects encountered
in order to let contributors prove to themselves that the walk has
actually been reversed. With this commit, `git walken` becomes extremely
chatty - it's recommended to pipe the output through `head` or `tail` or
to redirect it into a file.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index d93725ee88..4bfee3a2d7 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -102,11 +102,13 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 
 static void walken_show_commit(struct commit *cmt, void *buf)
 {
+	printf(_("commit: %s\n"), oid_to_hex(&cmt->object.oid));
 	commit_count++;
 }
 
 static void walken_show_object(struct object *obj, const char *str, void *buf)
 {
+	printf(_("%s: %s\n"), type_name(obj->type), oid_to_hex(&obj->oid));
 	switch (obj->type) {
 	case OBJ_TREE:
 		tree_count++;
@@ -149,6 +151,7 @@ static int walken_object_walk(struct rev_info *rev)
 	rev->tag_objects = 1;
 	rev->tree_blobs_in_commit_order = 1;
 	rev->exclude_promisor_objects = 1;
+	rev->reverse = 1;
 
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
-- 
2.22.0.rc1.311.g5d7573a151-goog

