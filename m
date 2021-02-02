Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD4C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB7964E2A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhBBR1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:27:37 -0500
Received: from mail-eopbgr670120.outbound.protection.outlook.com ([40.107.67.120]:38507
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234200AbhBBONN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 09:13:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0v36SRGCh/YvlG39bGg0CNygLDcWJivU3X9B8VTqa1Nk+dnnX61CDJZ/slFG45q9KDFKW8HlUDHn12CtZ5albm4+BVphnkW6N8MHH3patp0AX1QX5drcEGtexWUkErlvgLSfbz6cCdY0Hwq+Bi5S/RGL9vDhBN6/wZiYwX+WyIRaLq9uu7p84YN6vCJR0RHqJERJTmOBxjMy11lpv1t4BooJc68H6Sr8cs/aqNsX5Rfp6x1GeBZu9BqDJiV4vSe1X3zqE6nRsVJnbQktEjzScPD7jhtA480W01V8cpuX4qoz6PINGwKruKYLuZfu8dIxqI2sS3YtLIbB/NEF0LezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RqFOQNit1pMLW5JbD/PGqG7MRF/hNp029uMkxJJ0Ec=;
 b=V7O+5AeHQ+UIACcwlduX7lN+i3JZakDCy4y0onh5JvdCw0oRNyWMW0aoaikkG36L9KliTaquTP0K0dbDfsFFmp0RbbIhESNimf/+Nv35m5Zk/Zxebns2pIAxCOWHAQhGCWVvJw5USniK+HgIfzhJ06xiyDeFLad4Ns9+mLpRM9x6L7O0RCUwIxqMhJJ7minb1nTkHtwBc8N6eQkJBWV4xP6Zz8kkHDjwb0vXG7GlEAX+a1bo9G1PxoX9gD4xdoncunY+TgZRj9xpE6q6X5pTIQ7j53KpXj0cVwEDH3E1NsM+Bby9Y2dH4q5A8c5bZbdLTfbmDmGr7+linImnZCqT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RqFOQNit1pMLW5JbD/PGqG7MRF/hNp029uMkxJJ0Ec=;
 b=PHjLsMdCJetzvg1kefR0T2yiSd6oZEmSoIBrnBewALoYrRdb+7g2lR4aM00eyJTY7DKD+tE5NGseV9iKHGZc7INqZX2bDNbLaODzmAnuq/Xlp8BVFrnWBdvFVVN8ed4sO/JZ9tndzbsOdZKjNBjsilYUdWZcI3Yg2towLAdGZOhrIPQ+OmHaH6c6Cs731NVHFBtC+yemqajEWu6/6VmIH2TL6yp5gG66Ic3H52eYtN7MKunseU4OdG5lbz89d0Vl3+X3aNg5G7BWGBHm6Vv/SMQEvw2wgG2Av/oXxQzx0McqXbVkN1aMZoU2WsU5uOCEtzg47BpxBTnya54bBhjKAw==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB2664.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 14:12:28 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::41ff:ba06:e488:bae5]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::41ff:ba06:e488:bae5%7]) with mapi id 15.20.3784.021; Tue, 2 Feb 2021
 14:12:28 +0000
