Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B596C1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2389D610D1
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhGOIQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:16:12 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:4289
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234408AbhGOIQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 04:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccGd9TBn2Z+nV8SEC8bHRigQW9c3ga/osVykunnCnosY/FEf5pNJ9FVqA66nr+S+s749zIzy/ajRlAkYONwno4mz+G92SDUfao+V/VfJiBeZpr5jR2Vsekz92TgqNqnhHnirXk4iB0ta+C8+nF6WxbPNdHDW+AUZePUYP12FXFdIbqTszbGXKjKZM8AHR6PR7s9sqQvAT+wapGYNSDgESP1Aw62N2514kYgxyzLCBek0XOrl/QzHy21djyhSdujn+CLcDqcr0Rc73bDbX4bxfGhtQU+yQ33w8+wzDXbPFs/mPGIo4P5vEqAzvz9JXG4bVZijBJYozy/kzy4nR83H0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErSS/s7/wkNddGzbzfYQNbwR9jMW0ovxYbD9jgUtks8=;
 b=H+CaE5irz6NH74ZkIhNyoFZYFQ2gyd0DTR7nC4P9PzkoD0SfF4cVlwQMftkOxHUoq7kwLQQ9qL3usIpfKZgfjJJjCQgmYwh94PSErpY0yclbGqGwyZDTlgWFl8UEGUqePz2Q2Lfe3GwuyKr/GHw2ZZkF7eAYwOt0lXMvzG/aNrYSwCO6nXOUqMAEXMq/cEYvaHiwIwSLqE/S4hmjurLEzJuWEb2YxYku/xSS4ZM+eeYqOaKGdois/QkKTeUcRIPOjUeZ18AEhxrB9mEerIbZnnr3m8sYtIvfnFIgZ44tcBooQQp0PHnjyK9UGgK4klm+Ry3cM9MF4HRkLRlmtYQMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErSS/s7/wkNddGzbzfYQNbwR9jMW0ovxYbD9jgUtks8=;
 b=tlKwwVhoO0aW7AcX2k7AuiFy85sPZVuvJRGIPyuEjEmp+mUhZ7f1Mk6K0BBVCXzAG46q0XHAGHdYv8P6FXDJpG1H1hiEP2VAlczYVnpG9GqYOJiiEeIYY+sENygcQybkkO4awcIzrADERVzx4yGZTGg/qUz+GM5T9aMEA24HHHY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Thu, 15 Jul
 2021 08:13:14 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:13:14 +0000
