Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB540C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGTRB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGTRB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 13:01:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1167CB3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 10:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmOLOzzagyESlraFHi5XQjbhzIi9mfXuckpIN9ylNWsPUCzyT607yJzurVp3ShF9wC+v4xOYD21h3SJONEEeWUKcdNMk1c7OKrlGejf/fETIEP5X60DQSasOQwTmPE5FW6e/ZZ5VVbQYNxXFZNvsTXHvVEkPNFgK/R5TlZ+78S9Yc/Tiz943L11/JBTplglUMGCwIOy6DtRr7FejQ522YJxaiYuyqNyElCxe5TSmrC36SlBYsY3Jxnt824apGV69VC9V70cmR3sn6y5nKTDAZKyBkLiI3F/x+oVAc+WQwcsXmSWaZvFijA7p0Cs0mW3f4RRodCXzgCWK4KPr9kcdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOdVTXwkA4ua1blytVLFfeoNr2HzBmEMA4RiXED9yvI=;
 b=a4oXDPZx16fUPeYxKjm5QwBfwAxADl6s+e/czc+IBFEESTvOg7+SJPk89X80Ag5cHVFTwpu3BtumgZvRB7QIpNk5jloWWTQ6JJKdkV5obg2BvLF3gBLRmTIby2BekoYpJjHF/mZNdkIsOYiD46sVPZoaXv2a+plLGzCa8LMUIQgLbDz2RKcq1BIBZjeP9Gg650EI6j7mMFHXaz/XWquYNgh/pYyrxYZ196qa9dl8ePPbKWU6JhDkjDHUE/LSzdPSn6/8NbxJQufuFVeMtMZheYjO9ZZgJEBAuc7UaH8iyW8thw65OLbXTPD3s459ynj1bWhAh0QUKKuIYjairvCOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOdVTXwkA4ua1blytVLFfeoNr2HzBmEMA4RiXED9yvI=;
 b=WDFdEWmW1D7CQ1vS0uuP53PdPJ6VA/Ae4BjSY2Y0/0wkKJlg64QOzolPQgTr7cFkmyYbEuQu8M9S5O1t8R22mWwyS8l5l20vwJU23BO9IBkPBoImtZ8t4yXqM7Fo+Snmpo2l5jNjBwY2QuEdEGk35wh7DCiaQbeJflNsGjFPbBnNP5bHOinCJu68KS0llGLNqacbFy6I0ldCpd4dm9JP5o554epeb6F7KeMDFQnndxUcnJKgwR4hWhmib1/tzYhwVsg/4xShaww3xb8J9zym8rWyOMWOf6Vpk7FpP5CNWZVO1GrY4S0Gj9taCM/UMT09sTHsgqJhIKLVslA0hH/OSg==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by DB7PR02MB5210.eurprd02.prod.outlook.com (2603:10a6:10:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 17:01:54 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::98a3:f871:a033:7ef7]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::98a3:f871:a033:7ef7%3]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 17:01:54 +0000
From:   "Baumann, Moritz" <moritz.baumann@sap.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Moritz Baumann via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>
Subject: RE: [PATCH 2/2] git-p4: fix error handling in
 P4Unshelve.renameBranch()
Thread-Topic: [PATCH 2/2] git-p4: fix error handling in
 P4Unshelve.renameBranch()
Thread-Index: AQHYnALZQ3uU3jBrS0CJYNuJQhp/Zq2HcJTkgAAA3peAAAXaYA==
Date:   Wed, 20 Jul 2022 17:01:54 +0000
Message-ID: <AS1PR02MB8185DC4EE3C241B0F9A9234D948E9@AS1PR02MB8185.eurprd02.prod.outlook.com>
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <69c9fd5fbec859c2cced95930ac4d427a09aee90.1658298900.git.gitgitgadget@gmail.com>
        <xmqqa6934v2c.fsf@gitster.g> <xmqq5yjr4ux8.fsf@gitster.g>
