Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E40C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 10:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhL3KZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 05:25:52 -0500
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:2337
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229799AbhL3KZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 05:25:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJsc1br+zpsbb+6yRRnnxK7BkGEJGvZw9ZAWXvw7Q587ZrQIZ0MtOypIn1MwBXCjhGRG0nrN5xKQeO4rzVYO/RAb1G7oVZXFR0S8jGjBkSfQeJe3wC0sDO10v8U9TMxKhcAaJOQ1783YyBZLWV1z2TrDu6bvBRlQPqUxhAUaNsDf/6RviqnX6/XxSZcJM6DX0pJBI/UbahoiAbF/irbG65tp+tGlS9JqMdu0fDy4up1IycoF7U33e31HxxEhTcqinznz9IG+9yci5w9TFAjV2wOfZmPWxhzaPTzmOlUAU/2/oxi3CNl2VEnRQlqCEjIf4CAZwq519chIFostOTnoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VljnyJhKqi/wCFyP1Y4Tg8s9OLYIh701+bpykuwec5Q=;
 b=n3a3dzMjIsIBcH5jeP2KumQd1EwHimAWIWeVsvVA/U5VKUx6YLkeArQ7OuKNzL1CXmVMb8klpjKNw2Ofa14A9O7B0UNr67+WAjvlPOYGVckJvVMvYBvHZU2NTFy9sW9GvB2/oxoWoxb41Ya4o5maGo9vIJl4HStgX2TLg+bGPXj4KLn+JyDSY9JUn5L1U75MNIvzJtq8PXOl6fW14XAMrNtERfggdr6vSUzWy/mFTU+tsUNkZ4MfNk5MxW12eN31tJksWJv/D0Ll3bUeRP1SC3MSZbhAHToHiFfPLNQX/64vrZ6JEWfpc+8QuUcJEmbhC0LdOnQ3Fipw/q9HZvbk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VljnyJhKqi/wCFyP1Y4Tg8s9OLYIh701+bpykuwec5Q=;
 b=JtQ9CVyjiXKRzT6r9dbkOxW1+RfJ87cQbLYZZhuiarlxJicyh92TxnWvoJQdcG7NstM81ariR7XeOA04IiYWZvbVcEfGaUduWU8NqFmlEenfQm5fFr963IhdJ0xMVthvqxKkb1Wv0P2P6Fi6lHnItbAGEH2FRfs6yB9WvVbxVXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 10:25:49 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4823.023; Thu, 30 Dec 2021
 10:25:49 +0000
Date:   Thu, 30 Dec 2021 11:25:48 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Pedro Martelletto <pedro@yubico.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <20211230102548.q6ugqiyicswfx24v@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
 <20211204131149.cvyu7dvf6p66dotq@fs>
 <xmqqk0gjob0x.fsf@gitster.g>
 <CABPYr=y+sDDko9zPxQTOM6Tz4E7CafH7hJc6oB1zv7XYA9KH1A@mail.gmail.com>
 <20211209163346.w5ofhoapmjnpgc6y@fs>
 <CABPYr=xfotWvTQK9k1eKHa0kP4SsB=TKKuM0d8cpMb5BtuUZLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CABPYr=xfotWvTQK9k1eKHa0kP4SsB=TKKuM0d8cpMb5BtuUZLA@mail.gmail.com>
