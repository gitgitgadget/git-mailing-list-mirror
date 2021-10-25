Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BDCC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B70760555
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhJYIln (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:41:43 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:15428
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231940AbhJYIlm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 04:41:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcO5P2maGWFwmKaotfc8n7YdQ7VjKIDFvqOiWlj7gRLg7arYxF1NRMYJd8BCGTFZqIg9R/sDqmWAmpE89fiuyIw9zjUzme9pyO8bNG+ItVAUmGc5Aur+tWPiJDklr4G0ZKj5U2wBtXSbTy3GUKjQEmmziR08i8FuuUN52hN7i/Gmxnurz3BxuQLB17Zr8t4OdPuZxoDfwhZg8jE8zPEInea8aE6uMi76o/2+slLdyr5Iv8MP0oT6XDgHmZkVExY7hXLDqVQM/AE2C1V/YJqf7pvdwczYzC1WbptLk51Ldixp1//NdJhEaBWKScROWaFvstH9+oiO2TJbiPBlrjU/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92VHDI9XNyLXCjBQ4RsMPrHSLSWC5QO0BdOcJ5Jkjlc=;
 b=OKkai35LDui5u7FYLu/yu+UuGs+Q/LxZ/CP0sN0gCx+ZNCo6lZymSMYtisDXLYw2dsQTwWVHLqdyJJTRf/75mPLW0KBmz481d0Q28o1AtZ7Y357PPaBddetEmtxd695EMAkueoFgWV2QGrJDaEVbjUP0MBkJoOl6Tut39cA5fQ0dRxzH82i2ewtB3P405GZpGu7szz6E2JaYRhkbgJxCEiIwzl+5ORqDPml49AeyhivboARQ0THq+MGjiozgSRB5jIQsYfGBIu2lGSi+yZWAHx1OV7VNps+5Zgt/qbJB/4/2ktUMXNIrIgM3x3YbrJ5pgrlqKo0vgcnziGpjYFCEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92VHDI9XNyLXCjBQ4RsMPrHSLSWC5QO0BdOcJ5Jkjlc=;
 b=bcMkoJMUAnwqwzL0EGQvbkRFsPDlbbGXsqTS9UmKof5uTiAAo+Aw2DQR84AOPQuQkKf23VssaIzHVnstwFo70aLagfh16+Y/usQVS4IbLlxehhWG05M7IeZ57C6i/FMhgpH9IRvPFHZl2t7h6JJ+5++Oi5it9wqL1NQJ7CZDWDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:39:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:39:18 +0000
Message-ID: <8ff17f0e-9877-1004-4057-4f4af21531a1@gigacodes.de>
Date:   Mon, 25 Oct 2021 10:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 6/6] ssh signing: fmt-merge-msg/check_signature with tag
 date
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
References: <20211022150949.1754477-1-fs@gigacodes.de>
 <20211022150949.1754477-7-fs@gigacodes.de>
 <211022.86a6j0kjoi.gmgdl@evledraar.gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <211022.86a6j0kjoi.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0090.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P191CA0090.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e92bcc96-1d3e-46cf-c4d6-08d99792ef56
