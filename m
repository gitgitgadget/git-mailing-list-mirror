Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0BEC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ADA2076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 13:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgJ3N6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 09:58:18 -0400
Received: from mail-eopbgr670102.outbound.protection.outlook.com ([40.107.67.102]:45912
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbgJ3N6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 09:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6wThjl0/yORcTq1CgwYOZgotDoK5UsZWfA444iBNsm+tenliv4TWvfA3dzrnFa2HT28XbsLCIBT9QXD/0mWX9P1zYRWe0yBkfzPyLdKFoFaz8Vrzdh+hxZuQfYLNKKmF3J4jO/bdf9Uf1scxDEqMNsQBEoZKWMdxV9kePKlUMBdcSWnGlMexpGTsr33/jgUYxWs91JyZ9y7DU2XVW11QkNQ/nxrXxdx6OYpJ57D3fiwaRBX9OxYBxfv9kf6NDW0Rt6VAK+96YTrj3GnQiSermWZnOLl99QqcQCx6ERKs8wsD3tJ46D5eIIXHs9OFx8GDUb8sfRpBRidzjNcijH4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PL3l+M1Id064HD223aTkKpbKO90yfPK8yXZnBeES44=;
 b=hwJzDQ/tz7uUcO4rzWZ4LCnHhCq4aiEU0Vdgdypcd6a0oE9MpjQdcLm0ld0+DWX2d7Gcch99MaxpxhI7PKGaO9XSP64updgjGkdsiIrnNbIL4ttP70FPT7rdiS0S6HVkr7lqCr3ZdhaBsuL+18suh5vOQw6oM//U/9eTA+FYyhzGOzD7GoK6/dJ6GtHcZkM3QW4eJue9SudFrbX7AJcw5dIvlp/26OePmuVu8uSvzDkvFVdq/WxCwgsQXdRIcRuNV3wKCQy4CX/dnufn6GByvMmdMxkn/6CUeY63r08t4NDN+Vs95LxuKC9wI3Al4thCqM24T2m3f+nYC693DleXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PL3l+M1Id064HD223aTkKpbKO90yfPK8yXZnBeES44=;
 b=Kd7Y9S+liv1I8QP7/JE5WQXqX9l/7nPxYXhrfnowhFE9hd1VRR+LH11jd2yU3gX1SyW4zIZxUsu+kSD0ahroUVREpqamteP48KAdJY8yPvaLpoKi0eDS7opwi0ng5qaAikj2uUuxYgR2O7mOE7URMajOaJ5pFUWf+3Fya0hi1gxQF9IRQZ+Cbc+AHwV0ceRjWcaEB9WNhQyK6TsFX8mmtPICArrgV7VjHqdKxjSD4sUaLIS6jOgrKxTnZB7lxTKCjsVnW+j+M2olbKz6CdsBKGV9UllOlJNOzh2W09fccAF8GYlb2ll7QpztVpeeoK8zbffmjuh3TJa7Jj2ZoWGv7g==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB3432.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 30 Oct
 2020 13:58:15 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf%7]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 13:58:15 +0000
Subject: Re: git-gui: Why are the main panels no longer white?
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
References: <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
 <20201029232816.68285-1-serg.partizan@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <95c91585-5249-b0cd-bd06-a014e8770d37@xiplink.com>
Date:   Fri, 30 Oct 2020 09:58:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201029232816.68285-1-serg.partizan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::18) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 13:58:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 226b703c-54da-4447-9c6d-08d87cdbd8d1
X-MS-TrafficTypeDiagnostic: YQXPR01MB3432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR01MB3432856AFABA4951A9D53109D7150@YQXPR01MB3432.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLWbfV+oEhV/IdqjNqWEg084dI0o+hOyU5eHOtch1kSsFVe2FSx81Ew1iGqEQxt2fA0HYaGpNEqVkMqtPG7teY73rws6btIMqk8yWVaXy3d12Y+P505MSUVexirbzlRScDkphRED1vLGzCZ5rYIzxUhddENxFlQEjhK+6rFZXHG4SxwUwKVPkc9wPB99mhujnAnz9qlE1l8wFQ487g9knQEfJkJjoi5KWmnDwIbHtE12+UHyJ2eveXPfF5p1l867/sEC9SkKI3BH+lglnp0gE6zRr8jOTikVgNPiRuwM5SrxQ0BKgaUyOGOlsa3FpE2mFopwPs0rfJ+nZ7qwWChHixHt1hI7wjRHFDgzKonlQzJGhTxIvlDI4VM18Yw7VhTR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(136003)(39840400004)(8676002)(16576012)(956004)(31696002)(2616005)(8936002)(66946007)(186003)(4001150100001)(316002)(53546011)(4744005)(2906002)(66556008)(478600001)(16526019)(66476007)(36756003)(36916002)(31686004)(6486002)(86362001)(6916009)(4326008)(26005)(52116002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aDSKV3q8S0n1op9EDMidCtU+AsEBucMMHKHDtC4qrpCX/8E+xsNef+g218BGn9SbI8wMWZgxV9TDVzNFk6QpC1gXkxlk6UvtGSJ99ujiVH+8fi9kI+SN/Pi1ZJZwh2Ma7thvvbmJq3UsdzkY5gFhcjjmW7JvvtwRes1Q3cWQN+HUkRgv9C2qso6mXWXTu2hMoNdeI5JVTauk3X8KBdEh/2c3E5qMSkvjHKkVAiK4MCgTgSRpMfZhtOqTma4egxMraXevVt1Ma//iU/rwFFidyvPXaCsJUCz9/QIgT7qy/QmXv/O7eu5Z8qDzy7RcqPWpjPehvpfTVZvv/+zIcE2Yx50wSb+33TqJAj7sqBxAZPD2yVJ2QOc8eVFoOP2bGQH+RxM8pbI2sMAgg4h7eAAD57VXrdqJZQ0ZIDzFwZfzg296PuY3prjnnHMUDtdQPqQY4+A9pJMxQ3i+eqOp5tOFk2fz9QhUJEl1tOZ/XOjkOQDLPNJ4fvlvj/cavWj3CEQptZwL7DGDhknVURxZ3P9AJA5whSyyrljybUy8sncJHYL+Y2t0skJ/LfpjgtBIMVT8Z7CNnuacuKXk1LIPf6D23DKrNiQhSkGlGU/RnyAqcTuWrLkf4dKinYIhpVvZnWEtkSrNdK0cIfD0u859m/+l6g==
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226b703c-54da-4447-9c6d-08d87cdbd8d1
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 13:58:15.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eQE+4GcTooIeecuw/FoGSAfdcHTQSCZQ4I46VEIrab6pNgBMAt/eR7Exq1Ip+w1zXVBrVWN0xx8SxborTyoMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3432
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-29 7:28 p.m., Serg Tereshchenko wrote:
> 
> I traced source of the problem:
> 
>> *background:    #d6d2d0
> 
> But if you change this, many backgrounds change color.
> 
> Now we need to find right *something*background to set that panel
> colors. I'll continue search tomorrow.

I think our emails crossed in the night somewhere...

I've found that
	git-gui*Text.Background
in ~/.Xresources does the right thing.

		M.

