Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E34C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARUoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjARUod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:44:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADECC60493
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8ZJvBYCtFvUXACkmAkYHN+gcV/mGX+ZrkDX9Jru4bp+EkhYrCyAbxdQ4ghKYRXKQUg0j4R5jLRBWcvdobsZaGkA5Yas5LvGt7QThpn1Bwj4lHPRE2Eygjpd17O7GH4rtyMcwJqOYwp34PjaFq34UkPjNOSsgYBM9IoPWfQsZGSQjUER02ld8BJNrPTA/eRqffez/AgmBok1pYxu15aI10yz6ncvTofOsex1+6R5EbJ5HuXEZLv7vlBnH5zxX7ZnbxhxFuuYlYo8ryPzoNNmYSKFtGUFyrPyaBMNAbdWKeOyraE1q71GNLJdzpOz9vsKcWf4G3t3U4tN4G7isO4Qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYCJ72JoNriqZ+tB3SxdYfAxcNLeeODV1NxrCtzhLNU=;
 b=P6Wszp9hnUONNdRRS3zCKHTw8hRbn1zwBCniZbz8Vg7XJt4SIKT1xTCNt1UlmqDAUcfD+PUGNF2nXvNFa/gB+DODC1Cb/bV8jH7dzeokRmklHo85c7RSAshDgAMy25JkDyS/3+f8lvLHVpvWHjuKQLOjgJrMUQyo5OcdDyNeWfYzd5f3eGMDVIFg5JbQ0g+vlAO7oYOoE7InDulh2kl2hp//XF5WtxmZ+Ma64Eo7Ct4CKNY39Xhwa5WHAzARahY2OH07cB0PzVxfp83gIdR5Y5m4Q+EmLRqWl8wj2hgydtx6xyKRdAMcS/lf2H+NOqIGuneItCeTYb5CR2fIh7GbvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYCJ72JoNriqZ+tB3SxdYfAxcNLeeODV1NxrCtzhLNU=;
 b=QkSY5WEnqplmFyB0x6kkO+Eb9F5Qcrd/RspfKiF7pfpsEaaQZ8b6Ht9qH8mk5PfOaY2OBHeJHswRgINOojw8SHu7JnWE6ER4Q3tZAf8QLz3H3Vq7NKIXMhHWNFBdlyyak42XXzlMAgZ079y9neUCWji77GaruhjEtkA1MLhwBQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 20:44:26 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 20:44:26 +0000
