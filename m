Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D1C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjDZTWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjDZTWV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:22:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE11FD0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682536905; x=1714072905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BNapjN6UWcOhKBbvUjErS8U9H46qyiWXI9uMXWeYar0=;
  b=HH1GlkibY69mx8R5rcOvDwVma64/m8MKtMdxAnHv8Piu1d8cKWWATgPN
   hZRzblL93avf53Rkt5qRdbV06ohTCbWPFIpAQszgBJvzaJCQZGyjnV3sq
   3RHuveU1eovECsyWlLURo+CeT4d9TxL7adAL+fHaB9Z51ciJy9ykZBUYc
   ePc+40gilqe72PTzt2R7Xe8YudqwhQVi2/hmZ5PvpnRutoUSb4VZomZDe
   G8Qj0YJ8sXqoda9Qij2O39HIgFX6Xjwg3VAfFJNzUDXsrhwGYdGCFP5bj
   evMTrLviyLkzyxEZV3Iuxugq3d9v5/RWhXFVAUYLuFIa9aj9ajNQn918j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="347235730"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="347235730"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="763460819"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="763460819"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 26 Apr 2023 12:21:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:21:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:21:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 12:21:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 12:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZBmZBdpL7G793jvrp7n39AAJixHz7i0YYvzO+MZdE1tnepp7+Qq7HikqRiU+hKzOphKq77/0uDde4Y+YXq9xnKePlvXcfk/7oIMv6rCGqjVOcm+2sUDD2VL7iLQoWPNRjLnG7N+HlXqYSuxXsoTYoVALou6b/UmGlTEZoRKcbNfevTAOWrgEbCun5HJsuQEkxcmHuKXhJZv9yCEQ7AEHmb/NnPzpjOoj9HeYqtwtCHf0rVlZkV5VmUF7GeMysBmH82QshdsLKc56dxsQHdOMqqQReigZqJFHH7fud5ynnpUOoUQXuXoEg/5rRlVYOhPFA+BARMJHvpYHk8qfjQLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+j2Uu/nP6lRo4+3i1oVGSk6aBbqu27YXRQZja9rxNs=;
 b=ASYXgg1llmAZSe/pOciacbhaCDFVfzvp1Ya5mOYtg9I4VBSxjkWBAzmxglmD7G1axYlLCDXrxQL3n3vviNR3XHxKYOhKxzos2pa24Sf3F7Mef13LCZNG4HcKrK2pzjSjWWLZU0Nsto0kqvJgTiB/Kpx2aSDgEnZHvetmBrbHW6jK4itlBY81RwpGq3X6SeT82/QCadQlUYX5YOStzw288GUJmL/zGDkANnvt2H9TOVOaJCqDP7Bjf/P/N8LOgYHpbyoiFZfIij3/KSOxHb6Q+eCYb8DPH2MplAXNiS13lVVXAcabT4VOPWy1cWT01+ocHMviGYiLsGiwqH8z9WBqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:21:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:21:41 +0000
