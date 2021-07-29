Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745EBC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C9C60F0F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhG2V2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:28:51 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:6968
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229510AbhG2V2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko4O/w0FOHBMUR/vWhChGesckXkx3ezb2I013gSFBNFdStGC/7igui5EGPSbTqKHmRuNXS11VAc1I6zJ0XKDl7pCEv7kMIwNY1nD2NVUjxgLr4zskLR3Z7i2CoXZdPdAN1bbvsdavJp6S5l/idBD9rgEnTRPbhYzPIDP8wktTTHmBwdA8GziK5el7U73xGyOR2JQtrRaoqo5kTZQ6Lf74VYafJMghv5pArONXl3fUBC1ACwHvo1OrtvH9SoxuXoGofGQSjtKHKtIangdQeyIlhvF4fGYj/LHGs69EiB0dp5AXIJUULvGRGq+4hofqnfn9lM51q0EX2RibwfSScbTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElYxfTzIC1E0P8XvHK0nDXesO+WmfzxTgbCYBaGlgQo=;
 b=FB6LHBAXZE7JvIqTXZzu4/G8hM6XGvkaNd9WfsotpkOyVXBCwO5CA5ey6Ocd+JNGZ2fdNNy5tMiasdWUJiz+LnPV8UXAUnjWPE/+EqsrA9/r1ckHYSAZrmxpXsfibPM8eztXldRXJ01olbvguuQUw6TZYjkJmOu7AS2r1MXnGKnFpRs5NEDV5dPOatzmXJo4E/tTJWlC+CGWe1ntSEJJUcvyfrjQqIhKJXXmPERFl4AeiZTL8iBEISGzmiuua3iBNZY3GoSg6GAXFM7Gq3vSfRQnX4hMx/7yhCl+VCD3VmOcBtYgLNm/DM0QPaquK6Y3uShGldelxZ4WRnWIUrmn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElYxfTzIC1E0P8XvHK0nDXesO+WmfzxTgbCYBaGlgQo=;
 b=OutdCYp1SjOwPdRLCE02jd7xvq8wGNh/Y7Qw/UM7UkOO/1VXaNXq2IFCocpC7/+aSVup9SQIJoMN/GT591igKTooZ569mFL1QKs1ZDZU4zGReGc0Otm1X4TW9u+oLniceset+lW0ij+G+cr0NDScYvIFbDn+ivevwqYSJRh3DV4=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Thu, 29 Jul
 2021 21:28:45 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 21:28:44 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
Cc:     'Jonathan Tan' <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, bagasdotme@gmail.com,
        hji@dyntopia.com, avarab@gmail.com, felipe.contreras@gmail.com,
        sunshine@sunshineco.com, gwymor@tilde.club
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <20210728230452.2719333-1-jonathantanmy@google.com>
 <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
 <xmqq8s1o4zn8.fsf@gitster.g> <039a01d784bc$e92568a0$bb7039e0$@nexbridge.com>
 <8b8fafad-0c49-0d17-b8f4-3e797a3fc9b6@gigacodes.de>
 <039b01d784c0$518b7440$f4a25cc0$@nexbridge.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <ef39f1f8-9da1-25e9-ec30-b7023705b58a@gigacodes.de>
