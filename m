Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC43DC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjD0TqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0TqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 15:46:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01081FE5
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624779; x=1714160779;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BYQLjlQjPldjdtVp1kab6RH9N0/G7GkMRfTKfPgoR8c=;
  b=KJDEmXa7h6fgpIlCTL4o/9fwqlUoaoEqsJBGdXKjXyUM3eJvS+yu5uJk
   fNIdebSPgvZy4gMjTL7IrNS6jLIFWtZ+rXVP3NW05rPVXVdgqGFz/pTBk
   niz0Y9xIQ9cKfUO/vbGdQ6r0qhEQicfJvwizVmkVDx5C0f8yi6jSVyk4g
   Uim2w52i2Z8VaKl3Cq915DZT28GCQhE+mKx6ZqFXl8GcPg/2hJ+WYFPNz
   xGpl4x7dENRA0TUR1lBwhXKmB4oMPZz2RYTf604kZE8749qIorUx9FICf
   XLTVI/16O7J0Vgpb3mHp1BYPlq5yxtIKW6Aj70CKncemBzH4eETAW9zRv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410612127"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410612127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725066897"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="725066897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2023 12:46:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:46:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:46:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:46:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrHYq5l3WHILevQxkFpOcVS+Y6x7HLR0AEx7hS2AvQSTjbPBltvplqotHDw6OPSprDleCdC685G2K3H//KOTYivKrJ2VXxU3YFupqLuV4io7iikVPWJUyi/WplTos/pNwZIsPHAyX/2c0S5GFqddB5HtR2CXmWvgUlcGL5KKnxqxw/dGu/0s9RohsW3AodR/CcRAjV/qzEKxeBs40Vz087GM+TDdft9x8o8tlxM/GzYUbUkS8Cr5lq9dw+6i2EEkU2VYIsWV2y6+5cLNAvLhoew/zPqRvg1KgsDDDghm+Abm8Vo8V9w6t0bpoPf2kqpuwiLBVTm/410ZLi5DFEuRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47wCgMwdLxoh/2XgPrjaGfgkpk7dzHpI4z72wh0sTZc=;
 b=hzddb7swXQ3UM5prZIo5rql/0kHsR60FRexyRTiwiHUtDBYk6fmXJ3pEIbv7ckuTi0Xvg9Uo8uZlsDyt5JsT53+V7kwyLofuFzWyN/JipusAePEwJxnC96gtzt5tB0f8FjhdSuReOCaOL0dxlzS/ZpYoOfm9lAt101TH5MjvyqTTSswWaMOLuIM/dImGNRsQ8/w9jKYroJQHAjOKyA0/X+Dji+6k10KPfelO5rzEnlJC6HtNkTsh+JgDWjVsv20CzuV0kIF9aX7F6xX804t55JytvjciUCvEg5q2tnpe8463TyfZJbsfhvCTtD3x5rl0+bdVdezDo5eUE7+9AGJQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 19:46:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 19:46:12 +0000
