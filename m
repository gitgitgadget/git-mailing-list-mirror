Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB976C433E9
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BEB23104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbhASWHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:07:15 -0500
Received: from mail-eopbgr660103.outbound.protection.outlook.com ([40.107.66.103]:25564
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727191AbhASWHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 17:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXOc0sYyqFgs4U5S1Nxena5HfQ2gEXKZ9TAgy2faVA7D2wM2nZ/MWkC0GIm7pSgDzbFJx0LNwYcFDx1h+eZ7uNEEhPRp39s0D1L2R5dawiYHyhvKrOswB4jx+CTWMyBOO8ViM7imFXTJY8VQkTBvYU5WhBk3L4nuvUhzE8A7S+ETg8o0F44ZOGCm5SljDH3HZX6y9Bug5yxPm9HYsLDVbP8V/etVCZma98C8fh+PquNsk855viaWa8Sp+L2W+8BbUhpwcOMfjSnl8TJZwFLnqmAfOJ/p7MIUllubAVIIu2Shw4fBHrpYyCfsHyuxRuW8dyAx0Sxnh+sTUNLR8IQ0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNpU4GqZT2gUnN7ZhyXNaMZd1q1arLUYppG7viC5Eiw=;
 b=O7KvoqSv4SoXWBV1mfXb6dVlt46sRmEaH87aNYOAygYyTwmwe1AGz+msWZkJ34C441bHUPI4M/b/JJwq8fnMlKst7b9KGICcgCWsqz3AawzKkoALtYa94YYGb8VeaoLYE0jhTu9Xw31q2xW6F9RbnGo5i/nYJUNTf9eQlXcft2FaBDKEplcqNsxUAZy28+lUzZsqxCAX0YsOLC9lQUY6IrR9mptcvw0+Vh8xT2NbfUvCVznJc1moIA9LkMBsspUfUaGu4g7dHgkJ/6u8/2C6j618yfViOpzKZeqA3vrWMGjZ2U72YwmlN/fjQ3q+WEfJr2c4FDz90xNTbWwA2Bm0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNpU4GqZT2gUnN7ZhyXNaMZd1q1arLUYppG7viC5Eiw=;
 b=GaWFQs6ljZk3QBF74GK8w0GS/hFKw0CvO3QZuIdx8aLmbcvo/u/+HPbgIZFYunylHV+nknH8BzswnYjPcRAaTEJ9Ek4EB9QZdU9Z/mfLWfaYi3M+8JZZfYvRw+22OoprNY/wJBsi6qz+zzezWybXiqKECfDr/pHPMNlBy65FggVVc+PKpEQzCU57dOQuCbQ4MAYK+R7AyTQBBu9Et7jhzkF1uUID3xxDiU68TbDmetSqjz4UkvfLq9w6PYf/7EHzeutnBMPPfJ6TR4zINVMLDx77VC3xz7Pf5jKsa6kAzI0f3rK6xh5oS9Qv2WCFuxfHZGU4AgPB3s86FW8a+Wze8Q==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR0101MB1477.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 22:05:52 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::41ff:ba06:e488:bae5]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::41ff:ba06:e488:bae5%7]) with mapi id 15.20.3763.015; Tue, 19 Jan 2021
 22:05:52 +0000
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com>
 <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <a9bc4d25-f2ec-6a8f-4969-7704f12d667b@xiplink.com>