Message-ID: <bebed448-bb2f-a33d-469e-d6056075ee4e@amd.com>
Date:   Wed, 18 Jan 2023 15:44:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Content-Language: en-US
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
 <20230117013932.47570-3-michael.strawbridge@amd.com>
 <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com> <xmqqbkmxbort.fsf@gitster.g>
 <71623e1d-805d-cdc7-d872-224821c1383c@amd.com> <xmqqv8l34xkp.fsf@gitster.g>
 <fa9b1371-0a61-147f-637e-cb09f775fe22@amd.com>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <fa9b1371-0a61-147f-637e-cb09f775fe22@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0219.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::24) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 310c46f5-86ed-4ef0-a9dc-08daf994c964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnww3yN+vE9JWICGCVrlFjJoMwQ53LjDY3y9e73EOxnWhCfxwsa5VPoRFhgiProB2l9rPZPDxyW5NJIMhS5ZsfGzpL0/XE0+/ImCI4BTCD4y0lhmwDbj9ZSQgwHMp/dPr2Qod3EpV++v0VDNFt16vaI1FEAEWELDx1kyRp599FJy3C48v7uS1zt34O2vM4drXa5gi0W89BoG1DjliAYNfYI5V5/bE/3iwwZ55B2f8BZXy16HNzJ7oOH2WkQU2X8y7Mo/8348D+mOLotXoPikpS+253cIqcCyEgEeLyt1KJ6M9atHFQ7Szpml9wXO/c96iiPa6B7ZV7qyUvZQ2gn2sG/BF7KvUNm38L0OuRuO3IuWB6h7ka/aSk68upRf7HrK5ShAkLPNg7t7yHTaUGmvnJfAXq3aT9ehApO1Noq6J6mqxnSV6PvGBm28pNkmeuBX72CcAxxLZDzYX4MoPCjfQtEbNEFVZ3iuXDJbvvpHkcQPkzEEh7pW8qx+1RQ2eEM0w8BoP0bR/W5VQnGwv63VERxgvJRU5SW7v02fDI1KRJglhaDOX2qLS0i/qnKpfWkXIS2PsoZJ8NegB8qKeacMrrE0+aEyAYj4yG7dcKJfFcxMZSl7BWF0DUKNVslRa94TUFayLN22B2KdSTMIgWchQ9XgHB0JFPdva5Wj9dZC2pyXNDnYkxIk74VtrExqUR/I6alQSuoqwN4fBCyxlsNylsIrxfeVROPVkSC4aZPEWro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(66946007)(83380400001)(8676002)(31696002)(15650500001)(86362001)(38100700002)(5660300002)(2906002)(8936002)(66476007)(44832011)(66556008)(4326008)(41300700001)(26005)(53546011)(2616005)(186003)(6506007)(6512007)(478600001)(316002)(6486002)(6666004)(110136005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE90SnVRcVhlMGlSMXFXaTNpS2V5elJnL0N5azZ2K3RCMGpnQTJxR0lUY1hR?=
 =?utf-8?B?bnU0NmlSWGFTa2doRFJuVVZIVnExTkJ4ejQ5c2VNR2hyMDZzcVlmNndqZWsv?=
 =?utf-8?B?aGtaNk9KQ0IzSmwrdWZvbGxhd3ZzTlF0TlVOcWE4OHdsbGlDNEpVRDhXRVk4?=
 =?utf-8?B?Unh6akxscVpHcG55MWlsRzVxOStyMk9DSnBvZ2c5U2RqMXJNemxkaCtEbThm?=
 =?utf-8?B?TDZhZzV4UVY1cmlCZFJldHNENFBnWmVsS2Y1dGhGU2pBcDZPdXBPUi9Qc0to?=
 =?utf-8?B?M3FnckJjcExmSWpoZ2ZvT2NrN0RZbjE2TWI4LzlPYm53V245ZW4wZVRKU0NJ?=
 =?utf-8?B?V1d1RngvcXFiSmIzbmVrU2lmc2J1QytjMUxxWUhlcVgyZEdmM0NzOHZsTkgw?=
 =?utf-8?B?cTJPbXJEdmNBNDdVZlJWRDg4bjIvUTNhSG9Bb3NrYTFkWkRPRWFhck40dGIx?=
 =?utf-8?B?eFdjZEt4VWo2UUdacmlXOWllNE8wSThNS3hoK0M0bkEzWXJFQU1tQjlyRUll?=
 =?utf-8?B?UHNnT0hyUW9hbUhJK1AyWlF6cFFtaEE5NC9ZMjZUWXBJNjIrLzJvaUc0cmFi?=
 =?utf-8?B?TlF5WEM0ZGErU1lacHlZeUdDcnNuRWljNzdIK2xKYUVVd2FZUVJBS1pPTDhl?=
 =?utf-8?B?Vy9VLzByMkVyK3ZxcUdOWFI3QjRLckxzVU4yYkRjZVBOdGhTMG5FT0VTMmU2?=
 =?utf-8?B?NjJIMkR1UUN3OTI2Ynl3bXNCa1ZlV0krSkZOSkNUK3FnR1JRbjVvOVFRQ1A0?=
 =?utf-8?B?SXBkMmptc2VZbmNqRW1qRDNZVjd5TUNDMzE4d0ViVllHNlZUcXprYWR4WWgw?=
 =?utf-8?B?TjlZMTA5aW5iN0I0QmNJS0NmWVg4RVVoM0ZKY0o5WDZIaWpEWW9mU3EvSmNI?=
 =?utf-8?B?a1lSMDNmWGtJZGRTRFB3UGtxSWUweEdGbHBQUC9XTjNwTTMzakM5ZXFZaWdY?=
 =?utf-8?B?VElKc0xKdHZ6cnJLajlqUnZoR1hiSjJnd2dGdkJtelNORi9YODUrNGh6dlkw?=
 =?utf-8?B?TG1JNHVJTnFUWnllSHlWdlNVYWNGMVlld1VtVTB5bWJMeENSZ1pncnc2SU5y?=
 =?utf-8?B?QVBGZ1YvdjlNWW9mQ2dhYmhDb0F5elY4RjZjLzVMU3ZSQnlwQlZ2S1l0cFhp?=
 =?utf-8?B?SDJ4SzRCQnJmYkluVWN4QzllbWNNTTBERS85KzBYOWJkWTgyRGdMMW1UOU10?=
 =?utf-8?B?Uy9sSmVrZjF4T09acnM0dHRBTXl4a3MwakNSckFZcjRQTGNOcHlxTGhOdS96?=
 =?utf-8?B?NEU4UUEvcEpheXN1bmp3OVJKZ2EyNWpOMUJaT3dxeWRRQ3A1dk5JeC96TlpB?=
 =?utf-8?B?dzNFcGVhN3JIUXE5WHZxeGs1eHNPdFVXaGhvd3VTMzl6a3JzVkV4NGJianRD?=
 =?utf-8?B?bHJsdEg1cURzd1F6OU1lbS9oQ0NhY1A3MnBnVE10UFZlekRIZHptR3NCZ2Rt?=
 =?utf-8?B?NVczbGJXc2o5c1pXVHBpamt6NzkvYnhNbGVFd041WVMyTE9YOHBSZElGNU5o?=
 =?utf-8?B?WDF2Kzd2a2swZ1JOY1hmVDFtcVZYYm95VG8wQzdXWTdaWWEzWWFHQ28zNjU2?=
 =?utf-8?B?ZXRxb2lMTjNtY0V5Q3pwUWJWdmVISUF0UFN6dEVxd0lGZzVYMi9SaStBZWs4?=
 =?utf-8?B?Y1BWUmFwWnhHZUU0eWM4SXRLWE81cjZRUWMrcW9qdWJZSlV2WmQ4OXppZk8z?=
 =?utf-8?B?MjU0WElGRFFvMUVXT1g1eGZNdVlhYktaTlhUcGtOSDd2akxSTmpveDBEOWgz?=
 =?utf-8?B?TzhUZ0FOdGF4NTFaeHAvQTRDL1ozdDVPVWhjY2N4cC9vcXVFT0lVcWZXTGx5?=
 =?utf-8?B?RFoycnAxMTNQRTJYS0NyS3JEaTZTT0JpMFhITVlidWNKWnBjd3lsUDFHOUdk?=
 =?utf-8?B?NEZVN3FkcVpmblJmbXdtWXJ2dHJLK0JKWWUwK3RLSm9XZXhGV1E5N2pDeFhN?=
 =?utf-8?B?N3V5NDMwMEQzNHgrN1RmNXdINTdPejh2aithdFFxWDJvbDNoWVB6RE5wUS9Y?=
 =?utf-8?B?bjV2UXFncjRWY2lVWkNFdTkrd0h4MEswb1kxdDM3SlZnZ2NTZHhWUGpCbFMz?=
 =?utf-8?B?eTZ5WXo1Ri9IbXNyN0Z1M3RRTUIwWDZnK3NMZm1xTS9nUWgrSHJTK2dIUFlz?=
 =?utf-8?Q?2l0ss+R2L89ZWkEq/12jRXY45?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c46f5-86ed-4ef0-a9dc-08daf994c964
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 20:44:25.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjPnJWiTlEUqaruiYbaMD7YIo69OGwaID6+usC2pgq4mHMgxMoUDES5QDWluwtQxDyimSTdn9jniPnqy4gqCcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-01-18 11:35, Luben Tuikov wrote:
> On 2023-01-18 11:27, Junio C Hamano wrote:
>> Luben Tuikov <luben.tuikov@amd.com> writes:
>>
>>> On 2023-01-17 02:31, Junio C Hamano wrote:
>>>> Luben Tuikov <luben.tuikov@amd.com> writes:
>>>>
>>>>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>>>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>>>>> +	if test -s "$2"
>>>>>> +	then
>>>>>> +		cat "$2" >actual
>>>>>> +		exit 1
>>>>>> +	fi
>>>>>> +	EOF
>>>> If "$2" is not given, or an empty "$2" is given, is that an error?
>>>> I am wondering if the lack of "else" clause (and the hook exits with
>>>> success when "$2" is an empty file) here is intentional.
>>> I think we'll always have a $2, since it is the SMTP envelope and headers.
>> We write our tests to verify _that_ assumption you have.  A future
>> developer mistakenly drops the code to append the file to the
>> command line that invokes the hook, and we want our test to catch
>> such a mistake.
>>
>> Do we really feed envelope?  E.g. if the --envelope-sender=<who> is
>> used, does $2 have the "From:" from the header and "MAIL TO" from
>> the envelope separately?
> I'm not sure--I thought we did, but yes, we should _test_ that we indeed
> 1) have/get $2, as a non-empty string,
> 2) it is a non-empty, readable file,
> 3) contains the test header we included in git-format-patch in the test.
>
> This is what I meant when I wrote "we'll always have $2 ...", not having it
> is failure of some kind and yes we should test for it.

I've tested using the envelope-sender=<who> and the hook only gets the headers.  I've applied the feedback above in patch set v8 including a test for the 2nd argument.  The new test will fail if either the supplied argument is not a file or the custom header is not found.

