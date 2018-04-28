Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10BAE1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeD1Wds (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:33:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:53181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeD1Wds (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:33:48 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MYwQh-1erG7B2bvX-00Vi2Q; Sun, 29 Apr 2018 00:33:42 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tests: introduce test_unset_prereq, for debugging
Date:   Sun, 29 Apr 2018 00:33:36 +0200
Message-Id: <b94af009c1bc9c9b96d977b1c5775ff73669138f.1524954814.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:UkhJSadKN7OHRBMizVRDVcnXNx9oVzqBG3OlYxHujfDSPnm/VeX
 B4RUJoq+e2zf4CEW/OO3xdCehXnQjegB8yP9tfAmYBLATRlKdwfBfur1H3tygbu1NYxCVTy
 +Ytda7DWA9pF9X2/9sl5FyDTBxyYx1KDWX3VM5Zq/Hn2VXokLNcrDGOrEKH3OQsSHQV2PDr
 Umb8G5lBKfjtwhHr0zcAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DMrXH8WV8s8=:63lgUR3u5gvniXZh5PvZdL
 meYdlJK0NYvhBbhIRZfoOnjrrSq+JNi7B0lovyjyAoQ/ERITv38n+FQK/+C5Kyzdo0bWp5mw1
 twIRqU+Av76VrGNNHSf5akuyAkvLZ3o5EZq9WNKTJ5Y2uHsxUKSkl/uZ5yn1pl0XBceLZ2pcp
 SD7zhqWXuRkBIyBxeNMt8bz4jnu5M4IfX16NeS/9rPWVZpdDO41wwdLnG0Xo4qdjp+GkT+8dI
 PjVn3IVqHGDhzZ6KydU1cYvzYdazde4MMmQJMoyxD2yMPRiYShYMemW6ZkVDX8pO88d4RU/pr
 dZbFqLLXDZH+kzzePmme3yBvXw8XaREVlEcDYezHUIoyDyra0F/vPm5hwBuxLlxcbI5PuzP7w
 7YtKt9UBgDs1V+3gKpaoepjbKVbSDiUVP33ED/I0ODDsPvVTmhON/9mK+hdIuNiRoOplYWMF+
 otKCEOFGVgDunqDpWU4EmHoIBJQKfNdRknMMK3g33qADlJowLXvbc+gKOiOe/GzlNwWh09UQE
 9dOCM0unv2otAPqWOlTqo8naAUMyckZeD28JuVLInslRxtKAGJuNs0AOBU03oP5ur5B5TMOux
 6lpQ0AP59vwmtPCQFDtkganTYt91xdOS/6zK8CIEvuygscXbqXsTpckaVB5poabSptyZ40zBP
 gtuwt46yz9vJHJIeid7ssgfJmiXFKa8IBDu6ehABYSKhZZgJIYO3ISiveP85zPptoUSjW5+tx
 OlxeVDcOuSARx4XbAZ8e0+oXb9hzUTNVQdjay9dni00nCjqZIlCwt1NadDe3IRmb2RhPnB0Xd
 TNqS2Yq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on the --convert-graft-file test, I missed that I was
relying on the GPG prereq, by using output of test cases that were only
run under that prereq.

For debugging, it was really convenient to force that prereq to be
unmet, but there was no easy way to do that. So I came up with a way,
and this patch reflects the cleaned-up version of that way.

For convenience, the following two methods are now supported ways to
pretend that a prereq is not met:

	test_set_prereq !GPG

and

	test_unset_prereq GPG

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/test-unset-prereq-v1
Fetch-It-Via: git fetch https://github.com/dscho/git test-unset-prereq-v1
 t/test-lib-functions.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7d620bf2a9a..76cd6630f29 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -278,8 +278,20 @@ write_script () {
 # The single parameter is the prerequisite tag (a simple word, in all
 # capital letters by convention).
 
+test_unset_prereq () {
+	! test_have_prereq "$1" ||
+	satisfied_prereq="${satisfied_prereq% $1 *} ${satisfied_prereq#* $1 }"
+}
+
 test_set_prereq () {
-	satisfied_prereq="$satisfied_prereq$1 "
+	case "$1" in
+	!*)
+		test_unset_prereq "${1#!}"
+		;;
+	*)
+		satisfied_prereq="$satisfied_prereq$1 "
+		;;
+	esac
 }
 satisfied_prereq=" "
 lazily_testable_prereq= lazily_tested_prereq=

base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
-- 
2.17.0.windows.1.36.gdf4ca5fb72a