Subject: Re: [PATCH v4 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-10-charvi077@gmail.com>
 <f3e2b9ce-3dfe-e33a-6149-ca23397b1690@sunshineco.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <2f680005-db11-aaa9-9197-58d3ecf679dd@xiplink.com>
Date:   Tue, 2 Feb 2021 09:12:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <f3e2b9ce-3dfe-e33a-6149-ca23397b1690@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::20) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 14:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09a5d024-5e81-48f4-a1df-08d8c78492cb
X-MS-TrafficTypeDiagnostic: YQXPR01MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR01MB26649BD1444481DD405B7209D7B59@YQXPR01MB2664.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:174;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuObqdJc1oRPaLsFdkOeg4JGsnNHqZg/hG9Hwr6S4A6QxYYhNqVVpKHSrdHZb5QfUn2Vbch1i+9FhiMoBxpvZopJSsary36jPiE+pmT2CQc5oPA1OhbiO9vNaiJJvcui49rtCiREqITKheeMBNzseqpEyl2pn0QC7b1LcGfQj3wbKEhvd9/TTgdCIkYJ7+eq32WQnBW40UlTrAi8PyjyHxj9VDhVYhohjQcT39n7ZEQIBAb7PRzG8tyaKbWV9SB8gQQvzF1gA5mp+aYS/NOezqb39DJhKvrFiGXKoOL/cPzOlsN0YyQBWljMT7vkvPXvUoeDHkDsPcECGSNiOcdCphqhhYQ8kFzP6Tm7x4doMUYU37PEGYbi0aNv2CnBINsVciTEgSKrk8U+mf5sIE3LcYSEFVbo16rdQjHxzlwVwexB/NQkrNdO7nepOxwIxtJ70ngtc8xNMjFMFfliz11ZhrmCC2wniu1kFLAZ2gkFf6CD7+KzJniDTXgaJhGTVBBAWHf3+c4ZtRM0HDAXY2WWJqmXwTVGm0d/gVSAhmjpycScDNyVyWSo/OZ4I1yR2hhSe+ie6sgGhQZI9U9TBT6hyVb27iLZBYN//CrNRUFNJF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39830400003)(366004)(376002)(136003)(396003)(86362001)(36756003)(478600001)(52116002)(16526019)(110136005)(316002)(8676002)(36916002)(54906003)(26005)(186003)(31686004)(6486002)(66556008)(956004)(2616005)(5660300002)(31696002)(53546011)(66476007)(83380400001)(66946007)(8936002)(16576012)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8onMxeh7VCP4op9NRyinJjniRxXUwc87K3T6jjA/vzqwjE/vivb4spIci942MAziO9X2Ano4IIWfp115zD+67hI4bz1nsF79Gu5cCJO7VHiZ/CDI9cen1V8v3FAydxe/jo4gdMvWtu5V7urEgggdLtUmUhVLtbGqKKnV+qCiFsepv3BPY1NOlbf2STjzfNnijheJDvk1uONgg4+S/OI+gmDh5SL+o80r7Mf0o7zxTpzjMOC+JBQy73voqUN8rG9ICAnZFQxlRsNIjiPZc5aO+0NTJzy777UuD7tsHffDRkbcbbEQ8w1R7igz+6PlvReNGx4qv4sx/vYj4unX4Wq21tAbVTQ3Q4b4xEWteUFSgqGz5NfYkwgTJjDgAYsnvAIZQND/ZSzHfC1KEGqsliGQIUzF0TuSFjUkdTnIKfcBCeu9EgORiNDerwNon7RJh/ebJrnZQl/Lvw2PnvZ/6hDB5Rl0LdWCIMrj++4SnakwTsCzeeiVPhb0vynydBkMGE1wk3scFrCGlV3llhM2oWCrJ47vbVUoXU9WmDf3SzeK/uCY2VxqDGLDSMViMHmXo7/MrcqOZWFV//lB2rVFTjmiHL2wAG3CwGcbQj0aesC5DXGrc9ZH0ooB8ynTkXBKI2wH4vSvh3v1FMkX+4mTsUwvBxGzD7MU+q9+sP3nMsKGi8oOT/CCBva4ddyMJs/saO3Ck3WSnzwZhffewDOwFd0Wj8lToeBj25tI+pqHR7Xcra7DEWG9T+9S1XoOmWQXhlPIYgjuA2gEEbSdCw1KeDXWLm+ErMrjbD5SXaJqsGrGoIjvCK6w/ZCQWbtqfzzv+iln7YGiW5OA5AiuU9C6w4yl+1vGFS8k6oaErX3lO11RTm6wsUZBS+6BfsFVnCky0l9TxHLlWTg/9lwvzfM9wpMEuAu+ZJWvsSE/hDr/9xCefaeOrJZ+yBTkF8U3fEqCZuji
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a5d024-5e81-48f4-a1df-08d8c78492cb
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 14:12:28.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZYUFY6sOpYEC1xdEUnbV3zgt0D2uU9BjywcpGfoL2+wU4CNMT2w7PDT4imVBfsZ3gxzYH4LRiTAIbY3eZJHWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2664
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-01 10:23 p.m., Eric Sunshine wrote:
> On 1/29/21 1:20 PM, Charvi Mendiratta wrote:
>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>> ---
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> @@ -887,9 +887,17 @@ If you want to fold two or more commits into one, 
>> replace the command
>>   If the commits had different authors, the folded commit will be
>>   attributed to the author of the first commit.  The suggested commit
>> -message for the folded commit is the concatenation of the commit
>> -messages of the first commit and of those with the "squash" command,
>> -but omits the commit messages of commits with the "fixup" command.
>> +message for the folded commit is the concatenation of the first
>> +commit's message with those identified by "squash" commands, omitting 
>> the
>> +messages of commits identified by "fixup" commands, unless "fixup -c"
>> +is used.  In that case the suggested commit message is only the message
>> +of the "fixup -c" commit, and an editor is opened allowing you to edit
>> +the message.  The contents (patch) of the "fixup -c" commit are still
>> +incorporated into the folded commit. If there is more than one "fixup 
>> -c"
>> +commit, the message from the last last one is used.  You can also use
> 
> Erm, s/last last/last/ or even better s/last last/final/

I like "final", personally.

		M.

>> +"fixup -C" to get the same behavior as "fixup -c" except without opening
>> +an editor.
>> +
>>   'git rebase' will stop when "pick" has been replaced with "edit" or
>>   when a command fails due to merge errors. When you are done editing
> 
> It seems like an extra blank line sneaked in between the updated 
> paragraph and the paragraph which follows it.
