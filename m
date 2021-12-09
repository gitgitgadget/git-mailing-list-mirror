Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhLIQhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:37:23 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:46209
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239229AbhLIQhX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 11:37:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeV9i7Y6qMdwdXlCM0A/dBrSWhNQQ3lQaGI0uzdJtCIzyqS4bf8odNUcZEHL0K0XsmUKAEWIthjkbrCuaHvqUkbjQgUEmutM6ySCfTSqthXsehT708YawDj/w3kJ3fgu/QnmSG3tGd4Bt0t0GeaCymNtqm/5CHMj5zd/pwrgcA/baiPhCi103xhYUx43Psx8TBT02eJ4X5GDYxE7yxWukDkzxeVJWjriOTJ0QV8BkVRdZdb+vNCBZDocEH30RL67U2leBu5ZviryVGsNQ/74XIQnc+in9Do2R+AhaXHntv+smsRPZMju7qhruJdjJD+9XSJks0VkWat9RuuVjQqG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbfhBMXzlMjdrqhLEHDCg0bJJJVnveN7Lu0aSUNvi/A=;
 b=E7nWBcY0sgOPYkKbZDAbZxarZR80R1JdwI8wbhIFWaJ9GVPru63QOjoowyF+3DqMY/+WD6m5IgPWUL7RL4LsCnSvHj9HCX6PnjJotbWRubAgqymxwKFT7yrHVL8B7fbXVUy+/7hBVUeQscZucEa/ZOx7Wsisrr/4qGdKEA7XGpCfPkO9s2EZIUkl/Q+16DzxNEkrVJVDV8RYak1RU09g+maR6Eo284m3tMsv2h2K0ovSQ4Mtm8n4XzqPrCQUEf0clQmmmtjjd7ioabIhKdH11JOoi//w1Qop/XdGNOVBY95z1Kfk1135TqxD8fcfPRBfVDthBen0OecossC7aSNGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbfhBMXzlMjdrqhLEHDCg0bJJJVnveN7Lu0aSUNvi/A=;
 b=rqcH7+rsbfErUBgSbbJo7uemfOQj3D3W3KCHM178iTBi3Oawev6IRFT+DLQepqG3dQjqge4+ATjFiuZYbh11lRzqCs5fV10W+fhse0rWaonL5yDvu9A0DvAW7p3yaRFA7bArInGC3BUbO0sXp3xXdazD+QRojMLjebagBggL9Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 16:33:47 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 16:33:47 +0000
Date:   Thu, 9 Dec 2021 17:33:46 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Pedro Martelletto <pedro@yubico.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Damien Miller <djm@mindrot.org>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <20211209163346.w5ofhoapmjnpgc6y@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
 <20211204131149.cvyu7dvf6p66dotq@fs>
 <xmqqk0gjob0x.fsf@gitster.g>
 <CABPYr=y+sDDko9zPxQTOM6Tz4E7CafH7hJc6oB1zv7XYA9KH1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CABPYr=y+sDDko9zPxQTOM6Tz4E7CafH7hJc6oB1zv7XYA9KH1A@mail.gmail.com>
