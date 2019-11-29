Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD94C432C3
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D64921774
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="c+rPrLL3";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="Emeafjth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK2JW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:22:28 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:3036 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2JW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 04:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1992; q=dns/txt; s=iport;
  t=1575019347; x=1576228947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YJ4JkHtePE/zx8OPpWTNrqQYtDl+bMY4AK7QVtgXtgg=;
  b=c+rPrLL39pvELRr0X6Av7yEX47hD4wsLhR7ya5ZDP8ExAs8GhGMMs7W4
   IH7THA1S3oLnw0yuC0B2Br8sccXsdV9uaxmMTKeZb/UkRhJgbiG/0n8RL
   kj65zRokbSfxpdvi5CZoZooWkz38AX5yZETFTy6M+2S8LgilvGJKWhSba
   o=;
IronPort-PHdr: =?us-ascii?q?9a23=3Ae/b97xVubKKed8mKZNkrGklHWJHV8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSA9yJ8OpK3uzRta2oGXcN55qMqjgjSNRNTF?=
 =?us-ascii?q?dE7KdehAk8GIiAAEz/IuTtankiFcFLTltk8lmwMFNeH4D1YFiB6nA=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ANAADR4uBd/4gNJK1lGgEBAQEBAQE?=
 =?us-ascii?q?BAQMBAQEBEQEBAQICAQEBAYFrBAEBAQELAYFKUAWBRCAECyoKh2cDim2CX5Q?=
 =?us-ascii?q?Jg3uBLoEkA1QJAQEBDAEBLQIBAYRAAoIKJDUIDgIDDQEBBAEBAQIBBQRthQs?=
 =?us-ascii?q?GJgyFUgEBAQECARIuAQE3AQQLAgEIDgouMiUCBA4NGoVHAw4gAadQAoE4iGC?=
 =?us-ascii?q?CJ4J+AQEFhR4YghcJgTYBjBUagUE/gViCTD6EIgEmAoNAgiyWapdYCoIulXS?=
 =?us-ascii?q?aIy2EIqQSAgQCBAUCDgEBBYFUATaBWHAVO4JsUBEUhyiBLINzilN0gSiNdAE?=
 =?us-ascii?q?lgQsBgQ8BAQ?=
X-IronPort-AV: E=Sophos;i="5.69,257,1571702400"; 
   d="scan'208";a="670223172"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Nov 2019 09:22:27 +0000
