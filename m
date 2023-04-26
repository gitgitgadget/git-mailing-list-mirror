Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9998C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbjDZTUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjDZTUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:20:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BC10FC
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682536819; x=1714072819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2k+ILT4ArU/8GKGFHl/O6M62mSS/RImXNNnpiSjhDVM=;
  b=K97d80YxJ3mOEThyg5YWA3NE/6ynbaDUkTLirk3v9sdaA0waBUuxz8pj
   9Hg5wVi0zeil9xBwyrGsecY4Io3zP7ilvCXE35oX61JpqZdG1o260dvWX
   v0/n3HjRH1VTO/ScGUWs6RAxPVVIIsDPpqWMO3+86N288Xzqs8gmVvQ1a
   oMgEcuHjgk6/rhfkE/64bizcSpZjWzULrbr9rx7Et1V41DouIunaLCnuy
   0cq5iX/SC7CHogS6HLyIQEcQ6L8zi+TP4RTAmhNFv8GByMaVk5aiNzPxS
   a7ZmcIsOdneuqaPk/egAHBMW7WXpyVXWbhPaikgeBD8KsK2fIPbrWm14O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="433502693"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="433502693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="726685353"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="726685353"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2023 12:20:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:20:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:20:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 12:20:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 12:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTfbw0E04F6zcBnS7SiNOdDWZJWgPa+plj4S+dwYAbnDZMBPQXuqesg+sxoTWQJJ8UEkxuZDzSulHbX5vq7XSkGXoMxTsDvAfg2+D7RgkVwdM+z/g2xiCg2PNL/Ef0NWxVbQBJoPaOWwwEB78qf9hqTgdb6zYOXRwOXBkm8BjELusnnR0lTv2ZN7URj7VVbAxVXAnjl23Sz6TWrowBnZsh+9Gg2nqYSPHGtyymEBF8ec8yiC187OVbL62iI6t079KS/EErHXmQVqjUalwwX/fMx16TjUvg2xD+dX2krWa0I7jser+Pqs9CuRk+OzqNFbTgphNbXAjCsXA8yesi1t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqJReblFHTlkFEfZWEdtsJHSMmJ1LpMm882qyqwcOg4=;
 b=hPIkQaDH3YuPbcg4RVZPeb51GCVId30Wdo9VR1wIxz+BpwQHe89lJ1AwJV66pcFmpnXiXGs7jB2/uQVzXNbb2OPvaATZFNBeD1uopNleCI1IDWFIqmcTZbGEkHoa3xY3MNl5gpA/A3fBJTJmb6PnPfY9ZKnDS7GK5CbPLBUKPSJR4MNe0a4NO0pBDOFEnyVoBnFFICzGXYcV8BFAnm9G5LbJ0LD2W48V0gdVA67HnBKMziesvXH7oHPr3zIOn9f98vAUozgcczheN9X/Lb6GoMO/y8gB2gQvGmhjjT1HFqwbAcVxAk7LRyAzLKELbvSHx+5/lGkVvWu90kI3vWbF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:20:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:20:16 +0000
