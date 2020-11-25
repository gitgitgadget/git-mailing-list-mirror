Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB5C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FD6208CA
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jg6lzDqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgKYInP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:43:15 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:42469 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgKYInP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Nov 2020 03:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606293791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3k3g8EKHeGn5SB/6N4RQPxl4mx4YTR5vsE/drr1LT2c=;
        b=Jg6lzDqB0nVto6VtPBwNKW3TVe/mUq9xnda8ANHE4RdJjCEijorNrw7ZyLfHFBIgDSH8N0
        7hLqPLbWfHIFsyOgApryfg7+kqOKL990Fpmdz8vHDb9+FtxrySyd1tjGApSvuGsH8owHLJ
        oLX5XuhdlQRzl7pgHnqWD3T45Mi+G18=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-ecMY8nYAMGa-lj_SivBYdQ-1; Wed, 25 Nov 2020 09:43:09 +0100
X-MC-Unique: ecMY8nYAMGa-lj_SivBYdQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/7gACtO+B3146H/+vLDkMx51mBrFYBSR76x1xb+Cix1bherGxrVq6yLeV0GX+Oo5wgGwvs3NV0/0TiojFkOMFkKh1FkqxElVVbThv1jJ9oMqRtl0ZLU0O2QFwjCOx9YKJdOZM5+XsnJzEfgYXv5CY6zmZupdGNBWAbiLrnH+PYF3qccIOjcdSPRiDcEqd6vNUNF9j8HHVWwJ92EQz2ING9uD9cc8smcQVtGpU8CrGBFHHqMN3XwLY0JVTWM7qlAdGPxrGE6tyqyJ4FgtBXPEwm+d34qAA/3HNQtysxKhIe/0FG68mwOtc33BJpfGxD7SiS88XFI/03Y8Pn9r5frLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k3g8EKHeGn5SB/6N4RQPxl4mx4YTR5vsE/drr1LT2c=;
 b=inN3dxkHHb+SJ+C8dHKoleS2how88Hi3oY6YWt+xA2qCNkDDPddoWzhvHrZvpDoalObjep4IbmHMKram0VV0WVr2fyFdap7CPqop3P3QLjVD/+kgX55JkGpDqM8pe4y/x6Wxlx+sQ2zEKpN8k37lbk6Inx2grfvxGXNu2o3FaLLn8Y+WJ0Jb0e6EnjxIm9VPk4X4vHRLzeQOFgMtfnwWf7c7oQTa/96kaQTMqU51pdDUi6vVNGwlcpOWRxJ/OgbFm789SDmaJTUC3TEw/PftNwWy6sAA97Zvx6OXeAcAWfhg1VEMzizfiPAIyl/nwwDpFn03LyAErpMX7KO2qz9stg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB8PR04MB7161.eurprd04.prod.outlook.com (2603:10a6:10:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 08:43:08 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%7]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 08:43:08 +0000
Subject: Re: [PATCH] imap-send: parse default git config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com
References: <76d2be10-0c42-70f4-101c-ee15e3039821@gmail.com>
 <8a21b031-fbfd-81c2-1f91-eff8c03bafb7@suse.com>
 <xmqqh7pdg7ma.fsf@gitster.c.googlers.com>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Message-ID: <9c410f99-6b9f-3d94-bd4c-8e4197b3cde3@suse.com>
Date:   Wed, 25 Nov 2020 09:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <xmqqh7pdg7ma.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.157.137]
X-ClientProxiedBy: PR0P264CA0261.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::33)
 To DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.157.137) by PR0P264CA0261.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 08:43:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b798bbe-f458-4752-69dd-08d8911e2232
