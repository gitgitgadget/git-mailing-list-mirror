Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2CA1F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeJOHpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbeJOHpA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BEDA961B7B;
        Mon, 15 Oct 2018 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561736;
        bh=QTAeYojQOsmNZI0XOfqBrXs6MTsVfciEnFUO51RbfL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Hd0XX59o+NQRz09gA1MX9h5CPbxU1qRS0wH89MWtJfxDhnovB3OvYCwgcnhVNTT6/
         npkpJ78uUcas+maRqIBUvlA4LIsFw6c7xNVMstqAC47crQAXJtJHb86RnqtfqJpmLp
         c/dziowbr9c8q0ebnF1vrtMiffvm2j2boapTe4H2xtTbJBfFqG4hJg7R+j3JcxL3Un
         ElgcHWixQr0XwyXUt91eoSGuR5M/G2xw04FqgIh41EAaDYaRlP1Qb1w+GyvGjGXaCv
         XliKI0GJE6b+++R2quA+W7Ssq37QV+1XbrQ9xhBLF8mSPF9XEYXRZI+zpCNRlvfYzU
         hzbT0MieiQTb48MiThPbget2eLUXzEdFllUa7GwWtmZ2M94bkN6B64DHR17uDIlE6N
         /aB762cj+Ahzz9AxkvsNY7TFOqhkmumFDVMuZXnNPM7LmSheqQOHAfek/xCPkrYqjS
         6jUHSdXBjqPb4EhNc/gxfJCVnFpo6hYt8PWOmy40FLSpQG72GTM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 04/15] builtin/mktree: remove hard-coded constant
Date:   Mon, 15 Oct 2018 00:01:51 +0000
Message-Id: <20181015000202.951965-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a hard-coded constant for the size of a hex object ID,
switch to use the computed pointer from parse_oid_hex that points after
the parsed object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 2dc4ad6ba8..94e82b8504 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -98,7 +98,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 
 	*ntr++ = 0; /* now at the beginning of SHA1 */
 
-	path = ntr + 41;  /* at the beginning of name */
+	path = (char *)p + 1;  /* at the beginning of name */
 	if (!nul_term_line && path[0] == '"') {
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