Message-ID: <8e08ac5f-b1cb-554c-dc21-4cbd93c348e8@intel.com>
Date:   Wed, 26 Apr 2023 12:20:15 -0700
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
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: a4206606-bf12-4c98-3f2b-08db468b4483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwykToM+48dVFsz1XYuF0WJTgGy+7YuP/AnuzRcMhv+hcw1oRlQC29ghLKYMDjISP+vAxitHAU64V6FUdyf499y6LX0dI1rxwSUZpa2MOb8Pue9278+t2u4LBbXNVM6ftVfJJplxUIa+Tqi4tyZw1EJxxirI7NCu5UcBeMmOfWS9VrFjjLBcHY5lMZYc448acY+nfQSHQAwmlBCklZxd7aLeub4mLnEbSdlE8nmITSTVRxC8aow6g8gIlGCX47H/yKUD8x0UNAEafTF7QCqKvDdPViFUdAD0pZ6TYftdX40Wis++LST4vlMcNIMxv1a961qL46GMu2+WV4OZB3QPHl7Hm4s2kt0pVaiAmeehjLoPk/5IVJ3oTbI6E1HQ6D4Rs40AYhn59cGNDtowvpa7HQyqaXSpWA6Pizha3mrgR4e1zQpgP6qRqMLtVTqBJzqLeXvCWKCc4OKW5oRtUOVrObVHbHuIdbfOMVCWlH+6NJ/nKJT0GKd43qEnGBgnYg5Ga2hyXXz+jPAFeFMhAD95166TaObDwTidDZcvz6XX64+kZRZjh09Zr6oRFNYT9279+3DvrG3+JhlRr1FT3pHy4R2fU47ujTETTBlz8DeWSo5VMeId1EGwlaE/CmzlXyeiPXBb+t44Fy91ZT2n0k1agg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(2616005)(26005)(6512007)(53546011)(6506007)(5660300002)(82960400001)(8936002)(8676002)(31686004)(83380400001)(2906002)(38100700002)(4326008)(316002)(66556008)(66946007)(66476007)(31696002)(36756003)(478600001)(86362001)(186003)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdEN3dJMjBSZGFqN3RkVzlZN1g5cEVoY05XRkM5TFZ5T1UwSHQ5eFl4OFpx?=
 =?utf-8?B?MkxjU3BUR3E0WTNtcGE4KzQrQ1NUVjlMeHEzLzVjYThMRVBHUzJkeno2aW5Y?=
 =?utf-8?B?N21GZjZ6Zm9qVktDVktJTG9xcXV2Ym1XMFd6akprSDZCS0NTVldFb1VkYU9X?=
 =?utf-8?B?ZGRYT2c5QUlvM09wZ05YTFBjbW0xQy9PY1ZzR2UrVU1rL0VvbHcwaGJISExS?=
 =?utf-8?B?UUZmb3dzR1M0d0pYZWJrNVgxbEZWcWRGb2lmUVc2d3ZVZTQzYmRYTGs0a0l5?=
 =?utf-8?B?cmE3N2Jiblc3ejRDdEdMd3NtRS81d0lWNEJ1VmtxR2REWWdvUC9YQjNEYTFG?=
 =?utf-8?B?eStJNnlGeUZtTGhSOVNEdGM1dlhidlBJRmEvMWkwMVhGMERIek1CT243WlBv?=
 =?utf-8?B?OUc2RmxBUUxHY1FZZ1NRQlBnQ2s4VlN0YTRyY0JINm1EWUIyWGU3YTlMSlZj?=
 =?utf-8?B?b0oxS2xicENGSmdLb1gwekM4U29wQWlPQTBRaHh3VXlzbHgzNW55eU5pTEhz?=
 =?utf-8?B?ZFIzakdxVFZYQlpOZzAyUk85ZjNrcW9mRFBpVllBUkFRSlNtalJnK2dmOUVp?=
 =?utf-8?B?b2ZlWHk4azQvdnM3VWNSMjl2MjRuVFlXWWtVOVJwVmdhSlJCV2d2TS9WdHIx?=
 =?utf-8?B?UU1MN3B1S2w4WnU1OWdObEhqV0poZXFOUzgyMEQ4cWJ1U2N4bU1oTUJORlN3?=
 =?utf-8?B?UjNsREhNTkE0aWdKTEZVbTVFKzIwMTYrSzFiNXVhdVkwNnpkYVlJeTVGWHpX?=
 =?utf-8?B?ajNhVEZVR1NPRXRWQ2NRVHI3eVBiYVR1MlpnUTRQd0RTaDZQaGFQZkxlSGpK?=
 =?utf-8?B?eEZrWU81R2xDNHlwSlBaUXV1ZGc3RkJWSFlwVDlabUNUNjd5YVJtai94VHp1?=
 =?utf-8?B?ODdyREtEMzFGU0U2cTVFSndYZ0R1djRNSXJGb1gvbG5OK2pnS3lPTVBCUkJX?=
 =?utf-8?B?M2o2NVd3aVlkQ3BwYkFjM2FHVVFGL2ZySi9Ed2o2WWdJZ3NqZE5vMnNESVJ2?=
 =?utf-8?B?KzdvRk1rbkIxWkpuVUhXck9kTjU1cjM4M212QXRRWGFFazl2U3lKNWFYRjR2?=
 =?utf-8?B?a2dSWXJ3cUk5ZDlWSmdzRk50dEVoaEdKSm53bm1HWWlJQ1B1S1MvUE56SldJ?=
 =?utf-8?B?ZzdSZkdQSVNRb3FXbHBaNTFFd3J6MVZHUnVsR0JGdjJPbitrdUord2JMcWN3?=
 =?utf-8?B?c2t3QWduRlhHOFBIVW1KTjRJVjBjakc1ZkU0R1NUVGp0QzVveEdRekw2bnVU?=
 =?utf-8?B?OFduRzZ3YWxxd0ZuVTZWL0hCemNNa0Zxek84RmFGM25HUDZkVFJmN09oRW9I?=
 =?utf-8?B?NE1zSlEzWWxjVWQ2TTRLVWludTkyYVJvanFta0dlaE5kb1BoRGtGWkJjQmcv?=
 =?utf-8?B?OWhUUHhIUCtuS0MveDJLaktEWUJrYjZCRUJaMmtZU3owQk11NXBLdVVadDNn?=
 =?utf-8?B?SFQ0YmRXeHFWQ0RmNXJLZHFkSzZUMmlJRUVDckZtTVJ1MGRaaklSNm1TdENi?=
 =?utf-8?B?VWxtWS9BMzgzTFVSd0E1WDN3T0cwVmh5RzdXRHRibEtodFlQN2g1eUhjV0RY?=
 =?utf-8?B?clRQMndJbkFneFhsaFFsTmFtQlFLdEljMVc5SlJ2N0VMTXNtOVRERWIwRnhS?=
 =?utf-8?B?dXJDb1FPbklqUzllMHh3K2cyZDR5RUtueERMMnRwdmJxeG5yUVlDeTdNeHpI?=
 =?utf-8?B?R0lDSUtsN0RDTFl5akRxdEw0K3VOYnByMmJqV21Lc050UlZvMlBOU1dJL2VL?=
 =?utf-8?B?d1hNdVJLS2VpRWhrS1RPTytHT084L1NJM2c5eFNaOXhOeFdnb0pqS3dVVFAy?=
 =?utf-8?B?N2ZNSmtuMEtENHpKZW03amFhVjJLUUdKSXNzNS84QnZlMGF5V21qTDVRYWFC?=
 =?utf-8?B?a0xIS0F2Q3Y0dy9XZ1dnQ2E4NFREV0YvZWRvWGdlU25JWG15bGVYRFEvRU8v?=
 =?utf-8?B?b1NscHZCOFpwVExrS3BBaVFkd2VDR0JBTUljNUR3Zmt1dkxVaDFOdE1pbWxh?=
 =?utf-8?B?eGh6eFJ2dnJrb0hsN0V6aldSZkRlcmp4bS9CR2N4cUNxV1haVGc3b2lsTWJt?=
 =?utf-8?B?a0JRVEV2M2VsVXBpMldjYU1vV1JXRmh0dko5VzJUendDQngxUFhPaVcxbU9i?=
 =?utf-8?B?clZucFdDNDBYNW9peitBcEE4eGYzeGJlZVhaeG0rN01xa0FzZjJ1VmhsM2FD?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4206606-bf12-4c98-3f2b-08db468b4483
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:20:16.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGwIU5kMSlGjl88C0RiUoTt+aGvfGFAZyJBd10Z/Il+5O4IhSE4LeunCHBNs0Jnyq4i5INnqBgGmIbs9uLxJibBxTHioXL27pCIVv0bMI00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/19/2023 5:31 AM, Patrick Steinhardt wrote:
> When displaying reference updates, we print a line that looks similar to
> the following:
> 
> ```
>  * branch               master          -> master
> ```
> 
> The "branch" bit changes depending on what kind of reference we're
> updating, while both of the right-hand references are computed by
> stripping well-known prefixes like "refs/heads/" or "refs/tags".
> 
> The logic is kind of intertwined though and not easy to follow: we
> precompute both the kind (e.g. "branch") and the what, which is the
> abbreviated remote reference name, in `store_updated_refs()` and then
> pass it down the call chain to `display_ref_update()`.
> 
> There is a set of different cases here:
> 
>     - When the remote reference name is "HEAD" we assume no kind and
>       will thus instead print "[new ref]". We keep what at the empty
>       string.
> 
>     - When the remote reference name has a well-known prefix then the
>       kind would be "branch", "tag" or "remote-tracking branch". The
>       what is the reference with the well-known prefix stripped and in
>       fact matches the output that `prettify_refname()` would return.
> 
>     - Otherwise, we'll again assume no kind and keep the what set to the
>       fully qualified reference name.
> 
> Now there is a bug with the first case here, where the remote reference
> name is "HEAD". As noted, "what" will be set to the empty string. And
> that seems to be intentional because we also use this information to
> update the FETCH_HEAD, and in case we're updating HEAD we seemingly
> don't want to append that to our FETCH_HEAD value.
> 
> But as mentioned, we also use this value to display reference updates.
> And while the call to `display_ref_update()` correctly figures out that
> we meant "HEAD" when `what` is empty, the call to `update_local_ref()`
> doesn't. `update_local_ref()` will then call `display_ref_update()` with
> the empty string and cause the following broken output:
> 
> ```
> $ git fetch --dry-run origin HEAD:foo
> From https://github.com/git/git
>  * [new ref]                          -> foo
> ```
> 
> The HEAD string is clearly missing from the left-hand side of the arrow,
> which is further stressed by the point that the following commands work
> as expected:
> 
> ```
> $ git fetch --dry-run origin HEAD
> From https://github.com/git/git
>  * branch                  HEAD       -> FETCH_HEAD
> 
> $ git fetch --dry-run origin master
> From https://github.com/git/git
>  * branch                  master     -> FETCH_HEAD
>  * branch                  master     -> origin/master
> ```
> 
> Fix this bug by instead unconditionally passing the full reference name
> to `display_ref_update()` which learns to call `prettify_refname()` on
> it. This does fix the above bug and is otherwise functionally the same
> as `prettify_refname()` would only ever strip the well-known prefixes
> just as intended. So at the same time, this also simplifies the code a
> bit.
> 
> Note that this patch also changes formatting of the block that computes
> the "kind" and "what" variables. This is done on purpose so that it is
> part of the diff, hopefully making the change easier to comprehend.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

The commit message here has a lot of context, but I found it a bit hard
to parse through, especially relative to the actual fix in code.

One suggestion was to load the paragraphs a bit more with the actual
problem being solved first, before beginning a lot of the context.

We also discussed the block of format changes and felt a bit mixed on
whether to include it or not. It does match the coding style guidelines,
but there is no actual functional change made to those lines in this series.

I think its a good improvement, and it does force some extra context
into the diff which makes reading the resulting change easier.
