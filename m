Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AD1C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 16:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355638AbiCPQ2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbiCPQ2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 12:28:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97B6D4E6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 09:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbAq4pSJ9+U9W0xLZyDZo2K0MTV4b5MbSCLbxU8vFR+cHX1ngc8QUyt4G+DqKYBYVF7tlmy6EbsvvHGkiMheYsilSa/gug0g1duBro3dYj72UMAvqmsir7OpH3XEqL3qKOYrNvAjL0RoELmCVsx+A/t7g/301i3L1soHe3lPFNAxae+h7n5S4rb1zmlfRQledIE075PDDx5e+YrJnXFeuDZ2xj9hB/PPosb9RlHGfxDgeobKOQZup6VI+cWTVjrsi9uSJB53fvRtlsTvVr8M6eZcY9sTXcDNAajJ4tmQcD8j4GCKLpM+PUgUHUhVDsvl618Z6/63qMb0JnfwPBqfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9YPWt7M7iPHiefrOieqFSbQWLRTieV5TX5vT/Lie7A=;
 b=mYxK0WQSUTlFpON5SXm+ZaIoSdrUm6AQrDACznP+n6Mtq0qCrmmmNYc/AWgdcoBUhFs/bHS9f0odVfomukkX50+UH2zu9YsGcT6box71T3J9fWL3Flf7y/6ZonG/v68dWGZDnYpf8FHk6AcCrqEZ8bGRIMRv9QyzVT0TPYJY+5+Pr4qlydWPYC0wbqgBUBc614n4aOSY5+EhPrw8plVdOrfh6Bf47WIVsfrcLMn/C3110ZyaviYTkfcRuzniGdqVJpnEjejNOkKPyq5Cx5XFd5RpJCskq4FFwsbnxyEhYpr3aUo3vsF2f7hlmfI2NACosokZEnpFEldEMLZNIWA64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9YPWt7M7iPHiefrOieqFSbQWLRTieV5TX5vT/Lie7A=;
 b=hXavoeQ52OxaYU19JUX1sZNjs+Y2NXyr7x4SNVTHeVUah1ryIEvyOsj/eYRiXDv9yoX+LoXb1WbQutmolSaOAIJuhMh9FFPV4ClVtVG0DwTAvJ92+ZT2f81P5SyO8uksxSUTUsRsmFDwP7u/zZyfkux5I3U0rAro95rQhKX5hiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB7PR10MB2266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 16:27:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::79cf:e98:548a:e1f]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::79cf:e98:548a:e1f%9]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 16:27:12 +0000
