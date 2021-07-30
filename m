Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E05CC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 08:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A9260F48
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 08:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhG3IR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 04:17:26 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:7301
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237905AbhG3IRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 04:17:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8uM4ruWRSEDB2EzENrPYell3jJyNIt0v0zlog9jPp0y2tNyl0BC3tBBIbkH/41xRTKLqHUJHKtxrWsjhWoUGG7Jpny0lfb10oMfApPGVAzHWdjX64FHvu/LAgc1yYlxLxgpGrBYotuhVumtN/Co0Bis2MG1sakN2L16afVpCKj9qJFA7VozeN/nvAbh9FVHtJzGSKv5/8pSQ5J6uSGxA1Oo9X+3VUNXpf7Ar3WZJHa3H0Sn524XBYRAqhgOaRtrG/V/3qKcgIBwyMk9azg4CAfhB6Rw+FqZrqmdzKkVc6apfHlBJB/IRR1U972bpyTWG1TlYe1A4aBunjflJ7wEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/9D9yS9BkA4CrKM6WNjRYorEF1F6qcQ55HEZbotVDw=;
 b=ZHa1CUXCOLpZz4NYtYAQbSX1a8idOf4vzsdvg1aBplHF1zM9up+W0tdeWe3DRRbPpzaK9f2afO99AgKepM04E0y0VcbMYqZrIq1FIUKIZKCvj26BsXbeHsgqZeX0FPf0/1xnRIwDrM6WvL7r1Eow5PKvxHpzHQSKPCCcw9GwwyEY9ysFuT3LQqb8swKMmroNibN6F5k11zYnGGNwkHw4Hu/OBF+dMnPZG3Q7scMPm3P5fQb6nG0+kSJ/8xflknmwDi+ed2eRVU4X2CXh1YUVsuc7C1ABGzxLdpxCmBKMRtmfWv5uYo2WDO1UxoU6Cxxst1neJZ5GVrVkVljRwVgcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/9D9yS9BkA4CrKM6WNjRYorEF1F6qcQ55HEZbotVDw=;
 b=goukAHWBmtvuzIsGZ7/UQJeuX0ERsUPfw3CgSYhqbWiELGskZ4bCLKEEuHHreWtYAtFOLw4kggpaFK+Y8mvsc199qhI9XwLKK1BL2wJn9SlR9JZjOiBwAi2fOIJHHihHImD6hFaAw0wMrQ+kBoxRe0TWllvNXjZ0AChqo+UOlbQ=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 08:17:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 08:17:18 +0000
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
 <ef39f1f8-9da1-25e9-ec30-b7023705b58a@gigacodes.de>
 <03a101d784c9$0cb413a0$261c3ae0$@nexbridge.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <30489b9f-8bbb-22c3-bd36-95f430a45ba9@gigacodes.de>