X-ClientProxiedBy: AM5PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d72f2a6-3b3f-48b9-d6c0-08d9cb7ebfb2
X-MS-TrafficTypeDiagnostic: PR3PR10MB4016:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4016BECCB50E9A2F34F34868B6459@PR3PR10MB4016.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sIoX93ATCPQLjInxK3DHN2CddSCtj85YEf1tZR8DLSNW2+ZENN7xfvfQBJmYeuI08sS8JnTg4TWGzfGt5tPFGrFz4NgU+5ap5LMrX/cHrc5exH+egQZNWqXgqc9jODrSqgVNQTNyD3iVROB9lQN2iCklEVWZaWtNTCzIHaFSmJ+2aTGOIcWoGdRe4IIeukgr+ei00zpDH+Hrpb4RrtOjDGwYIVulL0Ms9cBilns9zAhbPH+p4k55O9jDhRo5jfbx+J+SC57Vd9JBr+M382ZfL7/U7PK3OvDahVz+t/FmLtd1UPcAYsNVE1UntXHVOF8Q66skcbTKTI3ruLRtf2+jQO0dVReOmJ93aSn7/sa/p+Nylr7z8TEEUkeGPZg+Wgt40ZvaXNQbXX6TTNehjyVOOlnjAzsZCSueLq+HAmP9AHvMDfQVEW5YOYXIA+uQLP4HjK+UdDFjqHOhFVQ2fII3AtDs4rZVrD40hqOfQ8LI0qCY0cQH8QKK8ncYk07/Oj9J5cyDlOuY52Z1OVWlU1I8zUH4aN/b6PGbEdC8EgEBWxO4jmWg6E35BQZ4Xf2cifeYNZ7W+jkHBWW0EtT2HcLw6Eov2YcLGNjS5Dv192Y6lk3Qyh4LwlzBhUqNRdJgMrg37EjbykBOuebgRLx+IX8VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39830400003)(376002)(346002)(136003)(396003)(366004)(316002)(8936002)(2906002)(6506007)(38100700002)(6486002)(186003)(83380400001)(66946007)(4326008)(66556008)(8676002)(66476007)(9686003)(6512007)(54906003)(5660300002)(86362001)(53546011)(33716001)(508600001)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9Od3JUc1ExS3cxckpwUWMvYkZFUEV0YU5LRjJQZFhzckw4WGwreVZBem11?=
 =?utf-8?B?YlRoQ3FoK3dqRmNGelE5dFRaem9kZHdQbnU1RUhLVXhHNnpWeDlqMTlJdTFu?=
 =?utf-8?B?Ym9xaGdOZk1kOExPUC84clBJQytzSnlxZ1B3U3BxUzkwcExHRjRvbzhmR0NZ?=
 =?utf-8?B?TjZobWdpU3ZLY1FJY2tDUk4zb1ZISjl0NVphZG9FN3A4TnJFdmdDUVRIWk9q?=
 =?utf-8?B?RHVaODdxbzllWnpaODRJL1BZVGlSYlQ2UUFTWm1rSzNaV2JJQktHVmRvdDg2?=
 =?utf-8?B?TEZUZFlpTDRUcmdIWlR0YWpkRjF3R040SEVHMVF1SzJrQ25EbDhKODkwMG1r?=
 =?utf-8?B?ZVVBcmh0WG8rQVNOcFBqMnBTaGVUUWtnUkFla29jWVFqbyt3UkU3aFJkVDhY?=
 =?utf-8?B?b1l1S1J4Yzc0R01IcVFMRTg2azF6cHBDb3BGTkNFU0VsL0xUUlZ6Qk9XRzRJ?=
 =?utf-8?B?Q3ZCcUkxOUEzWEVEOVNRYVpMVUVScDZzOVhyWCt6R0FKTCsyS1luOWYwK2xK?=
 =?utf-8?B?WVBkV0Vtb3YrNGI0UFFEejhERlFDdk84WGZVaEV3c0xuaU1Makhid0kzMkNC?=
 =?utf-8?B?SmhpOCtub2QrRnhmM1o0cjU1ZXdXaS9BRGdsS3ZoMyt4TzNSeGQyK2ZWcjZm?=
 =?utf-8?B?NFRnWjVRTTJkU0RZNkUwWjZhdXBJRU81dHNlSjJDNW51SHVKVi9NQ05CTXp6?=
 =?utf-8?B?TDVyeVNsZDlPUGVXNzFIZmhQNWllWTdqOFZTTzdoaWZjbUdBUkdYOGNZT2dR?=
 =?utf-8?B?QlA2Y1Y0RHVrczNMZjNoZ1dFQUxPcEJSL2VUQi9EQlE3eFk3ekVRZFhPSTk2?=
 =?utf-8?B?MzNGS0lINWV5UkJmZkdOVnk2RTZGNnB5VGIzSG4zZFZrVFBNck9vcTk0RTZv?=
 =?utf-8?B?N29KbThZM0J5TDZNVDNpbWc5cjFEclNBcHprYU1ZNm9LVmROZy9YL0VRWHY0?=
 =?utf-8?B?VmpjU3VIcWhTdXROMGVRRWVUbWRtYWRLZnpVSGZpRWlVa2FLZXF4b0xaNlBP?=
 =?utf-8?B?U0ZJejFkY25VL3IxNXlnSXNBdGJaRk5PTWZKYmdxT2VzS0VJVUlNTWdrVDhl?=
 =?utf-8?B?SkZTb2hDTGJvaDFWRnlnNmZISkhBbUVEam1Lb3p1VzRiRXZ5MFJrS2FiVHd6?=
 =?utf-8?B?R3pZa3A0R21DWnRSNTZsazRGZldDQ2RWcmZiMWFEZmxwWXlXaTNKQkU5K3Nj?=
 =?utf-8?B?azR2N211MUlQbVZZOVZqVDNEZThaSTRobGp0NDFXVUZ4MXZYWlBiYzdQR1R1?=
 =?utf-8?B?NlJjU2NtUXlqZXRheW1vQ2JPdmdMdmRuRkp6VTlRdzBvb1pFQW5jNEJBdS9z?=
 =?utf-8?B?RXBBKzFEZlAxdFZPWVpaMHZGSjhvdzdzYWhEM1gyNlRJTzdpQmtvSG1sVXZn?=
 =?utf-8?B?aktZN2Qxd3d4SUNIL0hrZktXbHhyWG5MNk1QRFFBQktaSmhrZDZsUC8vWU1I?=
 =?utf-8?B?NDZLL2Z2OXEyem4xdWt6TW5jeitoRUZScGVBeDNVaENvLy8yaURaYkQ1bHZi?=
 =?utf-8?B?NS85Vmw0NVBnNVZkSGM1NTZHM0IreldSWXliNUxCYTRFbW9BWnV3bnFxUlRo?=
 =?utf-8?B?VE5lQ3VCaVo1STVhWElnUFVrVERiUnl1cFYxamFOV2VNUUtvbFRHWTRBcVlq?=
 =?utf-8?B?VHJwcDZCV1U5UmVCbmFrVmZPZ01STHkrRFNwc0o3TThuWkVzTzJiRjllaHUv?=
 =?utf-8?B?MnNxdDJ1Ni85R2Z5NUFVK2Y3WXJnZlIzRzFINCtReCs5ajlNajdxSDZmT0hl?=
 =?utf-8?B?Nzg5eHRudE54NnZjdVVmVFNOOWFZb0NneXJFaFZUOExpcGpkOFpjMElrUVBO?=
 =?utf-8?B?eCtHVXlWQWFlTFhtd0d0bUpkZ1BnaVJDZ1p3U2lvcGJCbFRGZUZwbDAwQWF6?=
 =?utf-8?B?TkRabHRTQnRFYlo4UXdQUHJBRFc3bUNsU2RQdGNTYitKU0xaQlJ3VmJjNUY1?=
 =?utf-8?B?VEtnR0lmNEtYWHY3RU9zS2p3WFl0RFhOTDEwNmdscTZCNmJFYmFXWlZFQzE1?=
 =?utf-8?B?dzhOL012dm4ycU1NZjZwQk5XZWFaeHJ3Y0E4dFp2MkNub2poMmlXaXBEOTVp?=
 =?utf-8?B?SXYrS2taeVEvTHFncWx2eXE4dk54WVBuUzhoOUx1VUpiR1JIbC9sWUorbFJN?=
 =?utf-8?B?eXNLakdvMW85NEhCRmwrbUY0TWwrQncycHRBKzRaalYyZGUzNHRXYlhZdDhp?=
 =?utf-8?B?R2tUbXJtejgrNmhjUiszc3R1TWdFQUt1bUxhbCtIU2ZHaVBXK0gwSVJEd21O?=
 =?utf-8?B?VXlHNkVhME9MbXVDcUFTY1IySXhiUmV1cU8vYVIwSElLVGQ4UkN1NHpwOHR2?=
 =?utf-8?B?emIydmNWTWp2dkRrTFZYMU5RL1VYQXdaK1ByQ2hxYk1EMTRmZUtCdz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d72f2a6-3b3f-48b9-d6c0-08d9cb7ebfb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 10:25:49.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OTanbJbN9oPTFqpf5A/je/DYs++4ZUHwJSbumNRlkswDb4b7qx0PP8dbbW6UAtDw8Dwm1Q5LXkwqeJvG5rEQij2wc60vRzWCdigsrsMjps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4016
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.12.2021 17:58, Pedro Martelletto wrote:
>On Thu, Dec 9, 2021 at 5:33 PM Fabian Stelzer <fs@gigacodes.de> wrote:
>
>> On 06.12.2021 10:06, Pedro Martelletto wrote:
>> >On Sun, Dec 5, 2021 at 6:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> >> So instead of the posted patch, we should do something along this
>> >> line instead?
>> >>
>> >>         trust_size = strcspn(line, "\n"); /* truncate at LF */
>> >>         if (trust_size && line[trust_size - 1] == '\r')
>> >>                 trust_size--; /* the LF was part of CRLF at the end */
>> >>
>> >>
>> >>
>> >I agree that's a more consistent fix. A minor nit: if the intention is to
>> >only trim CR as part of a CRLF sequence, we need to ensure a LF is found:
>> >
>>
>> This shouldn't be necessary as we split/loop by LF just above.
>>
>> for (line = ssh_principals_out.buf; *line;
>>       line = strchrnul(line + 1, '\n')) {
>>         while (*line == '\n')
>>                 line++;
>>         if (!*line)
>>                 break;
>>
>>         trust_size = strcspn(line, "\n");
>>         principal = xmemdupz(line, trust_size);
>>
>
>The loop ensures that 'line' points to the first character of
>ssh_principals_out.buf or to a non-NUL character after a '\n'. It does not
>ensure that that 'line' contains a '\n', e.g:
>"principalA\nprincipalB\nprincipalC\r" or just "principalA\r".
>

Just saw that this is still open. @pedro: do you want to send an updated 
version of your patch or would you like me to pick this up and send one?

