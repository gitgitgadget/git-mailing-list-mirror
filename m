Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B9F1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeIHD1z (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:27:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:33683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeIHD1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:27:54 -0400
Received: from p2520la.fritz.box ([217.235.87.235]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gww-1fjL9I0XYE-00urQv; Sat, 08
 Sep 2018 00:44:34 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        pclouds@gmail.com
Subject: [RFC PATCH v4 3/3] t0014: Introduce alias testing suite
Date:   Sat,  8 Sep 2018 00:44:30 +0200
Message-Id: <20180907224430.23859-3-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc2.1.g4c98b8d69.dirty
In-Reply-To: <20180907224430.23859-1-timschumi@gmx.de>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180907224430.23859-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AcQNMiiUB5hiR3V0i98hkgYqeuIr1PbnqlZzL9OfvGHe/1suVO3
 nPUKWRqBYq9HFQ7KmUO+MroHfOlXcEmEHpcZpQBUz0e6LB+obt55nZkxLUZJwcBRZozcJbO
 0W4R98dg6syhoqmlXma+z94VqFbJ92nDWGBZM7tENsrs3U4K2XJBk5pOetJAp68h6rY6Q83
 dczVrrMCCrp/GoxulfwMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9nMwR4X+ajA=:/xIwMpBFr3fRew/+KYanmp
 qzJKH+wtGSioTaNKHvHbHx5m50CwT7f0kJ2kVFMOY5Nw6ijZKHrh1byg2TOsMbDwkGCXILX3o
 Aqim9feDlKs7suvnXE4vLCuWoiLuanH4iQYYoVQHe2PjRJ2FdBatiNLsP2hlI/FgDMWeT5eJH
 tPej+gGhku5FEuFJpdLUaSITXunPN23TQpbWBf0qev1fRcI8qSRyxPWrG+pt38RyEZfxpE6IN
 BWcyufB7mFQAgIYQVbFFs25T9HeApDP8s5fYMyY301eeqsQ8CRTzXLxtzuGzvv8W+uulfXRWq
 z5E79CromvcNougx97sMzzWjPHA2MH9evwJCgkdJNMkB0guaJNYgzNZsSrSbTxb67sRZZWVP4
 og30E/cLiAN+SNKS/9UKHWWEc4QykqYKy5l4ikY32NlMseLqwocg/ID2H0WILK1JSQEROHadh
 71Y6BVxZq0JlWXl/4u4HqtGuvHLDh72y5GYSCB537Dsuw3F5H3+OJ0dZholg50crO+JH1CMsM
 /BFvCKm6NENyZyHb5ipV26H9UWbUFIYnPhJPrXOouFdaAeL0/jjUnvzeFaWUwsZLNT1TWBkLb
 YCof2al+FDq6Ds+aky2tSq9CLlJaCGbH9wyi8GAjy/K8RDt+U+AklfY5gpCq14V5RSE96rUSN
 KrieKlGwVrK5XGwXFzcTozDPXxtl3Hp6+YUXH07VJ7STDXWL4IsjpIAyQQYDrLr8hDRp2IgSb
 73tFeFQ4jwEVbp4zhMz3j8u1y7rg+BTkl8gYaUCowxph2EUqc9hIYEA/bJE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a testing suite that is dedicated to aliases.
For now, check only if nested aliases work and if looping
aliases are detected successfully.

The looping aliases check for mixed execution is there but
expected to fail because there is no check in place yet.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---

Those are the tests that I've come up with. It consists of tests
for nested aliases and looping aliases, both with internal calls
and external calls.

Unfortunately I don't have a fix for the last one yet, so I
marked it as expect_failure. The problem is that the test suite
is waiting a full minute until it aborts the running command
(which I guess should not take that long, as it blocks the whole
test suite for that span of time).

Should I try to decrease the timeout or should I remove that
test completely until I manage to get external calls fixed?

As a last thing, is there any better way to use single quotes
than to write '"'"'? It isn't that bad, but it is hard to read,
especially for bash newcomers.

 t/t0014-alias.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 t/t0014-alias.sh

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
new file mode 100755
index 000000000..6c1e34694
--- /dev/null
+++ b/t/t0014-alias.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git command aliasing'
+
+. ./test-lib.sh
+
+test_expect_success 'setup environment' '
+	git init
+'
+
+test_expect_success 'nested aliases - internal execution' '
+	git config alias.nested-internal-1 nested-internal-2 &&
+	git config alias.nested-internal-2 status
+'
+
+test_expect_success 'nested aliases - mixed execution' '
+	git config alias.nested-external-1 "!git nested-external-2" &&
+	git config alias.nested-external-2 status
+'
+
+test_expect_success 'looping aliases - internal execution' '
+	git config alias.loop-internal-1 loop-internal-2 &&
+	git config alias.loop-internal-2 loop-internal-3 &&
+	git config alias.loop-internal-3 loop-internal-2 &&
+	test_must_fail git loop-internal-1 2>output &&
+	grep -q "fatal: alias loop detected: expansion of '"'"'loop-internal-1'"'"' does not terminate" output &&
+	rm output
+'
+
+test_expect_failure 'looping aliases - mixed execution' '
+	git config alias.loop-mixed-1 loop-mixed-2 &&
+	git config alias.loop-mixed-2 "!git loop-mixed-1" &&
+	test_must_fail git loop-mixed-1 2>output &&
+	grep -q "fatal: alias loop detected: expansion of '"'"'loop-mixed-1'"'"' does not terminate" output &&
+	rm output
+'
+
+test_done
-- 
2.19.0.rc2.1.g4c98b8d69.dirty

