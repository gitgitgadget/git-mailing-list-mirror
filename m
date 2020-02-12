Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D68C3B186
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E71C2468D
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CEDARON.onmicrosoft.com header.i=@CEDARON.onmicrosoft.com header.b="YiysX3hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgBLTu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:50:29 -0500
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:47456
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbgBLTu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 14:50:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo2d3ggIsKXz1twO8OAv70H0F7745f4/VDO/NUdwVWxdeSrg4AiKdBXwpu1hcmZ+20zNr+xQtn9HFwX1ir+WXnhU69JgWHnb/kGmRlY5I7TPsk6c32jpo8nhL7s34O05s75J8safb+K/sZPFvv21L3jAEqqPVs0Zs8KBLNw3wf8M218DURstp2nIQCyBYlAW0bv6yisJAzQKAw1Ow8ariXp+zwXYnnvJ/uZKWlQX59iRkXMTxuUTZzl/EHSVP6QxeSxDkt+rUCoxtPaHKh2GAue1iFCl3cUvgHltv38gxyWkEVkhm47n3gFtTc1HpCTwQb+w068o9IXcoVuSQ2qsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZPrCoGB1avLHh3rlDYLaXTvyoXsXPW3oS4i4cbrfXY=;
 b=anMjJjiDwK85inJr71BS17UBQW/kM+rYvTqieLrqgq36f/bt0TKMAVpB5C7mKtQoP9TLThOLypZFpZf/9hzZ/wOLd4K51kwURjbDe53zY/OkiSYfQBoZJcAJRCws0RAzNMKfqtA0dXIBaQvgao72uCufNLjfeX0Sq1rTxmC7QQpXIZKyiJ7+oOVkdxMDSTkoyc4KfaZiq6/6TqfEBI2rmy7KNnZzF6RBIUxyl93y+l9GFx5Xorfabqob94+MwNvTuvuK75Gc8C2zvAQj35RjYIRHH28jolItRxIPUQFBAjd1zY6CkvkEYt6SicSTjMNkYJGOpXueb1y1cs1V8aMIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CEDARON.onmicrosoft.com; s=selector2-CEDARON-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZPrCoGB1avLHh3rlDYLaXTvyoXsXPW3oS4i4cbrfXY=;
 b=YiysX3hvXysnJAWNUa8prX+ttSAS/CWeEMUs6ejBfURDVwr3Mfu2YP9qaIQv8BAxDsSHYQl5tpdSNLxWPJeAUrwGPAHxMkFXR1JxYnqUyiq9UjEUlZ8FGJDXPmkogjz0Thwv1y3LT31zusGO/l/S6V3K69UDN5hvVUzQtkutV/0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jhudson@cedaron.com; 
Received: from MWHPR20MB1583.namprd20.prod.outlook.com (10.171.150.136) by
 MWHPR20MB1663.namprd20.prod.outlook.com (10.173.105.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 19:50:25 +0000
Received: from MWHPR20MB1583.namprd20.prod.outlook.com
 ([fe80::d998:bca0:9377:4211]) by MWHPR20MB1583.namprd20.prod.outlook.com
 ([fe80::d998:bca0:9377:4211%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 19:50:25 +0000
To:     git@vger.kernel.org
From:   Joshua Hudson <jhudson@cedaron.com>
Subject: Feature Request: commits where $LOCAL and $REMOTE are from
Message-ID: <2b914152-9d1d-bb2d-ddf7-f7c915239cbe@cedaron.com>
Date:   Wed, 12 Feb 2020 11:50:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To MWHPR20MB1583.namprd20.prod.outlook.com
 (2603:10b6:300:13b::8)
MIME-Version: 1.0
Received: from [172.29.8.74] (12.139.157.2) by BY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:1d0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend Transport; Wed, 12 Feb 2020 19:50:24 +0000
X-Originating-IP: [12.139.157.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f5b1e5-29bc-47cb-e41a-08d7aff4cd65
X-MS-TrafficTypeDiagnostic: MWHPR20MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR20MB166316CE6CB961F95E6AD5A6A41B0@MWHPR20MB1663.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(31696002)(66476007)(66556008)(316002)(66946007)(86362001)(52116002)(8936002)(81156014)(16576012)(81166006)(31686004)(8676002)(2616005)(26005)(16526019)(6486002)(2906002)(6916009)(4744005)(186003)(956004)(5660300002)(36756003)(508600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR20MB1663;H:MWHPR20MB1583.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cedaron.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPlhCoPXMYdDMX/wo+rPqqf6Em04DaHVHE8LsJTL+/UZC1cyEEEpz7eaWg8KGzCOouATY0QMA4Cndr93Pd0m0mgjIphJbV6BerIa2RBc4czVCpUcxaAAU1yRROy6ADqb5bnVByjWVtD2PuAKO92UXW+tnd09ebD7FZOXg33HE/yPk1Kenvdfdj7l1zmiFwvblF2xu4UXMRJ1W5rWdVhHQYFEtwcen/qlAADrO37vJh8NYMqCPcBUDkjbywfQH/yGxFLZNXlT9YEdaUNojmKtUkAyZtAbEF+LmYCq9H7zMCoaKePPGYTt9d+UFyfJ9QtJfVtjoPekIyu+p1pcJrmdqHlFijC5DP98CG3sqmM9XliOJA1wEycZ6E2oe11OtnfbyifsXB4weSGMxRFq9VHPiGZ39AH5TOngti0Dd6gLKGPDcnue3jDI6GQXbt80inaD
X-MS-Exchange-AntiSpam-MessageData: UZt71g9PdmVZIWnpJXWv5yMIKIxCwU/ElalbyrWQ7PZOLFFJspx7KYuwkQ+54YelyP03Jg9pBaGotoPe/7Q6vL80AxL2UXfUMWSo3Df1BY0N+vTWCIfLsCWUGOlsOMVK0yo5rmwqTsKIw9E3mHWCpA==
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f5b1e5-29bc-47cb-e41a-08d7aff4cd65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 19:50:25.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PYOeNx+2gNOvNrKiT2olo8fo44Uthtx5bTr2vWoPKQaFcl4OjbDyuXrdeiGry4woLPHXDa6U5t61KQS2Ho3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR20MB1663
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We got ourselves in a bit of a pickle. We are trying to write a custom 
diff/merge tool for some of our files in source control, but to display 
a readable diff, we need to read other files, that may or may not have 
changed.

We think we can solve this problem with two more variables in the 
command line that tell us which commit hash to fetch the additional 
files from (yes, it can be the working tree; we'd like to know if it is).

