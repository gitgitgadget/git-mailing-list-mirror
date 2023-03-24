Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B16C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 06:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCXGAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 02:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCXGAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 02:00:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B095B81
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679637615; x=1711173615;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8sz64YbR6Km5mwsNA7BR/TLTJLdTp4ce83hs0AczU8E=;
  b=CIpeQAnpqytFjKnYdZ9ZSeoGi5sJmMTlm9LRMrMw7E5JV4crqbRCNbgK
   CZX0WbXGRy3jE2338Bj4zXyTTEDpyBRsM3cDqxyxJDEzWKs4YY1FBnJ94
   e1jLo43fOwBTyeuvIIbOUdvTARLaclfAHoKiZkEhqQzT/CoUj/s5krWq2
   OLYDrGPP47mw1APFp198hVLhtWNsQxW6IVS8uKR4vpkS60imEYJRvLPu4
   lQDwbK89z89g86mMliC/UmzpBJMgauk4ctt1p3i0z05QCP1ZZOwAl1xt1
   TjEJF3us5Vdh0UWSVcjf85H06uNOQEYFZesCnGng+J9tBXU8QoCVkgFgk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328113915"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="328113915"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 23:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="676015286"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="676015286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 23:00:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 23:00:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 23:00:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 23:00:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 23:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5LKO+OZSSC5G116Am0ozo7oEyjZrvB59gmtgy7X0I9oiJDe6/D74N4twrFpO6fspUaX+Lx3Zkt1TwKURXwfYhWwqONQsIC2tiMqanvRNCF83Dslko6DDNOFKXSgfH30SHqZKXvOdP7wV2A9k3KpEHNlNgFuT94Vbrrx5AXSLBmQLGyjPs/FI014AS+XAQwcusyw4HtLV/jY/otgCDhu6BoI3YNSga6Xwa0qn+XtTXCBa3oTCBmxBgtqUwcIHg2KpaXBcAfmZNIglIpCfDj13Bj+fzbY0lMX15xLTRlvpOEyUX8MFu2JAqBhJeEy+djqxVDJpqEBsTLK22ucw+/+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x7YkgoOICttSlue4wXnBsHEH4rNcnVBWJfESyOm7tg=;
 b=dd1P0Ev2GxfL9P9kSaCmTR6yNPI/BpP2Fnp70X/9p/m5XDrbpcF60xi2myaXbWiOSdJxpvxS3eqmy5DUW75c4fDdpQDjS8WgMOk5Nr7VpfKC7Nfn0vIHeU386lYLUN6yS6xwrCaDRJBrORFMcut0/6T66n+xNy9YzA0/9XODAU17xa8EP/IYBFZziJg6lREZiRQNKLdAAFtc5V8fKNB6XnVlJxrGT+daIae/tIZXTs95BQjP/fYEpaNuxIfvVq+Wyv1dZCLVx0p0kZGA5wD1WdTb/Ket5i1TdkDicualKbW7DApbHukEZbdwKweun6CNZtTrXzwigzIVE/HvxHh/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 06:00:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::a54:899:975c:5b65]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::a54:899:975c:5b65%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 06:00:12 +0000
