Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB7C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 06:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJLGzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJLGzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 02:55:53 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB6F58175
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 23:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV1WhGo1jc8hPmD6QCdRFXDw90acY0rcR2Ba8fQnHCPVhD8ZzyrldUZPvIPBtaDfoY1RhUGaXfIaPR2H40Lp/950eWj15IS2otBgVP1hy/GuIvVAoC46DNDNhp0iR+BANTPhDgFWN7H97MdapT9isvw9bV+/8+oPwpW+B8u5uIEPOR9ysNP2EXkSQGuzFBT96RGZfQ3bDAQLHfJCrWoPNCdlOVHV3HbOsSzoRd1KMcOizxnK1hxDpd3oIHyXQzVFCjx4/y0Xr5L1L302+n5KGqN4QvThzgBfMKmQLW4Q1gx7g/cTSIfLMuSHtKT/eA57gMQowoSe3/FGuJArh6mhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX1HHq6vYOO7mUS9pu8VYWLfgTdzxZ9yxjtGtMZSs1c=;
 b=PHzAAy0RtTxrDtzj3l7y+d7YhUNtkCjYPyWTCOJklmSL/zBDixI9Jr+1dXniAgeMYV6R2nfn5FyPG0A37lC+kQQN8/oeqeZMMsvRZdNLTfM746H4/7XOVLyUfP0W4luBv+YWTno//UALR2DsdnbZZja+ljhoj930rTJBCZ94EQkhtMX8eivqE9yF1UVRu00sUvtIlJD9enxc1t/Z4jBpFNWGUPsy+bt23hBPgV/a8zcnZtpZooN3sbzHNCdFc67Yj03HCStG13cRWxOFvIK0oOGBiClRKSgUTMv47dDK+/rYGHe0LmFLSts4NQgHXwykG1Kog3as2Cs9Xhw2KMcoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX1HHq6vYOO7mUS9pu8VYWLfgTdzxZ9yxjtGtMZSs1c=;
 b=OIw9Vm7jtbylc7urU2C+2RbErn5ka/QRuGtDIIBLsuQXkv/FjBZ7Zvn4/gTcsMJhGiaY12vY/oRtAlbLgcZSV6FOl3CIEs5Q3xUw48fKW8Doi8qGat7NaEyGr4YFW2QCb2TzrqTNjeriY+pX76hKnwq6aJbMNAioUha3kgt/Urs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::17)
 by GV1PR10MB5986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 06:55:42 +0000
Received: from AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ef7:ed26:40a1:f35f]) by AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ef7:ed26:40a1:f35f%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 06:55:42 +0000
Date:   Wed, 12 Oct 2022 08:55:41 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Nicolas Graves <ngraves@ngraves.fr>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Cuckoo Aidan <aidancuckoo@gmail.com>
Subject: Re: Error / feature-request: Signing git commits with SSH hardware
 key
