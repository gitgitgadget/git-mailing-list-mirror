Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F64DC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjDXTgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDXTgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 15:36:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68992E55
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682364983; x=1713900983;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lyEiHm/dli39AUzR6JcXuamaNrFo/7PdY7ZYKWOpO6o=;
  b=GeWzYM98vMVOIN917BQCQ1c2td44XoDkeOV30wiR4CwR8NTb9xPJ/bxT
   +fjglrGZUVJConQ5y7VCbbyv+8vtOcqFwMXat5792gOBKHGSK7nvoO6Ni
   iByv2yeSIY5evmIGfo7R+xzbCm9bqkWOXMXAQcXtsjNnqRDg1Gs0mmFEX
   usykBpwRDpmPzy0rzQt/aQUc8mEMEMqYsS1L7PhVZDn/HHZqhzdz1vyUs
   Vl+tNX/beqNuAF3gOb+eZ6cnyPi0GuFPyTOvokjYalJZ4v3cXuOVxw4NZ
   nwnQ32F03apxw3LITAyCwrJ6pbU4/MdTeOzaMJ5JLumVwF2ApdAfJP14n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="411825053"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="411825053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="757830379"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="757830379"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 24 Apr 2023 12:36:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 12:36:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 12:36:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 12:36:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 12:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETQAh8Pq2cNQq+IMlAimL6R5lss5FvJdBGXo8XMomuUtXnmAKcEYjar4LF9rHrNDUHAR1k534iXzGBtlRisP3NSmXZe6s4h2N/71hF75ZFdPiETV3DL+U0Wp1kq1MsPcKFTdgl8669qEKSRkFEkIqJA6VFPjvTHMmsWOIkNY3SJXAmHepUOQkLc6Zg40pilviySX1zVZq/Vk/l5ukmgn/RRY9diWrYXVh+X2tTRkPhqHKooc5ejuKI4igK4hJB2b0SP6u0s1ioGcW8Qi8DUtlmGBRqX7y2tqEQrRLnMVjGonPsrjXzw28CD4VvnEJDLxI/X94xWGhpUq/gJc1CAlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DOShztfxPrhg82ssxavvvc9pVWyaXLh7vDHRDEOGtk=;
 b=h0qElJD7k1KWL6Xv+yVUyT5eQ9574PB4Ux3gePH0/Q5Qw1ZyBjlPuydLDBUqF5w/B32UOI6b6xp/DNSZAigHXlQgurrsL7/pz0wSj8qctkTrvCi81K3BkVI91flIJj6REsagQPF4xnhQ5wM7+0wmYvu/AKaqbugcVAmRcqOEEYDwNEzV1KvCZcTjM6u95MDuAyFjJivPqAU/hfK12mEnNFI3ZAqogt3Pq9r7hf1CZ1z8pr7dLxzwddgNmc4av9hiNMt+c7ThCXLt9HzoeiIdTNYkA3AlWTPiDdD+Bch8yp5qgKi3i8ymJYi0C+teiT+rQjc/noe0xksm4kHcfRDX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 19:36:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 19:36:18 +0000
