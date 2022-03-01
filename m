Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F08C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiCATxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiCATxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:53:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA2593B6
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164330; x=1677700330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zSNlluzdMHMjC3336GgQIbPnm/KN/TrPeMyh/Mh20jc=;
  b=DN+seJOZ3K6dWLiVi71BnxU79QY4MxiUvr1j1o22EGqKSHjbGLTksftl
   7YFvPOHN8lxAHR6M3Pr2AsTF7qmTHC5LTobH0tO2k/OTsSjGfxCzxjqZh
   kwOAmYAZRtccyW0IlolPCPnlpYLV0+BwO2l3T1yTFcMVw2WcExvA9bfVH
   ORwTwTPL1tG2llke2/BolPZBAaziKIdSLmMNOxROgwSGUxo8c/RmPmdim
   sarnYrx89Y3c+vDMft4Vg+x4VjochtlZP1KPTzq4WyU23ScTzFGnUiYBd
   jCMdwoHiG48mWTUleTeNePymYxOuBbEPLxsd0/nhMND+nEU9BLvCh0gKT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316441107"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="316441107"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="507922409"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2022 11:52:08 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 11:52:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 11:52:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 11:52:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 11:52:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcSUYBR/mDDCuZo0kj5oxkUMO3OczLCgJEDJgc9hHu3giHDuIDPu2RTqrrmAcJBpYfNbbcYFAL8UKuTuSuAzJIPmTuGJawxVlf6MsWrdJ78z/cu1b87DY42SFE1LUCXkaqMal0ZyGaBNku+nmHlXogjBKn+65+xv4u7HRQEVI6YruwzDJPYPHwCoeUKYTrPnzVc+w374HJgyHruCxmk7B/DRGyTFHnun3M0eRf6Mb/xrw+pmOFXaME1aLZD7ttANwUSJoaQH3WOGj9V9SOCMlcyBKcuKjghG1cqneBczhsysFBaWJse8xaCnGkzbdDRWkk6Fc6yxJdUNSFD5G4zMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSNlluzdMHMjC3336GgQIbPnm/KN/TrPeMyh/Mh20jc=;
 b=JEI3oI8iF6KzbdVBKA7BB8TXsask3SmfQx6AdZilB08fYp/JogcxAfdrUgYztuTR8UBRfzR6QiYtxJ/5kxWiI9lVSLFaRN72EZgKfGom/PakqmbXliEdyqGftNbZfZFjejBfTPGyjCxt/3ihCP83MxEPf8D7AXhakVr3/NTnFzmL0+GN87Pz7MxbdW44OvdP0+OQkzVdSDWo2auq76iZVrvcMoSr2tJxFnFtmwhpN046Bx0YgX90kea6M2dbh1498a0/BHrk9uzyPCd5d5MfEHazGqm4x3azNRKa0BsXKsEBQ0DohFKxjCn+v8i2tH68cW/Z/tVTMm/9xqSdKT7CRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY4PR11MB1272.namprd11.prod.outlook.com (2603:10b6:903:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 19:52:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%9]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 19:52:04 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
CC:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: use generation numbers if available
Thread-Topic: [PATCH] name-rev: use generation numbers if available
Thread-Index: AQHYLO0/kx7y23fqQU2fGaub7n7TLayp0IwVgABL24CAAAc+aoAAfzoAgABO6IA=
Date:   Tue, 1 Mar 2022 19:52:04 +0000
Message-ID: <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com>
 <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
 <xmqqfso2t9cu.fsf@gitster.g>
 <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
