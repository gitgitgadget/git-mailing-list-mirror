Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F143FEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 21:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjF0VcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0VcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 17:32:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906D1BF4
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 14:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT/dhF/kOSHpLVJvtmXMVrMNOQ+rMO8S2hlpvix5bgJY9qxDYRxHcGu6aMxDWjq31xuCYUyKedVwBOtLwKCtr50KSxgsUNN4cza94eG8yrt1CxrlHc74trkxjrdMjfMA6Yh6CBrFcg96rEH1adBYIJC/gtfzuOUKK4HkezStIDdP9G7Z7C3KpJ+SFCv5/Bvj7K1WPL4/MtgRmByiSwZlJXa/4PlYPXowRSdzzpn+7AEYrrO1/pSCiaOMaG/Ws3cLilC4pYkQYJZQzds/bygFYVTfrKodu8vIAfRDcpAVquCfTLLSKiZ2Bxnif5WngcsIii6P/LUGoahMUJ5KULVIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmrVR4oh2re+AS5uyC6XaC/csCi/3J6xoGGyARpb+Bs=;
 b=J4NgAkq8VzfezpNds6pTpRVJYtPIebhioiWp8bepJ6/iyCL6sNpVKxAG0d5cmefLkyHEiSQKfdirRu+0OtQuz3Vp6y+fnwekAZUGUhIeAeRJfJ3dBqNo2W18/E/zFn1wT0HYuSQ+qzoo7DoYV8G3VpQIfZPjllLJcxjUpSioG4xscwyFU2BKBJUDQiCHQgw/rfgDsdxK0PX5acc78b0YR0ecXT7us2BTp45dATDxAfVJF5FG8N9wsjexOWv6u1GWv31aYgHuVtuR7knBtONbLqQgIGL/SyXZVc/hjzL3ViQvs+SZUgOSC9q4K45XuwUJC4vgg1Q5jUZ6KgKBg5I2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cedaron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmrVR4oh2re+AS5uyC6XaC/csCi/3J6xoGGyARpb+Bs=;
 b=LDdVLCbx5dEDgUZvTnya255g1f9hi7KYoYPcK3UeK0RqEp/i0rkC1HO8FEWac4Q8nBSsSu5ArXC0lpdfR8DhYm29OEOf/0/fpUtv9+EdKbVm23TS/x5q6eJs3uZFviRmXlT2I7V7fKsjYpW1w1xPB3CpbK9S3vBZhDqR+mVGSeFbqvp4mjlo7wTVT2UqD77uJ25Hlp76IAKaU4/9pUhlms9kxUKzNdq3eMT99qZ/83rERV98GJ7Ivagfj4HLA7XLtMjJhYkzLv8b4BCMitWgUo69Y3keYsHTzE9La1vUDyhrVejOrRi/gBU4U+kdOoVz4IGdtwF2PRYt0KsU1Ae70g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by BL3PR20MB4922.namprd20.prod.outlook.com (2603:10b6:208:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 21:32:16 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 21:32:14 +0000
Message-ID: <e7e5809d-5405-1e0b-f4e7-2d97e6748a09@cedaron.com>
Date:   Tue, 27 Jun 2023 14:32:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
 <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
 <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
 <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
 <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de> <xmqqedlwhgf9.fsf@gitster.g>
 <4f28a9c4-b422-69b7-ccc1-2661d756d876@cedaron.com>
 <xmqqttusfz9b.fsf@gitster.g>
 <cd5046d4-d66c-9dac-87e7-cdb638124170@cedaron.com>
 <xmqqilb8fvgu.fsf@gitster.g>
From:   Joshua Hudson <jhudson@cedaron.com>
In-Reply-To: <xmqqilb8fvgu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2758:EE_|BL3PR20MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e25386c-094f-4f4f-1ff9-08db7755f97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41x/Q2JDVIEHciWRCES+iCFQdwkIJdRauXJAmGznTNTsg9SdMPPdkoZpJ8xlAjzsMpj7ZTpLodVSPNX/A+CEz3Sb43kVnsrdda/7p/O7tOQ3p9dj5x69FotYAN6VWt7DCmhXCI9qFUu0Yyy07oLRqirf6MdPiA5pbHi+2NrWEdoQ9V0qMtNWUTbkghVXZG88be+LOdfGfFK9UatOkkzqMdUJ3igpIVmAslI6QhNGoINn0cHjmLKoU9jodZmU7cUmybKkWRooaBmsr90+tIs0+7yeulKQpOp+VAkOJONL8poUFKLigobpz/kBqYLn3d9tIKJDLq+hLxo+Fu7LczGyM4+SXCTGw98EUeWb10GHsjXjlf1htCG7rO/Wb1Zd1mwDTQIqYX0vEKVnsEv26SCib9ZkS85RxBMS+G38j84N6+xWdttOO8qvXnpVCCh7m6Uwo2m67USVGhMuoyz4M3TLktzCFx5U9z89sNIayUWiBKYuVESruqc4Dk7i2cVI5LDjr0sNUfv+FR8/+Gwrso6izdonqD8sqd+smsXWaQcHftReRSaNC59HK8LpnKqEgcgP7EfsBp3JkjaakAobrSbkBhAs276zsQkUnYw7/6vN5qoNCCCmZJVyNfj+ghwVsgPd4DZ1tLVLCkhT0lHqruQovA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(136003)(346002)(376002)(366004)(451199021)(6916009)(316002)(66946007)(66476007)(66556008)(478600001)(4326008)(5660300002)(36756003)(8676002)(8936002)(31686004)(6506007)(31696002)(86362001)(2906002)(41300700001)(54906003)(6486002)(26005)(53546011)(186003)(6512007)(38100700002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZ1SU1hWUo0blYrd1VNa21pckI4cFZKNWdVaHN5c0s5VDEvNnZGeGlPaFhI?=
 =?utf-8?B?UUNLd1pvemVrUXBmUDAzRGdUVUVTV2hpSzZnOGZSbHhSYTh6eVVWUmJ6bjFJ?=
 =?utf-8?B?V2lrWFBrbEpSUlJiQ0RWRzZTeFlqbkxrT0hUQ2drWHBvSFVJd2pZNklHN1JU?=
 =?utf-8?B?aGp4UkFRZ2FRNk52TmJyYUhkaXUyakVDbkVJR3pjck8vNnRYZDRRV0h1OE1O?=
 =?utf-8?B?ZnljcnZEbDBiNGdjSmxOdUVleGthS1V5MVRZOWNWQWczQ2xJMTU4ckJybUM3?=
 =?utf-8?B?QzBkWis1SWJLaFBpc3g0V1NkaUNEdjFiMThnUlpWalppbUxzTXh2WW96YStj?=
 =?utf-8?B?MUdEcGxYbkdRRVp5QTZ6NzVXc3FxR0gySzFlazBYVEFjcWpBbW1xS0ZhYkpj?=
 =?utf-8?B?VmZYOVNwOGVFNFVMd0xaUmxaNlo2SG1PV2VFazJIeWdpTEd5VGx1aFoxMEQv?=
 =?utf-8?B?MjU1K1FsTUtRdXlkNzNqQy9TR2lINW9VbWxBWkQ0UkNWRnlTZ3ZsUjU5cGZh?=
 =?utf-8?B?K2thdU9KaU8rd1B6SHN2ZGhkMWZDWjBkeElTdHJ6ZkpKb0kwMGw3MGwzUjNQ?=
 =?utf-8?B?MSswd0lKZS9RNHdEdVF3eG5HOTZWdllLaE1acUZObXd1Z0FVR0pJTVEvaExY?=
 =?utf-8?B?c3VxMC9GT1hTSndNdUsrK3BGUTg5V3FONFFFK0g2bitzbzBUdkhWdE81TjlQ?=
 =?utf-8?B?SjJYZ00yTDJ0Ujc4SU0xckh1MllEUHVJM0RyUEZNTHRaemdYRlpQUGd4Zi9Z?=
 =?utf-8?B?Vis2bnFLSDgxRitZZVhOY1dBNlMvU251MlVtbDNneWxIcDAreDdRTHp0dHgr?=
 =?utf-8?B?Q1pSUVppVTNOV1VJZUFqanlyV1FsOTBxK2dScVRIbmFkRkFtZDd2b09PNnBQ?=
 =?utf-8?B?UVo5QWJmVDNZaWZOQW1QRkM2d25zQzg3Y291S1J4ZXZwQ0xUZlI4SXZIdGg5?=
 =?utf-8?B?YWppMGc4VmRqVHU2YVVUWVZPL3BSZmtveWlvRG9aVDhyL1BmNGVpUndaeFpl?=
 =?utf-8?B?b3BGcGIzV1FXcEsxUEFwSlZPOTBqT0hXekg0NlVKL0hBMVZyWi9lVElvbWtp?=
 =?utf-8?B?UEdvMnU3a3NxNmc3d3gvRjdvdFVqUm55Ti8zai9RYVUvRmpJb3ozVDdKTkg2?=
 =?utf-8?B?alBLS2VQeXdzNCtkUVpHWmxNVUVVN0c4RWlqVUtIbTl0bGFVN0pmQ3JGOEpE?=
 =?utf-8?B?NkZjLzZvNloyRVR0UFNsQ3RNOEh4d3pjTDc0bkVsbHM2VzFseFAvQ0NmNnJj?=
 =?utf-8?B?RkFFYzljS2lWZTFITzZmVFhNc3c3MXozdktTQjdrU1o5TWNzc3QxTDQ5OHNj?=
 =?utf-8?B?bGNRRTJaVXZRUE1MY2FBWXRmVjFmNjdqYnplRTRyaktpNVNyZXRHTEVNY0ps?=
 =?utf-8?B?M0dBSzc2ZUMybm8raUdTY2pEYlViVlVuMXc3Z1JjWmhlZFZtMmdpZStINFVk?=
 =?utf-8?B?SXEzQ2ZFZHdGdnh3N0tQeTR5eml5VmkvWmFIQXlBS1JNLzFyOE1HVkNSdVpK?=
 =?utf-8?B?UHh6YVFmVHNBWDFOYUZVQTliK2tWZXBLNFo5MG1Wa1RnUHFUOW1xNEQ3OEtk?=
 =?utf-8?B?dVVBaTR4eFE1cUQwanIyVnUzcDBSWUExY0JNakJLT1pTNExOSzNUakVKRVNE?=
 =?utf-8?B?MVFoYmN0UXg4Q0JnNy9oRXVuYzdsZUdGNmh2MmlidWxKdWVKNmEyenJheXZj?=
 =?utf-8?B?SHpTQWJMcjNaMS9VSTJyRVhHazlDTTVpTGpLR2VLU291L3NiS0VtbjhnSVFK?=
 =?utf-8?B?bjd2LzFjcUVuNU0wOUlhR2laSm9rZkJGY3FnQ3VNbWZFcUVTd0RYNXdSaUdu?=
 =?utf-8?B?eGM2VzZKdDNpbFQ1VldZK0xocVAvcWlCTzU4TytFUjBodXNZVitlaVRoempz?=
 =?utf-8?B?SklpbDJLb0cwNk5BL3RRL0JTNUVFcjdSNVRnTnBzNGNnem5NWjRFL3JNOXF4?=
 =?utf-8?B?dVErdUdIWmhMZCtjejc1TjMzcUVDNFljbWl0OHBEQk9Gc3FUeEMzOUF6MVdz?=
 =?utf-8?B?NzJQNWRkdWxqdXp3Vm5xaE1TaG9nY2lYRE4veXFSZ2VUYUcvTkJJMDJhSldG?=
 =?utf-8?B?bU1xVVNNcGFpeTJXWUxhMzNydjdwemxybVh0VGhjcnREZmt3UlBiV295UlFY?=
 =?utf-8?Q?iGp0V1GKLGNhfae4OpSyK8gj2?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e25386c-094f-4f4f-1ff9-08db7755f97a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:32:14.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku90rOsCM2ta6qJkM0PFI/+/wydiutxVX3dBteA3xBDEFRsImMSygZxXzdDFCKHdwn4mqYNXJ6/nL/6O6HShsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB4922
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2023 2:26 PM, Junio C Hamano wrote:
> Joshua Hudson <jhudson@cedaron.com> writes:
>
>> Try changing kill -9 $$ to exit 137 # 128 + 9
> Yeah, but then (1) we are not simulating a case where the external
> merge driver hits a segfault or receives a signal from outside and
> dies involuntarily, and (2) we are codifying that even on Windows,
> program that was killed by signal N must exit with 128 + N, and
> these are the reasons why I did not go that route.
>
> Stepping back a bit, how does one typically diagnose programatically
> on Windows, after "spawning" a separate program, if the program died
> involuntarily and/or got killed?  It does not have to be "exit with
> 128 + signal number"---as long as it can be done programatically and
> reliably, we would be happy.  The code to diagnose how the spawned
> program exited in run_command(), which is in finish_command() and
> then in wait_or_whine(), may have to be updated with such a piece of
> Windows specific knowledge.

abort() => 3

Killed => no you can't detect it

Faulted => exit code has the high bit set ( >= 0x8000000 )

My starting off with "the logical equivalent of calling abort()" has 
proven to be an unfortunate word choice. I need to harden up the exit 
pathway on my side _anyway_. An OOM at least does turn into Faulted.

