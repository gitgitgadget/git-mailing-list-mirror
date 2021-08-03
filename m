Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E6BC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F5760F9C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhHCJdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:33:40 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:63716
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234707AbhHCJdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 05:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUHA0lkmKjeZ/OLbYgAnootu1xEvvnCzTPmwvIfRVk2G4voCZS14jjF3f0wlQLYIJJx3aYj/3wgpnhAYS0S1s0AhSQx2TAjYmNMpudo8ZA3ALUF8NUQiHBB4hjSFFNRNK953pNfK+50Flf8ye9+7B5xToVKTmATclcwtYK7XHSrBdtst6R40YGSJzUzD3BQYEcQf3ZtX/RqxXaP587HJO6T94NVJOsEqLMEoilJ+49LuivkvrucWKFHqP6H5TXBdps9Z4zKdq7hnZ5Y13BWzoDi8Z+6tcQ2o2TgPV00igB9x4N8BB8e38TpyJyXjSpp01T11/8Q7lExbBbsqtcFECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYtijNXOWGLaysl3UJfjIjIWpZR4RlGc2dbN4nf4NJ0=;
 b=lu4WwLpZB/pYgXbtHUUajn1XaSLv/m04r4XZ2IM4YNhxbhS53fZpGXYS5qn+1ltLCXCXWRh1lWe+31y3wXDtknjuK5ZGmejblt8Iomo2G+tBFG9hA3ZI6liW5Oz/137EjwWN0hiaj4+a54GdNyPEMTW58+qGEa/nuyxJAw9u4qgsQXz9nuXTC5Hwg7oWwi5CN7pgPIAd4cZeVf0ozDcbfD18mv2zYUq0bmvUbfM228pR2t0JDplTiwWn4QG7emVzXHs5tK/EkS1BOakDBCJnusrEzGkmCeNARPYuBC3H1BZbz4xZ+ikWfRpvrk3pIEbdTs8AYJL3BgPeQ70LgmyXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYtijNXOWGLaysl3UJfjIjIWpZR4RlGc2dbN4nf4NJ0=;
 b=E+whevLJVwrjEcvR7hns7mIH50LV+3G9XeOYZ59z21XpdNRG1STL9qIUjpVJdoCGrZSFGxhQRafIgXRJNzJui7gWQkSbXWm3IEtQwU8S9piK1txLJwXTogMUPmGQGG0X6rOJVRKtDqQiDbO6xcUegiAc7a3g4b5iXfYSP6KVKS0=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 09:33:25 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 09:33:24 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <20210728230452.2719333-1-jonathantanmy@google.com>
 <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
 <76cc0f7d-90d9-18bf-e749-feff8e584453@gigacodes.de>
 <91adff99-5f56-643d-e328-472256dc60a1@gigacodes.de>
Message-ID: <46c2a269-132d-3209-804c-c7d4c80ea083@gigacodes.de>
Date:   Tue, 3 Aug 2021 11:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <91adff99-5f56-643d-e328-472256dc60a1@gigacodes.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0255.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::27)
 To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0255.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 09:33:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfef7853-5219-4f09-b843-08d95661bddd