X-MS-TrafficTypeDiagnostic: PR3PR10MB3899:
X-Microsoft-Antispam-PRVS: <PR3PR10MB389998FA01F1BAB16F98B27AB6839@PR3PR10MB3899.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaC401JqkxqIPGA2LJNYL0iCgAsC62PW+eFndlY7hZmXi4F3GdAx0331jZcEyHAmQyryQrIbhlFz3Ljbz3Aa/Ehglj9EOD7W0IJzLOJkM4UjPWxRI3syJ7T8wtbxuMTfCi1aadaE5WgnIGqdvCPdua4OpWm8Hqa78TIx5jSi8uUsPkCrLmpy9TREokUoFxWIn+55tVnnbwsvUxmeXDKVVst/etk4K3mz/YjMPinNS7HbkBRPKL4t47Uf9A4qy1zEPwwga3GZrFdMELbxp19w8Mra3SICCvkWYdl/5Qu8oSUHaScBWXwxW0y7JHDQC5ZGr0R+9nmSGM8mc1oZrNoUyFOkX6y8c82UAivhBvwKvTbIkV0I2fxtz4lcgrP3mSCLLHlvmxOp6qszkyrYIm84S1QekMOYxquqXZKaxljpVyueWUiQhyl5oIXY4QhV/yeRduolds6Y8Ex5AgbBOuv83gV/ssn5+F0uahQ9KncYrmKn581uRxvFsmVpGP4Qo4IHhb8p/snfjyYNTMjKqDSg910gyQyUw7EU02VQuqvNBzLA2udwyS3vsOH6SSxA2pOJX2ZxSVMFkhfJbW0qdQRSnvC5z0pCzwsHZ5E5Mxtlj9yQaVivlZLhXdTiVYvlinonbMhCenV9TxQ4YSCtGq3NuPb8dMm7Vb9/wbB5HZnv1CX7xIwndhmy7bk4XpjFMdEy69N8j9iNGfb9eu/All+00PLuKtJhDzoWRV9q5DmO0iPkMg905xV3g7gntonFNsH8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39830400003)(508600001)(66574015)(53546011)(66476007)(66556008)(316002)(66946007)(83380400001)(38100700002)(86362001)(8936002)(52116002)(31686004)(4326008)(36756003)(31696002)(186003)(2906002)(7416002)(5660300002)(2616005)(8676002)(54906003)(6916009)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bllWQ2d0dWNKdFZ2ZFlxWFpWcGxvSzNoK2NyRTRtU040c3VMSm1KVFFOL3pl?=
 =?utf-8?B?MGpiQWdBc2RZM2RJeDdsNzM2RFh6THA4TEFlbUhXWENqdWNkWkJJMzdsUDVO?=
 =?utf-8?B?V3RnaTRhaGVUTVFnUXJWQ3p6dldJYW9pdE1ES2V0TVlEUVE1SlZFdHo2N0pD?=
 =?utf-8?B?VmpmNm5ISjlIcTdNQm95SlBjV25HL1RZRlU1OHZWdnZ4NUlHc0FvNm5GM3dU?=
 =?utf-8?B?UEtlT0htN09VcGtwM2ZSUTNESjc1enRGV2NWRU9WMFdId1RaQlVVVER2QWh4?=
 =?utf-8?B?YzE4QWhKSGVuVDd0K2V6VzZuZnBhNndrMXhQRVdEK01FSWp2NVVsT2xvbTNs?=
 =?utf-8?B?R0x1LzhiQXorYXFEZWk3S0tsQU5VbVV2aEpPZWxVdndRZFpObVd3d1I2THNX?=
 =?utf-8?B?bitQcUtrbGVRZzdhMS96Sk1EeXB6VWVxdDJCOE9tcHRnT1NjWmpDcE9SNTlq?=
 =?utf-8?B?Y202YUxMT3ZabnI4dThRUkVqNitjK2JySlFKMnpYUkMzRWZoRHR0bGFsNTdX?=
 =?utf-8?B?djBidW9FS0NJaGYrRE8rWm54QjVOR3FnVUh1RHpEd29KY09hQ1JYMGEzbnJE?=
 =?utf-8?B?ZVVGb0pjV3lKbDlBTlZNY3h2dGd4TnUxOFhOaExkeGpxUytMNnAweDhNVEgr?=
 =?utf-8?B?UVdIRXVVRzFvY2FnakgyQ3k5TWIxVlNmU2g2eTBDcEdQdVV1eU1xOEhBYU83?=
 =?utf-8?B?Y1dXbFRlQkVqL1BnVUVKcEpKaUhkN2dLWDVNVTNFbjlQK0VCVnZWNDd0Z2p0?=
 =?utf-8?B?elJuRlh2UnV3cFM4ZHZQeXZEV0hCL2NIemRRY2FJR3BhbGZub1YwZmt3REdm?=
 =?utf-8?B?MjNMbmt1Lzhlc1VaYWMxbGszMmtvZEplS0t6WVRhd05VcWxpbS8wN2xqNElS?=
 =?utf-8?B?N1J0TW5xZDR3Zit6SVNuTkFtY3cvU0ptRU5JY2QwNlFQWEQzb2FCYXFxUTcx?=
 =?utf-8?B?N3FKV1luSEQ1dEgyV1p5QWJNVTVLSElQaFcxSFdXN0IvUW16anJmTzhUUGo2?=
 =?utf-8?B?VDhyYjdEeEJFaVExVDJOeUFkQTlmWUYwdkJWWTlXTCtaand1ZUIrWnkrdmo0?=
 =?utf-8?B?bWVyeEoxdVp3SHRGODFzMHNPd2lwdWZXcWJjK3J5bzFpYWRWT3lPYldoKzhn?=
 =?utf-8?B?Qk9PakhpMEtsTWRqQ3YwS0lod1pZcXNMZlh6Z3RSSGl4ek5ScVJ1M3owQXlP?=
 =?utf-8?B?VHFBZ3UxZDZSUHA5andCNDRTMzZDL0JlRGM0eUxLbCtOczhvdGs4UE9hekVr?=
 =?utf-8?B?TnJUR2NuSUY1OEhCZ2F1cmE0OUhNUm5FK0RIZGp2YnVJVW9sQnR5ZngzOHdG?=
 =?utf-8?B?SjQ1M2lzb1ZsNzVpRUpvR2lPNktRcFJhQXNNMlQyejVmUS9OVmFidnplTk00?=
 =?utf-8?B?NGQ3eGUyZGw1bjB6eW14ZCtWVGF5Y1VkcGF2aXlTQ2RObHFHRHhvdXdqR2Ur?=
 =?utf-8?B?Mk9pSGVENnBINkp0QkU4MGVwYUgrK3VGYStKNmRiMldCR3I1aEFsNFFmNEJy?=
 =?utf-8?B?dFhVNWYwRnlvOEtZdXVpMEliQ24rRTJiaXIyMVlhTTFnVGJxem1LVjh4T2N6?=
 =?utf-8?B?dDh5MWt4Z09LMkxuR2IvQXpoZzdiQTBST0tpSFR0cGZhaXltZVN4d0NnN2ZK?=
 =?utf-8?B?SWM1YkR0UHlGb0VlWVRxK3pMeTVYdEpsMzJnS3BiR0JSK0N0VjNaQU0vbmNN?=
 =?utf-8?B?MFZLcFFVK21KeFYzbEZtdnZURHpPZTBKU2J2Z05UZUlZd2xZVEdENmxZZW1M?=
 =?utf-8?B?K085eGdXTW9EN2d5Q2Q1c3h3V0hTRWNGaU8xOXkrc0NoSEs2OVNuNWFyaVU3?=
 =?utf-8?B?cWhnYkFtY0dhMDNMMVp3cFJ4N2tJSzhVM0Rkd1BKVUhxVWlDb1U4M3FmN0ZF?=
 =?utf-8?B?clVaMm9YRjQ4MWxHNU9yRXVrZFNUWkY3UTcranZrdytySFdSRjljVTJoY2M2?=
 =?utf-8?B?djF0cWRjQmt2R3ZwUVBTWHFsRW9lNnBMRk1jL01nbVRaWmVDdVJjbjNGMTYw?=
 =?utf-8?B?akhFZ0ZqcUhscTF4MmJNc0xtUGsySWVIcXpsYjZKUS9KM2NJTGp3cmV4U1Zm?=
 =?utf-8?B?dWdoaCtoa3lDVy9TMDQ1Z3l3UXUwQ29DTkhTL21CS2pBajNjdmQyckxBZzQw?=
 =?utf-8?B?MEl2Q3JxOWdZdzMxUDJ0S3QxVjBCWWI4dStGZ3NadVYyWTdNaXdhSTIxUjRt?=
 =?utf-8?B?UExTSmRRWkNKRVFVV2NSYXpid1l0TUN6WjMyRGE3S3htM1ZqRTlzay8yWWdw?=
 =?utf-8?B?U0Y0WFVzZm5QVUc1clFLNEF6ZzdQUFBVM20wY0c4UCszbWpRQmlVY1VHTCtV?=
 =?utf-8?B?SWtOay96ckFvMWNzQmtwYk1YcUdwWG8wc3pBbCtQYjBmTlB4WG8xUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e92bcc96-1d3e-46cf-c4d6-08d99792ef56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:39:18.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OY+8zYxmP/e68gYfYSXBBhmfB1CRfUFsFvQEfXpTe5AP5Lq4tASgqmmfRAjUy/EnYRT8rYSuJLPeaowLSrUqWkq340BhyYhP4oe4ZuE1EEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3899
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.10.21 20:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 22 2021, Fabian Stelzer wrote:
> 
>>  			buf = payload.buf;
>>  			len = payload.len;
>> -			if (check_signature(payload.buf, payload.len, 0, NULL,
>> +
>> +			if (parse_signed_buffer_metadata(payload.buf, "tagger",
>> +							 &payload_timestamp,
>> +							 &payload_signer))
>> +				strbuf_addstr(&sig,
>> +					_("failed to parse timestamp and signer info from payload"));
>> +
>> +			if (check_signature(payload.buf, payload.len,
>> +					    payload_timestamp, &payload_signer,
>>  					    sig.buf, sig.len, &sigc) &&
>>  			    !sigc.output)
>>  				strbuf_addstr(&sig, "gpg verification failed.\n");
> 
> I haven't tested this, but your addition to &sig here lacks a \n,
> compared to the &sig seen right above here in the diff context.

You are correct. I have added the newline.

> 
> The whole business of seemingly mixing error messages and a signature
> payload in the same variable seems a bit odd, but maybe I'm misreading
> it. In any case it seems to pre-date this series...
> 

True, it is a bit odd. This function generates the message text when
merging a (signed) tag. It verifies the tag upon doing so and includes
the result information in the message.

I'm not sure what should happen in this error case. (especially since
this is one of those "this should never happen" errors). I don't know if
i can just warn() here or if that would be lost or even corrupt the
merge message :/
If the buffer parsing fails this could result in ssh signatures being
marked as valid even though they expired. So i think it it important to
include this info. But the error has no effect on gpg signatures. So
telling users about not being able to check key lifetime here might
paint a wrong picture.

Thanks,
Fabian
