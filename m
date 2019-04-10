Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70DB20248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDJCNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCNR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so399677plo.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=184R+gIqcEZHsADEqxOOSCWhDR9lJDz8+T+aZFKddmI=;
        b=SjSo8ARAs9TycQU62bvePVV2D58RIN+S7i7Ajg3ozrNMLUFB0Zhrzd2V73kBr51XY8
         gQIlHnaULotzUMePW4BS1QQtU9qmNSrsmm5CXq6Sqr8y311Vdb9EalOVf+iMDXLZImul
         p7q2zn2iwUqH9d24h4FS/pSRq9uwqUQWcK0VqcQSTpEN6uBd4Jw5vZF3o6j70+QWfBcP
         gXLt6TMh+5LMhov6yiiG1s1ACfm7xNd46iJaN5iX371kgEoJt2m47C1oFHNPqLh/R8cA
         ihJ30tD2QHHFIEqQQY1fyIh25kdbQKiO4cBFpdWgouEspENCHQ1qQMF1K7gxjn5+SUwX
         PAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=184R+gIqcEZHsADEqxOOSCWhDR9lJDz8+T+aZFKddmI=;
        b=jA0G2yGHAd61mhtZsaELJxCZRWMkdY7XL/fm1zXRLoYzo9678X3KEhHn4kBH2gzME/
         FAAl8eAteKaYZGTzx7GZfeHFqFfjHngCGIp5ngvzMGzutMe6euBCKgLvcP+huJBFIW/Z
         zb1gy04Q8lMDIWeaIAsJSu5Qv9uBbehysxschQvtBAJAeQvkJUoIXqQOfil/eief5z/e
         2yLfFiCXDwDpkKFxtC+bkV5AkPXNmQLWE7hVfwRqRBGC3XtdP7hrxfLvCzBQdZFAHLX3
         W6fNW2EdBZvwhajZ86AH9QmcvlRCOrOjxLmlzsBAGKSZW9vAXwN5u7L8vbNuNsIhavV/
         eg0w==
X-Gm-Message-State: APjAAAVNyb4PwmBGioN6RqGZ/QJCgD0abCTNssh7kdm7LySDoSmYa3/i
        wR99TEa9hPa7/7O7cTDl2Fs7X/ngXJTAjZdR
X-Google-Smtp-Source: APXvYqwlUG0L6S/Bl1klis8HMrM0wjGbChnWjQLGtdASKAi1/WyzNiLHIKmyIijIGLN998SHvE9jug==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr39412727plb.143.1554862395886;
        Tue, 09 Apr 2019 19:13:15 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id k10sm22966695pgo.82.2019.04.09.19.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:15 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:14 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 2/7] t: introduce tests for unexpected object types
Message-ID: <137e2df24d80f796675691e57d08948b6eede6e3.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
 <cover.1554861974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554861974.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call an object's type "unexpected" when the actual type of an object
does not match Git's contextual expectation. For example, a tree entry
whose mode differs from the object's actual type, or a commit's parent
which is not another commit, and so on.

This can manifest itself in various unfortunate ways, including Git
SIGSEGV-ing under specific conditions. Consider the following example:
Git traverses a blob (say, via `git rev-list`), and then tries to read
out a tree-entry which lists that object as something other than a blob.
In this case, `lookup_blob()` will return NULL, and the subsequent
dereference will result in a SIGSEGV.

Introduce tests that present objects of "unexpected" type in the above
fashion to 'git rev-list'. Mark as failures the combinations that are
already broken (i.e., they exhibit the segfault described above). In the
cases that are not broken (i.e., they have NULL-ness checks or similar),
mark these as expecting success.

We might hit an unexpected type in two different ways (imagine we have a
tree entry that claims to be a tree but actually points to a blob):

  - when we call lookup_tree(), we might find that we've already seen
    the object referenced as a blob, in which case we'd get NULL. We
    can exercise this with "git rev-list --objects $blob $tree", which
    guarantees that the blob will have been parsed before we look in
    the tree. These tests are marked as "seen" in the test script.

  - we call lookup_tree() successfully, but when we try to read the
    object, we find out it's something else. We construct our tests
    such that $blob is not otherwise mentioned in $tree. These tests
    are marked as "lone" in the script.

