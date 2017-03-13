Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68BBF20373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbdCMUJt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:09:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:58550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753560AbdCMUJr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:09:47 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIu7d-1cpzFt46Cf-002WIs; Mon, 13
 Mar 2017 21:09:33 +0100
Date:   Mon, 13 Mar 2017 21:09:31 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 01/12] t7006: replace dubious test
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <84e77c62345c99911bed5948fdb83bd96d4bfb7f.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QRQZ+ZbyLfirxObNhYtvQCKB7LgFcl93yF6v+prUGbGvxuaDm6S
 NT3WIMGLf5CZaYDmbw7sR3yOFsq+Syq3VIRdo/QXBHCsI1ROtTWLqYfOWZZqXDbaO8sqjZx
 UptTqPlOq3QVGijoBl8OATS1r3oI1jk8GeSv8YgRZ/OPRQk4UJyBa76cCbaheZs6uf08NSQ
 00MvFQVuEIFdfJ2+AFQfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QgTIPr1zONk=:QzdntvBeOptLXAnCGhevDS
 BS77zoeBBcsAIXA/HOUcICnJCRHTdNzKAaFzIH6edI09drokz/93ToBuxGcRZH4kjefQGpEhX
 Y2OJ5v6qyrWVXEmbHbk6D/yOqtYu7kUhXle6bqt9V0pLWhvuMzveig/3AIWgznoto2Z0dPDsS
 sRl5a+dcuz3VSJlihYRgkJPmqAxB7ltNuG4HNXITdjNSZ3/hIfnfDH9DHrupPZM2KsO8s9stE
 sDzpBvCfrtYMYqTT85IwOrS0l/1kIAqD+LEzGJR3qLnuOncOrVavEgCRaOJKq1ZGlJqgiigLA
 o1fQkHiCFLHyfN34/HnOkLW3PVppjNcfc+6/hxMRLaZB+6aU9y7hTsloOkEdVaQTmaboTTgzy
 EdAqFRlxmE+DOCNjlC+LVRhpgsu3WbY6BNcv+Ej59B28aG8jFWIdIhqMVI/IwkPkDlIG2P5h/
 tA4KO5PcHioBCyTgI5McHcQkV+/n4CKgM6Su+Jr4Da4976j3OnOpMBNvbsyo2osW7OkQxtfFa
 rvYFjiMEEpgwcx8Ym9K8BRVVEmrC+OihCSxrnV/dB9Ye+zFiTijvvbw75E3sp9rP2kmJlJuqq
 Rv92jD3P7/qi9J1cLmqjyHdwzq11E2BgmrM6xC5AgiItbTK43ZTyICf4ecMxZrpAB5g505fpR
 3oakn+sJkn+fGBCTqU/QOjs7W3GqWBVHWkuYrghgsPsU/W8KEeuRj5K6RPT4ausGFCQQw3L8C
 jECKfmE6Ztx8uF5Ms9MBb9rpl2/AgrkjIrVYOnwpKJrhmzLgmV3CQpjCLwTFb4qMUliPG/Eiy
 A0qfieb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea of the test case "git -p - core.pager is not used from
subdirectory" was to verify that the setup_git_directory() function had
not been called just to obtain the core.pager setting.

However, we are about to fix the early config machinery so that it
*does* work, without messing up the global state.

Once that is done, the core.pager setting *will* be used, even when
running from a subdirectory, and that is a Good Thing.

The intention of that test case, however, was to verify that the
setup_git_directory() function has not run, because it changes global
state such as the current working directory.

To keep that spirit, but fix the incorrect assumption, this patch
replaces that test case by a new one that verifies that the pager is
run in the subdirectory, i.e. that the current working directory has
not been changed at the time the pager is configured and launched, even
if the `rev-parse` command requires a .git/ directory and *will* change
the working directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7006-pager.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index c8dc665f2fd..304ae06c600 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -378,9 +378,19 @@ test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p request-pull'
 test_default_pager        expect_success test_must_fail 'git -p'
 test_PAGER_overrides      expect_success test_must_fail 'git -p'
 test_local_config_ignored expect_failure test_must_fail 'git -p'
-test_no_local_config_subdir expect_success test_must_fail 'git -p'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
 
+test_expect_failure TTY 'core.pager in repo config works and retains cwd' '
+	sane_unset GIT_PAGER &&
+	test_config core.pager "cat >cwd-retained" &&
+	(
+		cd sub &&
+		rm -f cwd-retained &&
+		test_terminal git -p rev-parse HEAD &&
+		test_path_is_file cwd-retained
+	)
+'
+
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
 
 test_pager_choices                       'git shortlog'
-- 
2.12.0.windows.1.7.g94dafc3b124


