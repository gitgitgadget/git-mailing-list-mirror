Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253AAC77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjDZTRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZTRW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:17:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD42FF
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682536641; x=1714072641;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jf5HAKJYTTBLb3xgwyK4CxmUJZgZY/3KV2ghpExsJrc=;
  b=SAtKZxsuAqeyY+C8eUhZAKNe1+A+4AL75KGGZUSd6/XSWuxdaS5bRO5I
   8Q5RqvjAOzkRfUnhVkSex9+bMlcVIfTNJCyracmzDw5dMAv0kdZUyq5l+
   aYk9CJGnIlCaqQ6ecwZh7C75xhWZVL7yGUvlnf3Dlcrt8eZl65D4eEqAp
   LH06ldIEHaShMR+5+R90IpsMmy6jqw56uUF3IlNtErCwsgsU0pE4MgM3d
   FuutCPCrTJQXWhzT/nmhF5WUYyGBx8jmz00qRRo+6PBWSmI2Au3LqlUqt
   eottWKjA//C/xvRsYzT49tW9fqN0WSl5si3b4KuXRw/WrTXRZsaAeeMSo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="410227821"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="410227821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="805640534"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="805640534"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2023 12:17:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:17:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:17:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 12:17:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 12:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjgWB26sjDcTc2RX2Vba9ZXQdSDBlnUQcNKntQV90iNqERoWpbgKpB5p+DmIkFCd65t8Zq1QEEOwaiAJwEKi0P15sghUNdPHNO30TmTMNJ03x734Gc+cfmS0X+AR5B7fDH4LLm8ZU4rjLsi8xBz48vQ6BBvLHXNgmQYVpnKvvUm1uhCLLC5eRzbalEDr962klH02MKRvOwAXKBSG4KOUA4RfUDd/p6UGtNb0lYfwCKtibVoC3oN64aImAHS22E/vDhlYPAjQYIuzBcbr27womakXURZISwAsTnvVnAeSYgnW8Bj0lUl37+fl3UoaIDh+PaocQbfDMyHDlQIxV7T1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNr//Dk9HWLTmh3m3mEYz/5Tei3Aq5bOw5mpUJsMHNI=;
 b=ftdk+7H42a8tt8lS9H/5sv3L2yH+vjKYeMyQ2c/Wnp8BctFQWzm3iCCuZKYsK4aMro253tT366bwAVVBySvopGARC2rdUa1zFyxjBQzhZqRZ3pVoU06MoXentBxoaka7qFMVRTG/wCY4L5b3YMI5D4FFE4NFn0uVw4qONLY4mAlFxOn3CH5SrAZDupr5Dzry/wXYMe6Tr6VLX5hzdPoDV0OgUlSlCAc/AM0jGx5WbNTb0KF93lfkMn37CFU+hp9sikWUleE14K7RZUznwbqhVFJdEEaT0BjuA2SoI6XZmgwNGle/l0nWupfNQzlX2s5s3WCMr4iC2YqVy4njlf+Z1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:17:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:17:17 +0000
