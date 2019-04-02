Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A672A20248
	for <e@80x24.org>; Tue,  2 Apr 2019 18:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfDBSgB (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 14:36:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58671 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfDBSgB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 14:36:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B70E164ECC;
        Tue,  2 Apr 2019 14:35:56 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Ln+3RKIc4+1gtv687vJ+Y+jNx
        zw=; b=DwMf2B1/EqGyXnaEPfAjrA3T8Jo8EfEJHnWnxKAu5hOjAGuKbAi5N19wf
        FBq/5cASGYSK4y8Zf9RHbGbI18hjEzBCJfdyDReNQuK/0sk+uF8FhMlHipZ4Nkku
        F+96bdUY/8aHOkI2nvQUjAXoyF7INrH9HBGhg5M0WBJpVh1E4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE5DA64ECB;
        Tue,  2 Apr 2019 14:35:56 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=8pBgDRBYkQqv/MU3KvmVVM3Y0EvyNV9T1zL4ECxoaaU=; b=ZYGcKAI6klbkqVH8y7P1n+nb/nn//1psDN2hYfKNXWkRi3Q4dwDrSLEtbOFwe/7BeLMBbymD7TWmydo9S2LAIQdb0M5VOjsy3BPFF3vIqKld84cXRevfZGFfqIzJVHoPfqIHcB8eag7LIqMKzd/yI12zKNcFw4yBwnwx9HBfXQQ=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD1B364EC7;
        Tue,  2 Apr 2019 14:35:52 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Cc:     debian@onerussian.com
Subject: [PATCH v2 3/4] t3009: test that ls-files -o traverses bogus repo
Date:   Tue,  2 Apr 2019 14:35:04 -0400
Message-Id: <20190402183505.31512-4-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402183505.31512-1-kyle@kyleam.com>
References: <87lg1eq146.fsf@kyleam.com>
 <20190402183505.31512-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 25E063EE-5576-11E9-A4D1-EE24A11ADF13-24757444!pb-smtp21.pobox.com
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