Message-ID: <4f01d1a1-8e4b-39f2-1ccc-980f2345db73@intel.com>
Date:   Thu, 23 Mar 2023 23:00:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] blame: allow --contents to work with non-HEAD commit
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20230324010457.275902-1-jacob.e.keller@intel.com>
 <xmqqy1nm69se.fsf@gitster.g>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqy1nm69se.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9b9d33-b7d4-4ee2-87c0-08db2c2d080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnaA57+GXTFleaAUidNDTaxinBvBpcpBQcHfmQas6VaaJbLrsKyPnE4ORVzdFB/dXRVVIEcXwLm3Zoz07F47xSe/kg3QBZPBWY/XeVGjpD4WbAt8kNDyExKJPPY0Evwg6QqxkE5VeOb9+AeXhPsO/TeK1F36Zizjkihyfr5TYiFR55vu5YNgunxLo2eTlyA33TCtvEU0oyH7XGAMb8Y1/IdbVI2+gfQAwzlr/Zh94jk4pqrafky+ANLbH4TYwOZ22ptohE81DpV6G0s9uOjwPY1OAT3K+kj4Ig3qj5lPyn/YuxvH17gD+ogVDfP3BnlqW/Sdt6jrq1TGKyy18xD7RrMr37kFLNJ5jvcICydYa+LlB2m9DKkyIf0uEHksV1rADZD2GkSkNwa/4s1OedO4cxyfFfW09ZWVmLCnLrMyCWgldmu5MuF9FhPhW7KFT8vR0Vh/GfXFykto0Q5PX1CTGp9q9PgMk8Sa2u3r9YXF5q3IFbBNi5YxKlfLSAeb9TBJTQ067AvRFzF3df5GcqAH5n0QqeXBFo64e4HpgYNmtk+nWwHwpqi17ZERenYnsZVBMUlmPY4q8YDiUrjQtBXf30sTltKoMRs+oeb1yYofFLevTM1ivcEZHM+C9EuYbK5oBB6/RbUKXMSA2vM7E9z51Gq9IRPvxD6nQN3XzvF4/mi/DZp78/hnBNku2bkQkzHyDwBmVKyVne/xPOCnWQkKh0j3CwzgUmuRX2Ma/ddVdQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199018)(478600001)(8676002)(6916009)(66556008)(66476007)(66946007)(4326008)(5660300002)(41300700001)(82960400001)(6506007)(6512007)(53546011)(26005)(8936002)(2616005)(186003)(6486002)(83380400001)(316002)(36756003)(86362001)(31696002)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVPd1F4Mzk1VEJKNDR4UmFZVk9PSXdsOXZTamlPZ3JEUjRjTWxFVnJBUnJx?=
 =?utf-8?B?Szk5Wm9wM0NjNFA3UGNTVm1IT2N5cGVtajFleDBQN2x1U3hiaG1JS3FHQzBo?=
 =?utf-8?B?djBjNjVKUURWcjc2SDkveVRLbDJFSHh6NzBTeHN5R1cvSlowTSt2azRDMmhM?=
 =?utf-8?B?b0k1OTVyV1dOTklVRzlyakRYbXRVSDA5MVNhVjhRU0VpeE9OVkNlMHVvVmhB?=
 =?utf-8?B?VmRZTEFpRTEzV0hwdkxhZVRVcjl2WTR5T0UxV3dONGRHdy9YZ281TTJwWFdI?=
 =?utf-8?B?THRZeXlnamwzUzNmMjV2eVN4ZWJkelBGeUY2Skc3eVFtb0s3cWZ3cmpFcEU5?=
 =?utf-8?B?eklhVStCeW5ib05udmFkTjRPUkFiRG9Tcmg3bVpqc0hMcGx0cVBWSDUwbHll?=
 =?utf-8?B?WDE0bnltRUJwMFUvOHdUdDdZZ1VHbTNMUWgxRVhZOGZ2WCtXVVh2QkNUQitI?=
 =?utf-8?B?SWtjM2MwSUVMVWk4YU9veVR4SWRkbHJqZXV2U1Z2MEM0RWp0SUpaM0RPUFY0?=
 =?utf-8?B?TTgwano5cWFWVW5wTEFCK2xMOGhHeUF4MENRY2NYak4raFQ2eitXQ2UwVURH?=
 =?utf-8?B?bWdqK0JCY2syK0QrWThxZWMvbGdiWkV4WnFIdGtmemFUYnlxSGxZclQ3Zkk3?=
 =?utf-8?B?KzNTOUpXY01scU1CQUs3M3NtSmZMUGJVZkYxTGVCTnRLYStERitpM0Nucmp3?=
 =?utf-8?B?QVhQSnRTaC9adVFhK3BjYlBSbTMrMlgzNzhkRmV1MER2MjhGWjJibkpUVnRn?=
 =?utf-8?B?TW1mN1lsMEFOY0ZFT3ZIODRGNmp5U2Z2YXluc3lta0pzS0UvUnc5WHZCdWdY?=
 =?utf-8?B?cnZzUmZMM1I4SDFQQy9jWUErQUNsUWloNDhudzJuSVlIM1hqMk1tR29yMHEw?=
 =?utf-8?B?aWJnNWZUQStSV0FSMlQxbXhNbWJZTkhEQUhXc1Y0SkprR3NQQXB2OFIvQlVz?=
 =?utf-8?B?N0RSL0FIZnp5UFoxMFJEUFFSVDE3a1kvakpKVTh1QzdUSzZRRU9FbVFJeWxs?=
 =?utf-8?B?dC9SUzdzb041anhyZ0dXMGZOVVI0QmlGVFZwUGtQTVBBK1QwemVFekk5WmRn?=
 =?utf-8?B?bExuOUVwaXlrSEQ1ZlA4cjhvUW1xRFNNRjZyNFF2cHhhcHpHOTkrdklhYWRB?=
 =?utf-8?B?Tllrd1pCeHJvRlRaSDJqOU1PcU5PV3FwSVpFc0dQWHNGNzMrcGVVZ1NuTTdT?=
 =?utf-8?B?NEVsd0lzZG83dzkrL1h4VS81OGMycDJFZnlLNXFmYktMNGpCSWl4RXpVK0gv?=
 =?utf-8?B?YWEydHhNaTMyRnFPM0prSGJwZnVsbnhLQy9EU0FjT2RlRkw3SEU4TDdQQ1JB?=
 =?utf-8?B?Unk4RjNKMU9FNFRYMkNsRXA2SkdYUTM0WlFxMkxSSkF6MndOZG5NcTI3VVk2?=
 =?utf-8?B?eGljMlNSak9lK08vV3BVUStsZTlhSWlYaXViVzEzczFOaGVpYk1YdlNCSzk2?=
 =?utf-8?B?SlBGMHRtRitheS9MSXRway8zcC9PMjFhRGRRWkFpZmh3SThRbi93ang1bnlU?=
 =?utf-8?B?eWlRbWs5bjhITWN4Tm8wc2VDaEZSYXJhT1Vna21WSGt5V29hM1huQjJlUVhv?=
 =?utf-8?B?TDBqZStucGhSVkwvL2I5cnk2R3EvY05IMVhKTXVRcWFJWVpCRWZkWndQbGd3?=
 =?utf-8?B?VGpRQWFOVXM3dWdINzVqeEtGbC9XUm1YcWp0Yis1V01wdmloTzZEYW1GNVFB?=
 =?utf-8?B?eEloMzdCRFJUbWZ0UzN0VVFsQ3ZRaVlVZDJGZmJyWjYyb1VRRXZLNmc2em9J?=
 =?utf-8?B?QjVseDBnMFZqS2hLQnJyTG9RaThFNmxUWDdWTEpNYTBmMzcvTzk3eFJlLzZa?=
 =?utf-8?B?UXVCeG0yVEswZGtwS3pBc3VUZW1icUlRbWF0Ny9iZ05wSzh6Umo3cnNUY2s2?=
 =?utf-8?B?aUJ6bzFKTjF6OGVDTGxZUzhpSUo3SFNBL25BVThXNDNJamVRNFNmVWx0N3hy?=
 =?utf-8?B?N2JldUNCQnJpM2xnWHZMbU5vczZmbEE5cjJMYzEyMi9BNVNRNkkvejl4dDFy?=
 =?utf-8?B?REtOTEsxWXdNeGZTR0tNeDJPbVNMVWZUbndSZml5Q25jeTU4cTJ6aUFXaVJa?=
 =?utf-8?B?UkYvR2djVUFLbnRBWFhYR21oc1VxUDRTNHBWVUI3RFJkUGcyTFZnNUx0Vy9N?=
 =?utf-8?B?c2RkZ3RNNnpNa0MxaGJ2S1RmSGhyVzdtcUlFNkJEMFFyV2wvaUl2TVNDOU9S?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9b9d33-b7d4-4ee2-87c0-08db2c2d080b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:00:12.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwS8h15iQ1yrjV57w6ic8iZfyY99i4VKrp/bpE4FY5bGdS/CHoHFZByugfHcA/qenM88mnB40ij4z4Bze/vZTMo56LaMjO7uEZw1x9ylWB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2023 9:41 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The --contents option can be used with git blame to blame the file as if
