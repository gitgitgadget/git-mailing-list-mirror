Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C2C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504A0613A6
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhKGW7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 17:59:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50786 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236730AbhKGW6d (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2021 17:58:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D2B3F6077A;
        Sun,  7 Nov 2021 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636325749;
        bh=H3ICVDYIlS8MAoJz/SzjR5wDxHfZiQPKji0K0JsnwFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=a+nF5Ly1czZmRllmC4IXsjVt7UiecZKFIPC7x3IcRzlFZ3no8F+1CPjto032JLOMr
         q9zI4pVrQh2HkogVYlUahWwFwUOGrtWuBIzcXedlcgvlsYNjQWEs1aD1hTfOUhhYzZ
         1b4Ti9GJAII1zh37g8Nb+OoKhXNUA/nj6fgtbNGFVZ2SAKKRNwAgswczAttj81Vg8P
         A5ioy4s8Qwge8eM5g3/6egG8BPv0e12oVAWr9h6g8rqC2ANoyJLG97c5VTmeho4b7q
         WkGNmuvwFoDku+Ao/KG42y1j4We5h3j1z8qliThqfuBQB+Y4ulIpDgs5f5psWw9Eq2
         qxA3OgMhXjM2qMZ1WN5+bicrgMGrkr6uJevPU+gpzSQXWeScC6wIeEHbbC2LRq+VGS
         J/1pLVkiH8VrLV8humBZfTaGoOEfL3n8CGAHZPT0Eb4KPkTwNYa1YgcP1nJ2cD/2Lg
         VoIHCt/W5L+6nB7/JOSin9GmLespx1JSJ3GsZ3hG+lv4/V4SYV9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 1/3] gitfaq: add documentation on proxies
Date:   Sun,  7 Nov 2021 22:55:23 +0000
Message-Id: <20211107225525.431138-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211107225525.431138-1-sandals@crustytoothpaste.net>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many corporate environments and local systems have proxies in use.  Note
the situations in which proxies can be used and how to configure them.
At the same time, note what standards a proxy must follow to work with
Git.  Explicitly call out certain classes that are known to routinely
have problems reported various places online, including in the Git for
Windows issue tracker and on Stack Overflow, and recommend against the
use of such software.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 946691c153..5c21951f7b 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,29 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+[[proxy]]
+Can I use a proxy with Git?::
+	Yes, Git supports the use of proxies.  Git honors the standard `http_proxy`,
+	`https_proxy`, and `no_proxy` environment variables commonly used on Unix, and
+	it also can be configured with `http.proxy` and similar options for HTTPS (see
+	linkgit:git-config[1]).  The `http.proxy` and related options can be
+	customized on a per-URL pattern basis.  In addition, Git can in theory
+	function normally with transparent proxies that exist on the network.
++
+For SSH, Git can support a proxy using `core.gitproxy`. Commonly used tools
+include `netcat` and `socat`.  However, they must be configured not to exit when
+seeing EOF on standard input, which usually means that `netcat` will require
+`-q` and `socat` will require a timeout with something like `-t 10`.
++
+Note that in all cases, for Git to work properly, the proxy must be completely
+transparent.  The proxy cannot modify, tamper with, change, or buffer the
+connection in any way, or Git will almost certainly fail to work.  Note that
+many proxies, including many TLS middleboxes, Windows antivirus and firewall
+programs other than Windows Defender and Windows Firewall, and filtering proxies
+fail to meet this standard, and as a result end up breaking Git.  Because of the
+many reports of problems, we recommend against the use of these classes of
+software and devices.
+
 Design
 ------
 
