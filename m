Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F7C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 20:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiB1VAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiB1VAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 16:00:01 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E7B36B60
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646081960; x=1677617960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pgA6uSFXSqcWgyHgv6h+IiFn1LxgG6rssQKlivn6JmY=;
  b=O2wBU3rmK1as5nmcG6wqTa7WoTiLCUO++Y2M+ajFsYdR0u2Hre4Uk5h7
   Vyw2zJ1cJ0gWKIUa4njdDy1kTIFtQKBmivJTHHpEZ27k/xwWzv7VtCkm8
   K894R7ysVbcwgZ2h5B5aeuBtf49d/Tr6/X5EVkOv0y1cutPaePdfbWpN0
   NTkTa+mVVNLLBu9Q7GFZc214ze3AICBc5Z6Ci+cCyHoELOgIpbrSWEMFG
   W5ptK2pwgGo5Q2T0hycKjpQrbtORSLRRbFa5c/oKYTv+kmGY5dKDzFtl0
   kSiszX8giZC2NxKNvNmMba8P0Sex86EvVkzk27grVXlYk7t7NwQ1XU2sG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313707147"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="313707147"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 12:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="534618765"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 12:59:20 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 12:59:20 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 12:59:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 12:59:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 12:59:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Mnyyns++t6ge57I04mwxJNq+yBn5pjUwHp0R/9w5Ye6o1wdMtJ750HyeLTpIO7sNX1ExsE2gcPrdFwewsDBFyld9FMfpNm3Lrzqc/Qo8zUtQX4fHfPGs+yj9TUpIWJjXhdQZIrwz/J6rywIU87+GtcV6mWXM5v9CqeOJtO8hAzGZyI/hYRplYdBuR/3n9uo48H2Z/kS32xqqPD44ADpkoKklaRvrUAphnVPMc4wF0XWpB59P+1RZCQWAPPE+lXturcunGjElZoJV/LF/3jWH6w0u6AN3YikYXXB+T5BpdwEDn6gW0CXq53VxwQqFBm0R2NodZeclpL5NGIsPHYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgA6uSFXSqcWgyHgv6h+IiFn1LxgG6rssQKlivn6JmY=;
 b=YJGNF8LUu5IczkbGdchGUS8hfTws9+l0+7mlq45iR6bQCwN8nsi8CPGJE8hllpEEaU5iPd1SLdbdRsUaMx+JPRALzhs8d9H4uWV9+pKbcPfQAZmCOgPWhHca0QoL9AdTsJGB3dUgTKLFZEUWoV/oXQy4XwYDhzL9mQr967D9slsCPBOKyH0S6k3W1IOje9dkddkU7ndPhzKkzhOuhHfXxuEHDcxqkDsPP3eUhjV+GhmRNxg9ZvJFooMPngeX93AiTya5P/Dnl9J31pJrMoB3mt0qeZarbwO5ymf0jvoG33TLTqSh1odoREJhc5tPIaOd6tI9/oMMREBg6CdGaueKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN7PR11MB2834.namprd11.prod.outlook.com (2603:10b6:406:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 20:59:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%8]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 20:59:16 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: RE: [PATCH] name-rev: use generation numbers if available
Thread-Topic: [PATCH] name-rev: use generation numbers if available
Thread-Index: AQHYLNaLAupeX18OMUy98LsJRMPl56ypX1GAgAAIK4CAAAEzAIAACa4A
Date:   Mon, 28 Feb 2022 20:59:16 +0000
Message-ID: <CO1PR11MB508965B6F5F4A4B8D45649BFD6019@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220228190738.2112503-1-jacob.e.keller@intel.com>
 <e4096124-e566-0842-f17c-366645c3e37c@github.com>
 <15ce47f3-a726-75d1-3d3d-869331b24230@intel.com>
 <117ed093-f3e0-ba24-2364-74e43a1306fe@github.com>
