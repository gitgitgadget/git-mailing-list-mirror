Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4021FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933856AbdCXX2v (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:28:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:54835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932972AbdCXX2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:28:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLj5z-1crpU73mHz-000peF; Sat, 25
 Mar 2017 00:28:44 +0100
Date:   Sat, 25 Mar 2017 00:28:44 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] p0013: new test to compare SHA1DC vs OpenSSL
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <4c2e3b2abc84a4b4eb7b41b424f76defda550646.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sHlyY210FLZ/S2HPxUu0MXlJVUo5MPGDKCrL6ibUZ46QnkFe/o7
 ryAwsiX5M5w3wZ6BqK2Ra/mh+L7lggecJAPO3Dn6BMtl47MmpBUVYQbRezU6F6qcTexrXTp
 SZz4zIoM4AgfbhMakQp1Q1YUdUojX9UVIFkshyPT60TYLLD2V/xFGKGxWS6xDxY8i1c+bnc
 ilQgrb1oSKzhadNbA/0zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WgCyIDSVLuQ=:A8ub2xzkv4nREB32SLqc2K
 S5W2SbuJflxbdb+/6Quf8gDYujd1nP+AzsY1psfO1yAr4ex6sHs1I1fAItztb+2LqFQCUfTmq
 Bs2XxWP+IHkkDQ6khm1lzozuJR9OdAM7WYhhm/BX/fK5EsDUsRGSn+isNAI9iwCILRc+sdZnE
 w8KVasJO66MdxcE/rvKSQN+JW0cAw5LNVC/sriWeO7VNTQsYJb1dWSkkgZnQzin5j7OD9cI05
 JWziuOGOihltgVyXseyi9eXuSysQS/h8VV6MQ2NySDf1U5aSIcsrgkibpqGtorLNxS84YjmAE
 lAKcmVYYquuU5MoV3jNUNWYS9PBFAS62oy/sCIUHb/wdm5yJOTyGr5yTBORZn6cGWeM+kjVTt
 k4ODNcR/t/wTcrCYiBZrIE8Uz01mV332l19PJLyBAQ2/bVKzK+0/be0kZGKBZ5iklhuUvv25v
 +WZg12CYBLZohQvw0gnvqk84PPMgiT2tXQfYyQtUwmXv8KMGrdBSSuBMjI9+4Daxp+tPPEVdM
 y1m0TQwYo9h8TiMvEWcak3OsPgZBxRV379V1/dSkWvLLVM6wTx/9VxmVgrSQCH1NM+IttoE5O
 hnTwdCWvl9GAyx/4cij5pe/QNvhPgy0SwZ8tjHVyFD1pdfI6wsG3E232LokhddhZN6rWDvAki
 wPwlzLm3+/Zjox1tZ/DBwxdWoLsWwnmNpRMW/MT+28JMr0EOICLYm7W3Vl0T8qa8q+dtejeYf
 /n6y8S02x1WiQZfOyCdsb+UEMUEJp1lUXZicSCLgSavsyjBRsmzpFQTa0tm6zUPkmQzKLX7PJ
 R77a5RXUhA2/xP90D46Zt4RLW5dyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To demonstrate the need for the core.enableSHA1DC knob, this test
compares the performance of the SHA-1 algorithms with collision
detection vs OpenSSL's (that does not detect attempted collision
attacks).

The payload size of 300MB was actually not concocted from thin air, but
is based on the massive Windows monorepo, whose index file weighs in
with roughly that size (and which is SHA-1'ed upon every single read and
write).

On this developer's machine, this comparison shows a hefty difference:

	0013.1: calculate SHA-1 for 300MB (SHA1DC)    3.03(0.03+0.17)
	0013.2: calculate SHA-1 for 300MB (OpenSSL)   0.58(0.06+0.16)

It is not only that ~6x slower performance is a pretty tall order, the
absolute numbers themselves speak a very clear language: having to wait
one second every time a file is `git add`ed is noticeable, but one can
handwave it away. Having to wait six seconds (3 to read the index, a
fraction of a millisecond to hash the new contents and update the
in-memory index, then 3 seconds to write out the index) is outright
annoying. And unnecessary, too: the content of the index is never
crafted to cause SHA-1 collisions.

Obviously, this test requires that Git was built with the new
DC_AND_OPENSSL_SHA1 make flag; it is skipped otherwise.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/perf/p0013-sha1dc.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 t/perf/p0013-sha1dc.sh

diff --git a/t/perf/p0013-sha1dc.sh b/t/perf/p0013-sha1dc.sh
new file mode 100644
index 00000000000..e08473ac969
--- /dev/null
+++ b/t/perf/p0013-sha1dc.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description="Tests performance of SHA1DC vs OpenSSL"
+
+. ./perf-lib.sh
+
+test -n "$DC_AND_OPENSSL_SHA1" || {
+	skip_all='DC_AND_OPENSSL_SHA1 required for this test'
+	test_done
+}
+
+test_perf 'calculate SHA-1 for 300MB (SHA1DC)' '
+	dd if=/dev/zero bs=1M count=300 |
+	test-sha1
+'
+
+test_perf 'calculate SHA-1 for 300MB (OpenSSL)' '
+	dd if=/dev/zero bs=1M count=300 |
+	test-sha1 --disable-sha1dc
+'
+
+test_done
+
-- 
2.12.1.windows.1
