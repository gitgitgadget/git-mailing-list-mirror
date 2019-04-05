Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9583920248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfDEDhr (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37953 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDEDhr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so2252187plb.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0tTQ10WZWd33DovXUawoSSM0sld+DtFlKe8MHueC55s=;
        b=kaldXoIF5UrsUVVoQymqLiZPtgafJdVpZjMXhy49CG9f17G0SE6bRg++d6Y5EJpqy2
         PPsr3k46FaNTV7Ym63fJDxWQmTcii9fjgMBZNV8NAimSrM5sB8vm4qufE6VbIQTtKGrH
         itzTqujYypu/5TOZiAlQDCZSgeTr1bIRVG4MgnYv579nx3rY4td+elTZa2CJ9g87C8HS
         VgxZhhufwF3/dSEvdYOOd2CBVP9mdZAr6NRDSLIcE32mseF/zr6HjfahaYL3UWWVN7js
         Gy8h+J3/+oXM75XhDPHCqQJH1SgSPlXFiSzipCzp7SMzc5OgXss/jfdiw7D7K8xWq6pz
         s4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0tTQ10WZWd33DovXUawoSSM0sld+DtFlKe8MHueC55s=;
        b=GjalJRQ2fU4fHXeajTgaOka3j7YdCEW1QwLwgGPK2M5G+zAXImGfTv41/vmnNd6gXY
         5escsOYr4o6ChP31brnhGxnCjc39zQgGtCev3nayAwUw0oGovxE/f9bzF+vLPWcv+SAB
         ZHF2edhtxrS7t46pfqoQ8oIMFiOOFDW7ouI3jzuonwnF0kK5mv8/Y1U2OceedIYmT+KY
         klBJBuo/C3TIjLzdScHsUL6OU6KWp+/Hc52RkrLce8oQ5qPAtVRXiIeGUlJbQytF+rEX
         naJ6bvjboX2D0xQ2aBWCGRMYhWDSVqLToCPy6xb754w9jqLGyVk64zFxWEe13du12Gqw
         MsKQ==
X-Gm-Message-State: APjAAAU9knPMGAHrw3cKzspsRUm9ozvRlmwf4uCzPVMqNsiN7NJIZzCE
        2UK7S/b80v7Co9SgxKc3eQBlYRF6XC7JIw==
X-Google-Smtp-Source: APXvYqzvvKyTIHeBwM+hRVaNq7g/cN/4w+XbNgOItLKajamnuuhljmauPeIfEqMYlPbkBteXvQvzLg==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr10049165ple.142.1554435465597;
        Thu, 04 Apr 2019 20:37:45 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id t24sm21250069pfe.110.2019.04.04.20.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:45 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:44 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
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

Let A be the object referenced with an unexpected type, and B be the
object doing the referencing. Do the following:

  - test 'git rev-list --objects A B'. This causes A to be "cached", and
    presents the above scenario.

Likewise, if we have a tree entry that claims to be a tree (for example)
but points to another object type (say, a blob), there are two ways we
might find out:

  - when we call lookup_tree(), we might find that we've already seen
    the object referenced as another type, in which case we'd get NULL

  - we call lookup_tree() successfully, but when we try to read the
    object, we find out it's something else.

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
index 0000000000..472b08528a
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
+	commit="$(git commit-tree $tree -m "first commit")"
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
+	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
+'
+
+test_expect_success 'setup unexpected non-commit parent' '
+	git cat-file commit $commit |
+		perl -lpe "/^author/ && print q(parent $blob)" \
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
+	git cat-file commit $commit |
+	sed -e "s/$tree/$blob/" >broken-commit &&
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
+	test_when_finished "git tag -d tag" &&
+	git cat-file -p tag | sed -e "s/$commit/$blob/" >broken-tag &&
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
+	test_when_finished "git tag -d tag" &&
+	git cat-file -p tag |
+	sed -e "s/$tree/$blob/" >broken-tag &&
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
+	test_when_finished "git tag -d tag" &&
+	git cat-file -p tag |
+	sed -e "s/$blob/$commit/" >broken-tag &&
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

