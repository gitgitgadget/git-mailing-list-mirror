Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF8C432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 08:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB9F60F41
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhG1IT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 04:19:26 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:22274
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235390AbhG1ITN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 04:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg9sCqc8PxXGHA5zQ4GnBnn63LpqTcteD0joz3AfyEnwqO6MKhhShivnm6YjwdQkY6o9GCI9C/3R+HE64PdlBGaYCJmhWnjBUjmD8023NTsN673NAug2x/X5AHL4gq3XiTRwC4ldPsztU6zOgWLC49MgDGgFOlALcPo5SuRVSfge912x/4w7nmTcJ0J4fCNtqeVBOWxI1iucFLXueu2UBkRMuGsmrWSe6dQt0x9n9ZQ7IGPiXBfwx/0AVxvSJqCDZiy29SwX8F2PYCNTxNBHOt/OI6SV+JLm46v3K8A333VOz6WzDctpLFc+WAIGM2+9vdjEYFYEGntMGCUQCY9cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFqC0Sb4m2+flqRmYlxsNv0ivQ+Ce4VTRbSUnvrnmgk=;
 b=W/Q6XDAm9Ybh13I3AYg0wz1TTdQbvkWLlK4fDfaElxfcGdkCb59NdlytTvvQqdBDU+B0o7oxgps4K2g/ZbeyrTpNDV7OXgJb5qRTLvTfEo9hxgj4kqNcnwU8P1OTRsuDotE/OAFlaIvG/DWlnaI8grYJCS1OyqOXcbNXGxxgzeshldMWw6q5VH5oz1RzcBZBwlEA4g23Hng5PY/+x8u/sASowATMsv0tWHZirH5excb43fzUmpoVV1rNvcnjF+LjH073DEcMuJ7YIKEFrP7zhZ7bTGXsu8FvQquS3/GHynvQQThf2pF6XLECAsggi3Kq1B9zNiG9JN4O6eyCR54pBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFqC0Sb4m2+flqRmYlxsNv0ivQ+Ce4VTRbSUnvrnmgk=;
 b=wKXbPTXToTUKX1gKIyu9fWJ3tEoTlDOdv4SPoXoKJcNak5vOF5LW000oLvAP14jjPh0TKzIKLREB82KuAS0WD2wfAkc1mGzrgeE6rsnx4FZNUlTz+HnW6mjXG/wH1xc/JuEJzT69B9V+1ytWvhIjuZkaKNF5GTeyYlYj3pEmzqw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4526.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Wed, 28 Jul
 2021 08:19:10 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 08:19:10 +0000
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
 <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
 <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
 <xmqqh7gghgtd.fsf@gitster.g>
 <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
 <xmqqfsvzcqmo.fsf@gitster.g> <xmqq8s1rcn0t.fsf@gitster.g>
 <xmqq4kcfclw8.fsf@gitster.g> <xmqqczr3at7n.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <6fdc3b2f-6135-d540-1868-080a423af0e8@gigacodes.de>
