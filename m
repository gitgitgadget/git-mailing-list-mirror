Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314CC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90F961362
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhGOIKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:10:00 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:19430
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229810AbhGOIJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 04:09:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKYgmVMrDoaRVPgaAS4EZWy+PqVyFB/O/Lmm4X6EZsg2opHGQU15+ZWXnsPUIoKeud+jZvY2YVMNSJogJ4lPh8Rrt3mzdnkuZxLa3AwxOXYBsl0gXBKGkjbl0wb+EtsM+wU7kHiXyTPOO3vYAPGhdexe/Xtgtz6IqjwLo2uFEIcF7fXRUy0Ix1c6LrLPzwVIbVJGkzHxpI2CCnm8u/m+Nf1zQCTSs3wrkKyLEwn6jLKLJPCtLWiVuGS2i1WLl/W5pFZozyPeI3WsaA61wE8ypS3ot1NxgFbJZ1BIkUooskIBkcQahT4zqFh1x3BjsBPmBD66rdGf403D6XvdZ5LtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51tsQLUeZ1+7xVJ0P4mwoYyGJCahDjvkj6tAo498tR4=;
 b=gvCqlnpq3wqrRrY3ZOFv0RxctWwHxX5wSLv2bPubunpwksXlQ20qwr35vZ7RPY0cMEk1Y/Xdax0XJtsmr+3HVXEmE4ZhVJQre/D2KnNZx7byVnOBTdGulD17TETIwcSKkEQWOl4hdz9cOfxffJmOjiGzEtfgMjS2gx2Fdb/T125OXZxwmpSavVFDa8a0xu9BBqYEkrCzCMOZvqjUBmr6cVPqkmP3XpGVL10V6nPNISv4FBNNSjI+QTlML/T9OUNoJAIErl23MaRVTxDtOCKz62xC8kfTze963IOtacma6J33yCFZpT11UgksQHih/skKybriJkwOB1Zw09QX0PnrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51tsQLUeZ1+7xVJ0P4mwoYyGJCahDjvkj6tAo498tR4=;
 b=ox/QlZPDoo+e8Q57f/OSdpPn44KKhx0lfpmW9uHtZSlzdBFJta97048y7EdvavcAXVhjJ8WFhz9pgiiE7IroIpFd/eOTrGtJz+54LKjGssOCiwWMASPR5lCcmC2dh6Xz4STzn/TsdGSEtQ5+TXfYFRX26L9QyodOsEqnpCuC0Ts=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:07:04 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:07:04 +0000
Subject: Re: [PATCH v3 3/9] ssh signing: retrieve a default key from ssh-agent
To:     Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <b84b2812470ea45a85d624ec339f35bb0107493d.1626264613.git.gitgitgadget@gmail.com>
 <xmqqr1g0ve8w.fsf@gitster.g>
 <CAFQ2z_POEE3F_WPAPy4YRRnZONvsg=MOPmti2YT0me+M7eLFvA@mail.gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <ddaf5adf-9219-f462-70ee-ce53ac5d3cf9@gigacodes.de>