Date:   Wed, 16 Mar 2022 17:27:11 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Signing using SSL
Message-ID: <20220316162711.wfcavqpg2w4u7fat@fs>
References: <036701d83942$e6963ca0$b3c2b5e0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <036701d83942$e6963ca0$b3c2b5e0$@nexbridge.com>
X-ClientProxiedBy: AM5PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::33) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06ed6ad2-73ed-4268-86ab-08da0769d336
X-MS-TrafficTypeDiagnostic: DB7PR10MB2266:EE_
X-Microsoft-Antispam-PRVS: <DB7PR10MB2266942E3AA3EDFA31C8BC48B6119@DB7PR10MB2266.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3sZcwnXc4WbRUVsL9xawmEgUJaZIZvPyCeZQSYQhuvU9FR/Vi9hrwYAf4AWZKNvSwPUdp3GgaQOFs1B1nGGf3LBoPDYZ8+C5deDgccLdDUe3YMdMsv/Rc+U/X5fLvx2vFnl8Sl32zSNuGdhFjHcRl7ikGN7yJvDFCUjJ0iG31n0ex30+eIR7XmctMwYq6Kb/ySoC+g0AZET8ZpkEHRlWQvmBJUkupKUfD2pV0gNV+PIvaMPh13NnJVKH9msIlwgawb4xmmrnzhMokXN4n7zoohbzjdsACwOjMPhRdF66vldy32Y7B5im3dZrX11izxrvq8XRYGfuC/WjJlHYoIpOCXsPqaaGBb7Fnz0XW4VHgyb1orWJTCnJRqfZpYyqBLNzfM4oCa3hy7UThE7u/UCfIW784dTp0OdblOAedjob1488uJADWYi8Ad1T6KKlFUOYPT1QoxcnrGysWKPnXZkosOyH4qc4fpQvrRtRCC1bFOx5GCrysi3a6WNxX7Bh6ZLFPK2T2wi0Qj5iyIZVjPT6dvDD7pvJuUBgmyShZumOMATG5FZecIWbCB3PqU68X6lV6bY7muDe9iPFVxa5EJSzaDk8C96tJ3fLqFSCc1gjFyuuIlQz4gFK12cmjuWMe9/3p6Mu7MRRQfpOcHhWSYNHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(396003)(346002)(136003)(366004)(39840400004)(376002)(33716001)(38100700002)(9686003)(186003)(26005)(1076003)(6512007)(66476007)(66946007)(4326008)(83380400001)(53546011)(66556008)(6506007)(8676002)(86362001)(2906002)(6486002)(6916009)(5660300002)(8936002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1dKaCtxaWZ6QlY1WGVNWkVEeUZUZ3VSR01UT2dybm0xVzdsRGRpTUM3NGo3?=
 =?utf-8?B?VUFDcHRJdHU2a1NGTERRTVl1ZnR2QnB3eWdMcEs2MFNZeWpnYVJCZWthTFRM?=
 =?utf-8?B?MDlITkU2NkNmcU5pZHhtSE9pU3dCMFphMWVRd2R2dmVObHpjVVJKM1YyaFRm?=
 =?utf-8?B?bFY2bDk5MWpHT0Nsc3RSNkExRDJNV3RaMHEvdHZKQm1HRlh1Nk5zS0hoL3RG?=
 =?utf-8?B?eUtzMXdUOHRIdzRSa2I2TGNyN09GQzZEWGpYWHZqQXJRdWszZCtRRWQ4Yklm?=
 =?utf-8?B?YUVFVHlCUHVUbnJLR2dMOGxjTkVwTFk4M1RkRUR0alp0K2k1VThYejEvR1V5?=
 =?utf-8?B?dFdlY0x1d0lVTmtBY2ZDSDZHNFdSeW5ZQkVSQkhFVlhHbE5SY1c3SmRibzZj?=
 =?utf-8?B?UU5CSmFiYzNoa0Fzc1lXY2Q4Mkdlcy9PNElqbTl4UDVEWDl5SmtncUVWaTVK?=
 =?utf-8?B?bGwyVmJNZ0FmUkJzRnl0aS9SaUVFTnNOdDBDdUhCYXZDYWZrdEZ2VGR6bnB3?=
 =?utf-8?B?T2s3c2o1cnhYeDNTcTdMM1orZXcvS0JZbzdydEZLRThNN1g2ZTlKcFdiNkJ0?=
 =?utf-8?B?RmcwZ1ZPc2xjTTZNVkJhdzk3REtZSm9NSkdTYU5JM3VEYkJGM21XQy8zSTVO?=
 =?utf-8?B?cVRIeGlqc2xRZXpKT3ByY0NVK0huaHJlU2c1NGJMUitoODBSZTBIUUtxL25n?=
 =?utf-8?B?bmE0SUFGWG9uUWNKTGxvdnU0bUZ2bUFvQVptN3pLbUMraGNQV0k2bTNZaEtH?=
 =?utf-8?B?MGtlWmpzQ0E2emZWdzVmSE1qSjdkVkU3S3lrajJkcjR0Y0F6SVVtOHpsaUxa?=
 =?utf-8?B?T3pRK1NPbXdGSEpJZ2xZNkRIeTRLcncrMTA1NDJNQjJIamFHRmdZNktoR1dw?=
 =?utf-8?B?Y1Y3ZEpkUkZuQ1hKNVl6cU5uWWRHYmsxdVRDeVZWUnZFbkc5QlRXY3NUOXlM?=
 =?utf-8?B?Y1l3NjVURjc4ZVI2M29kWFdEUEtReExEL3Z1bmNWaUpXQzdSL1ZDSlNoQlhE?=
 =?utf-8?B?OHlPa0U0UlQzMjFmSTdkNFRQOGRmQXdTMjVnOE5LNmZhektFdHFhcFdsYkdr?=
 =?utf-8?B?czZteUlxL0FGcWdxMnorZWF6Y3NNRlZjdGk1TDF5SkNaaWNzUEJtMytIVW00?=
 =?utf-8?B?cW5UNU15Y2dFanBhVEdUVXcxcC9UbHZsc2lsT3kzV0N5NmFuSS9YdDIrVGlk?=
 =?utf-8?B?TTIyb2xYMTJLaXpIczhTVTNJQitYMjlxQ0IwUlA2RzhVNU9LdHFzWFJrRFVO?=
 =?utf-8?B?UDF4azQrcTcwZ2FzdXVWY0VSdVRtcndYblBHZ1N3TjNsWElBMWJSOFJjTHlm?=
 =?utf-8?B?V1gxNEJ4aXZHY0h3djBIMUFGbkdlemswVjkvaUxQZzc4U3NmL1N1dHJjelFK?=
 =?utf-8?B?WjR4TjF6RFhMbXRpcmo0L1Q2WC9PaUpqNmE4Q21vUlkrb2YrS1VDbk1sNUd4?=
 =?utf-8?B?UkI0bnRJTG42WHZqM0FldGN0clIydVozS0FIQWVZMDF2bXVoUHZyT2tSNFVD?=
 =?utf-8?B?VWxyNzlpdStzRnJTQ2Z0Sk5jR29QN2VUMlBrNDVLUFZrdTcwVDROR2FnQ0JF?=
 =?utf-8?B?OWZETWJjY29GbGtjWlhSbEVjWWdadzQ0dTlTSjdwbFpzZGFRc2hKUnhxQ0lU?=
 =?utf-8?B?OE9wbWNmOHY0RnNPbTJEMnN1QWZmQlFyVVJoOHJqN0lHS0JwQ1RwZ0FvQVRi?=
 =?utf-8?B?YXdESVRQcTZNd25jb1cxZXBKNDd0dHNjYjNjaHRLaEh5cjJxLzZKdkF6V0xs?=
 =?utf-8?B?SVJBOWJIUVpORnBsTW0ya09rRmZOR1A2UkI0alhKR3NrV2VrZTFGUi9tTXBw?=
 =?utf-8?B?VkVVMFRCQVhSMzJweDd5QkFSZjBmVkhJUkJTeXdQbmtCQWhYK1BWYUtlSWZG?=
 =?utf-8?B?ejAzV0dVcmFQaXNNaS9OZ093RWxaYXdmczdNdTBxSTlIcE1CRDdhaWp1T2Fw?=
 =?utf-8?B?aDhmaC9MVlhFWTlUMXBFdEp5SExZQm9TWmcvNjZHa01WdU5pbUJNS0ZvVWg1?=
 =?utf-8?B?ZzBCbXhqRU93PT0=?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ed6ad2-73ed-4268-86ab-08da0769d336
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 16:27:12.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dri2uh+Zp15iSS0p8VllLAmlK9FxdM6f6Q+MrRe5BNZ2kyRFZYPvl8z7/xcvkvFsKVNvp3fgSb3DoZqlQuK/eEtRTrlGsUUcYVKa0M5UXBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2266
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.03.2022 10:34, rsbecker@nexbridge.com wrote:
>Following up on our IRC discussion on Monday, I have had a request to
>support signing git commits and tags with SSL certificates instead of
>SSH/GPG. The organization is heavily invested in SSL infrastructure, so they
>want to go down that path.
>
>The basic technique for doing this is, for example:
>
>openssl dgst -sha256 -sign key -out content.sha256 signature.txt -passin
>passphrase
>
>There is a pre-step to compute the sha256, in this example, into a file
>provided to openssl. We could use openssl to compute the hash also.
>
>Verification is a bit different than what SSH or GPG does:
>
>openssl dgst -sha256 -verify  <(openssl x509 -in certificate -pubkey -noout)
>-signature sign.txt.sha256 signature.txt
>
>and reports either
>
>Verified OK
>Or
>Verification Failure
>
>It does not look like completion codes are consistently involved.
>
>This also does look structurally different than both GPG and SSH and more
>work to set up. It may be possible to provide wrappers and pretend we are in
>SSH, but I'm not sure that is the right path to take.
>
>Any pointers on how this might be done in existing git infrastructure, or
>should I look into making this work in code? Sorry to say that the
>documentation is not that clear on this.

Why not gpgsm? It can deal with x509 certs and is already supported. I am 
using this to do s/mime signing/encryption with an yubikey hardware token 
but static certs/keys should be even simpler. However I'm not sure how good 
this works on other platforms.

Take a look into the GPGSM prereq in t/lib-gpg.sh for a few hints on how to 
set this up.