Message-ID: <36931566-1258-c5de-2efb-63541a2ce96c@intel.com>
Date:   Wed, 26 Apr 2023 12:21:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
CC:     Jonathan Tan <jonathantanmy@google.com>
References: <cover.1681906948.git.ps@pks.im>
 <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dc23ee-b33f-4f67-8242-08db468b76d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9R9+v6ufoh+JAfWpGvGFaIN0lZHGB7xxtmL8lY3G6jy0v97nBLkYWo85KJdMm+oG02iDc2lZkUh8XvI/7UZddDuK3CpUaUDcZyRVWjO2c4eyLEy3IQb5rAWe69sIRj1K2BktUBP23p4sfZp8ceO9+eJP1InEJHYbIZPOp0YClMm7PR+FtkBtpH412sGxr+g8XCV0yIlbkEkB20tOMb31p+VX1YA3TrtECijQssLJWTxw9BLVGMw3DFcRLLRDg3+5Tbiywo1ophA/cGgBj+xsVMY4in7RetlOikGCq5C7jlSoQaRzw44X0sq/I6VSWoc8dh7KLmY2IwMZATgGRvC214UN3XrCF5ZxEN5s6bSSCW6GnREhi5Jpl/m2Zbu3U6y5fr96Ph8ErME6arKftQ9S3i2wVn4RubX/By2/prCqJULNJyusEpjobdK8o85mzDtAzJu7D7/VQQApkG+/ZwgGb5mDQBNNF/JMv6WseIiQi37Dk4HFnCyIwOUQLBlI6ezjHMswMe3g8Qvh7DORKHvpLnDsozoiaTjs6aKF32xd0QDtM5t6Lai/DlBSbGeU1Q7Oyel0O0bWlIfWf0XP/wJwvZ/1gpuPKp2HfshGW2CrWVKAhD29kSbGIbVxRaez1/YPB82TDAad60K2+DLN8LctQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(2616005)(26005)(6512007)(53546011)(6506007)(5660300002)(82960400001)(8936002)(8676002)(31686004)(2906002)(4744005)(38100700002)(4326008)(316002)(66556008)(66946007)(66476007)(31696002)(36756003)(478600001)(86362001)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGRNQWd2RkZLMHBpWWJQMy9oSitoTytlNmJIVmZSQXpoNmd4ZUVCQm1UWUw4?=
 =?utf-8?B?cXBIUVFnbXJOWWFxZytwUlIza3cvdVIyQmZ5akNkVUUwL1dLdmRDSzgweFlk?=
 =?utf-8?B?MEkxdFlDVktSUi9QcjJta0gyZFh6djlWNWtlSzdmMERweDZFMkVLS1hKU2NZ?=
 =?utf-8?B?WGZMejR0SEVxaXdkOEtVaHpONWpQWFFSOU5Ya3c5V0xkL3VUTUlQTWdaSTZu?=
 =?utf-8?B?Vm5GT0IzMFIyblhBN09uMG9oQnZRTG9rczJwK3NMbDBaQjVWd0NuQ3Q3UC9S?=
 =?utf-8?B?TFhJdTNscHFJNWlGRUsyUkE5RkREa2hrTnNiK3dVQ21ONDlEdHQvRDBOK29m?=
 =?utf-8?B?UlluUVZGZjkxRDJ5dmViVkhINXg5ZnRFSmM5TTdmT2dPSXRjWkVRSjdvbktV?=
 =?utf-8?B?SEp6Z3VkazBqdDEyRGlsTlZ5b3pXV3BPVFE4OVBMVlJPSmhXQ0V4Rkx3R3dy?=
 =?utf-8?B?SnlCRkZ2MU1CaTEyd3ZFa1lsVDBkRStSN1prejRoQkxMOWNyVmxab0g5cGRk?=
 =?utf-8?B?WUhuOTFWekt3dTNjQkFINE9FOHBpVXpIRFMwenpYL1krejRGWjJqSnZOQkNv?=
 =?utf-8?B?WmJoOUdEd0pUbTBtaUZyT1c5aFpRNEhDcElZMFhIVHRLd1ZWVnJkTTE5RE5y?=
 =?utf-8?B?NGI2NThDY0RhbEZJdzdDME5XL0JqQllrMTA4bGJKeEsxOTJIL3VFd2ViRHNF?=
 =?utf-8?B?MitIM1FRM0hXeTNOZmNnUE13UVFVb0lDYXZQWFZzZFY3dGU3Q1VCOXhONVh0?=
 =?utf-8?B?QTF3VlJlZmZuRkVKbmlvbGRFdjlWQ2cydFh3UEM3RzAvYlorZDlsWWlvUVE3?=
 =?utf-8?B?aHhTSk5GUmc2WFpPdFdsUU95K21XUW8wRVJFRzIyQ0lDOHRTTkM1K0YrMFl6?=
 =?utf-8?B?YkxQcGRxU0didHJ2UkZVdEVrUnlORkw0YlRNV05RUlFQT2FFaWZCT0FPcVU3?=
 =?utf-8?B?b2ZTODkxdEpDOEVhM3FZWGIydkFmamo3QzFWcVhlMlRxWEFIdUx2VDY0N0k3?=
 =?utf-8?B?QnRJZ0ovRmhycFhyYWlQWGRCekRBTlFycDM1SXhVWUh5Z1JBcHFNayt5ajR1?=
 =?utf-8?B?VkFoUU04VlZ4VWRmY1FKZ3dwOU1RUG1Idi95bTd1V1h1SmlXSlZHWk81b09j?=
 =?utf-8?B?Q1hXSHFsc08rdDJNcnJ5SU4wUG5JcVVjTG5PMHd5T2ZXYnNtYWFoVVNqUGVQ?=
 =?utf-8?B?bENZWU9DNXNTWFNWazVsUlkzT3VJRG9Lc2lPblFnbGdzdVUxS2IrSTR6TEp5?=
 =?utf-8?B?SlFBQy9DVG5VcnZiNVpYVkt3TGxFN1VaNzZwL1BxSDU5TCtiNUp6UzJKckE3?=
 =?utf-8?B?SEhEOFc3WWtoeGhkTU9pWTNLWXdPZG1pandkY2ZUQWpUbk5ndWRsZUxMYlY2?=
 =?utf-8?B?MERsSWFZRTZHUmpoUnpGSWQ0OHFVMWV0a2xaQ0xwcm9TUE50QkZ3dEE5Y1hw?=
 =?utf-8?B?cGY5Z21xT2xVbGRFaUs2eTh4Z2U3Q2swbS9mVnJPcUNzREcrYmUwcmw1dTdN?=
 =?utf-8?B?QWNOU1lvRzA5ZG9WMFlCT3JkYm5abjg2L0wza0hNZFNyZ0s1ZzJrdis3cVZ2?=
 =?utf-8?B?aklzdTRMV2ZWZlg0cERoRkF6YmYyMml0b0JKWDhoZlhVMFJ6RitQSVlvVkVy?=
 =?utf-8?B?NFVjeUVjdmhFMmpBeTFlN0s3QmQ4QnFWUkpRSHlBaHl1MTFYajdoNTUySm54?=
 =?utf-8?B?aUMwL2tIL2o0WW5tL1RhdXlnYVRtNFByUzYzbDBqWmtMOUt2UHVKNHNWRkNV?=
 =?utf-8?B?bmRadWY5b042dkE5cm4rV2crUGdWN0ZWQ016aUhmaEpzWXd2NHJoVHErcDZ0?=
 =?utf-8?B?K3JQUWV4ay9MVTR5eERVaFhsVG0yUEtqeW5CQjhMNlJWWkxrOW5NVE01Wjdn?=
 =?utf-8?B?SFREMkphaXZsZWZvTVRrcGQ0VllNSVVaVFVOdGhIWWw0SVA0NEkvTHduUmZD?=
 =?utf-8?B?cGNSdk1ld1NTbEs3b3pMUjFZdU5RTytxZmc2MFRBV2xRWHE5SXpkVTlHbnB4?=
 =?utf-8?B?MW5xVmZ2QzI2bFc4NWUzNTYvQjR4OU92Y1hkeno3OUxPTVVkQ3h1ZU5KK0dx?=
 =?utf-8?B?SFBrUzFMU0JLbmZCdlNCVjdnekFuejE4U3MwSmxKOFZwNTFPL21BaWJCb2Ev?=
 =?utf-8?B?eFRqU1dqQ3pzRnU3clZFNFF0QzcxUGpCbndxb0RUTzhUUDlLbVNMUUQzNDh4?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dc23ee-b33f-4f67-8242-08db468b76d2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:21:41.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC+AW9sxMv5vJNSIZAgs0mpXFaAevb2Asj6tRFU2Qx9k385+jN/ypK0szcFJb4ynVwBqV1AD8hkmgWtl4oLdozk9SvNWqTdAh/5WuWFPVYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/19/2023 5:31 AM, Patrick Steinhardt wrote:
>  
> +test_expect_success 'fetch output with HEAD and --dry-run' '
> +	test_when_finished "rm -rf head" &&
> +	git clone . head &&
> +
> +	git -C head fetch --dry-run origin HEAD >actual 2>&1 &&
> +	cat >expect <<-EOF &&
> +	From $(test-tool path-utils real_path .)/.
> +	 * branch            HEAD       -> FETCH_HEAD
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git -C head fetch --dry-run origin HEAD:foo >actual 2>&1 &&
> +	cat >expect <<-EOF &&
> +	From $(test-tool path-utils real_path .)/.
> +	 * [new ref]         HEAD       -> foo
> +	EOF
> +	test_cmp expect actual
> +'
> +

The test mentions HEAD and --dry-run, but the bug seems to exist
regardless of whether --dry-run is used. I understand the use of
--dry-run for testing fetch output so that you can repeatably run git
fetch and get the same results.

The tests here should probably also have a test that covers fetch
without --dry-run though.

Thanks,
Jake
