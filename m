Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1DEEB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGJVMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjGJVMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C6E58
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:16 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-579e212668fso72203267b3.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023535; x=1691615535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9dGpDeDNIt0aOY5wWYLp6BsVyYhTCd6Io6uYGoTqjE=;
        b=4UxPXlCKrXhk153cnVTSxGIUgZfdX9fj8aWazMfaijJ2Rv8nl4VyqF/s69BZW2B7tx
         jnJpbm48Mf2SxMG9MRgFU9oTogXDotZtUMxsOCjQVzmwfm0/6jRUZX3yzVZrDCR4+q+C
         39+RWjgkW4e0ZBtUvHOq0Y1hSUKFMB5NopuD/RPlB4rw0d8D7zWzr5GIOsl1Vy/uZylC
         vkOaMUAfJOc7p0g2eTv5Tk7r/w3NwC2+qC8AUXz58WYlWsbfMqSZGzzpd+6pO7xHI4QG
         0XqRRdI+xWS6JpzlpdpsyxtXSCG4+vKpS9wYOcXpN7xhpBKwlVvi1qnWurVfjBLcdFkf
         HkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023535; x=1691615535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9dGpDeDNIt0aOY5wWYLp6BsVyYhTCd6Io6uYGoTqjE=;
        b=CAyKhtD2lZZcNlab6ptrkply0uSDLQWHk737VInTTxhJ3MrrnSpmP/po47tHwc/1Fe
         hce4Zdumctt1u3YJDtIE/jX6nym5q45zyuuNXvVZNBXhlNGcq5eX7HF/O+DI0FURf3J7
         RDDJu2ITllyHBeGJ6ZJwIut0saCiQwVq4B5Hk9CIUCyueYe6/AteGJ4swx4urmu9ZJ/y
         C0w6fiQmdFUHUIGiRvoA6Zn+wEFzgHxeZ8o3ha1+azBjvsc6BES/K7Prv8Kqfa66MPzD
         Bz4gxBokznjRr31tzVIsoGROPBt1obV0OtGjKoQp9K17KDpmDhNzOKkvdGSutu0+Jk7W
         0Z+Q==
X-Gm-Message-State: ABy/qLawgcuCftgArE58/l4Bkl8p4KkD164xpi+hyqHwC2envU2sMFcF
        a4qM07nZRu3OZP6ITYrNW3zarKyqe3oIJZLgx+3lMg==
X-Google-Smtp-Source: APBJJlGWcmeUAXot1Wix0//evfJYXYcozGZfK+xNPsBSMtKpGBQH38EXNddVq/VvyYI6WFUuN+o5Nw==
X-Received: by 2002:a81:4913:0:b0:579:dfc5:20cc with SMTP id w19-20020a814913000000b00579dfc520ccmr13320772ywa.17.1689023535158;
        Mon, 10 Jul 2023 14:12:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q63-20020a817542000000b0057a68b6c2f4sm179810ywc.133.2023.07.10.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:14 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <00a4532d54d81953c931bdd948e708f90c0df15a.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We did not bother to clean up at all in `git branch` or `git tag`, and
`git for-each-ref` only cleans up a couple of members.

Add and call `ref_filter_clear()` when cleaning up a `struct
ref_filter`. Running this patch (without any test changes) indicates a
couple of now leak-free tests. This was found by running:

    $ make SANITIZE=leak
    $ make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=--immediate

(Note that the `reachable_from` and `unreachable_from` lists should be
cleaned as they are used. So this is just covering any case where we
might bail before running the reachability check.)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/branch.c        |  1 +
 builtin/for-each-ref.c  |  3 +--
 builtin/tag.c           |  1 +
 ref-filter.c            | 16 ++++++++++++++++
 ref-filter.h            |  3 +++
 t/t0041-usage.sh        |  1 +
 t/t3402-rebase-merge.sh |  1 +
 7 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 322646f38f5..f06df4be7a5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -855,6 +855,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		ref_sorting_release(sorting);
+		ref_filter_clear(&filter);
 		return 0;
 	} else if (edit_description) {
 		const char *branch_name;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6b5e313123f..ccceba54aa1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -120,8 +120,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	strbuf_release(&err);
 	strbuf_release(&output);
 	ref_array_clear(&array);
-	free_commit_list(filter.with_commit);
-	free_commit_list(filter.no_commit);
+	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
 	strvec_clear(&vec);
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index a624185d105..f33600c0506 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -659,6 +659,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	ref_sorting_release(sorting);
+	ref_filter_clear(&filter);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/ref-filter.c b/ref-filter.c
index 4dd6575400c..84cd3921307 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2866,3 +2866,19 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
 	return 0;
 }
+
+void ref_filter_init(struct ref_filter *filter)
+{
+	struct ref_filter blank = REF_FILTER_INIT;
+	memcpy(filter, &blank, sizeof(blank));
+}
+
+void ref_filter_clear(struct ref_filter *filter)
+{
+	oid_array_clear(&filter->points_at);
+	free_commit_list(filter->with_commit);
+	free_commit_list(filter->no_commit);
+	free_commit_list(filter->reachable_from);
+	free_commit_list(filter->unreachable_from);
+	ref_filter_init(filter);
+}
diff --git a/ref-filter.h b/ref-filter.h
index a920f73b297..160b8072245 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -170,4 +170,7 @@ void filter_ahead_behind(struct repository *r,
 			 struct ref_format *format,
 			 struct ref_array *array);
 
+void ref_filter_init(struct ref_filter *filter);
+void ref_filter_clear(struct ref_filter *filter);
+
 #endif /*  REF_FILTER_H  */
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index c4fc34eb18e..9ea974b0c6c 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -5,6 +5,7 @@ test_description='Test commands behavior when given invalid argument value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 79b0640c004..e9e03ca4b5e 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -8,6 +8,7 @@ test_description='git rebase --merge test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 T="A quick brown fox
-- 
2.41.0.343.gdff068c469f

