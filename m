Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E199EC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7620740
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WjH5Pk9P";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="qDXd6JoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfKYQaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:30:19 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:18890 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfKYQaT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 11:30:19 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 11:30:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=257; q=dns/txt; s=iport;
  t=1574699418; x=1575909018;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=W7WH/MbsbqFtNw8RD8w5kM1pZ8KrhOibifboJzgpj5w=;
  b=WjH5Pk9PuBnIstvMN9YHqVxBtyPC3FbUyLKmyDWhyxlBf3crgk/U/FtL
   8ryO+9C1zFYgRxdYfxVKPvdRTtyJBciYQ+e2w/0lUiFlmnhQIVBaW3hJE
   Az9+zQAW4somKBCyM09DGrf0gDlres0fAuT71k/j+c9mT2lRBAuf6hJUg
   c=;
IronPort-PHdr: =?us-ascii?q?9a23=3A1rTX2RKfJG19ejehW9mcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeBvKd2lFGcW4Ld5roEkOfQv636EU04qZea+DFnEtRXUg?=
 =?us-ascii?q?Mdz8AfngguGsmAXFXyKffway03NM9DT1RiuXq8NBsdFQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CwDQCT/9td/5ldJa1lHgELHIFzC4F?=
 =?us-ascii?q?LUAWBRCAECyoKh2cDim9OghGYBIEugSQDVAkBAQEMAQEtAgEBhDgIAoIuJDU?=
 =?us-ascii?q?IDgIDDQEBBAEBAQIBBQRthTcBC4VTAQEBAgESLgEBOAQLAgEIRjIlAgQbGoV?=
 =?us-ascii?q?HAw4gAaYeAoE4iGCCJ4J+AQEFhRQYghcJgTaMFhqBQD+BWIIeLj6ESQKDQII?=
 =?us-ascii?q?slmSXUgqCK5Vvgi8Bl2yOSJoQAgQCBAUCDgEBBYFUATaBWHAVgydQERSGSIN?=
 =?us-ascii?q?zilN0gSiMFAGBDgEB?=
X-IronPort-AV: E=Sophos;i="5.69,242,1571702400"; 
   d="scan'208";a="671391547"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 25 Nov 2019 16:22:51 +0000
