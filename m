Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B219F20248
	for <e@80x24.org>; Tue,  2 Apr 2019 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfDBSf6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 14:35:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63174 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBSf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 14:35:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DF4364EC9;
        Tue,  2 Apr 2019 14:35:53 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=/zXPjEN6fy8KAleL/49vkFad2
        mE=; b=o68Q50NYhXs5hOcchwEyHwRykE/YPF2uvrsFgyNCfqEwFY5GTUpjNUafj
        x+tpo3EVt2O6FDAiKEr1DaUf0eZLkgyRW+Z7r0H723x4MGx9PxJjnpzvZ9fdQKo6
        X2uSqVICjTOenWNnS09dTCGqABRwWWMeoMVY8CP/j2oUbmRjuI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8721A64EC8;
        Tue,  2 Apr 2019 14:35:53 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=HQWqSnKUq9mnZy+XYe3QbiEcs2ioWpwtOwXJU6NAABY=; b=VdbtahI5oyOzjblV/ux+JpN0FyeMOQu5jkqpwple+CtCEonFS+AVnLYa/f5VxpfdP9JrH//dbj76qLvSrlRPk7RTROGclHlI4uGBPccwLRi1J3ScuJeCQpzigzY2qk94vx1XbnY0oDlEWURX+tNSm200JdLH4/pHS+/8QNNpg60=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B809864EC6;
        Tue,  2 Apr 2019 14:35:49 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Cc:     debian@onerussian.com
Subject: [PATCH v2 2/4] t3000: move non-submodule repo test to separate file
Date:   Tue,  2 Apr 2019 14:35:03 -0400
Message-Id: <20190402183505.31512-3-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402183505.31512-1-kyle@kyleam.com>
References: <87lg1eq146.fsf@kyleam.com>
 <20190402183505.31512-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 23FF5954-5576-11E9-B220-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a2d5156c2b (resolve_gitlink_ref: ignore non-repository paths,
2016-01-22) added a test to t3000-ls-files-others.sh to check that
'ls-files -o' does not die() when given a subdirectory that looks like
a repository but is actually a subdirectory containing a bogus .git
file.

Move this test to a separate file in preparation for testing scenarios
with non-submodule repositories that are not bogus.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t3000-ls-files-others.sh              |  7 -------
 t/t3009-ls-files-others-nonsubmodule.sh | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100755 t/t3009-ls-files-others-nonsubmodule.sh

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index afd4756134..b4f9fc4580 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -65,13 +65,6 @@ test_expect_success '--no-empty-directory hides empty =
directory' '
 	test_cmp expected3 output
 '
=20
-test_expect_success 'ls-files --others handles non-submodule .git' '
-	mkdir not-a-submodule &&
-	echo foo >not-a-submodule/.git &&
-	git ls-files -o >output &&
-	test_cmp expected1 output
-'
-
 test_expect_success SYMLINKS 'ls-files --others with symlinked submodule=
' '
 	git init super &&
 	git init sub &&
diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-o=
thers-nonsubmodule.sh
new file mode 100755
index 0000000000..cc66a4a14d
--- /dev/null
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description=3D'test git ls-files --others with non-submodule reposi=
tories'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: expected output' '
+	cat >expected <<-EOF
+	expected
+	output
+	EOF
+'
+
+test_expect_success 'ls-files --others handles non-submodule .git' '
+	mkdir not-a-submodule &&
+	echo foo >not-a-submodule/.git &&
+	git ls-files -o >output &&
+	test_cmp expected output
+'
+
+test_done
--=20
2.21.0

