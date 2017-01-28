Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3541F1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 21:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbdA1VjB (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 16:39:01 -0500
Received: from mout.web.de ([212.227.15.14]:56879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbdA1VjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 16:39:00 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjJWR-1bvUSj28Ux-00dXtd; Sat, 28
 Jan 2017 22:38:34 +0100
Subject: [PATCH 1/5] add SWAP macro
To:     Git List <git@vger.kernel.org>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
Date:   Sat, 28 Jan 2017 22:38:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vHbpfokSWIsiMtVQ+O4VvrMivygJu8wP8DwQq89GSa3PN3tNQVP
 njJHWNWue7dj3uLW8G96Tl1l0Udi4e9oNqQwavGJUbXd/vaXp4OaQJbXmovpwEh0SqoJYvd
 qKl1o9MPTDWDXy/CNXbuw62g94qo/RyjvgmpUw6jxzSHupwfQhfa/3cfaWHLZTXqiQznCWr
 N11bcRYDZNTtXELDcbbdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qA/TmgFDDiw=:tjt05fCEfMQPsWO+nq6EGV
 pgmlNuI4Z8Cfm+eMA2tO0H5pTRc6oNpHGVz2GihSBLoRys+3AAkq3j5jLttS3mGgvdZBSsCZu
 7lsyPLh4M6csPwwneWTjmZRKyN54G1O7a7/wEvEYhOWFWnR1j/CGpzHRDwxUn7kbXK/6e37M+
 EhnUQu5YkaSln+2U7D2RjVByomDT+j/iGiQZJ0h39EiIgh8SIpG9iaEVmwn3jv34CaaKuLSai
 nUoAhBVSeov9L2kLL2AXITCyH3bnjirdhMNGceQU9OqdgrdEF2H+jFfw0kItTJbFjAIS7fYKQ
 va6U2nxtYlN1fFs8Yy1wO5oD4i+FVXsxGYepLg3jF9E8Nwj72dmc2hJ8cqOqEDsf+xAnmJ6wK
 yiNbaOYy8xL0McM5R7nzqWfKBaC9OQ9npQFYll+Y71eIjdYwkcILkMWxhn1IEPXXHPhrtzNj5
 C8gcZwI1rFW3I7vzhv4o/XGf/KASOD2EL95g7PAp1WGYEIU8l/UWUL8aAF4z65DDxgQn+AXMN
 befnCgmoEkjQ0KB2KqCVecJ3HAPj5TCCyOvIyV3CZCmQaVpWMHkVrMjJsKwcL/DbiF0HbmMFc
 gQ4BoIxfYxXBuYvVMp4gTAc5bmwsQuehJEP4flm3+s4MDS1DDVYqm2246KWPq55h6RoZ0BAVn
 tIhIgweS7XHue29gCnzmgLfwqnL7EXR5DxzCYJ3xcLMG+84/Q48MH4+qKw+EDSi2xAEPcKdfo
 5u2q5ksXdQ6QntrOTSoDLTMQ2z7vfLLFOuQ/abtgYxVrQwdzzNUC64qMona07ThLbnXvCNnGd
 Q+tUrBP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro for exchanging the values of variables.  It allows users
to avoid repetition and takes care of the temporary variable for them.
It also makes sure that the storage sizes of its two parameters are the
same.  Its memcpy(1) calls are optimized away by current compilers.

Also add a conservative semantic patch for transforming only swaps of
variables of the same type.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/swap.cocci | 28 ++++++++++++++++++++++++++++
 git-compat-util.h             | 10 ++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 contrib/coccinelle/swap.cocci

diff --git a/contrib/coccinelle/swap.cocci b/contrib/coccinelle/swap.cocci
new file mode 100644
index 0000000000..a0934d1fda
--- /dev/null
+++ b/contrib/coccinelle/swap.cocci
@@ -0,0 +1,28 @@
+@ swap_with_declaration @
+type T;
+identifier tmp;
+T a, b;
+@@
+- T tmp = a;
++ T tmp;
++ tmp = a;
+  a = b;
+  b = tmp;
+
+@ swap @
+type T;
+T tmp, a, b;
+@@
+- tmp = a;
+- a = b;
+- b = tmp;
++ SWAP(a, b);
+
+@ extends swap @
+identifier unused;
+@@
+  {
+  ...
+- T unused;
+  ... when != unused
+  }
diff --git a/git-compat-util.h b/git-compat-util.h
index 87237b092b..66cd466eea 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -527,6 +527,16 @@ static inline int ends_with(const char *str, const char *suffix)
 	return strip_suffix(str, suffix, &len);
 }
 
+#define SWAP(a, b) do {						\
+	void *_swap_a_ptr = &(a);				\
+	void *_swap_b_ptr = &(b);				\
+	unsigned char _swap_buffer[sizeof(a)];			\
+	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
+	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
+	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
+	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
+} while (0)
+
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
-- 
2.11.0

