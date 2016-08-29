Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12C31FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 13:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbcH2Nqg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 09:46:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:62463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932908AbcH2Nqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 09:46:34 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lmqxo-1bAmDz1wVw-00h3BU; Mon, 29 Aug 2016 15:46:07
 +0200
Date:   Mon, 29 Aug 2016 15:46:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
Message-ID: <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hbJFML/gpBpUW/BUb2ibHV0dYKfq1YINfldHzWkoCGE4BRbJJgJ
 EJ+UpuFW0WK+LaCPPyX4+Sy+/iIhQMZbWL5dieW5A9C9rZ2BA3+8Ns0F/sKkZBU7a+xtyqI
 xqOi+6jGKNL//lYIPKSoVG+B+VGPuom/pyu4o5FX3G7XJUAAnJJCoXHbaSrIapYFjJUGeU4
 PrnqOav8LC8xmQx8gH1Zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b7F4JVaGXAk=:pbiIsL1eEDnlwdD7UfvtmX
 2n/AE/qOxL/kU7BachSPe3Q6Wgt3aAmHzyWvqdPOArpDqmH1YTBxiFdpoVXlzPhRI2WX//m+3
 Wu9o9yd6cfoC/iXBEQOJ9TtAR54evppNMEH4thP5yUZbm1cKOyj5jVBklHKVNm642nalG/NMO
 g2hhem1RKbz7vH3HLENxrGVEzebHh0JGqK1MRtK+m0c5B43CRM7AYPqVqAVeCCHSrmfjcTE1g
 2tX3LrvJ9Q415j21ILuYNaMI6LrrjyL2tbTrrzJo9tYVJ0Wx8oGtuHxfk5yNmL5OCE37APHty
 Ko6rryoA337XTbS0MNraiemoxDaAassKXu+usbrtxnuo1z0KOhbshKRuOtcW+4/EbmsbCpFdS
 AEeNvQJif1+bu1Dyg/j1i/nrqoCnb4g8c/3lY3zQKZVCdrFldwp4fQ6Dgs+Nl6TjZ9nWndJWm
 XuKS2nsm/fKGinMdXx2qchXjysPY3mEinZrCrhgd2h8mbulgLtdZuvuyapcrIWwqgUFo+rtIW
 aK6Z6Yq6cTeWrJUMnEq2l/hSCRLCYo9/yqC3BlQ3npyPnBAYazUBlWRkdla7dSgQCPEaP76hb
 BmWRV/2SXgInDluJ68k+ZGvfdakESpj69HlvpAEN/DmOTJR4L3QR3px25ettIisOb2wVBhpuz
 rrrv8u9QOko8/3AVn3/B5AkqMfIq71HmFh11RNdM4YWICVZMU9PGL8WY3pE/U9JPwsUu3BPf3
 dUq8vAkn+7jvc/TjVhWGl13GjB4TlwFjW+LBC2g+u04/SvXl81I6OPZ3pa99+MrFh7ZbidPCq
 ZbFtYJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While developing patch series, it is a good practice to run the test
suite from time to time, just to make sure that obvious bugs are caught
early.  With complex patch series, it is common to run `make -j15 -k
test`, i.e.  run the tests in parallel and *not* stop at the first
failing test but continue. This has the advantage of identifying
possibly multiple problems in one big test run.

It is particularly important to reduce the turn-around time thusly on
Windows, where the test suite spends 45 minutes on the computer on which
this patch was developed.

It is the most convenient way to determine which tests failed after
running the entire test suite, in parallel, to look for left-over "trash
directory.t*" subdirectories in the t/ subdirectory. However, as was
pointed out by Jeff King, those directories might live outside t/ when
overridden using the --root=<directory> option, to which the Makefile
has no access. The next best method is to grep explicitly for failed
tests in the test-results/ directory, which the Makefile *can* access.

This patch automates the process of determinig which tests failed
previously and re-running them.

Note that we need to be careful to inspect only the *newest* entries in
test-results/: this directory contains files of the form
tNNNN-<name>-<pid>.counts and is only removed wholesale when running the
*entire* test suite, not when running individual tests. We ensure that
with a little sed magic on `ls -t`'s output that simply skips lines
when the file name was seen earlier.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The patch is unfortunately no longer as trivial as before, but it
	now also works with --root=..., i.e. when the user overrode the
	location of the trash directories.

Published-As: https://github.com/dscho/git/releases/tag/failing-tests-v2
Fetch-It-Via: git fetch https://github.com/dscho/git failing-tests-v2
Interdiff vs v1:

 diff --git a/t/Makefile b/t/Makefile
 index c402a9ec..8aa6a72 100644
 --- a/t/Makefile
 +++ b/t/Makefile
 @@ -35,7 +35,12 @@ all: $(DEFAULT_TEST_TARGET)
  test: pre-clean $(TEST_LINT)
  	$(MAKE) aggregate-results-and-cleanup
  
 -failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard trash\ directory.t[0-9]*)))
 +failed:
 +	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
 +		grep -l '^failed [1-9]' $$(ls -t *.counts | \
 +			sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\./d;P;d') | \
 +		sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
 +	test -z "$$failed" || $(MAKE) $$failed
  
  prove: pre-clean $(TEST_LINT)
  	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)


 t/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/Makefile b/t/Makefile
index d613935..8aa6a72 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -35,6 +35,13 @@ all: $(DEFAULT_TEST_TARGET)
 test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
+failed:
+	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
+		grep -l '^failed [1-9]' $$(ls -t *.counts | \
+			sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\./d;P;d') | \
+		sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
+	test -z "$$failed" || $(MAKE) $$failed
+
 prove: pre-clean $(TEST_LINT)
 	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
-- 
2.10.0.rc1.114.g2bd6b38

base-commit: d5cb9cbd64165153a318e1049f8bf14b09a16b11
