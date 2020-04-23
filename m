Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48BCC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B300020715
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgDWSDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:03:31 -0400
Received: from mail-oln040092068079.outbound.protection.outlook.com ([40.92.68.79]:57841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729901AbgDWSDb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 14:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxfjpOMI2o0j1KKvDXZfbfegPiTXrz/NHzww9APIsPlf8ncmk2Jvosl6K9uu4rMLnB9OSSzMDSCOEzw2/UEGEbs3TxrX9H6AzX//M3x5eB9EnJMN4PQ4Gbm7ey4vE1NbNrgjBcYI0qKPOQ0M0neLlts6J0ATg8buj63UcqCkPCygmTl8ffa9hXSsHfc5lRdM3NrCQgv7b0EefQ1PK4YdkAkZPyFY8IVFBvGpqYLtRtRaRTHtZNZQdVr6PA+t3ROhBhw0xxT3GIBK3/c/M70wBI0VF3muNbNikc2x7DfW1MD/5dOPuCMMs9afbHEjSm+T0tt5y862l52wnBbgYEsa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMBOvL6wo2HrBflaDI4oOADW/JbmnLB3/ppW0TwGf6A=;
 b=X/Rg1PcaigaXb7W+0d+egQi3iT2oqi8zxYxtNU+LnpK2CtWwg4rJNiR4+1uPx9YUozxXhXgAobo3x64aC4F/qvfIbMIZa4iEwA6rjVjSWqHwpnBH5c8/u2dnYQUolqEO2Cq26Xtf1ZXTM3BQ1HzW2Yh+4iNrEzQrEb7v5noCSjnjH5sLlILg79zVV1fZvwi5ooo1tTjpk2ZDSZgBpKvE5rWg6ZaSIz1x5ENO+Sqn4cI4BMuPNz2kO3kRuzYaiWIF5nyTXJ9WQBVDpB/uyoHqHQGeK/X9ieGm2uE8z168wAR/FVwpsByM0l0FhGvV2atm5V5cZmBENAH9ubkMK4c0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.de; dmarc=pass action=none header.from=live.de; dkim=pass
 header.d=live.de; arc=none
Received: from AM5EUR02FT050.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1c::4a) by
 AM5EUR02HT035.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1c::361)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Thu, 23 Apr
 2020 18:03:25 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:7e1c::44) by AM5EUR02FT050.mail.protection.outlook.com
 (2a01:111:e400:7e1c::508) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Thu, 23 Apr 2020 18:03:25 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:72B39C61F9ED067E3BAC7A049BD9A097ADE58AA04DFA9055E2180E34F68CD078;UpperCasedChecksum:5339F43EA073C27E73629E4EE55D58E67B5F4E747BE27BF97654B43CC8775276;SizeAsReceived:8629;Count:47
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 18:03:25 +0000
Subject: Re: [PATCH v2] ssh: add 'ssh.keyfile' option
To:     "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org
References: <20200423064110.77258-1-ray@ameretat.dev>
 <20200423112110.45405-1-ray@ameretat.dev>
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <AM0PR04MB47715A57B110E14D6631EACDA5D30@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Thu, 23 Apr 2020 20:03:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200423112110.45405-1-ray@ameretat.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [hMyHKDOXdAhzQDpLG8CplIebpUHQ7gRd+aJ7WkfcDFxUATuUfHhRZqdnNzR0hqGa]
X-ClientProxiedBy: AM4PR0902CA0020.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::30) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <d9052042-2337-6b2a-0b18-f3195cfaafd1@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a5040c91-0547-47cd-996f-08d7e7b09e1c
X-MS-TrafficTypeDiagnostic: AM5EUR02HT035:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6iYsnj1RlrVdP6+dYjDqTCq1TeBRYWRc8fuzpWA87b+JUq3jp2mGnMtplD13nbXov6c5q6uaF90BpPilojNkJBfsj8kP5MfkaYj2MzWBSu+oLBGPZL9CKb90vCcIZsqomq71MtanQqAsj/REfMSUD3fUR6hMQrGvuUF5VLOydNRctfPkKGjtBXduhiL0p9g6PpEEOlDW7endOfia43iOHlHGut8BjWx573E2FH+g3oLaU6/4p23PdcT0r7u7RBr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: y+x06G0QQktdPn7h6vZDBm6vtrXGhQcE7eOWJOzMsLk/g+sxUcnqFXQvOkRk5jKGCCUGhzOAPNoQOIlujFWTwzJYdMeEh9BH5+iZMkoYt83Eul2zs0zCxpCDEFEY2FsaCUd5Lcj3QtzyxpumjobqjscR1uCCRJVwZ7JVScc4LMFlUEMwmtT7BTQ3+0972hxtzC748ygj9OveYQcLP5kTcw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5040c91-0547-47cd-996f-08d7e7b09e1c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 18:03:25.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT035
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>+		switch (variant) {
>+		case VARIANT_AUTO:
>+			BUG("VARIANT_AUTO passed to push_ssh_options");

Why do we keep replicating this all over push_ssh_options? The wording
very much sounds like it's a bug whenever VARIANT_AUTO gets passed to
push_ssh_options, no exceptions. In that case we should probably just
check for it once at the beginning of push_ssh_options instead of after
almost every single if. If there are valid cases where VARIANT_AUTO gets
passed to push_ssh_options we should probably clarify the wording as to
what parameter combinations are and aren't valid with VARIANT_AUTO.

I've included the Sign-Offs and Acks of the commits that introduced the
previous copies of this.[1][2] The previous discussion[3] on the mailing
list does not seem to mention the duplication.

[1] a3f5b66f: "ssh: 'simple' variant does not support -4/-6" 2017-11-20
[2] 3fa5e0d0: "ssh: 'simple' variant does not support --port" 2017-11-20
[3] https://lore.kernel.org/git/20170913215448.84674-1-bmwill@google.com/T/#u

Best regards

Matthias Aßhauer