Message-ID: <c4a99e9c-46c5-31fe-5004-2d741a5bc8a0@intel.com>
Date:   Mon, 24 Apr 2023 12:36:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blame: use different author name for fake commit
 generated by --contents
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Glen Choo <chooglen@google.com>
References: <20230424193508.2245566-1-jacob.e.keller@intel.com>
In-Reply-To: <20230424193508.2245566-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: a36e4c97-bfbd-4921-a183-08db44fb2ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBO+t8Gnxx1VyUKnS73wp6Tkcgm33UA5tOP/2B77U5NvzELi1zVhzHEidrLwUetTvSEuoHCWysXpxfBbIErHu87dCw9kV8XIl3MgcsYHJATY0rxjKjJ6YQui2BxwUG/QtV/Iqd8roE0tMakbmyt0lS6Q4Ddfm0sM7JSfV04bBW/TRuecaxQpDhadPJvnElIQFaDuKE31QU1DmnBbCFohGoKzms+IaPM3WxJqs5AVjfnfpAubsToqfLjCiD4clXBT0/YlUku5nxypxtQII4xramp2tMjUPJZ5FLKpawozLS0Xj99Zhsj78N5nV2QRZppj0Aid1xcY6yNEdtIEExXB6jdvd2EEF9mTjRW3MvYFEjAvhNVP0HTV+2oliN+BvGQBXJctyG7xY+e8dK6eVmitjf1fV0EbD20yidpxHghFTftMpUU/7jJCsWQWqBN4cRRvOKCWRrtpAYlcRzzV1VKcgBV340MnxTubc6Wi8lga09Sjum93d757plMMsrQUe/UfYlzBYz58ESQekK7Uv6m5dtEptLrl/YJgfynhrtXKFifSkbFF30XWIdC34RR62vqUCJwOI6z1A3gmpuBmG7iqiHYbhW8/AHpdDwBkohi4++klxhSZnwgriElRkpxs8Rm6ugaEmMg3lSV5a4+jVRJrXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8676002)(8936002)(5660300002)(41300700001)(558084003)(36756003)(31696002)(86362001)(6512007)(26005)(186003)(53546011)(38100700002)(478600001)(6486002)(31686004)(2616005)(6506007)(82960400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckphSXFOUGQzQVlmN0xsR2FnS0xuU2F5YXk3RHhaTHpMeXFQZ3hvZzdYVDd0?=
 =?utf-8?B?UGpJT0tDZXdBSXBINUZrN2h4bnY0aXFKZ0E5RHB4NHRpMVQvVkR2ODBwUVdy?=
 =?utf-8?B?VEFicmRwVFN0T2I4Q1ppZTVzdVV6bEVXQS9idGxVQUx6RWNybkFZVFc0N1lT?=
 =?utf-8?B?WTI4Z00wM0w2VHhNWkpJUlhTNDhWMmhOS21WRzBvL1pKbDdqSkNFVVN2NTZt?=
 =?utf-8?B?ZUVBMmIyRVp4T1RLM3A4UzdYT2pNOTd3U1Z3QmhwODd2VFhTWURIZ2ExK1Rv?=
 =?utf-8?B?SWVpaGE4T3A2VHE4U2VSOUU5U3J3VHFTanJWTWJMKzJVWC9hcEFMZW0xMW03?=
 =?utf-8?B?dk5KRzNjWnJCK2pPTFpEcUNNSTNaVENtSUR0TzVndnMzTkZaN1ZqRnJlWWJm?=
 =?utf-8?B?NXltSGFLNDhKakIvUnQwNkpSZm5sZFZlVForRURDS2RTNjQwNzQ5NTFvd1BE?=
 =?utf-8?B?dkpnTENValhycnNRaE5Kam9oTFZHNVYvU2puYWJXcVprdGVCc0lWcWpZMkZk?=
 =?utf-8?B?MzFLMy9Zdy9qY0lWall0Z24yNDNTVkE2Q3JuQ0VHallvalg0QUxnTTRDOHRw?=
 =?utf-8?B?dzc5ME5BKzJJTHFVM2VaWXpXWnduamN1aktYYmVySkdCeC9MOUtIak9BdjBv?=
 =?utf-8?B?b0JHN0hoSFdmK1hEN0tOV0FjY3d3SnpVUXVaZlozckgrMjBKUCt1dlNDd0pt?=
 =?utf-8?B?akdNTFNQcjdJYzhGRmtjRS9JaEJmWmZiYnRxaTFCZ29rSXZDd015R2NzS1Jo?=
 =?utf-8?B?ekhyQ1dIT3ovRFpIY0UzVSt6d1NmdzRtcXo5eXg1c1Qrdjc3QTBiM1k0WVhq?=
 =?utf-8?B?MUFxam8vWWpGMlJIREpRSTVWZjloZFRaUVF1RDc5V2JnUGMxUzhrRFBzR2Fw?=
 =?utf-8?B?ekc3cXhwTHFTeThJb1VQV1UyaHJ4T3Y5eG95dy83eGpHTUF5UzhpdXM2azBU?=
 =?utf-8?B?MWlvK3ZzdmJxTW05SUdRcDVRc0xoWFduTlQ1Qkh1VXRFSFhYa2NpaEJRMmtI?=
 =?utf-8?B?U3Y3SDhwYVV0S09LK3VlSGlTcHV1UVJ1S3hsR0NkZmxCRmtmQkpjdlJGYlMx?=
 =?utf-8?B?ajdmdWh6NDFGTG9JckRTTUZnUVBaYTJuQk8vNDZmcWtwVXpvMzJpbnh5UHpS?=
 =?utf-8?B?NE5xTkpRTWJNTC9wRTFxeUFPVWpBd29SU3kwOFdKMU1uWDFRTWx1N05iSWxr?=
 =?utf-8?B?dTYxUEY1Z0E3U3QzcnFqbGNRRFUxcUtCTkt2V0tpR28wVUVoeVpZZUNNRGhE?=
 =?utf-8?B?UHBGL0dtT1YwU0VVcE5YZEJsa1REYVFyZTkzN1JEMXRmZVk1bC9pSkIrdlo5?=
 =?utf-8?B?RVV5QkRtbmVOOHJYazZGdHVLSDEvY3NQQmgyY2RBUTJ6cjVrWjc5V3J6eXhC?=
 =?utf-8?B?K0FJcFpLZzFmWnhrbWp1R0laMkh3UE1idnpMNkpuV0pzclpDd0VsVDh1Vmhr?=
 =?utf-8?B?RjNkUjVrVDhUc0hBbVRmWm5MZm5iTno4MFNCbW9hRUMxbUhXbGlwT0UvQ09J?=
 =?utf-8?B?SlYwRk9OS0hJZ2RiN0s0eFBWQmZJaERDOWUyL0hsZXBYMUZmd3FkcldhU3g1?=
 =?utf-8?B?TlJWSG1ucDBoWmt3dXpRREpsREVVQmlVQzJ4RXBMWnZPY21pZDRQaFh1NnBF?=
 =?utf-8?B?YkQ2U21oQ0FLNWNpQW5oNUFQRzRuTzQxVEF1b1NzLzQya1BHSWV4Wkhha2lj?=
 =?utf-8?B?SUoxeVlmcTZZbnp2MGN0ZzE2MlNtZE8zeTdaWS96cUsyVGd5V0NHVlU1bDJj?=
 =?utf-8?B?WjA0enlJTzVuU0hpL3Q4R3lLY21JaEJrNmdoRk50OHZVSXYyTVBibFdaRlVM?=
 =?utf-8?B?UzBUeHlyeGlwUi9pejNpZFNid3ppam4rSGpueEZPY3c4ejBRU3JVTkREaXNC?=
 =?utf-8?B?UXcvRWNSZ0h6WUh6UDhlNnhqYzdxYnBwQVU3K2FCNmZTUlp2UnRCRkU3N1d2?=
 =?utf-8?B?V1ZtS0hkeWlLdlV4Yzl1NTBjdDNja282VmtsajhvWm14SDZ0eERhMkhjZ1lI?=
 =?utf-8?B?anhZYmowNWVyamlZMkg1TUIya2V5Umh0VFJVczlvd0pIbVdlNEZrb0pRb2VG?=
 =?utf-8?B?SndTN0FrMlhMTEQydnU0M2dTbGdobXZ1QTFYaFRreDZxam1tbnE2TGVrZDNT?=
 =?utf-8?B?QWx0aDRXTEhORDdMMFN4cDRGRkswSEhFRmJ2NFNxZEpReHFObTJYbDlrS2ZW?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a36e4c97-bfbd-4921-a183-08db44fb2ca2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:36:18.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIpa3Pb+8NAfaP+rc3byz+oeEfHu+RAo0YNEwcN7GEquJOO5VPC070jhubknRgpqXRI0MPlx7APvxYOkTKsL1zpzp0ONduJy4MMDSZk8VLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2023 12:35 PM, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 

Apologies but I forgot to add -v2 when formatting this patch, so the
subject really should be [PATCH v2].

Thanks,
Jake
