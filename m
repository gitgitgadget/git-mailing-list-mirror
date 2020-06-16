Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B3C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 06:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8408420810
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qmaw.com header.i=@qmaw.com header.b="nvvncCO2";
	dkim=pass (1024-bit key) header.d=prudentialus.onmicrosoft.com header.i=@prudentialus.onmicrosoft.com header.b="v928+a4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFPGrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:47:23 -0400
Received: from pa-mailgate2.prudential.com ([12.42.50.176]:18503 "EHLO
        pa-mailgate2.prudential.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgFPGrW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Jun 2020 02:47:22 -0400
IronPort-SDR: AMgfXdD85N7f6Dk3tbyzempWR69nF8juZhaoy4Sj0p+Pya5xOHFrZqf9GXe5K8yXLIiPTizaBF
 BQIpZM85Yl7g==
Received: from p2erscba1085.prudential.com (HELO ironportpaprod2.prudential.com) ([161.151.153.21])
  by ironportpaprod2.prudential.com with ESMTP; 16 Jun 2020 02:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20190808;
  t=1592290041; x=1655362041;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V4RaTyXn0zKN/YZJCAlYOe2pyoCg3znQHM/CCeO3c00=;
  b=nvvncCO227GRsucctA55HO9XhkzBwgY77CdAoKcClcdYi4+Ij+dOoAmG
   FfckFUzWR8YSCwjse5kbV7LkrCBTge/kgYjnQ4dpTTswfJf2ubDQx2+NY
   a+RhXdkgPzkFmR5BjT5X4TTvJzqTXKGW0jOHsUncA0R0aac91Q9wbdeim
   lAZDFKDzY1NHW3hpAflzAfr52E7cHXfnGeZEfwF/lsMRZ5YKOLT4v6kpk
   vsxyAaZPjkSMHPAX0VeZmmwffYoTQKYmDFOUCnntgz5qxb8aSqSHCK3HS
   OqUyyb9K5wgxSuOD8i2lL2GkQBYmW7GjFh+ufjxGguhemAY6nrlMgnXvb
   g==;
IronPort-SDR: 6sDwedW2OY8pQX/qxdmyZ+xgd0CzcRXSSycnzLkfOp5B2R//JonMc6Q/3H5UyWLAeXEo5hxVLb
 oHHZFdZKCwhw==
Received: from NAM10-MW2-obe.outbound.protection.outlook.com ([48.96.18.140])
          by njros1ngw23.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020061602471348-2518478 ;
          Tue, 16 Jun 2020 02:47:13 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xffy3riPfHzob4AKFHyHEaOIlLhU+4CJM/ccPy5JpkgMVB+m0mfZ+Il+0YJqrf0Ob5P0ROCALOVVTNjOyNpQjguSLlbn+TynvqlbNqg0AqAHekcRKsNWG2pReHP/puSYDi+YWqO6qs29ne07ey95Tt1d/9+4Vw3haHizk/9KX/U2dTSGyJkVyx9nOIlcdkVZ4dpZrDmGJxPYadHimlSe8nknM+YJ/Op5om5CqOm8qGEdKhwQHV5fLGoWd2QG8iESc6VfBuX3Zt4j0dfr6BOzJ4vFkT+GS/5uKhzgA7Hn203WD+uHvJwDax6p7tOZNia5fUXClByt7nxm4RXHiTPHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4RaTyXn0zKN/YZJCAlYOe2pyoCg3znQHM/CCeO3c00=;
 b=OVCkpYkd9wX2uIbfQZfLtnm+htrKhR8HlKqYyeHaHU/ZNC3GWy5DT3vha9qMmCc4g5PcIWqKBBoYb9v9vGn7IVXGomgXpMeXjA0x6Y9PaKL6HA6DZ/JPliz9UHDIdgJ/KWATgfgFESUmggzMApWXUzslBX9iNwth3bBnwDgVtu7sQmM2t8j2OV5oN2MCJzfoN/zaQL9is8iFSqfe2JWXx/fGdhF6ZSeEuyGjuxrKNPvPhcURZ0tJxF4k6Aryu7sLMS4CDtcEuPNaML41tZjygQFriGrVn6gbM21+fK94Un64UoZXfPennWsHoQKfK0Mcdxnu7VnaUzB5HJOhUol5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4RaTyXn0zKN/YZJCAlYOe2pyoCg3znQHM/CCeO3c00=;
 b=v928+a4GTBrJ25sTRJ4yE/oBK1iVcvgjTM2AR4frUoOr9TZCn+oPuXairVVr/P1s+vl+LDiEz+tJZx6jKPuC7ts9pVG4oEal4v5W0cL+6aTtIYezYWsPGbSXP9fQCLVGpCoXtmSzfIvxI76Zw/Yjv701t08sVVqTRfivQyRK5vQ=
Received: from BL0PR11MB3460.namprd11.prod.outlook.com (2603:10b6:208:6e::21)
 by BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Tue, 16 Jun
 2020 06:47:04 +0000
Received: from BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659]) by BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659%5]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 06:47:04 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git switch error message tweak
Thread-Topic: git switch error message tweak
Thread-Index: AQHWQ6nQKsc8dHoJEE26s0Rv0s8dWw==
Date:   Tue, 16 Jun 2020 06:47:03 +0000
Message-ID: <BL0PR11MB34603334FD8AF4B662A74C3A9D9D0@BL0PR11MB3460.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qmaw.com;
x-originating-ip: [82.69.86.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f6130de-dd3a-4ee2-63ed-08d811c1145d
x-ms-traffictypediagnostic: BL0PR11MB3282:
x-microsoft-antispam-prvs: <BL0PR11MB32826E750A08D0EBFFD612199D9D0@BL0PR11MB3282.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zD77+PAhdkvqwKO5E7Cvji4bKUkybA8MYENCKuZMaZHnKYjsmTVaSFZ27DjE3N5IDin8NayfINGB4XIx/GW5vqEGw5U2pQ/P+sg/Jy2eRNNKbZhcp/5lgf0LKIzY8UfSYgBpFDo12VqZJNOev4o/tbrcHXQ4AWdOT1VTdeWneE3vV/jJAY+6WPpdAakqx0V7iWMxPfUnXY/Nj8uiN4EV/DFXkuCPmrxROCPkFC4wJIfvvJtMHsMe28MH2bk+d0bJcz3iSRsRbkQhKF3DprVQ+PrAX7znwWA356cs4xsRxh9LAyWryt2IiFS5IK+p3148
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3460.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(7696005)(52536014)(4744005)(9686003)(15650500001)(83380400001)(55016002)(6506007)(86362001)(44832011)(8676002)(66446008)(6916009)(5660300002)(186003)(66476007)(76116006)(8936002)(66556008)(66946007)(64756008)(71200400001)(91956017)(2906002)(33656002)(316002)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w09tsCjMklgvc33ffoZFkt3rpdPy2KmHTpAnszfQvB7yDUDNTUBqiSPwxpp5JwwqNKUKxTZffeFZfy8ZgkmB6JLQZXzWNIaA64tZDoDPP5DdnWt2KQzqPTbLKo96K4bDLVdErYE3jEKFzcmlPv7J2hjP040RIGSZ8/csvGydDApgwb6zJsLk7puXfmYpzdtoG12KyHnMMBtpcalM+2efGQtrEIeZtIH+Gxi+8KtwxlQG9pZ2/59ScWJNaZnrVQ0lWrEZcfUU+k1vlX4bcJDuOdagSce9C3Y158fRSMvZK6+aa+xkYFurpGpf3poL+87Z81rhGr976aR1XO7rryS9sVkVKuqFlVR1YPXkdag7zNKRgI8IrrvY0da2IKUUD1FP+9xf8N1rmw/CN6ndgqeUL0Kgtd9kYGYk4ucp0BeEC4/s9oNO1YK1cCbRpsYcXJp+abFATJyMoPBUQfQslqKvE5UrS5M5WLjDahG/QeOfedQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6130de-dd3a-4ee2-63ed-08d811c1145d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 06:47:03.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaiB4u628CA2L3YqXHcpbUcqcvIH0zor6dcP8Y3OfC5P3OE0tGR8tFZK0Y2AmxGtrufgKf/JlvG+evM8Ce7Fbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3282
X-MIMETrack: Itemize by SMTP Server on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 06/16/2020 02:47:13 AM,
        Serialize by Router on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 06/16/2020 02:47:13 AM,
        Serialize complete at 06/16/2020 02:47:13 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-GB
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help those migrating from 'git checkout' to the newer 'git switch'=0A=
and 'git restore', this error message could be improved:=0A=
=0A=
% git switch baa022666d26a5d40e86c0b6349eb7435033e80a=0A=
fatal: a branch is expected, got commit 'baa022666d26a5d40e86c0b6349eb74350=
33e80a'=0A=
=0A=
It could print additionally=0A=
=0A=
To switch to this commit in 'detached HEAD' mode, use --detach.=0A=
=0A=
as long as it was indeed a commit that was given.=0A=
=0A=
I note also that while git checkout prints a spiel about "You are in=0A=
'detached HEAD' state", git switch --detach does not. =A0Was this=0A=
deliberate, on the assumption that if you pass --detach you know what=0A=
you are doing? =A0I think it might be better to honour the=0A=
advice.detachedHead setting the same way for both checkout and switch.=0A=
=0A=
Thanks for considering this request, and apologies if this is something alr=
eady discussed and decided.=0A=
=0A=
-- =0A=
Ed Avis <ed.avis@qmaw.com>=
