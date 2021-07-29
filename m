Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE2C432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B0C60BD3
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 11:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhG2LDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:03:31 -0400
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:3393
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236087AbhG2LD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 07:03:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWk0smj1nPTTOlX4Qb31uJGInddkPBVz7RxczwfXpQr09rb+I+WAxH8SLZ7JYBEnWgl8/k0GZph8UE8KlMlefgC/XR2u+3sVyqssUfYt0jTWOiOAjIndLNg5h1LRd2z/rnkEGKGNIR/JYUYzcgVMSyd7IdPps9L3qsoWbPsh6OkdGexloIDDGFBjNJmxZnYO3HKTQNMB6a7JaSGhwx/m27R3VrBNnoMfh6FNxzkavZuaIil2A489IVs4BiBthSBUnl4pcIh2ijFxGlRC/4t9e8+9WrQsvkFkFRYsFctXIBkugRYcCPODDnHehWnTKhK2L79f0P0Y9OBsj8ZjJi+gcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RvANQb2LQQMUIeG6oDKWcHTrh6MqYlxSsMVKSrJhhQ=;
 b=jj6cIwwJIflr94szLKsPA8MFjpSxR/JvJHbe8VIctBj30WqJdYryb3iV71MIpiumntgeXxpYwHKYWOzdT4ukORmxGkH7SmymqMTrg4AFXbGmr0moT5hljhoDrTNIZsjolPN3iZjxNAgQG9XrSzYVSTkk1g0zFUAVTXmmv0W8ztUuadbRjTuV561K2+Xh6ShJ3JeHJLge7TakF5Qi+hhBrxpr4mdYmGXEETg+haRrIWn7Srwi+3/Hc2zWpRnEmAav1VsANWbOraNoyNSgzHeClMH5ywK+Y6H6ZRDFkMKugSH9967yjMNhNKHYnk1uNLgwgZmCxG9tFvOkqByWHtOyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RvANQb2LQQMUIeG6oDKWcHTrh6MqYlxSsMVKSrJhhQ=;
 b=Tv2bsAzWSgBgJa7FrRwQysygkvJR9pE1L2tHWnrCJoHfPUy4+QqN2+YUB7nhX6GNSMYrzzNyRNKoY5JOEeqkqbhqfj5RMmyfEieUJhcS8n9uZB27Zy+V/lR0tz7sXkzrIuSoRjbN08wGz8HUlNK332r15xJI3dqQR9W9fQnXzaE=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DB6PR1001MB1126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:65::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 11:03:23 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 11:03:23 +0000