Message-ID: <82a6ad96-ade5-2cfe-cd6b-0b6b94b6658f@intel.com>
Date:   Thu, 27 Apr 2023 12:46:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
To:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>
References: <cover.1681906948.git.ps@pks.im>
 <6446e3db4702d_cd6129452@chronos.notmuch> <ZEekRNuPmObU9Vsq@ncase>
 <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com> <xmqqildis89b.fsf@gitster.g>
 <ZEpVatqnhdUSMWYY@ncase>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZEpVatqnhdUSMWYY@ncase>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bc5bde-3801-4400-21ff-08db47580e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzreNm9xB2EgtvCo6qrHJSaT+vI9Jg0SV+oHKRIMwv/J0ogwWNjdZCRhvfAw+QhBok4KwXrBfbdb0YKDHcIyZ3yfXvfPQnV+GOoCYqJYA7Rby26uIUemtWPkgOg6r4IrwRwVcIiaI60vtqOfcpNUo9SA+uUY41MfyZJjKzafCSim8qi9K4xw+cNd+Kf9P5WSMt6AeKn2JpRj1YHLnuQ67s+HtiNHAz6OmRwETFikRHoX+O8Rf0yEzSiMgy92jVQyvxiaubIwWggLz9bXcMFUVAVNGJov6SOSOjrL9B5YYOh3GHGeGjlEdfVcbLtoC96RgX07leHxX44KDjJbixAuGlvoEjE2Sf7mGWMrpPH6hFtdsJHPkiW5s7jZ3/kF5G7sRF2nJhfuxRs/ns6iNh8VClW+QyvfrMf3lKFAZ5Fq+a2RlnTr2pfs/MPQZxKUbfdiVXKaF4dT5byPogqRXbaH2zumbzxzXH460gjw45R5Q0PyuD8aKJ4UoYTcnWHyZX5vYIsI16XxJaoOiLKbTml+8sn6ckA+PA9nbHNgxkBrAXV5rOJfnIV+N9ODwgTShiITN/Uko7dyMDsgNT7QJNneEoPcdIvfdwcIJjcrlwEBm4vu+kOPNKW30aeZX6vcwvcm9kyySs1rKbooddvJDLTn8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(31686004)(66556008)(66946007)(4326008)(41300700001)(2616005)(186003)(6506007)(26005)(53546011)(6512007)(83380400001)(66476007)(478600001)(110136005)(6486002)(82960400001)(38100700002)(86362001)(31696002)(8676002)(36756003)(316002)(2906002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQzTjZYSER0bU9XYmtGMVRPTDNtaTc4SFptRDhVRUtBMUtrTDAxTkt4Qy92?=
 =?utf-8?B?YVliNXNCUzRueTYrWlVsQmcySHhyOVZ2ZFUzRHlmLzBpM3JwWU1kN0N3NTVV?=
 =?utf-8?B?RHdBVmd1Um1qdGZ2bGdhTXNoRTVteDNQSU1OK2VObW5DSzFjMUdFWkx2TVcx?=
 =?utf-8?B?N0lpQkRUVjZUaG85ZzNCT1FIVzd3eUgvekRQenY3QjMva1BkWENDbXBHYzdE?=
 =?utf-8?B?dWJ0SEZobjRHLzVYZk1OUnFmUzR0WTA5Y3JVM0hoS3V2NWlQRUc3RER0ckFP?=
 =?utf-8?B?dUNCRjVUb2N6TjJrc3RLUmsvaHNNMER0R2RHZ0Q0U0d1QW9MTVlkUXlMM0hU?=
 =?utf-8?B?L29LQlpsbllDUDNyTkVBTnliOUIwS0lOQmx6S1IzOFJZdURLZjdRNE9zRlgx?=
 =?utf-8?B?L1VCS2tmckpWaS9CWVQ2M09wakYzSUtXS1FPOFdSc1pjelAwalVmK2trbGRK?=
 =?utf-8?B?R3pjMm5uZlYxeUNNbHJhQlcyckZoQTJUcTV0bE1rd0RUdTcrOVRiYjlvRzlp?=
 =?utf-8?B?R3ZkMWEwYmltY2g1amExcHRSTkVQN3o4dGZTbEJwMElOOEtrK01aaDlpMlAy?=
 =?utf-8?B?OXFMblR4dlBuQkt5OVJmSXBQaVRvcjJmTHFUYXJlTXlHMDUya2piVkVNT1hW?=
 =?utf-8?B?NlVWZ243ZVlRYjRaOFdMNVNldDEva0tpVGRTL0NuSm1KdktERDdhS25NQXFG?=
 =?utf-8?B?bVVsSk9MVmxyOUpsc212cTNqYjhPZ3Bpa0xTV2VDeVJvNHFHUnlrTGlQMG41?=
 =?utf-8?B?SitqcTV5aHg1cXNMYzB0S2ZKc0FXeVJHOUw3SzZxbXBqQ1NOSERtems0QjB1?=
 =?utf-8?B?SUxPZHZldkZPTVBaTzNubmpHdHNadWEvY0FYak1CZnBrVzJUZm5MNGVVVGZs?=
 =?utf-8?B?dnQ1ekE2c2xObEM5NEtkb0FKK1dMQVYzaXU5WW00Z2tvOXI5Q1I0aC9BU1pz?=
 =?utf-8?B?cHZuRlpLeU5Bdmo4ZTNyR1ovQnp0T21SNWErdDhlYUp2SU1yTXRuUnBFS3pL?=
 =?utf-8?B?S2dRSXg4ZG11YlJTb1g0dXlneXlxRzU3ZUx4V1BXclhxamwySVdZVVBnc2p4?=
 =?utf-8?B?TnpkcTdxcWRuVVFheWFsVy9pNnVreDJ1TmY0VUdQV1lQRXVBQWYxSVAzSnRt?=
 =?utf-8?B?RFNxcUdhd3ZaY2RYS2VyNjdzU3JLbWovbDlIcFByNFp3Y0JTSU1oZVNoRkp4?=
 =?utf-8?B?ZDJUMkJtRmJHZmY3eU9RRmRMWElFYitRQlVlV0JZQ3JMUEN4Tm5hT2twYVRK?=
 =?utf-8?B?Sk1uNVFKQVgzOHhzTGFvV1QyTkd2TE8vVmNZY0cyWENkcHVIY3lCY2IrMlBY?=
 =?utf-8?B?WmVxcFFiRk1wL2RZVGJXdE1VZ2JOeEFvQXh5VU1TSURvbEhvTjVYelhhRXVu?=
 =?utf-8?B?V00wcHV2TWlDRjRyVkpnZ0NVWVBETmxEZVVaRzMxNDNKRkN3VHl3ODFveHdH?=
 =?utf-8?B?SnNhYUd3NytneGZsZFhZMzk5eWQvOWd4ZE42UnB0MHZxak1vMXZtbExLYnkw?=
 =?utf-8?B?N3A0VC9zVExYa21MalNKL21uSEdCUlpOWGRUR0xjZStGMHRyQXpPZE9RRVpR?=
 =?utf-8?B?VTg5dHdHRlRBV2hPK1VPczEzaUh6SC9aOUN1dWd5U1BxZVkzOW4xQkJPRU9F?=
 =?utf-8?B?VEFpWDdiOUxNSjE0YWlYOGQxQjRLQzRPUDVmb1pnTDVSY3duT3grOE53aUhF?=
 =?utf-8?B?SFdncE11U1lGb0NlaWNWWXhkckdCNGpCTXh2b1VKcVoxMklrbUNPcmNjencz?=
 =?utf-8?B?RVkrMExlVkVLZ3pGb284NTF3OGQ0ZjljWHpQVy83T0I4YlR4cnZPUzZVUHJK?=
 =?utf-8?B?ejcwRUJWckI2anlVU1lvcFdNb1h4WlZJbCtGcVVJK29DRDhJd2Iwb2lmdk9U?=
 =?utf-8?B?K0xtcVlOUUVvbDJlTmhHTEs2bmhsL2NPbFNZckVybXlPUXRPZVJqQXA5eC8x?=
 =?utf-8?B?cGpoc3M3NS9pTGpISWE1RDNmRmFiTWY2SUoyOXJzdlhqdkxCQUR1djVrM3Jx?=
 =?utf-8?B?ZFg4VGVlRlJZUnZLbzIyUUxCU2c4Q3pNckljU0c1LzNNdGVVT0xRNzFwSE90?=
 =?utf-8?B?dTZ2Q3NRNTZOc1dSRWR5K0h3ZE5VczUyOEdaSkU4S0JYNERMUEFYSkloQmw0?=
 =?utf-8?B?S0FzWkdiRkRqd1ZjajhJQ1Y2WmluZlUwN3FXdlpNMEltYms0bDZRUDdjRlho?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bc5bde-3801-4400-21ff-08db47580e19
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:46:12.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGJv+a8bzGwIJ2I+3xWyELsk+0YaWLVtt1W+kLD+grne5yJLjQnvYsBYvowtYbAA6iqx/Kcb3+6R5o361F+RJemmodDCEIF81yzbhA34/T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/2023 3:58 AM, Patrick Steinhardt wrote:
> On Wed, Apr 26, 2023 at 01:23:12PM -0700, Junio C Hamano wrote:
> Furthermore, I think that `--[output-]format` has the advantage that you
> don't need to handle priorities or mutual exclusion of different options
> that all apply to the reference format. To a user, it is not immediately
> obvious what `git fetch --format=compact --porcelain` would do, and
> which of both options ultimately get respected. But that's likely only
> true for future commands, because any migration would create the same
> kind of ambiguity for preexisting commands.
> 
> If we were to also migrate preexisting code to use `--[output-]format`
> then I'd argue that `--output-format` is likely the better name, mostly
> because it is less likely to be ambiguous compared to `--format`. The
> latter could e.g. easily confused with `--object-format`.
> 
> So I think I'll stick with `--output-format` for the time being.
> 

I agree. I think using --output-format and migrating existing commands
that have --porcelain to use --output-format is good. I'm not sure
whether to keep using --output-format=porcelain or whether to use a
different term there.

I definitely think avoiding confusion with --format is good, and I don't
think its too much of a burden to have the longer --output-format as the
option name.

Thanks,
Jake

> Patrick
