Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F7BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhLMQOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:14:24 -0500
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:45376
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233692AbhLMQOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:14:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6EiODBitk6kAEduTM0lzbsH6dFkPAS8PKQ7xXj2mAkp7cCjElenq9NhtLsr2ESsph3EDnVEchgIXhuxdv2KnNJqWk8Hz1eU8576CExMDmgseFYH20F+t//K6/pI5F0jG9dOz7MCx18NVv3Q4hD0x+H06NOm6xCdcYMz6apMho92sn9B604qaPGtq8Ae8i8EC+QCMDSycSKPtaBapL3bJwETIxp3lsS+GmyrxfTaSOVbD7JJ79P/tQ9bCe5Walh7cInRuBtpxokj6TH/j8wDfR17OXowsKxcYYYF3Zxj2QIxR3LU3Ws+gMRvFWZJQFXRKIBH7m3UUmktFAJko0eHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMG/Pzn1rVo+gfv7JZXckaybGfEXJeCnZME98JN3Mp0=;
 b=hry4ba6NP/wCR4X7EERvCo5fRl0kGUjPZkf4YDBqQk6K/lcWZOPsa6E1x7MeylcP7gmrP/4urLvwjJU/EwmscD3tu9h3xPOyMqpwdclv0tdcDloais14ZpInjFVGQyuOpbDejQeULpYdXqrdibS7MOSJIZ0hbS1vSCEDIoy5A+WaMwJx4DoGx099pacngvVTHp/mSNy5LZ+iopFcZZPunlSkqONajswn1jRo26f58sQuWjUZA0zyKVY3IiXsU5UNXVmApdUh8GsEil33Ak8JxXgiO0F2mEVTyloiJiW5pPW3gUDJeEnWO11U2EtkgPuW+a5/s9mcLJTswJq5FKh8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMG/Pzn1rVo+gfv7JZXckaybGfEXJeCnZME98JN3Mp0=;
 b=ouSCsrlL6tDMkGrl6m6vOiNOQzPDvxbJlH5jf2k1ReLrlwiTX4oBAQy8cXHwuFNwR165Ps8wY6TCMvKqzPUZs9dcQ5WzGy0ccP7HBZVs+FIWXDylQldst/5RaDhFDto8aC9oySO1ir6Si1lBAP/g9+1h30yufXgUTbc9w+G5ksA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 16:14:20 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.028; Mon, 13 Dec 2021
 16:14:20 +0000
Date:   Mon, 13 Dec 2021 17:14:19 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Message-ID: <20211213161419.cwamlunrgz3adrhh@fs>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com>
 <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs>
 <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