Message-ID: <298a1063-d4e3-6cd8-cbde-cfce9e70df86@intel.com>
Date:   Wed, 26 Apr 2023 12:17:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
CC:     Jonathan Tan <jonathantanmy@google.com>
References: <cover.1681906948.git.ps@pks.im>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a04eaa-a70c-49ec-5d3d-08db468ad9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHcGE5V4YrBspuzbi2H3SMPSNloJHmRb30zSoXE1BKNWsnAUquFgqbTkPKHbydhRNIooH5+3U1CoSAPKu1imAy90RT3YnuwLhetLDHs3QnQbZug12d1Sndj5LZIe+xQNLsh8DMj2evEjH0urEmmLJMMioR22gzFYKPqUKKV8gHgZHam1QAY1X0eUWmXNDW5BgLAiuAltX2WG31+KP/nCNaoK1TIuAQHp6yvumBrjV8A0DbDB0kf0hMf+VS7D8AGGxJzDyAW4wXnN1vhvj/tZnZcOlbTUNm6oPeAQPopChHI8w7aScm6n5FB8d4Sx53jaxEZAYyU7/qr1zPF2FxgBprr/+cKRxgmui58tSZYwhabqj15uJcLb+7etfXWwDonb9Aw42+IAyzuG+HM1iR/dPiJyh30xH7g0DT9xyM3Tai2wkIXd5HKfyrJi0QMokNS23g5/09SI701LxtuoeAqw8yEDGroUb1JjwsrDVdgUx7/i6gvWh1+eTl7qC4+Z29UBeWoPBPrMpG71qHIgawI4n6jkdVcnVOu7P0z+X+kxz+t4SNcWH+ZQT7z06iF4wwUVlIKDbakQwEFj4XE9dEtEUz/UPSPVU+nG+NU87Q8PCNILfWDzvCd8N2bW3j/ZJ/W+ELm1d8/GZTEayDH2ushfCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(2616005)(26005)(6512007)(53546011)(6506007)(5660300002)(82960400001)(8936002)(8676002)(31686004)(83380400001)(2906002)(38100700002)(4326008)(316002)(66556008)(66946007)(66476007)(31696002)(36756003)(478600001)(86362001)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lGQXAzY29FS3B0TDk1U0pOd1FVYXMrVFVtcUFMZWpmeVAwQzJSdk5FQlkr?=
 =?utf-8?B?a3N0V25XdklLM25VYjZPSi9KUExla0huWStrVStLSmJ4U0UxUlhSSUJzUVh0?=
 =?utf-8?B?eW44YWJ1bWh1YlczZkZSYVJsMHY2dUdGSmdBdVNNTnVyTmgvd0RPRlRxYTYr?=
 =?utf-8?B?SjR5WGVlUG5UUE5mNjNSYzJQSWZTZkhlSUx6TjRSMUZzMkN0b0xNT0JVMlNz?=
 =?utf-8?B?SWkxMEU5NXdqRVBEbFVYcEtmLytLWGhPTXV0S0ZEdGtwNXV1YlZ4OHFoemFs?=
 =?utf-8?B?bHc1MlVVNUw3UHdIWnZpaG5zdmYrVndJVXF2OENyajJYZWI4RkkyREhpdlI1?=
 =?utf-8?B?REh1ZWdDNEZ0cVEvUXZFbHdxNDJ3Z3c5YVZ3cFZjTWFUNGNuWlhQa0lmaW1h?=
 =?utf-8?B?MWZVZVNXQVFTbUJhdmlOWlFKbEZFOEFMSnJhU0dTMkY2YkRyc0dsanBCQ2Y2?=
 =?utf-8?B?Y3Yza1dwNlN2VTFlMXg5Wk8rUEp6eUNyOC9aSlhvQ0U3eFdmdmdkNndoQkRv?=
 =?utf-8?B?WC85YmhmcERhWkNxaXU0MWNGYzJGc3VSWS9XZDMwNWtGZWQ1TTNuVk1FZU10?=
 =?utf-8?B?Nm8xU1dPVjZIcjUwMlQ4bmRyVkoyanZYY2RhVGZ6cWd3dEJmVjEwRnJxRlpF?=
 =?utf-8?B?Q2pVTEp2bm5mclJ4QnAzSm5CWmtmOWhybTFUT3NWcjF4S2c0Nm5DS0VibU53?=
 =?utf-8?B?Ymt5SEdUTXkyd1ZsVW94c3d5Wm9JV09QdnBhN0ZlSmZqbnlxenJMWm5wa1pS?=
 =?utf-8?B?VXZsRGlCenlOZjZiSU8zN1IvaXlEby9aQ0dwWld1RytzNDgxTGJGNVNKQWFI?=
 =?utf-8?B?clF0ajZnRU5SVlUwOFZNV3JmT3FIZ2xpaUFxaXFDZHh0UGZVdGUrLzRPcDh6?=
 =?utf-8?B?M1VtWFNIN3RmZmZSTkxrbUtwejdRMitRSzl1c08rcmZyTjloeU9MU3NOQ0JH?=
 =?utf-8?B?ZDBUZGFwOThBdnJhVG9ITVh5ZmxQc0pITTFTRG9LSHJkeGZKanFOZnVTZGZN?=
 =?utf-8?B?TkcvYmJzVkVObllHdVlaSXgzWi9NNlViV1hnRmcrMjdIMzFUblRuSk1MSDhz?=
 =?utf-8?B?VElnS01zRnZjYldLaXZsNmtzQXFZQ3N4MWc1S2V2bno4RXgzRE1vSk15ZlJT?=
 =?utf-8?B?WC9GMTArMEZ6dTNLcEtlaXlvbmtPVmRQT21tSCt4aStnWUd5cHUyY2xEM2s2?=
 =?utf-8?B?NU5nWWJWa3dITDZWZWVCbkhIWFYzKzlFcWF0THk0R1dDVmRIekx5SnpmcUFq?=
 =?utf-8?B?ZDJOb25kUW14N0luWU5XWThJVE1MUjFrN3pCY043cUR5eVE2RjVqOXFpRE1l?=
 =?utf-8?B?b3NyWW50OTRQM3c2WDBVUE43RDhWODN0dzJ6OUZoNC9Canl3M2g3ckpSbDNL?=
 =?utf-8?B?NmJ5NnNJeXA2TkxvWHlUOC8wdlBkTkJxSzFkSDV2ZHJUeFVIVWNNTDZkVlJM?=
 =?utf-8?B?dmcvNVpNKzBNWXdGbEJybTVURlNFcFJFSEM5dW95R3Jjd2tCNWRBU1lPQ0NR?=
 =?utf-8?B?czA0dkkySkJMMmtlbDIrSGtZNXNhbzhqcnZXVEVmRnNuQ3BzRVpEemg1TXJp?=
 =?utf-8?B?RnN3a012RHZ3QTIvc3BsZ0hMUC84aTlocDZpVlR4d2w3UFNaTDdXeExhMjZB?=
 =?utf-8?B?N2RmejlJWlg1ei9nTTFmb0l6azdPRDVsNmhmcDdSSktZZ0VXUklaSVBJMHA4?=
 =?utf-8?B?VDFPL2FueGJRbHZhZjhHaGFRdGlxSS9Mei8xQURFdkgrekNiM1lqQ2lBNHd1?=
 =?utf-8?B?WXJYUXBoMDBkK2ErZTN2dys3ZUcrOW4zY25Wa01mZHI3dy91TG5PQVY1cDJr?=
 =?utf-8?B?ZWN3enU3TFp2R0pGTFRrU2RzSWJudGJtbkM2STRseFA1RDhHTytqdldyNURq?=
 =?utf-8?B?eEJiaEM2dllyalg4U210cWhxT3NvKzZjZWxSaVBNK0Y5aVhyaEo3QnozakJY?=
 =?utf-8?B?cTBrc3NON08yUGF5QVVteEFuUmpMTHBySVVIdkVVUXZTeC85K3ZMT2JwbjRN?=
 =?utf-8?B?YTNIQUpDeUU3clh2alM3K2hQeVdrY3loakc1VmE3NGJGREIyVjVlSUQyWFBK?=
 =?utf-8?B?QlREd2dOSXhXczB4NHhYajdwTEZpUWRTSXBMWHF0cGJpb3VXN0VQWm1Za3FN?=
 =?utf-8?B?VXdGbWN4b0kwd09RTWdLU0VoR2pwSmQyNERvNzlKZFFOSUczMkRxU3dpL1Q3?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a04eaa-a70c-49ec-5d3d-08db468ad9ac
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:17:17.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mcOd+GknM3EUFHplLCeC8nZlHJswCCax3p4PnoKoOQiGF1Fa0uFVssaZMOUXxdLUGZVOiJZe5BVQQnxMDRuBRGWxqUBJdYaRGavuAA9gTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/19/2023 5:31 AM, Patrick Steinhardt wrote:
> 
> ```
> $ git fetch --output-format=porcelain --no-progress
>   fff5a5e7f528b2ed2c335991399a766c2cf01103 af67688dca57999fd848f051eeea1d375ba546b2 refs/remotes/origin/master
> * 0000000000000000000000000000000000000000 e046fe5a36a970bc14fbfbcb2074a48776f6b671 refs/remotes/origin/x86-rep-insns
> * 0000000000000000000000000000000000000000 bb81ed6862b864c9eb99447f04d49a84ecb647e5 refs/tags/v6.3-rc4
> * 0000000000000000000000000000000000000000 83af7b1468c0dca86b4dc9e43e73bfa4f38d9637 refs/tags/v6.3-rc5
> * 0000000000000000000000000000000000000000 ab3affb8ed84f68638162fe7e6fd4055e15bff5b refs/tags/v6.3-rc6
> * 0000000000000000000000000000000000000000 1c8c28415e8743368a2b800520a6dd0b22ee6ec2 refs/tags/v6.3-rc7
> ```
> 

One thing that the standard output (maybe with --progress?) shows to
stderr is which remote is being fetched and what URL was fetched.

This seems like useful data to include in a machine readable format. It
wasn't clear if such output would still be made and whether it would go
to stderr or stdout, nor whether that existing output was machine readable.


Obviously you can somewhat infer remotes based on the refs/remotes, but
that doesn't include other refs like tags.

When fetching from multiple reports (--all or explicitly asking), I
wonder if it makes sense to include some lines to differentiate where
each block of updates for a given remote starts and ends?

Thanks,
Jake
