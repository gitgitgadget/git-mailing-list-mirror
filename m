Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2F120984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbcIMQkq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:40:46 -0400
Received: from mout.web.de ([212.227.17.12]:51459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753562AbcIMQkp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:40:45 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MZDTE-1bRCur07bw-00KvAt; Tue, 13 Sep 2016 18:40:33
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: use valid pointer in strbuf_remove()
Message-ID: <408af1a3-6867-2ff5-c97f-3eb884412ad8@web.de>
Date:   Tue, 13 Sep 2016 18:40:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dMew4R9kGgV2P+waKVkLCeuJ4TabLnFJ8lZTTA41jf81QCElz0S
 j2eVjIgOXr3XlL2Un1PJNGdR7m5Dp5FbI4POVfCKQg4FRSUVCCY5hxxdj8ckK3OV5mhYlH0
 /cR/FRq6ordPqLUCYBgb1xFZ3PHLL2yNTGBE+guQTFfzTcGbAok199ZA5ejdvkMXkvRcI/z
 JFIBmDsOUf7Lx/6Q3kwRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/+FJSEZArVk=:srfsdPFv42T/Y+Pym+a669
 2bRVuEI9khVK2NFG1RBWV8Gfx+fsf55DvBRTRaTjnwqYMGlelshHOhcMwTVJt9efsSKhTK/ch
 aCENW7/u9crCOtDQhRukXBdL7WgCBrfcu6FFdKWpcrwXxKZqjXwtf83PicPmgyZkB7JLkTlxe
 rS85UomsOuiRE21gKgyV/G1q/ZlGH9LYsPqgiSaiY3wuvRR9rKS+a8rdz/4bFJwgwS/+jUM/F
 RTUcDsNrDphXVbMCqsR0LLYwwNFAkIbBhn0rHgC18gmo4WsGI3oTELVWdlfYog8fQpyuU9Clt
 s5YEZNgwTL8UfJQcpxPYe5BE6wqV0zpoCAhPnBKKNYcXiBtEsgkEyuNAOsl9L37QFJpHtkLQ5
 YgwxzNlLblmW0ebkTxJIhiEHE/qSlIpVsDax8X3yRRs3QaDqXgP3mlLEl8Rptx6h2YWPVqBur
 WMd2NyOEltbtgUZa+RjNc8aupRyTIuj/FDWzP27QO8q5/dgIMMCp7wvWOfkpPZJRBvc3luU0O
 w9Id4LCj2ngs0h5U8tgGhxDPAuzfyS1SgwD3ws0F+bK+oEfthJ+gy7zBUsD6vP469yEM3Bpnk
 jFiT9cHmc2UBC4lWY0/QWQWQL3nOo/ZwhO6I3Ga6TEwq+3+ixJkc+tMhKAElxvbfuqm9TtxMe
 EAE4EUIRv3ghqpRaSR3i8w6GLHPMlFkMv5WjHzDQfZLOseKMUV038pgLcj9V2UOXg9bEYhUwp
 0W7smmpN1gF5kRGQxsHn78BVfeGBTwkmrRjpxojlePExkZelCaAXvSMdiWNhFfYmBo4gQkT52
 B7X1ViM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fourth argument of strbuf_splice() is passed to memcpy(3), which is
not supposed to handle NULL pointers.  Let's be extra careful and use a
valid empty string instead.  It even shortens the source code. :)

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index f3bd571..b839be4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -187,7 +187,7 @@ void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
 
 void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
 {
-	strbuf_splice(sb, pos, len, NULL, 0);
+	strbuf_splice(sb, pos, len, "", 0);
 }
 
 void strbuf_add(struct strbuf *sb, const void *data, size_t len)
-- 
2.10.0