X-ClientProxiedBy: AS8PR04CA0163.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR04CA0163.eurprd04.prod.outlook.com (2603:10a6:20b:331::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 16:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f8aa8a-4082-44fa-7adb-08d9be539e7a
X-MS-TrafficTypeDiagnostic: PR3PR10MB4319:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4319DB983418EB0E320380B2B6749@PR3PR10MB4319.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPDsOdg63LrPZLe8Zxu7dDjZFeZFmx0WkOz5xIp7OD2cXtyVkUmbkmT4LO7coIFbkUPnmZ49fBswgizRx/R8Lp5lmvZ4dfXCE4xeDAzGybbWKByXxeU0VQpILPya3jMEb4dv3XqIktSof2p9l8SX1nMolVb4Y3qgvmN6W7eCv0o/wOu9TExNeAliF06J/lZZBGoOBadD0q+vQxQHfY+GwaB21kCgKCTHwXkVqfNL43AocD5vPiP7ySrwFGmHdONbbrvHKJKIPEuiixlchE1WS+YfmXSS8sOt2XAvBQcgvV06hXeLWIbwtna0LyYf4ETjjLNkXpHgpvARKlCNnnNpGUwLYU52/gCQgwS9uRbOWllxYKiIuSsgCrdahrshHcdF/NGYOtQ4BMCEGDEZ4oFmTQape+gS8gHN1nmatkeWWG7L15o2pe8m9n8Hv8ECRQ09xMYIOvrCiNxebsoHkGeIWeNrOu34Hq7VGQT5vxg6szqOndM9E7++G1bOx/85tFqEJ3rpghc8kcI6Q9lbexKrLOQECRIyJypZYc+Vto3NcWZGJjGkaKGXz3Xk1mS0NXQHEsQ3dCMsKBrtn57jnHWTKXqnn1LFmitFTIRlxAhBakdw/NjscUFBq3g+ktPkTeo7B1TEKVLU3P1f8ItPz5AJ0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(376002)(396003)(136003)(346002)(39840400004)(86362001)(4326008)(1076003)(508600001)(2906002)(6496006)(83380400001)(53546011)(38100700002)(8936002)(9686003)(316002)(66946007)(5660300002)(66476007)(8676002)(186003)(33716001)(6486002)(66556008)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW9BamNxeEV5dnEvb1Mvd1ZoNkduZmVKSC9pMTBRakxIL3lPUG1GdXB3QXJR?=
 =?utf-8?B?NlhEaDlZbWhMbzVERERpdGw3Y2FodTE0WW0zNkFaVEpuL1NOTllheC9RUzBL?=
 =?utf-8?B?ckQzWDVKbDdjSlpraVh5M1RTcXJpcjlaWU54cXlUQ2JTVng2MHBaMlNwSHhG?=
 =?utf-8?B?WCt3aTcyZXp2alA4NEtocWRtSTlHZWxuOTdXV2xEUHRreGpJVjZuU1ZjVFY4?=
 =?utf-8?B?akNsVHdzRmZGaEROSFFlaVUzY25ubThYZ3JlOG1YUGdNTEpJRS8vcURYV2l6?=
 =?utf-8?B?UW1DNUtyTkRTUmRWemR3K1R6ZDdsYndBdDFtT2lRM0h0VXA1TGVwYnhNMGdy?=
 =?utf-8?B?TThCTk14bjI3amdFQlpScEU0QTRMQkFFK0JQTkprUDRWN2tPc2NGT3BydnNE?=
 =?utf-8?B?VEdTZHl1eEozOUpIdmhrTFlZVGFERVBrR2VYUWVyRHdlRVZaK1RUMmpNbyt3?=
 =?utf-8?B?dGxzVXRURFA1dGhCckk0bk45Vmk5RklxVWhuRllNOCtiSHVnVnNaUWZsZzYz?=
 =?utf-8?B?NkRtblNzYjVRbzRUUk82U2Vybk5CdGxCNXlIaGdrY2NOMGYrQnpOaU04Z0xv?=
 =?utf-8?B?aTUzbHFRL1dOV0svc3NFd1huRVB6a054dE1WdU14RGpFdlUzdzlmRVFVOEdC?=
 =?utf-8?B?OGcxY3R3bllqY3pLSjgrMWUvaUMzbUswMFplTkxFRnFwVitpc0dJK1hadTY2?=
 =?utf-8?B?a3NxSnJ4eGV3SUJHczJQTjRUdmprT29OMFJwUHc0L2N3QitIcVpzV2F0eFlS?=
 =?utf-8?B?Rmp0ZWp3bDBDMDBzZzJoMzFkYnpCK1lSQ3hicDFxZERMSWVEeWhJTDJRYjRO?=
 =?utf-8?B?VWl1dGNqZzNUUVNocHBXc3RRTEVwSThRQzNTTjQ2azJlUkVndUpjNWRxYXJm?=
 =?utf-8?B?MXlEYXZad1B0cm12TStiOE9PWXRhUmhRUFpTZzE1MmJtQjdWWDhuelJuN0Zx?=
 =?utf-8?B?OUdRcFhXTXJmVVozK2JlQ0dncFFLM2NYTVV2K3ZJT2Mxc0c4SFNHYTJCeStG?=
 =?utf-8?B?TmdzSkU1RlcyZFNUUGVnZGlaZElLZytieDJGMGtqTHZndjdSSUxDV1lsU1k1?=
 =?utf-8?B?bDhMc1U2R2UzWjhwS3dqVVpMNENDQWt2MlRwUERzYWszMFFoV1BockRldDNi?=
 =?utf-8?B?UTdKOEpiZE1tRm1LblF3MCt3ZXJjcTcxTEpIaC84Vk13R0U4VkV0SmhxSGJ4?=
 =?utf-8?B?TlB4UXVxUlFuc0kzNnlNZ0hKdVczRzJkemRaZ0RMUHY4a1EveHU2Nm5WOFY1?=
 =?utf-8?B?YUljS0ZoSlR3VUg4U0ZtRmlqWnJDTWJRMlVSWkRIeGlCKzgyTCtYcmRNZG9s?=
 =?utf-8?B?RDRzK3NQSWwyOEczckRZeXRibVZmSVlsNXpkRUttVS9aU1JGZWxkRDg1N2ZF?=
 =?utf-8?B?TkFtN2ZMaHRwUndVaEo4aE5wNndRQmxJWTBqMnp4YSswY1FXWXpVUHRsc1NE?=
 =?utf-8?B?SUZ4Z2FzL05YbFFpR2JmTnhMb0hHWFNmUWNzNERMaTcycDdVMHFXWEVZbTNr?=
 =?utf-8?B?aGJhQ0tvMTRWYXhqdEx2UWU4UnVIdkRLb21LLzdaQXFmNHBRSlR2dHo4VFB0?=
 =?utf-8?B?bmZ4anVrdi9CRlZ1NGo5NTUyeFdyZFNtVU9EcVNvZkljK2V4cS9hOXlzTGEr?=
 =?utf-8?B?eVQ2c3NoaVk5dFM3ck9xM0t2dE9oUGtMRVpIZ2NqUm1MbDNrTTcwNWxWemRo?=
 =?utf-8?B?R0VsTWJIMXlCOVVhdDJONGx5RUdtc1ExcTlTdDNOMXo3R050MXFVU1c4RmQw?=
 =?utf-8?B?Zi83aVJuNjBzR1pCUnpac3ZOZkZPY0V6QTcwdUIrS1ljQjR6WjRtM1FoWjlo?=
 =?utf-8?B?YTR2U0JtSHJobmdWR2VIOXdVUFBtZWNEZndwMGIveUtzSEpsMHhIYTgzUFZE?=
 =?utf-8?B?eERsRVd2cDFpNkFKQkhBSSsrcHRPTk5VeWc5MXNzamhoTVQ0VmgyaUtvZ1BV?=
 =?utf-8?B?a2FwVEk1UTJGMUprMlZsMU9iQmZvYVBkenBqNDhRcHZza0ZOQU9FT3k4MStq?=
 =?utf-8?B?WWtjSVRJN0d0Rkp1Wmc3ZnlzWnRFeUwyUXFOVGF2WDE5bWx5emJwQ0pWNVky?=
 =?utf-8?B?YWVXUXpLZFZOdThuYkxiQ0hHQTl4dS9nVU5BZ0lUWHFERWJjNnlkcUUveEJx?=
 =?utf-8?B?TGc0TUlYZUpSdE91ajhNSDFkeTQ1UUdvNDBZM2twZ3A4Z0pqOWlOT0RRSEdJ?=
 =?utf-8?B?a3A5Z2V5dXZsanRvQ2pKZ1BVa2NDd2hmNDBma3FoWEdhQ1Z0WlpLU3NPSURW?=
 =?utf-8?B?L1JNR2gzazByVWJ0NWJMRFNuOElGd3cvc3NLQmltQzhUcVJoS3hQNEJwT0xp?=
 =?utf-8?B?MVJma1A4dGF3REoyWDNSUVdGSGlOWXZyUllvY05GOHNhQ1dpVmlKdWpVVnl0?=
 =?utf-8?Q?PaCk3Ttrf3OKV9LA=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f8aa8a-4082-44fa-7adb-08d9be539e7a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 16:14:20.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4J5ZazhSUwBQp7Kz0DvCUkModNVyNPR0RhFEkx+4wXD2bq1DazoCtgjcVtuOhzM8lCT20JxsZW465c+PjG1nnPplBypMLMOXyYsJGa9//o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4319
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.12.2021 11:02, Eric Sunshine wrote:
>On Mon, Dec 13, 2021 at 10:43 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> Personally i find the initial for loop variant to be the most readable.
>> Ævars makefile targets could be very nice too, but especially:
>>
>> +$(BUILT_CHAINLINTTESTS): | .build/chainlint
>> +$(BUILT_CHAINLINTTESTS): .build/%.actual: %
>> +       $(CHAINLINT) <$< | \
>> +        sed -e '/^# LINT: /d' >$@ && \
>> +       diff -u $(basename $<).expect $@
>>
>> i find very hard to grasp :/
>> I have no idea what is going on here: `<$< |` ?
>
>Ya, that line-noise is an unfortunate combination of shell and
>Makefile gobbledygook. The `$<` is effectively the source file (the
>file being passed into chainlint.sed), and the rest of it is just
>normal shell. `<` is redirection (using the source file `$<` as
>stdin), and `|` is the pipe operator (sending the output of
>chainlint.sed to another `sed`), and capturing it all via shell `>`
>redirection in `$@` which is the Makefile variable for the target
>file.
>

Thanks, that explains it nicely. I'm not familiar enough with makefile 
syntax.

>Anyhow, although the commit message tries to sell this change as some
>sort of optimization, it's really in preparation for the new chainlint
>which wants to check all tests in all files with a single invocation
>rather than being invoked over and over and over. The self-test files
>also require more preprocessing to work with the new chainlint, so the
>implementation of `check-chainlint` gets rather more complex once the
>end state is reached. I'll think about it a bit, but at the moment,
>I'm still leaning toward this intermediate step as being beneficial to
>reaching the end state. However, my opinion could change since the way
>this is done here was probably influenced by an earlier iteration of
>the new chainlint, but now that the implementation of the new
>chainlint is concrete, it may not be especially important to do it
>this way.

I don't mind much either way and i tend to favor the efficient variant as 
well. On the other hand i can also see some bug mixing up the contents of 
these files producing a huge diff with no good indication for the developer 
of what has happened.