>> it had the contents from the specified file. This is akin to copying the
>> contents into the working tree and then running git blame. This option
>> has been supported since 1cfe77333f27 ("git-blame: no rev means start
>> from the working tree file.")
>>
>> The --contents option always blames the file as if it was based on the
>> current HEAD commit. If you try to pass a revision while using
>> --contents, you get the following error:
>>
>>   fatal: cannot use --contents with final commit object name
>>
>> This is because the blame process generates a fake working tree commit
>> which always uses the HEAD object.
> 
> "the HEAD object as its sole parent."
> 

Ah, good correction.

>> Fix fake_working_tree_commit to take the object ID to use for the
>> parent instead of always using HEAD. If both a revision and --contents
>> is provided, look up the object ID from the provided revision instead of
>> using HEAD.
> 
> An obvious enhancement.
> 
> As the original author of 1cfe7733 (git-blame: no rev means start
> from the working tree file., 2007-01-30), I am not sure if the verb
> "fix" is fair to describe this change, though. 

Right, this is an enhancement, not a fix. I reworded this in v2.

> If you update the
> working tree file with contents that is vastly different and totally
> unrelated to the version at HEAD, then with this new feature, your
> "blame" can start at the working tree file, and then some commit
> that is totally unrelated to HEAD, and down the history from it, and
> everything should make sense, but if you smudge your working tree
> files that way, it would be quite awkward to use the working tree to
> advance the history that leads to HEAD.  That is the reason why I
> designed the "fake commit based on off-history contents" features to
> work only with HEAD.  But unlike actually messing with the contents
> of the working tree files, feeding a temporary contents via the
> "--contents" option has much less chance of breaking the next
> commit, so I do not have any objection to this patch.
> > Thanks.

Right. This doesn't change the behavior for if --contents is not
provided. If a revision is specified, we ignore the working tree and
just use the revision. If no revision is specified, we use HEAD but
generate the fake working commit that includes the staged changes. Using
working tree with arbitrary commits doesn't usually make sense. If you
*do* actually want that, its possible to do now with "--contents
path/to/working-tree-file", but you have to opt-in by using --contents.

The change should only modify the behavior if --contents is provided. In
that case, we always use that file contents and assume you know what
you're doing with respect to the contents you want to blame.
