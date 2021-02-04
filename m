Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5714EC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1883364F38
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbhBDTRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:17:54 -0500
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:28512
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239201AbhBDTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:17:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De7/3L8BV2tebq/HU10rH0ogo2eQnmnmxxNSMSPnVUU5ULVnr48CaE2+U1he0jXAVVVxazCFmKVyitN6Ceh4wKpZSuaVCBpqVb6G8GeoeLieqMWm3YA2WT+4ULr8sNTw0VirycyiZVZpFUw/atxR+15fNhxmeoAYJfUkTv9JQvDvy16YhenX84Uga9NIUnMVnwifVj/Xp6kGH6GfaMrofyhsQJ1cojieBBQm9Jbykobdy0gF6s8r0gsun0Ohd/CcighgNjLFT+a4xIez5eXmDgrOAp3r1I5XHmMtknuFTmnAY0FrGbcyCgBMvp4KRJquWhCLzveWAR8ttnbK8ZwlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tErAkPe9yCJt4LYcIdnB2PrjpYxw7nNczOMDFtJyJ88=;
 b=Kz9zK6SYmf8KlpdRzjiV0DzcpCSBqAcHk1E6Wuz/kJWAboQMcR8unV1E30ALRmQX2LWooy8gFn5tsjUE8ic0DfhHZoa/ehBHwjn4kybGRXLWq4zqmzSWH8N+GwpsH1T8e0I8tLIm/3h/C5E+Eany9sH9dbsi0sykq/qrqlY28qoAL280taYlJznDfB4bGquXv2U9Sqw64GJi9u0GHPedBUBQwEWvioQV9q62n1S8TNLfRxACAnA0M3hzJ8fM3nlHitgIVtHIaKyeDbELD6pEh7NcWJkny9yEJJHTJtqyjBdQRps0JTjEky+Y4HoexIRSGNoqEJOxDEx1ia+8gIq88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.201.127.2) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=astronics.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=astronics.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tErAkPe9yCJt4LYcIdnB2PrjpYxw7nNczOMDFtJyJ88=;
 b=Kh/5x7jd0RM/wqF/LQ4s6L408931YZIrzyw5X/4q71GppAgUAY5yvmz8db+Pk1HdqnKXU3T6zsO7TeDPrIfhscqw7zTA1vp7+uVJhLQIG0Ld3T64FUkqWvE5B/NAIkqBzB/++NLCXnX3efuHndPBmCDQaEyd/OJHw/btedEHkAk=
Received: from MW4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:303:b7::14)
 by CH2PR11MB4326.namprd11.prod.outlook.com (2603:10b6:610:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Thu, 4 Feb
 2021 19:16:52 +0000
Received: from CO1NAM04FT007.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::24) by MW4PR03CA0099.outlook.office365.com
 (2603:10b6:303:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend
 Transport; Thu, 4 Feb 2021 19:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.201.127.2)
 smtp.mailfrom=astronics.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=astronics.com;
