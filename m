Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1F9C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251352146E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf/lLTDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgAGOzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:55:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36860 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOzw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:55:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so19739768wma.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EbSSQFBaP8i1hkKFD8hKVezSwvLRhGPCMa92CiqjNPI=;
        b=Uf/lLTDc9YDPftFrBwikQifUpjAXgfQGB/eN7WCiidlIMSay4dwn+Q1afvM5A17/Qz
         w5uZB8Aos67xbiHhHE/54RpOGdYO4mK4Anz0BxkMYuEv3IlRaAJ5hqXgKuf2DHhYvbl7
         htne2RgtRKK5VehR5PCz8eMsB8zUrHYHM5SLFo9KjwcnWD9WPk3lbRq3jQWd57Naz7co
         bwDhOkdv2bwL3iG65xvnCsHSQuYRAAhkYcAhcC6dqSm+OVkGfRPySUeYnJHnyHG5+bMU
         otm30I5JPwc5IHMnKcCPTubde3loOx7UTZGCcXTBQ0VwhhLHLzV4AX0y0nQtl1YfxByr
         3HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EbSSQFBaP8i1hkKFD8hKVezSwvLRhGPCMa92CiqjNPI=;
        b=KRYzWiLECOv6Bfk6hQCQTzZlPqAY8OpF98aSIwPYnfXbqGNylJJzoRVg+1Obc9a+sQ
         u7WGzMpxTDNLCM9mNI0xAaApDtXgPyygdJ89QPkZhEK1P1x82+qUBfSSLi4dA7QN86qd
         OKRijJPhv9CPqYxSirdBfCdnEz1TH8uSkSWdPd+cHXZBuXUCZ9jnUN4p43WbIaOaEzUn
         T0PlAHnQHD1pQxg9+ffZL0xhSXDHmxuwi0+CWUdWLAZpGr0PbJmaRJgfNf290m+Yj5RW
         0fDJUT1HKbe2CkqPaEigEs9rD7WCBULysyA1ZOXRiZVse9yKyyGpsrhpGCdTbehfJt6T
         /jvQ==
X-Gm-Message-State: APjAAAU9ZMvEHZtmpEzTqzTQ73tJd1/uXpLeFFRCz7EVKCiNnvqF8bX6
        3VhohU8ReF2AcIfQo4YHV0pNBFuE
X-Google-Smtp-Source: APXvYqyqgokOXYZKhnmV+Re6B605dDB5rH4RCZwJduPucrgIPNIj+c17Asb++IAecwsPqpeJx3sDfA==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr41397939wmf.100.1578408950263;
        Tue, 07 Jan 2020 06:55:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm64666wrn.78.2020.01.07.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:55:49 -0800 (PST)
Message-Id: <f74e82bea68701beb734537cafd147162d1bb2c6.1578408947.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.517.git.1578408947.gitgitgadget@gmail.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 14:55:47 +0000
Subject: [PATCH 3/3] t4215: add bigger graph collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A previous test in t4215-log-skewed-merges.sh was added to demonstrate
exactly the topology of a reported failure in "git log --graph". While
investigating the fix, we realized that multiple edges that could
collapse with horizontal lines were not doing so.

Specifically, examine this section of the graph:

	| | | | | | *   7_M4
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | | | |/| /
	| | | |/| |/
	| | |/| |/|
	| |/| |/| |
	| | |/| | |
	| | * | | | 7_G

Document this behavior with a test. This behavior is new, as the
behavior in v2.24.1 has the following output:

	| | | | | | *-.   7_M4
	| | | | | | |\ \
	| |_|_|_|_|/ / /
	|/| | | | | / /
	| | |_|_|_|/ /
	| |/| | | | /
	| | | |_|_|/
	| | |/| | |
	| | * | | | 7_G

The behavior changed logically in 479db18b ("graph: smooth appearance
of collapsing edges on commit lines", 2019-10-15), but was actually
broken due to an assert() bug in 458152cc ("graph: example of graph
output that can be simplified", 2019-10-15). A future change could
modify this behavior to do the following instead:

	| | | | | | *   7_M4
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | |_|_|/| /
	| |/| | | |/
	| | | |_|/|
	| | |/| | |
	| | * | | | 7_G

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t4215-log-skewed-merges.sh | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index ddf6f6f5d3..be2c24564b 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -282,4 +282,67 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph with multiple tips' '
+	git checkout --orphan 7_1 &&
+	test_commit 7_A &&
+	test_commit 7_B &&
+	test_commit 7_C &&
+	git checkout -b 7_2 7_1~2 &&
+	test_commit 7_D &&
+	test_commit 7_E &&
+	git checkout -b 7_3 7_1~1 &&
+	test_commit 7_F &&
+	test_commit 7_G &&
+	git checkout -b 7_4 7_2~1 &&
+	test_commit 7_H &&
+	git checkout -b 7_5 7_1~2 &&
+	test_commit 7_I &&
+	git checkout -b 7_6 7_3~1 &&
+	test_commit 7_J &&
+	git checkout -b M_1 7_1 &&
+	git merge --no-ff 7_2 -m 7_M1 &&
+	git checkout -b M_3 7_3 &&
+	git merge --no-ff 7_4 -m 7_M2 &&
+	git checkout -b M_5 7_5 &&
+	git merge --no-ff 7_6 -m 7_M3 &&
+	git checkout -b M_7 7_1 &&
+	git merge --no-ff 7_2 7_3 -m 7_M4 &&
+
+	check_graph M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | | | *   7_M4
+	| |_|_|_|_|/|\
+	|/| | | | |/ /
+	| | | | |/| /
+	| | | |/| |/
+	| | |/| |/|
+	| |/| |/| |
+	| | |/| | |
+	| | * | | | 7_G
+	| | | |_|/
+	| | |/| |
+	| | * | | 7_F
+	| * | | | 7_E
+	| | |/ /
+	| |/| |
+	| * | | 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
gitgitgadget