Date:   Wed, 28 Jul 2021 10:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqczr3at7n.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:207:5::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM3PR03CA0057.eurprd03.prod.outlook.com (2603:10a6:207:5::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Wed, 28 Jul 2021 08:19:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27bce63c-40bf-4bf6-fd9a-08d951a05ffe
X-MS-TrafficTypeDiagnostic: PA4PR10MB4526:
X-Microsoft-Antispam-PRVS: <PA4PR10MB45267FCC15C4A496B4AAE37BB6EA9@PA4PR10MB4526.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP9327Tkgf8SQ+I6185VDEDsOA9KtwV3A6RBXRprkBaJ9rtHqYj/OMyolxTi32ScLz4AMrWJkLHeVb8KDgvQXV35tScdmbCdF4x+np3htnSazWFkoajp0z0vs8Khv8SZ8wbQ350WEyL04xfI3h5pIJ7P9euYS7gdDbs7yOEioHkElKfcnFnogQXaOyBPoOy+jnnypIcDwMEP3QuhMw9HiW9mJV3h1aT0BUSWjwQsl/BdqexUV20zPIL8dtaGHCtI0dD7bPdsBYPvf4gx6TB4nxaa1wvpbfheymJsSgrKGjeZpMV6v/NgPhN+kUxdyL2c1uMoh8F9lea4fq5+Z+cL1rZnPiPWpVEpBU9bjozOtFFZCHQoOyxAyNOQ1osPmUu7tvVknmkacpbBneYmHfTZYYn9sQATFHSu+UyY8712d7lxBq7YGg4hDakRpMz2XQN6BpWyKqTtfTGtKLTvIgQosHoCW+GYQG5gcMpHgKND/8ZXlZgijmEyqUXFLTVrwtY3y53PFtBE2ZHUwcS87b8x21I4VWYZFoctqcTmqJ1qsDJiHNA8gSrbL0m4ovOmlvizs8mD0EDkydwnaRQCGU6b0RWkbravO4vl56ndpm6RcmmydGK1eA68EfMiknsM0Et8Zk7/kbMiYZrKfG7oZacVXaqjGlCRXahCPBSHuJ+ccuoZFReM0hlvnZ9A2Wqwr5Khky/+Sb87Ua185sUdUhwhXNgxxu2t3LDD1bD1g7asZCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39830400003)(376002)(6486002)(316002)(186003)(31686004)(6666004)(8936002)(66476007)(66556008)(2906002)(53546011)(38100700002)(478600001)(66946007)(5660300002)(86362001)(83380400001)(36756003)(52116002)(6916009)(4326008)(2616005)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndZeEtORmtZMURjeTE4RDcvZVVzemsvUUFNZ0lnVTF3UUc0dkpaSERxNlFV?=
 =?utf-8?B?SVN2SHFjU3JLdDFxaUliRUVVaGU3eWo5N0VGSURPRnQyTVgxeEJiUnNZRmlH?=
 =?utf-8?B?K3lIcVkwTjd4Q055RGw5UHNsWXVCdFV6OWZKUUEzWWUraFora210RWJGT1l6?=
 =?utf-8?B?SGhRM09KNC9DcTJCWnQ3clJ4V2ZUN245M2R1NU9GQWZqRTdJNW9Xdjc4Wnpx?=
 =?utf-8?B?ZFZSSGFibWIxL2hUaXBzczNiMTRaYk44MWtpeUczZnRaNTJ3WjBXWE1aR0ty?=
 =?utf-8?B?cXdMdm13c2JuS2Vjb01RZFVtN3U0RFh6SWpLanV3b0FOZ3hjTU9zNTcyTkdC?=
 =?utf-8?B?YmxwTXdvYzBLMWRBbVBldzQ0Q1FmOHphNGk4cWRaZlJJZnhRa3QyN1ArWGph?=
 =?utf-8?B?dG96Q2g3dFMwRGZ2ODkxL1dWc0VhL2pjM0cvUmNsaDZyMW5KeEFsSTI5Tkts?=
 =?utf-8?B?SWZiTzVOay9ueFpoWFdmUVNvZ2VDZ1MrNVgxaXVFK2dOMlZIcGlIb0ovRkxt?=
 =?utf-8?B?R3Q0MVI3dFBtaFBSNVl3VmRDWnhUWmU5Nnl4NExvR3NMUmU3N0ZDc3B6RStD?=
 =?utf-8?B?V3NrWktxNXdrb0Fzd2lyK0lscXNHSC9EWXl2MXh3dDBVT2lwbzVRVmFNakFp?=
 =?utf-8?B?YkJYU2NCdlljU0orT3IxU01ZNER5NjZ4L0w5RG5CNjc5Zi9neVd4WVNCeGdT?=
 =?utf-8?B?SHdUQ054dFZ1WHJGWldYMkVHL1VxeEhiRzZ1U0szbkQrblNhZHJaZWVqQUxR?=
 =?utf-8?B?VEVON3QzcC9FM2pIbnpaUkF6T1U0cm1yMVUrN3h2RXVuQTUwUk1DYUgxbDB1?=
 =?utf-8?B?cVQxTkFoYTN4eWpRWlhqWGhIbVVIZDZhcElwd2NQT0JyU0V1elRNb2NuRkJh?=
 =?utf-8?B?eTNheUpLMW4zZ016SEhqM1UzZEpvNUlkM3UrMzVvTUdPQjdaanQ4QmNoVGda?=
 =?utf-8?B?eWxYTlJOVk40aGYrRFE5WStBanhBckhkdnVJcGhTSW5wSjRoYjlBVlVIWSsx?=
 =?utf-8?B?bkxyOFdTc1NHQm9XS29RSDRObUFKd0lkTnd4dnUvWmQvWkdxSWF6NjNLYzlY?=
 =?utf-8?B?N0puSWc4dkdDUDdDZkd1MjJhbEx2S3lEdnRab2xPT25qelVBRDBKUkFvTjZW?=
 =?utf-8?B?UUNraythRTczLzJRcS9jWXY2TVlRVmZRb3Mxbnlua2pHdWxKcFlHREJtdGxP?=
 =?utf-8?B?K1RFUlp5NUtWcjJLTFRHUkp3TW4zMXlvVnVTUHJQQjdLSkxuRkhTa2tQd3Iy?=
 =?utf-8?B?MGlYNSt6WGRtTmVZR3VxU3NzUGt2UmRrU054eVRSbTN0YXpWcnIvWWdnOHNR?=
 =?utf-8?B?RkcvUDhrWVhvb0k2S0w4RTU4Vkx2STVCOE1ZdnU0QS9DcXFoaTNHa3dzbFFW?=
 =?utf-8?B?amNxS2w2TlFSNlErSzgzUmtteGVCT2FRREJRdHN0N2MyK2pVc0pkQUtQQzVM?=
 =?utf-8?B?RTFqTFliVjBVS0hNanMzb2E3OWxOQ2plNW5MNXVYd3hKWTVQRDU1RHVHMUlj?=
 =?utf-8?B?Z3ZmbHZzaGVzNVNpdGZjcVNZRWE0Ny93UDQ2dmR0dE84dzIvVHpwSXVEMzl0?=
 =?utf-8?B?M0lRNTJybW0wL1FyRTZ3TlNSb0xuZGc3RWpDem1ienIyRnI1SW1tYXY5L0tm?=
 =?utf-8?B?NWpZTkxhMDBkSUV1MndWZXAxNWNlVG1jTHNUQTZuNysvem9zZUpPTEhCdkxq?=
 =?utf-8?B?YzRORi93anFNTG1CZEhMelFnQ2Rhc0tBaFpwVzBXQkFOVDlUVDlubnExdDVG?=
 =?utf-8?B?NUFLMW1zUzdCelRQV2xxQWdTVm5sTWJLcEJhQUsrSzd3RnQrbDFleFdHMm04?=
 =?utf-8?B?MVkvUks3WDJSbzNQQmdHdmVLYUpzMWVmY2VUTEcySWlXeGhBbEZ5QW5uMUh6?=
 =?utf-8?Q?MR7F7rdU76I/h?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bce63c-40bf-4bf6-fd9a-08d951a05ffe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 08:19:09.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Psyumf9vWXTq0HqvS5tUvVQhKRGkL99f9sWvNzgDN4B10lh1LRDv9xAPCauSx+Jub7hfeNnKAHbHCeRWrQ53kd6mU0dp8vY1eWuOWFsyVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4526
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.07.21 07:43, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Fabian Stelzer <fs@gigacodes.de> writes:
>>>>
>>>>>> I think Fabian's "ssh signing" is not as ready as this topic, and it
>>>>>> can afford to wait by rebasing on top of this topic.  By the time
>>>>>> "ssh signing" gets into testable shape (right now, it does not pass
>>>>>> tests when merged to 'seen'), hopefully the "expand install-prefix"
>>>>>> topic may already be in 'next' if not in 'master'.
>>>>> I think the test problem is not due to my patch.
>>>> I've been seeing these test failers locally, every time
>>>> fs/ssh-signing topic is merged to 'seen' (without the reftable
>>>> thing).
>>>> ...
>>> Interesting.  It seems that the failure has some correlation with
>>> the use of --root=<trash directory> option.
>>>
>>>      $ sh t5534-push-signed.sh -i
>> And 7528 fails with --root set to a /dev/shm/ trash directory.
> An update.  The same failure can be seen _without_ merging the topic
> to 'seen'.  The topic by itself will fail t5534 and t7528 when run
> with --root= set to somewhere:
>
>      $ make
>      $ testpen=/dev/shm/testpen.$$
>      $ rm -fr "$testpen" && mkdir "$testpen"
>      $ cd t
>      $ sh t5534-*.sh --root=$testpen -i
>      $ sh t7528-*.sh --root=$testpen -i
>
> on the branch itself, without getting interference by any other
> topic, should hopefully be an easy enough way to reproduce the
> problem.
>
> Thanks.


ok, funny issue. in the ssh test setup i generated a few ssh keys for 
testing and (wanting to be clever) concatenated them with a prefixed 
principal into an allowedSigners file using find & awk.

Turns out the directory entries in /dev/shm are the other way around.

touch ./t1 ./t2 /dev/shm/t1 /dev/shm/t2

find ./ -name 't[0-9]' results in:
./t1
./t2

a find /dev/shm -name 't[0-9]' returns:
/dev/shm/t2
/dev/shm/t1

I'll change the test setup code to do this statically for each key. Not 
such a good idea to rely on the file order in the dir anyway.

Thanks

