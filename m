Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6843B202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 13:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750823AbdJYNDT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 09:03:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41477 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdJYNDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 09:03:17 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171025130315epoutp0464dda94632e554cf9174b04428e4903c~w0dbePPZW0790707907epoutp042;
        Wed, 25 Oct 2017 13:03:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20171025130315epoutp0464dda94632e554cf9174b04428e4903c~w0dbePPZW0790707907epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508936596;
        bh=3E66ip6coy45MSovC8+h9RFctXxjOlxetC8vU2vp+is=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=FnKe/0O6QCT1Pj6cKG/JZulJtDLWeH5nqshAfJX+j475gAQRO3B7CMYj/JXe91wJp
         YBK/aPisa7MaoiD1P/hqFpR/aKrIhOjiFCUCAe9F4VnosDri3Lticuw29/bkAT6Gfw
         EMjHKAr5Kvk8jF6DfyG7DWyOfbW9aEPwGQK1PLDU=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20171025130315epcas2p394859f77d2691a4767babef9d71c2ca4~w0dbCI8hs0186701867epcas2p3W;
        Wed, 25 Oct 2017 13:03:15 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.7F.04140.39B80F95; Wed, 25 Oct 2017 22:03:15 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20171025130315epcas2p165c956927d99cabdb9071be47656f0a5~w0da0dVw02199621996epcas2p1v;
        Wed, 25 Oct 2017 13:03:15 +0000 (GMT)
X-AuditID: b6c32a47-cd7ff7000000102c-a9-59f08b939d10
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.CE.03859.39B80F95; Wed, 25 Oct 2017 22:03:15 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYD003GUQXCYP80@mmp1.samsung.com>; Wed, 25 Oct 2017 22:03:14 +0900 (KST)
Subject: Re: [PATCH v3] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
Date:   Wed, 25 Oct 2017 16:03:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3ebXezmz+n5mFWwsRCIU0TWxCWIXUJiSgLFXpc8qbifLDr
        RC3MUHNORcnMGPmILHEI+cIHGpHTVIyWtaQCp4WK6ExNoSGItV0D//uccz78Dt/DjyIUL8VK
        KiU9i9OmsxqVRE52mwMjjlSXrcYfXTMq1QZrmUhdUGEl1Ft2A1I7isoJdWdnCal+b7+P1EMl
        66LTUma2sJxk+oxTUqaxQ8fMVwwgZuKTP/N85jyz3nHwojRBfjKR06Rkc9qQyJvy5HlTH8r8
        6JYz1mBGBWhKZkAUBTgcTGseBiSnFLgXwUDDsMiAZP+KPwg2KsKc7HQ6e5ZIQepH8GtqRCwU
        0wiWH9WInZYnjgFb0RjpZC+sge2BCYlTInAzgmczdYRzIMHBYNmskjrZHQfBZ0e9q0/jSOhv
        mnM9ROIAaCt0uPreOA5GzM1IcDzAUW1zLZDhy9BUVeliAgfCwsbDHfaBd9PfkMB+0Nm6TAgR
        liTwdEIpcDT8qFmVCOwJiyNdUoF9Yd7UjgS+B8X6WVcAwHoE68YXO9Ip6DL0SIQFe0Fv3pIK
        d6RB/0AhKAxUzb0VCRwFQ60WiXAtixjqiy2iKuRn3JXHuCuDcVcG464MjYg0oX1cJp+WxPFh
        mceCeTaN16UnBd/KSOtArt8TdK4XdX+IGUSYQqo9NK5diVeI2Ww+N20QAUWovGhKtxqvoBPZ
        3DxOm3FDq9Nw/CDypUiVD53fPRmnwElsFpfKcZmc9v9URMmUBSjWGlKrap98M646u2KbuLQx
        Xqfzjqu707A8U7oUX3N7PfLaV/Pr1O+hpT+LUOJxm30gar+dipqxbj6xBrS1bUePun8hDCfy
        7rZw4lm/8DP5jF+XPGKZVogPXc9JclscLSvpGZXrK7mWwxfqQtBwVkKRPPg3ezWWPrAw/uqx
        /xUVySezoUGElmf/AnbzgzU5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t9jAd3J3R8iDT5M4bDoutLNZNHQe4XZ
        4u+bLkaLHy09zBabN7ezWJx508hocaT9M5MDu8eT5h4Wj52z7rJ7LNhU6vGsdw+jx8VLyh6L
        H3h5fN4kF8AexWWTkpqTWZZapG+XwJXxbNVOxoIL3BUn5x9mbGC8y9nFyMkhIWAisXn7a5Yu
        Ri4OIYGdjBJz579jBUkICTxklDiz3RfEFhbwkbjXcpIFxBYRyJHo/HGdCaSBWWA5o8TZbU2M
        EN0XWSWWTLvIDlLFJqAncf7XBDCbX0BL4vKPecwgNq+AncTuJU/BNrAIqEpsaP4BFhcViJB4
        3vyeFaJGUOLH5Htg2zgFgiU+fnoHtI0DaJu6xJQpuSBhZgFxiWP3bzJC2PISm9e8ZZ7AKDgL
        SfcshI5ZSDpmIelYwMiyilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMFa2Hdbq38H4
        eEn8IUYBDkYlHt6Mme8jhVgTy4orcw8xSnAwK4nwcpR+iBTiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXAKL3JS1wtie3SokK2xruyCzgjnFbfvrBd6DWH
        PNPU974JD2tOfdP5wrh02v2fu5ZHbVFh6P2wPetRjuDePpWn0sanJs9vsPP6nuxqsSlPjPfy
        D/HT7WmBvbMO1H2SyGF/puvWzRKm4n7uH/MP9X07m6+ITGHYdqf5omTwVnknhtmz27+7btnp
        rcRSnJFoqMVcVJwIAF1/CH+RAgAA
X-CMS-MailID: 20171025130315epcas2p165c956927d99cabdb9071be47656f0a5
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
        <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
        <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
        <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
        <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
        <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get 'GIT_MERGE_VERBOSITY' environment variable only once in
init_merge_options() and store the pointer to its value for the further check.
No intervening calls to getenv(), putenv(), setenv() or unsetenv() are done
between the initial getenv() call and the consequential result pass to strtol()
as these environment related functions could modify the string pointer returned
by the initial getenv() call.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
I tried to rework the commit message.
 merge-recursive.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb8..60084e3a0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
 
 void init_merge_options(struct merge_options *o)
 {
+	const char *merge_verbosity;
 	memset(o, 0, sizeof(struct merge_options));
 	o->verbosity = 2;
 	o->buffer_output = 1;
@@ -2171,9 +2172,9 @@ void init_merge_options(struct merge_options *o)
 	o->renormalize = 0;
 	o->detect_rename = 1;
 	merge_recursive_config(o);
-	if (getenv("GIT_MERGE_VERBOSITY"))
-		o->verbosity =
-			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
+	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
+	if (merge_verbosity)
+		o->verbosity = strtol(merge_verbosity, NULL, 10);
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
-- 
2.14.3