In-Reply-To: <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c4d75ac-3c59-43ea-367a-08d9fbbcf5b5
x-ms-traffictypediagnostic: CY4PR11MB1272:EE_
x-microsoft-antispam-prvs: <CY4PR11MB12724C0176B41027863F198ED6029@CY4PR11MB1272.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlCg3AitYyYGMpoKfqhu9PKbU5EBq+piFrJ99f51SK+KXMhvh16EGate4EnoZi/NlNIDeXIERFlixGvU5FG8MnyOVGqt+q049YWyUQXSBweIARyf8rOGLo83Qg6K2zsIBRPy/WycztsDowx/nQDdHmpdEMH+IaTeWDw4Hsv/aYlz2TlNIxvExfYgKq97v4Na1AZF9+W0WrggvfbDNHOaMzIgMtqXm1H1MLwzctVuMhqbyiFLHeOEh/3Z85RvuliZMl+D/XeZxs1JThbs1iUAJnLYCKK8wf4ITSUNMBRwspf9Vr5P6fUvIO7IUwsswnM4kybVshvq4zF/wJl8sx8mBQX4Pi71cnydaN9F5QLErZpbVqHYIARSNHjkjQNBUh31+IYrot+FjHgNp1anhCr+yFn00YW4T9v3kFb3PDDoHlPpb1Lb8BXCGVWV1D2NgYcX+dYxSKqw7/QkDdZSXAYOa9tNvlpoigXOA9lUeGEAczR7jG2t/Hj4ooiAgchgQqopE+mu/m+0WSR8KPmrz/iPmtGISebCKUpR3/xxfN3ZYGx1nN6VyeRY/rN/bb6wjwGTFEdSL+ifBYy1GoPV/Piy4fYx3Z165+wY1xpRNFkTeaLgkDYjeXELTNf04GNFAv/UQn1yQeYX13XYIT0fTjA/qrxZO7yefFZky3/qOg+fuZ7u3/B2dvYYCHbjCsC3eJ35dNiFyWcvdYlS05nDbwYTwY963CViIfZx4J1ZwwElgXnVl3oFnlzJw5ITY+cEngzU6YE8YPHvgzqgdgS3WSJQoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(110136005)(6512007)(53546011)(38100700002)(36756003)(83380400001)(2906002)(5660300002)(66446008)(8676002)(4326008)(76116006)(64756008)(66556008)(122000001)(66946007)(31696002)(66476007)(86362001)(316002)(6486002)(71200400001)(38070700005)(508600001)(82960400001)(186003)(26005)(2616005)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFDTm0wWmc0TXUzZE9ZVHVLU25MMDhnbnhvK3Rwd1JQeE5ad0h0THN6R3hx?=
 =?utf-8?B?QzdNZkZqZ3dVM3VwQ2ttV2ZOaHFMdFJDN2xpN0ZPcW4vTGFFNlZlTUJCSjhF?=
 =?utf-8?B?bFlUTkE3bkdrNkJkUTEreHFvY3lSMjZWRjdQOEJxMWV2UEI3WjJPWEd0U2s1?=
 =?utf-8?B?Nnp4MVN1Rm9HM0pBSEU2Zy91ZEpWUlJsU0VSL2dtVnVPL09oMWx6eldZYmFX?=
 =?utf-8?B?WEw5eUV0d3ZGd2N0N0RVaW1ycUhWQTlaVk1KMWxJM1FuNDFRRzhuUTBvMC9i?=
 =?utf-8?B?YjZzUDk0S3lsaVNHOTRmTXAwVnZtWkpaOERXNmg0NmNhYkZWR3BvWXFnSG0y?=
 =?utf-8?B?SWRFVkxET05TejhLWlRsSGovdzVNR1VsdzFpOWtqRFVyMFREWEZxMmMydlRL?=
 =?utf-8?B?UWJpVjhKZHpjTm5YaEcyRVhhYVJwajhkblZBelVvekVQMDloeU52R2RIUFJV?=
 =?utf-8?B?OGlqMWR1UlQ1RFE2WXJLR21oRFltMzFXVFdiU3ErSzAyRlNoN1kvbTB2V2Zm?=
 =?utf-8?B?cytTSUxNeldiTk42TEtVaTJVNmkwUGVFdmlMcEJzcEdVRWV3b0F4eEZwTnFR?=
 =?utf-8?B?eWZhTHR5aVlVWXY4RTJYbjRGbys0d2RTTjlXc3krajBqTU5GOGpKcURiakZN?=
 =?utf-8?B?VkNTSStFRE9IR3A0QVAzTjhDd3RlVldKSmNRUkRjZ3dNMXRwWTR1VjhXcjRH?=
 =?utf-8?B?Z3QwckJwRjMvUlB0Nk13MXpIS1I2OUNnWHNGMDBMc2hraVR4am1nbWNZMlVT?=
 =?utf-8?B?Q1QwcjExRUEwS1owOUI2LzdvbFd2UDhQaWZFNEQvSkhnSE5Id2pUMzVPcXUz?=
 =?utf-8?B?T1FVQWJzeDQ4OGs2TjlFbkkyUjVCOW41ejhsTjVDRVVQUnhHQ2cwQS9OU0lL?=
 =?utf-8?B?anpEVlFjUDBUSVhYM3dvRnBYenhKMlVocUN3Q05PL0VLV1BQYjY5YlFaZ0tx?=
 =?utf-8?B?alEzakI0OWpzZ29Ba3JuQ1FJdkF6OXc2eGlLbXM1MDhtZGRBZGxCQ2wrMmI4?=
 =?utf-8?B?MzdpYm9TQXY0cUhvTFprQUZ6TVlCNEVNZG1qOHhORHZIMnF3VVdLU3lqYnVk?=
 =?utf-8?B?T05SY1BJTmxDaFhQaTRJS3J0WmpGWW04TllOb3hUdEZkSjBLK0FZYmZyZTJk?=
 =?utf-8?B?Q3l2SkFlYXBpTmd0QVVQNnlDSkhyNXpLRENrTlVIbmt1M1ZaaE85b0RYUkFt?=
 =?utf-8?B?SUpwTHdPSUJ6UkFWZmhzcVNKY3Z0UHVSYytDSk1qa0hRWVlmQU1adVRiVDFQ?=
 =?utf-8?B?Ukxvd1kwb2tMQmtNcFBwUWQvTVZaYmtaRW9NbXZHREZIVDFJd25HdHNNZDhN?=
 =?utf-8?B?Z1lhMmwxVkttRHAxREt2U2puQlJuOXhQOFdybFo1QUo4TklHMkU2T0xabzVn?=
 =?utf-8?B?SEVzR1pyWmpGL2R4YzA3L296NEVmdGZrUUUrWW93aUdVMEQ0MVgyZ2dHVnVj?=
 =?utf-8?B?VU0yd2psMFZGb1pCNkFjZVZvT3lha0w0MkR6bjg5eVpuOE5HYTgwZi84Z1R1?=
 =?utf-8?B?Nm9LOE9icWo2U3RKd2o2bU82TlQrZkNuQ2dVQ284VENpTDErZWRESzFhVCsz?=
 =?utf-8?B?TUxQbXBabUpHWkE4T2VuMzlmazBUZUtsZ1VrMTY4OVY5N3BqQ0VjajREb1Zs?=
 =?utf-8?B?WUN1SjlkZ04wMUZMeXZkcDNXZTIxd1Z1UHBGYTVGUnZzR1ppZTlrNjdtZkps?=
 =?utf-8?B?ODNkb0lWTFpRN05DOExqTHZRVFBFUkJvaTV2a1JqZkxvRFJYdjJ0dTVaa0pW?=
 =?utf-8?B?TmN2NlZDc0I1czJYcERPOThxeHA2SmNGenpodG9vdjFCYmd2T0g4OGlXNTN3?=
 =?utf-8?B?VnRaZmZ1REQzOXBweXZGZFhRb1U3ZFdIOXNuMkltais4anR5NjFIUmUrQ0t0?=
 =?utf-8?B?S3hCRHpkZzZYd3lzZHg5U0tyQjc1WkhBcXBoZ2ZxcGh5VmYzTGlEWGV5Rko3?=
 =?utf-8?B?dnFSSUgyTmZ6eEtFVmVTWlJFYjZPVlIzekJBYWlwT0lUMUdSdDh2Nmg3cXlQ?=
 =?utf-8?B?NUQ3NWthay94ZTBIQWNTSVRsR1B2allwMzV2VHJTNjAyaXJDczlGdktyaE9z?=
 =?utf-8?B?ak9GbmZ1dHhyemEwSmYwSzdCWDF5NWFSRnRqMXgrNnRsZjBqaFE4OFpVcWNm?=
 =?utf-8?B?OXRrQ2Q2RlhvWVE3QkhyN1FtL2VsUEpEQkJhamRWM2FzVGpCMjJULzZNNW5x?=
 =?utf-8?B?MjdMT2NEanBWWmoreWhzUXBhU2d6Ri9OaC9tcmVHTTRrMi9vMW5vRGVrVFZJ?=
 =?utf-8?B?ZndMbEdRSkZlbzVDM3g1M0IwWklnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1D22B07841C25439299BD8DC3108229@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4d75ac-3c59-43ea-367a-08d9fbbcf5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 19:52:04.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzUmBzq8nXoOM6u8DoA/PBXt908gkPZnyXjUEIHwaQB/wVHtI9qYbD13c8GGVVmlwiEHdmJZhhAJPfxRQKJPp3VHmUXs3BO+0/2TsAQ8c1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1272
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMy8xLzIwMjIgNzowOSBBTSwgRGVycmljayBTdG9sZWUgd3JvdGU6DQo+IE9uIDMvMS8yMDIy
IDI6MzMgQU0sIEp1bmlvIEMgSGFtYW5vIHdyb3RlOg0KPj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5r
ZWxsZXJAZ21haWwuY29tPiB3cml0ZXM6DQo+Pg0KPj4+IE9uIE1vbiwgRmViIDI4LCAyMDIyIGF0
IDY6MzYgUE0gSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToNCj4+Pj4N
Cj4+Pj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4+
Pj4NCj4+Pj4+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICduYW1lLXJldiB3aXRob3V0IGNvbW1pdEdy
YXBoIGRvZXMgbm90IGhhbmRsZSBub24tbW9ub3RvbmljIHRpbWVzdGFtcHMnICcNCj4+Pj4+ICsg
ICAgIHRlc3RfY29uZmlnIC1DIG5vbi1tb25vdG9uaWMgY29yZS5jb21taXRHcmFwaCBmYWxzZSAm
Jg0KPj4+Pj4gKyAgICAgKA0KPj4+Pj4gKyAgICAgICAgICAgICBjZCBub24tbW9ub3RvbmljICYm
DQo+Pj4+PiArDQo+Pj4+PiArICAgICAgICAgICAgIHJtIC1yZiAuZ2l0L2luZm8vY29tbWl0LWdy
YXBoKiAmJg0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgICAgICAgICBlY2hvICJtYWlufjMgdW5kZWZp
bmVkIiA+ZXhwZWN0ICYmDQo+Pj4+PiArICAgICAgICAgICAgIGdpdCBuYW1lLXJldiAtLXRhZ3Mg
bWFpbn4zID5hY3R1YWwgJiYNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAgICAgICAgdGVzdF9jbXAg
ZXhwZWN0IGFjdHVhbA0KPj4+Pj4gKyAgICAgKQ0KPj4+Pj4gKycNCj4+Pj4NCj4+Pj4gSSBkb3Vi
dCBpdCBpcyB3aXNlIHRvICJ0ZXN0IiB0aGF0IGEgcHJvZ3JhbSBkb2VzIF9ub3RfIHByb2R1Y2Ug
YQ0KPj4+PiBjb3JyZWN0IG91dHB1dCwgb3IgZXZlbiB3b3JzZSwgaXQgcHJvZHVjZXMgYSBwYXJ0
aWN1bGFyIHdyb25nDQo+Pj4+IG91dHB1dC4gIFRoaXMgdGVzdCwgZm9yIGV4YW1wbGUsIGNhc3Rz
IGluIHN0b25lIHRoYXQgYW55IGZ1dHVyZQ0KPj4+PiBvcHRpbWl6YXRpb24gdGhhdCBkb2VzIG5v
dCBkZXBlbmQgb24gdGhlIGNvbW1pdC1ncmFwaCBpcyBmb3JldmVyDQo+Pj4+IHByb2hpYml0ZWQu
DQo+Pj4+DQo+Pj4+IEp1c3QgZHJvcHBpbmcgdGhlIHRlc3Qgd291bGQgYmUgZmluZSwgSSB3b3Vs
ZCB0aGluay4NCj4+Pg0KPj4+IFN0b2xlZSBtZW50aW9uZWQgaXQuIFdlIGNvdWxkIGFsc28gY29u
dmVydCBpdCB0byBhDQo+Pj4gInRlc3RfZXhwZWN0X2ZhaWx1cmUiIHdpdGggdGhlIGV4cGVjdGVk
IG91dHB1dCB0b28uLi4gQnV0IHRoYXQgbWFrZXMNCj4+PiBpdCBsb29rIGxpa2Ugc29tZXRoaW5n
IHdlJ2xsIGZpeA0KPj4NCj4+IE5laXRoZXIgc291bmRzIGxpa2UgYSBnb29kIGlkZWEgYW55d2F5
LiAgV2hhdCB3ZSBjYXJlIG1vc3QgaXMgd2l0aA0KPj4gY29tbWl0IGdyYXBoLCB0aGUgYWxnb3Jp
dGhtIHdpbGwgbm90IGJlIGZvb2xlZCBieSBza2V3ZWQgdGltZXN0YW1wcy4NCj4gDQo+IEknbSBm
aW5lIHdpdGggbG9zaW5nIHRoaXMgdGVzdC4NCj4gDQo+IEkgcGVyaGFwcyBsZWFuIHRvbyBoYXJk
IG9uICJ0ZXN0cyBzaG91bGQgZG9jdW1lbnQgY3VycmVudCBiZWhhdmlvciINCj4gc28gd2Uga25v
dyB3aGVuIHdlIGFyZSBjaGFuZ2luZyBiZWhhdmlvciwgYW5kIHRoZSBjb21taXQgY2FuIGp1c3Rp
ZnkNCj4gdGhhdCBjaGFuZ2UuIEZvciB0aGlzIG9uZSwgd2UgYXJlIHJlYWxseSBkb2N1bWVudGlu
ZyB0aGF0IHdlIGhhdmUNCj4gYW4gb3B0aW1pemF0aW9uIHRoYXQgZG9lc24ndCB3YWxrIGFsbCBj
b21taXRzIGJhc2VkIG9uIHRoZSBkYXRlIG9mDQo+IHRoZSB0YXJnZXQgY29tbWl0LiBJZiB3ZSBk
cm9wcGVkIHRoYXQgb3B0aW1pemF0aW9uIGFjY2lkZW50YWxseSwNCj4gdGhlbiB3ZSBoYXZlIG5v
IHRlc3Qgc28gZmFyIHRoYXQgdmVyaWZpZXMgdGhhdCB3ZSBkb24ndCB3YWxrIHRoZQ0KPiBlbnRp
cmUgY29tbWl0IGhpc3Rvcnkgd2l0aCB0aGVzZSBuYW1lLXJldiBxdWVyaWVzLg0KPiANCg0KSSB0
aGluayB0aGUgInRlc3RzIHNob3VsZCBkb2N1bWVudCBjdXJyZW50IGJlaGF2aW9yIiBpcyBoYW5k
bGVkIGJ5IHRoZQ0KZmFjdCB0aGF0IHRoaXMgc3BlY2lmaWMgdGVzdCBmYWlscyBpZiB5b3UgcmV2
ZXJ0IHRoZSBuYW1lLXJldiBjaGFuZ2VzDQpidXQga2VlcCB0aGUgdGVzdC4NCg0KPiBJZiB0aGVy
ZSBpcyB2YWx1ZSBpbiBkb2N1bWVudGluZyB0aGF0IG9wdGltaXphdGlvbiwgdGhlbiBhDQo+IGNv
bW1lbnQgYmVmb3JlIHRoZSB0ZXN0IGNvdWxkIGRlc2NyaWJlIHRoYXQgdGhlIG91dHB1dCBpcyBu
b3QNCj4gZGVzaXJhYmxlLCBidXQgaXQncyBkdWUgdG8gYW4gb3B0aW1pemF0aW9uIHRoYXQgd2Ug
d2FudCB0byBrZWVwIGluDQo+IHBsYWNlLg0KPiANCj4gVGhhbmtzLA0KPiAtU3RvbGVlDQoNCldo
YXQgYWJvdXQgYSB0ZXN0IHdoaWNoIHVzZXMgc29tZXRoaW5nIGxpa2UgdGhlIHRyYWNlIHN5c3Rl
bSB0byBsaXN0IGFsbA0KdGhlIGNvbW1pdHMgaXQgY2hlY2tlZD8gSSBndWVzcyB0aGF0IG1pZ2h0
IGdldCBhIGJpdCBtZXNzeSBidXQgdGhhdA0KY291bGQgYmUgdXNlZCB0byBjb3ZlciB0aGUgInRo
aXMgb3B0aW1pemF0aW9uIGlzIGltcG9ydGFudCIgYW5kIHRoYXQNCmFwcGxpZXMgdG8gdGhlIGNv
bW1pdCBncmFwaCBpbXBsZW1lbnRhdGlvbiByYXRoZXIgdGhhbiBrZWVwaW5nIGENCm5lZ2F0aXZl
IHRlc3Qgb2YgdGhlIG90aGVyIGltcGxlbWVudGF0aW9uLg0KDQpUaGFua3MsDQpKYWtlDQoNCg==