Date:   Thu, 15 Jul 2021 10:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAFQ2z_POEE3F_WPAPy4YRRnZONvsg=MOPmti2YT0me+M7eLFvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8 via Frontend Transport; Thu, 15 Jul 2021 08:07:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbce65a6-7c44-4c4a-07e9-08d947678852
X-MS-TrafficTypeDiagnostic: PA4PR10MB4591:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4591FA6967B59F861B1C45F3B6129@PA4PR10MB4591.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0iX7aGkv1XgFwlmP3FukpsnuPl/HZiv5T9l2vnH4XcV6IkMVz5sA56++pRiUs6Q6dL6ONWPisaD6b+E3hnX6tUGJzOKbUugmEYRkO1c22cgp5J53vnFPXtc13YZ1DXH+zTU+oeucrcXPmbyNJ991hxYwdAnjkupBEoOMVterYP41nRvYUL4aXOzh79PCiNSkY2XjvfmUvoWPs7ub7dvsBptIm+dBNwSTx2SPWMyz8BXsOSurjXYhQNkoOPPGsvf+ZWLFQTFmFLhwi3++Tj+LmksJY5h91HhR3xNaYunGeRcixfaG1WjJU5itu5uQb6Saq0upWQo0c9rdfoBnCRk2gZ4VZAKZFanbVTrjaw80abFvEt0uJFrhMn1gNo92hXla6zcBFZ3ybEDW89K6YA8g6mEMJLXJVG5QyBZkpefZTRMml474194TKXiYxCemsK9f1kg/8bH6T1h2b63cei9ap+8qkpABClWehxa/rLcNOCuqJuOmt84KIAFqopspn/pcFUjs28X/KUJvkHk1Y3CfMP9KErp33tI6aYB95XirbNtu7GH8QIpS+2Bw7o7GJuuLLCgg/VwuMjJ0Acy1xZiFl5l2tAKBv6VgCp4pmY/27sYjpFeavFIkF3tkgw40bAoU8j+AtVIGBHtzPBIauFuzJwvs+4jGYm6sKF4JdJzw0whaDi4ml9N2mWdhZin+2Bte9nyiBzdL5T3WistLuJzBnjUn0pWOA1s5xe92MSiVU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39830400003)(396003)(136003)(31696002)(53546011)(52116002)(54906003)(86362001)(186003)(83380400001)(38100700002)(66556008)(66476007)(6666004)(4744005)(66946007)(316002)(2906002)(478600001)(5660300002)(31686004)(8676002)(8936002)(6486002)(7416002)(110136005)(4326008)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTkwcjFxc3Z5emtiRGd0S0twSWlGQit6R0tXQmw0YWxCU05GdGZ4YWI0dklv?=
 =?utf-8?B?NysvRjVrNjBMTFhRNVZLaDRlOWl6N3lFY3RiZDFNMWlvUEpndEVLU0hmcmVP?=
 =?utf-8?B?Z0U2YWhEeXllMlZRVjA3NTV0enJ2bEdpUWJiM1RjZjN6VXhzZ1UrY2Z0bmxE?=
 =?utf-8?B?WVpTeDlZSDd2Mlg1b0FZTHZxbG9IR1VTY3BoWjdNYWZubmZtVTVaUHl4Zzkr?=
 =?utf-8?B?dFdQZWZoTGh3a1lKbWhtcmNka0RBR0o5WmpScy91RnJyT2VMQXh2aDVhb1F0?=
 =?utf-8?B?SXFIcG9lK3JqaTBoK05NcEdiTWQ5bU1iMjJNbzlnOWNrMTNnVkRLUDZkSXVM?=
 =?utf-8?B?Q1N3QitIczJmQTBzSEYrdWNhK3NWTE42RzNraE5DNm1NN0ljaXJmMGs3cFVh?=
 =?utf-8?B?dXM2OWc0d2puRi9relVuVC9zUkhtTFdkbktVQmlNeTdkSVY1TWFKbVJSWGxF?=
 =?utf-8?B?ZjhoSUZxNkpGWURTUWFpdnZ0SC9EbFg2R3dTQ1BFMmdIUG9UVGdMcWRISFZp?=
 =?utf-8?B?V2ZIS1A3TkJCZWYvNGIzNzBzZ2JZbm9ETjN6dFh1eG5vSWttOGNwdWZPRmpL?=
 =?utf-8?B?amtJV1BQbTc3Q3IyMFpPK3lGcUsrbk1lOFhMZVBtOXlVK1VIVGh4Y3F2MGYv?=
 =?utf-8?B?dngzc2tXVFRQZE9CV0szdXpVQS9lVWlZdEJIQ0ZiWStFaG5sR0ltMkRLUVRh?=
 =?utf-8?B?L1Z6NWQrNy9GV2tQRUlHMkhJSVo4dlVNTThtNjZyOFlNemFkUCtONEZDWDJJ?=
 =?utf-8?B?OTA2eWMzT2JXNmRNWXJlejI5RUtQRU0wUnRpL25scW1UaWNBb1VmTE5XajlV?=
 =?utf-8?B?M3Q1Q20vSXlFVHRCWDdEbnFUVUROUEpsZlRjSUs5UVo4dmYrQitjZUt6ZHAx?=
 =?utf-8?B?QUhSUGlKdVdhc3FMWjViVk9scU9hakovLzlJTjI3c0xqUGg3amJwTVNvVGdJ?=
 =?utf-8?B?LzdXZ0FkSXpzSDJPRWEvTnpCVVNOUEE2ZnpWVWtSaTJnRmdROER5S3pxU3hY?=
 =?utf-8?B?cjFwRlFOYjl0QzFPR1FDVFU1U0h4R0pyQVJTdTVIWFFVZkF6ekVUNm1Za2ox?=
 =?utf-8?B?U1VtL2pFaUlaUUFlL1dGQkxPa0p6UktEZjhOU2l1bSs1dlpDc1RXU2ZBRXlW?=
 =?utf-8?B?UnUwUWU3N04rSjhnL21ydmljc3l4YUcreXJ6NWovTERMUm5Gbitnd3RCazls?=
 =?utf-8?B?ODA0QjBPNzRkRFpOY1lZMXpmRk1TZ2hsNm1iOHgwTVNPQWc2NmF5OUxEOU4w?=
 =?utf-8?B?VWVFQS9oQUhRSUdJZG84N01MRG9OU1VlaHRKTkUwZFFRTS8rODAvaUZNZTNw?=
 =?utf-8?B?K09EbU1tSUlESkdKL0dDMGszZDd3K0tnUGFHbmF3YVhmekNnckRPbEV4S2Jt?=
 =?utf-8?B?TjAyV3JNV1FEbWljSDE3VDBGYnBNNTZKTXdtUWtCVUd3UWNDUDJWKzRTNW42?=
 =?utf-8?B?bmhvdXlUcjkyZlRQY3d6MXVHZEhlMUFQRFI2SVI0QytUMklXeUhZL2tIa2la?=
 =?utf-8?B?UHQ1Y0wvZjFQQjJ0eGhKRkxQUFdmenIxZ2JBQXo3WnFaa2RLN2ptWkNjTTQ4?=
 =?utf-8?B?N1c2NXZySHZvVmp4VHo0SWF4R2szWGNRL0tQUFJqemJxckM2M1hMMUJvY1Zr?=
 =?utf-8?B?aVdyb0kvSllNYTRreUI0VHVSUFk2ak5LelFNWDYxTzNNNnpXTk5vK0pxcTRX?=
 =?utf-8?B?WEltRVBQNXZ1cWwxZTdTVXhrbndJM0hybStIOXFRMEhFdnNCZm8rTEMwdEpu?=
 =?utf-8?B?QnhNWWdZRXdMSmduWGd0Mk9NRTBRdkNOTENKc1hOQUU4SXpnaFhDZ1BlTDFq?=
 =?utf-8?B?VlZTbWF3QmlURVkzeUk0SFFZUzluUXJnK2tEUWRQd3hlbHhZRWhJQVV3bVBW?=
 =?utf-8?Q?27U/ZbdvmIK4e?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dbce65a6-7c44-4c4a-07e9-08d947678852
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:07:04.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFgZ4/ebWPvAiJACe/K64GWy7+DajfkPMhxF2O7Vy9R3+LU6S1LxhnLum49aWp9B2FXmG2zAxVi99MpQ7B3M/ewdA7CSobxzrRUGieLFU3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4591
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 15.07.21 09:49, Han-Wen Nienhuys wrote:
> On Wed, Jul 14, 2021 at 10:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> calls ssh-add -L and uses the first key
>>> +/* Returns the first public key from an ssh-agent to use for signing */
>>> +static char *get_default_ssh_signing_key(void) {
>> Style.  Open and close braces around a function sit on their own
>> lines by themselves.
> I recommend using clang-format (there is a config file checked into
> the tree) which handles most formatting conventions automatically.
Thanks a lot.
This should really be in the in the CodingGuidelines and the 
MyFirstContribution docs.

Especially the clang-format-diff line from its help
"git diff -U0 --no-color --relative HEAD^ | clang-format-diff -p1 -i"
is incredibly useful. Otherwise people will reformat all the things ^^