X-ClientProxiedBy: AM5P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::24) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM5P194CA0014.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 16:33:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4edc66b-3ffd-4823-7e16-08d9bb31ac71
X-MS-TrafficTypeDiagnostic: PAXPR10MB4783:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB478355C57A6D449C0843EEABB6709@PAXPR10MB4783.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpKn/0wqeJPRcghbAzkoT702t/BX7kcFvWMm+qm2VTirrxYMiPO2WXrMbO+cf8IAE+yMSbvjmUBlhZGboulR0gwhLg6e3Ahuz2qxYDKgi/gePBe+875dwCNd9UZ9IwKy2ta236jGisfD1kKOC5tUG2L6GPK8JNZkLSQ/SoG2WN3HiQ9nzerlV+4K66PToWwsVIGYfPNeA0hviulP7H5m66e94g6E9CF3kEJXiKrw0uD2JVyabwSg1oIF9p1mwqTyhDRJZM9KEuMXvsgFo9ylVWovqHdAqGFtl7ZVCumRg0K9YhPbEQ3YWpwQkmn7Y3aUxqAkbw3epwwfyrZMkIW57WEYpxuHNNuSpWJ7jdwg/Sn1OrZuCF6Mw0PMyNPHOrpbfzXguJqj6qLrLxh82pGPQOoVhhRgTfkk5VurNIm2br6TwJHXNV3VJjIA3prv/FId080/HLOX2O+48KVff3KtiNsLZboDIGd/Ta134sbqbmH4SNwq/GLTXNgETTsF9FQXXSAzOHlp+0jRzU/ssPF7lNlg3sYt4qwrImxi+cvAYPSiTVj2c0Vb/bvUdao6Zv+jf2y0c3iAsOcxsiPdNvHoyhyZXWAVD0x7wxbk89iFkfxq73zLGj9i4VoIyYeqJR1zpts8KhEN3vAcYvQroLmWMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(39840400004)(346002)(376002)(136003)(396003)(4326008)(33716001)(316002)(186003)(8676002)(9686003)(8936002)(6916009)(1076003)(508600001)(5660300002)(6486002)(38100700002)(53546011)(54906003)(2906002)(66946007)(66556008)(66476007)(6496006)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBRV1B3NkZjekZGRzJGclNyTytUVUQxdUozNXZGaFhuUzFKc1ljM25DdXVr?=
 =?utf-8?B?NlF0dUJWVzdHY1NpOHlaMFIrcTROQmd2TUxFOC9SRndZcWJJUFU3MVpVUVZo?=
 =?utf-8?B?WDlzWkMwT1h5S2NUQXZVVXQwbmRzZVNXY3lVVlUrcVFtaUoydHRnMWtqUEMv?=
 =?utf-8?B?UUNCNlBiVnNWSlRlL1NHV0dXeDJMS2FHVndCNmZnaW5wZ1ROcXc0UUwwUlRF?=
 =?utf-8?B?K0FzWks5VjZmOFZBbTkrNEZCSUlVL3FjdmgyaTBNRGNyeG04Z3R2QjdHTElT?=
 =?utf-8?B?UWJ4VFo1di8wY2VCbExMUVB1alRWYjhKUzlJVUhiRGJ2WUVuV2ZZQklKY3o0?=
 =?utf-8?B?YlBjc3ZZb2RHblZseEJQd1M2c0ZJVkp1OUVtSXluKzk4dW9qT2laK2FIaDBN?=
 =?utf-8?B?T3g5bFV2MFdIaC9UNHBIRXFYWERDVEpWVUpCTDZnbWZUL2U0VzBVWUJDM2ZZ?=
 =?utf-8?B?VkVrQXg2UjdSV2IzME1ianVxRjRsdmlPeC9uc2JqVTNmdXVySjJSV0djWXZj?=
 =?utf-8?B?L21qa0ZzL09nTDA4cVJUdHpRNjVpZS95RTQxU3BGK0ZCVm4vVW8vUnNwTWJO?=
 =?utf-8?B?N0pnUUgxc3lGUUZvWDhERXJiLzlwZks0Wk02U0MxUzBxZXB2ZTBYcGcxaFhO?=
 =?utf-8?B?WnlvQzNlcjVrRjBsR1hqd3VPMnNLRW03V2N1SFBzTGFiUExEeEdmTW4zaWUz?=
 =?utf-8?B?OWRjc3FJNU0yaUhSV0FPd1R2NVFnYm93RHM0TlFubDB2WVhQMkxZZnhnQzZo?=
 =?utf-8?B?dEpTRVdvM3RqUkFHTzk5RXRnYlJxVDVnUjNldWVUQTB4dXBEQjFsc0J3WEhz?=
 =?utf-8?B?TGQyckcvc2lTdW00c1l0MmdjeklhcC9oMlJKb01ZVHU5QmZlNVNmSWlOd0R4?=
 =?utf-8?B?aTI2NGlhM1gvTjFVNVN6Q1VpNFlWekFzcTR1NHIwK1EvZEVmRWc3ZzdmeUpy?=
 =?utf-8?B?V3paTnZHZ2pqSkFveFFKRTBLYlE0OFNwc2dTWURLRFM5VEJrbk44SVA3Qzda?=
 =?utf-8?B?Z3RmSi9RZENUU3R2Yk1MMGRmZ2MvMnRzUGhTYjVySkVTSmsxbkxjRUc3ZzI2?=
 =?utf-8?B?Tm1KVTE2R0RaVkJVVXBsQ1J5d0x0WHZCVkxKWEl1MXlXcnpNRzBPNXo1MFNC?=
 =?utf-8?B?TkxHWjJmUWZ3Y3JoMUZxb29zT00wRDQ0cUpPV1RBSnAxQ0JGdnFCdTRIbzNx?=
 =?utf-8?B?SDZRemtJYnpSQWczRDd5NXR3bEhBZGFsQzU0dGxwQXBxRkVKbCswZit1R29Q?=
 =?utf-8?B?MVNaUTJLdkYrLzdxbWRHcytRUVBJeUJ1NHFzSWVFU3A0T2NsY2hoR0ZWU1ho?=
 =?utf-8?B?QXM3d0dDblI1S2JmelR5L0pvaEdiVWVwa2VNNGhIWno2Sm1NL2k4M21odXpJ?=
 =?utf-8?B?cTdXTVhlaERyZlI3b3BTV3FKZEhXVDUySGNiQmZHT21jNEZjak5pcEh2VCsy?=
 =?utf-8?B?aXE3SGVOdm04clRFTEVTYzV4QWFxZHpRZ0YzSkZNNldyVllDNEZLRGkrZjJX?=
 =?utf-8?B?OXhSSVpkMkR1UFd4cFQwaDNqUUhiREZjZEUwc2xwbzFXYVlSOHh1SEtSMjZy?=
 =?utf-8?B?ZHB0MUFMeDNUSkdTcTBFTXdpb0RrUWVsa1p1L2JRMGxpcnJsbE5RSDF2MFNa?=
 =?utf-8?B?enRLbWNXVloyMlZQQnpuR2t0K1loY0pTL1g0UnlQRDZqZkxHUjk5WFJjdkpL?=
 =?utf-8?B?Qk8vRnRneEhWQ3FiV2J0N3pYRnNZRERNNnJFL0ROMnVlemJLdXdOSUhvV0gw?=
 =?utf-8?B?ZEJEWG51cFRIdnBCUEdrZDZqTyt3bU5hamJObEd5dzFyK3UxQ2thc1JqZ24v?=
 =?utf-8?B?N0JDOVMxbHNRZHVHODlkK2ttZEw5WWFrcmkyQU90RnBkRmlsaVk4WDZ3UVBY?=
 =?utf-8?B?cVRDZWhLN2xRN1M1ZzFhSDJ5Q1ZwUHNlUCtnK0xCM2IvQWNOZk9PSklNTkxW?=
 =?utf-8?B?SERoSnNXbDNXNTV0VW1Yc3IzdHBqUlBDYjRCSTR3Z0VqelN1OTVMSDJYV3Jm?=
 =?utf-8?B?emR1bXhXM1VGRlUyWm5VMUN6cFFwUktyT3VYNGlZNVZMaVJhTHJ6WTEwZ3R6?=
 =?utf-8?B?TFQ3Z2FZODVSOVpIek40NVplUFpwSHNvUk1KOGRBaGxEaTJNSldWQnNmY01i?=
 =?utf-8?B?ekpjY1dhaXlxZDJXYlZxYWYrU0VLdGFRY1hLSFNOR1Q5bEJZZUpVOUdqUkJI?=
 =?utf-8?B?bUQ4WHlFcDBrYVA4UEFseHBQQTRBWjVGNTJpd0FXS2lHNjJyb0VuOGlMbVF4?=
 =?utf-8?B?R1FWL0FieWRubXQvc2c4ZTRqbElpQklFcFVaNXFwRzVabGNXQTN0eUlqSS9H?=
 =?utf-8?B?RTlmUjlRWW14MWJyVlpMb3V5WFZuK2Z4dXA0R1czTzhCNDNrUlUrZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d4edc66b-3ffd-4823-7e16-08d9bb31ac71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:33:47.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Frj4Z8sAUapJVJ4Hx08Pvfxtof9X2hyNo0xQ01SM/IPaJHlVEmbDUSl3UMgizJ6C7fdpjPXjhcHIBDYJ8GiTlWyKGKdZrV67E4wKHJ7djjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4783
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.12.2021 10:06, Pedro Martelletto wrote:
>On Sun, Dec 5, 2021 at 6:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> So instead of the posted patch, we should do something along this
>> line instead?
>>
>>         trust_size = strcspn(line, "\n"); /* truncate at LF */
>>         if (trust_size && line[trust_size - 1] == '\r')
>>                 trust_size--; /* the LF was part of CRLF at the end */
>>
>>
>>
>I agree that's a more consistent fix. A minor nit: if the intention is to
>only trim CR as part of a CRLF sequence, we need to ensure a LF is found:
>

This shouldn't be necessary as we split/loop by LF just above.

for (line = ssh_principals_out.buf; *line;
      line = strchrnul(line + 1, '\n')) {
	while (*line == '\n')
		line++;
	if (!*line)
		break;

	trust_size = strcspn(line, "\n");
	principal = xmemdupz(line, trust_size);

-
Fabian

>trust_size = strcspn(line, "\n"); /* truncate at LF */
>if (trust_size && trust_size != strlen(line) && line[trust_size - 1] ==
>'\r')
>        trust_size--; /* the LF was part of CRLF at the end */
>
>-p.