X-MS-TrafficTypeDiagnostic: PR3PR10MB4221:
X-Microsoft-Antispam-PRVS: <PR3PR10MB422147B2C45138E2CBDB78DDB6F09@PR3PR10MB4221.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H80gqA4ttUdzFlsmBYjAVNQgMDOmjhWKkI+XoIofFworVEOR/QOVePL9S1kR0KeudzFYuaixNmjeRvfof4v4hqfUsNuNuwX9pfCnEx+mguS7E2ML6GD8Nf46Ul7DlZVZSAi2OM4GGROefqJcQhD75+XIbmbtSTvBUJyfMu3lpov6cuKExj9cGMVoA1DyOZNDX08XRjXO6ajCOeEMecktsizdNWZD9Td8ELw/AxXjnHM9wztbt57+mLRvpp9hDfRE2r5GoTTn4b29USlRozdNGEEkldAz9B1krFUQxLrJrdyrMZVxn3wfB2XZw90jLxxaeDnJruLtkGtkkA7aXMIds45IxZbIaB0mGeankTeKGaUYlKCYBTjtQyR9yP3mOPqLit8PtuOPXsgkV/bKdJdf1FlJ3zYmCp45JfeYGfad6BeHB4js22kj3VHQHFvrWITUC70yeqYOk6rLzHIu1uLV4YH6p+nMdpzvQHZxzkBa896CL0XZj24uF6ZpQ4vh5MKAK2Q67SULIvwv/mC6HQ07mLe6C5IbehF9G1srPxMyH76x7ZGi3W0rq2O6QxVhWl2bZ1K1T9IOyPBJWuclbcxT7wOe1xEEv3iwZxMVzPcZ1GVtVpP3ro3p7LQ09XzaInC892W5JzVrGewNUF2g6pIh55JXTK6EOVgUKACTv7gLyakytqEkHH+3Lpbj9udZSUYota9LtTsOVU/P5vrN5H6dSk285fWva8uLNWlflrJoekpTpvnYZXsJeij+++RhG7OY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39840400004)(31686004)(66476007)(83380400001)(52116002)(478600001)(5660300002)(4326008)(66946007)(86362001)(6486002)(316002)(66556008)(15650500001)(2616005)(36756003)(2906002)(8676002)(7416002)(38100700002)(186003)(8936002)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1l4MnBKTW90SEdQUEpyekVtUjY1TzI5U1BtQ0RtR1d3UkNQNDQxaWtRRGNJ?=
 =?utf-8?B?bnhBeUFZQ3B3RGhjcDkzb0swK3dDbEN2T1ltdjFZdGxBMm9YVDZFUWhndWRG?=
 =?utf-8?B?TnAwcVlaT1FHZnZBYll6V3FtR3hKSzRjZkJXT1lxZzdkd250VHpyVFREVnhU?=
 =?utf-8?B?NkRrNTdPTGRNWnVNdWZXNFRHaXFINWtsNUw5enh3bkwwTkc5S0JLT1hhbDZG?=
 =?utf-8?B?dU9yZTkwNTFuUGxpQXdWQ1U0UkVCZHB0NDJuNHRZaURrRVQ2MXRpcXhwMlpF?=
 =?utf-8?B?S1kxdG1aR2hsM3ZMbWw0b1NxdWk5bmtoNUxxYm1WZ2JIOHBXTTg3SzNHellZ?=
 =?utf-8?B?L3FYbkoyZGVBTlhIUEdYaHViNXRvdEVPbnk0TGhpUVROTXlmWUY1RUY4blZL?=
 =?utf-8?B?TWRuZlNDbU1LcFNwd1kvMUNmN04wZlhrN3FPNFFhL3hJN21tUEtNeWlKb0ln?=
 =?utf-8?B?QkpQc3hkZHZDV2FEcGFUMnhRQVV2eE54VloyTzMrQy9rZC9XK0VjZnZzYUlk?=
 =?utf-8?B?c1h0L3J3U25jTC90QWlQbFk3d0EwQk85VTZlSGFiQndYMzQ3bTd3aFNmaXlE?=
 =?utf-8?B?T2NhaFkxQVpzMnM2QmNkVWNtMmljbkVWRmxrRElGVUZsbkVuZ3Z3M1VnM2hJ?=
 =?utf-8?B?RFh6cGFRVVYvdlI5YVpCcmUwWXF4bkpMTEdhMXEyQXRPbXFIK1Q2Nkl4MkJB?=
 =?utf-8?B?dE4yZ1Yza0FoZXBMTUwvOFBualFFaHRUUCt6dGxaeHROSmdJUW83YVFUOEFQ?=
 =?utf-8?B?V1cvSXJrRDBFS25qUVpmaVp1VlYyREsvamNYK2svcmJPZFNjb2xKWFllb094?=
 =?utf-8?B?ODRpejFtbHJKamlhK1BsNDZCU0gySVp6ZW82UDlhR0FCMmFBUUF4V3huV2o1?=
 =?utf-8?B?RTExVStzOGhxQkRpM2ZIZ0MyQ21ZN1M4dVBDKy9SYjJmSXRTL1AxU1N0cnky?=
 =?utf-8?B?UTQyYW1YeUJwOXViR0xYa2NBaHVjOGR2ODRGdzR4QWFTQ0FLSWtYbnFlekpD?=
 =?utf-8?B?VGJSMWdXa0E2ZmttQURPOXFUdEg3cHpMYkUwa25PYXdEUUd5aytlS1BHS0JX?=
 =?utf-8?B?R3pIY2NzNXUwazRnTjVVdjFJWWJVVzBOZS9uazFhN25BSVQxdWNFR2k3MFA0?=
 =?utf-8?B?YU9Kdzl6SFVndEVQUXpsY1pZYm9DQ3FzSE04eXpkZmpLZTNRdmgzcXZ5Qi9S?=
 =?utf-8?B?d24yT2lqZzg0Nk91dWwwL3BObmQ0N2hWUDNlNDk1dXhrSjFJbDV4QytQWFdt?=
 =?utf-8?B?NzBmQlRCYmdiRzZDU3ZxdXhqN2RPaVZnY2o5NU94ZHpRdHAzTStJNzJHTEJI?=
 =?utf-8?B?SUFUTWw3R2txNTNwM2xWWUc4RENYZzU3dVNnL2hPNTFYZjhXNWFBTGhXSlQ4?=
 =?utf-8?B?UEhZUTNxQVR4bkZUTUVYUUlzdEtYMnlNOC83U2xkSGJkWjN1U21hMzBiaU8x?=
 =?utf-8?B?a1VaSFBNbElXMTV2dkNlT1NGNXN5R1p5dU5ZWlZ1MXZXZlZmMkpNMG9KVFFx?=
 =?utf-8?B?WVJxNmpRQndsYkpYeDhzd1Mwc3llQy9wUzR0VHp2Sm9HR2VRWmZqL0lSa0pl?=
 =?utf-8?B?bE9rS29zTlBMVHlSYW9lQjJUQURNM3lmNCszVlFwZ285NXZiWXRYd2gwWXcv?=
 =?utf-8?B?WHBHTkVJQ0FJRnpaWGpRQnZ1aGYzWTd4OThSK3NYcXBnZ3FjU1BYM25CQTky?=
 =?utf-8?B?T25pSUJscS9Oa2dOMHNQRjVMTEt2a1dNaEdScTZFUUFhb01lMVE0SlpuZWh3?=
 =?utf-8?B?VG5qdmx5S2M0UElMK3hUeW9DNHhraDJ1REdrNEwzZ2MrZGFUQk5RQXp6YnpZ?=
 =?utf-8?B?NDcvOE5tQUVOZERyYWNveUlzMzREdlpJYnIybnM0VDZCNmZ0V0FUS2UrMHFo?=
 =?utf-8?Q?aYceD9J9Tbb44?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfef7853-5219-4f09-b843-08d95661bddd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 09:33:24.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8os/3cg4P5uEhx2VNPDoyjdSr1ceNUeI/HsOxPWWlKkCLF17lOOL6q788qBNXJwdGxc8PL2gisZTJDvz4vEEh64aya8KPqNcBnxhEKNMrlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4221
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03.08.21 09:43, Fabian Stelzer wrote:
> 
> 
> On 29.07.21 15:52, Fabian Stelzer wrote:
>> On 29.07.21 11:48, Fabian Stelzer wrote:
>>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>>> to verify a ssh signature we first call ssh-keygen -Y 
>>>>> find-principal to
>>>>> look up the signing principal by their public key from the
>>>>> allowedSignersFile. If the key is found then we do a verify. Otherwise
>>>>> we only validate the signature but can not verify the signers 
>>>>> identity.
>>>>
>>>> Is this the same behavior as GPG signing in Git?
>>>
>>> Not quite. GPG requires every signers public key to be in the 
>>> keyring. But even then, the "UNDEFINED" Trust level is enough to be 
>>> valid for commits (but not for merges).
>>> For SSH i did set the unknown keys to UNDEFINED as well and they will 
>>> show up as valid but not have a principal to identify them.
>>> This way a project can decide wether to accept unknown keys by 
>>> setting the gpg.mintrustlevel. So the default behaviour is different.
>>> The alternative would be to treat unknown keys always as invalid.
>>>
>>
>> I thought a bit more about this and my approach is indeed problematic 
>> especially when a repo has both gpg and ssh signatures. The trust 
>> level setting can then not behave differently for both.
>>
>> My intention of still showing valid but unknown signatures in the log 
>> as ok (but unknown) was to encourage users to always sign their work 
>> even if they are not (yet) trusted in the allowedSignersFile.
>>
>> I think the way forward should be to treat unknown singing keys as not 
>> verified like gpg does.
>>
>> If a ssh key is verified and in the allowedSignersFile i would still 
>> set its trust level to "FULLY".
> 
> i dug a bit deeper into the gpg code/tests and it actually already 
> behaves the same. untrusted signatures still return successfull on a 
> verify-commit/tag even if the key is completely untrusted. my patch does 
> the same thing for ssh signatures. i'll send a new revision later today 
> with all the other fixes.

oh boy... sorry for all the emails. the gpg stuff can be really 
confusing. especially since there's different meanings of "untrusted", 
"unknown" and "undefined" depending on which docs/codebase you look 
into. Especially "untrusted" is not really a gpg term but used in the 
codebase in tests like 'verify-commit exits success on untrusted 
signature' which tests for a key already in the keyring but not with any 
specified trust level. I could not actually find any gpg test for a 
signature that is completely unknown. (i will add one)

GPG does a successful verify-commit/tag on keys that are "known". 
Meaning that to be marked as good signatures all you need is to have the 
public key in your keyring. This key can still have an unknown/undefined 
trust level (meaning its in the keyring but no decision on trust has 
been made). A key thats not in the keyring has no trustlevel or anything 
but fails hard with "no public key".

SSH signing does not really make this distinction. A key is either in 
the allowedSigners file (and therefore trusted), completely unknown, or 
revoked via the revokedSigners file.
To make this behave like gpg does i will make verification fail on 
completely unknown keys. There is no use of the undefined trust level 
for ssh then and i will set keys in the allowedSigners file to fully 
trusted so they will be accepted for merges as well. I don't see any way 
to have keys that are valid for commits but not merge with ssh then but 
that should be the only difference to gpg.
