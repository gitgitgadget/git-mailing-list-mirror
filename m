Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B31420248
	for <e@80x24.org>; Sun, 17 Mar 2019 23:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCQXCr (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 19:02:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60632 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXCq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 19:02:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E947962A77;
        Sun, 17 Mar 2019 19:02:44 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=ohB6j8uzLY3s8gOYhHCnu0p9NPg=; b=ofU8IpJqzcEmUNYZHeZY
        ax9nFoImeUjfsO0jWyIELYIJQO6PFl//P4pF41YzmTbJVMW9/brObL622e2jmbCP
        tYxJdEiFedn4mT9r/nv6uu20eEJ3HKTTxi/8oGcFV6X9Aho34cY1S5qPJ/70UZrX
        DtjKZ+i0R38EoupCQR+95NE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=bYpAQ9ddK+Z8PQ/8R7V1ffmRFpVvFhcKXFsbAAl1rhluDu
        lGm27KzAY55rpwyIJDesEL7MiGfH7INqITqHtC6x9QQP4YbpTMVnvnJOIR+lwpKu
        /o18woLWX1yOuX65IsnlJMLcrNpn2vmX/OAaIqZsBnBU+Dmn9Qx7UML9eIp6w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E092962A76;
        Sun, 17 Mar 2019 19:02:44 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A443762A75;
        Sun, 17 Mar 2019 19:02:41 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] t4038-diff-combined: quote paths with whitespace
Date:   Sun, 17 Mar 2019 19:02:39 -0400
Message-Id: <20190317230239.10131-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Pobox-Relay-ID: C4AADCF4-4908-11E9-ABC3-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d76ce4f734 ("log,diff-tree: add --combined-all-paths option",
2019-02-07) added tests for files containing tabs.

When the tests are run with bash, the lack of quoting during the file
setup causes 'ambiguous redirect' errors.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Hi,

I noticed these failures while running in a repo where I happened
to have TEST_SHELL_PATH=3D/bin/bash set.  I wonder if we should
have a test matrix which uses bash to catch these sort of things?

 t/t4038-diff-combined.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 07b49f6d6d..d4afe12554 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -480,18 +480,18 @@ test_expect_success FUNNYNAMES 'setup for --combine=
d-all-paths with funny names'
 	git branch side1d &&
 	git branch side2d &&
 	git checkout side1d &&
-	test_seq 1 10 >$(printf "file\twith\ttabs") &&
+	test_seq 1 10 >"$(printf "file\twith\ttabs")" &&
 	git add file* &&
 	git commit -m with &&
 	git checkout side2d &&
-	test_seq 1 9 >$(printf "i\tam\ttabbed") &&
-	echo ten >>$(printf "i\tam\ttabbed") &&
+	test_seq 1 9 >"$(printf "i\tam\ttabbed")" &&
+	echo ten >>"$(printf "i\tam\ttabbed")" &&
 	git add *tabbed &&
 	git commit -m iam &&
 	git checkout -b funny-names-mergery side1d &&
 	git merge --no-commit side2d &&
 	git rm *tabs &&
-	echo eleven >>$(printf "i\tam\ttabbed") &&
+	echo eleven >>"$(printf "i\tam\ttabbed")" &&
 	git mv "$(printf "i\tam\ttabbed")" "$(printf "fickle\tnaming")" &&
 	git add fickle* &&
 	git commit
--=20
Todd