Date:   Fri, 30 Jul 2021 10:17:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <03a101d784c9$0cb413a0$261c3ae0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR3P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 08:17:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0580d3c0-0ea5-4cea-871a-08d95332728e
X-MS-TrafficTypeDiagnostic: PA4PR10MB4336:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4336EDDD3C6446B6E799FE61B6EC9@PA4PR10MB4336.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /su7MOJ70yXN0d8fdqIQO4zX2u+njt3T/znZYY711057hzu+RWIacy0UII4G3gG8axS6HWRVdaw0zDwBhw5Ynbp2w1DQJtzWace6jDzoU8//JLLjuxNeWbCc5LQ9kA3WXngFw5mE+U6vp6fr0QVPjOb7LmUhePDszLJmjJU50KVh9FwQjVBiZLEY/jdlo97l9p1c4/2XkRQS5p7fQ+FqCVi0K6OFcTFd/RVtTIQQMFTGzaNqWrkjcXa6wGMbPk2vx7qr8bhKn7ZMy32l4i5rd5Ei8A+NuQ5htIcDisbqWXKKDqmO1n2KQQvYwinsWnspalh6mnB0fMPbtAXWIEEYAa/cKlzbjBge3aTNbCHZfdjLM01D+DnCd/5KCUiVUJTRT3aJMAXb4nw5/7Ldc1C07F5RgPe4wBHhNOSl6aFNwdSNbIQn4v/3rFV90O+5UgxGe4jQuz6xYvqliwj9R3bAeP7srTsa58tY5Qt7lXieDkkDF2axgbDnhhidc/CQq7NJp4u4CqrWtDeYZLQ8gcujJeYdk2wcraNmRbceOfmANanZokOuTH11IwohSTWHO+Dd+rTPcIz3yJhL3NvjG+DsoueK3eOeESUtiBf+72A9693uAU3cG95UGs+B7Ap/RA13wisAp0/H23Tq03+ocofG0chJOqBzzPclX1x/lYDEpnCMrBejueuNAGDkWQayuxx8dfgrkRWEIVq5yx3EdvCPoXLUjISSS8W3/bCCzzljby5dCxDjakOU6E6RYkcY2Jbo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(52116002)(86362001)(15650500001)(31686004)(83380400001)(66476007)(66556008)(66946007)(478600001)(8676002)(53546011)(2616005)(316002)(7416002)(8936002)(2906002)(31696002)(110136005)(6486002)(4326008)(5660300002)(186003)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkpiRmNOcCtNS0tSdk5oSUkxNGxEM2VZSllGTDJXcjhNSGZmS1Fodm44KzVz?=
 =?utf-8?B?eUZtQ3ZLQXQzVFpuVWNnNktKVHBZYUpJbStCRzJUdmZTMEV4Y1pRN0h6cFVW?=
 =?utf-8?B?N1ZnNUxBTlY0eGU1Y3QyMUhPT1AzNlkyRjVsWUNxUEY2TGRQaTRZQWRqRG5Q?=
 =?utf-8?B?OHphbkNBcnU1MHhwR1NrTDNPRm5BbGxQck91MTE2dHpqNnllYnVBR0NQS3hC?=
 =?utf-8?B?RmxxRDljR3F5bWxoaDAvWWdpWDY1SDlMS1NNdWlIejlNUkM1THBzNUJUWFNB?=
 =?utf-8?B?R0wrNzJ1ek9LNURuYzVOd05SNXdmSXp4WFpLSk1jemRNNmtVb2FYekhnVVhQ?=
 =?utf-8?B?bjNLSHFRVUdISzlPaUgxeUVsQ0ppVHdmU3hrWWtWTG44ZW1iR3d5L2w4NGtE?=
 =?utf-8?B?STY4U09kVW5rdHhMeEtMTWxyTWlkdmZidWhsK2JhbGU2YXFMOVFPRE9aRksw?=
 =?utf-8?B?ZUtxUkEwenRyVnJWZ0s0T29RejcwTUFGdmpwbXFQSUQ4KzBlVWU5VnlxaVBu?=
 =?utf-8?B?R0hvTGc5VFMzdWRhY1M5SHlyWHJoREROVzVQMkx6RkRTQmFZc1pQR0JYYTVC?=
 =?utf-8?B?WTl0TE5ab1luMjI1RitjbXQxaFZYTlh3ZHVMU3RGTkRIMkc2Tm1LKzZPakd0?=
 =?utf-8?B?ZnQ5Ky9CWEI2RkhsZlBmSGVrVzdnRVRGUTJqbkNZanlGYXo2dUJVdW96dzFu?=
 =?utf-8?B?c1BvYXgzTXI4cHR2djY5V1dVbncwdXlGcjd2Z09RL3RyTXRtYUo3bjNMUnpy?=
 =?utf-8?B?eFZncUlBRUtvVFIydjlXWmZNUExTTnVWaHR0M3RJQTNsS2xTcmp3d3phNGlT?=
 =?utf-8?B?NmgzZUtRWThMQ3l2cC9QaE5mQ0dqRTgxVHlmRUYwTXZLYVRIR3h5OEp1Skt4?=
 =?utf-8?B?QnB6UUtZODZZUmxxbC9tNlZFSjk1bUVTdXl2Ty9lbkQyWGFJZzNFV0R3TUxX?=
 =?utf-8?B?SldHQkRYMlZMY2NjRzZ4VHAvMFI5TmpCQkREZGpTNEc3a29NRkd5NmY1Mldh?=
 =?utf-8?B?S29WRURROUpnZUd3VXdDZGdHMWpzK3ZyblVtZmlBOVJwZWFlWTRmZDRDWU4v?=
 =?utf-8?B?Zmk5TmtpMmJDWFg2NWFhVkZDZFFBVnl5RXFmNmtVcDlRUTJkWm40REJyM1pn?=
 =?utf-8?B?Y1RnUzhaSmNHU3RuRi9GZ2FCVUtxMGZ1ZGVKZ0R5MlRyTlVWakJOVjJ6bXBp?=
 =?utf-8?B?QTkrM0hMVjdzTjlmZHpkbk5UTWxxMGppeHNDY1Avb3pWSGpUQ09YNWd2VGhh?=
 =?utf-8?B?aVhLUjFHOENPVnczZkl6RU9TZ1BodnJTdExpekM3bGE0dXdUTFh3VzdCYmlY?=
 =?utf-8?B?STdhSVAxMTBsK21mWmFBcHE1RjA0TkRVVDN6MmFTOVhQajFIcVpYeTlLYm5K?=
 =?utf-8?B?QnZNeTcwZ2h5OGczNHVSNno3Z1NqSUNZQ2h4a3Flc3NjbG1VWDdrZVRYcVh4?=
 =?utf-8?B?cHIxVUZESHlTRXV3dG9ySE5ud0dxMkNLbXkyVHU4YjdiaHdjdzdOWDdjbWVq?=
 =?utf-8?B?SE9tZ2VVWGFPaGtwNkdPRGgwLzNOR0JOWVd6NEgyWkZEYkVOSkFvS1JaMHdC?=
 =?utf-8?B?OWZVTTkza3djbUlsai9TNWFVUGVBL1MvdmRpSXEwVStzaXllKzIxQndZaVFt?=
 =?utf-8?B?b0dhNkFBcHExNkFXRmV1c0FKVnZ4UDZyRThMRVZRUHpQKzBJWlVCNk1Yc3lX?=
 =?utf-8?B?Um9wN2EyK1JHTEZ1VWZmWWlJZDRmVGZiQndKOGludXM4cTJaY1BpeVhPOGMz?=
 =?utf-8?B?d2xUQ0tSTC9MMFhYbVl0YUgzTzdYSjFMblU2dktmWnRqRnZZZ0VzcitsbDc4?=
 =?utf-8?B?NW4rSjJ1V0RwMkFQT1gyazVqckp4eHpINGhyRk83MVRBZ1JxL3lHYXVuMG40?=
 =?utf-8?Q?QUf7oYG1NM5qg?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0580d3c0-0ea5-4cea-871a-08d95332728e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 08:17:18.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PILAuVt7sPlabpOU+rc8Ta1Bb085eF0Jfj0R9QjGElOdInvw9b//OiKHe7PIu5VQH0i/NtmBYVGV3szIRaI/RIKUOWe0fmMUApfQyh14TYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4336
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.07.21 00:28, Randall S. Becker wrote:
> On July 29, 2021 5:29 PM, Fabian Stelzer wrote:
>> On 29.07.21 23:25, Randall S. Becker wrote:
>>> On July 29, 2021 5:13 PM, Fabian Stelzer wrote:
>>>> Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and
>>>> verify signatures
>>>>
>>>> On 29.07.21 23:01, Randall S. Becker wrote:
>>>>> On July 29, 2021 4:46 PM, Junio wrote:
>>>>>> Fabian Stelzer <fs@gigacodes.de> writes:
>>>>>>
>>>>>>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>>>>>
>>>>>>>> Also, is this output documented to be stable even across locales?
>>>>>>> Not really :/ (it currently is not locale specific)
>>>>>>
>>>>>> We probably want to defeat l10n of the message by spawning it in the C locale regardless.
>>>>>>
>>>>>>> The documentation states to only check the commands exit code. Do
>>>>>>> we trust the exit code enough to rely on it for verification?
>>>>>>
>>>>>> Is the exit code sufficient to learn who signed it?  Without
>>>>>> knowing that, we cannot see if the principal is in or not in our
>>>>> keychain, no?
>>>>>
>>>>> Have we not had issues in the past depending on exit code? I'm not sure this can be made entirely portable.
>>>>>
>>>>
>>>> To find the principal (who signed it) we don't have to parse the output.
>>>> Since verification is first a call to look up the principals matching
>>>> the signatures public key from the allowedSignersFile and then trying
>>>> verification with each one we already know which one matched (usually there is only one. I think multiples is only possible with an SSH
>> CA).
>>>> Of course this even more relies on the exit code of ssh-keygen.
>>>>
>>>> Not sure which is more portable and reliable. Parsing the textual output or the exit code. At the moment my patch does both.
>>>
>>> What about a configurable exit code for this? See the comment below about that.
>>>
>>
>> I'm not sure what you mean. Something like "treat exit(123) as success"?
> 
> How about gpg.ssh.successExit=123 or something like that.
>

I don't quite understand what the benefit would be. Do you have any 
specific portability problems/concerns where the ssh-keygen format is 
different or exit codes differ?
I think using a script that provides exit(0) on success and the correct 
output to wrap ssh-keygen and setting it in gpg.ssh.command can already 
cover edge cases when needed.

> 
> Is there documentation on the possible arguments the patch series will use for this so one can create a wrapper script? I had to look into the code to find out what GIT_SSH_COMMAND actually required when the ssh variant was "ssh". I'd rather not have to do that in this case.
> 

The documentation in ssh-keygen(1) is quite good and straight forward 
for verification and signing. Again if you have any specific portability 
concerns i'd be glad to help.
