Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C128C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 03:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjDUDS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUDS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 23:18:56 -0400
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0078.outbound.protection.office365.us [23.103.209.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33FBE53
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hii-tsd.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm16CHrDGYw2hoicoXeZz5mIY7bMEDplVG/4GipZR9g=;
 b=kX3sZIWATFTqan6yzRQp2c604Qu2Jwut7IRdvU+/RDRnq88rs1xEgk1rPboe1ehNs0m20qJT7J/XKF+aqxWJnO8u/++t62w9Y+LDe1p7xT1ry0LEbCqm+1arV+LlQlaJ8RTL46EG8lCWYKPYdnW9SijYPKQ8It16z3IsIFXEreXfqVZwPruhwu0rr2EJPhoDIEdB6wpTIf9NxZwxfpOSnskaKciu5XRLlO3dWmnTxK7pfbvfKXaxFWuoLbgV68i1c6peJ2RmYR0ZNmkwcG/Grh+WOo/5mrz/aiBL//f4fDC9C4W0rlot0mvJVRh5PhTFeMoAH2FmRbEBBmKfBdkRQg==
Received: from PH2P110CA0024.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:127::37)
 by PH1P110MB1145.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 03:18:50 +0000
Received: from CY1USG02FT006.eop-usg02.itar.protection.office365.us
 (2001:489a:2202:5::203) by PH2P110CA0024.office365.us (2001:489a:200:127::37)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Fri, 21 Apr 2023 03:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.237.244.98)
 smtp.mailfrom=hii-tsd.com; dkim=pass (signature was verified)
 header.d=hii-tsd.com;dmarc=pass action=none header.from=hii-tsd.com;
Received-SPF: Pass (protection.outlook.com: domain of hii-tsd.com designates
 204.237.244.98 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.237.244.98; helo=agwtsdmbx01.hii-tsd.com; pr=C
Received: from agwtsdmbx01.hii-tsd.com (204.237.244.98) by
 CY1USG02FT006.mail.protection.office365.us (10.97.26.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Fri, 21 Apr 2023 03:18:49 +0000
Received: from agwtsdmbx01.HII-TSD.COM (10.254.42.148) by
 agwtsdmbx01.HII-TSD.COM (10.254.42.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Apr 2023 03:18:47 +0000
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.178)
 by agwtsdmbx01.HII-TSD.COM (10.254.42.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 21 Apr 2023 03:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=n7iksJ7uKpLq/41pCjtCc55qnwyQXOLhxxiRU61WDnwSYtmQQi6DiX71lkgGphu2IrvIzlxvzguSL4XCiszjRj4+bIyQ6EG102WZ0Z28XEAVhYq8byq/hpKUWIgblUSurIvFJMzj45FOzVprODdZ0KghUp50g91NiqVBFRY0DWH6mhsvljjI3jujo4mZnu5Awn4Wz4IFmgdGrBDqvK5wc+18dmqpquJvdXuya3r8HobMk9MPFvQ2pkARWV4qF2lJs1a40WFuL4OTu1HI8WRkq0RLIPBpmPyxZTDOR5aLf7fWh4pN5uCJATHIAFlzavL8J/JnFgTXmRV0rlFd5ywYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm16CHrDGYw2hoicoXeZz5mIY7bMEDplVG/4GipZR9g=;
 b=A7z+x8NgJYuP54LclSXU6YBrKZ649uVPS3K6xBtI2p2dXkK5CjZRSYfOip+zkOcb7qk141hQQSsCmRHN1M6SEkYgxluveBzlj0QBz20jJVvqiQW7qNotse2LR+f0DRML1sZxEPNLPiKFEcWEfLwIoHE8Zva5ZMJ2Bo92z+FYcvgeYvjZrlr18qWA242c3lY8Z/SSioeUlvz7vT3rJ3TGQx4mM+R/nEfq3b1b5LdHEogcS4lgWmv9GNailWvBXghnEwz3UETszVfZ5hG4R2QvY1g2r6/dEZIaIk0DDTgiWm/AYfCgZ5k87aZJEyWPcVSDWppSBNxu6AhioxWbBd2Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hii-tsd.com; dmarc=pass action=none header.from=hii-tsd.com;
 dkim=pass header.d=hii-tsd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hii-tsd.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm16CHrDGYw2hoicoXeZz5mIY7bMEDplVG/4GipZR9g=;
 b=kX3sZIWATFTqan6yzRQp2c604Qu2Jwut7IRdvU+/RDRnq88rs1xEgk1rPboe1ehNs0m20qJT7J/XKF+aqxWJnO8u/++t62w9Y+LDe1p7xT1ry0LEbCqm+1arV+LlQlaJ8RTL46EG8lCWYKPYdnW9SijYPKQ8It16z3IsIFXEreXfqVZwPruhwu0rr2EJPhoDIEdB6wpTIf9NxZwxfpOSnskaKciu5XRLlO3dWmnTxK7pfbvfKXaxFWuoLbgV68i1c6peJ2RmYR0ZNmkwcG/Grh+WOo/5mrz/aiBL//f4fDC9C4W0rlot0mvJVRh5PhTFeMoAH2FmRbEBBmKfBdkRQg==
Received: from BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:181::20)
 by BN0P110MB1545.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:184::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 03:18:43 +0000
Received: from BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2abb:51a8:c10d:4ac6]) by BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2abb:51a8:c10d:4ac6%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 03:18:43 +0000
From:   "Davidson, Ricky (HII-Mission Technologies)" 
        <Ricky.Davidson@hii-tsd.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Junio C Hamano [ ]" <gitster@pobox.com>,
        "Davidson, Ricky CTR" <Ricky.Davidson.ctr@ncte.hpc.mil>
