Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3BBC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEB62070A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=qmaw.com header.i=@qmaw.com header.b="FjdjjbZY";
	dkim=pass (1024-bit key) header.d=prudentialus.onmicrosoft.com header.i=@prudentialus.onmicrosoft.com header.b="tXdgdQO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCYIOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:14:18 -0400
Received: from mailgate2.prudential.com ([161.151.157.53]:10929 "EHLO
        mailgate2.prudential.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgCYIOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 04:14:18 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 04:14:17 EDT
Received: from mnncpoba1722.prudential.com (HELO ironportnjprod.prudential.com) ([161.151.157.69])
  by ironportnjprod.prudential.com with ESMTP; 25 Mar 2020 04:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20190808;
  t=1585123475; x=1648195475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=3ur2BZZL5Z6c7F+LsesqlpSYN+EqomdfY0QeqYczLzQ=;
  b=FjdjjbZYMEu7phegs9a3QrWfcL0UD6a1s/FYVKCxus+H8c4RqRKAYS4W
   KVXmVZfIWySzUMh/WD6mVabubaK/p3x7Z5OxPyG99J87osgEMIUia1hKr
   PGbBO6MOylapDgvi1wmtdoKuh24+dgjmDkl5XMsSCcBy0PN0ZETqwYriA
   c65at/N7vR5IgkTURZJ1Vl4vHLb7VwWg/kFNNtxGfN944ZYzEi3CTp7bp
   PRJfDy4sHrhg5e7tX8/G8IFu6eaCjqieZDz5G/lN1G0gTz3MEd38lqmdw
   FgMx8Bu/5I/N0Ricc3AHiSO3HruUM+zVTYMFOVvt9xbF5/OR/XDfy9jYX
   A==;
Received: from NAM04-BN3-obe.outbound.protection.outlook.com ([48.96.18.199])
          by p2erscengw004.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020032504043553-375112 ;
          Wed, 25 Mar 2020 04:04:35 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckXSgHDvmnsoQAPdkeLu8vgWiR5WbTofCKS+5sC9isMHtOYrW9n8GSCOpDc5Q1n3W20iw7uXtD0ULRpKAAPupxf5ly85N4OTA4qFh5e1Fm8RroDjLXkkxMm93NJbajBll+PkDlQCJa0Ul3yvO3FOTyan6I596+iAFwei4e6EUP5+kIhW6424LTKAVcNSwbx80eyaA2Jg5+jEtTv/lCZFD7uIPT+Q21TxMYXSJM59ckFnCiUrt0VyO7K97tYejMoGu3uAHgayeANGkIEDL5VKYsvGtM/7Yq2q7Fks3TLvhIYzEsD6w23wYEFUIqUOMDJdBG3PYDUr861UOlTGns0U9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ur2BZZL5Z6c7F+LsesqlpSYN+EqomdfY0QeqYczLzQ=;
 b=MlVVu8jD9tHm98icXbhThpXQHgIcQFkYC22L7lo69iTumcBYYM6Rmu2Qhe/idB3L0nWsHosEGZgVh5ekd15EuqlmntXPEgftw046UJ4NtYdsVj2GNDuE4QfkIUHaggDvWlLp05SVkqjr7GrF4a42T3gBCfzG4IWQZr+rvAPMVzIKevXkM/Cyy/lovEbE8pbyweG+brkrjDizIWpmvt1URKNmhahSwkDWuyee1Xu7n3GzF9ajETd1c1MTYm5lMK5/43UGQS98AEWiJqLfNcHiesrMkoYHfTDovqMU0EWHbCN+XJk1y6A8o/S7pNnSRruOrRrjR2/5zcN/Ql3sACIAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ur2BZZL5Z6c7F+LsesqlpSYN+EqomdfY0QeqYczLzQ=;
 b=tXdgdQO9OLRHOjfrQglhNV5L72hyAqmqODgG07OIoByQo+LSSroyDD4wcjU1Mmp3JI8p2wN+xQ7amp+D7jzdSfS6GrFhJbTQgo5l+RB9ik8TgaFNgskEmRdP3L6MGIRWBgriAP6MQqxPo8rd7+SsaY1o+q23wQxkyheancZlY4c=
Received: from MN2PR11MB3663.namprd11.prod.outlook.com (2603:10b6:208:f5::32)
 by MN2PR11MB3743.namprd11.prod.outlook.com (2603:10b6:208:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 08:04:33 +0000
Received: from MN2PR11MB3663.namprd11.prod.outlook.com
 ([fe80::2957:5499:ba70:fb66]) by MN2PR11MB3663.namprd11.prod.outlook.com
 ([fe80::2957:5499:ba70:fb66%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:04:33 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Feature request: 'git grep' over multiple working trees
Thread-Topic: Feature request: 'git grep' over multiple working trees
Thread-Index: AdYBsFps/lU5GYHyQTOTfXbrVEUzNwAW1BX0ABwRy5A=
Date:   Wed, 25 Mar 2020 08:04:33 +0000
Message-ID: <MN2PR11MB3663199126786BCC0722593C9DCE0@MN2PR11MB3663.namprd11.prod.outlook.com>
References: <MN2PR11MB3663C042590097D7A7F4B2409DF10@MN2PR11MB3663.namprd11.prod.outlook.com>
 <xmqq369x38c6.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq369x38c6.fsf@gitster.c.googlers.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ed.avis@qmaw.com; 
x-originating-ip: [37.244.66.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1761b1f7-e6c3-4259-e6ea-08d7d0932764
x-ms-traffictypediagnostic: MN2PR11MB3743:
x-microsoft-antispam-prvs: <MN2PR11MB374358A572B1C8125E7B10559DCE0@MN2PR11MB3743.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(81166006)(186003)(4326008)(26005)(316002)(2906002)(9686003)(33656002)(86362001)(55016002)(71200400001)(52536014)(81156014)(44832011)(8676002)(7696005)(6506007)(478600001)(6916009)(66556008)(76116006)(66476007)(64756008)(8936002)(66946007)(5660300002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3743;H:MN2PR11MB3663.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: qmaw.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RNgmJWFZJySEdHUVsfH2Owr2WIjZsBT1B73Qnj61tW3SQTxP6glJvmAZ37HsQj3EVZcTuiUPSqEc0udApBljj5SphgWIaXVTyLgLRecHXNt/SVWlOwV2qk7sWSm+WRCUiPo+Vu9CCsMhL3iH/d6+bZcwUqOn2r9UK8XY4vNq2v6cw+poLtDZYIWlLEFlrx3r7olGp7EmLuShYuTGuR94yqzqjwe8+ItkpsaGGbDfJZHFTF8pDdXEyJ+V2WL2syH+WZqHAV871GJcnngacZO+Oq6dvMC42LTUlusIoT8JyQxqpWawHLhoQGFpKHzbBYo8pqYYbsE4BqPZqwmQYEP2356qNFMgmOpKWF2s8AskkC0zH30ijDKLXo/ZD7OD4TCf/K9Y53t3mjClCScwhkkoZk79X8pi+SfwHuQ3bI+Jg+Q2/n5clEi5XNhtG93Rz5V
x-ms-exchange-antispam-messagedata: piDYWeRKNcMmlVmCfr0D6+zn+zjKhDlcPdxCBO5J/F5xwaA+WPNvXHI1mw1JbhOS9nMUUUe04kfjDOuJdVIAf6NP4LcmJKzIYMlrCmkpwG9Is2Kg5Yd4o6p0r4K3+Bs1acSPnOx85h97s5fO6qCTpA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1761b1f7-e6c3-4259-e6ea-08d7d0932764
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:04:33.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toc9igKFND+W+wguG4D5HrSuBqHAhj2LIOlORzHy3a7uHlLPBMxYrSI1NAo8H/gnR4+JgKHk2WrJcXU0xatmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3743
X-MIMETrack: Itemize by SMTP Server on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 03/25/2020 04:04:35 AM,
        Serialize by Router on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 03/25/2020 04:04:35 AM,
        Serialize complete at 03/25/2020 04:04:35 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
Content-Language: en-US
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your reply. Please interpret 'should' in the context of this bei=
ng a feature request. If you reject the request then no, it should not :-)

The use case is just as you describe: having several different repositories=
 checked out under a common root, and wanting to search all of them, while =
keeping the speed and other advantages of git grep.=20

I do this multi-repos search all the time. In a pure software development c=
ontext it may not make much sense. If projects are so tightly coupled that =
you commonly search all of them, they would be in one repository. But for i=
n-house code in a more 'dev ops' setup it's invaluable. What code reference=
s this database table? User fred has left the company, which config files s=
till grant him permissions? Does any other group call the Pogg() function i=
n our in-house library? Even with a single development team you are likely =
to have more than one repository to search; in a larger organization you'll=
 have other teams with their own repos which nonetheless you have to grep b=
efore you can consider changing that Pogg().

I think I'm not the only one with this use case, judging by questions on q&=
a sites. To me it seems like a natural (though limited) extension of the ex=
isting recursive search. It doesn't change any existing behaviour or break =
any scripts, since it concerns a case where the current behaviour is to giv=
e an error.=20

I appreciate one can get bogged down in questions of what happens if the wo=
rking trees are two levels deep, or there is a mixture of working trees and=
 other stuff. I have tried to keep the scope fairly narrow by stipulating a=
 single directory which contains git trees under its top level. I believe t=
his is a fairly common case.

