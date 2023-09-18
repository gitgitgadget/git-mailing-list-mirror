Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1339ACD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjIRU05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjIRU04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:26:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE270B6
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv/68GelDknfS5CoNNmQF40Sk9O9Wh7OhaAPuMtvuz/DJieCThtk5vf5GsZqKpS1BpBmAuW4PQQ51+l+zNAv5GcVLJt0kyaqLVuGQAgRIKHuHT5vzQA2lLkFouK9tGyJXKg2LJZ38BP0sQ6cSsJGM9VpYon7SRGHgRbT4+pqBI/05e3NSFcw7Kkn/+SozaNjY/bVeyxpQNFYcXYDCPzvHT2NFoA2xPo00VSSgbZ6KThM9RZfvbWkZnbaD+D5S3sfnO7vxBzUK284r+5oeJ6XUv1kxH5K8rQ0ydNC2yf3jOGpvXcZO+oaQ9F2xv/lLDyDgqdffnE+/Rb4YUwLQ6FiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/HKZ1hTEf00LZVTulMF9vuFcSFF9Hz3H96V6ZfwZCA=;
 b=fbf6wQIaen5hfEYQ343wLYcwYRzQ+bBKyu/IOfvCN3GxbPfr5WqV06to4pFG/zy/WppAmVFg+KRwjD6Y7/OZPK0xuWmxrK4pt2lnfKKtDReOwEsbO1IQDRisVfewg34qaqbuoamG4olFtZvBZJ2KfdpX7GWOL+0uKZlQJzhYRthwizVxSIIWjEeaG04ogYx5Qhm9xqFYmbwvP2793H2XtbI2iz/pKZnZruEuE8zkwZ4Tvson/w2QIdw37JI+OhPpcYs7c0ygEqG12YhGdyDF99un+8bZU4e/ULtRNvLgzRJk4l87OBK8N9ZAsEpdAhEx7FWS3OtsQ+CWKKGDuWZaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/HKZ1hTEf00LZVTulMF9vuFcSFF9Hz3H96V6ZfwZCA=;
 b=GT580qhTI2NoZkeUiUjHq8YQMvuIGC+C5Bx83yh1tLaXxA/5censVn6pxTCXnclv9F/rd7qi76den5T/11SVb+8BU+gMBZmQ24qVqrCMYZjFj8fhqWEratHNksuL7TuHJ75GhBGr7f8rV5Vvo/UnGntAx3EDE4MAdD9AVdpXmfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 20:26:48 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 20:26:48 +0000
