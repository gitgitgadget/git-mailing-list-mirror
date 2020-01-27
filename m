Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEB6C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 08:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642BD20702
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 08:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="STE2LwJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgA0Iw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:52:28 -0500
Received: from mail-am6eur05on2090.outbound.protection.outlook.com ([40.107.22.90]:19712
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgA0Iw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 03:52:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkLBwdgd3tcjrxGBUpyTkoMouNpzc0+HdhpnqVe2YMkg+l/bA1TLzkwIRGCqxnT2LXDXKHz+eDoCz8NeDI4Jtq2CTntPh9dayr17soutKFQEVxrC5/P4Rn7ZzB78lrn/2E3xNP5DesylkrTnGjm+daIgveKx22r7NU7poHO3elh+v/pqLYNSQD5pEUHtpSEOf9KSfjusguxPAEaqYhOT7MOANbz14syZRBveaBNCMwk6TRX63FKvHrslDndCiGucTRN4GNxzZFGnBPrDm9y6Fgadra9I3jACXYRIUZc8zGI7IgTyNu/L63pyaMwt8kL4wgoh+OOM6QM2OJsfHaJ7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBLROC1UYlmFmWk/Vxe3DnZCiLyzoHTu6Sd/Q1PIw+U=;
 b=mjl0bsTTt/ny/VJkoIw/I2DCKdzDQpkrouTPbCXHoG/hZ0H2NnKWvtxSlhG0+Xfd9gWzgfChCuFV1u/13/6VislofKSzWF2pNpAW0PFlDsIlpeghsqh0APqhXz3q9SZeHuJEIfR3QdRZ94xk0Tf5/nYW+8n84UfmXAgod3UhZNlm/QnDslTM65nM/9JtZ5lqelwTEOyDqQ73w1oIU4pqSR2Aq7F1MO+faNKspr1spc1+yO2Hrb1OZDzHd6RwYM2CB5ym0A++UciL2RaXEXnIcNRlcDVVXerQMh8KVrFJhFHeiNXZjjSEVhr/3HZvqmVj9TjDkJc0eGF7CUJP0znAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBLROC1UYlmFmWk/Vxe3DnZCiLyzoHTu6Sd/Q1PIw+U=;
 b=STE2LwJrc/1qyGDOqRP0MRCQsFNN1b2Mlz+b3qcbZ9a14oKiUSb/rCu+MhC4BVasrv7oBuK5f5Vjyd9R3+Nlsra1Vt8RQHPLlGUx0ggreIfJKlWSfSSnFPf2CfxLdLIUsZGys5hoUefWEFY/oM8ydiUkvQSimVexbwz/5hQxSeM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peter.kaestle@nokia.com; 
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com (20.178.20.93) by
 AM0PR07MB4564.eurprd07.prod.outlook.com (52.135.152.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Mon, 27 Jan 2020 08:52:24 +0000
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::68d2:a509:8a23:8d98]) by AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::68d2:a509:8a23:8d98%4]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 08:52:24 +0000
Subject: Re: [PATCH v2] Fix status of initialized but not cloned submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
 <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
 <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
 <9192695a-0b3f-d166-7efa-84f57e091c2c@nokia.com>
 <xmqqblqs3hbv.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <41a835a3-3809-eda8-fb3c-30fe9fac1a24@nokia.com>
Date:   Mon, 27 Jan 2020 09:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <xmqqblqs3hbv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR05CA0386.eurprd05.prod.outlook.com
 (2603:10a6:7:94::45) To AM0PR07MB6179.eurprd07.prod.outlook.com
 (2603:10a6:208:f8::29)
