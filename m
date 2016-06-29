Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDBA1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 07:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbcF2HCq (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 03:02:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:53061 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbcF2HCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 03:02:45 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ledpu-1bgztA0S9W-00qWAR; Wed, 29 Jun 2016 09:02:38
 +0200
Date:	Wed, 29 Jun 2016 09:02:37 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/Makefile: add a rule to re-run previously-failed tests
Message-ID: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CXku29V2Bh61WZnPHYkwC/Vq9OdHcGmRpRLAN9Ql8Jp5jFu+6pY
 7wpTzq9nQ7IEGPgcC5o6Fv94stPwYsOxNKgbmJ2kS4Uu4GlWEE0bFESk7Yh45sb7yI7tFG7
 D+ExwvOe3jET8YIjGS5LCXLBxGG6F7Xn3Ov/GNjxNZqoc4OeN6/TYzJjg68LFUZ+YBv4xPy
 rKAQs9bBhfZcFoRTLzcNg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fX85L9ZWRhc=:caL7nKSQN+QcIiWiLppOI6
 JkQLxZrgUmrVJ+AFuPl1P6TCe35xZtVsD0vxNyp5WysN7U/1ub0QB2DOz8vY/5wm/8c6FLmYL
 1ZwOVaM/NmJm5udIbq+eZsVlqG++eWW9fRqWMwGwFiytJO8stOZfa37YbPQEMANvVOhe205vC
 PzlGdNm8k9B3uZI0sRvlgadeSeL1B/BqRNYgvv1kqVVi6he9gJluCDTm4bPMYW2sPI/yKAtkG
 kyS2Jr1VDS5pHakBl84xbOvSR9SuKbJMQb89yZE87f6/Fg43cCH5ENt2z9NzMVhnb/oYPUQCh
 dbsP8hVeDXO93c2ewDm2L5L1oBbzUxmCY9C/urg/Irf6JvV5ldJvk0oAq4tj9kaYp7MnEp4qO
 0XadXD7F5X0uVTWj4g4bxi4SupX54P5tdDNHqJsKY2i4IEw5eMDo9sIjKkmQZ5I4mJ7beqb4G
 jmCaJzEY2od8cVEASq/hPYEy9phhZesGcHeSQ6NvlEfCmK5YPRHl9bGowG3Ek/k5gPZbtLWfQ
 jPn3tO5JnyI1NsXDu1V79owcPmD714PqSO/V2dASyAU5btAcSrQGGboGABJhz3hEHuWDgvIZ+
 mCr5DpQtu51aTpZ0pABA+8ugc+x+NnapHK+OqdefeE5+2YJufIoPItRza28vgk9v75KkU0SQz
 8O9qoXW4qGnfElYGna5U2F3DgATvbW9dl0KZJwN0KZV+enN5bRclqWTtewEdxQZqme7tl8Rw+
 4SPoQ4bA3M++dvOjuadluMrLro7lvYrVxu0wmkruOYcqiR5bY6XkH9DBM/XxygB4jdvk+++69
 WUGBXJR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While developing patch series, it is a good practice to run the test
suite from time to time, just to make sure that obvious bugs are caught
early. With complex patch series, it is common to run `make -j15 -k
test`, i.e. run the tests in parallel and not stop at the first failing
test but continue. This has the advantage of identifying possibly
multiple problems without having to wait for the complete test suite to
finish.

It is particularly important to reduce the turn-around time thusly on
Windows, where the test suite spends 45 minutes on the computer on which
this patch was developed.

It is the most convenient way to determine which tests failed after
running the entire test suite, in parallel, to look for left-over "trash
directory.t*" subdirectories in the t/ subdirectory.

This patch automates the process of determinig which tests failed
previously and re-running them; It turned out to be quite convenient
when trying to squash bugs that crept in during rebases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/failing-tests-v1
 t/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/Makefile b/t/Makefile
index 18e2b28..1459a7f 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -35,6 +35,8 @@ all: $(DEFAULT_TEST_TARGET)
 test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
+failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard trash\ directory.t[0-9]*)))
+
 prove: pre-clean $(TEST_LINT)
 	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
-- 
2.9.0.118.g0e1a633

base-commit: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
