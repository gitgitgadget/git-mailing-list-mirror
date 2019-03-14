Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC77220248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCNPJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:09:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62062 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCNPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:09:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26D3F5C5A4;
        Thu, 14 Mar 2019 11:03:08 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Ln+3RKIc4+1gtv687vJ+Y+jNx
        zw=; b=NsRRbfhLw+5RNtbByFkv8rPqUedKrcY7M5ZbAqqjEbZJ2znyeJLCvomyx
        ZnPepPLcK94bJiSMhvFZ/VWbFz81jQFlFh4RuLdOjKizfRYhvpdAsYFTymc+pCqj
        DqJJLWq3K9XVkboRLC02Bf3Pc7UHrTxO7pcXgapNpFuUsSIVio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1EC5D5C5A3;
        Thu, 14 Mar 2019 11:03:08 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=8pBgDRBYkQqv/MU3KvmVVM3Y0EvyNV9T1zL4ECxoaaU=; b=qxKdY1DzWTFDQw5E0xCVsobTVGsVtO04XNubGCfREXX02MGbRN8qTZYcJMcuNgbxXbGGZXcuzrO220yYJJcP6GU+l9McXgveJGa59iiFXLhIMrdpR119aZiwBtk+G9+8Ubln7tl+aTrQUkGUtf9W+XZVJe0IWkXlphFoAS0H8/4=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57F005C59D;
        Thu, 14 Mar 2019 11:03:04 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     debian@onerussian.com, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH 3/4] t3009: test that ls-files -o traverses bogus repo
Date:   Thu, 14 Mar 2019 11:02:18 -0400
Message-Id: <20190314150219.2040-4-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314150219.2040-1-kyle@kyleam.com>
References: <20190314150219.2040-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 455EC442-466A-11E9-A70A-D01F9763A999-24757444!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a2d5156c2b (resolve_gitlink_ref: ignore non-repository paths,
2016-01-22) added this test, the purpose was to check the 'ls-files
-o' didn't die() when processing the bogus repository.  The expected
output didn't even need to be adjusted for the addition because the
bogus repository is treated as an empty directory.

Let's add another scenario to test that 'ls-files -o' lists an
untracked file within this directory.  Doing so isn't useful for the
original purpose of the test, but it will be helpful for highlighting
that this traversal does _not_ happen in the non-bogus scenarios that
will be added next.  Rename the original subdirectory to highlight the
difference with the new one.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t3009-ls-files-others-nonsubmodule.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-o=
thers-nonsubmodule.sh
index cc66a4a14d..9ed75928aa 100755
--- a/t/t3009-ls-files-others-nonsubmodule.sh
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -1,6 +1,14 @@
 #!/bin/sh
=20
-test_description=3D'test git ls-files --others with non-submodule reposi=
tories'
+test_description=3D'test git ls-files --others with non-submodule reposi=
tories
+
+This test runs git ls-files --others with the following working tree:
+
+    repo-bogus-no-files/
+      directory with no files aside from a bogus .git file
+    repo-bogus-untracked-file/
+      directory with a bogus .git file and another untracked file
+'
=20
 . ./test-lib.sh
=20
@@ -8,12 +16,19 @@ test_expect_success 'setup: expected output' '
 	cat >expected <<-EOF
 	expected
 	output
+	repo-bogus-untracked-file/untracked
 	EOF
 '
=20
+test_expect_success 'setup: directories' '
+	mkdir repo-bogus-no-files &&
+	echo foo >repo-bogus-no-files/.git &&
+	mkdir repo-bogus-untracked-file &&
+	echo foo >repo-bogus-untracked-file/.git &&
+	: >repo-bogus-untracked-file/untracked
+'
+
 test_expect_success 'ls-files --others handles non-submodule .git' '
-	mkdir not-a-submodule &&
-	echo foo >not-a-submodule/.git &&
 	git ls-files -o >output &&
 	test_cmp expected output
 '
--=20
2.21.0