Message-ID: <20221012065541.y2tl63tw3ooeoy7s@fs>
References: <875ygqw7p8.fsf@ngraves.fr>
 <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
 <87v8oquiuk.fsf@ngraves.fr>
 <87r0zeuhrv.fsf@ngraves.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87r0zeuhrv.fsf@ngraves.fr>
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3271:EE_|GV1PR10MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: e4face8a-d905-4c6c-1322-08daac1ec772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BCvle0xPlXm70Wi3KPgDk9OEHCFCAalJCBLkBC1xEuL6ngIj1L+JhOCVFOWypcMawO8gqYc6dGi8lyf0ovXvp+qefRz6JEkfkDV/UrrpCkvHHe4TXC+JMG6QbM1bNgjNznw8c79IsjMnm4v20WCFpOSjCQ5u9JhAjm7xEbyGcvDGhBcXpgSyOOvC0O0rN/5CgTcJReaw1velGBuFQy2NTxzlRHJGNB942lZp2WyRJaUGZ13SycMNr0h+zPzKQxFYPigxml9dwXMaQa0/D6mBXz6pE0YGp57mRwY6FnsBNR+3lBVso2GpH0aSehIL3NJDoAE2qKGgmwKh7mR81gIzo2eefNsA4oVTXTnJy7EzCw71xzCW4Hgq9InDFjLp+fncBB5LKzlA0CLvmYuk30FRL/xxbINnjJCxpf7iYcPiuEpYOllgPkD38ALisx1sgeauKqAyskGKsMQfg+ohyuGLVGrEki125LboX+zzlwYvLmLEa6EBLhrPXan/cXEo/9I4IsQOVj/l/vHZ7jprPAcm7u1RvtWceGvRs0N+6PgiH9/rKR17ietTDLArH3ScdwaxiUiCQ+JaHloqQbo7gpQpSa1KRRzpDQl5181RBXtMIe3b55WqlqSfrDf3eiCJRsXQkyQbj95qYiNuD91ONdHy5zBvY6moXf2ViKRdUmWuaAZcLgUNRE6kq68Xp3yiiRCqm3CEq7g4xwmmlEggzdCWlS8SmlAhbq76XkQ3ehH7YDIZzm5JNe0/INGdBYiDBkV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39840400004)(346002)(136003)(376002)(396003)(366004)(451199015)(33716001)(38100700002)(86362001)(53546011)(41300700001)(6506007)(4326008)(8676002)(26005)(8936002)(4744005)(6916009)(9686003)(6512007)(478600001)(54906003)(966005)(6486002)(66476007)(66556008)(66946007)(1076003)(316002)(5660300002)(186003)(2906002)(4001150100001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHA3WFlIZk5yUmVSd1hlYU5DMUNQcng2RTBtdHZEV2VidHhzYUZaUDJOVjZC?=
 =?utf-8?B?L28rSDJDN3JoeHhMb2treXZobWhjNk5TaldZNnU4SG9CTUJFNjdKR2RTL25R?=
 =?utf-8?B?ajhpbWRzZzYwdVlqakJmTHFsQWtYSC9VUDc3TEhHbk5IT0hoc2hYTkJhWGxs?=
 =?utf-8?B?YzNURVNvZDNwZ2t3RVpkN1NOYm0vZldmRXdkMDlOTUpMTmlMa043a2YrZUVU?=
 =?utf-8?B?ZnZnMXF2SXdaZFBybGpBY0lCbUdTeXpNMFRoOHZ4YTZ4VGhmU3pkbHJ1K2ls?=
 =?utf-8?B?YmpRTU5PckhHOWhxTDFLR0hGZGNCQ1pYa1RxbDBvdEZTNW9uUjBBR2w5cnlY?=
 =?utf-8?B?dVFYVkl3R0RsWDBXTE5FN2JXOXo5a0dDM05wZFJ5UERzZFEvYmVMWCtTdDdl?=
 =?utf-8?B?aXZYc2p4WmovZGNJbXFrSzJ4R1dwdUlWSjh2N3BPQWozQmpBcEU0NTJTTTZp?=
 =?utf-8?B?T3hoNnEreFNabnUvMjZjekdSM0h5RHBPeWhGcnJwOXdzdEJHUkdSbkNFS2k3?=
 =?utf-8?B?M216QytFcVhRRDc1N2toWVh0UENYbEVybUZLUEU4dnMwV3ZSY2ZqNWNqZVRF?=
 =?utf-8?B?Um9SdjhpQm5xVWJtTXlCd0FGRVVlOFp3Zy9HL2ExM2VBVFhkSWxURUk1Mm1Q?=
 =?utf-8?B?MVdUSmpEbHVHdGJPRWdSckpJY2RIUWgza3FGaVlkK2xkeldnVUlGeWNXWVRP?=
 =?utf-8?B?dzEvc1dpbFFrbHRXV1hpU1ZsOW5WdEk5OWorR3FxM3NMaW96TUpHcXNtWEsz?=
 =?utf-8?B?MG1QbEFGTVNyY3lSandFMGRTVzd1c2RpbkNYMlUxZnpIVW1iNmIvcVh6ekhk?=
 =?utf-8?B?U3VoaUxDU3FrUkRHdGRqaXhTUzBWV0ZWUHF2L2dhV3FRY2d3WWdkWWZWVmgr?=
 =?utf-8?B?QVJOTmVJT2tnNkNRQWN4YXhtT0FJeHg3MEhRZTlNWnpSNFhRR3Bod29obys3?=
 =?utf-8?B?VzVxMXNSVVQveTVKVjh2aDd4VWZkY0drSDc0dDlDb3NSRzl2VzFTQTZIaXEy?=
 =?utf-8?B?NXExWG4zUVR1ZGxYenZMMjBUOUptb3J6NDQ3TUtZNWFPck5tNlR1N2ZERUlk?=
 =?utf-8?B?OExiYW43ZGRSemR4T25vNkUrUEszV1JRL1hTNlc1eFF4VUVSdnBUZWsxTGZT?=
 =?utf-8?B?enhFa1M2eHFsQTFBVmg3L0s0U1lBRjVSZXdVK2YxNllaeTFOd0tQcTJ4UUp6?=
 =?utf-8?B?SVFwc2s0ZlBacE4weUdsSDZ5RTFwaG83My81MVRNell5eVRDSDJGamYzbFJ3?=
 =?utf-8?B?UlBxZmZRUU1YL1JFNVAzY2R3UTkrVmdFTUcvbzM1WDNkcjhUeFE3NWFxL2c0?=
 =?utf-8?B?VnNmRnFGdDc5TFhybnQvUlRaZ1pGem5Ld2d6MEoyT2l2M0VMWWlDWlpWYU5u?=
 =?utf-8?B?QW9wMFJCMW9najdHM1lCa3pWUmlFSUN0MUZ6NHJzNzV1TEFnUmxqcmY1ZTEw?=
 =?utf-8?B?QmJPNzdMa1ZsWUdxZUp4SUtodXNldUdoeHhQb0xUT1V2cWVncGdSVit5Sytj?=
 =?utf-8?B?WmpLbSszbkN6N2UybUlPb09FVFpKY2dyaGtXWlZtd21xYlcrWjlEc0JLQzJt?=
 =?utf-8?B?eW8xWm1NR2ZVUUt1cXR2N05zUldmRjNCSWczd2JjN0gxOGlGYXN0ME1RQVVK?=
 =?utf-8?B?aFZyVWxWZTg4REdJUkRiT00vUlVjWjdJR2czRUFwenlva3RDZVlLZW13Yk5V?=
 =?utf-8?B?dk9FcGl1cWZQRWZkSS9BN3dpeFJZR2xnL3drZHhKM3d2NlVuZ21VMCt1UUtw?=
 =?utf-8?B?THJ1WVpzY0xMZXZCMUdCQVVZZ1NiVWFxcEFJTnRUWkRiMjRoNHhJWGM4a0FP?=
 =?utf-8?B?akpyMUw1VGY2VDF0cTNzMWZQelNaa25iZ25NK012bWtkMnd3c1B3b3loVTF0?=
 =?utf-8?B?eUYxNUt4RC9iWE5qMVB3RmwwZHBtempHay85VFl2OEFhdjJXdXQ3Y3dteDVU?=
 =?utf-8?B?SVlNdnozVzlDRWp1K01jNldYZ0dzMklmcXp3akRITGFQRnBhN2FBdHR5YnVm?=
 =?utf-8?B?ZE1WSFc4eVZTUWlDZFlyemU0eU1EMnNBcjZUQXJQdTF5U05zWUJtR2pYd1Rx?=
 =?utf-8?B?WENPTHpxZzQxQzJMOGh1VEJPbEpxbGpGRGJRZjBsb05FTXIrOXZCLzhxZTRi?=
 =?utf-8?B?alBSWE5uQnIwKzdONTlLM3BNL1VSY1NsbkhGK3gxWFBkdHZ2dE5kbTRlaUZk?=
 =?utf-8?Q?G2QgjSLx/faQlzezB6Lme6g=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e4face8a-d905-4c6c-1322-08daac1ec772
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 06:55:42.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZfK55SDugZlO8iz4qc7hOY5wTis3S34poh6/Z+NjkTaMr9RmtfuObH40YLkEOxPns2s+TPBtUmRBey4V+Xb5NEb7NB3435SU0kmLWupK+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5986
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.10.2022 00:17, Nicolas Graves wrote:
>On 2022-10-11 23:54, Nicolas Graves wrote:
>
>> error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
>
>And I can confirm that it was this error and bad configuration, sorry!
>
>> error: Couldn't load public key sk-ssh-ed25519@openssh.com AAAAG[..]zaDo=: No such file or directory?
>
>This error is not very precise though.

I assume you have specified your key in the git config in user.signingkey as 
the literal keystring?
If so, then you'll need a `key::` prefix. Otherwise git will treat it as a 
file path.
See 
https://git-scm.com/docs/git-config#Documentation/git-config.txt-usersigningKey

In the initial merge of this feature, git would allow ssh-* keys to be 
specified without the prefix. This was later deprecated and not all 
Tutorial/Docs you'll find online consider this.

Cheers,
Fabian

>
>Thanks for your help!
>
>
>-- 
>Best regards,
>Nicolas Graves
