Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2B1202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 11:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750788AbdJYLj0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 07:39:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:21581 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdJYLjY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 07:39:24 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171025113922epoutp011fc15319114e1b550087e56e3599b345~wzULZ79f31468914689epoutp01j;
        Wed, 25 Oct 2017 11:39:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20171025113922epoutp011fc15319114e1b550087e56e3599b345~wzULZ79f31468914689epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508931562;
        bh=XfPEYmfzIvIhxjcFgj0I9hPIuR8vZdKppFcE/p6Zcfs=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=YM18VWigxAJAKGqa1ZeOluMzrZm5PHAlqQgksyp8zNj0/FqlhERikmxtDQWIlP7IL
         bV/jFKdkbk1v/a/QapOrV6mWubaNksZaJSLF0vEwrltZUibP+qQeN3GQkYLTqH3SqE
         cpa08RC/Rv4SHvya3h8okUH/8DRIv2V/0OpDoyKY=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20171025113921epcas2p31076506371e7cee8b042f64a8acdcc5e~wzUKxceiM0631206312epcas2p31;
        Wed, 25 Oct 2017 11:39:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.6E.04158.9E770F95; Wed, 25 Oct 2017 20:39:21 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171025113920epcas2p4fe42149385c058da3f1362fc3f362b17~wzUKQcRxG1384913849epcas2p4h;
        Wed, 25 Oct 2017 11:39:20 +0000 (GMT)
X-AuditID: b6c32a48-905ff7000000103e-18-59f077e95e25
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.8C.03859.8E770F95; Wed, 25 Oct 2017 20:39:20 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYD003RAN1I9G60@mmp1.samsung.com>; Wed, 25 Oct 2017 20:39:20 +0900 (KST)
Subject: [PATCH v2] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
Date:   Wed, 25 Oct 2017 14:39:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGO7vX7TpdnubbvykpEyVHzl40RoRlSF0jKvqi9kVXXlRyOjZn
        aVQLTdfUGFmJ+xBGhmEivr+kVm7qEMuZk7KwzDTJsBRnppIU253gt9/heZ5z/s+fQxHCp24i
        KiMrh1FlyTPFXD7ZZg4/GDF3eTFp78SdQJl+rIQj05aNEbKNeT2SrRaWErLm5mJS9nr+JpL1
        Fds5R3n0TEEpSXcaP/HoqiYNPVvWjei3oyH04y8naXvTrrO88/zDqUxmRi6jioxJ4ac3jMwQ
        yn6PK0vWWaRFH931yJ0CHAWNlimOHvEpIe5AMNE1SbKHPwh6lk3kpqvg9hKPFboQzE23uCKT
        CNb7tIQeUZQ3pqH1d5gj4IOPw2L5oPMmAg8hqOit5zkELpaCdd3gZC8sAdvqQ8LBAhwD1qL7
        bg4mcSi8H/zKdbAvTgSLuQaxnh2wWv7ZOZE7jgOL/p+TCRwO35fvutgfBiY/IJaDoLnuJ+EY
        AvACF4ZauhFbJw5aX6zxWPaGH5YWFwfAbG2jy3MDbulmuGxYh8BufOIyHYEWfTuXfWE76Mwb
        PEd7wALQFQlZCw2Gb70clmOhr87KZbdlI8Fg+oUMKMi4pZBxSwnjlhLGLSWqEFmL/BilWpHG
        qPcro6RquUKtyUqTXsxWNCHn/5HQHejV8CkTwhQSewpwxUKS0E2eq85TmBBQhNhHQGkWk4SC
        VHlePqPKTlZpMhm1CQVQpNhfcL3tXaIQp8lzmEsMo2RUmyqHchdpkSFaUum5J8K3OTJ4rbVn
        ZfxA4On6Tts20cij4eBlU0wuOdcf/dL8JttvfSCKk3CGf62HeFDTkEC0V+ZbFqQea7HnLkxX
        J9+LLwsbt6kOJe00jirsu/3KobowNEr0nB5rkq5MSUueHQs0jl9N8QrxmDhhl9u4KLDf+6/F
        SzIdLybV6fJ9EkKllv8HUuhMnDsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t9jAd0X5R8iDRq2G1t0XelmsmjovcJs
        8fdNF6PFj5YeZovNm9tZLM68aWS0ONL+mcmB3eNJcw+Lx85Zd9k9Fmwq9XjWu4fR4+IlZY/F
        D7w8Pm+SC2CP4rJJSc3JLEst0rdL4MrYcOEJc8FR7opP558xNjDe4uxi5OSQEDCRaO78xA5i
        CwnsZJTYvFi8i5ELyH7IKPH/42WgBAeHsICHxNavaiA1IgJuEh8mn2QBqWEWOMso0XtmFRNE
        w1UWiUufPjOBVLEJ6Emc/zUBbCq/gJbE5R/zmEFsXgE7ifNtU1lBbBYBVYnrJx+xgdiiAhES
        z5vfs0LUCEr8mHyPBcTmFHCRON71nwXkCGYBdYkpU3JBwswC4hLH7t9khLDlJTavecs8gVFw
        FpLuWQgds5B0zELSsYCRZRWjZGpBcW56brFRgVFearlecWJucWleul5yfu4mRmCkbDus1b+D
        8fGS+EOMAhyMSjy8GTPfRwqxJpYVV+YeYpTgYFYS4eUo/RApxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgXFR9bqD2c0aRp7r9VKUzBl+Oi6Z80ZlYl6d
        9df51117hfas/DT/SOfiv1amDkbywnkTpFV9PILzhCb8b/sumBItsl5xrpf3qilO32/dOX4v
        irH36utZTJ9LTnoqlE7kOLFG4SZD5uSPvjtNZwY5KH+0V1mq/pk3WWxW/tPXvl98wi9KsxlJ
        z1ZiKc5INNRiLipOBADCEnJbkAIAAA==
X-CMS-MailID: 20171025113920epcas2p4fe42149385c058da3f1362fc3f362b17
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check 'GIT_MERGE_VERBOSITY' environment variable only once in
init_merge_options().
Consequential call of getenv() may return NULL pointer.
However the stored pointer to the obtained getenv() result may be invalidated
by some other getenv() call as getenv() is not thread-safe.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
Changes since the previous patch:
* no actions are taken between the merge_verbosity assignment and check.
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
