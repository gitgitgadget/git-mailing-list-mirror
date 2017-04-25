Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38879207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 04:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S973433AbdDYEvk (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:51:40 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35105 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972530AbdDYEvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:51:38 -0400
Received: by mail-io0-f194.google.com with SMTP id d203so52660681iof.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3O2GNdqUfieFdk01p8eWirVw+kKPIfi3YAEZGqFPHJs=;
        b=WJmegVKcEdoVZt1KcQQgxbG64AHxSEP7+NY9GLkMFNJWl3ScLpPDYEx41SvgAmdyes
         wJ8TQwz11XDZ66QVocSbOx5+X1Ej92xjTvV1nabDh9TRyXFAY1YHkPG7NzNtkbH0CPqy
         gQTOBqN93VqEbO2Lo7NuuoFEGdXZbg0uj1aD8s7MsqcakWhxG0hL+Ejsu35z9PYINi6M
         RlWASLQtf3n60mxVpXU+rY20NPJr78toNLBSDjhvGVwHzfAaD8s24bIkzIDrxV7sUDaO
         iH/zhTioptkppSoDzor7vpe6i8L1AwHN6jds8qxMBKdrYZATKJ5zj0MAGARibHQMA6Ct
         BSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3O2GNdqUfieFdk01p8eWirVw+kKPIfi3YAEZGqFPHJs=;
        b=qBq5075AdWIch6ows5mkzi/Of8q+FhezgZgkpkq++xmM3B7/sPT5rZKxsV1s8Pu6JT
         YaPe46GJT+qiJe2TCjw3cCNEWcnFzJzJ3cp9L2S4K9XNNsHog4LWrReO/T6WcoAqJBg0
         Z1hhSizwED18ovvL7v7NCAjbAkHDOnyVll7fsP92AYiHWtsYT/bdDvXYc75ZtLdDbDod
         jwGR2GJynnrKNeSUACLeLkS3+aZXWqJL2XPfkIy8pxq7DJvxTX/qiLMXlSlrO9RqpPoP
         xd1MAvgbDFljDnpNgMKccjtTb/Fvrug3+IKy+WuceIjIt5x2U/9uekivHbuLpigBLQKv
         wzJA==
X-Gm-Message-State: AN3rC/5XwomQ+cWu2BGxmt1OYapwzp4qr1BK/l7EBqfpfDsqMjW7j5C0
        PTx62zQ7c03Ydw==
X-Received: by 10.107.129.195 with SMTP id l64mr11238140ioi.194.1493095897976;
        Mon, 24 Apr 2017 21:51:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id z91sm986770ita.25.2017.04.24.21.51.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 21:51:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v3 2/5] archive-zip: use strbuf for ZIP directory
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
        <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
        <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
        <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
        <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
        <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
        <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
        <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
        <949f19e6-0414-9abc-9754-064d7e58c169@web.de>
Date:   Mon, 24 Apr 2017 21:51:36 -0700
In-Reply-To: <949f19e6-0414-9abc-9754-064d7e58c169@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 24 Apr 2017 19:30:49 +0200")
Message-ID: <xmqq37cxw0mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Keep the ZIP central director, which is written after all archive

Is this typoed "directorY"?  I know there was discussion on the
correct terminology I only skimmed and I am too lazy to go back
there to understand it to answer this question myself, so...

> -#define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)

This tells me that there is this thing called ZIP directory, so
probably my guess above is correct ;-)