Subject: Re: [PATCH v3 3/9] ssh signing: retrieve a default key from ssh-agent
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
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
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <b8cad34e-8969-25f5-1b29-30c60cd27e7b@gigacodes.de>
Date:   Thu, 15 Jul 2021 10:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqr1g0ve8w.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0121.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0121.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:13:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e09f224-e608-405e-df46-08d9476864d8
X-MS-TrafficTypeDiagnostic: PR3PR10MB3850:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3850328D3B5C363E0CC77C60B6129@PR3PR10MB3850.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB0/ssuGUpK7Rq3nQti3IniHkQr6xw92gwRFgE9YOhPRsQ8YzZ3WWjFeUWH7WxA1pad3Ouj1sTJKunBtNnEP5zSs+H70oA5spY7JQ4xpApHWC2+XvJpfrNDpwk04FnVenDbJuzUQafgVjAcv3UCWyr+8QIapw9qwx2c58uy/zOtVGkJUcf5PEA7eKpI+pX3XbiaNW7dXKjgtUxnRslU4JU7VMDrgFy4KZGWJ4cXrN3bs+W3/dy/NOUuMn5ZyiITJt3XC931G1VUm6fewYpw7T19IZ8MhxCUvheSFxtuxMPXSntDwetaKdXjYp/a7w1u0783p4bafTtWulxEttBBCbes8WP/fsjQfsnTwgCf+98rbVoE4nrSC2EQe4GMRzA16hSsw6AaSSzM38Io4KoQAC9ZwLIV6FGFULIuGHLefYMK+Rp9gBM8iBkH4HBAw/iiYaIGf+T5fV3oOPKueD1vxAWT/ViKxGsDHxeValdyZJDZOT44ZV8rNmHCZMTENa/x//VnVlbFcmnZr2ipkiOU2YEceYwEG3X7Tt5M6owF9DfI0lPnpyeYU/CJG5VS8x0UkoDTyBDEJLOqWXVMaO5HDQk02ne6FJfpzxLraL2V0e6hD6xgLr/R+rvQ8tN3vu30iRgtPOMCioOwZMCupDnubT9CZGfyPpkxUtzPzyF5IsmHCA82LdftdjYfnJ4Z9eGIzi/lodf/+BB5cVwiHmq4b35BhFdBHCiR1u0ZBNldDBw+s0geo2WzI2cGVa3PMQ58+xaTfHDDh7ZlZichIWfrplTKmajqKNdE1PGu2zrJ2dUSRUtWkSwSZbMUTceK67Jn/uKdpNjqR6jnaXakhjRkVqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(376002)(366004)(136003)(346002)(5660300002)(6486002)(8936002)(38100700002)(7416002)(2616005)(31686004)(54906003)(66574015)(110136005)(86362001)(15974865002)(4326008)(66946007)(66556008)(316002)(66476007)(186003)(8676002)(36756003)(31696002)(2906002)(478600001)(53546011)(52116002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVIeDNtU3pCVGZBbllDSmdYZUpud00rY1JXSFRhR0xIVVZOcVNMOFZCckVo?=
 =?utf-8?B?SmE1UWpQM2ZqSHpaNkZyeXdRc2xIQllUTVpHNm5tVythRlBpV3BPZ3phWjVI?=
 =?utf-8?B?R1lsRTE2SW52cHBrNGJxM05QcEFNMkRMajBIZGZpYlg3U1RXdjV6RFR5UTZz?=
 =?utf-8?B?dFA2VHUrcURmUHgrN2YvZng2b3Fha1JXdzBiN2xrV1ZUd0JVRmdRRU53cDVY?=
 =?utf-8?B?Vm1Fem5jbGIxRCtxTGNRMTE3WWdoeEIzU0g1UUFWc2FlWk9ndkFkK3NpbmlD?=
 =?utf-8?B?aXc0enlZcEt0T1dHTEtQSnpPbEE1MkdhbTEzVVdLSnFWUkZQS0hyZEV2d0l6?=
 =?utf-8?B?ZGlEb1AySXNNQmM1bndDUy9MUndreDkycU03N0s3MUdwbExIbklqREtRN2VU?=
 =?utf-8?B?ZFZxbGlIV29aMDY5WnptR1lMdVBmNU5LaCtEcnlBWlVEb1BEODU4Q1MyY2p3?=
 =?utf-8?B?WHJxUldPcVBScGJPSnNjV2tHUHhoTTN4bFFSalFUSlJWL09iVEg2RzQveXhk?=
 =?utf-8?B?ZFFJemsvSk91OGpvUVFrRFZWTVE0b0JKWjhXRHFLcWlzNGlCcTZoOEFlL29N?=
 =?utf-8?B?a3FMQXhOT3owNmNyYi9uL0ljcThsVGp4YUk0SlM3NDV3SDVMa1ZMaE9xZDZY?=
 =?utf-8?B?MDdyOWxLQzVyVWoxVEJKdmxhSGtaNVB6SnVyZDNEenA1NFAvbHRwczkxZWdI?=
 =?utf-8?B?QXJQQVREKzl3RzB5dVRWSEQ3OVBBNVJPZml5U01mOEEyS0p1Zy9pUHBoK3pW?=
 =?utf-8?B?bmorRU9BbmVxdXlnQnZSdlZBZUp0aVdncVdlYnpPb1ZPQnhTSXRVZVNkQmlS?=
 =?utf-8?B?QkxtYnh0K3hQTDdRSVZScVViaWZqdlFXRzdDYTIxOE1kUXA0dnFlNUJsNnJr?=
 =?utf-8?B?dVFjMUxDQzRGTlN0Z2phMmhSOTgwOFpSb1lpM1JaWkR1WFkxNmhpRDBVTHh6?=
 =?utf-8?B?L3VRWVRYYUpNQ0ttOUFDaTZ3RzhKbWcvTWVWVjFhc3plSFdIR1ByMExpSFRO?=
 =?utf-8?B?WmhuZUw4c1kxMk5LdkNhOWRZWkFETjlqNGZ5a0wrRDlzME0xdWNuNzF4ZE1J?=
 =?utf-8?B?NzE2dE1sVW5FSSt5VFQ2VSsvTzlpa2tSa0xOZ3VqaVR4N0s0cDdNYlY4ZFQw?=
 =?utf-8?B?elBoTzZCTGlzUlNyc282RUVMa204TENlci9JWFdpZUJremt2Q0NhT01nY2ll?=
 =?utf-8?B?d3RaU0M0aGVQMVFNRmRnVHlYUktWK25HZGdJSmNhRkFVRXFGVkc2RG9SYzJi?=
 =?utf-8?B?WWRiaEtvZm9QZnYxdEx2cWk3R3AvSUpOL2xyblhubUQ1MG45N09ESGVNa2VY?=
 =?utf-8?B?bVlMYStyb2I4bDNMaXFMbmRoZ08rZDFOZVFPVjhOc3NiVlZDUmVZK1o5akhH?=
 =?utf-8?B?U0F4bDVnOVB0d21uck1tWGRrb0JQZFJXUjE0Q2NyT0hJeE1XckJMVVYvQjBV?=
 =?utf-8?B?OUV6Y1dsRXNJV3RJMlZvUUx3TkhLMHlhQW5MQnIvL3F6UTltY2wzcGtVWUJw?=
 =?utf-8?B?YnRucmNPTjhKcm83Y3M2YlhLNXRJTjdESFF3UkwzZTBpWHFCdXhTRUFlOFMx?=
 =?utf-8?B?a0cyeUJQaFUxY2FIeCs5cFNCRnJ5M3NqY0dYbDF4ZWhqaFRHbHdWUi9OLy9V?=
 =?utf-8?B?enozWWVJMHc2U2NNWE9neWpRN09kVUNDRU5EaERNN3VZanZEamJ5OTNUWW81?=
 =?utf-8?B?U29HY0xHbzIrT0dHZnR2SFF4VXM4VTZKRVFadTVyNVNydnM2d0RiU3NYTkl0?=
 =?utf-8?B?dkFNNXYyTHducHlDS2FLNHdObzM4Tzd1ZDRBOUhBSXJXRkltc09oNWw3SFMz?=
 =?utf-8?B?ZVNtblZFK0huYmtOcGdVZDZGa2RGV3ZlWWNGRlo2Q0V6MWNXYnd2RVdFVVlT?=
 =?utf-8?Q?KXGzzSAco4eCX?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e09f224-e608-405e-df46-08d9476864d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:13:14.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oPghfQzvx+a/sTm6IReT6KM1uDToW+2Mjy8cJhwVKPzEa4kv2vYefJMU+lbx8ywz6JamOlNUCCU9N4G7YonPJj8cV4eir4CF+3M5bi1F2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3850
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.07.21 22:20, Junio C Hamano wrote:

> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> calls ssh-add -L and uses the first key
> Documentation/SubmittingPatches::[[describe-changes]].
>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>>   gpg-interface.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index 3c9a48c8e7e..c956ed87475 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -467,6 +467,23 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>>   	return 0;
>>   }
>>   
>> +/* Returns the first public key from an ssh-agent to use for signing */
>> +static char *get_default_ssh_signing_key(void) {
> Style.  Open and close braces around a function sit on their own
> lines by themselves.
>> +	struct child_process ssh_add = CHILD_PROCESS_INIT;
>> +	int ret = -1;
>> +	struct strbuf key_stdout = STRBUF_INIT;
>> +	struct strbuf **keys;
> Whose releasing the resource held by "keys" when we return?
>
>> +	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
>> +	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
> I often load about half a dozen keys to my ssh-agent so "ssh-add -L"
> will give me multi-line output.  I know you wrote "the first public
> key" above, but that does not mean users who needs to have multiple
> keys can be limited to use only the first key for signing.  There
> should be a way to say "I may have many keys for other reasons, but
> for signing I want to use this key, not the other ones".
I will make the commit message clearer. This function only provides a 
default key in case no key is configured in user.signingkey.
If you set user.signingkey to a public key the correct private key from 
your agent will be used for signing.
>
>> +	if (!ret) {
>> +		keys = strbuf_split_max(&key_stdout, '\n', 2);
> Let's not use strbuf_split_*() that is a horribly wrong interface.
> You do not want a set of elastic buffer after splitting.  You only
> are peeking the first line, no?  You are leaking keys[] array and
> probably keys[1], too.
>
> 	eol = strchrnul(key_stdout.buf, '\n');
> 	strbuf_setlen(&key_stdout, eol - key_stdout.buf);
>
> or something along that line, perhaps?
I have changed it to what you suggested. I'm always a bit hesitant to 
use arithmetic with string pointers.
I know its simple and efficient, but IMHO can be hard to read.
>
>> +		if (keys[0])
>> +			return strbuf_detach(keys[0], NULL);
>> +	}
>> +
>> +	return "";
>> +}
>>   const char *get_signing_key(void)
> Missing blank line after the function body.
>
>>   {
>>   	if (configured_signing_key)

-- 
GIGACODES GmbH | Dr. Hermann-Neubauer-Ring 32 | D-63500 Seligenstadt
www.gigacodes.de | fs@gigacodes.de
Phone +49 6182 8955-114 | Fax +49 6182 8955-299 |
HRB 40711 AG Offenbach a. Main
Geschäftsführer: Fabian Stelzer | Umsatzsteuer-ID DE219379936

