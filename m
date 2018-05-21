Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436911F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeEUCC0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50810 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752509AbeEUCCY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8951A60732;
        Mon, 21 May 2018 02:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868141;
        bh=t576ojGFsRiMEkPGa4Hn9wThwswnOWW6bCcV3zcUgJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GaMbVyaT5T7LdV4jTC3XxqRFU72ELn9DRfLeMbaxtG5Ok7TS597+Dg5zi2A9AmxHl
         sAHWLvXPF25P1fzII4Zi6uw90ETGM4zZlQF7sufmgxKUBTLFGdMI7Be59HR1tBU+qz
         yzqS0sO9+vhE10002BCb+ZfZwJkeji9N5dATacZmXOowvtTqz3WWXnxyEdDaaoK6yt
         pTkPHhwjZma/XF4f1tKoNpkrjMhTgHD9yg2n4BqMCRvHiyjlrpg6zt+8Vtd0yxyvu8
         0KjL1zE/iOnzfLfcsnxY7tbgvG+cYp7P5dvRrjNS+W3AFNdhKUh/zIoeBkypADNg4g
         CDptCRzfly0iEUNn+ZPsD0V7xhVP0aVcvBZYrjxFG/X6sin0lqYWYrAOcz+wPt94Zk
         BAkRK5zt15IUjsjfA5dWGU5areGw0nRVUstpGOiF8mUtZelBo0WGuBWNfvfGxJnMUi
         GI7FyMaaCkzpEFRIIOT0J+6FCzq21w+deAFGA2zyrWnTt1i5ZCu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 04/28] t/test-lib: introduce OID_REGEX
Date:   Mon, 21 May 2018 02:01:23 +0000
Message-Id: <20180521020147.648496-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we have a variable, $_x40, which contains a regex that matches
a full 40-character hex constant.  However, with NewHash, we'll have
object IDs that are longer than 40 characters.  In such a case, $_x40
will be a confusing name.  Create a $OID_REGEX variable which will
always reflect a regex matching the appropriate object ID, regardless of
the length of the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 58c2ea52c6..fed21c3dfc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,6 +184,7 @@ _x40="$_x35$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+OID_REGEX="$_x40"
 ZERO_OID=$_z40
 EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
@@ -196,7 +197,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID
+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
