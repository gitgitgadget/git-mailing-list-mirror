Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400711F576
	for <e@80x24.org>; Thu,  1 Mar 2018 10:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967607AbeCAKvv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 05:51:51 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:29872 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967590AbeCAKvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 05:51:24 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rLnoeYfgY59cnrLnxexaG2; Thu, 01 Mar 2018 10:51:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519901477;
        bh=fQpJez7+LYdgSsTXjeiUDlIwP6aejiRsIYY3flPnODQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=obaw5H/mqFsOHk/6j+Q/mqf/vl5cyFBJHpc3raQ0bwHIpMzX1ytkIlfDr4XJtYglv
         R8xTIz4jgHgXEcIkIYdnoQqjO1RC7+9INSo2YrjDW4UdKUykUjNs50ZCcHXepMqYM1
         DSSoZDRqXYma4VZpk8sI+ezVV0xDPVMBi3phl+TE=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=Yr8hubQX c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=jIkynP5I9sAo3PriuZ8A:9
 a=FXBJT50yf1defmuw:21 a=DYTXFpXuwx9TLzfG:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 5/9] t3701: add failing test for pathological context lines
Date:   Thu,  1 Mar 2018 10:50:59 +0000
Message-Id: <20180301105103.24268-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301105103.24268-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGBkoTsGcgFjx0FvrAMkMajVRFyEVexd8ddU+A2DFRvBpJNJok7ee53VHSak87LhfqT2k5f3lVPd6hBLfc2ZiW4Ul/qOkGKFOS9PU2z7dhZVc0+gLYjL
 +8SzHpGzISsfbX9D9q5s4woEn8mLCMfwhUw+vbV0gQP/EUwpyzRn2pSh7Hh2thBUD37svb6orzBpiGtAmQe9haSIhjEut5LN+43Yne4qwfjqdQVCtjcpf8We
 Ob5AW667mKFSu99J7T/ITfbxVUIEc4shBIlXsCbOQZzjOddr4q6gXiydcCHsFULEeI6pRh9Nqs0tVwOOA0zTnacPhpK4tqnLGK5fsqCzApk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is skipped by add -i the offsets of subsequent hunks are
not adjusted to account for any missing insertions due to the skipped
hunk. Most of the time this does not matter as apply uses the context
lines to apply the subsequent hunks in the correct place, however in
pathological cases the context lines will match at the now incorrect
offset and the hunk will be applied in the wrong place. The offsets of
hunks following an edited hunk that has had the number of insertions
or deletions changed also need to be updated in the same way. Add
failing tests to demonstrate this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - removed test_set_editor as it is already set
    
    changes since v1:
     - changed edit test to use the existing fake editor and to strip
       the hunk header and some context lines as well as deleting an
       insertion
     - style fixes

 t/t3701-add-interactive.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f95714230b..094eeca405 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -531,4 +531,34 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	! grep dirty-otherwise output
 '
 
+test_expect_success 'set up pathological context' '
+	git reset --hard &&
+	test_write_lines a a a a a a a a a a a >a &&
+	git add a &&
+	git commit -m a &&
+	test_write_lines c b a a a a a a a b a a a a >a &&
+	test_write_lines     a a a a a a a b a a a a >expected-1 &&
+	test_write_lines   b a a a a a a a b a a a a >expected-2 &&
+	# check editing can cope with missing header and deleted context lines
+	# as well as changes to other lines
+	test_write_lines +b " a" >patch
+'
+
+test_expect_failure 'add -p works with pathological context lines' '
+	git reset &&
+	printf "%s\n" n y |
+	git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-1 actual
+'
+
+test_expect_failure 'add -p patch editing works with pathological context lines' '
+	git reset &&
+	# n q q below is in case edit fails
+	printf "%s\n" e y    n q q |
+	git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-2 actual
+'
+
 test_done
-- 
2.16.1

