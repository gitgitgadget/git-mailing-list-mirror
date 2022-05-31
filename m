Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BEBC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiEaOrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345293AbiEaOrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 10:47:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E949F43
        for <git@vger.kernel.org>; Tue, 31 May 2022 07:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ1ilonqnZdW9Q/i2HNlLt9AKQttWQ6zMIS7ApO4H94JEOptoNQ0+EmIHaJunrd0gBjV1Kvl6GrImou7Q9f+BgG84T6SVHg3glQR+pB6o3d4kNtLjjZhbSF/ECYdflKFKgyuafGxU7Lj0vYaa9suFfvIEJmdKYIBPaC9Pa6omfpOiyVmDuQlTr+hA92ePC7eh/tNiyJp8V3zcM+fONZcyPrsiW3yk+swUmul7mQL26Am3IqKTAqAonMIOf1ZJtwDO7WQjPooyoGCYbWEA8CZ1aTna27dMj3cbxe0H4L7shSyai6+eZ0/l/jrkNF67MJ/gMB1BJDHh0X1urC7Xfz26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTgj2OFsSzhII3nw6wzVDDoxempLgwZFBzPFXrXaAZc=;
 b=dFBGKr+I0qm+FEwg0+W7z670Lb9J+/7WOlrKByshhOmHTtrif/U49UMZhjzL9bvdbj5GTyYSmCXKg9eic0GdIlb/v4YpdrTiyvx82wsvx9U63DNwF0dGxRNoVXgfmt1m1LWAb+mgggoRZ2PIMTBCmyvf9FSttWS6IT7OlQ4BijvYnmQIHuZ/qGUcCHf179d0EaF9ILWmeuIlt9HQF9Fa7XXHhavbwD3eB9tp3kb88JYSZARgK2nznqYbCEDrz/ABfHSMveGDqAZJq+zNwBb9ej2808poJ3CuUAZpSzKLfOhxfKkYeZRbuVcx8J8361LkWekRQ4qrKXw40iU1WTwFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTgj2OFsSzhII3nw6wzVDDoxempLgwZFBzPFXrXaAZc=;
 b=Osoqy9CxhDwiWVjTASQvMWCRM2kRk2oXVycCJ/f8dt1Q0+GSkkvTt/QyE+U7I2BYc6rYdcVrXHA5qEVxhDn8thxQI4Ol4AvmFP2GLLeYuI6Oz10CL0torPQvpa7z17YuDFlBDEaMbyRzHYKbZlHAHgqYq7EZpYoCjH7r86Ueypw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 14:47:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f%8]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 14:47:05 +0000
Date:   Tue, 31 May 2022 16:47:03 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Andy Lindeman <andy@lindeman.io>
Cc:     Andy Lindeman via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: Support ECDSA as literal SSH keys
Message-ID: <20220531144703.jbawf3tkypt7se2i@fs>
References: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com>
 <20220531073445.iuovy634ufp5xims@fs>
 <CA+vJLfu1WyqP4V44iyZj+Fyr8O7JSB8tSJfOmS1SeSZ65fXh0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+vJLfu1WyqP4V44iyZj+Fyr8O7JSB8tSJfOmS1SeSZ65fXh0w@mail.gmail.com>
