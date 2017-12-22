Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717C21F404
	for <e@80x24.org>; Fri, 22 Dec 2017 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbdLVK7d (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 05:59:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:50623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbdLVK73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 05:59:29 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LinyL-1eyNPN1Wfd-00cv9P; Fri, 22
 Dec 2017 11:59:24 +0100
Date:   Fri, 22 Dec 2017 11:59:23 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] oidmap.h: strongly discourage using OIDMAP_INIT directly
Message-ID: <940d8daa8eb8d42b9f0a3ebf4c25fb6417e71bc8.1513940345.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j438khtZ2l5MdcD0bW6e/SbC/ISJF/1IJRZjBPPVw+h+7Pt2MDJ
 I2EqNNkh6AzdL6fqKB1hb0XK0nolV1rz41B69YP/SdcmHbHLnyl/TH0uWbe9MRCRsl+ZCqe
 bibkvSog9dORU3VVcp6iY9+T/EYyuqLXJ67wHXKYOfAxBq/rIFKeU91UGjBIM3qkOsUI0BB
 6rQwNWwzrHvmjKiRBRvTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LDuAKKC0ru0=:PdJKEKe3hg4pLxySxFxRm6
 IJqYPtFWnINyFYQxZ3P/bUHseMzh9bp2aHiP6yPGJ5pMNmX8bnMJVwhJqSiMr5umNdH7gY5DO
 NGoanZwjrUWI+1GUtFWsWPA4CkXtq7Bqwpvlr0eYanivb8PXCnxOVWTlIhq+/he0fIxzesYae
 0wLHUs9P8q264ga1KAloREIM09TOQR36Ezt60R+bstXXmgl8mSe3gmIk4VuojhWkQPBH4p/qD
 WTBu0wmoztrwPiHQCcqnuvC4lCJAlHfP8MOGVkhmwm67yXFeqpTF1eotDpylR74p0xcjOB3+u
 MN0NG5JPih9/HDbBU/LgD3Qp+eGrWzPdbb9SMwvkKUTVHR9MNuRHd5nyvw0YfKe5r8IoHKKRg
 wv9i2ZvWOkMCj39aVUcevO33T+x4YSzio9P0BlQ5SooPhWg7NZ3Za/9PLxzKxNANyicsLoKKO
 AsIgbzORwH0/T0vH1htl+7CizWJ0G6/EjCBKii8fX8QzQ9PAeclbILT+KPU4QnIJRjKxrunbw
 82hP8rH9g1cpbIVmTadfWuzO33HXH6MGCJfFZbJ9SotoCPko7TMIGUyZgp1tsIHEl291JtUGO
 VoInH6hDl6sHY0p7clV8tGRewZeBIfqN52YfuKtJrP6As9HJp4nTZA3WXSqdYhIThkLEMka/o
 5m2GGJMEoa7vWzwpV1LGseE83nw0Xcx8D1wHneeQW/dk5qQ+sQ+VqPhPhcSPRq7fiLz0i30/U
 exglQIGgjHPeBWJGO1ntFp8ecyA9RkB8XxyrsLaEMMjikHrKXfXCgaXdUzn/gCRfKaQuHfLFs
 UPqHB3JlmFQjEtReqZZbo3hH7ACNo5pW9wrYz7C1gzMLM8S2HM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git's source code, we have this convention that quite a few data
structures can be initialized using a macro *_INIT while defining an
instance (instead of having to call a function to initialize the data
structure). You will see that idiom quite a bit, e.g. `struct strbuf buf
= STRBUF_INIT;`

This works for oidsets, too: `struct oidset oids = OIDSET_INIT;` is
perfectly legal and you can use that data structure right away, without
having to call `oidset_init()` first.

That pattern is violated by OIDMAP_INIT, though. The first call to
oidmap_put() or oidmap_get() will succeed, but by mistake rather than by
design: The underlying hashmap is not initialized correctly, as the
cmpfn function pointer still points to NULL, but since there are no
entries to be compared, cmpfn will not be called. Things break down,
though, as soon as there is even one entry.

Rather than causing confusion, frustration and needless loss of time due
to pointless debugging, let's *rename* OIDMAP_INIT so that developers
who have gotten used to the pattern `struct xyz a = XYZ_INIT;` won't do
that with oidmaps.

An alternative would be to introduce a HASHMAP_INIT(cmp_fn) and use that
in oidmap.h. However, there are *no* call sites in Git's source code
that would benefit from that macro, i.e. this would be premature
optimization (and cost a lot more time than this here trivial patch).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/discourage-OIDMAP_INIT-v1
Fetch-It-Via: git fetch https://github.com/dscho/git discourage-OIDMAP_INIT-v1
 oidmap.h | 6 +++++-
 oidset.h | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/oidmap.h b/oidmap.h
index 18f54cde143..1a73c392b79 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -21,7 +21,11 @@ struct oidmap {
 	struct hashmap map;
 };
 
-#define OIDMAP_INIT { { NULL } }
+/*
+ * This macro initializes the data structure only incompletely, just enough
+ * to call oidmap_get() on an empty map. Use oidmap_init() instead.
+ */
+#define OIDMAP_INIT_INCOMPLETELY { { NULL } }
 
 /*
  * Initializes an oidmap structure.
diff --git a/oidset.h b/oidset.h
index f4c9e0f9c04..a11d88edc1d 100644
--- a/oidset.h
+++ b/oidset.h
@@ -22,7 +22,12 @@ struct oidset {
 	struct oidmap map;
 };
 
-#define OIDSET_INIT { OIDMAP_INIT }
+/*
+ * It is okay to initialize the map incompletely here because oidset_insert()
+ * will call oidset_init() (which will call oidmap_init()), and
+ * oidset_contains() works as intended even before oidset_init() was called.
+ */
+#define OIDSET_INIT { OIDMAP_INIT_INCOMPLETELY }
 
 /**
  * Returns true iff `set` contains `oid`.

base-commit: 936d1b989416a95f593bf81ccae8ac62cd83f279
-- 
2.15.1.windows.2