Date:   Thu, 29 Jul 2021 23:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <039b01d784c0$518b7440$f4a25cc0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Thu, 29 Jul 2021 21:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a711047-ace0-49c6-9b10-08d952d7d81f
X-MS-TrafficTypeDiagnostic: PR3PR10MB3788:
X-Microsoft-Antispam-PRVS: <PR3PR10MB37888EDFE62122A1B88A5CA8B6EB9@PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJnDbQugHmNqKEUCfBS4HHtC/CXBv2Gi3Sbe/5tnp1OnFa8Qcwl+l1NJ57ail+oCeqEL3fCOFdrejIq4eg8Wos7nX/3h0NsWtkLTP+6hUQG89kMVMXOf9q9b6ZiL+7wYpyOourp0AMjFc726/QQNSRwky4QQ0l80eAYvvFRdseVXroFC9Zc7R57WGY/Tz7RA0iXnesWnpuzrIZxkMt6nk6CPQx7PIZfHDGTOFJTBHQdgKyZn53Da4yjbEIfu5F++CLwS1YBvtA/YhCs6M8QMUsaO/zYgkaeRPKDkTnVRSHTSGbGYWhKro/ndvGfhYnaP3SRI20h3A0ZhaHdPd+dn5lcPuOOGqZgiEVD0awp2AhamVf2n2XESniCBceWXkdm29AAuxS9BxAYoomTdPCO8PNhNaukOqG/mBbu2BTnDTtBkBAmDp/sqXr26asH4lsBfGswo+fhQK5S83QAmqqLmAntM6l5C6dl5Vd5+iJZhm0H61pRbzH1//UW6XrrMrnsY3l2RGPgUlvsIjg/BsfW7kIfwZDVKjUwxLC8Rc6YPJBrBdacajpWkNBJoK4dUuk4hnFGXTjox4tcA0rH+TPvqbZduhTotuq9kphGSevSC9ORRamdMnxh+SjjcWLNfBqu81gpEAmEIkZhsQyPFbCQV/w817lNFoZNS4O4GJE0VJMZgbrQVQ5cQGp/r39T7M75PJ4zR2t7ALAj4hF2ouxu8Tww6gsEwhecQqFm11vTwAYIlJC1cQ70MfmjUTi/qRgUk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(396003)(366004)(376002)(136003)(186003)(8936002)(15650500001)(66946007)(316002)(110136005)(31696002)(38100700002)(86362001)(31686004)(36756003)(66476007)(4326008)(7416002)(83380400001)(8676002)(66556008)(2616005)(478600001)(52116002)(6486002)(2906002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDh3S080S1VxV1NPbFZxRWt3NHNVU2M2c0FNdjdYeU5ENHN3MjZwem5KZUw4?=
 =?utf-8?B?YVlEczNBZ2FuWHJJOU5pM2x1WkU3Y1p0T0VrVUZ4bVZHODdHVkxaQTdPUGNN?=
 =?utf-8?B?SDkxQVBaS1B1ekd3aGJmNCtESGJGSHkvVmpFaHdzbkJOWFFVUm8vSHBxc1NK?=
 =?utf-8?B?b09OZVhEeG5lVUFXTmpmdGswNmQvejVjNlpHVDNFVlFURThVenRXM1hyQjdq?=
 =?utf-8?B?aUJSazI3MGNzaUhJSnhOODlHNFY1Z0o3TnNXQ3JDRmZIUzcxRzBEWUExRkVG?=
 =?utf-8?B?aTRDTGUvdUVwbk1VWS9hS0NoYm5sT2J0dFBaa3ZEZFFKcjB0SmQ0MTdteXRa?=
 =?utf-8?B?SmR1WjdnQ1IyUVI5cit6QllKTnZiazRxUXlnSTgrVE9OdTJiWVBQYnBHRkth?=
 =?utf-8?B?blBEd0lwL0M2eFl6dmdFcDRzVXBHODh0YzFGdHc3RWxHeDk3ZG9QNng5TEVq?=
 =?utf-8?B?bFNTNnNkWXVMYWVZMmh0dnBQcitLbG5GSjNueC9lbE9BVkgvVTZwYWh0K0xL?=
 =?utf-8?B?NlFMS0lsRVF2UGFsRDM2ZW0rZFBOWUN6dHh1MHBsS0Q1KzVrRkE0TWp2Ungy?=
 =?utf-8?B?RzFjcC9XdEt2QXhCZGRFSFYyZkMwUW1CaEZNMWVSMi9Rcm03alAxUkdmcmQr?=
 =?utf-8?B?a3ZnMnZiWkthVEVTZkZkUVNjV00zYk10NitlU2xBc2ViYmVONk1sQ2hDY24z?=
 =?utf-8?B?YVkwQlJhLzBmNnJoQWJza1FWb2l3d0J3V3RrRlFEZUJWb3RnZFgwU285OXM0?=
 =?utf-8?B?bUYzS204M2RPb3hvUGZxcFJEK21mZ2Q0QUYxVHdrT24wUDZNR0pZYTFxV0Rq?=
 =?utf-8?B?QStLYWxGaEZWc2pZWkRiZ2lQUnJoS3dkdTE5NEIwRXRLNHV5RTlUT3pUSlBX?=
 =?utf-8?B?SzMvMUVwUFhpN0JzOERQZzBHdDROY3IvNWxPZG55czFqcHF0VGFXUnpqRnB4?=
 =?utf-8?B?OW5KVUVCWVZEbzA0WmVqb2FYa2huTXBNV3h0bXVTQm1Mbk8zK25KR3hOeS9t?=
 =?utf-8?B?R2c4d2pmT3N4cWFJZ25nZW4zYTJwSDkzaVlyanJUdVBJeHJwbFpwT2tQOU4z?=
 =?utf-8?B?NmVTdmNubFkrM2V0WjVveUdvU0VKTjQrNzR3OENONnhCUEZaZXNKUEhrWDRG?=
 =?utf-8?B?ek5VTHEwUWZ4RW93WTJPUjB5NTRDL1ZpVnQveHJFaGo4akxWbkdvRmliMkRQ?=
 =?utf-8?B?eTRlbFVBOHhZRlhjWmdyMjdDUjlpd1VyMFRhZUlJa0RIMndjZllGQWhNOVU2?=
 =?utf-8?B?RytNMHEwS09Oc0ZIVkkzdUlLSGxPazh3SG9XNmpXVmQ0SUVjNkJNZU1BQmVC?=
 =?utf-8?B?eDl4NUpFMGRQbUdwTXM5VlZzSzZabEFjMVc5NEJhRlhxdjFNZzJLSFFLelRl?=
 =?utf-8?B?aHBuYjcvMVo2L2NHZkVaeVlTQ00vTEk2NGJaN2xKZzdlR3VnSi8vQnBUOW9z?=
 =?utf-8?B?OUdwSU9jSzlMbnJIeFNpZk9MTXhMc1pMSmJlOTJjUUtSa3Q3UnJDWVdwWk54?=
 =?utf-8?B?SXp0WFNOdFBQV2NZTUdFK2JVMGhuNFUrc2QzdTB4b3M2RHA3MjZMd285ZUdJ?=
 =?utf-8?B?MndQR1FBSko4cWJ6dytBSFl2SlBMY1R4REZycXRDdVpxZ1VadXdWcGhTcTJw?=
 =?utf-8?B?TktSeGRwc01pY3NDRnhzK2h5KzRHWTg2eHQ3VU15QjNvekhNc0VzWXpvbjZY?=
 =?utf-8?B?cS9SM2NEOCtvaHEvVkxlaVJDYUVJU2gyMXB6MlVReUJQSFJ1U2tzSEc5ZUZP?=
 =?utf-8?B?UFZnVWtlL0N1azVRMVJFVFBCK3ZiYk53ZjhlaFVnWTIrbWQ0OHU4NGpGcFg1?=
 =?utf-8?B?cElLWXVJWS92UEFrb213U2RkVkcyMkpnMnhPZlo1V09uTHNsMHZkcmZTOHpr?=
 =?utf-8?Q?p38BIMWtoEoaC?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a711047-ace0-49c6-9b10-08d952d7d81f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 21:28:44.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8/fbjzboLuEA1TOTJSOGNauQFxTZFQzDbQpjUduZR+GwHiZdvP1fKiAL9KIQNZX0Rq898/rO06f9iSLHoKoT+hwN9UhrCaezb2Z+FPDQpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3788
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 23:25, Randall S. Becker wrote:
> On July 29, 2021 5:13 PM, Fabian Stelzer wrote:
>> Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify signatures
>>
>> On 29.07.21 23:01, Randall S. Becker wrote:
>>> On July 29, 2021 4:46 PM, Junio wrote:
>>>> Fabian Stelzer <fs@gigacodes.de> writes:
>>>>
>>>>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>>>
>>>>>> Also, is this output documented to be stable even across locales?
>>>>> Not really :/ (it currently is not locale specific)
>>>>
>>>> We probably want to defeat l10n of the message by spawning it in the C locale regardless.
>>>>
>>>>> The documentation states to only check the commands exit code. Do we
>>>>> trust the exit code enough to rely on it for verification?
>>>>
>>>> Is the exit code sufficient to learn who signed it?  Without knowing
>>>> that, we cannot see if the principal is in or not in our
>>> keychain, no?
>>>
>>> Have we not had issues in the past depending on exit code? I'm not sure this can be made entirely portable.
>>>
>>
>> To find the principal (who signed it) we don't have to parse the output.
>> Since verification is first a call to look up the principals matching the signatures public key from the allowedSignersFile and then trying
>> verification with each one we already know which one matched (usually there is only one. I think multiples is only possible with an SSH
>> CA).
>> Of course this even more relies on the exit code of ssh-keygen.
>>
>> Not sure which is more portable and reliable. Parsing the textual output or the exit code. At the moment my patch does both.
> 
> What about a configurable exit code for this? See the comment below about that.
>

I'm not sure what you mean. Something like "treat exit(123) as success"?

>>>>> If so then i can move the main result and only parse the text for
>>>>> the signer/fingerprint info thats used in log formats. This way only
>>>>> the logs would break in case the output changes.
>>>>>
>>>>> I added the output check since the gpg code did so as well:
>>>>> ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
>>>>
>>>> Does ssh-keygen have a mode similar to gpg's --status-fd feature
>>>> where its output is geared more towards being stable and marchine parseable than being human friendly, by the way?
>>>
>>> I do not think this can be done in a platform independent way. Not
>>> every platform that has ssh-keygen conforms to the OpenSSH UI or output - a particular annoyance I get daily.
>>>
> 
> What about a configurable command, like GIT_SSH_COMMAND to allow someone to plug in a mechanism or write something that supplies a result you can handle? That's something I could probably work out on my own platforms.
> 

This is already possible by setting gpg.ssh.program (although you'd have 
to pass the sign operation as well)
