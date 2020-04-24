Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70807C55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A54920767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgDXEdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:33:14 -0400
Received: from mail-oln040092066051.outbound.protection.outlook.com ([40.92.66.51]:38117
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgDXEdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 00:33:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIUw2eVbpVCDMlEhkpql0m95YHg/eiELuLREYMKG9E94z1ueg/hEnAv69Bu6lgwVyxJU6ICLDSlbcCItTsrowWcZa7+/Ly6NLewDwxEyHqW8Ya3uLdm/8XlvU0eg8lu55OJ34vGQjMEaK55sor3lRWxewE8kLU4cmVUOA4PHOObx9aBouzpTASlj8NQMmkfurRMn4m6tF4el7vaXblC14RLKPTtoDvVY0zg4h1WsuND3Q9eOYG/9RcifgribNE3+nHiJzScokbF/I40V8iiDZOidakV45xMS3cqf66EGf9LT7AjLO7q/v3SqyOSXM6qZtTddEHLNoGARWhzfAMWE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TCzNCCsfSu+sgmhXM55v9ZRIP83kxfYZWu7RtL0I20=;
 b=B7EOjDpbiIHf5/baPYO/Z3LuTIrsCnL5fxu2i1s8Ulei4KRcuhhBy2b1OUNVhT6B9PPox37jlHEcW+mH6fYOV9sAiXdaKQ6aPbyEElhLge0P9bd0/oKGDnF5bIeYNoJEeUrrKEqm7lqshA+kCXQ9LZ9fGSWbdeArYqEGGzzdjyZs0PNalMLoOIAKwtC91b1XWnEW993GXlZsIPPRh0kzEIyreaffXTLLfugrMOWEcnBpQfmQLQlnOJwOT07zgSwr9sEPkm4bnOIlb45aykqjWHZWJDgcuDayRaKk/YKzzfsAj/c4Ka73ZGc8fALPXP+IhB+F6cQ64RNdhCTAvgdRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.de; dmarc=pass action=none header.from=live.de; dkim=pass
 header.d=live.de; arc=none
Received: from HE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e18::49) by
 HE1EUR01HT027.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e18::308)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Fri, 24 Apr
 2020 04:33:10 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:7e18::4f) by HE1EUR01FT064.mail.protection.outlook.com
 (2a01:111:e400:7e18::287) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Fri, 24 Apr 2020 04:33:10 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:60BE7A962247F036BA8655437AF890E8AE8F3FAB73880AAA63FAA61D129859C1;UpperCasedChecksum:6607AC9AD29387C8301526267A8CD3BDA77EFAC57081C7D64549ACF28DE80FD5;SizeAsReceived:8763;Count:47
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 04:33:10 +0000
Subject: Re: [PATCH v2] ssh: add 'ssh.keyfile' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20200423064110.77258-1-ray@ameretat.dev>
 <20200423112110.45405-1-ray@ameretat.dev>
 <AM0PR04MB47715A57B110E14D6631EACDA5D30@AM0PR04MB4771.eurprd04.prod.outlook.com>
 <xmqqeesegfgy.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Message-ID: <AM0PR04MB4771FB8BCD1EEB7E60EF54C7A5D00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Fri, 24 Apr 2020 06:33:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <xmqqeesegfgy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [WbZ3hiEe73EqrAZ3sMZabmPupPkmGjnNu4/406l14df09lbaSSybiM9rGxng6sTn]
X-ClientProxiedBy: AM0PR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::39) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <46b5f56f-fe99-ddf6-6423-590b04ed6bb9@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6add4034-37fb-4924-ca6f-08d7e8089786
X-MS-TrafficTypeDiagnostic: HE1EUR01HT027:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1tXKWRrohRPw367F3deQNnosTmByEhhWo+qeVFYZ1DAwBtIQY2TY3d3Z6Ibu1IxSKaNANX2ZZVWQbhLv6yTCmHbdzAP5mYDdCKrarnMpwKbWi+gh/dJsglnx/LzU6pnNrHw9ksPdsk49SGoFExmvHrlY5l/kTOuuPz0EytOODOadLNUy9EKMohHT/dZy0NfR456gJQ0ZtEYzPhj1IMuFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: fX+bXa8Oqs3s5tO2OMG0KfCeZJyEaIC8NHhJYDVnMlOPaGi1xjLGJRxreYswN+ve07cibqH3DWvg8uVOlYZ1eljHPmDJnlIwI9kPCq35gSwTyAPcfwlK+9Bp69iNIxszXvlkJoZ/tkkEdP2KOQ7FQymr+Uc6ahuzmqe74aOKGSmcTSnAF2MxfGptsDOMLi1a9ujYFq66tO8r34QSlN601w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6add4034-37fb-4924-ca6f-08d7e8089786
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 04:33:10.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.2020 um 21:38 schrieb Junio C Hamano:

> My reading of the code tells me that it is *not* the case.  When the
> caller asks to connect only over IPv4 with CONNECT_IPV4 bit set in
> the flags, we cannot translate that to an option to underlying SSH
> implementation without knowing the variant.  As long as the caller
> does not specify IPV4/IPV6 or custom port, I think it is OK for the
> caller to leave the variant AUTO.
>
> So you probably want a patch along the lines of...
>
>   connect.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/connect.c b/connect.c
> index b6451ab5e8..b02cf74c9a 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -1118,7 +1118,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
>   	if (flags & CONNECT_IPV4) {
>   		switch (variant) {
>   		case VARIANT_AUTO:
> -			BUG("VARIANT_AUTO passed to push_ssh_options");
> +			BUG("VARIANT_AUTO and CONNECT_IPV4 used together");
>   		case VARIANT_SIMPLE:
>   			die(_("ssh variant 'simple' does not support -4"));
>   		case VARIANT_SSH:

Yes, that looks about right. I'll extend the patch to also cover CONNECT_IPV6 and a custom port,
give it a run through the test suite and send it back with a commit message. Thanks for taking a look
at the legitimate cases where VARIANT_AUTO gets passed to push_ssh_options.

