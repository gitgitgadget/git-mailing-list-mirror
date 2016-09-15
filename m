Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6332070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbcIOSbd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:31:33 -0400
Received: from mout.web.de ([212.227.15.3]:55532 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbcIOSbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:31:32 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M2uXO-1au9hx1qre-00seWG; Thu, 15 Sep 2016 20:31:11
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] add coccicheck make target
Message-ID: <e47359bc-1bf0-e1bd-b076-6f95c3f15abd@web.de>
Date:   Thu, 15 Sep 2016 20:30:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PbhX6RZzvSRgqzdj6wvQjfQgO5HtOO4pPjQI6BxwN0JgB+T86+H
 nNKKCLvcBYrO9RhsMu4pSoN9Lbpt93Qh1EYNNt8RYz2nOU8oXahGlB5wV5QtXJE26dJVQ5A
 yRzpT0zmcNMEZqcwW6Cwbf9gV4qSmxjE4v8OwnHljYI0eoiif5B3Rik/twD4mqDMCsrDvtH
 0qfxPqOs9URQtxYpHqpZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lJAaiPcikSI=:2x5Xaar0mTdfq+dFVyW2Ai
 vdyyEsgbcnuzPT+3AGRubA8GAJdkH9XYfTH3E3W1NvFfaNvaaC4dVgScYN88oCCqhDHbkGSiM
 y3wZgIFg/VqrPMFg0l41ovI5uD1UZ1ebPQpHzaRwIHhp+8gCfpVB+Gx5q9ocl0bacdxOVNDQz
 iXhfl06ve9Z7kf4WcPHjZohX412MbBgfihPmNWGpDpgY/mROiAsIT78hF6zoRKE5KLig4POhE
 Dbbzsd3sKFALXcRNMEaIhgfQA3babYwkGb8P54Axd9ukW9xOvp4O1c6xldhZEkOXF2B1fCfuS
 7SQt+tZpeztyJDugFnpoeWaGT0C4VSRwumLcbGlf4bJoqLAHeUPX4Kv1D4IL84EpN3QEfSGYE
 qaaZ94AJKM5B0ADaf3SAZzC+ZFm2HGRvwOAWuoNeuAT/gvm++hMDLRexK2rT6IJXdWE3lb1vK
 fE8c+Mu/T/ItkRstxintEBVNTSoN8dhd2VMq95TsrzyfGcNau4Fa74txyga13OfQ9iybd3R1P
 oyEImruA0cA+UyR+2JVsQfE+MugxjHJvG5S3nJwHONmxb3Lz+yW93LtGR/Kb0QurfZw2nmT6/
 Z/2i3VEFaXqyysHeS0Co6P0HOWj3vIz6zaaa+DMtRAr75+whGzhvZoQlngNWHukdR0JVwvWwC
 /r87wjdMWcLevQKuOCnVMA6bvcr6Ww2UvR2vP7bpAwtvaDht6kk5d76cE8XUJhwuuHh6iOY1O
 brOVXb5mkULnhdrBhilk19eSEgri2dzNmLuEFq5BKTx88Pz+J8NVQUbJM/YGqswyenWQb1i70
 f/DDgGh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide a simple way to run Coccinelle against all source files, in the
form of a Makefile target.  Running "make coccicheck" applies each
.cocci file in contrib/coccinelle/ on all source files.  It generates
a .patch file for each .cocci file, containing the actual changes for
effecting the transformations described by the semantic patches.

Non-empty .patch files are reported.  They can be applied to the work
tree using "patch -p0", but should be checked to e.g. make sure they
don't screw up formatting or create circular references.

Coccinelle's diagnostic output (stderr) is piped into .log files.

Linux has a much more elaborate make target of the same name; let's
start nice and easy.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 7f18492..74b2788 100644
--- a/Makefile
+++ b/Makefile
@@ -461,6 +461,7 @@ CURL_CONFIG = curl-config
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
 GCOV = gcov
+SPATCH = spatch
 
 export TCL_PATH TCLTK_PATH
 
@@ -2307,6 +2308,18 @@ check: common-cmds.h
 		exit 1; \
 	fi
 
+C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
+%.cocci.patch: %.cocci $(C_SOURCES)
+	@echo '    ' SPATCH $<; \
+	for f in $(C_SOURCES); do \
+		$(SPATCH) --sp-file $< $$f; \
+	done >$@ 2>$@.log; \
+	if test -s $@; \
+	then \
+		echo '    ' SPATCH result: $@; \
+	fi
+coccicheck: $(patsubst %.cocci,%.cocci.patch,$(wildcard contrib/coccinelle/*.cocci))
+
 ### Installation rules
 
 ifneq ($(filter /%,$(firstword $(template_dir))),)
@@ -2498,6 +2511,7 @@ clean: profile-clean coverage-clean
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
+	$(RM) contrib/coccinelle/*.cocci.patch*
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-- 
2.10.0

