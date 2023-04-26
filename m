Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B118BC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjDZTIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbjDZTIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:08:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98D8A57
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682536118; x=1714072118;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RQlIfIGLIZVbfDJCrRzuXVhZCRBTUdP8Cn7npqB5j9A=;
  b=nUc9cPe9sP/ALDosScXBNH3L8n5G+9MpKkDp9ETilFoBXZHyM4yatNY2
   gcE/FbUvrjy7Pizp4pyBxPUqKB3DRcO1pGHAHoENh+QFGRdPqE98JBYoK
   cY+8+Dftw9eLEkXpJk7XtaO6j3ojVLK+lBSWQPW63cuIVxUJ5beS+4K45
   IoJpUil/CNIJOX3LKdlg3KmrOXKGX39YJyOsawg/mWGouWbsIiupH3F//
   4u/5i0PgatZsv7HyTkrmjRn8uC6hwSNS0oTeUoHyGeAIUJYiJLQ08ybgL
   4aWQrmLDyXsxOcYUmx8/iB0TcXPWoI3RbKV5UlCo3qfTJfRp651KxKhhI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344661042"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="344661042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="1023754466"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="1023754466"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 26 Apr 2023 12:08:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:08:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:08:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 12:08:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 12:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwstBGYDSALhbza7fktQDjdDZah/cXVW9My4u4/d1hxS9GnN9gOmnaN6lwnwgD7uIYWlBIZuJrao7c4WSo3FLhrRdlu84hT7WZ6hQldlSro4T0tHaVxDsLdlomC2xwSJZ0I7Xvd5n1Tug4K1heKjzji1A8tvMf71jgk6faEgvzj8eJFnIvu0huUFt1PEmVLN1n4ChQYTyqZp2Ws840ytT9BNp8cWjNuqPo9gaiBNK+Q+k6muw97qdosEczB3RZKFwndpBWHmFYzhWS5NYR5p9vqOsP/BmXyLD+xYp5YnLbwem4fR/NU34wtoyJfSYw/ZEY70CUP10JwhzLrySSbR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Fy9FlQA8G/SspXq+Sp4JPVrGrM4BBBvGRTxyKL3bk=;
 b=WfU3PB+kf3HCLeND+Ez4+1XMHbZPdGo+oa1bBCsEsrzHS+PObxdssxL5iFaToeDlOy9F1OBTOVNM4DhxAooLLvjygbRMnc7h4MLzcikdqOSZiOF/U8lnQQGmHHeFBXTFRNQmBAokTyYCGfCjz5FpIQgKYlb8SNlmRW6TQMe45swtbxmjld0czZX0UntFze++c6Afq763N7y/YB0ht9KJkqGFDCFvLjcfCBE9ZaG20/eWbrpFikr2BBrnp3nhJdIf6QIwJiIWEgL5hVsbeFY+imgy9XGgik4NWQ7cKrTz59J37C+d700dW+1erLe1Iak/IPRhV6QIExgPd8S2J/F+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:08:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:08:28 +0000