Subject: Re: [PATCH v6 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <6b244afb-e4bb-c613-142a-4baba1149de3@gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <7689f8c6-0ac7-0121-4034-c8747edaad05@gigacodes.de>
Date:   Thu, 29 Jul 2021 13:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <6b244afb-e4bb-c613-142a-4baba1149de3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40)
 To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 29 Jul 2021 11:03:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f962adc-9b29-4659-5f8e-08d952807ba2
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1126:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1126661369E01A72E289191CB6EB9@DB6PR1001MB1126.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGCVbNks1ncRnquvAS1zCc98c44fZcX2NKYkqDSXcR9ojSgCgAj6qD8R6bHBOX0m68nBgcqhorYWM/TqF4rxJFWkcYNLqWRbQ7ZWy2iX830mfJoamSjslPsYRk1drO7w0SosCmMsJVBu+JYjDhCDUozODx0mxUyQM+rWcRorCOSCUfMS2X6s8MQgpV+D3XsCOLu0JeyZiugAbiHrw4NfQ14eHG5WFZaqhZpESyI/FrfpwtIG5kDHa+kWY0w2f6wyVJDA9TB0rBfln/1g+GCB02BqKVcq+IWSNDhRb3QclH1uuzoRxrx95iQ4uGO1J7fRxe8jIX+tzu0vvESdaAJ7sZXO8WvojAzSg06CRBjxkDCRPLJfUewjfIy/D2prxTgfeqJVIsB6LVeyviHaEoXVDjrWZe4qtjM8MQ0Q2jJ8K/u/XgTuerY9Mcg/Lv5Cx6E3OwrixrHEcTyVjMkOqoX6scfzM/QSXKjNcyga1pk4zOEEKgrtUcW41WWeJiS1SoQOY43Ume35Rxe78GaavwDKhZZmi3aqL0UlkceyZL8XV7JOmsP4moyP4QCeIry9irx534iMFCTFS/6aAkzDCFMVgy90QjMcqfo2GOqtVISRR9t6S68y7nit74JGc15lezcAl0upFkVHuVa0d7Mt7QdZ+0M8oZMs4wZbb9YCHQGzynLDZtddXIQx59ilC+C+w98h2FE5uSGNcZM9BgzkksXx++tVaBu8cHvHyJCnmv3rLMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39840400004)(136003)(366004)(54906003)(31686004)(6666004)(4326008)(66476007)(15650500001)(478600001)(66556008)(186003)(8676002)(5660300002)(66946007)(8936002)(53546011)(31696002)(38100700002)(316002)(110136005)(7416002)(2616005)(2906002)(36756003)(83380400001)(86362001)(52116002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhNUkFEaFZOWEZiQTRkam1xQS9SdXhxL3k5RDY0NUpBdUJuS1B1V0xiRzJn?=
 =?utf-8?B?UzZ0bXh4TFFhYlhkK2drM0Z6WGg5VVgwa3B0YlY5WG54QXczaFJQUUh2a2lV?=
 =?utf-8?B?S2hyUUl2Q1FjQjR5Y25UTWg1Y2JRZng1Ri91U1g4N0NtQWp0c0RhRDd1akNJ?=
 =?utf-8?B?Qk1PTHNVeGEycWJ3OHNVbUdmL2p4UW9HM1hVSlgvdmV5MHVRdnVyNzlVYkpj?=
 =?utf-8?B?NnVhR1Z2dVZlUmRKQ3FONVZEam5XdzUxRFlPNEtBTkR0VElKSnp5SldHN1N2?=
 =?utf-8?B?dTNhdW1NYUZqQWVBZlBSYjJIc0ZQUEN2NXhXQy96VUErbkNWcFEyczJYTVhj?=
 =?utf-8?B?K3Q4NTJUZW9RVUl5Tk5YMVFGdmVDTmM3aUNlU1BFWk0xY1o1dm5ZaWlUMFVv?=
 =?utf-8?B?RTZpdlorcHdSSERaNSt0bk1OQ21TODV2bGJxWHV3ajBKb2gvK05hYXVtRlhQ?=
 =?utf-8?B?QkZVaW96MWNYTmZCb0ZybXVIalhIZW9HZzc5VVdGcU5jS1kxaEpRelVNM2ha?=
 =?utf-8?B?dDdlV2Vra2NjYktyUGFxd2xyUElVWFg4aXFlSmN0MmZGWUtaWGxlSGtNOHgw?=
 =?utf-8?B?NzA4dXRVYU5GZ0prZFBMSzA0aGZNSEtFYnB3TnY3bytSeTRBY1kwUjJHRFQ3?=
 =?utf-8?B?THpwTjVhay9sUzRrLzdhenNpRWd3YUF2T2p6Y1BzWStMU3JVd3YwTTR4eVU4?=
 =?utf-8?B?TnZpT3BuMklWQ3dWTjZBZlFCQy9OdUZwZWVObUdDdzlmR1J3WUdhamYzcTl3?=
 =?utf-8?B?M1F3emJBS2xzN0pFWmNFR3JsaUlobi9hVW1NaGQ3SmFpdGxTV29Fb3dQM0ha?=
 =?utf-8?B?V0IzbXNxa3kzT1RvVkNJcS9HT2dPQktCYUVRU0lhWjB6c3VmTytLaWl0M1BM?=
 =?utf-8?B?VC9WTFVMY3lEdWEyWEJIV0FTMi8yaTF6NnV0by9RV0ZGRTAwQzRFZXNEYnE2?=
 =?utf-8?B?d1V5Ry9QZ2Z4ZjFvUDk0TW4yU3E0b3I1clRWanh5TzhYTXQvNUVkQkZGQU9C?=
 =?utf-8?B?UDF5REJaaU9hOGlMS2tFdEo1QWFZN1RzN01Oa0t5d3RyOGNSZUN6aEVKUEZ2?=
 =?utf-8?B?LzBSSCsvQXF5Nm51d2p4d01KMGxpVFkyRmNYWEdZYVY2SkdUa1E4RUNaUVBP?=
 =?utf-8?B?dU1rVVE0NnNuTDZSNk1FSFZ3U1lyYXhMWnZpenpoS1JuNVhDcUcxZGN3K0hs?=
 =?utf-8?B?RkVCbFEvamlETlQyRXk0bHZuS0U0VjlSVUI5NjdTeUJmUGN3bC9ZYzM0SWZw?=
 =?utf-8?B?VU1MdTBkTWpJRHd4Y3kxeFE5TmNvTkhNSURaQWFxWGt4VWVUSkZCWXFac0Vh?=
 =?utf-8?B?d29mRDJWVTZrMVZYb3VuSFdoQmFuS3Zqd1FvYVNkV1NQQkh4RHRjMzQrZTlM?=
 =?utf-8?B?Y3RXL2dRY1pXbGhkWFVHeDU3T2NMN0tGVlIzWjdKSk16SXlKTFhaendVWmZB?=
 =?utf-8?B?cXlKR1FCb2IzNTdqdkFCL1ZMZTV0am1nSTRoMFZ2YkVTYjlqeVFGbDE1SU9S?=
 =?utf-8?B?cDhkaHdrQ2MzTHF1VWpSb0tiVVdRVUhidGx1cVBoTmtZdWUvclorbWVlaFBS?=
 =?utf-8?B?ZmxqNzZoOEdKWTRaYVl2NTVLQ0pyUnJmTlNyUzR5Y2VoK1ZCYVFCbkczZ0xs?=
 =?utf-8?B?TkkwUkV3aUg5VEdKRU9Fait5Rm5MT0tCZkNvaS9PaCtvVm8rU0xtSnk1Y3Zy?=
 =?utf-8?B?WnZtSzZXZ0w2ODhpbVBwSkpCWDVBV2piMFRNR3I3VGxxRTNoN3hJaVZVbGlI?=
 =?utf-8?B?MGh3dHMzazRqRmJ1bkZ1eXZaOEE0TlYxTXNua0NPWkh1Qk0xREVDZXpUNktS?=
 =?utf-8?B?b21WbUV5cUMwZ0ZPaEhXSDVsc2N2K0l3dzZFYlN0dy9NME1FdGwvNzN6N29E?=
 =?utf-8?Q?qHwN+DMoM1plq?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f962adc-9b29-4659-5f8e-08d952807ba2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 11:03:23.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LlVdfMIAzmZ7zThpqpL3dp20laZuVvPlnvfZR9FtszwJ5Tfjpg7pDMqDZ6JUi7+Y7PiBongg9H7A4AzbJnKDCady6OxcHbYT6MxJGIpZRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1126
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 10:19, Bagas Sanjaya wrote:
> On 29/07/21 02.36, Fabian Stelzer via GitGitGadget wrote:
>> openssh 8.7 will add valid-after, valid-before options to the allowed 
>> keys
>> keyring. This allows us to pass the commit timestamp to the verification
>> call and make key rollover possible and still be able to verify older
>> commits. Set valid-after=NOW when adding your key to the keyring and set
>> valid-before to make it fail if used after a certain date. Software like
>> gitolite/github or corporate automation can do this automatically when 
>> ssh
>> push keys are addded / removed I will add this feature in a follow up 
>> patch
>> afterwards.
>>
> 
> I read above as "set valid-before=<some date> and valid-after=<now> to 
> limit key validity for several days from now". Is it right?
> 

no. "NOW" is not meant literally but in the sense to add the current 
date when adding the key. I'll edit the description. But this feature in 
general will follow in a separate patchset with proper documentation anyway.