In-Reply-To: <xmqq5yjr4ux8.fsf@gitster.g>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad276f44-3eff-412d-ac0b-08da6a718c49
x-ms-traffictypediagnostic: DB7PR02MB5210:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZcdk3RBfMnSPTQjUjgJME7qVUHWwIcwrVctTlaKhFQmckNa6AxVHvszPLnOQF58upSudykZ01eVBpKX8QVvPmuVj/Nr7NZDw1vCVD5UAlBxY5F4/WPXQ9ArMs1uEExhNYICxR+gngryPt7eQNTFiy3y4DybiqZ2LbKPhDoXjpxaIy4yeKUVFN/73BPtO0gwBpAahh535vuUZeQKSYgU2RN94FdVkyp6tpQkykrsbzdHpyetaTeZSSSqn185iqMNl8GtWe6spj4sNPskSkP4KbDY2e/6g2FzKn8GHmdzqdybHTElIz+saclfpfiLZoej9qQS1PuTmulocD06Lp7L0AVyZHeoPKvldBarVwiiwvGphZ8EtGHXcMDDAnIFM5cv0AjoXOINox2MbFHXQMFeGFFDml11J1BIX+8Mk/i+o1fVUXsPCWH9hgn+XG9pao+ZISlvizP9nz4CsVv4B4Iv9NZ3arQOibKTOtysEAq1+UP0F4jLAFSjlMzip4RDHSdMDc1tYpdrYJdzOpqRRurtP/Eyx08pxZ68Bqi31S3RtqROt22hNvay5Pxl1ooJynbmRR/A6pIYgz/N1uozToQ+Z7os+1k/jqH18QGM27ab/gvENXCGMY5NKHnt7tOCCq+YNqrIdRRAPXFxEwllmTb/6tzvTaf6an9CZ+s1P+YF4bz4sMr0AIB/Mq7Lo7/1ku1bmT7gzdKi6HsSTwNAurTZfmnN+gw9SzkYtCxn3b/+OEudFYQb0JRCGH1o6v+rnpiE/RzXP74XDoXqqlmgwjlWKiIzYuyaN1cz9QV5+Ujk/3uwiuZeHJK4HtCSOA6SnTOP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(86362001)(82960400001)(33656002)(38070700005)(122000001)(66446008)(4326008)(8676002)(316002)(66556008)(38100700002)(110136005)(2906002)(66946007)(54906003)(64756008)(66476007)(52536014)(4744005)(8936002)(5660300002)(76116006)(71200400001)(186003)(55016003)(6506007)(26005)(478600001)(9686003)(41300700001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkdQbWMzczZYY1hPWEUxZWMyZkUrTEhxTFd3U1VHeTdZRGdvZjhRRFJ3SGJM?=
 =?utf-8?B?RWJtTCtjTjE5YUYvQ3FmSlh6anZWb0QzT2gzczhSUWNuWXQ3WW15c2YyYVRx?=
 =?utf-8?B?aHF2SWxobEdyZWNvMXVyampuS1pUUmZydmpBVFBwUDFCVDF4ZFVZWVFlK3pw?=
 =?utf-8?B?T081bHlUYXZXRStXQndTS2ZjWHRNbm1kVlpBbW83SFdyN0F0SFBrZ0RnbENY?=
 =?utf-8?B?VkI2Vll3ZmdVZ3lDUWVvZFpoRXFydVdSTGxoRVZ3Nk9yc3B1NVE0VWNWTmNp?=
 =?utf-8?B?alhGcVBCT2gxV1g1T0IycmFNVUJYd3BGdTU4SVJEZ2NTSDFZUTVBMXhEa1po?=
 =?utf-8?B?OWRwUi9ISDFEeW0vR1k4OUtTVWlzTUFPazlpWDRFa2tFdGNPUFBIeVRpMXZO?=
 =?utf-8?B?clJiaFZHeDBORVRUcURaUVZGcFVONWRKcnpjTWdSWUNFSk96U0R3UUtDelhN?=
 =?utf-8?B?TEc5ZzJSTXhRcXcvL0lhWEtSamtnU0RMTGhEUGRHMThMRTBDOGtVWHlWQ0do?=
 =?utf-8?B?MEExQTAzQm45MUNJb3NUczl4VUhrVXl5dGdldHJlaW4zZXdQMllLbGpyWkdB?=
 =?utf-8?B?bGlQSGlOMEJFYnVvV0JIYUVaakVpQko5OWRUK2RncFQwbzhydUZrOEZTNlls?=
 =?utf-8?B?R3BDanlpNE13Vm1TeFpFWVdCMHBsR1dFYUR3OGZIN09maGJydSs0R3RpaGgv?=
 =?utf-8?B?VXJwNDkvM3J2dTBKV3docGgzS0JyeGp3SkZNajEyeDIxNHhCRCtSN3lLbGRt?=
 =?utf-8?B?OUFldWY3UnFzaURFOHFZLzFnTHFRN2pzNEdnSnh4SGFKL2xWTmZDVGNJVHRM?=
 =?utf-8?B?bVFPajJRaWh2a3U1NVBZUkJlS2FweFJ6TE00SFV6TDhDMXRYTG9TVFVLMTBY?=
 =?utf-8?B?UXhqMkhnQy9XVmp6YTN5QUxJVmNLTU95bnRtcFpMc2o3a3BHTElMRUVsdGtS?=
 =?utf-8?B?REZtSmJLdXlvOVUramkvekl4dHA5czcxT0JBL3hMRTYwQVRJV0dKelRqdkUx?=
 =?utf-8?B?bXNmbW5CbEFoMmFFSzFGZmZmYWlQdjVuZTUwTGU4UEpSMlhtMnRFR29xaVFY?=
 =?utf-8?B?d3E5OVZKRktDZFVtTGg3Tk1tVUZSK2JPYVZmRGdFYTFORnp4d3NieFZPVGhm?=
 =?utf-8?B?MVJoSHdqVHlnNGMzNXV1K2VuK2dhQnlqd0RKSHhtUkR6czVVaDVnOFNnSVcy?=
 =?utf-8?B?MU04UDh3enlMRFljei9EK1J6bm43dm8yeEhFSWNXR3Vub0U1RzBwYVYyQjNl?=
 =?utf-8?B?dmFtcjlqcG0xbFgvdld2ZHU5NE03RHFzTzlVNzFXUXJDUG1PTkNzUi9UckFX?=
 =?utf-8?B?a0VIeWg1VDAySkRKRTdVZVNOSUIzWVUrcTFPMzduTkxORXBkNzB4d0RObzJx?=
 =?utf-8?B?Y3pGb1U1MjBUV3hUUXZaQTk5aEk4ZVlpSmY3dHlZY3N6M3JGZlFlbU9aVmpm?=
 =?utf-8?B?dkY3YlBtMFJ5MGNZMjRQVW44b3BnTVZ5d1ZEUzJib3VWaGRQWjJlemFrVzc5?=
 =?utf-8?B?VUw3RzArMUZGalN5ckJTYWZiTy8rQ2svYzN5dWVhV1VSNStXK0thZWNmQzZn?=
 =?utf-8?B?NW1WMk9ncjlVTjF4MGdNekZjRTFjMVlBNDRaSGxtbUVBNHdURVloenlkV1dD?=
 =?utf-8?B?bmRTMktwTFFYRjJyTStJWEI3Y3QxaTlPOEhRMmVEV3ZsL2pkeTQ0emI0QS9N?=
 =?utf-8?B?ZHBSL2tLZWVHK3cybSt3TWhmc3A1bWVVTDVOaStlQ1M2TzcybUVmaGJqcksx?=
 =?utf-8?B?em05S0hHRlhtMWRLU2JzOUtMMDdlTmVGck9jSnh4TUpLcmhJcGJmZWJHMDgr?=
 =?utf-8?B?T3l1aFN5SW8vZHdhRlNyMkZSZ2xUbFF4TXYzVGxieU1NcDBSSERhQ21ra1Jn?=
 =?utf-8?B?Kzl2eTFHUkNFRmxtZDhuSUxkbTBKUll5VFFlNjd1OGc0cmVwMTAwUWhIbHFU?=
 =?utf-8?B?L0xIOVhrdjNBVlMyVnBoYW92VlM4R1NJeVhmalRPekpxaTBOL2dmVGhhU2Fz?=
 =?utf-8?B?YW9HdVVFQmg1K0FPenZPczkrYWxwU0JKclUyeWlxZnhmKy9DQStKeEZVcnJn?=
 =?utf-8?B?SWIvMDZOYUpIbndEOXIxWjRKdWF4UVdTMjdTR1d1aW9QbkVJMndoQlZMYnFk?=
 =?utf-8?Q?HwfrMsEZuz4TjHdVuIfkF/RRX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad276f44-3eff-412d-ac0b-08da6a718c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 17:01:54.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnvjDDVYL0pMmajHsVcnFfH9GBDv4eV05H+uE2tUHCen5ngYrojFVwFqNI4op1DKcKw/EuqlS4QFD6kRpaGrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5210
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIGNyaXRpY2lzbSwgSSB3aWxsIGtlZXAgaXQgaW4gbWluZCBhbmQg
c3VibWl0IG1vcmUgZGV0YWlsZWQgZGVzY3JpcHRpb25zIGluIHRoZSBmdXR1cmUuDQoNCj4gQnkg
dGhlIHdheSwgaXNuJ3QgdGhpcyBhIHR5cGljYWwgdGltZS1vZi1jaGVjayB0byB0aW1lLW9mLXVz
ZSBidWc/DQo+IE5vdCB0aGUgcHJvYmxlbSB3aXRoIHRoZSBmaXggaW4gdGhlIHBhdGNoIGJ1dCBp
biB0aGUgb3JpZ2luYWwsIGJ1dCByZWdhcmRsZXNzIG9mDQo+IHdob3NlIGZhdWx0IGl0IGlzLCBp
dCBtYXkgYmUgZ29vZCB0byBmaXggaXQgKG91dHNpZGUgdGhlIHRvcGljIG9mIHRoaXMgcGF0Y2gp
Lg0KDQpJcyBjb25jdXJyZW50IHVzZSBldmVuIG1lYW50IHRvIGJlIHN1cHBvcnRlZCBpbiBnZW5l
cmFsPyBJIGhhdmUgbm90IGRvbmUgYSB0aG9yb3VnaCByZXZpZXcsIGJ1dCBqdWRnaW5nIGZyb20g
d2hhdCBJIGhhdmUgc2VlbiBzbyBmYXIsIEkgaGlnaGx5IGRvdWJ0IHRoYXQgdGhlIG1ham9yaXR5
IG9mIGdpdC1wNC5weSB3YXMgd3JpdHRlbiB3aXRoIHBvdGVudGlhbCBjb25jdXJyZW5jeSBwcm9i
bGVtcyBpbiBtaW5kLg0KDQpCZXN0IHJlZ2FyZHMsDQpNb3JpdHoNCg==