Received-SPF: Pass (protection.outlook.com: domain of astronics.com designates
 50.201.127.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.201.127.2; helo=KIRAST-MXS-02.astronics.com;
Received: from KIRAST-MXS-02.astronics.com (50.201.127.2) by
 CO1NAM04FT007.mail.protection.outlook.com (10.152.90.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 4 Feb 2021 19:16:52 +0000
Received: from KIRAST-MXS-06.astronics.com (172.27.4.113) by
 KIRAST-MXS-02.astronics.com (172.27.4.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 11:16:49 -0800
Received: from KIRAST-MXS-06.astronics.com (172.27.4.113) by
 KIRAST-MXS-06.astronics.com (172.27.4.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 11:16:48 -0800
Received: from KIRAST-MXS-06.astronics.com ([fe80::cc97:5e0b:df06:aba1]) by
 KIRAST-MXS-06.astronics.com ([fe80::cc97:5e0b:df06:aba1%3]) with mapi id
 15.01.2106.004; Thu, 4 Feb 2021 11:16:48 -0800
From:   "Bulgrien, Dennis" <Dennis.Bulgrien@astronics.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: howto-index not found
Thread-Topic: howto-index not found
Thread-Index: Adb7KfhnHM5OLSTJSy+UoMjpWihHWQ==
Date:   Thu, 4 Feb 2021 19:16:48 +0000
Message-ID: <68e6a4e1991d4066a39b84ab5924202a@astronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.249.101]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f012367-b344-484e-5816-08d8c9416d9e
X-MS-TrafficTypeDiagnostic: CH2PR11MB4326:
X-Microsoft-Antispam-PRVS: <CH2PR11MB4326BA31792BE21BE733B176E0B39@CH2PR11MB4326.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsMbf54u5w5WWml/LIqVRWyKZqdUhdvneFjeMPlRYN41WPfgbW7PzpSnRRssD6ue4CA00F2PbkOqxFFxZcv3J/EgOS5JCn6etWoZeUhLFVPvcRfRFS3ofYzKoz3WXJG1o0QrtuQjDsyyoe6c9bi9J+vymKBJjqlXKxmHXhExSZKd7AAspgkFCE3wxOcKMk3Rw4XxiYZL1IzWw0b8GIfm3IiWGBmM+0+LSxalq6Cs/8Rms64gR+ovsFXM4CI0PNLqMKS2mSp9x+7jQv5mrveGTO9EhZFm45qpPBL+sqUfnYdyfvsLleLt7zcGWXubK/vh5VsjC+kHG1ij26ensq8HsLUXn4bkzL+wtI7Kvc0TznS5f6Yi1Y34HfCA4ME1SwlBpfmyPARbdNE5ueSYK28pka+6PS+QDzhszFuvI7miAnaYD7S0INZqxhsBb9TEihoh/ViPho6JzmUfQBgf3nu+gKfRC+aVlYWITSnzNae60EvvUAQKsr+9kZeZrUduFzwbb5FVthGJoFHgANVCGdQqLPXeXt2XkA7saKoEZ+I2KFeaySatcdqZnvV1M0f3TBcbghhoeL1X1RxjH7vM6FFeLC831yx04SVJrGehBleeRi7E1jQVSYooOle1rPlYp8YfvI+RUmOAJAfDJ9moQ8WkfkdjDVzGJwUqxeEeenFNVgGeEeNYHxSksm4x7bqYCXvQZ1lHdzCgSgLWuWcaunOm3MZwW0VWeEeL38OGfaxN9pw=
X-Forefront-Antispam-Report: CIP:50.201.127.2;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KIRAST-MXS-02.astronics.com;PTR:mx2.astronics.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(136003)(376002)(46966006)(36840700001)(83380400001)(82310400003)(47076005)(3480700007)(478600001)(356005)(7066003)(82740400003)(108616005)(186003)(36860700001)(66574015)(5660300002)(8676002)(70206006)(70586007)(966005)(426003)(8936002)(166002)(2906002)(86362001)(6916009)(336012)(36756003)(24736004)(2616005)(26005)(7696005)(316002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: astronics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 19:16:52.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f012367-b344-484e-5816-08d8c9416d9e
X-MS-Exchange-CrossTenant-Id: a2ce8a60-0840-49b7-9389-97ad811e2924
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a2ce8a60-0840-49b7-9389-97ad811e2924;Ip=[50.201.127.2];Helo=[KIRAST-MXS-02.astronics.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM04FT007.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4326
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The https://git-scm.com/docs/gittutorial-2 says 'For some interesting examp=
les of Git use, see the <a href=3D"http://git-scm.com/docs/howto-index">how=
tos</a>"' but that does not exist and redirects to https://git-scm.com/docs=
. Where should that link be updates it point?

I found https://git-scm.com/docs/gitworkflows which looks somewhat fitting =
or perhaps https://github.com/git/git/tree/master/Documentation/howto.

Dennis


This E-mail is confidential. It may also be legally privileged. If you are =
not the addressee you may not copy, forward, disclose or use any part of it=
. If you have received this message in error, please delete it and all copi=
es from your system and notify the sender immediately by return E-mail.

Internet communications cannot be guaranteed to be timely, secure, error or=
 virus-free. The sender does not accept liability for any errors or omissio=
ns.
PLEASE NOTE that Freedom Communication Technologies is now a part of Astron=
ics Test Systems (ATS) and email addresses are changing. Please update my c=
ontact info by replacing @freedomcte.com with @astronics.com to direct your=
 messages to my new email address (for example, first.last@freedomcte.com w=
ill be updated to first.last@astronics.com)
