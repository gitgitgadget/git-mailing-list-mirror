Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A801F404
	for <e@80x24.org>; Fri, 23 Mar 2018 05:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeCWF1J (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 01:27:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33744 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCWF1J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 01:27:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id g12so4204842pgs.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kacrIWFqlgy+8y5MjH0g3j4XcofNQ+PJ0hU/rEXTY5w=;
        b=ENYzyqO09LNr+WX3PHghj2qUmh0iPMxFuN7XP0lI3IaNHxc4BgNaaLLjsevFaBaSpr
         HRKPB5I3uKQddi3dmPLVKytEI9ULCnkypuFwEprvt+vu0ypePZlbSU+cSJQtZfZ12WNS
         q9ZlRyY6Nucj01PdQf9pMwHJqJMZaU2pnEvAGnBdw6blNT8iNqh+FvnGN469KrpfunbF
         zoTNvqQJbDnIdOTl78ahZtEH/jTssiKUruIw2f6wPYDpe+lxq6NU+Qt+MTatP0AL9PH0
         75jHAYL1P4+tsRVgHQ+1nTiKsHqXjitStRWeAjvNeqs0ip+qrxi3H5JTPWdOV8fL2Rnn
         RDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kacrIWFqlgy+8y5MjH0g3j4XcofNQ+PJ0hU/rEXTY5w=;
        b=KO9aods7Wj5Gv+EClDe5Gr+Q2ISiMZqMcJkL/L5cNpd5uQ2t65pdhtDz6VyI7tpo+y
         qpOe7pGLuPrLwTUPOlv+z2P0gUASBmm8BobBcOf/Nc3bvFvwWPtN4s50/hpD2U6HBAeW
         ub8mNqiM9gbIIK69FP43s2n3ROITXgk7QaRO3STc0zO2/2LJnpEv7TDswVLztPwg1xTI
         Z0+Mq2VknwEwszhOKhVncN4gmyzGpZINYMquljOnZpA5J+oQtf4+ZXyCMyA+AXDe3HOL
         DbeyKUZjcri3IXqp4BTwZ/0POyL8atN2WL6dZjfNMiBdgAourdqnVXR8AhopejUzK0uK
         hRBQ==
X-Gm-Message-State: AElRT7FX8HQYrJeSlHZ+iE6Oy08ddLLwEtLqp91TrAkBLBNffjreg0M/
        RhUhuZBwsPVj4IM6R0cOTBM=
X-Google-Smtp-Source: AG47ELu53c8sA6PCSn9ya0duzgBz70LCpnbfdUga9xiV1zrYzCkrW7yxTkWzai2qdmEyR4JrSS4j6Q==
X-Received: by 10.98.254.5 with SMTP id z5mr22472089pfh.53.1521782828622;
        Thu, 22 Mar 2018 22:27:08 -0700 (PDT)
Received: from localhost.localdomain (softbank126094251158.bbtec.net. [126.94.251.158])
        by smtp.gmail.com with ESMTPSA id r14sm18106840pfa.163.2018.03.22.22.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Mar 2018 22:27:08 -0700 (PDT)
From:   Yuki Kokubun <orga.chem.job@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yuki Kokubun <orga.chem.job@gmail.com>
Subject: [PATCH v2] filter-branch: fix errors caused by refs that cannot be used with ^0
Date:   Fri, 23 Mar 2018 05:09:13 +0000
Message-Id: <20180323050913.5188-1-orga.chem.job@gmail.com>
X-Mailer: git-send-email 2.16.2.18.g09cb46d
In-Reply-To: <5ab46520.0352650a.cc02b.a177@mx.google.com>
References: <5ab46520.0352650a.cc02b.a177@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git filter-branch -- --all" print unwanted error messages when refs that
cannot be used with ^0 exist. Such refs can be created by "git replace" with
trees or blobs. Also, "git tag" with trees or blobs can create such refs.
---
 git-filter-branch.sh     | 14 ++++++++++++--
 t/t7003-filter-branch.sh | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..41efecb28 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -251,8 +251,18 @@ done < "$tempdir"/backup-refs
 
 # The refs should be updated if their heads were rewritten
 git rev-parse --no-flags --revs-only --symbolic-full-name \
-	--default HEAD "$@" > "$tempdir"/raw-heads || exit
-sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
+	--default HEAD "$@" > "$tempdir"/raw-refs || exit
+while read ref
+do
+	case "$ref" in ^?*) continue ;; esac
+
+	if git rev-parse --verify "$ref"^0 >/dev/null 2>&1
+	then
+		echo "$ref"
+	else
+		warn "WARNING: not rewriting '$ref' (not a committish)"
+	fi
+done >"$tempdir"/heads <"$tempdir"/raw-refs
 
 test -s "$tempdir"/heads ||
 	die "You must specify a ref to rewrite."
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 7cb60799b..04f79f32b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -470,4 +470,18 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
 	git show HEAD:$ambiguous
 '
 
+test_expect_success 'rewrite repository including refs that point at non-commit object' '
+	test_when_finished "git reset --hard original" &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	test_when_finished "git replace -d $tree" &&
+	echo A >new &&
+	git add new &&
+	new_tree=$(git write-tree) &&
+	git replace $tree $new_tree &&
+	git tag -a -m "tag to a tree" treetag $new_tree &&
+	git reset --hard HEAD &&
+	git filter-branch -f -- --all >filter-output 2>&1 &&
+	! fgrep fatal filter-output
+'
+
 test_done
-- 
2.16.2.18.g09cb46d