Received: from XCH-ALN-006.cisco.com (xch-aln-006.cisco.com [173.36.7.16])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id xAT9MRKe008945
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 29 Nov 2019 09:22:27 GMT
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by XCH-ALN-006.cisco.com
 (173.36.7.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Nov
 2019 03:22:26 -0600
Received: from xhs-aln-003.cisco.com (173.37.135.120) by xhs-rtp-003.cisco.com
 (64.101.210.230) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Nov
 2019 04:22:24 -0500
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-003.cisco.com (173.37.135.120) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 29 Nov 2019 03:22:23 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7nKb6BtGfGPxsRr61EznOaoFV79AMSX1bpuELmjwh87puRLc6RI61akMpNMSu8qGrL0ol/rA2Gq5peXNEh9mmTFcXRbKpv7pc610MHKeDmkOhKnxIIO4UChshV94SPSUWrgTSKTGxQ7/TzNM4CdwqE1niFl87jSc7Kel0t2UuEe5b46mK072JSdQRP+tjYrWLgwDki+XL8fnw7+1JU6DhSuqERb7uPN0S2r4BPHT4n19RVTzOFqtZ0Kqiq1KkyN07gftD8UzpsTi2ohLHHzeShn+GgKYpRPHSs3pGE4wBE6XBmJdJIlodA/kuWAtKr4Fr8O5B3UeV8YLqheql0n1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ4JkHtePE/zx8OPpWTNrqQYtDl+bMY4AK7QVtgXtgg=;
 b=KNyMtslTgVilXgmAOrRZlR+5E4YLwWC3Z5Gn4/Zph2EAeLcOsnC/W7jvSivDiZMFWeeM2sF+ZpGZrMKL1zSh/LCkkfbNl5FkdZezDVELh8+j3MdMwc5ubBXsxtj1ZWrBNDsstCCLwtxA0J8Uh/mIWSJJ0J8nHHdyFeWqn+GOxt2npnyVZgb5umg5Puu93VkMIgSRypKLFIUwvqfBF3/r4ml//FiBOGahO0c7BaWe7FPe5+O7ISs/aBh7OI+mJoG4uVgpnZOk+axARbyCKPn28/UDnGRa7zN7G2eqJj8Ivlw16eoTLNZHXo1NOD4J6XXklA8vgzqLCLxr/ZEC2tAdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ4JkHtePE/zx8OPpWTNrqQYtDl+bMY4AK7QVtgXtgg=;
 b=EmeafjthysLZuwkfeOyFaN2dagLx2u9hLforY1lx9r4fO/w/FhHXdef3AVAvMbaU7FX7URfXv1KzEWVbiLXm7ujPuINVZiACZHKo2EXGGxpjaLQji+YTiFsSQzE0ehQjREb9SVFxkUKVE9BUcqTJ60qruIo+lIMNp2EjKcesvV0=
Received: from CH2PR11MB4294.namprd11.prod.outlook.com (10.141.118.210) by
 CH2PR11MB4294.namprd11.prod.outlook.com (10.141.118.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Fri, 29 Nov 2019 09:22:22 +0000
Received: from CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::759a:b24d:909d:853]) by CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::759a:b24d:909d:853%7]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:22:22 +0000
From:   "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>
To:     Jeff King <peff@peff.net>
CC:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Thread-Topic: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Thread-Index: AQHVpR63qXkRF4jHPE62LYMCWIhkwKeh4Lnw
Date:   Fri, 29 Nov 2019 09:22:22 +0000
Message-ID: <CH2PR11MB4294A6C1AA71DF1A1721C94CCF460@CH2PR11MB4294.namprd11.prod.outlook.com>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>,<20191127123211.GG22221@sigill.intra.peff.net>
In-Reply-To: <20191127123211.GG22221@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pamarlie@cisco.com; 
x-originating-ip: [173.38.220.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 671f5f3b-c7bc-43d2-da1f-08d774ada3f4
x-ms-traffictypediagnostic: CH2PR11MB4294:
x-microsoft-antispam-prvs: <CH2PR11MB42940916F76898CEEA3EE291CF460@CH2PR11MB4294.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(186003)(316002)(25786009)(26005)(76176011)(76116006)(91956017)(7696005)(6506007)(102836004)(6246003)(478600001)(52536014)(64756008)(6436002)(305945005)(256004)(14444005)(3846002)(14454004)(6116002)(33656002)(66446008)(5660300002)(71190400001)(71200400001)(8936002)(229853002)(66556008)(9686003)(74316002)(6916009)(55016002)(54906003)(2906002)(86362001)(99286004)(66066001)(66946007)(7736002)(8676002)(81156014)(81166006)(4326008)(11346002)(66476007)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR11MB4294;H:CH2PR11MB4294.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQ8qDd82gcZi1+xyTuggfrrdCiqjt5s5eSeOzREDu/fIsHVpGf3KYGlUAiEuCNn7QFU5kDvf295T/+dGFI8hSQE1UsRqXvSijn81bM0yyq56BEnSPuHyAYzG6PJCLs+x4wsW4/X8PwsI5A2VSzFYyvsw+CW+/mn+FdLSFxFlZ36i9VEyXBYzs1aCrNk8LssHMEwqM7m8lfcjbFhXLDAuf6YuOn/5ldej4KsyjZgEQ1kaePCLaT7zu8ZsUe5kPdWrF841xnkAFz9GZdzqGr2pGHsRa5N8CSwyllvXCuImjxeayWJbFvypPSGT9ua7poFpx5hizTOXhtZaUXXoRyfgPsys8motgVeFg/kgm/BgtFg1TDswdSApGcOakvKDVDFUqGzGc7u1Q/33sGFVNGRD41cH5NroHvoIzEkCfwK/h5yWBAXOnGhpRMufEZsF4g/E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 671f5f3b-c7bc-43d2-da1f-08d774ada3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:22:22.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abkGbxyW8sVABKmrt9PDpjW0lWa3fT6mwmjsNF4bwbw1AcoAVLrjaXGf0Ny0JqLQsCNlV2q6AVxchVnPNrwtUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4294
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.16, xch-aln-006.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Nov 19, 2019 at 01:12:51PM +0000, Patrick Marlier (pamarlie) wrot=
e:=0A=
>> I am hitting a performance issue with "git push <remote> <refspec>".=0A=
>> The local repository has only few refs and the remote repository has a=
=0A=
>> lot of refs (1000+) with objects unknown to the local repository.=0A=
>> =0A=
>> "git push" of only one refspec takes minutes to complete. A quick=0A=
>> analysis shows that a lot of time is spent in the client side.=0A=
>> A deeper analysis shows that the client receives the entire list of=0A=
>> refs on the remote, then the client is checking in its local=0A=
>> repository if the objects exist for all remote refs.=0A=
=0A=
>Right, this is expected. The client send-pack feeds the list of remote=0A=
>objects (that it has) to pack-objects, which can then limit the size of=0A=
>the packfile it sends based on what the other side has.=0A=
=0A=
>So the patch you showed (to skip refs that aren't part of the push)=0A=
>would miss many opportunities for a smaller push. E.g., imagine I create=
=0A=
>a new branch "topic" from the remote branch "master", and then try to=0A=
>push it up. If I do not look at which objects are in "master", I'll end=0A=
>up sending the whole history again, when I really just need to send the=0A=
>differences between the two.=0A=
=0A=
Thanks Jeff. Indeed it makes sense.=0A=
(My very particular use-case would have a limited impact in this case)=0A=
=0A=
=0A=
>> Since the local repository has a only few refs, most of the objects=0A=
>> are unknown.=0A=
>>=0A=
>> This issue is particularly amplified because the local repository is=0A=
>> using many alternates. Indeed for each unknown object, git will try to=
=0A=
>> find in all alternates too.=0A=
=0A=
> I think the patch below would help you.=0A=
=0A=
I will give a try next week and I keep you posted on how it goes.=0A=
=0A=
Thanks a lot for your input and the patch!=0A=
=0A=
Have a nice day,=0A=
--=0A=
Pat=