In-Reply-To: <117ed093-f3e0-ba24-2364-74e43a1306fe@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68e021e1-7200-45d7-b54e-08d9fafd2ed9
x-ms-traffictypediagnostic: BN7PR11MB2834:EE_
x-microsoft-antispam-prvs: <BN7PR11MB28340868ED0627B05EAB7F10D6019@BN7PR11MB2834.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mumvz37UfqNwifYE1Mf8hR3IKRCZ6gCf7zyo6mcLpl4VNuyU5cW11XQfNj6QbM0u0vadx5FU8SOTr/aejfx6S9GuFDUUCY3nRSiqDebFp7O2MRqkbLN5hhu/qCab/9tZi/cRp24zuFOqCo4092tEgl0GfilzanX3HF6U+M9gm27t2K8MaBJ/vKjL72IOY9IjYOS8zYnrcodDyYdaUaSQ3iyLYVGM0pyB7z+uolmyPFRJFdO0+9XP1xpb6yWgJmzA/7YCkB8PEXLfr/gRW8NpcHfAEVKfSduql9/9KIR+fxVv0LCH19eoeahkRDUfwulxMReYD63ZkJ4uA8yZq1Mvat0uQYgWx6B3OTeUg1Acod3U5tILhB+vdFlsk0DKbggbbyMtPgTvxqNdsYxHQsrY4V/EOb+vZxzbPa11jqLEuh4483H6vL6hXBxb72E3MpgBrWFGUXCfxwARLHruAJslzrg4Zd38AckU8360pi5rvSwNB00ey5KtXqChWqMr/aLHgP3huuVYMgcYr12nhSsTha7yU/MWZlNwPr+orh6Fk70+9J5NiI6OfD6T9eIedasd5JT+C1Ja+2q8adi5HtQIqlQ7SXviCPAT5OHpcL/ZH1bNf53+VH8aZw2zriRjR8EaHdRqXslNjuHwEVb05T29B2gdz3FBZ3C75qCPOL9qdog5JM/EbyZ8JnyfyPK+ZrMp2fczLsYw5RC58yoy8ddntw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(5660300002)(8936002)(52536014)(122000001)(2906002)(66476007)(64756008)(66946007)(66556008)(8676002)(66446008)(76116006)(55016003)(38070700005)(86362001)(33656002)(38100700002)(82960400001)(316002)(186003)(26005)(83380400001)(508600001)(54906003)(110136005)(53546011)(6506007)(7696005)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFrN3RCSngzSnY5OG1GK2JYTkNtT2FTMmhqT2JUWnZFY0M4VGo0RmtiSGxM?=
 =?utf-8?B?UkY1bTh0cnpIT0V2bmdXUDRXQTNMZk9LSmpRZGMvdGdSTW5QTitEUWo3WlhY?=
 =?utf-8?B?R0FlNjMva2FtcTZKQXBhQnNoWTFzaDJMS2RkNkJYdHdTZDNOdytPNUNCakZw?=
 =?utf-8?B?YjRNa2FEK09wNE1vYVNMeXRGT2hrM01JVnFxdXR3dkFRM3Z1dStqZmsyWm4x?=
 =?utf-8?B?S0V1N0czUE9venJpYzEvMmMzbGJVOWQzMkl6alFMRjF1VEd5Sk1Ob1pFeTcz?=
 =?utf-8?B?a3piYTZ4eFR4Nm1tWHgwZXU0KzY4bmlqVTZSUUlpRVJ6RXNNR0FPamVLdzZk?=
 =?utf-8?B?aVg2Y0Ficy9DTGdYRDRHMmsza080NnVxckZEaEhZakVLblNQVVlzVnZ6M1Vx?=
 =?utf-8?B?Sks0ZnFyc1VMUFplZ054ZitYeUUrR2dqamtERmwyRzZOeC94RktDZVFGaXJI?=
 =?utf-8?B?d1pBV0RhM3A4Ui9EZXBkWnlPb0U4ejVETDNnOHM5WldxNWVUZFArOXh0N0Jo?=
 =?utf-8?B?MUxDSWdBUEkwQ0lUcHk0SnNrVWNtbkpaRGFNSHZQVTM0MmcyWkRIYm11OWZy?=
 =?utf-8?B?SXVaVURGaHlLSisyMG53OUszemZVb3p3bEVzTG1raUd2cjF5OFBoVjhzWjFj?=
 =?utf-8?B?VVBHVHlzWDl5V3E1RzhDZnRJSUxNbmJXcC80b2ZzeDQ4THVvd3pCcTZtdHM2?=
 =?utf-8?B?OEtvYU9tMWNwNVR3VDBpaEZ3c0tRcHhSTmJ3NUY1ellCVGFIRmxJTXFrV3Zw?=
 =?utf-8?B?cWU4TE5JYW4wbzVDMmExMjFUMzR1dFRqOWNIeHJSdlovbjBBRi9hdGRWS2xF?=
 =?utf-8?B?MmUxdmN2N0ZXRVZ3QWgrdXZ3YjVFNWlVdW1tRDJDd2dBNkkxeDdjZzlvQTNr?=
 =?utf-8?B?MVREWlowcVZrLzAwRE12aUp0UG83YUFMcjVheVcvUmJlbXNjNkV2UkxlbURI?=
 =?utf-8?B?cXBxMkVyd0Z6NE1XSkpadThZelo0ZXZ3U0RRL3R4clZjL2U1NTRJdXlzSDVr?=
 =?utf-8?B?U21ScmM3dGU0T2FZVm9ucDFOSE9yc3EveWVvS2t3eGJPZHRmay9tQU5LcXBM?=
 =?utf-8?B?Nks0QlNuQ045R0dLb0c0bURGS213NmRWZmhFQTcrUzl5SkpYdHh4ZmxaWEdG?=
 =?utf-8?B?MlE4cUFnOWZDa3VSS0pwV2FJdHpjNUN0d1kwYnBDUDB3UGlhQmhYZGJ2TkJB?=
 =?utf-8?B?dUpJaWJQa0xEK3ZDQko2dDdTNTk5QXE4Ni9POGlOSy9QNWpIei90TzExSE5N?=
 =?utf-8?B?SE5uclBEbUhzaEhLVFYrTENQL1dUQzlKSWE0TFJOdDV5MndySmVvY01LSlpn?=
 =?utf-8?B?aU1uZkhFbEN2YXNoR2lvbXRIcHRaTnBGR2tHSlJyNWg3SG8vZXZuc1AwUWpH?=
 =?utf-8?B?NHR2UkdYa2VSMVYzSHlNSzhLYXptSExqRjAvaW5ndjRFM0t0eEtxZlJuR011?=
 =?utf-8?B?Y3E2VDdkWHA2NldPa3grbTE3bTV0WUdRZEc4Q2s3dEJyamRUZFFJUkxVdW1H?=
 =?utf-8?B?UDliT0gyWWpxRWg1MEw1dEZFbDFlQm5xc2xhYlBoa09RN3hCMTZoVG42L3M0?=
 =?utf-8?B?R2ZKMlpsSWIwMzB1eEczQzNBVzNSVFJCVWdjdWpkTzREVGFTQUNPd28vU3Jl?=
 =?utf-8?B?SW9HdEhZYkFObVhTbHVmNUJrWmIrZExVNUlvT011Z01nN2dZM1MvSmdTdUU2?=
 =?utf-8?B?dUxXamFPdEQ0aHhWR09zeDVpVTE4aEFmVzd6WEZlY3UweG9GWHdJZ0dmWjBQ?=
 =?utf-8?B?c0NWZzJRbWljMlh0MGpLMmEvMmt3WHpkcjBHelp6NWNCWGVlYVZSVHFwb00z?=
 =?utf-8?B?WHFaaWkvYTVYbW1ZOEhDK3FZSEtUNGd1MllhdHBzMUhQYW9yNzFEeXFDUWdT?=
 =?utf-8?B?SmpEWWZjZUFZYjdZUDhFUEVKZXIrV1NTV2pkM2kyY3EvdE4zS0JhbnVZRTY2?=
 =?utf-8?B?aG95NVIvaW5vdkt4L0pHcGRJbnZXUW5kM0FSY2VnaUFnbktPd1NtK1llK0x1?=
 =?utf-8?B?b1pydldoa1lXQndLUldOdk1jd3lxL2FDeEIybGVUU3BLVGJxN2FQSEI2WXpX?=
 =?utf-8?B?R2hiamZZRXdoRnJNSkhmUFl2a2hiaEx4dzNYQ3RhY0FHVldxV3MyczcxZlE2?=
 =?utf-8?B?QnZ3M09SK3QvYzl5dmVOMVIrem9ndEVEa2dzR0FTNmpTOHE3Q1lMN3VaSzF4?=
 =?utf-8?B?cXRwbmU2T1hKOVJ1Nk5XRXJBdG5DTzhubks1N0U1VElQMTNNS1dKRnZIRGFk?=
 =?utf-8?B?QnV1ckFBUGNOelVhajFIYXdnZUd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e021e1-7200-45d7-b54e-08d9fafd2ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 20:59:16.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNCndL+d5cxlJqNNyPtPA1wfL12S1W0vYJbiLntSnM8271kXEhKQ048QTTinH4ECxFgTwfbGKJXomdvmxtSZOGFBlM4hePE48mpwhxc43f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2834
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVycmljayBTdG9sZWUg
PGRlcnJpY2tzdG9sZWVAZ2l0aHViLmNvbT4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyOCwg
MjAyMiAxMjoyNCBQTQ0KPiBUbzogS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRl
bC5jb20+OyBnaXRAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+OyBKYWNvYiBLZWxsZXINCj4gPGphY29iLmtlbGxlckBnbWFpbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5hbWUtcmV2OiB1c2UgZ2VuZXJhdGlvbiBudW1iZXJzIGlm
IGF2YWlsYWJsZQ0KPiANCj4gT24gMi8yOC8yMDIyIDM6MjAgUE0sIEtlbGxlciwgSmFjb2IgRSB3
cm90ZToNCj4gPiBPbiAyLzI4LzIwMjIgMTE6NTAgQU0sIERlcnJpY2sgU3RvbGVlIHdyb3RlOg0K
PiA+PiBPbiAyLzI4LzIwMjIgMjowNyBQTSwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KPiA+Pj4gRnJv
bTogSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPg0KPiA+Pj4gKy8qIENoZWNr
IGlmIGEgY29tbWl0IGlzIGJlZm9yZSB0aGUgY3V0b2ZmLiBQcmlvcml0aXplIGdlbmVyYXRpb24g
bnVtYmVycw0KPiA+Pj4gKyAqIGZpcnN0LCBidXQgdXNlIHRoZSBjb21taXQgdGltZXN0YW1wIGlm
IHdlIGxhY2sgZ2VuZXJhdGlvbiBkYXRhLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gK3N0YXRpYyBpbnQg
Y29tbWl0X2lzX2JlZm9yZV9jdXRvZmYoc3RydWN0IGNvbW1pdCAqY29tbWl0KQ0KPiA+Pj4gK3sN
Cj4gPj4+ICsJaWYgKGdlbmVyYXRpb25fY3V0b2ZmIDwgR0VORVJBVElPTl9OVU1CRVJfSU5GSU5J
VFkpDQo+ID4+PiArCQlyZXR1cm4gY29tbWl0X2dyYXBoX2dlbmVyYXRpb24oY29tbWl0KSA8IGdl
bmVyYXRpb25fY3V0b2ZmOw0KPiA+Pj4gKw0KPiA+Pj4gKwlyZXR1cm4gY29tbWl0LT5kYXRlIDwg
Y3V0b2ZmOw0KPiA+Pj4gK30NCj4gPj4NCj4gPj4gVGhlcmUgYXJlIHR3byBzdWJ0bGUgdGhpbmdz
IGdvaW5nIG9uIGhlcmUgd2hlbiBnZW5lcmF0aW9uX2N1dG9mZiBpcw0KPiA+PiB6ZXJvOg0KPiA+
Pg0KPiA+PiAxLiBJbiBhIGNvbW1pdC1ncmFwaCB3aXRoIHRvcG9sb2dpY2FsIGxldmVscyBfb3Jf
IGdlbmVyYXRpb24gbnVtYmVycyB2MiwNCj4gPj4gICAgY29tbWl0X2dyYXBoX2dlbmVyYXRpb24o
Y29tbWl0KSB3aWxsIGFsd2F5cyBiZSBwb3NpdGl2ZSwgc28gd2UgZG9uJ3QNCj4gPj4gICAgbmVl
ZCB0byBkbyB0aGUgbG9va3VwLg0KPiA+DQo+ID4gSS5lLiBvbmNlIHdlIGhhdmUgYSBnZW5lcmF0
aW9uX2N1dG9mZiBvZiAwIHdlIGNhbiBqdXN0IGNvbXBsZXRlbHkgYnlwYXNzDQo+ID4gdGhlIGxv
b2t1cCwgc2F2aW5nIHNvbWUgdGltZS4NCj4gPg0KPiA+IEkgdGhpbmsgd2UgY2FuIGRvICJyZXR1
cm4gZ2VuZXJhdGlvbl9jdXRvZmYgJiYNCj4gPiBjb21taXRfZ3JhcGhfZ2VuZXJhdGlvbihjb21t
aXQpIDwgZ2VuZXJhdGlvbl9jdXRvZmYiDQo+ID4NCj4gPj4NCj4gPj4gMi4gSWYgdGhlIGNvbW1p
dC1ncmFwaCB3YXMgd3JpdHRlbiBieSBhbiBvbGRlciBHaXQgdmVyc2lvbiBiZWZvcmUNCj4gPj4g
ICAgdG9wb2xvZ2ljYWwgbGV2ZWxzIHdlcmUgaW1wbGVtZW50ZWQsIHRoZW4gdGhlIGdlbmVyYXRp
b24gb2YgY29tbWl0cw0KPiA+PiAgICBpbiB0aGUgY29tbWl0LWdyYXBoIGFyZSBhbGwgemVybygh
KS4gVGhpcyBtZWFucyB0aGF0IHRoZSBsb2dpYyBoZXJlDQo+ID4+ICAgIHdvdWxkIGJlIGluY29y
cmVjdCBmb3IgdGhlICJhbGwiIGNhc2UuDQo+ID4+DQo+ID4+IFRoZSBmaXggZm9yIGJvdGggY2Fz
ZXMgaXMgdG8gcmV0dXJuIDEgaWYgZ2VuZXJhdGlvbl9jdXRvZmYgaXMgemVybzoNCj4gPj4NCj4g
Pg0KPiA+IEkgdGhpbmsgeW91IG1lYW4gcmV0dXJuIDA/IEJlY2F1c2UgdGhpcyByZXR1cm5zIHRy
dWUgaWYgdGhlIGNvbW1pdCBpcw0KPiA+IGJlZm9yZSB0aGUgY3V0b2ZmLCBidXQgZmFsc2UgaWYg
aXRzIG5vdC4gKGkuZS4gaWYgaXRzIHRydWUsIHdlIHNob3VsZA0KPiA+IHN0b3Agc2VhcmNoaW5n
IHRoaXMgY29tbWl0LCBidXQgaWYgaXRzIGZhbHNlIHdlIHNob3VsZCBjb250aW51ZSBzZWFyY2hp
bmc/DQo+IA0KPiBZZXMsIHNvcnJ5IEkgaGFkIGl0IG1peGVkIHVwLiBZb3VyIGdlbmVyYXRpb25f
Y3V0b2ZmICYmIC4uLiBhcHByb2FjaA0KPiB3aWxsIHdvcmsgaW4gdGhhdCBjYXNlLg0KPiANCg0K
QWxyaWdodC4gV2lsbCBmaXggdGhhdCBmb3IgdjIuDQoNCj4gPj4+ICt0ZXN0X2V4cGVjdF9zdWNj
ZXNzICduYW1lLXJldiAtLWFsbCB3b3JrcyB3aXRoIG5vbi1tb25vdG9uaWMnICcNCj4gPj4NCj4g
Pj4gVGhpcyBpcyB3b3JraW5nIGJlY2F1c2Ugb2YgdGhlIGNvbW1pdC1ncmFwaCwgcmlnaHQ/IFdl
IHN0aWxsIGhhdmUNCj4gPj4gaXQgZnJvbSB0aGUgcHJldmlvdXMgdGVzdCwgc28gd2UgYXJlbid0
IHRlc3RpbmcgdGhhdCB0aGlzIHdvcmtzDQo+ID4+IHdoZW4gd2Ugb25seSBoYXZlIHRoZSBjb21t
aXQgZGF0ZSBhcyBhIGN1dG9mZi4NCj4gPj4NCj4gPg0KPiA+IEkgY2FuIGVpdGhlciBleHRlbmQg
dGhpcyB0ZXN0IG9yIGFkZCBhIHNlcGFyYXRlIHRlc3Qgd2hpY2ggY292ZXJzIHRoaXMuDQo+ID4g
VGhlIHRlc3QgZmFpbGVkIGJlZm9yZSBJIGFkZGVkIHRoZSBjb21taXQgZ3JhcGggbGluZS4NCj4g
Pg0KPiA+Pj4gKwkoDQo+ID4+PiArCQljZCBub24tbW9ub3RvbmljICYmDQo+ID4+PiArDQo+ID4+
PiArCQljYXQgPmV4cGVjdCA8PC1cRU9GICYmDQo+ID4+PiArCQlFDQo+ID4+PiArCQlEDQo+ID4+
PiArCQlEfjENCj4gPj4+ICsJCUR+Mg0KPiA+Pj4gKwkJQQ0KPiA+Pj4gKwkJRU9GDQo+ID4+PiAr
DQo+ID4+PiArCQlnaXQgbG9nIC0tcHJldHR5PSVIID5yZXZzICYmDQo+ID4+PiArCQlnaXQgbmFt
ZS1yZXYgLS10YWdzIC0tYW5ub3RhdGUtc3RkaW4gLS1uYW1lLW9ubHkgPHJldnMgPmFjdHVhbA0K
PiAmJg0KPiA+Pj4gKw0KPiA+Pj4gKwkJdGVzdF9jbXAgZXhwZWN0IGFjdHVhbA0KPiA+Pj4gKwkp
DQo+ID4+DQo+ID4+IERvIHlvdSB3YW50IHRvIGluY2x1ZGUgYSB0ZXN0IHNob3dpbmcgdGhlICJl
eHBlY3RlZCIgYmVoYXZpb3INCj4gPj4gd2hlbiB0aGVyZSBpc24ndCBhIGNvbW1pdC1ncmFwaCBm
aWxlPyBZb3UgbWlnaHQgbmVlZCB0byBkZWxldGUNCj4gPj4gYW4gZXhpc3RpbmcgY29tbWl0LWdy
YXBoIChpdCB3aWxsIGV4aXN0IGluIHRoZSBjYXNlIG9mDQo+ID4+IEdJVF9URVNUX0NPTU1JVF9H
UkFQSD0xKS4NCj4gPj4NCj4gPg0KPiA+IFRoaXMgdGVzdCBhY3R1YWxseSBpcyBpbnRlbmRlZCB0
byBzaG93IHRoYXQgaXQgd29ya3MgcmVnYXJkbGVzcyBvZg0KPiA+IHdoZXRoZXIgd2UgaGF2ZSBh
IGNvbW1pdCBncmFwaC4gKEJlY2F1c2UgaW4gLS1hbm5vdGF0ZS1zdGRpbiBtb2RlIHdlDQo+ID4g
ZGlzYWJsZSB0aGUgaGV1cmlzdGljIHNpbmNlIHdlIGRvbid0IGtub3cgd2hhdCBjb21taXRzIHdl
J2xsIHNlZSBpbiBhZHZhbmNlKQ0KPiA+DQo+ID4gSXMgdGhlcmUgYSBnb29kIHdheSB0byBkZWxl
dGUgdGhlIGdyYXBoIGZpbGU/DQo+IA0KPiBUaGUgYmFzaWMgd2F5IGlzICJybSAtcmYgLmdpdC9p
bmZvL2NvbW1pdC1ncmFwaCoiIHRvIGJlIGFic29sdXRlbHkNCj4gc3VyZSAodGhlcmUgbWlnaHQg
YmUgYW4gaW5jcmVtZW50YWwgY29tbWl0LWdyYXBoIHdoaWNoIGFwcGVhcnMgYXMNCj4gYSAiY29t
bWl0LWdyYXBocyIgZGlyZWN0b3J5KS4NCj4gDQo+ID4+IEkgYWxzbyBzZWUgdGhhdCB5b3UgaW50
ZW5kZWQgdG8gdGVzdCB0aGUgIi0tYWxsIiBvcHRpb24sIHdoaWNoDQo+ID4+IGlzIG5vdCBpbmNs
dWRlZCBpbiB5b3VyIHRlc3QuIFRoYXQncyBwcm9iYWJseSB0aGUgcmVhbCBrZXkgdG8NCj4gPj4g
Z2V0dGluZyB0aGlzIHRlc3QgdG8gd29yayBjb3JyZWN0bHkuIERlbGV0aW5nIHRoZSBncmFwaCB3
aWxsDQo+ID4+IHByb2JhYmx5IGNhdXNlIGEgZmFpbHVyZSBvbiB0aGlzIHRlc3QgdW5sZXNzICIt
LWFsbCIgaXMgYWRkZWQuDQo+ID4+DQo+ID4NCj4gPiBBY3R1YWxseSBib3RoIC0tYWxsIGFuZCAt
LWFubm90YXRlLXN0ZGluIGRpc2FibGUgdGhlIGhldXJpc3RpYy4gSG93ZXZlciwNCj4gPiBJIHRo
aW5rIGFkZGluZyBhIHRlc3QgZm9yIGJvdGggbWFrZXMgc2Vuc2UuDQo+IA0KPiBBaC4gT0suIFRo
ZXkgY291bGQgYmUgYXNzZXJ0aW9ucyB3aXRoaW4gdGhlIHNhbWUgdGVzdCBzaW5jZSB0aGUNCj4g
b3V0cHV0IGlzIGV4cGVjdGVkIHRvIGJlIHRoZSBzYW1lLg0KPiANCj4gVGhhbmtzLA0KPiAtU3Rv
bGVlDQo=