Date:   Tue, 19 Jan 2021 17:05:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Tue, 19 Jan 2021 22:05:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e26f391-6412-4b15-729d-08d8bcc662ae
X-MS-TrafficTypeDiagnostic: YQXPR0101MB1477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR0101MB14777424565BD110AF35B6ACD7A30@YQXPR0101MB1477.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koI5qOJu1yDyLrMYlG3/HosSPtlWplCUTM/w0Ws8/fi+xDJ7PlOXCNh+zplbEriUv34IYFteLo6HfODbOcLnirLRWf0IIf+GZUPckrgD4NqSJ7v9yrxEEl1sPGKweVc232LVeVoRPWaST1zDOXy3AWtfGY+YiaDv3xa0/Ova9UdrwE8kjXmIYiuRzlCZp1//xs+HrXfpmX94ZU+7e2/qSdoJBQAgxFL4j+sEaU/k/R1b/AaprdGJxifiQ7mwe7THGl+MtoUA1ZUqosrkQAM32mpmgMG9zehQS+50/nKMfR1v8Is2JFd81hrzVjZyRuObrHfArxb7L3d83h9XkhFaIILl8bUYpUjJKDQukwypsCDLQSKUxtaGx6j4F+UtX9gDiXYNXy5YSOmcG7chah9fI6+8qjD3dp3nenYoMUqNFEf+Fnr2Poj9x0xVRdbBQINyHKoMjO+lkUU3PDXSpy/CyeWegVwQ0uCdOoHrJ7qrZkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39830400003)(346002)(376002)(83380400001)(2906002)(6916009)(2616005)(31686004)(316002)(52116002)(186003)(16526019)(478600001)(5660300002)(31696002)(53546011)(956004)(54906003)(36916002)(26005)(8936002)(36756003)(4326008)(6486002)(86362001)(66556008)(8676002)(66946007)(16576012)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vAEwAU5lZv314RCu2pZfPv7ykCHEjumoihkPHLytpHr3V80LUcti7UFxR2yxYmaSo+HcrVMJj2rUXmBn96zJXKrBRJuo0Gu9DZ6TYorDZjPToLwON73s+nze+JEdS0+dOhCBZ5AlJFWZxQQb2cQhWCd4hLMChp/va7ZBrcPFbdC5MAeexnZ5v8wAK1RiOn7bxeR4PKJJTk7fEAu5H7Vra2I/s8Pmfw1cPSWxTpQaZLzm2gqOJkwnJsVQnyc88PhL4XjPV7vbH0Sf68xnZipD4l6X3waRWlcjzWAKzul7v/wTU8CVvbYopjKtH+q2nQ1qCUrTPZiYkmul/MrsmBP+fw0MhZezfit/H1/Qnum9+p4T9EdSlBy52hodqj0ryLAqLfIwbctQaooRNSyG68BzOJf5Aa5JSuxQxggZ5teVv52wea6Rm7cvokjg3OdTL4QXX/n9T2ylidSwB0WO61XhHhDAr4BVM4GpRCG5avprIkglNIRIhKLg0mwNxMJhX4SApb11CqZFWJysnekLkqEiiIQZdw93D7GKSCuWO0sVc6Fprl08vB9rwJmS4Z0O4BVyMt0ypQsQQlgXZ00ejUrzWpQ8z7dp+mNx7CsAUm/jsL13H0B1MivjEaftJsa7MFr0FX0sn+19YWmAYIrcH2wp1jxwtncNi5b56cqQQ2vn4NVAfRYbOxHWCHkki0yE4Fh7lW3Sy9X0RDy3dx7HlX0U+jyzWVo58YvKAakNyHKDEJHFgAEwn8591UkhggmQ3872A6cYZxbqHXOJgy7jl7Wf2vKjVlMHqlhnSqUMXWpWb7qgIzYJl2gwX67cLXUSusT4j1m6FVVfud4aVV04/J4qmxHJ9xHLHn8IUbduwPWkgS50v+HKi5yidkXMDKbUOedv
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e26f391-6412-4b15-729d-08d8bcc662ae
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 22:05:51.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGdgJqZsgegqKm6jDBP1eJUmN1B/Yv+lq2DJJf18BZivYU0uyngURAxAAzkhwIbdJz7DKLWA+5/TP4pk6I0Mtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1477
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-19 12:13 p.m., Charvi Mendiratta wrote:
> Hi Marc,
> 
> On Tue, 19 Jan 2021 at 20:07, Marc Branchaud <marcnarc@xiplink.com> wrote:
> [...]
>>>    "pick" for the second and subsequent commits with "squash" or "fixup".
>>>    If the commits had different authors, the folded commit will be
>>>    attributed to the author of the first commit.  The suggested commit
>>> -message for the folded commit is the concatenation of the commit
>>> -messages of the first commit and of those with the "squash" command,
>>> -but omits the commit messages of commits with the "fixup" command.
>>> +message for the folded commit is created as follows:
>>> +
>>> + - It is made using the commit message of a commit with the "fixup -C"
>>> +   or "fixup -c" command. In the later case an editor is opened to edit
>>> +   the commit message.
>>
>> s/later/latter/
>>
> 
> Thanks, will fix it.
> 
>> What happens if there is more than one "fixup -C/-c" command?
>>
> 
> Upon running interactive rebase, in todo list if we use for example sequence of
> commands like `fixup -C`, `fixup -C` , `fixup -C` then it will fixup
> content of all and
> for commit message it will replace with the commit message of end `fixup -C`
> 
> Similarly, if we have sequence like `fixup -c`, `fixup -c`, `fixup -c`
> then also it will fixup
> up all the content and here it allow user to edit the message, so
> opens the editor once
> in this case and shows the commit msg of end `fixup -c` to edit and
> also contains
> commented commit messages of complete fixup chain. So, for any sequence of fixup
> chains `fixup -c` works as similar to the `squash` command.
> 
> Hope it explains the working.

Yes, that does explain things.

I'm also under the impression that the "fixup -C/-c" commit's patch is 
still incorporated into the folded commit.  Is that right?

So I think the documentation could be improved.  Assuming that a "fixup 
-C/-c" commit's patch is incorporated just like with plain "fixup", 
something like:

The suggested commit message for the folded commit is the concatenation 
of the first commit's message with those identified by "squash" 
commands, omitting the messages of commits identified by "fixup" 
commands, `unless` "fixup -c" is used.  In that case the suggested 
commit message is `only` the message of the "fixup -c" commit, and an 
editor is opened allowing you to edit the message.  The contents (patch) 
of the "fixup -c" commit are still incorporated into the folded commit. 
  If there is more than one "fixup -c" commit, the message from the last 
last one is used.  You can also use "fixup -C" to get the same behavior 
as "fixup -c" except without opening an editor.

Thanks!

		M.

