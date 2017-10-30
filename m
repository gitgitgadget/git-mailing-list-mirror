Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4EA2055E
	for <e@80x24.org>; Mon, 30 Oct 2017 07:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbdJ3Hmn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 03:42:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52512 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdJ3Hmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 03:42:42 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171030074240epoutp014fa77f406d3c7a84ca9bd74be19c33fc~yST8gUAIJ3194931949epoutp016;
        Mon, 30 Oct 2017 07:42:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20171030074240epoutp014fa77f406d3c7a84ca9bd74be19c33fc~yST8gUAIJ3194931949epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1509349360;
        bh=2DBaVq6TbMaWMXN5lpEY3SkGqSzXHZ3sLzd5+YwH2cg=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=TolbP3AzkYsMyV2s5v5bbhJvbntPRDZL9+viERE8vRCsqrCPtF3dw9N0JsSHh5DcO
         ILmVXgBbCBDV7cX8ZJvZt2rG4YA8PxaAKJb+tZWjBjp3hX6RPoIItDNn60UV7GvUJh
         Bkk0l22vGgYGNTu5wDkoVx3kToqT1YRpXehI4YeU=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20171030074240epcas1p3e5f0151402b00981b10de8eefb737797~yST8XhFIo3134631346epcas1p3O;
        Mon, 30 Oct 2017 07:42:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.A3.04510.0F7D6F95; Mon, 30 Oct 2017 16:42:40 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171030074240epcas1p2680fb8a4a93f767d9f94f2b2cbb5d60e~yST8IJXh31992119921epcas1p2N;
        Mon, 30 Oct 2017 07:42:40 +0000 (GMT)
X-AuditID: b6c32a38-1edff7000000119e-67-59f6d7f00c87
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.46.04095.0F7D6F95; Mon, 30 Oct 2017 16:42:40 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYM007P3LEYGY20@mmp1.samsung.com>; Mon, 30 Oct 2017 16:42:40 +0900 (KST)
Subject: [PATCH v4] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <2b507ce0-0d18-d9d6-11ba-6fb0d4f4a473@samsung.com>
Date:   Mon, 30 Oct 2017 10:42:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7bCmvu6H698iDZp7pSy6rnQzWTT0XmG2
        +Pumi9HiR0sPs8Xmze0sFmfeNDJaHGn/zOTA7vGkuYfFY+esu+weCzaVejzr3cPocfGSssfi
        B14enzfJBbBHcdmkpOZklqUW6dslcGXcmN7AVvCFu+L+8wuMDYxNXF2MnBwSAiYS/V0bmboY
        uTiEBHYwSlzdPwfK+c4o8fPaTBaYqutTjkEldjNK9J77wgzh3GeUWPL1LFiVsICHxJYJMxhB
        bBGBdIn/k/rYQIqYBdYwSmy//wisiE1AT+L8rwnsIDa/gJbE5R/zmEFsXgE7iYa+qUwgNouA
        KtBRq8FqRAUiJI4fXs4IUSMo8WPyPbA5nALBEpMn3QWzmQU0JV58mQRli0scu3+TEcKWl9i8
        5i0zxAuv2SRWT0nrYuQAsl0k5j3igAgLS7w6voUdIiwtcemoLUS4XqK14wnY+RICHYwSn2ct
        ZYdI2Ets6drOBjGeT+Ld1x5WiF5eiY42IYgSD4kJTw8yQdiOEkfWnGeDhNVpNonld7+xTWCU
        n4Xkm1lIPpiF5INZSD5YwMiyilEstaA4Nz212LDARK84Mbe4NC9dLzk/dxMjOPVoWexg3HPO
        5xCjAAejEg+vRua3SCHWxLLiytxDjBIczEoivJcuAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        iq6/FiEkkJ5YkpqdmlqQWgSTZeLglGpg7PvuW8azd87mcyeDmyfeuLn6zUvnY22MfAt/XbJK
        796hX/HLf8U21kw+nq/vNYQX7xGZuXweU7H9xRua9+sMplm23S6z/bfCvSRBTEor7fBsmawz
        izu4OQVEsi/IG8398Gz+W32T2Ulyp2Q8ct7pFtUEvSy+83Ln5aZM89j6ws6saf1nN9avUGIp
        zkg01GIuKk4EAOQsLcI5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t9jAd0P179FGvzby2nRdaWbyaKh9wqz
        xd83XYwWP1p6mC02b25nsTjzppHR4kj7ZyYHdo8nzT0sHjtn3WX3WLCp1ONZ7x5Gj4uXlD0W
        P/Dy+LxJLoA9issmJTUnsyy1SN8ugSvjxvQGtoIv3BX3n19gbGBs4upi5OSQEDCRuD7lGFMX
        IxeHkMBORon7R/awQjgPGSV2Nb9hBakSFvCQ2DJhBmMXIweHiEC6xLZNwiA1zAJrGCXWzXjL
        DNFwlk3i+qLJLCANbAJ6Eud/TWAHsfkFtCQu/5jHDGLzCthJNPRNZQKxWQRUJfq7VoPViApE
        SDxvfs8KUSMo8WPyPbA5nALBEm2rHrODLGYWUJeYMiUXJMwsIC5x7P5NRghbXmLzmrfMExgF
        ZyHpnoXQMQtJxywkHQsYWVYxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+duYgTGyrbDWn07
        GO8viT/EKMDBqMTD25D9LVKINbGsuDL3EKMEB7OSCO+li0Ah3pTEyqrUovz4otKc1OJDjNIc
        LErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGMtlpvF8+jrXrFRpQqDf8Qd/DCpjRVwe15ld
        ufZRrHax7psuXdtU4a1S6mutb+Y+sZgct6GsKIZ1gqTRZ7ayBwb3QuJLHtzxVdjT+Sd4599D
        gU9Ftj5MU2XpvfbT9veHL85aGw+Xnjf6VcS4MzToaUfg7oUPjucW3/RsX1utbVQxL2DV7MtH
        q5RYijMSDbWYi4oTAT2sZKSRAgAA
X-CMS-MailID: 20171030074240epcas1p2680fb8a4a93f767d9f94f2b2cbb5d60e
X-Msg-Generator: CA
CMS-TYPE: 101P
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
        <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
        <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
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
Reviewed-by: Stefan Beller <sbeller@google.com>
---
Added 'reviewed-by' field.
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
