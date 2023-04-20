Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FECC7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 21:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjDTVOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTVOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 17:14:12 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 14:14:10 PDT
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0070.outbound.protection.office365.us [23.103.209.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93915469A
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hii-tsd.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be+FyTuq9trQYdTrLo+aH+vnbxBr+LVrN6Kr9XEud2Q=;
 b=mSZwIHsEWTa4abgoaOf5FTrJOBTHK3FE1pfAEJijHmv3fUoKD6bDU+PW8ubMtP7TxnXcvGVs6jqiAahOE/W3rqq+HtMXX95MqcIPGC2SceymUGTA4N29tC27cPTgM7gexuBmjGP3JRPPT+wHLQkYxgds5CeenimJ0QJvfCUlnxdIdkhcv1xLkvOzWCuJzNPqu+UP2ks6TNi7QHfsjahh9PnkNDqs9FvV7MPdYsJvlWza0x0wAFoJW+2mcHHeoei6lE1taOyLUhx5g/7UpDhyOJMrNCZMsjwrDOqLeA+g+pG+KRxc/NxxUMMc2SMsw8cwr2nrUe6vvs8Vk+a5z/e7XQ==
Received: from BN3P110CA0035.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:408::33)
 by PH1P110MB1187.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 21:14:08 +0000
Received: from CY1USG02FT008.eop-usg02.itar.protection.office365.us
 (2001:489a:2202:5::205) by BN3P110CA0035.office365.us (2001:489a:200:408::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Thu, 20 Apr 2023 21:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.237.244.98)
 smtp.mailfrom=hii-tsd.com; dkim=pass (signature was verified)
 header.d=hii-tsd.com;dmarc=pass action=none header.from=hii-tsd.com;
Received-SPF: Pass (protection.outlook.com: domain of hii-tsd.com designates
 204.237.244.98 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.237.244.98; helo=agwtsdmbx01.hii-tsd.com; pr=C
Received: from agwtsdmbx01.hii-tsd.com (204.237.244.98) by
 CY1USG02FT008.mail.protection.office365.us (10.97.26.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Thu, 20 Apr 2023 21:14:07 +0000
Received: from agwtsdmbx01.HII-TSD.COM (10.254.42.148) by
 agwtsdmbx01.HII-TSD.COM (10.254.42.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 20 Apr 2023 21:14:06 +0000
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.177)
 by agwtsdmbx01.HII-TSD.COM (10.254.42.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 20 Apr 2023 21:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=LXAa+8ftquJPv59VZ8ng6EprwMH02lMgMCR9fIze//RDP6JlThdco/aZEbryD93CEkT5/IlXMrubuXORLcKHHfZIPsbFS4deqUYTgvkDIq/58ORGUEgLJWz/46Xfxr85t49a5Lk99JsT8+bpvDdXJ6l3m6Tl1CGLvOPzH+TUmtFyV2vjJMo8nLIbBAwXiPnM0RmELhynIQLL7q9MF0/tG7FyX7EB6wNerw6Oz7XGFG4eM1Xqwlm+jR/4OGh/oMG6Nm8J/eoMbrN4EzyhWHQvSukZNRlti3B7AR2BKuKbvPwiZLQCgd5BIyBbBbs3vzNpxuKul0djr31jV/QmFgA7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be+FyTuq9trQYdTrLo+aH+vnbxBr+LVrN6Kr9XEud2Q=;
 b=DOKsll9AtHOitOvz7V236ZUYZ6vUuDAk5ZXneEuOpB9N7QDTB/qyS7uuQLnhoplJujdyRcTOYJsurTO0ap6F85N7OXc48ASCeUblOuKByYORuzCs3xX6mBHdS4vFu9Cl5POuQm4lWowmJGmtbexuYaMg0Z4M5D/lJICg+O/o+fiDLT4VK7Gg3Iqo7NiSgWqwEPkILb2CE/iRKUV/EymDCL49ufQCCJqkd6QpUc6yinS+NJ9LRd6D396CKA9EIclPg78FuDnKX1ay5syT9V2fHXeT8bE+648tUQbrABw3+c4YQOcNzBEDYte+uwEgpZGhWj9vv0H7n9Y3LTPeYZxCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hii-tsd.com; dmarc=pass action=none header.from=hii-tsd.com;
 dkim=pass header.d=hii-tsd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hii-tsd.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be+FyTuq9trQYdTrLo+aH+vnbxBr+LVrN6Kr9XEud2Q=;
 b=mSZwIHsEWTa4abgoaOf5FTrJOBTHK3FE1pfAEJijHmv3fUoKD6bDU+PW8ubMtP7TxnXcvGVs6jqiAahOE/W3rqq+HtMXX95MqcIPGC2SceymUGTA4N29tC27cPTgM7gexuBmjGP3JRPPT+wHLQkYxgds5CeenimJ0QJvfCUlnxdIdkhcv1xLkvOzWCuJzNPqu+UP2ks6TNi7QHfsjahh9PnkNDqs9FvV7MPdYsJvlWza0x0wAFoJW+2mcHHeoei6lE1taOyLUhx5g/7UpDhyOJMrNCZMsjwrDOqLeA+g+pG+KRxc/NxxUMMc2SMsw8cwr2nrUe6vvs8Vk+a5z/e7XQ==
Received: from BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:181::20)
 by BN0P110MB1161.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 21:14:02 +0000
Received: from BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2abb:51a8:c10d:4ac6]) by BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2abb:51a8:c10d:4ac6%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 21:14:02 +0000
From:   "Davidson, Ricky (HII-Mission Technologies)" 
        <Ricky.Davidson@hii-tsd.com>