Subject: Re: EXT :Re: [PATCH v3] http: document sslcert and sslkey types and
 extend to proxy
Thread-Topic: EXT :Re: [PATCH v3] http: document sslcert and sslkey types and
 extend to proxy
Thread-Index: AQHZc+rTuPQNUg6g6kqxkwd8ND8axa81FkZa
Date:   Fri, 21 Apr 2023 03:18:43 +0000
Message-ID: <BN0P110MB117884C8D51DD55E4B445ADCDB609@BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM>
References: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
 <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
 <1c365381-4858-1534-18ba-aa6f5c5056c2@ramsayjones.plus.com>
In-Reply-To: <1c365381-4858-1534-18ba-aa6f5c5056c2@ramsayjones.plus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hii-tsd.com;
x-ms-traffictypediagnostic: BN0P110MB1178:EE_|BN0P110MB1545:EE_|CY1USG02FT006:EE_|PH1P110MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 280c69ef-5d28-466f-b457-08db4217202a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: F0lv7AbUjMKwL4ikLjUsYXrlva7c43OUmJrp6ulZJ7eluhIbvtomyqtXzOSN3V3LhoNm7CSP9F7vs2BMh5XehP7kSdoiJb2Sv8u7dO6Hp6iOOJBRswgV7Mw7gflQRET0cGsbbshncqIgIyk9Z1MoIAvwEya1TauStug/+gMDRQtkUR6BWx9rEbluNJ/GspubvFHqrW7Vpw7jpx/Pq5VbHyq3coBz7y9EPdgkHZ4UXGmcpbzNw7+WFCQbT8SIJ32skwusNGucaJpXDM6PzaE+nZn5+MROwxpPk8e6TedrXRukyhI+2Pvc/SX5jQLux1X6qw0W7Xlvi7eBUlXXHwEpO0PQLw0n+octGnxKLqt/z5zF9NFpK23tz47j+W2XV9uNjkd0W4lrFuDoQKE+7J0ptCEjSXYfyEBfhrPOPeDhj3SPomL+irNSTFcJGOEbWXcgkM3ERjDeseuARXbZyg6xv8lsRjBjXVJfQcDLs10Ig0LNX/AdcueeGpN5lVlXb+lnPgQUYVJ92zfN/lt1kkqXJH8L3GwG6RZLpDMON0dCGRH2kQWyRqYkFrdmDnKuAzkfL/N6m95ujqKQwijXa/dxUW/DBPefYejnHWzddlx4GlS0FDkgkHMfkA+32XgzIKm3
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB1178.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(451199021)(66946007)(76116006)(64756008)(66556008)(66476007)(66446008)(558084003)(4326008)(33656002)(38070700005)(38100700002)(5660300002)(8676002)(8936002)(110136005)(122000001)(52536014)(86362001)(54906003)(498600001)(2906002)(71200400001)(7696005)(186003)(26005)(9686003)(6506007)(55016003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1545
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CY1USG02FT006.eop-usg02.itar.protection.office365.us
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34dc0603-6096-43b0-d64e-08db42171c6d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjmQfjyfKbztdmx2gMCdCL6DeGa8BYpXpaHCJrcmwP6t9sMqc2VpTRQtjK39Ix3kQ5g/eQgDOhaGQMAgGdRCfCFRaW7VmsoJiO5DzrRFsZZrJWIW8QZrd+7RkTURyOfbXb0BOWJ+0KDR1Kp9JfBsL7JrLzXJaFkuUfEbTC7v4c4gYTXzI4ZLROmmfFryqZ2YB/FOHz8Rw1njWgovDUMEP0hiczwjO/6Hqi4Xg/CjnT0pS7qWgQGfU8v9YZ/PW2vbFKhBoXOtjueLIzBKapBIjIHNZvYhzDOVFJoDWjr4wesjppD7HT/n+3gTnoMfYdnJlXYW7yhs4Gr0YQ3Iz1bUsS6Azi9r67YliWA6JGXdqrud6XZk/DP9UHVU/q7Pqjk4zjCO8UOHqghvOC0sEyNFflebI362A2uKgRD8aSgSc7gSNX/IIEd5XJxVtSVYkOF1sVzxRNSA/gvhpVosKATD0h5aTi2JuPYoA5r8U9mRegBkFgOdvHS1ZH9H4WeRAygx+0rQodmf9+l2/pF0CdQJoCHorh54tROPuvveXXy3IbgNrApHDZvP4qHn6Is7+7PvADjZVP2omnBu5OCxFZIoX7/iUPo0qLA5eggfRJNpahD856Xsdpzhh63wNo0y3PNclJr85y1TugBuizcpugxlEb1zRXZ9KuLW5ZLNsIrfbhEyfASguOdSHk73ZbMOg+n8jxJZ2wbp3qLhc3w0kYj5Rg==
X-Forefront-Antispam-Report: CIP:204.237.244.98;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:agwtsdmbx01.hii-tsd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(451199021)(36840700001)(40470700004)(46966006)(498600001)(110136005)(8676002)(54906003)(47076005)(5660300002)(52536014)(70206006)(70586007)(336012)(55016003)(81166007)(4326008)(8936002)(40460700003)(6506007)(26005)(82310400005)(9686003)(33656002)(186003)(558084003)(86362001)(36860700001)(2906002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: hii-tsd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 03:18:49.2220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280c69ef-5d28-466f-b457-08db4217202a
X-MS-Exchange-CrossTenant-Id: 0f5f8cb4-3b3e-42cb-bcb9-13b83b2f86e2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0f5f8cb4-3b3e-42cb-bcb9-13b83b2f86e2;Ip=[204.237.244.98];Helo=[agwtsdmbx01.hii-tsd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1USG02FT006.eop-usg02.itar.protection.office365.us
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1145
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
> s/GIT_SSL_CERT_TYPE/GIT_SSL_KEY_TYPE/ ?=0A=
=0A=
Ah, yes, thank you. Another patch will be inbound. Also, I am a little conc=
erned about the language in "Supported formats are `PEM` and `ENG`.", so I =
will change that too.=0A=
