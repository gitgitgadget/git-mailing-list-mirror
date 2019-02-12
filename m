Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C991F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfBLBXj (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbfBLBXi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:38 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0E12160E57;
        Tue, 12 Feb 2019 01:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934615;
        bh=hXIxm2OltYi/N9VgtHCQFReQEeiQbRf+hi6+lBEL08E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oeqDz0u5FGsjsNjGcM5YsFT07m+Qt6STTHntrY7tOX4I/MoCOXWM9s6rDwSBLgkOB
         bwicmOjBKGeZ5HIf3+P16IOT352+YYOQT9aILtcKsFHlyIToBD59x0dcEFXQqqE+2p
         K5F3wLbqC+9q+OaHU8HxryaiKoK25w4p6aAG1gGnDDe+KW9zKa46vxKqQRS/znrTOr
         C6LmRXUEvZgarbZORib6zFOQ1fQUcEm/aQ7F1uhWJVB6vBRYLO847u9MKYRzxUNJ3v
         JLNhz6rmyh+ML/8+Rra3upagFEjzXy56x4H3GPWO7igrs+40/cpkhIoZQabqcEdgGO
         EKmtG035jLmYdYNk/xeQyAOAJYjv1Q1Xc065ZgvKwny6sJqYiWODeVBnnotUHhcjE5
         00GeSVotLsDEzX7NQOdZlg/wiLCtfpcwBjRMwRwTRyKz74NRBV+Rg7hkZeVGfUXAnQ
         vIFZEtx4vuXOfTJCK3aHsLbvesMnUr9oS2RQDO0/vt0a/ySCis8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 20/31] http: replace hard-coded constant with the_hash_algo
Date:   Tue, 12 Feb 2019 01:22:45 +0000
Message-Id: <20190212012256.1005924-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a hard-coded 40 with a reference to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index a09adc518f..993ddc956a 100644
--- a/http.c
+++ b/http.c
@@ -2065,7 +2065,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	url = quote_ref_url(base, ref->name);
 	if (http_get_strbuf(url, &buffer, &options) == HTTP_OK) {
 		strbuf_rtrim(&buffer);
-		if (buffer.len == 40)
+		if (buffer.len == the_hash_algo->hexsz)
 			ret = get_oid_hex(buffer.buf, &ref->old_oid);
 		else if (starts_with(buffer.buf, "ref: ")) {
 			ref->symref = xstrdup(buffer.buf + 5);
