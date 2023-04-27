Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC8C7EE22
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjD0Twq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344041AbjD0Twn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 15:52:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33911FD0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682625162; x=1714161162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YEo4muHwy83yiCZtfYufHJ9bpw9zkyMaV30dzhPxNSk=;
  b=C1x/kZ4PT7nwZShUs59VGRifQUBRNiU1G3RU0GBdxp04C+EwlOQsIXRD
   i4xHwnNckLW3eUOyM7uuS/l131myg8PY44KMBiPqYCg6nxfp3Cn1DNNrF
   5XXN6ydjXvGHRtwNNUYryJxlsAzeLCN1cD3b9SycyqXBCtkocFcEJh6Jq
   PhV1iLhCMFcyOINTlvGDieW+KDZQI0DsFpeLZv6CGBiPbBR/HAUjgxG0I
   D0iHy6M8NQ10fLKn4E1KVDZGFKcQGM5dmVs4pwv8Cef8X+H1SwfgiuNlf
   anf5rJWOWJADME7MmbcnKLtb4pWFD2eo0JdCY4mbO9KzedM19EB6YGtpy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347573496"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="347573496"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="688556079"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="688556079"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 27 Apr 2023 12:52:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:52:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:52:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:52:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjMVK3BuUJdrqHZHU7mWHDDoPVvGAURgVUyMMG9IwXFdf/xpL4R7i+8V2lNVl/Rgypbi2VPhTXOrbgKnRMVC4zHX11pQicECYGVhmVh99PPE4/t8TYhcgwtZIhI2tU27Uw4xyu4ByZwIZKb8JyjuAeTIoEiI/guWdB90hnDbgeGZKJ3gSFgsXf60KRglFAfgP4VZZVpxDy4NolDxwTX0tygYszIOxgNV+gV2YAImK4W6z2jSDyXmF66FXJ+HP6KKld0DHHaZaQD4Zf8qthydNo12SZxy9XfuIJAOV7MzoJi/UyPkw9F5jPL0oa+rP5RQ3oKzWPGLSN7hzKq22nZrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEo4muHwy83yiCZtfYufHJ9bpw9zkyMaV30dzhPxNSk=;
 b=gUe369kIfkft47ziEgT1yf0SxlKXxTiFbMdpElGptYEYVnnhMedr868+EJk6ISwSRzzSVYzlerjqf1eyzXLSsZ187leiAKYdsvEt31uaNQ58teZvPTgAl25lvF2/5vovkNinhc31piQVgnWM5VMWTBmuHsULyZoEwtTV7LoJhbeMRJEw461VEH+2toFjIX4X9wlQJAk6CDx5AHvWzgXXzi2mZeyULlVDxdG9kr9N0Rj4QBcwhnr4PsecGPRk9ABcNGuYNwJUgB+4OZgT2vo0xkHm8uSMUCaGCAl+v2LRakc9U7ny2oCKd1EmwixduDsSiDN6lAd4IBjgWAN338GABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 19:52:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 19:52:38 +0000