MIME-Version: 1.0
Received: from [10.151.80.182] (131.228.32.182) by HE1PR05CA0386.eurprd05.prod.outlook.com (2603:10a6:7:94::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 08:52:23 +0000
X-Originating-IP: [131.228.32.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c348823-f6ad-4d7f-0a04-08d7a3063a57
X-MS-TrafficTypeDiagnostic: AM0PR07MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR07MB4564A027966854E358E86576EE0B0@AM0PR07MB4564.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02951C14DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(16576012)(316002)(4326008)(81156014)(31686004)(5660300002)(81166006)(8936002)(8676002)(66574012)(2906002)(6916009)(36756003)(6486002)(478600001)(52116002)(86362001)(186003)(16526019)(2616005)(26005)(956004)(53546011)(31696002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB4564;H:AM0PR07MB6179.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6/YkScZ/F8igU7zPBknWmMRKYmKpvILlSq1HFYTPC2ouDSgSrQZVDl1eHkBq2Ubxuw2mNRn0ayW9vVAAf6Cp/xCpTX1kqxN6hqGvAfvm0IMOHwkDooALx9f9PdO1HtXcZ7srAdJigqGl5GNVwyW2x5Dafdwl5ih/9xyd0ikHWhxwC5GY+wfqVCwjDskcMwWl2YHLyl2KLrji/tPkFOEH2YEIsWk/fTDL0ayV9ORcjk3j1hhnEwsXE1Z48bnRdQInHNYvsBHNeGoDmrNJZ22eRF5jxWyUQV/IZ3d8DrtkcI1jn1UkjxitTdjExtOxHbnklpV2IYl3snuqG37R9gI0EjB1H0Oo0bFrd/K/CyjPXNGJxrb2b5PR7g2JjcxMJYjL/HqmM8PUMVqZzCnSgZjNMWOunTjzfOvVVCn2y701WROgiTMLNwcUgXxdE3UEIAg
X-MS-Exchange-AntiSpam-MessageData: m+7vBs6vG8RzhPCBP4SP/6gYjsWq6M1Q2tBesn9m7NQEV4OImZikOL6LeruxLo01TGDjRqHLYq1rVQ2VhF8eIzscW4yTZ+w5lpB6uzhra0OKNBYpPbxTfglM2Y3mAuUojIWVvCBXj3jq2Ln5mHwpqw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c348823-f6ad-4d7f-0a04-08d7a3063a57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 08:52:24.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8db2oNZ5T4UGOv6HQW0g5LXfGX3eczjWOAzwh1p5Fd2mtNkngxpkNvhk5S284el7k2qWdEVy5pQ1JUhYIOP2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4564
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 24.01.20 18:16, Junio C Hamano wrote:
> Peter Kästle <peter.kaestle@nokia.com> writes:

[...]

>> Is 3) even a possible use-case?
> 
> That would be somebody who is about to add a submodule to an
> existing project, right?  You have a top-level project, you need
> somebody else's project as its submodule or you need to use a
> library in your top-level project and you develop the library
> yourself, but want to keep that library part separate from its first
> user which is your top-level project.  So in the working tree of a
> top-level project you either "git init lib/" and start the submodule
> project right there, or "git clone $URL_of_upstream_of_lib lib/",
> and then plan to do "git submodule add lib", but haven't done so
> yet.  .gitmodules does not know about it, but the directory is
> already populated and is a valid repository.

You are right, this is a possible scenario for 3).  However the question 
about how the outer git repo should behave is still open to me.  I mean, 
the outer git repo should treat the inner one as standard file structure 
and not as a submodule until the user explicitly calls the "git 
submodule add" command.  And thus "git submodule status" should 
completely skip it.  Calling "git status" in the outer repo should list 
the inner one as "untracked" or?
At least this is, what I would expect.
So from my point of view the only test for 3) we could do is something 
like this:
mkdir innerfoo &&
(cd innerfoo &&
git init) &&
test_must_fail git submodule status | grep "innerfoo"


>> Besides that, I think testcases for man git-submodule's description of
>> status on merge conflicts are missing (...[prefix] U if the submodule
>> has merge conflicts).
> 
> Nice to know.  Thanks.

Maybe I'll have spare time next weekend to create some.  Not to promise 
anything, but sounds like fun.

-- 
best regards,
--peter;
