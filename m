Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC795C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08B561A02
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKSNve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:51:34 -0500
Received: from mail-vi1eur05on2043.outbound.protection.outlook.com ([40.107.21.43]:61793
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235594AbhKSNvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 08:51:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGMxD3PNE2MrsZdVCX40I3QXUrOqIT+CJnZzzVh9JHVOc7OaBYCrAPmKE8o3DyAlXF++DuWQretxHmCrJQBt7UdKmbGO4dXROY33w4PPTbtiES1aJ+Teo/cCgq77LDuJHBML46r9qj8aPT8k+uROb304z8uKmCtR4KwsPfpG2jjohuFNfpYju1dvI3RZGy8102CntI1JLIzrouk1vAoUSksVF0kQoXzOy20hplnIShpRUkA/7oYEN/jg6df1Bgp2ls0Y0dEtEKlScoente/eE9FszydIzRg3vEJ1xLTyMrVPsy8HeG8PXnPBhzGYqg/IKNL3suLv45kKC/EataryCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EXfAx8JjvrHkih8gVz1GQexrX31aEEah3112PEtJww=;
 b=bndVnctqP1IfK+XnTzCva6MJdF2z4qrjnMQiZP8fm2+7Gvozz0khhdAqoNxhcbN8/n299IMlJFY85y4TrOibY/sKijC3RnBgwFTry0c0xQVX74k3a0g9QbR0wRSx3037XroTyWuVQh0edogWyJCOQMKpPDZzBp+R9AlGW1d6I50Zb11TIj1P//2wtWaCbfn4dmMgsXHVyzfbUo3EaPixIDRrTi6GTT0jYKp/7z62udSnuXRUoguwCg8VCestgdhpxHGnSQ6fWiVlagAqBoIv39dAtwiP4Acxu/iLu9lPOeUNMnEoKs4tGImrIFcdb8zVHQFqQ6ds5UEvOuy7ZrH1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EXfAx8JjvrHkih8gVz1GQexrX31aEEah3112PEtJww=;
 b=rccCgcIv+FGOzkS3Gb3ahK8AYLoCIK/fMsiwvCasRy/yD96c29N9/fAQXuUGkioFUZUo0kRd3TGEEO2tUjOZRsYgIQ6St1yBM/EmTtOCWvsaVMXgwTuTVONy/lTS/4uc5Vx/PGPM+XWqGkc2TA6Po0LHfi/kgOZgSbnMVU9cGOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 13:48:30 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 13:48:29 +0000
Date:   Fri, 19 Nov 2021 14:48:26 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Message-ID: <20211119134826.i66sufxzxotadxlb@fs>
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
 <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AM5PR0502CA0008.eurprd05.prod.outlook.com
 (2603:10a6:203:91::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0502CA0008.eurprd05.prod.outlook.com (2603:10a6:203:91::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 13:48:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d8ffc2-9fc3-4113-a732-08d9ab6343c1
X-MS-TrafficTypeDiagnostic: PA4PR10MB4543:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4543F93C1813CACD59D989DBB69C9@PA4PR10MB4543.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOk+IlqQ82aTWcq7ZF7T+SFHdhe8zKWK8iWyt+vlzxWhARmcZMP4EYald5qgUqxY/gCQvipLrYGkoy0mSNABbFb3IAJcK+TWwjhjmAaOyddsxcOBdVbE/mnT0210NM6j7co+x+a731aX0OqyDgKjZYpJEOJDZu/cnUI4o1viDaq3V37JKVuUbsXAGSuIocTo5pEMLErB2dDPVQvSWU/JrdAp8tlcfjpY0ddtF2wIks/R164K9OF3FlGh08GX67RXOdizRayvhKmHzxK5XtxIv7yJYok2qFm8YX+GqDRQM2O6z/cp1XkePCeYmYJ2DrAxpHrToKXjbnWJJCLTEbXNyBnws1Jp9EfpdpJNvlteXPcnMDUpAyHYVluYelcXEJQv375Xiwwav6KugwF2wm3BEm+UUZfc3RWSe6pkUriTCjpha9O9Tww/aiPTmwsRouIJBI73WFX/N0vuzCSABLu6XNnYAlhbEGmYVv/dOFI23qrH822a8tFu8oAdQr74PrnlRHJmNiLLZyNi4o9lu3CFWt7JrIPPm8gliBn+lH4hHbXJj0KIaWtkWFugQcq7xPjGvDTqsDSKcx5XWgq1/QkLOfXAklfJujWud+zMC25L/tqkRxXtbXz/z+XG5zp60Hcj3OGogV1r7kjeOWX3iOwWOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39840400004)(366004)(396003)(376002)(136003)(346002)(33716001)(9686003)(54906003)(4326008)(86362001)(316002)(2906002)(66476007)(6916009)(53546011)(52116002)(186003)(5660300002)(1076003)(4001150100001)(38100700002)(508600001)(8676002)(66556008)(66574015)(8936002)(6486002)(6496006)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBpbE1GM2s3STFBdmtUSGdDdGlDZzhxTFRSSFB4L0lCaXU4NDNCSjZyRWdT?=
 =?utf-8?B?T1dOQWh0djRUTVplVVB0czNqeStkMlJOUjAyNDQvV1NsT0NxWkZTQUxUa2tV?=
 =?utf-8?B?R0kyNHY2UUR1aGF5S1BMRDROREc4ZE9YeStWU2txNXU4UGZpempTUWtMd2I2?=
 =?utf-8?B?TC9jYWVmL2ZNTzhZSDVXNUIvRjZMNnVvL3EzK3d3UlE3MW5sN1VLamlEN0hF?=
 =?utf-8?B?bDVnc3h5K1VUSGNzbFJKK1ZML0ZSdVZZZStyMW9BMFk4SGUya0kwRE14T1FY?=
 =?utf-8?B?VEFHSHhqb1I5VmVOa0w1MVJ4MjRoSU1BU0EwdUtMVDRKSUgyS2huV3NJc3hU?=
 =?utf-8?B?RXVSZy8xTnNiM2U1VHRTa0o3OVA2QU90VGhhdWkyUWROdmdnYksyUnNDRFVZ?=
 =?utf-8?B?bkpKdENNb1pYQ0pNeVpKYmdvcFlSd3pqRGNkeWJ3U0dqaDJ1azR2eGJlVUxh?=
 =?utf-8?B?WTkrSzBSZlVGZGRFZVR5Q2tSVGJTRUc0ZVFybUlhSW40VkZrVUVIQkNUN1l3?=
 =?utf-8?B?bWJKTDJYbEptSWp1bm9mYnBPeFRLMGtUeXhNMXdldnEvVnMzalcwaVBRQmMw?=
 =?utf-8?B?b25wck5GQmd3SnNQeWs3V2JSUFA1c3pTWmlRM29PZklqR1kvYkg2cWJBYWEx?=
 =?utf-8?B?bFk1R0ZKL3JYSjZEQnk2Y0xGVFdrNDRPRnhkelc5UTI1OFNwc21TMXEwQzlh?=
 =?utf-8?B?TzlKTVJDTFpKblh3ckppNFJvU0ZpUHlGbkx5VXgzaitPYlBybDYxUjllazJO?=
 =?utf-8?B?QUxBdmFqMjlBcEhQcE5WU1FnYnpUL1lOa0MzRUNMMzFGQldIbXJqWHZ0MnVt?=
 =?utf-8?B?MGZYTW0yOXg4ZEJOd3RLRHVJcXFBQmppWGZhNFRRMmQvQnBsV0x2SWFKMnpG?=
 =?utf-8?B?SW5KRHdPbWFFVGh2MFh3VmRlUzRkaHVTV0RxaVJRZnIxWDNwNCt6REx5OHhL?=
 =?utf-8?B?SFROVFB2NU9HQ0hwZlVCNVBGOFFabU5QUlc3eHpBaEVEclIxMXVSVGF0Wjc3?=
 =?utf-8?B?MjB5TFU5L2UxL1JSWlpYM0c1UXhMWWJPUzR5aWFzQzZMdDRRMUlTbFM2Uzdx?=
 =?utf-8?B?R2swdVpTTGtwSU5pRmlxWkpMWEVzR3U1Z2svVG1NOFZXSVFtWitHeFFKNThr?=
 =?utf-8?B?TTgxWEtjRi8zdFJEbmFtb0twbDA2Y2t4cGIyQzlxbXpDZnlTS1ZkYlZxSGVR?=
 =?utf-8?B?dlVnQ01iR1BSbXhudnpGdjd1SkNpT1BQdFYyRG5jM2xqSHl1Y29pdVo2b2pP?=
 =?utf-8?B?K05OOW9SZnFublBOUkNxbjFuWXEvbTQrVVhQV0crcDZTOVFSUVpSRjhHd0Vu?=
 =?utf-8?B?VW1Sc2FiN2ZDejVjSXYraERoaFNBUEJRd3pBZ0xTTzZEUXIrMlZIUERPdkIr?=
 =?utf-8?B?OVJmTXdTQjlhYlM1ODkvSnc0RWxncUJOUnFhT1JReDAvYWV1RjBhWGN1dEta?=
 =?utf-8?B?NGtMU0VFRHVoR1k1WXJOanMvSWluUTZtQk96ckxIdHJwVGlwbzJBOXNlcjha?=
 =?utf-8?B?cUZkWGxyQUNwMkR3TTJiWnB4SEJjNjdDT21aUU9hV3dLRWhFYjVxai9wTHJp?=
 =?utf-8?B?L2FDc0NiVy9GWGFxSHlnZDJIU05saCttMGxBU0JHVjZXY050VWJydVZPUkN0?=
 =?utf-8?B?TGdXdHd3L25vMU9mYXdFNGZ2OHFEa0hLN202NzZaRGRSYVYvblAvamQyaWQ5?=
 =?utf-8?B?S0M4WUNxR0hPNmVjdEw3WDFPbENoZXV0UHNNbERQTUp1U2VlYUhYcklvWEZB?=
 =?utf-8?B?Ty85NkRzNVA4MWVRdmQwcXU2K25YVWEwdHVkeldKTE13V0o4WUw5dGhET0ZZ?=
 =?utf-8?B?S1Z6VEs2c2lnS2piVUZHdXZueUtmU0Y2Mjh2MGp4TG5wSFVvUWpDUmFQRW5F?=
 =?utf-8?B?c25mMi9uUmJ4ZWIrVG5CZC9GUTUwVE9wRGNiSjBPaVZnTkhNNFM2QVU5eTl0?=
 =?utf-8?B?emNYMlJxSDVFemVvc0l1THpsZ0p1MkxaNmFQc2RCWGJXM3JtL216cEdRSzFn?=
 =?utf-8?B?dzVGQ3gvbkpmZFJ6ODZTVmg4aUNHWi9CN3UvVVl1Z2FoQTJuZTFaSk5nMTAw?=
 =?utf-8?B?SHUvSkdnZnhNSnpxRjg2d3RCVXNCTHJWZXQxTlgxTG5DazNtVG1NMGg4dVNP?=
 =?utf-8?B?WWl1c0l5ZTlLcVAvNlg5NmxpbWIrd0VDdUVJaG9DT3hQTkdqSDg0RTFMQytN?=
 =?utf-8?B?VllpNmpUS0dzWU9WbmJsLy9TU2NaVTJlMEJ0MS9wenNWVlk1d3kwRkhMY2Ew?=
 =?utf-8?B?dS83MXRIMDA2bkhya2xBcDBhZGxMeGh1bTkwTlQvcnNxOG41bWhBNHYwVUxL?=
 =?utf-8?B?STlCbEpWL0tqNno0Y0FWcERwem84SXJlRWw1R2NpbHZiNVJhU2xaemlTSWcr?=
 =?utf-8?Q?x2TloFpxz0f1CEpc=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d8ffc2-9fc3-4113-a732-08d9ab6343c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 13:48:29.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMUqgD3GR5BpUvZA32C6l/h1hu+X75vL3LhXHCNSxwU1RNpqkIBCsn6yV2aaajM0AlBC4rJJ1MHgFFZwVfxzAlnq3HCletJ+N6CPbAFIxBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4543
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2021 12:13, Ævar Arnfjörð Bjarmason wrote:
>
>On Wed, Nov 17 2021, Fabian Stelzer wrote:
>
>> In certain environments or for specific test scenarios we might expect a
>> specific prerequisite check to succeed. Therefore we would like to
>> trigger an error when running our tests if this is not the case.
>
>trigger an error but...
>
>> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
>> which can be set to a comma separated list of prereqs. If one of these
>> prereq tests fail then the whole test run will abort.
>
>..here it's "abort the whole test run". If that's what you want use
>BAIL_OUT, not error. See: 234383cd401 (test-lib.sh: use "Bail out!"
>syntax on bad SANITIZE=leak use, 2021-10-14)
>

ok, thanks. BAIL_OUT seems better. i grepped through the tests and
didn't find anything like it, so i used error.

>> +GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a comma speparated list of
>> +prereqs that are required to succeed. If a prereq in this list is triggered by
>> +a test and then fails then the whole test run will abort. This can help to make
>> +sure the expected tests are executed and not silently skipped when their
>> +dependency breaks or is simply not present in a new environment.
>> +
>>  Naming Tests
>>  ------------
>
>For other things we specify via lists such as GIT_SKIP_TESTS that's
>space-separated, but here it's comma-separated, isn't that just a leaky
>abstraction in this case? I.e. this is exposing a previously
>internal-only implementation detail of the prereq code.
>
>It's less painful in shellscript if anything like this supports
>space-separated parameters, as you can interpolate them more easily in
>any wrapper script without using "tr" or the like...

Ok. easy enough to change. Should the listing of missing prereq at the
end of a test run be space separated as well? (maybe helps with word wrapping)