X-ClientProxiedBy: AM6PR10CA0098.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::39) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1535a8-c4c2-4d4d-eb8d-08da43146dfe
X-MS-TrafficTypeDiagnostic: AS4PR10MB5575:EE_
X-Microsoft-Antispam-PRVS: <AS4PR10MB5575B248E92151126D38D364B6DC9@AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCLOv/TpiZ2AcuMXm9NQIra4LP+sQ8KJcW7C/xkbMf1WKHqGbeUJAQDueNabZuD13IG0y6atDF6gkJQZEc37Ba6vZQ1kzi0nwpo0n1FY4EOtU7mILTgsm0Nw9B4uICkEo/GG7ne/KRE9eODSlxOIs8nFLI/eE0JaxUXKpa5r5bVntNJ6jIEjV4hVHr7TyOtETj+y+gKGuGLmPGmbf0dKQWYwQxA4d9NbuDhaWwJl7h1pfTD4j4v3qPu7wS7uXMHqblwRtDhgP5e53hDdFThRxn7ocOiA096ECxlcG6YBFiXtGObLEaqjayLxBNiNAh3MNfM++m6elWSP8XA76vNrOwOoLFrF1YgZ2pDaHyunjMdRp0YFMqjhdkg/ZIuFr/Wgpm/31xVyFj0/QnZAVMOgqmwfu9RoSJchOM6jtMYiSC9maGxKhAIGRcdUKSBbxsxqi/wguo+HcbdiChsHMLrVPkZ4GTXe7wO5Vj5h3kGKEgWwSeyDpGu4DiPC2A/SjEJzDiTla4ueHQWipoexIs3nZQ/D7TpFs7AEwmbaCSxKZ0VX1C+J75eZJCCS8BoFs7TvF8tXLuoSI1uzKc4rXTIQm00AuxgwN07Spm/QUQKsaVMapI6299FM4xwDrSBG7a0qtVidOo/vcTjDHsGfbH+swVYpNGo6Y8s1KWJ/sQzdetsVBF2zKtOFFzRdeaUkrrIPWAwokWlIGaciLMwsK0m+O+4Mw4vOD9veoKJ6eWp+gWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(39840400004)(346002)(376002)(136003)(396003)(366004)(6506007)(508600001)(38100700002)(316002)(8676002)(6486002)(53546011)(86362001)(6512007)(1076003)(2906002)(9686003)(83380400001)(66946007)(66476007)(4326008)(66556008)(966005)(41300700001)(5660300002)(186003)(8936002)(6916009)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FQNi9KQmc5TWtVd2tJNGd0L0xZSkZ4QURKOHZreGZmYXdXaWs3UUNDUkp2?=
 =?utf-8?B?SDRZVVVNbXk0N0c1T0M0K016dFNnZmlmNVBITml1SXp1NURnNktQbzR0d2hh?=
 =?utf-8?B?TGhLTHlyU2VCRDJ6WkRDY2phLy9rSi81c0Rsb0paWmdITUhXeEZZeFBFMi8r?=
 =?utf-8?B?Mk5mMk1sVVFMSEVWMUw0MURpU08vNjlwOVZjT2xKaFE2ZmNWaVVUUGZGUWxZ?=
 =?utf-8?B?VGdSaUt1QXlKVm1nQVRmQ05DenZUUzRDbW9uNllGYTVsWUdtS21qaWVwODE5?=
 =?utf-8?B?dDBXSXZGckdKYVMxOXMzb1JxWnhqeWEwWEJLMEN1TjhmUDVUTkFBRTFvKzAw?=
 =?utf-8?B?ckFROUpXS0JtK1NvQ3d0ODRLY0hWWVF3YU8zeW9zMVpLcG9HNTNTTm85Nmtn?=
 =?utf-8?B?eGZPczVEY0VsY1ptYWRSa1FZK0EzOTVmRHBnejV5U1pwb3BGbmt6bjJYMmFH?=
 =?utf-8?B?d2t3cEVOYjhjM0E5V00zcTJqUXZVUWcySktSR09Gei9mTi9SdHJzNmdUWkhk?=
 =?utf-8?B?dGdaT3ZPVzJObWpxMnl3Z0ZSd0k0ODZVZFZMdnowYW90N1JLYnhJSFp5T3hz?=
 =?utf-8?B?UU52cHUxNHhpR2piMlJHb1g3bmdscFNJRk9LY05pam5LbmxhTGFCQ1R4Qzha?=
 =?utf-8?B?eHVQTmw2WG5rOWhuSTNWMFBHV1dnU3d0MnRpZEdKMDBNdnp2OG5Pbm1CRGcv?=
 =?utf-8?B?MzNpUHlUSEFKbHlNbkN3L0taeW9PWWdzTkxzNEFVWEhleHNRMUdsN1B1K0JM?=
 =?utf-8?B?dFFiY1p2Z0J5eFlEOEJmRnhnVTFYUGVBYWM5MDVVSWNidHpnREpXWEwzdFpE?=
 =?utf-8?B?REdhVCs1UEJURUJPQVd2emY2OVp0TEhrYW0xcSthR1c5UTVQTFdGc0EzRkxI?=
 =?utf-8?B?Tk02TlpJQnRESnNkSEFrVUN0ZVh0UFFvTmswRmRkUlR3SEdEZkpOcWU1QXVI?=
 =?utf-8?B?M0IycmI5MHRWREFZQlZzZ2VaOFQzVUhqYnFMOGZnZmVscW9aMUpYYWpBMUsr?=
 =?utf-8?B?eXA1V2Z1WkREL1p6OWFSamFJSUowRU1VMFdCWTMrMHhVbjBPV0U0OW45ZlZO?=
 =?utf-8?B?aEpnczFEa0ZzMkR1WUFLQnhHNE5rYzg5R3hTenpJdDQ0dEhBa2hhUHV5K1k1?=
 =?utf-8?B?bDFicU9ZbGxtWlJzSm82a3M2b3JmVTlkVWhKWE55Z09pVkV1R09YS0U0a1Bw?=
 =?utf-8?B?Y3VSeTluVTdRSWRKVmowMEdaY1NYSGtyZHNCNE9pQmt5WjF4NWFxMVl3amZ2?=
 =?utf-8?B?YitHU1AwdEtRUEJONUVwZ005eXVhRlllNy90VUpkK1RNamh4NmFjWUZsWHpF?=
 =?utf-8?B?SVJ0R3JZSUJGUUpIZWlwRFFvZElKRHB0OTFoQTJ4TlphUUVveTVJeGFsQWNv?=
 =?utf-8?B?NFdmRGdXMUFVMjRDdkdSd2pVL1RIU05OQlY2V3hFVFBIZjdMRVVBWFFNRTN2?=
 =?utf-8?B?cG90Wm9XUk1nQkFuTWtwU251WkJlQm9tZFlRQUN0alNNVVNDcUl1ZDFwRUMw?=
 =?utf-8?B?L0JnOFZvSFdXQ1pDOXVObGJrNUtvVW9saFlIaWFkRG41dk9WanBlL083RnhD?=
 =?utf-8?B?OGJHUDZXUkp2V3hua2pPNk9WUDB5QVc2OU5mMTRmM2x2QVVTWXRncWNodlJL?=
 =?utf-8?B?Uk1GQ2doTlp0bHhEOGJvU2QydGNjWktoNHZEaDNBekxmMi8yV1ZMYmlzUGNk?=
 =?utf-8?B?MlJnRDkyNUlVUU9xNm92QThrUndzd3FVQjFEbVpxZ1U3c1FWWTFYTkZLUmlq?=
 =?utf-8?B?VGRiL0M5MUZxRERpdHVEak0ybGZSdzg3blBWOERpaFRaWk0wZ21DWUltbjFU?=
 =?utf-8?B?L3d0RHVqRG5zN091dVBWb0RVNHkxc3NnUmZYVTZ5ckxyVjdXVkUvWS9DaHVE?=
 =?utf-8?B?QkdOVitMaDF3WEtoazhUUXM0am80V2tyQjBablNjaWNTWnZtbkZxbmVRcmJK?=
 =?utf-8?B?Ujg4a0R3aHlKVEtxYXVBNWI2SW95ZERnaGpvazlKMmRFWTY2ZVVpdGhaZ3VH?=
 =?utf-8?B?QjdoL3ZhVXZ0bHpJSWVSM001WXp5UkJGSXg5MitVUDE2a3RuMERZb0Z0TVZU?=
 =?utf-8?B?OGNhVTV1c1FTRlk5VzVlMlFkNVh1NDE3WHc1U1NRSU9kZkNaVXFiMjBtNEt3?=
 =?utf-8?B?dElHY0lNdVZIVk9nd1JaTFNCcncxRGlhcHNxM0RwYlhwejNscGZoN0cxTW9J?=
 =?utf-8?B?UnUxSjE5cGRiYUU5RldmTEc5cWdvMWVhM2xUWlJJYnFaQ3lOSkUrd1hFRmNk?=
 =?utf-8?B?MkZ4SkVRZGpCSjViOHk0RERFYmo3SWZNVnE1cUhYZmtHcHR3bElVWHdzNU51?=
 =?utf-8?B?R0dIUy82VW8zakJwZkM3VlFUbFhvNk40UjZVOFlkZHJ2aFRnak5DRmhlT1Ns?=
 =?utf-8?Q?qOhLnvvTdCjR2DVQ=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1535a8-c4c2-4d4d-eb8d-08da43146dfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 14:47:05.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z727ElYQlBmPo5fn9CRCRF1wqMeZesiQE1t8CJaZ7gM/Zjv/QLucqtp3HfYWIdY50Zhku1RH17NC6LVad5uNzwN7BXF6Pwhmsqi6wHBGALU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5575
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.05.2022 09:28, Andy Lindeman wrote:
>On Tue, May 31, 2022 at 3:34 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> On 30.05.2022 17:45, Andy Lindeman via GitGitGadget wrote:
>> >From: Andy Lindeman <andy@lindeman.io>
>> >
>> >Keys generated using `ssh-keygen -t ecdsa` or similar are being rejected
>> >as literal SSH keys because the prefix is `ecdsa-sha2-nistp256`,
>> >`ecdsa-sha2-nistp384` or `ecdsa-sha2-nistp521`.
>> >
>> >This was acknowledged as an issue [1] in the past, but hasn't yet been
>> >fixed.
>>
>> Hi Andy,
>> thanks for your report. We have decided in the past to not explicitly cater
>> to every key prefix and instead use `key::` for literal keys.
>> See
>> https://git-scm.com/docs/git-config#Documentation/git-config.txt-usersigningKey
>>
>> `For backward compatibility, a raw key which begins with "ssh-", such as
>> "ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa XXXXXX identifier",
>> but this form is deprecated; use the key:: form instead.`
>
>Thanks for replying, Fabian.
>
>My main issue is that ecdsa-sha2-* keys currently seem incompatible
>with `gpg.ssh.defaultKeyCommand = "ssh-add -L"`
>
>The git-config documentation of `gpg.ssh.defaultKeyCommand` says:
>
>> To automatically use the first available key from your ssh-agent set this to "ssh-add -L".
>
>But this does not work with ecdsa keys because each line of the output
>of the command is checked against `is_literal_ssh_key`. Because of
>that check, keys that do not begin with `ssh-` are skipped.

True, this is a bug.

>
>I could certainly write my own shell script for `defaultKeyCommand`
>that did something like `ssh-add -L | sed 's/^/key::/'` but it's a bit
>awkward.

I think this is at least a valid workaround for now.

>
>The code that runs `defaultKeyCommand` states:
>
>> /*
>> * We only use `is_literal_ssh_key` here to check validity
>> * The prefix will be stripped when the key is used.
>> */
>
>but this is clearly not true because it is rejecting valid SSH keys.
>
>Do you have thoughts on how to improve `gpg.ssh.defaultKeyCommand` for
>keys whose prefix is not `ssh-` ?

The problem is that we do not want to maintain all ssh keytypes in the git 
code. Thats why the `key::` was added.
I'll have to think what we could do besides just skipping the check 
completely and just assuming the defaultKeyCommand will return a valid key.
ssh-add -L is not necessarily defined as having a parsable output and any 
additional messages it might print (or some pkcs11 provider) would at least 
be skipped with the ssh- prefix check.