Message-ID: <c7bb292d-903b-692e-885b-524b6bb113ee@intel.com>
Date:   Wed, 26 Apr 2023 12:08:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Proposal: tell git a file has been renamed
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Jeremy Morton <admin@game-point.net>
CC:     Chris Torek <chris.torek@gmail.com>, <git@vger.kernel.org>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
 <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
 <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
 <6446d78fbbe82_cd61294e5@chronos.notmuch>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6446d78fbbe82_cd61294e5@chronos.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ef8592-8ffa-4930-ea19-08db46899e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgZ9q1cCoivt4oP0yWd416YftwZBrf/wRFHnROp4ubMzjnVwxQ7wpkZIFk/gz8r2jtULQoNZGrH4OnnSSwpEUYUSQDE7a0KvhEjm2eXD/7+ft08PlWucxazNEpel/2CjistfQqf7HrvxEmFHRYsIAW9UKdFh5LIPYzrDFMvim2sDR3S/QtKan967+wO2AHDwZDTZ7xDnvX23Zr0eglMcLa7H1QObDDL+bJ+u3IoxUc6LGEXbwppH160I3XIBHt9/30usf2GPPSthY050bYHvT8YGJaoDDdkcaXogvIWaCSCsCNRaPNoZ1h6w0F93LJ+WgmDSsXf6Xqi4LKbOlISh3nhmAxLDRXec55Hs6JiGT/+fxe/LDNnrAwDr4bpm+uIB32ww7Rep3T/9PYU9XyzF/ohUOzVkNVwgR9oWSAq9YBiYrJoMQaAQlDY+cjMvl0KI0Q2q4XvJblGrcwAypSOzKNycxKcXK1WELH6Qu38nHmlAOC7DPVlyvwtphkuvWJ3CZ1bt2QTdQnCevxQfvzdIWpJdayEf1kSvxfRzxW4r68GRENU9YIu3SY3qD7kkFxKbzkD31wAlHsBtP/2sPsFEUebJ2o/Y0pinqUjcLffbRnX1PL28FtS5Kr8oEyXWl6RoQ8nvdQC76K6FAV+PTdAo/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(2616005)(26005)(6512007)(53546011)(6506007)(5660300002)(82960400001)(8936002)(8676002)(31686004)(83380400001)(2906002)(38100700002)(4326008)(316002)(66556008)(66946007)(66476007)(66899021)(31696002)(36756003)(478600001)(86362001)(186003)(110136005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVd2dG9VQ1VDVmlBajhvdHo4cTdmdHAxVitsUVA0dms1T0xIb1hvU1RtZzBW?=
 =?utf-8?B?M2lFdk5KbjJxUWo1MHl6VnVQa3RyRklFdVJ3VC94cWtwNC9RRUpyTS9odUMz?=
 =?utf-8?B?UW5RM1doaGY2RUdyZFJrT3IzYWxEbldFT2FHSlhzWTUxd0V0ZG95SGdYbElw?=
 =?utf-8?B?KzVIeDgyUjdkcVg0c0FleS9YMEJUSlhWSUV6NVY2NEJCdWozeW1KRkM0TkNu?=
 =?utf-8?B?b1NPQ201YUdJN1J1ME9OblJrSUt0Y2NITnpiOTFzeWo5OFR2dngwZjB0cTFh?=
 =?utf-8?B?eStPRWxUS21qd3RiYmxLLytyVmRFaEdsR05FL3dGd1p5MlpQeUNDR3YzS2Ev?=
 =?utf-8?B?NGRiMVVGZU1YSnArb3NEaklvMW5zcHZNT0YrZnlZaTVUZUpXdW54ajdYdVhD?=
 =?utf-8?B?WDZPSmxZa1l6TlJRemZTcm5uNUpKUWJLQjB2aFBsVTFQTjBwRFJwanlXZVBP?=
 =?utf-8?B?ZE1LNnY3VjBib04zdVZkNmRSc0h6dVVLNG1rL1FhUHNxR1E5YkhxdGIxcjNm?=
 =?utf-8?B?WkhQZUU5NEFmOVkzK0w1S21HNTd3UE9xZnYwclRCMGFkazRmdnNjbjR4eW1L?=
 =?utf-8?B?SjY3aStFMzM4dEFBOUVPay83OHV4TFN1MlhMWDJMaTM5RXpUVUFNQWgwbUhi?=
 =?utf-8?B?eVZFUFlaNkwzRktsREhKMWQxNzdOUXRpbkFvSmdpZ1Y5RXY4NVE1bjFrN1lJ?=
 =?utf-8?B?WWZnQkJvTkF6S1hHS2IyK0VSZ3c5czJtcXVQUTNaUGs0WUZoeGZzQithUGxJ?=
 =?utf-8?B?M0RQalJBWE9Yb3dYaWY4Q1ZVM0dkckEzcVZJY2E4NDlSSzYxYXBuVUp3SXNC?=
 =?utf-8?B?RzZIbnFYZkN4OThHU3A1eHB5UThxekVRVVFWbnhkRWpnUGp1QktYbjdXdklo?=
 =?utf-8?B?VFlWY0Q3bTJnU2tQdWNwVkVoME1pWTBDb1dpdlh3ZkNMTHJvbGNJM0I5dXF4?=
 =?utf-8?B?ZVJXb3psOEZ6VHpMWDF2QmFwaHVLbzBBbE9ndjNHOTlNbGEzZHZJRjdkWGNa?=
 =?utf-8?B?ZlpSRzl0enpxL2NnU3Z2NG1wQS9wWHdiSWhrdFpyK1NtRVZBS2luNUJFWjZC?=
 =?utf-8?B?TVZneEtwMmVoVzFRRzloaFBvcWxjMVVzT2RuSmhCOE1pblA0NkVwSVhwL3dK?=
 =?utf-8?B?TU52M1ZEQXJYUWo0RGo4dzJ0ZFNiTjYwVmhIY0huYm5uMThCR2FFcHh2clFk?=
 =?utf-8?B?R0FUWm83NkR2U0s1a093VnBQdTR0MTl3c0FaSTRrMTVCZDRvK1hUTHJLV3Vk?=
 =?utf-8?B?VXhJVjFoQXZEcDZiUjlQV1VQSTNId0F0QWw2TW9HNjBpSnpUaHFta0xURWZr?=
 =?utf-8?B?YUYrS1htbUJOY0thSjFwNlFQT3JDalA1NUdkZVVkSE9tSVpDNjdQaFBTTVZa?=
 =?utf-8?B?TGhNNTliTEozV1hGNjBWYnRnbWdoMldobklycFh1dG94WmlhY3hVZDhFb3Nt?=
 =?utf-8?B?ckVYOWk1QVZnOERFNnp1TzY0NnMxcmpiL251OE9sL0xiZkhKYWlGeldObDNY?=
 =?utf-8?B?VHBMRUlNcFhaRXdsNDdXclpKRktyZlViZjR4cDBRN2drakFTMnhNUjlUV242?=
 =?utf-8?B?Y2Z3WmVqZGVkTitqeE1PMEgrUW5iSnltQnY2N3AzenhlOVZQcHRDZlQwZzh5?=
 =?utf-8?B?U0xZbEJJZ1l3alFQQ2tmbVJ6UzVOcG9Wcnc1a2lucjU5dFpXVXBhSFlhSk02?=
 =?utf-8?B?R3ZUK1BVbGYrdUJKdTJWVWM2SjdqelpkVFhFZnpNMUlSODFPZjNpUmZNcTZq?=
 =?utf-8?B?U1had3cyZzFlUEtTbmJodXpRNEVJcHZOVnVINXh1dVZxaldKQzdlU3dvNzdv?=
 =?utf-8?B?R1QyOGE1dm5nZms0Wms3VWNvN0pBRUY5QUh3d0pvQ1loSElWci9raXpsV0xj?=
 =?utf-8?B?MXoyZ1gvM1gwcEJBV00zRzcrN3preXE4cGp3S0JDcDgxZkxzZVo0MndtSFVp?=
 =?utf-8?B?VG55RmpwWS9lM01TUTF0RURxaVdxdmVybGRxVVVaQ1NaWGtLS0hNVlBTTDV0?=
 =?utf-8?B?bDFLVmdRdHhidUJLTTYzN21xVHZDdkEreUJpdFlsRklqR1FlY3FMNTljc0hN?=
 =?utf-8?B?dk9yTFdQTWFQV1J4aVBXSWh6UXZaa2FGbU5QYzdOOEJIN0RVYTNvdW1kZ1hX?=
 =?utf-8?B?enZmTzVMRHh0MjdmTVlxaGgzTFAvR2M4Vm9xTXp4S2tyMXI1dlMxa2U3QlFr?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ef8592-8ffa-4930-ea19-08db46899e35
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:08:28.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNUwqVpfd2Up1C8VVLAlwQrzzSQtbuQ+y9+HzdmbOLn24FugmPIydSDT2eazgIM3eiQ05okxaJQvBVGnz8oVHEYZCqjYa8DKtwiegVbBK9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2023 12:25 PM, Felipe Contreras wrote:
> Erik Cervin Edin wrote:
>> On Mon, Apr 24, 2023 at 1:17 PM Jeremy Morton <admin@game-point.net> wrote:
>>>
>>> There's no getting away from the fact that this adds a lot of (IMHO
>>> unnecessary) work if you've already done a rename that git can't
>>> detect and have both that and a bunch of other changes sitting in the
>>> index.  What feels like it would be a natural resolution in these
>>> cases, though, is a "no, this remove/add is actually a rename" command.
>>
>> It can definitely be both arduous and non-obvious how to deal with this.
>>
>> The problem is that such a command cannot exist atm. because renames
>> don't exist, they are only interpreted. So the only way to achieve
>> this is to revert enough of the contents staged to the index such that
>> the rename is detected. The only way to do that in a foolproof manner
>> is reverting all the staged changes except the path so that the moved
>> file in the index is identical to the old file in HEAD.
> 
> I agree recording renames explicitely might be a good addition to git, but the
> real question is how are they going to be stored in the object storage.
> 
> My guess is that it can be added in the commit object after "committer", just
> add a "renames" field with all the renames, or one "rename" field per rename.
> It would be backwards compatible because any field can be added this way.
> 
> How to generate these fields is a separate issue: first things first.
> 

I think such a renames field might work, but I know historically there
was a lot of resistance to "baking in" such rename logic because you
can't "fix" it later.

I know there are some big threads from early days of git discussing
this, with many objections on baking in renames for various reasons.

I think the argument can be made that there is still value in a commit
which says "I as the commiter know this is renaming the file, please
show it as such and track it as such", and I think the other use cases
(code moving from one file to another without a full rename, multiple
copies of a file getting deleted, etc) can be handled in other ways or
with an escape hatch to disable the commit rename indicator if necessary.

In the more complex cases where code is moved without a full rename,
there are tools for handling this such as pickaxe or the proposed magic
blame tool that was brought up in the discussions against static renames
being coded into the object storage. I think those are interesting but
separate problems from "I am renaming this file and some of its contents".

At commit basically is the only way this could be baked into the object
storage, since blobs don't store filenames and trees don't store any
method of difference individually. The commit is the only place to
really do it.

The alternative would be something like Junio suggested where we have a
separate rename storage database which is computed ahead of time (kind
of like commit graph storage) and which could be overridden manually.
This doesn't "bake" anything into the objects, but obviously requires
manually keeping up to date and adds some difficulty in sharing such
updates across remotes.