Message-ID: <2876e9b5-b9a6-713d-8c0c-0561e1c6d6da@intel.com>
Date:   Thu, 27 Apr 2023 12:52:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 8/8] fetch: introduce machine-parseable "porcelain"
 output format
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im>
 <d7c1bc1a80406ad320c2de684e0c97ba14827c7a.1682593865.git.ps@pks.im>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d7c1bc1a80406ad320c2de684e0c97ba14827c7a.1682593865.git.ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c5a615-1733-4427-3c79-08db4758f436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLz8CeXjCpgSOTlWnwda7gwytfqicB0Dkme6XWbkJINi+SXAEjdAvoDPCK5lwXs0evBbHuHcIMQKXi+5ejfqHfPMDUfFeN9ED7XrjVzGgIFxxoX6gLUR+MNKZVxNSKgMFoa16YGaQCQ2DCSEZxtsZsT94iVrZDJnWrqgO3vEYg7mvWGUpEX5x940u7kaX35OtbSr2XQPEbKT7iHF7wOWvQVJcZnj/uC2KAxAuVIUQr/iGJ78XNIHeJBrGuMwt2NShVXomCm/YdbhFuRJfd+XZaOzahgCSROuIoC5af2oo+vHRPdEOCayiLZFKr0VfYlBlWW9sTe10YarLvFm3QSRBy9LGmul9oRGCxXENu6fpbQb9vWYIZZZCivO05Pkuf+bC7Gs5R0oNR8B5H5yRQH1ytJmPKkNLCTBTaKQGksjTrxJ5a3vA9ggZQPjmLLC9O+cx6WWc3lRYEhNQTeUWJvYh0rWEzi5QyitNFF9iC3trfomAdiTLHIwm/cNmh4EUvaAi6fvIUh5C8y4wohe+Ds6S4KMx73WKdRdksx1bxfPsYi1pDSlDTekgYpvi/Lf9a7hRe91YWrW2jlCfUvxU7jqt9D4x9Ql2la3FbKIKs+9YegdzW08TGX3ShxcNAJAAOfv04aQvTsqFZJnavOvWIH/Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(6486002)(54906003)(66476007)(66556008)(4326008)(478600001)(82960400001)(41300700001)(8936002)(8676002)(38100700002)(316002)(5660300002)(66946007)(2616005)(186003)(83380400001)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFpVUVvNGEweTJ3VW5NWDVsdEJ2U3JhYitEM1kyV0tXNHBTMktwSERDcnQw?=
 =?utf-8?B?Q2NsWlJyQTFnRzhPUmtZOStUS2p0a24rZ0s2bnYzbXdvd216WU85ZlpOY3VY?=
 =?utf-8?B?ZFBldkpYRDFIMVo2TTM2Ympsd3dBaXl2RDdvWktSUzdEWG92Z0t5TytTMk54?=
 =?utf-8?B?NzNDaTJvWHFyaU5vd1BXT0FydHNuUU5PRUVXZ1lwTzlHdG9sMGhwczB1RVlC?=
 =?utf-8?B?QzRnSEFpSDR1aEc4cTJ3cEFaRk5LSUZGcFdvZUpCVkVWQzJ0dW44OWtzVDk0?=
 =?utf-8?B?RXNSbVdKZUFKK3gyRHIyazNPck4yUUQxRWNBNlQyZG9JNC9UeTZWTXc4WjhN?=
 =?utf-8?B?dldCSEwvQk9hTVJnRlpOaVlIclExVHV6NlRLWmk2a00rTFVTblhJeGRoaXhy?=
 =?utf-8?B?OXhUQjhvOXNIMXBYSlN5NHRENjE0dXVoeHpOTEZWbERoc1E4cEtwcThQM29t?=
 =?utf-8?B?eUlKNTE5WGpmM0hLRGdLV1BaaWc0UGNJdGYydEtob2JpUC9aemlGck5RSjdn?=
 =?utf-8?B?ZmtGTHltSVBtVDF5aHFZR1VxRVRvOHJLWG8zTUFVenBpMEkyUDA2QlQ3ZGFE?=
 =?utf-8?B?WEdzYXBGWXVkcUVZK3cxK2YxamR5aS9zSWE5dlZFN3VzaUZhNDRJZ1NVUU9o?=
 =?utf-8?B?RDYyL3FsdjBhTkViK3g4MXQ2SEdQdnJRY3V1RE52dmIwenJLUlRRaXhrNlBC?=
 =?utf-8?B?azhzSW4reGlZTmhvZDN3azdzTmxrMGFzZnJ0V1dmd0s0SE5MTmRhZSsrTkxo?=
 =?utf-8?B?Rm5KajIxWW1OTXJpR3RSUEt6cXUwWng5SzdQbXovOE5DRGhOUC9WVlBjcWwr?=
 =?utf-8?B?L3pMU25yVXR6OUpTdVRzclgzWFBpTHFrd1R3RHZRMk4yc2Jrb1pCR09HazV0?=
 =?utf-8?B?cmljMngwbDBFaGZmLzBpVllNdGMxK3RIQm1Qcm5mWEUrVnJHcldnMjhwOXhU?=
 =?utf-8?B?UVFxZGxmM1J5S1RLRi9mVDE4UVh6SHhMSVJUR1lsQ2NFMEVDRzRuRFdaTlND?=
 =?utf-8?B?QlFMdmVVZjJ2NHZvb1BWOGtrRzdoQXBrUWs3dytkTVE1K1pCSmN5NGdQTnFr?=
 =?utf-8?B?dHJIUEg5MFJFdWFxK2dwcDhrclBpV096UlpZQWRSU044bE1aeTFiMklwdVFY?=
 =?utf-8?B?VmMyaC9YbWpkd0pWRkh3ZldzQ0twZlJUM3ZjT0NmWG80NzM2MjJGUTVibzdM?=
 =?utf-8?B?U1BvdGhkVTN2a1ZLTDZoK3hscVplNHNzbDhTbXE5Z2lxd3k3aGp4NG44NU5D?=
 =?utf-8?B?M0didWZzNUNZR2x6Vmx3RE5lY2h0YzlZdmZPNVpxa1pSQmhpcEVEbGtScmlm?=
 =?utf-8?B?cG4rRE94Q2Y2bVloNjU5Ly90WGg3NUEwdjdyUHlBejRlQUJlcmxvVmF0Vldl?=
 =?utf-8?B?bmhFdm9KZmtOb2lUVUEyYlFWU1cxbnBiL05RbitGUUVYcWM0Z0VjNGhYY0Y2?=
 =?utf-8?B?SUJsWUVqSWo2ckRLa1I1UEdRenF5K3pkbGJMbXJDZW5VWFdpa3ppVWdnS2Qz?=
 =?utf-8?B?RSs5VWlkNGJHNmdWMVZ1cWlwdjA0S25EaUQwcENPZkJRY3EycE9DMlVFdzhz?=
 =?utf-8?B?b25RcjlTUmFHeWJaT3RoMmxZcXFWb3Nib0lidmFuOXVWVi9JU3VVbFgzcHZV?=
 =?utf-8?B?YzdJTy83dHVRaGliK1pzWENSMXcxcVp2VkM2Ynd2VVl1TmZEOExvcUE1M3l4?=
 =?utf-8?B?eEpsZEFNeUQ1V3hoN2lDOWpTQlV1V3d4ZlJSSzZrQkU0RjdkL2tYdWVYdXB4?=
 =?utf-8?B?eHBRVis5K1RNSWtYeXNac0ZDaVQ3VENjcUFHc0pnaHUrbXlubjEyYXZUYmxy?=
 =?utf-8?B?MWdqYTBJYlY3UU9YYzZhenV6UU41ckpBMFpxWFBxekVTMk5LdDNjVHNDOHJr?=
 =?utf-8?B?dGp5ODlaZE9qY1liQVg3RGp4cU1Ca21QNjZhdEJjQ01NVUliWG1GWHlaTU9Y?=
 =?utf-8?B?RkpqcXFRNlJGTHplMmxDYVBJdWxrRm9tQkhEY2IyZ2k1b2FGNTJCYUhLc0VZ?=
 =?utf-8?B?Wi8vMVlWNkJlOWZrWnptRC9ScjdyNitpN1g0M2Rjcm4rdU1Nc3Nvdk1Hejhz?=
 =?utf-8?B?MW1HOWF3d1NDbWN1OTk5TUFMOElqd1ZUeitwV0xoSDh3bVB4dTROMnErODhx?=
 =?utf-8?B?dG43ZGhackZIRXhTNUlKTlM1bElENzhITk1vRDE1RUcrUmJaMW5IWHlDbUV4?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c5a615-1733-4427-3c79-08db4758f436
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:52:38.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7pyXfD9h7bGvICabaRMb9edlgoK8+zD+NH1BC7bdu2qMDz1euPsgWThzomlRx7Esp2xQDMvJBib9brmINkVt2Sii1j/AMco643Wd5h3oLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/2023 4:13 AM, Patrick Steinhardt wrote:
> A notable ommission here is that the output format does not include the
> remote from which a reference was fetched, which might be important
> information especially in the context of multi-remote fetches. But as
> such a format would require us to print the remote for every single
> reference update due to parallelizable fetches it feels wasteful for the
> most likely usecase, which is when fetching from a single remote. If
> usecases come up for this in the future though it is easy enough to add
> a new "porcelain-v2" format that adds this information.

Thanks for clarifying this. I think generally its ok to leave out since
you can often infer what remote a ref came from (either because of
refs/remotes, or because of how you configured your refspecs for fetching).

We do have the option to extend this in the future if needed, so I think
that's ok. In that case if we wanted an even more verbose output I'd
probably argue for something more structured like adding it as part of a
JSON output.

Thanks,
Jake