We should check that we behave sensibly in both cases (especially
because it is easy for a malicious actor to provoke one case or the
other).

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6102-rev-list-unexpected-objects.sh | 123 +++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 t/t6102-rev-list-unexpected-objects.sh

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
new file mode 100755
index 0000000000..15072ecce3
--- /dev/null
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='git rev-list should handle unexpected object types'
+
+. ./test-lib.sh
+
+test_expect_success 'setup well-formed objects' '
+	blob="$(printf "foo" | git hash-object -w --stdin)" &&
+	tree="$(printf "100644 blob $blob\tfoo" | git mktree)" &&
+	commit="$(git commit-tree $tree -m "first commit")" &&
+	git cat-file commit $commit >good-commit
+'
+
+test_expect_success 'setup unexpected non-blob entry' '
+	printf "100644 foo\0$(echo $tree | hex2oct)" >broken-tree &&
+	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
+'
+
+test_expect_failure 'traverse unexpected non-blob entry (lone)' '
+	test_must_fail git rev-list --objects $broken_tree
+'
+
+test_expect_failure 'traverse unexpected non-blob entry (seen)' '
+	test_must_fail git rev-list --objects $tree $broken_tree
+'
+
+test_expect_success 'setup unexpected non-tree entry' '
+	printf "40000 foo\0$(echo $blob | hex2oct)" >broken-tree &&
+	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
+'
+
+test_expect_failure 'traverse unexpected non-tree entry (lone)' '
+	test_must_fail git rev-list --objects $broken_tree
+'
+
+test_expect_failure 'traverse unexpected non-tree entry (seen)' '
+	test_must_fail git rev-list --objects $blob $broken_tree
+'
+
+test_expect_success 'setup unexpected non-commit parent' '
+	sed "/^author/ { h; s/.*/parent $blob/; G; }" <good-commit \
+		>broken-commit &&
+	broken_commit="$(git hash-object -w --literally -t commit \
+		broken-commit)"
+'
+
+test_expect_success 'traverse unexpected non-commit parent (lone)' '
+	test_must_fail git rev-list --objects $broken_commit >output 2>&1 &&
+	test_i18ngrep "not a commit" output
+'
+
+test_expect_success 'traverse unexpected non-commit parent (seen)' '
+	test_must_fail git rev-list --objects $commit $broken_commit \
+		>output 2>&1 &&
+	test_i18ngrep "not a commit" output
+'
+
+test_expect_success 'setup unexpected non-tree root' '
+	sed -e "s/$tree/$blob/" <good-commit >broken-commit &&
+	broken_commit="$(git hash-object -w --literally -t commit \
+		broken-commit)"
+'
+
+test_expect_failure 'traverse unexpected non-tree root (lone)' '
+	test_must_fail git rev-list --objects $broken_commit
+'
+
+test_expect_failure 'traverse unexpected non-tree root (seen)' '
+	test_must_fail git rev-list --objects $blob $broken_commit
+'
+
+test_expect_success 'setup unexpected non-commit tag' '
+	git tag -a -m "tagged commit" tag $commit &&
+	git cat-file tag tag >good-tag &&
+	test_when_finished "git tag -d tag" &&
+	sed -e "s/$commit/$blob/" <good-tag >broken-tag &&
+	tag=$(git hash-object -w --literally -t tag broken-tag)
+'
+
+test_expect_success 'traverse unexpected non-commit tag (lone)' '
+	test_must_fail git rev-list --objects $tag
+'
+
+test_expect_success 'traverse unexpected non-commit tag (seen)' '
+	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
+	test_i18ngrep "not a commit" output
+'
+
+test_expect_success 'setup unexpected non-tree tag' '
+	git tag -a -m "tagged tree" tag $tree &&
+	git cat-file tag tag >good-tag &&
+	test_when_finished "git tag -d tag" &&
+	sed -e "s/$tree/$blob/" <good-tag >broken-tag &&
+	tag=$(git hash-object -w --literally -t tag broken-tag)
+'
+
+test_expect_success 'traverse unexpected non-tree tag (lone)' '
+	test_must_fail git rev-list --objects $tag
+'
+
+test_expect_success 'traverse unexpected non-tree tag (seen)' '
+	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
+	test_i18ngrep "not a tree" output
+'
+
+test_expect_success 'setup unexpected non-blob tag' '
+	git tag -a -m "tagged blob" tag $blob &&
+	git cat-file tag tag >good-tag &&
+	test_when_finished "git tag -d tag" &&
+	sed -e "s/$blob/$commit/" <good-tag >broken-tag &&
+	tag=$(git hash-object -w --literally -t tag broken-tag)
+'
+
+test_expect_failure 'traverse unexpected non-blob tag (lone)' '
+	test_must_fail git rev-list --objects $tag
+'
+
+test_expect_success 'traverse unexpected non-blob tag (seen)' '
+	test_must_fail git rev-list --objects $commit $tag >output 2>&1 &&
+	test_i18ngrep "not a blob" output
+'
+
+test_done
-- 
2.21.0.203.g358da99528

