Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA7C1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdJXPPZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:15:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15131 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbdJXPPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 11:15:11 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20171024151509epoutp02c57d3a3fbe70727f6db72782806b7824~winTH6nCH1021310213epoutp02R;
        Tue, 24 Oct 2017 15:15:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20171024151509epoutp02c57d3a3fbe70727f6db72782806b7824~winTH6nCH1021310213epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508858109;
        bh=JTeGvgaVGsHCAZbbc57Dzx4fqk1VNVk55DCOXigTlts=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Jhcc6taKihZ8hAx+EJTD1/Cd+ovJXw70de8V8eN9K1S+JkdO5RC93tjBTS/aCPaUL
         6bqvNaOCclmZUpyu4bVsCH600oPHE0zmB4FjN5gQ6eCBV/Ty3kzBbvrIULJQi5HPEv
         zwDn9sve13xXbOqBt1JlLLi0NTEQJVv9VEk7hYxs=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20171024151509epcas2p1f48aab6e994776a8cf217d5dccd12e30~winS8OBUM1832718327epcas2p1v;
        Tue, 24 Oct 2017 15:15:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.CC.04140.DF85FE95; Wed, 25 Oct 2017 00:15:09 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922~winSMoGnq2867928679epcas2p4K;
        Tue, 24 Oct 2017 15:15:08 +0000 (GMT)
X-AuditID: b6c32a47-cefff7000000102c-0c-59ef58fd5a10
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 8C.DE.03859.CF85FE95; Wed, 25 Oct
        2017 00:15:08 +0900 (KST)
Received: from [106.109.129.81] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYC00J6S2D67740@mmp2.samsung.com>; Wed, 25 Oct 2017 00:15:08 +0900 (KST)
To:     git@vger.kernel.org
Cc:     dturner@twopensource.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Subject: [PATCH] path: use xmalloc in add_to_trie
Organization: Samsung RnD Institute Russia
Message-id: <e63c2208-900e-138a-a13c-fecf9403e0b8@samsung.com>
Date:   Tue, 24 Oct 2017 18:15:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmue7fiPeRBke7OSzmbzrBaNF1pZvJ
        oqH3CrPFj5YeZgcWj2e9exg9Ll5S9ljw/D67x+dNcgEsUVw2Kak5mWWpRfp2CVwZ3QuXMhc8
        Z6+Y9ewiYwPjIrYuRk4OCQETiQ1HngHZXBxCAjsYJXaseM0M4XxnlLh56gULTNXb5dMZIRIb
        GCVWvG2Gcu4zSuxc+ROsSkRAXOLt8ZnsIDazQKzEof3nwGw2AT2J878mANkcHMIChhKbP2eC
        hPkFtCQu/5jHDGLzCthJTHj4FqycRUBV4tW+02AjRQUiJI4fXs4IUSMo8WPyPRaI8ZoSL75M
        grLFJY7dv8kIYctLbF7zFuwDCYElbBKPzj6H+tNFYsf6OUwQtrDEq+Nb2CFsaYlnqzYyQtj1
        Eq0dT9ggmjsYJT7PWgpVZC+xpWs7G8QGPomOw3/BnpEQ4JXoaBOCKPGQuPZxCzOE7Shx5eUT
        sHIhYDjM2DCNcQKj3CwkP8xC8sMsJD/MQvLDAkaWVYxiqQXFuempxUYFxnrFibnFpXnpesn5
        uZsYwalCy30H47ZzPocYBTgYlXh4G8zfRQqxJpYVV+YeYpTgYFYS4V1h8j5SiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOG/dtmsRQgLpiSWp2ampBalFMFkmDk6pBkaWJSnXw7KZvq4/Ujs3stn6
        8Pr5B5ln3F4yre91Q3bYg2um9evCTSTnG3LG1btXB5TGPEstcjXmmK/2fcv3+LhqScPQlISN
        3pPPf3bWDHU9d+lHz6uwve+aJZunPXPrtb8lF/3rucuhRS6aL3cYVrV8XXT64tkQ0xCGnx+f
        fzslvfxAyC3jhbuUWIozEg21mIuKEwFSINFBEQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t9jQd0/Ee8jDXa0C1nM33SC0aLrSjeT
        RUPvFWaLHy09zA4sHs969zB6XLyk7LHg+X12j8+b5AJYorhsUlJzMstSi/TtErgyuhcuZS54
        zl4x69lFxgbGRWxdjJwcEgImEm+XT2fsYuTiEBJYxygx4+8WKOcho0TL+cVMIFUiAuISb4/P
        ZAexmQViJc5d+MgKYrMJ6Emc/zUBKM7BISxgKLH5cyZImF9AS+Lyj3nMIDavgJ3EhIdvwVpZ
        BFQlXu07zQJiiwpESDxvfs8KUSMo8WPyPRaQMcwC6hJTpuRCbBKXOHb/JiOELS+xec1b5gmM
        /LOQdMxC6JiFpGMWko4FjCyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECw3fbYa3+
        HYyPl8QfYhTgYFTi4b1h+S5SiDWxrLgy9xCjBAezkgjvCpP3kUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYWUUXbt9ZsLFOVUdPu+vvwwi2TxMOq4Zf
        X2Z7t9bkprP137SYOWob7SuD1jirCXE/WRlhvUWz2jL2a+n759OunWqfIqA68cyrOWaLdsxN
        KzCNbWD70LvcxENl2u2VVl3JxxPWPzawOPvxlyD73OsO/wJSD3ItymcqYl53Jokpd9L8u4sW
        CEj+UWIpzkg01GIuKk4EANo8TPZbAgAA
X-CMS-MailID: 20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922
X-RootMTR: 20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922
References: <CGME20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922@epcas2p4.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add usage of xmalloc() instead of malloc() in add_to_trie() as xmalloc wraps
and checks memory allocation result.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
Hello,
I'm not sure but it looks like there is a missing check of the malloc result.
memcpy() may crash with SIGSEGV due to the memory allocation failure.
make_trie_node() uses xmalloc() and xcalloc() - so I believe add_to_trie()
also should use it.

Best regards,
Andrey

 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 335d4dd87..69b23ef17 100644
--- a/path.c
+++ b/path.c
@@ -191,7 +191,7 @@ static void *add_to_trie(struct trie *root, const char *key, void *value)
 		 * Split this node: child will contain this node's
 		 * existing children.
 		 */
-		child = malloc(sizeof(*child));
+		child = xmalloc(sizeof(*child));
 		memcpy(child->children, root->children, sizeof(root->children));
 
 		child->len = root->len - i - 1;
-- 
2.14.3
