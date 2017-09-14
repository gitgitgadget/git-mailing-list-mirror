Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387FD209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdINOwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:52:45 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58284 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdINOwp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:52:45 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue104
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MhDBR-1e622k3rZR-00MPQy; Thu, 14
 Sep 2017 16:52:36 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] test-lib: group system specific FIFO tests by system
Date:   Thu, 14 Sep 2017 16:52:33 +0200
Message-Id: <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.712.gda4591c8a2
In-Reply-To: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
X-Provags-ID: V03:K0:Qj4qvJjpBMZii7yN6V8BqP6+Eo3n48GnRRlfmfwRtnl2VuHJknR
 3DyeXRaIWm0j3ygS3xGuLcpWOXrDSLPzZaOl56JVYFSS/cgYw0sBPTrL9k39JolT4Fovymo
 Ez5i1o2TzzeBdEO8Ma/jiSpnrPoPj7Tdqn7aGq7fycphidUEb/F1vWOlNxSBTXyJ6eYvVFY
 GDmPjyIaNG/KEamKBgx5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uYOncZJXPwU=:JxMmHkybenvq/oIG0eBEfU
 MLqL8+al9Q1cho45lSmwnyPkBxaQ3Td3prbjFjb7cZp9EM3IA/xQz6n2mq9XoXed4MT5ZZoAz
 DpsyHDH/cQPCN67F8EAD0CQfObVLgGgw8WTL+OmkM9NgkIUwp5IorTvfFxzaZB6iQh9lc/BcF
 BIRV3famtPTookny8Df/RsVHiWoJ4Wyu8b0WiwdMPMTfseFuR8y8IVYKm7EDkgexCoVmU/fN5
 TT5ubb2e/dS+C2bONB/Az4KTTdxjghU05PX0VYe3wUKb0bXudgGRnFj6u51x6znMTQeIbKLsn
 2bDStCMUdGytsuNddifAg7MPk3djteGUoDr7CEUO9X2n4qloCX1/SUG/M4zrYdodHVRN8H0hj
 LKqWSTwdmhjcpDoOnBWWou5M2E+E/oIfMvhd39+GKODcCYXYrAOWLjcO6UiwQMLYNxkGLPaAz
 p/rSHhPVdKBBn4OKDlm9kKkkKvknbgY1nU8xjsQur6CKZ2U5IeDeOGiVHmZ3ly0r89eT6q8rC
 tnCGNPSCR/TeNmU9bH2ye5XA/9qZRNQpqGqovk8Z8pSaotnhKElHPWyRIOVlRUuxi7Fyx8yrJ
 MakPQt438auFK3ocvKYDv8TQG61iM2hwsDskGHsEktCvL9tb7H0ttRpYQaBh62Xdp0URy7NTQ
 okCpfmEb5zatL7VARD+7atPfCanns6c7NTwxQsNXcm+34lVYpGLt1Dv8IWvkLuqwW7Q4X6swA
 Df7Ad2G1sfXsh8btquaArDbpxhms9RvwrwAFJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-lib determines whether a file-system supports FIFOs and needs to do
special casing for CYGWIN and MINGW. This separates those system
specific settings from those at more central place.

Set mkfifo()  to false in the central system specific place so that the
same test works everywhere.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/test-lib.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5fbd8d4a90..b8a0b05102 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -994,6 +994,10 @@ case $uname_s in
 	pwd () {
 		builtin pwd -W
 	}
+	# no FIFOs
+	mkfifo () {
+		false
+	}
 	# no POSIX permissions
 	# backslashes in pathspec are converted to '/'
 	# exec does not inherit the PID
@@ -1004,6 +1008,10 @@ case $uname_s in
 	GIT_TEST_CMP=mingw_test_cmp
 	;;
 *CYGWIN*)
+	# no FIFOs
+	mkfifo () {
+		false
+	}
 	test_set_prereq POSIXPERM
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq CYGWIN
@@ -1062,14 +1070,7 @@ test_i18ngrep () {
 
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
-	case $(uname -s) in
-	CYGWIN*|MINGW*)
-		false
-		;;
-	*)
-		rm -f testfifo && mkfifo testfifo
-		;;
-	esac
+	rm -f testfifo && mkfifo testfifo
 '
 
 test_lazy_prereq SYMLINKS '
-- 
2.14.1.712.gda4591c8a2