Received: from xch-rcd-011.cisco.com (xch-rcd-011.cisco.com [173.37.102.21])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id xAPGMpYI032717
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:22:51 GMT
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by XCH-RCD-011.cisco.com
 (173.37.102.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 10:22:50 -0600
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by xhs-rcd-003.cisco.com
 (173.37.227.248) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 10:22:50 -0600
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-003.cisco.com (173.37.227.248) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 25 Nov 2019 10:22:50 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRZRIiDLqQDN0jkpmw7ereN/V5VLthxFxF4kuZQJxkx0ogFvobACz+2EPQKEbLbBzdATLIUMPPKDTWGm2kNzWCPSw65XbvKgZITI9Ku5xz0SRHcNYMGqVd+snyKH2dYgxrJ7686BDkgMl1293RbCl8aWK9bMk6nWHogd/PzHVhTSWKbHHE+F4EbArQIIZwtDSOe1nbzAWGVUz5ahLy95NP+4IefY1RmIOKOHR47Wq9d8Xre4FmN53sOuYwN0t3y1zkFAR0BoJUpMvgCo5phSe+0gvbIpdC8Cy9o1AFkkUP6RwArmzqt+7rV3f+6Xk99kXxwHEg980LYqFh32zfY7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7WH/MbsbqFtNw8RD8w5kM1pZ8KrhOibifboJzgpj5w=;
 b=K2zRLJ21Eq7LdP6vwU/jqjv5LGUezx4+hPeGIHz+eLD7NK8TksEDIq/Ns1lnM6Onwk8Bz4oHTVKydVJ0ZC+9WkQLEnTA4JJP6nvbxpdiWEMnsm21R0A+Pttc1njh2zuR4VIANw51CMMbghPG73Thsh5zaom6e7CrAbY3h/l55NSgpJNxh1SyB2j6VUWmI2L5iIHfqfOr7PUd5MV233rQ/GmBOLapdmC1jg13PsQyGGZKsf+1qAupnm9hHbMyfxrIL+M2TRssHRvvcWZ72vsfb/C303xbkr9ZG22ez4bW32qc/x4yakeGKe4fIJMXyRjvNQVA54Gck3cCOovGNXri2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7WH/MbsbqFtNw8RD8w5kM1pZ8KrhOibifboJzgpj5w=;
 b=qDXd6JoOo37IEul0Pn2G4u96b0DVqMsUmc47ry1TUm5DPEOXrYy9Hz9geItlU9B6t6S0ZPBrKV5qM7XLWyuLh+NWQCluLkzAqpaFX1wypf3hns9BwTuRrR70Bhq0gWyV6Vx5wOUPszIELMDO0n/qT82Jl/nFZTo712t5uBwOZVc=
Received: from CH2PR11MB4294.namprd11.prod.outlook.com (10.141.118.210) by
 CH2PR11MB4279.namprd11.prod.outlook.com (10.141.127.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 16:22:48 +0000
Received: from CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::759a:b24d:909d:853]) by CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::759a:b24d:909d:853%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 16:22:48 +0000
From:   "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Push a ref to a remote with many refs
Thread-Topic: Push a ref to a remote with many refs
Thread-Index: AQHVntgNsCy38IgfMk2h9wErEHyX6KecFYNc
Date:   Mon, 25 Nov 2019 16:22:48 +0000
Message-ID: <CH2PR11MB4294168406728D1510A92704CF4A0@CH2PR11MB4294.namprd11.prod.outlook.com>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
In-Reply-To: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pamarlie@cisco.com; 
x-originating-ip: [173.38.220.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b047cd2-bcd5-4a5b-8d49-08d771c3b652
x-ms-traffictypediagnostic: CH2PR11MB4279:
x-microsoft-antispam-prvs: <CH2PR11MB42793E3241F7AEA789697A2BCF4A0@CH2PR11MB4279.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(64756008)(66556008)(91956017)(66476007)(76116006)(66946007)(6436002)(6916009)(8936002)(2906002)(52536014)(5640700003)(25786009)(229853002)(55016002)(8676002)(9686003)(71200400001)(71190400001)(66066001)(81166006)(81156014)(33656002)(1730700003)(6116002)(3846002)(6246003)(102836004)(6506007)(558084003)(316002)(7736002)(7696005)(26005)(11346002)(2351001)(5660300002)(256004)(2501003)(74316002)(305945005)(14454004)(478600001)(66446008)(446003)(99286004)(76176011)(186003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR11MB4279;H:CH2PR11MB4294.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxbEL6pDxrohnzZfF02CsTx5V8HN6RL7tZ7a7jwo6RF74dQCaESEo5AWOw9R7BC4o9nbdolG+7HPEcgm+GBUHbKAreBBPwUQl6/SY6+BwLzhXVce4ALlUgdPhWD0wKfduZmbEFJDDv0ee4yQWHAKBDI9VetALVbXt9k+8jD97q8IRLmP0FPUfzStx26MWl0to+KMJm/MEl4nFrWa/pv6PT/Jj90i+ppys1KnCL+VGci7+2mhjfw+6ovd4uLoYO6LolJVynm/sY0O2LKF1GKXXa4miVjNG1Kdm67r5QJZHApayJdvqnnOqXjjJYkE679zyPLL7AbnIQXVFHR5lymx/7f8g+uoi+IH8pnfewIXlUVfgzSZN4Ojo7gKp5gOPaK3Eh+ifA7NNB8GmvmX/kv3Qiyydz/vQX+lKR+1VFr8AH6xIdXWhd7WdI2ci0qohqEp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b047cd2-bcd5-4a5b-8d49-08d771c3b652
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 16:22:48.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fH5NRXfLU2Z2Gh0tvd1SLQXZbb+qFHg7suJp1kXfUKDE/o8LwzxpkR7+0ZoX0NYFdUAMJcwMZePrGCNZyrL6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4279
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.21, xch-rcd-011.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To workaround this issue, I ended up skipping the refs that are not part =
of the push. See patch at the end of the message.=0A=
> Is this safe to do? Is there a better way to do this?=0A=
=0A=
Some help on this?=0A=
=0A=
Thanks!=0A=
--=0A=
Pat=