Message-ID: <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
Date:   Mon, 18 Sep 2023 16:26:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ZQhI5fMhDE82awpE@debian.me>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <ZQhI5fMhDE82awpE@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::13) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 837c753b-b5b4-4a5b-5409-08dbb8859582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fgZ53sn+RqU7vb3yElamkoVlixeTLAXhXAMBNPMHDbJUSJXOMiux4r9TpBMEqZyrGeNLaxkZiPHF9d8j40M4QORvYB1nA3QODRyjRfwGxnfBgdmOX6mlG4Rmx3gJAW77U8BSMnw/PXJXGkUyQrRHWDc1FMcendMLHX0mXWagSUmJ0yxzejx6hcYhQoLji9+kWFH89D9S9pfs0B2ikyvHrFVnVTMeUlzRU85MsN4HxPfhAlIBP0Rw+QRIVB/2er6XeCNgBEzagRpY0HAllbAMi9DbrVlx0X0CdUbi3+OeUnCBDTOAxuFgjKgoIVyLIYRr2f5Q1mF8NwE/j01VIhKudFp2JA/4MIs23HtHqTf/Qq9G/xBud7h3saekw/3jNEl8FByhzozs2kZXBWBnN/nuZiG3EI9Vs6HNmVnik8e1uuV6cQd3t2Prt6jV3DvrMy/lu9EaLuX7MetcryAd/Szs+kvCvziHebf5o95QdUYTg8Tyc4B+SKSLe5/aEM1HkJOJjJ4R11cHKTKl7p/EivEYUf9k/ICfmFbhHR03tkXBfYhs9GpImKTrMUDAYQGm8A3JjzTm2qGmkdHFD0UitBFCJ8+y0+q78zXgDi2V9Yj6tns1BxWh/KVLj/tuMFWfV4nXvDYUioPw+DdBNFTrKvKH+YRLRd5xQCTvW5EMhJSTAvOmiPRK+QEgNhFU7DX6ljm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199024)(1800799009)(186009)(6512007)(53546011)(6506007)(6486002)(6666004)(83380400001)(86362001)(31696002)(36756003)(38100700002)(2616005)(26005)(66946007)(66476007)(66556008)(110136005)(41300700001)(316002)(2906002)(5660300002)(44832011)(4326008)(8936002)(8676002)(31686004)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVONC9zNmhLY0YzRUJWNmFmd29OT0hjdlRJMWRpYmkwTGN6UHJCZ1dTaVRr?=
 =?utf-8?B?SGNnMCtkWHlQa3FGdU8yUlhaSUNJSDJuWkczQjJEK2YyS1E4ekNGZ0lZbG5q?=
 =?utf-8?B?MjZ6TEQ3bkQwV2thWmswWHU2VmlrSEluZ1l6Y2o5ZXZQR29yaW1QNVl2V2kr?=
 =?utf-8?B?SzZUVzl4L3dtbGQxUFB1b0E3bzRjcXVTYmNrdE1OeWpmRUZ1MzhxMWFnZU9t?=
 =?utf-8?B?NGh4a09PbFUxcGtZQ1VMdHdyMDY2Ylg3eXIzd2pyN0VORm5vR2UxT3RuM2tO?=
 =?utf-8?B?dUJwQXdGS3podURydURFa0RiMjQ0cjgzSFVZM05OSVZUZ29waTMxUHVOQ1cr?=
 =?utf-8?B?MGFvS2RKQWZwS2xSMG5IS1B3OWxUdHdrdzRwWEUwSGRrR3dCZHlFVTltNSts?=
 =?utf-8?B?MC9CaE9YSlp4cXRFZFNlY1FoTzloVTJicjJhekZ2dk9jZXdaS09kek9SNWdT?=
 =?utf-8?B?WFREdU1zZ0hjQmFaY2llb2lJazNvYmE5MjVNdSs5RGx3MEQwY0hyZkRyU3VI?=
 =?utf-8?B?LytveGR4VGkweCtDVkk5Z3ZKam1LcHcwVENCdVZ6VlRVRk9FUlBtdlBGSEZT?=
 =?utf-8?B?SFYvUHhnYk1jTXRiUlhiaHplU21tV2QwWmNHcElPSmNYaE1wSFExQmJlMTd4?=
 =?utf-8?B?VHcwTm5TYXBwVEFBcFpIeGtjQ1lINU41eVZuWHAyeHgwMVU1QlM0L1BkUXVn?=
 =?utf-8?B?MkYyZGpVUnZMVkZkd0tiY0o3M3ZUWlJWeGxSOE14NUVRSEVHVEZlUHFOUzZu?=
 =?utf-8?B?Q0M0b1drYll4MkVsOFZPalo0c3BGVjFWbmFuVFI0TDM1Q2tLazRVWVpXeXRY?=
 =?utf-8?B?TW8xUXJVaXVtcUYrSGxTRWQ0dUFGYlBtSkZwSDlSc2diZDlpcEt4b1NvaG5p?=
 =?utf-8?B?SGlSZ2hZOUNyMTlXTCtwYUU5aWN5blM3M1VjTXc3djVKaVQ1ZFEwK01KSVhW?=
 =?utf-8?B?ZS8rSnVqZC9QdlowdUNpTFFXTURXVU9KdWZRNXowbEowbndmWWdMQTM0VklM?=
 =?utf-8?B?RVR0SHJjZ0x2VWV5c3hSempKVUNaTlo2S1lqbHh1YVdrVVcxM2NYc3pFQW84?=
 =?utf-8?B?aXpRSHJCdlNRajBVSnZjRlBKTnFpeExpWldWY3VYVDlmVUdxWVFsZmUxOGJ6?=
 =?utf-8?B?OVF1SDRQNkVXNnJBOFA5UlM2RDdNNEpmbnpJUFFjTkpiSzBKNGFQZG1HSTN6?=
 =?utf-8?B?cHhWZWdyRDVFY3phY25JWDN6bnA3eWhRRWV3Rkp6eDdGYzNhdzZGUE16VVBo?=
 =?utf-8?B?MHpJRW9RWDRwQStOckk3cnR1Z1ptOVlhUXRackVvdEhOam1GOWd6blM4TWp4?=
 =?utf-8?B?a0tIbmhjbXFqSkNZNlQyelhyeGs4cTNIa015cE02SGQwbVZ2V2V1NXcwakIz?=
 =?utf-8?B?Y284N1F1U2UwTDgydWJRRDJaczZjT1RpV3ZlVTlFOGljNkNTY09EMGoxWnhy?=
 =?utf-8?B?K3d1SlNpTjdSem9ZbnZSeVp0RDV2aXhycWFodVBYU3lVVzEvVUpjcE9MYzVH?=
 =?utf-8?B?aE12WUliU1AwYWc3MWd3WmFvNGpZUmlsbmI1UHBhMjZtTkNlTlMyYVh4VUEv?=
 =?utf-8?B?R0VkWU91WUorZGRWbmRyL3dqbnFNb0xJYkdvTG8xRFdJSjNpdWMrT29hK0FU?=
 =?utf-8?B?SG1temg2OTlYN0JpajQ2dU1Jc2xTUXRHVU1hYlAyZlRLRlZzbnJlRFBGSzJr?=
 =?utf-8?B?L0Vicm9kenhNNld3QkpGcTVIUFM5c3N0UitBRkRzTjUxaGppR2lIT3dmWFNI?=
 =?utf-8?B?NVlNWlJRMU5VQ05GTFZCdml0OFZhVEVQRVlKYW5DN0RKTlNlaXpYL0RCeFFH?=
 =?utf-8?B?dVJpZGp1Wi9KdHo5Wkh5UWxzbVVKaDBJdGkzVmVFWHpXMzBuaThrTTVGNTcw?=
 =?utf-8?B?K2loWkZiMkVXY0NGcDc2KzIzaUM2RXBmVGFlcTJzbXVFQW1rR0VadVJJZ1I1?=
 =?utf-8?B?b25zUUhlMVUyRkdXbkt0VWl5S3dVUEROMEFlU2hIRE5uLzlqb29SbFJtUjRz?=
 =?utf-8?B?Y2VPb2QzVlE5QjVsb1gwOE90RFlBYmJrS0ZtK1FXMi9YQWdoN1F6amZOY3o2?=
 =?utf-8?B?WFdHenZGVU0yY0FZZUlpOVpGaGYxUTJGN3hMSXBaVVFLZVJ5V1J1QWhudDNG?=
 =?utf-8?Q?CHMsoEDi9kNd/outrOo+YDgWm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837c753b-b5b4-4a5b-5409-08dbb8859582
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 20:26:48.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANynkTX/AUm4J2VI0o9NQHJSG2iLlZEl34K7uykRt0e672LawLE1TspZyJV4hADuJQFtjfyiVtrNuntJHhXfxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Author of a8022c5f7b67 (send-email: expose header information to
git-send-email's sendemail-validate hook, 2023-04-19) here.

On 2023-09-18 08:56, Bagas Sanjaya wrote:
> Hi,
>
> Recently when I was submitting doc fixes to linux-doc mailing list [1]
> using git-send-email(1), I got perl-related error:
>
> ```
> Use of uninitialized value $address in sprintf at /home/bagas/.app/git/dist/v2.42.0/libexec/git-core/git-send-email line 1172.
> error: unable to extract a valid address from:
> ```
>
> My linux.git clone has sendemail-validate hook which uses patatt (from b4
> package). The hook is:
>
> ```
> #!/bin/sh
> # installed by patatt install-hook
> patatt sign --hook "${1}"
> ```
>
> This issue occurs on Git v2.41.0 but not in v2.40.0. Bisecting, the culprit is
> commit a8022c5f7b67 (send-email: expose header information to git-send-email's
> sendemail-validate hook, 2023-04-19). Emily's earlier report [2] also points to
> the same culprit, but with different bug.
>
> I triggered this issue on patch series with cover letter. To reproduce:
>
> 1. Clone git.git repo, then branch off:
>
>    ```
>    $ git clone https://github.com/git/git.git && cd git
>    $ git checkout -b test
>    ```
>
> 2. Make two dummy signed-off commits:
>
>    ```
>    $ echo test > test && git add test && git commit -s -m "test"
>    $ echo "test test" >> test && git commit -a -s -m "test test"
>    ```
>
> 3. Generate patch series:
>
>    ```
>    $ mkdir /tmp/test
>    $ git format-patch -o /tmp/test --cover-letter main
>    ```
>
> 4. Send the series to dummy address:
>
>    ```
>    $ git send-email --to="pi <pi@pi>" /tmp/test/*.patch
>    ```

I tried to repro this today on my side.  I can repro the error when
using the address "pi <pi@pi>" but that's not a valid email address and
so one would expect it to fail in the extract_valid_address_or_die
function with the error that you mention.  As soon as I make the address
valid like "pi <pi@pi.com>", git send-email no longer complains.

In your original case, are you trying to send email to an invalid email
address?  Is it an alias by chance?

Thanks.

> git-send-email(1) trips on the cover letter since there is no recipient
> addresses detected. It also errored out on patches without Signed-off-by
> trailer. When the command should have been succeeded, I expected that it
> asked me whether to send each patch or not.
>
> My system runs Debian testing (trixie/sid) with perl 5.36.0.
>
> Thanks.
>
> [1]: https://lore.kernel.org/linux-doc/20230918093240.29824-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/git/CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com/
>