To:     Ricky Davidson via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Junio C Hamano [ ]" <gitster@pobox.com>,
        "Davidson, Ricky (HII-Mission Technologies)" 
        <Ricky.Davidson@hii-tsd.com>
Subject: Re: EXT :[PATCH v3] http: document sslcert and sslkey types and
 extend to proxy
Thread-Topic: EXT :[PATCH v3] http: document sslcert and sslkey types and
 extend to proxy
Thread-Index: AQHZc8RagrJyRtWDEEC6XkWHFehc4K80sd5C
Date:   Thu, 20 Apr 2023 21:14:02 +0000
Message-ID: <BN0P110MB1178028CE56A467917E58634DB639@BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM>
References: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
 <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
In-Reply-To: <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hii-tsd.com;
x-ms-traffictypediagnostic: BN0P110MB1178:EE_|BN0P110MB1161:EE_|CY1USG02FT008:EE_|PH1P110MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b88524-9e42-4efc-5836-08db41e42dc8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3VcV3ymTKCDPOTZC6vgCnktypYPtHK5G13pf246T4g8ZzfS0mGuXSn50ug7lqA9XXnuZZWDC/ZFbo7Ep9RzE7shC7oHgE2HAUXqB9gFmMKAU10Xjl5N/d4ugfi0w9z5eHeYO3B3wWSX7xc/8twkMNBjqFjiD+084PhfqE5OKFiohwa0RFAMd/L/LL0SltI7vbollfE7MeMIEswhH9gvbxxtBrQyrk7+9JwT2eJ5dLrvZe7u+D03KEqcYivjz1EJFkGijYbn1oSMLHE+5SRQcpX23IDh9jsT2D3y1rdEyzmbo4JUc//7TwekiBc4EgYvmgtmejh2hJKr3wu1gro85IeA+SGxn+HPr2WGlF+zVliOzEXhAUG8GijFIOoS00JdS6XVrvGIUdp/4pbdbU3AsjeXMT1hZxPErbV05tDSNX4cIKGwI1b5LMZevSlcHFcAVu/Nu/SEyRNcVJ+97YUa6UUlkjCzmTQg7suhPsteoEW08U71hTdtwb1O162Qsyqw2B40drc+caRavxqbcNRW7d/RD/tsa+OeKnfdw5dUDH3B2NiAVfRAGzPE3PnXFJUfwebDvXihtm1UYtGWGEICmw5qeq287uZ+vuDWKphTy8JwXXHJufemN7Pems9wpZYcG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(451199021)(33656002)(66899021)(86362001)(55016003)(498600001)(110136005)(54906003)(7696005)(71200400001)(122000001)(8936002)(8676002)(38100700002)(66946007)(64756008)(66446008)(66476007)(66556008)(4326008)(76116006)(83380400001)(6506007)(26005)(9686003)(107886003)(186003)(5660300002)(52536014)(2906002)(38070700005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1161
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CY1USG02FT008.eop-usg02.itar.protection.office365.us
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e707630c-a4ad-4eb3-62f3-08db41e42a83
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJ3SZIpO+pAgCGcNcHxQA2iqCMwFMKhgUxPPNojOjDulc2IzdVVKnTvVArlaXE+/2g86+WqnbAgE5IUVHTUFIF9Z0VfQGXxGcnGU+JUfg/OItJM0lvdR9ThWu0wUNf+ssFd3qKendkmwt9NVCqc50F0PDaQ94A+fHZgxLbrO+b2BWTe87zODnuhGoPDnpivd2gN9bgd4E5i5fzrIKTtxcOFyPGPIxq4XKovxZ08GHANEhKpLfA6JtADUqdN/NyIvHiX2dEr6k+viEXEQAtrkKrVRPiS1Zst0iKyEDfX0vFzG32E+pC4FIH7tD3mC7AB2Q62STTmgQMG2q8/mh1yOcjBsvwLtc/0h78j/nJgdEqcOcjIa9X7FjeyO+tCw8dM/UgZ2droxkiAxKROIg0xdDMceERHNOGpo4zbG2k9ILgNiyQh23pY44o27+ZYnw9UNA4m2ybVF2YUNYP0k2dVjkUBLfLxwuET6cDvpKahT4ny7GDU4j2GX03ypDz4H1ByCG+6IF79O/AI8Z2ScVjpunVUU65JBQDYrwaIMPKuJQ6EGFVcop+x4dYAvyFS3T7VFzqAuCSlu6h1UUpvTA12twzPOFhFrJcTBRB7jCLuhfM7c9Es70bx3S6HtHosnCRhP/9XnBCzoaIc1YPQIYbfrH5HUz/1CvJoEs+k++I+oBUzAIFOsTUJcMDkrWrqjIQfXipqiI2ExHXarsMPCGCouqw==
X-Forefront-Antispam-Report: CIP:204.237.244.98;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:agwtsdmbx01.hii-tsd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(451199021)(46966006)(36840700001)(40470700004)(55016003)(82310400005)(26005)(6506007)(186003)(9686003)(40460700003)(47076005)(336012)(83380400001)(54906003)(110136005)(498600001)(70206006)(70586007)(107886003)(4326008)(7696005)(2906002)(36860700001)(81166007)(33656002)(86362001)(8676002)(8936002)(5660300002)(52536014)(66899021)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: hii-tsd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 21:14:07.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b88524-9e42-4efc-5836-08db41e42dc8
X-MS-Exchange-CrossTenant-Id: 0f5f8cb4-3b3e-42cb-bcb9-13b83b2f86e2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0f5f8cb4-3b3e-42cb-bcb9-13b83b2f86e2;Ip=[204.237.244.98];Helo=[agwtsdmbx01.hii-tsd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1USG02FT008.eop-usg02.itar.protection.office365.us
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1187
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think it is the first time we see your patches around here.=0A=
> Welcome to Git developer community.=0A=
=0A=
First time, yes thank you. I am sorry about late replies: I have struggled=
=0A=
with all listed methods of replying not working.=0A=
=0A=
> I wonder if we can add some tests for the feature, though.=0A=
=0A=
I would love if there was a way to test it. But my historical=0A=
understanding of this issue is that it has been repeatedly not merged=0A=
in due to lack of anyone knowing how to test it, given the nature of=0A=
a hardware token (what this is especially focused at explicitly=0A=
enabling) generally being hardware. Technically, I am sure pkcs11 can=0A=
apply to software tokens, but I have never ventured the topic. I'm=0A=
also aware KVM+Qemu+Libvirt allows creating virtual smart cards, but=0A=
I also have not ventured that topic. I have been following this issue=0A=
since May of last year in private support tickets, and I do not feel=0A=
I am able to contribute anything that has not already been pondered=0A=
over this issue. I strongly welcome ideas, though.=0A=
=0A=
0a01d41e (http: add support for different sslcert and sslkey types.,=0A=
2023-03-20) does solve our main issues (which is absolutely=0A=
wonderful), and this is only to finish it up with documentation, and=0A=
proxySSLCertType does not personally affect me, so I am not bothered=0A=
with the wait associated with consulting on proper testing.=0A=
Although, it would be a shame to see this fail to get pushed in again.=0A=
=0A=
Thanks,=0A=
Ricky Davidson=
