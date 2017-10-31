Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D8A202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 09:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbdJaJJV (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 05:09:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17399 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdJaJJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 05:09:19 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171031090917epoutp0386a561fb89fc02df9cd56b7328cc30e8~ynI3Fwh-B2149721497epoutp036;
        Tue, 31 Oct 2017 09:09:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20171031090917epoutp0386a561fb89fc02df9cd56b7328cc30e8~ynI3Fwh-B2149721497epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1509440957;
        bh=ATi/qkeKp62CUkK1XNzRyyO3Wkg/PchiX5670fyfOaA=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=X1mh/pxbflk+p/4m7tyukSUOK+tHFSzj+xBwTnvqA5YDG9vV2VwUcpPR8PQzXao92
         zVqZTt9zjyiD3+FJl9nRQF2DcuB1vlkp2ft5ISmBHO3QznC4UEz9fNwyIz7ZqZcglY
         /IACFna4AL/dniVpdBlcrHp8oCTr/TIgoAussKUA=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20171031090917epcas1p4ec87a613f69d28472e5f852d63882b5d~ynI28SkR81666216662epcas1p4T;
        Tue, 31 Oct 2017 09:09:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.A7.04139.DBD38F95; Tue, 31 Oct 2017 18:09:17 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20171031090917epcas1p39087e30e2877442613daaa15075b0749~ynI2srx3Z2812628126epcas1p3E;
        Tue, 31 Oct 2017 09:09:17 +0000 (GMT)
X-AuditID: b6c32a39-969ff7000000102b-6b-59f83dbd1b79
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.2B.04095.DBD38F95; Tue, 31 Oct 2017 18:09:17 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYO00DFUK3EUL20@mmp1.samsung.com>; Tue, 31 Oct 2017 18:09:16 +0900 (KST)
Subject: [PATCH v5] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <f0d63948-80f3-b2d8-8623-49ae13ca87bf@samsung.com>
Date:   Tue, 31 Oct 2017 12:09:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <xmqqwp3byeai.fsf@gitster.mtv.corp.google.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmge5e2x+RBsuOqlt0XelmsmjovcJs
        8fdNF6PFj5YeZovNm9tZLM68aWS0ONL+mcmB3eNJcw+Lx85Zd9k9Fmwq9XjWu4fR4+IlZY/F
        D7w8Pm+SC2CP4rJJSc3JLEst0rdL4Mrov7iDpWA1V8Wna3/ZGhivcXQxcnJICJhILOmdwNTF
        yMUhJLCDUeLr4YXsEM53RolZ60+ww1Qt/zGBDSKxm1HiffMMZpCEkMB9Rollq31BbGEBD4lH
        7XPYQGwRATWJiW2HWEAamAXeMkpM2XKSESTBJqAncf7XBLCp/AJaEpd/zAMbxCtgJ/Hz53ow
        m0VAVeLM2hawelGBCInjh5czQtQISvyYfI8FxOYUsJZ4dPwAWJxZQFPixZdJLBC2uMSx+zeh
        4vISm9e8ZQY5QkLgNZvE/e+bWCDecZHYN/UFG4QtLPHq+BaggziAbGmJS0dtIcL1Eq0dT9gg
        ejsYJT7PWgoNCnuJLV3b2SAW8Em8+9rDCtHLK9HRJgRR4iEx4elBJgjbUeLImvPQkDvDLnFt
        0mqWCYzys5D8MwvJD7OQ/DALyQ8LGFlWMYqlFhTnpqcWGxaY6hUn5haX5qXrJefnbmIEJx8t
        yx2Mx875HGIU4GBU4uF1iP8eKcSaWFZcmXuIUYKDWUmEV+gjUIg3JbGyKrUoP76oNCe1+BCj
        NAeLkjiv6PprEUIC6YklqdmpqQWpRTBZJg5OqQbGeo2Jf15H3727sf+6yVq1PkVPX8bo+QFN
        nqvbVzrf23BEyuDqm4+1tW/+RvC+eMl1y8ay37OOvdBfpWZN+HQFZe5X0+8WBUgHrhJTWfIv
        d+uLI01egVHC7iGd/yNr1cp/JR+5Gjkp/v7HS/sOTHIt0UkVvly3sUbWaOoxBcUFLmfXq+y8
        8G+bEktxRqKhFnNRcSIAURu3cToDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jAd29tj8iDTZeFrLoutLNZNHQe4XZ
        4u+bLkaLHy09zBabN7ezWJx508hocaT9M5MDu8eT5h4Wj52z7rJ7LNhU6vGsdw+jx8VLyh6L
        H3h5fN4kF8AexWWTkpqTWZZapG+XwJXRf3EHS8FqropP1/6yNTBe4+hi5OSQEDCRWP5jAlsX
        IxeHkMBORomZW3exQzgPGSW6n85nB6kSFvCQeNQ+hw3EFhFQk5jYdogFpIhZ4C2jxLzbMxkh
        Os6xS6xa8wasik1AT+L8rwlg3fwCWhKXf8xjBrF5Bewkfv5cD2azCKhKnFnbwghiiwpESDxv
        fs8KUSMo8WPyPRYQm1PAWuLR8QNANRxA29QlpkzJBQkzC4hLHLt/kxHClpfYvOYt8wRGwVlI
        umchdMxC0jELSccCRpZVjJKpBcW56bnFRgWGeanlesWJucWleel6yfm5mxiB0bLtsFbfDsb7
        S+IPMQpwMCrx8M5I/B4pxJpYVlyZe4hRgoNZSYRX6CNQiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkZ57wKDq1GeW38LXz6/4fluv6W7b2l1FT0vM5W6
        XqseIL74ZOOi6TYnEzrZ8u5JdkSyrdb8uzxj/v24z20/lF5eufj/F5/rzXnuLyK14r8ZBWfN
        0lrGNPvQJxFZm90Btr+6c2p+nr0k8dZ4iui1WOn/l7O0Xq/ISU40OVAsvZxtVZurhdCdCbeU
        WIozEg21mIuKEwHm4qd9kgIAAA==
X-CMS-MailID: 20171031090917epcas1p39087e30e2877442613daaa15075b0749
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
        <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
        <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
        <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
        <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
        <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
        <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
        <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
        <2b507ce0-0d18-d9d6-11ba-6fb0d4f4a473@samsung.com>
        <xmqqd1543xfc.fsf@gitster.mtv.corp.google.com>
        <xmqq37603vek.fsf@gitster.mtv.corp.google.com>
        <ecb12f21-f26f-6905-1fdc-60d7c282cfe3@samsung.com>
        <xmqqwp3byeai.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of the duplicated getenv('GIT_MERGE_VERBOSITY') calls with the same
constant string argument. This makes code more readable and prevents typo in
the further development.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
Commit message is reworked according to the feedback.
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

