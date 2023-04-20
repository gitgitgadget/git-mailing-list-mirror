Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77044C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 22:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjDTWYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjDTWYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 18:24:16 -0400
X-Greylist: delayed 3634 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 15:24:14 PDT
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0066.outbound.protection.office365.us [23.103.208.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5AD2D42
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hii-tsd.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTIeF1SSTdZrl0i2+8ECnVsPFp+83qmx9UWYZhpI05s=;
 b=OOo7jDu8YKRoHpi8SPgqb4NbTpvZVSxMx62/fN11IoHNT45zdiuVbskJIKxnDthHmw4Zm0AkMlNjbgqOIvAo0+5kD9AWEbgHuqRGMCskDqoDeeMEDqAjZdglPiAJC6y2iC6pGxd2lo/H0jgxcflsBUIzQf6SdLzy+fiX1u9Rzlpl2eg4K4o92X4uQYLNEEANs8jgnxuRTKmOWaTXM9uJbelWTz4UhdMcxRdHyFBTALw8YKaN3kwpxUGAQPvR2KAXdSUtdzGUQhWRfTPl5W8laNpGrbSyeK1HItoauJ141W3calavq0uZ9h1HwdKBC/SYxuL76vUzCU1/HogyIcPzWg==
Received: from BN2P110CA0017.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:163::26)
 by PH1P110MB1249.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 20:51:30 +0000
Received: from BN3USG02FT011.eop-usg02.itar.protection.office365.us
 (2001:489a:2202:4::206) by BN2P110CA0017.office365.us (2001:489a:200:163::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 20:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.237.244.98)
 smtp.mailfrom=hii-tsd.com; dkim=pass (signature was verified)
 header.d=hii-tsd.com;dmarc=pass action=none header.from=hii-tsd.com;
Received-SPF: Pass (protection.outlook.com: domain of hii-tsd.com designates
 204.237.244.98 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.237.244.98; helo=agwtsdmbx01.hii-tsd.com; pr=C
Received: from agwtsdmbx01.hii-tsd.com (204.237.244.98) by
 BN3USG02FT011.mail.protection.office365.us (10.97.24.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Thu, 20 Apr 2023 20:51:28 +0000
Received: from agwtsdmbx01.HII-TSD.COM (10.254.42.148) by
 agwtsdmbx01.HII-TSD.COM (10.254.42.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 20 Apr 2023 20:51:27 +0000
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.177)
 by agwtsdmbx01.HII-TSD.COM (10.254.42.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 20 Apr 2023 20:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=VRj2fTstvwdJQB87ImN6up0KTpQbxIffYnOS48cro+usMlr/6xmj3CnzxF4Kv8Im0Io5KJ8ZSouLNvJ4uFZHNmPnk/Xei+DEDFlHkKAQGQ6hNuY+jLNRzWwfVagLMD1AXCKYDRSj0HTdcyb6as92k/NfQ3IYDoA0zouQSMZcxKYTArBLMcBW3jBCtFTWVNssxL/VAwDF51CXbZhgQT29pYNDnvgsTr4RWDbPw4x5TErbFRgem121zhNGM3riViRjl35tYWDfzVNXz3lQ7jqqvsSU11aT7UMzHEGGadzcPuMelPF1Lf9rSxJKTCFFRwGDWQZFno9Ng0+m8+eB9/IvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTIeF1SSTdZrl0i2+8ECnVsPFp+83qmx9UWYZhpI05s=;
 b=roLlTbD4OaZofOK1BTD/63ddK2qnQnXl52vlGyCZsgr9B+MQjr+z0kDkeoQTy2o7GZ7zi7sJmM9D0Pt6dXvaBehkYd8Sw8xvlIetRHVf2VYRw3Boppn2t6gblf4UStTo/yfKEIgc0jnSxotSjqhZdwuEZ9NrHVkhkK0palmrPV3mqYfwHsgtpSkBu7/Na5Kj/vd0ud8x60S0Q6ot3RcOe3utd/xi6ju1A4THk4fkVGXPrqlT84oup89qNvI8vooTvGFGVC5jU+yEGkX0KlP1kK2/wIo1rWqgNHmRr6kU6FRgGM1CvsbkYuXP8wX7KJa1AxGBTDc+ICJxmNdedwq3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hii-tsd.com; dmarc=pass action=none header.from=hii-tsd.com;
 dkim=pass header.d=hii-tsd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hii-tsd.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTIeF1SSTdZrl0i2+8ECnVsPFp+83qmx9UWYZhpI05s=;
 b=OOo7jDu8YKRoHpi8SPgqb4NbTpvZVSxMx62/fN11IoHNT45zdiuVbskJIKxnDthHmw4Zm0AkMlNjbgqOIvAo0+5kD9AWEbgHuqRGMCskDqoDeeMEDqAjZdglPiAJC6y2iC6pGxd2lo/H0jgxcflsBUIzQf6SdLzy+fiX1u9Rzlpl2eg4K4o92X4uQYLNEEANs8jgnxuRTKmOWaTXM9uJbelWTz4UhdMcxRdHyFBTALw8YKaN3kwpxUGAQPvR2KAXdSUtdzGUQhWRfTPl5W8laNpGrbSyeK1HItoauJ141W3calavq0uZ9h1HwdKBC/SYxuL76vUzCU1/HogyIcPzWg==
Received: from BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:181::20)
 by BN0P110MB1689.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.32; Thu, 20 Apr
 2023 20:51:25 +0000
Received: from BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2abb:51a8:c10d:4ac6]) by BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2abb:51a8:c10d:4ac6%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 20:51:24 +0000
From:   "Davidson, Ricky (HII-Mission Technologies)" 
        <Ricky.Davidson@hii-tsd.com>