X-MS-TrafficTypeDiagnostic: DB8PR04MB7161:
X-Microsoft-Antispam-PRVS: <DB8PR04MB7161FEC8A6317BA20E000FF9BFFA0@DB8PR04MB7161.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7Tv/W+qKF3YWTCZqMwPtarMmipXWS0/v/1tDq7QcHsRf8BsrLCDykG5BNxSuHtNlJ34pIhhQXDjDENUY861S/rizN9RwZ3tbOHVsJt8fAgDhyTjfUzmqN0VL3bvoiTyFS4R5duXHwwMro9kWKpt7Iv7k6ywTE/xvwOiByLcwAe8PKszIjnJjHyIKpwUkf/yrnLDUY0C0986P5wCbUAScETkfdsQvojdX8mlRz+cAjJsKqbAabM2Z01ObxjcxtDzaDESgCkY1n5V3bmJGaqBFnSvnyltlXBxMrNPnMqSgCdc3mXKzZP70fnFuUSv+vWzA9DedA2QRnuBckLerx8RCQwlqEMYqCSchNH+XyVrm/AOajz26ERUv2hJ2wkiakx0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(366004)(136003)(346002)(376002)(66556008)(52116002)(6486002)(36756003)(83380400001)(66946007)(4326008)(2616005)(316002)(31686004)(66476007)(6666004)(16576012)(956004)(86362001)(186003)(478600001)(26005)(5660300002)(6916009)(31696002)(16526019)(53546011)(8676002)(2906002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NW1OOHFJNENPM21UTjBXeGk4dUxyQ0xXTU05RFg1aEJrMGl2ekZZS0lGQjFR?=
 =?utf-8?B?bEY1RGs0QW9lY0dvcGluengrZWNBSi9ibWVvWmZYaVpKMFJYOWRZK2hQZW9m?=
 =?utf-8?B?Mlp6bExZSmN5V0ZHR0FNT3pEeTFDQlc4STRlQmdMTVdzbkFhZmVvTkNuY0d4?=
 =?utf-8?B?ZXkvZE5tOFJXcm51TVZhb2h2eVlJdlhaa3pyL2NzTnNDNVVFaHF0dGg1dkFr?=
 =?utf-8?B?b2RzVUZWeS9NRERqY1NCWE5nYVlVM1NIMGYyN3RFblNHcnZQbHM1ZURZaTdV?=
 =?utf-8?B?VVRHendRZUlrR3Z2QTQ0RkZxM3pYRTdrdUkrZG5xYWVycGQ5ajA0OGJSVTZD?=
 =?utf-8?B?d1I3SEJvOGFHMVVmczQ1RGVrZHY3L1l2bVY2M2p2dDVaTVNCTWd4aXlzL2NV?=
 =?utf-8?B?ZE9WUVgvZFF5cjMyYlFJbHk5aW9BN0NESVZ2MTEyUG5IVklFbVFDaElwbzM5?=
 =?utf-8?B?enZSWXpMc05VaFBFTVhFN1V6N0pMVDZHQUJMSDRDcjFmRGJVZ0RwNFNFU1hV?=
 =?utf-8?B?UFA2dXRxMStTSTg5cDF6M1FCNUUydHhTRHlZWWhpT0NCcFpoL0MzakkwaEtk?=
 =?utf-8?B?SCsvUFFhZDd0WmJrZFNnYkJpT2tTTHo4U1ZYWTVuZmo2S3RXcXM3Wmo1MGc5?=
 =?utf-8?B?b3BtZjJaL0JPNU56TDlvSmg5d01HZ3VHL0NvZDlHN0tVSjYyVHRiK3prc0Nx?=
 =?utf-8?B?cTYvcHpwdzVxbjNseDAyd2drZFlYT3poWmlFVTNwcVM5NU5PV3lteHVXbWJp?=
 =?utf-8?B?Tmtsa1hCWUZuVkt1MDJYREZGSmNDWk54ME9wMUNsc1N3VlVHa1NoL1JoQ0Vx?=
 =?utf-8?B?a1ZyTzFFa3orcFhFZjMyRjN4TlVDOUNBUXMxOURFSnY0SGtrcEcvaEdyd0o4?=
 =?utf-8?B?MGxFQXR3eW8vZmw5bmJMVGpTU2ZrNWtyYWJWL2dyanYwcEQvS2xxeXlVT1My?=
 =?utf-8?B?THVCdlFPSVJZYTErUlZKKzRobWNaMWhGU3k3WHYvT3B3dGZtekR3YlNidnRD?=
 =?utf-8?B?ZTFVaDNVZVlPR1lWL1E1YlBCcWoyeXppYXpxTTI3NFNhbXB2SUEvakZpTTI3?=
 =?utf-8?B?NGNqUmMwTTB3b1dQR2IyeTRDNTBzcVVUYlVFNFNNK25mKzRJL2hkN0I3bzR1?=
 =?utf-8?B?YU84RU5tVFRENnVpMGFEWlo0a05zK1cwMm1rQUt2TW11N1NNMW5tbWpxOGNx?=
 =?utf-8?B?S3FOWlliWUl1VUw3UnVORFdpaDB3TVBEaFN1RXdrL0ppMDJGblprNnlST3VB?=
 =?utf-8?B?bS96emhuNW16UlhDV2tQQ2cvVU5PNlplSWtOamRPYWFqNEFKQ1QySkZReTZD?=
 =?utf-8?Q?1PD+fZF6rhz1XPXNfwjNPfzzEJ6Pb29/C5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b798bbe-f458-4752-69dd-08d8911e2232
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 08:43:08.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdCIQ1inbMsrifqwbk0m+KHIMjs3Ew2D8dGHhYOv+hDUqchZicazpkRwjRlS1KvKRHtbFurw1PHNIeZHA2UbNmaXWZOQmAfzrLNfJaMbAWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7161
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/25/20 9:31 AM, Junio C Hamano wrote:
> Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> writes:
> 
>> git imap-send does not parse the default git config settings and thus ignore
>> core.askpass value.
>> Fix it by calling git_config(git_default_config)
>>
>> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
>> ---
>>   imap-send.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 5764dd812ca7..790780b76da2 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1367,6 +1367,7 @@ static void git_imap_config(void)
>>   	git_config_get_int("imap.port", &server.port);
>>   	git_config_get_string("imap.tunnel", &server.tunnel);
>>   	git_config_get_string("imap.authmethod", &server.auth_method);
>> +	git_config(git_default_config, NULL);
> 
> There are two styles of parsing configuration variables to get
> values.  The way imap-send.c works is to grab individual values by
> calling git_config_get_*() functions.  The other is to give a
> callback function to git_config() to iterate over all configuration
> variables and pick the relevant ones.
> 

OK. I thought it wouldn't be THAT easy :)


> Of course you could also unify in the other direction and instead of
> running git_config(git_defauilt_config, NULL), pick the exact
> variables you care about (did you say askpass???).

The only one we care about for this specific case if core.askpass as user gets prompted to authenticate on his IMAP server.
So picking just this one would be simpler. However isn't the other way around cleaner if we happen to depend on another "generic/core" setting ?

Nicolas