To:     "gitster@pobox.com" <gitster@pobox.com>
CC:     "Davidson, Ricky (HII-Mission Technologies)" 
        <Ricky.Davidson@hii-tsd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] http: document sslcert and sslkey types and extend to
 proxy
Thread-Topic: [PATCH v2] http: document sslcert and sslkey types and extend to
 proxy
Thread-Index: AQHZc8XgA9+REzHd5E+c1Fg3FuDc2Q==
Date:   Thu, 20 Apr 2023 20:51:24 +0000
Message-ID: <BN0P110MB11787766D6BB6BF2022DB025DB639@BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hii-tsd.com;
x-ms-traffictypediagnostic: BN0P110MB1178:EE_|BN0P110MB1689:EE_|BN3USG02FT011:EE_|PH1P110MB1249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d697353-5591-4936-45c5-08db41e103ce
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m4iVKuLgiCnY//3/8Y52d4b54FXdxShjJgzWhvNK9PgD9gc1g8ykY3VI+AaXIqBSP41o5DZS/7QdDPjh8Z1aPuFEqIr0ADXFD3i5WXsO2LjoDjMScGYcxSHV/19vtG0Fi1l3i4sTbeqdCpy7Er9R5MW8U5CJL1Wrw9jyE9CnFv8UAN1+HXweBGxPjdR7Yd4ez9gbvfaq+2iFpynCd05rS3AXygGAeVOSzAIoe4sTEmCKVJbEWrjKUyvLPrRn1BhslT9TotlRW+hB8d6Kqp1GWJDlwtcSvBorAgOdfbIBbuaBDqNRxF6w6Wy72OVbfm2YLl65lziSHpI+XmgGEZlmdnvisIM38V/CNi3m3ljN1HLM6i+nBVVjHT0e4kNx6Ezg0SjbZKz+idbcUnak5d1/9oaCKX/ZRKUfO53oIMkN4RpgMOB0y/Lhj7LZjZxWa2LDu78LK8BBkjDazrzuQpHntQd9gvNtouzMB6d02hl1PFd4aQLDYoV/ubONRgFtWPpWX603DjEmKRozaTuaQhwUuSyJE/gH0llYJDD+d76m6YX0TkWNKs+JwmSmMDhpbniM79NytzvkjIQVcjo3AUeohkfCGvoQCRphi8XcJxvGDZDaKr+EUWgOzPOm7Ryn6grU
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(451199021)(52536014)(76116006)(5660300002)(66899021)(122000001)(7696005)(9686003)(55016003)(66446008)(33656002)(6916009)(4326008)(2906002)(8936002)(38070700005)(26005)(38100700002)(71200400001)(83380400001)(186003)(66946007)(64756008)(54906003)(498600001)(66556008)(6506007)(86362001)(66476007)(8676002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1689
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: BN3USG02FT011.eop-usg02.itar.protection.office365.us
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 59aa614d-e645-4eed-9449-08db41e1013c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIOcU0ZLBrW6meYO8hEhVBTokWSL2G0zxP4va5RPLgENS7J7ovoHUuv4YRtBEuZNfKOpXbMM8rRNJDqAFYk0GhXOA4LQITMQ5+2fc3AXmQJ6tPjWYjwgXfVcmMnLGvvapexG1idWbLYcIa+HKAaf7QLdFzah3B8djDFy/SAl1tkbqd8JnyQtxiSZ9qOxkW2KcAM2yNqPVw7bRTv3krfVcpeq1Gn8eCFdbTpo8VtyjnN24oPwbV9280ri/B6dQT+fHCVa081If2DjteD195oddUONttuVY6jMHMvOpVJ35MxQK8ePzF9c9uzw8HQco4HbIRqnnszvfvUuJLQ9fis3pLtaZ5HhPmFdxucptfbPT1Fwj/lBv8+aB4N88mfrff2Z9UmkiBvBN8y8y8hIUNZEj8UmH99rZiglBBWhCmYE2Ho83BOcH3g/0xuriDvb+yExIfpyczqo907B5tCJM6b92aYAhVa9kdSe4JBpRq+wgu0UdZPbCpYseQ2CJAReqNa3tSagF2F6aa0ggP4pw8jRHcsjfFeXP2cFstY2j2hkkF28437yA9rHVCWVS5dCFAJstwuhWiFeWDHmvhx3vU3vN2Qz8eJoXpbFMo9QDMXajhG6TcB3kTp/dieXJf8sAbrDWW5virRtWwn+Q6TTBOJ5yBio97IE34vOvWAArLeK7gLMfAaN8YqVB/H2P9ktKm7tAozXu/j8nHK6PsexGfvFYQ==
X-Forefront-Antispam-Report: CIP:204.237.244.98;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:agwtsdmbx01.hii-tsd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(451199021)(40470700004)(46966006)(36840700001)(66899021)(82310400005)(6506007)(26005)(9686003)(186003)(55016003)(8676002)(8936002)(86362001)(5660300002)(52536014)(40460700003)(498600001)(54906003)(70586007)(70206006)(47076005)(83380400001)(336012)(2906002)(33656002)(81166007)(4326008)(7696005)(36860700001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: hii-tsd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 20:51:28.8791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d697353-5591-4936-45c5-08db41e103ce
X-MS-Exchange-CrossTenant-Id: 0f5f8cb4-3b3e-42cb-bcb9-13b83b2f86e2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0f5f8cb4-3b3e-42cb-bcb9-13b83b2f86e2;Ip=[204.237.244.98];Helo=[agwtsdmbx01.hii-tsd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3USG02FT011.eop-usg02.itar.protection.office365.us
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1249
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think it is the first time we see your patches around here.=0A=
> Welcome to Git developer community.=0A=
=0A=
First time, yes thank you. I'm also not able to use a client that =0A=
normally allows setting headers like in-reply-to (I am hoping mailto: =0A=
works here), so I am hoping this works, and I will take any advice on =0A=
that situation if possible.=0A=
=0A=
> I wonder if we can add some tests for the feature, though.=0A=
=0A=
I would love if there was a way to test it. But my historical =0A=
understanding of this issue is that it has been repeatedly not merged =0A=
in due to lack of anyone knowing how to test it, given the nature of =0A=
a hardware token (what this is especially focused at explicitly =0A=
enabling) generally being hardware. Technically, I am sure pkcs11 can =0A=
apply to software tokens, but I have never ventured the topic. I'm =0A=
also aware KVM+Qemu+Libvirt allows creating virtual smart cards, but =0A=
I also have not ventured that topic. I have been following this issue =0A=
since May of last year in private support tickets, and I do not feel =0A=
I am able to contribute anything that has not already been pondered =0A=
over this issue. I strongly welcome ideas, though.=0A=
=0A=
0a01d41e (http: add support for different sslcert and sslkey types., =0A=
2023-03-20) does solve our main issues (which is absolutely =0A=
wonderful), and this is only to finish it up with documentation, and =0A=
proxySSLCertType does not personally affect me, so I am not bothered =0A=
with the wait associated first consulting on proper testing. =0A=
Although, it would be a shame to see this fail to get pushed in again.=0A=
=0A=
Thanks,=0A=
Ricky Davidson=0A=
