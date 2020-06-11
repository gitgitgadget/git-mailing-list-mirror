Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B13C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56C52063A
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qmaw.com header.i=@qmaw.com header.b="Fp0JUYX+";
	dkim=pass (1024-bit key) header.d=prudentialus.onmicrosoft.com header.i=@prudentialus.onmicrosoft.com header.b="0qxhbz6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFKLTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:19:17 -0400
Received: from mailgate6.prudential.com ([161.151.153.47]:56075 "EHLO
        mailgate6.prudential.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgFKLTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 07:19:17 -0400
IronPort-SDR: cvOwpxa8OdPigx+lYEWhtOyVn5gkeVneK0qwQr8xn9raFEEIr9whLtP1Td6/hOp7Tg8jqGPTQv
 TIJs+JAOYlpg==
Received: from mnncpoba1722.prudential.com (HELO ironportnjprod2.prudential.com) ([161.151.157.69])
  by ironportnjprod2.prudential.com with ESMTP; 11 Jun 2020 07:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20190808;
  t=1591874355; x=1654946355;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=smz57MIQAlmEwaGNOWk7btxzKxgWZ/Z6AQ87asoBNlo=;
  b=Fp0JUYX+xSs/KY4nVVyZgW/A7d1htdB7frRkupXpigAOy8hlqd6vxGZX
   0eSdvmlFH8LOXTlvjRjt+8imki1aYpkoCn9wFjosn8ISfO5DAg50x311p
   f2yiG3WTwEOTvQDl0914yGHkULIHqFL1O8GrKLEcLaz+Q4qdiokoHdya5
   nh6M1Yx1z3vmhU5YJ2S53giuxIbArQZlRXjuc0P71buDt1BphUgmN3lDS
   SbYUb03qdUPsuZBVr3wF62caMSrgvTNr9SsyzPLZtE928+BUQ43HFo3sw
   hYFIDKXi20zSPUuWWZ459Em3fNwV/9YfFWMmxzEoxLa9k6+KeGg23OVKo
   w==;
IronPort-SDR: ONrpH+FBF+0SOi5VIKfLyMIA1yP6Cvwv+o8BT0gNQ20Fkbw3nIAuQfWdjR9UzTFpekCrHEWVqY
 cMzJ+jFkbN3g==
Received: from NAM11-BN8-obe.outbound.protection.outlook.com ([48.96.18.2])
          by p2erscengw004.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020061107191479-553977 ;
          Thu, 11 Jun 2020 07:19:14 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsl74UjKSKSIN1lCkQwenRApNySrWG+LF5gHEbDPiH0MB9qgV4a7FvcAAS0NSQ3CQy2jQVtw+emG12vHjfaoIIZvzoqao+YWmqQwRIDgVSpbv6ssF36FiMK5Ztp2Hupk2Etl5hjT6n4RVDY7sqHW6KAg/xvInusGCKWR7j4IVGP6CwfEpI277PkUumfWxn6V2tVvgawhCbTz5wiw/hYsTiele4YxiBlRm2leyI2tjEGEg2/eZKiOfqxKJCJ69jZ1iqykFTyVZBouDoVAedsb5gG+UoMSpfqxIaRIgyObglR8hCFaboxyrW7N5fuq9nRC1kjKeEKgPPK/SMYnyNKw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smz57MIQAlmEwaGNOWk7btxzKxgWZ/Z6AQ87asoBNlo=;
 b=TIG8SrVTDF01CgB5klQgAEj5QBcuORKLkjoiBOSP++DptWVGSZiAWNMFD66cWJ1NuaTDPydaQ+xxniUdMzWIryeMMk/v2nnOAp4WsevntjVWyWwYDZdI/dj1nCkH09grtPgwa2M7rlx/msetkqUmC4p31jlZbjBPenUW6Kq7rl1rbMkggf04O0Yer8pJ3c+npUiaHrocagKCFXSzt9aOBHV62AugmsmXebvI2ezZqkENlYOE9DSISy04s3ehUzwdBVswIHZzIf/9lpvsfNh9IgvH+bu44Vxm9YDxibqRUfHw4Fb3ShNIRQLhGrbrNvYc/BWnvh4GOHYIy8pHDkHPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smz57MIQAlmEwaGNOWk7btxzKxgWZ/Z6AQ87asoBNlo=;
 b=0qxhbz6ylYjWT0TzlvTuEZHED++hgcoYE2M9wtVqBDek3kCpAbM3smBU+djt6OxdwMwFBzuhWd2oj0rcKAfWC1gCFB0JbWPvTAJG+/IsAp5eTdc7NeXH5xSnRsQo1iAEyGoVFds7LP/O9inaoo9RyH0LzOQcJGQClChTeYYgDrI=
Received: from BL0PR11MB3460.namprd11.prod.outlook.com (2603:10b6:208:6e::21)
 by BL0PR11MB3187.namprd11.prod.outlook.com (2603:10b6:208:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 11:19:14 +0000
Received: from BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659]) by BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 11:19:14 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git log --name-only improvement: show old file name in rename
Thread-Topic: git log --name-only improvement: show old file name in rename
Thread-Index: AQHWP+H0kjTryd4RS0S7/Rafrnu33g==
Date:   Thu, 11 Jun 2020 11:19:14 +0000
Message-ID: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qmaw.com;
x-originating-ip: [82.69.86.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00cc350e-03bd-4a21-bc96-08d80df945c8
x-ms-traffictypediagnostic: BL0PR11MB3187:
x-microsoft-antispam-prvs: <BL0PR11MB3187B9029A241F941D2D07749D800@BL0PR11MB3187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WiRFQ1l035zJPFICvbOepkSRbfUnSehJYh5NgPlTbMnuSDxVpUDXGgQzb0aoDJ0qWn13ekeZ5kB32L/kLX4nMcFB80SmLfN2aCnA1fQ6JIlXPszHtBNLpFQPgTCs2lRkomhwwW6CO5BldnJs2Q0YT2jRmrOjKOeJvKrfubnntbVd20vX8Z63ifvO71C9jmUzTdplOU6rUCUvQPDzDynjMJSV15M8cIs9ty3OLBehSe60d22/fEBVcd74Skf62F6NsUV8/6rzWs2llkNKYVPsYBTWu1XgntjghWo2IUGbGPkRS3CEWgtDiIId3ozSaMuf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3460.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(52536014)(5660300002)(316002)(6506007)(66556008)(8936002)(76116006)(64756008)(66946007)(7696005)(66476007)(91956017)(66446008)(71200400001)(83380400001)(55016002)(186003)(9686003)(26005)(6916009)(86362001)(44832011)(8676002)(33656002)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6fk32sXb6hdiiQWfET049vGxbH6JNFmKRYowPAMgp+CAa8Di0EpYjRoehCqiIGRx9zwgBl8ufjegNfe1P9mtBaaJVH00dckc/id+Q5rCEr1TGP+CQtMe12nIhkT0lJKuD3TvUTh7/zAxiKkj18CFqLT+iLcytt3maCq4aHZFVNPNKBrwX/Z7iScLCxM/SuBzdhLsnKVQq4a2LM97fU5QMl3qM1PZzPe8RY4NISomn8WGI7ma4nQR7OKLOdqNWJOWVzX78lT2tIvFjhopxdmH1PDILuyd2vPsAXPMB0v0WBaAchpQbnd/lJiocs0Qov8CedxjXahpQluBAAaDW0kBvLxmjFmtYHMPB8pIHC6x/NtK0aaeG7mq4RSK7IfOov2vIcF+2/An/5lp3Uv4LZp3XannvVz27lRMEuSRFnYEG7gadZcBjaSb5An8EsXtCCBeAUTvE4lTLqWmO2lXeN741KFrEIwqiAL/z27eSuKbCcI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cc350e-03bd-4a21-bc96-08d80df945c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 11:19:14.0097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mu+9YwMuT1raljdW1MfXIxcEC7mzgMCJXz+lGQWWj+BU9KnGCfEeRdRwiDKhXW+lVzwQMxK3mM2AWt/vJ5L0Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3187
X-MIMETrack: Itemize by SMTP Server on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 06/11/2020 07:19:14 AM,
        Serialize by Router on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 06/11/2020 07:19:15 AM,
        Serialize complete at 06/11/2020 07:19:15 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-GB
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-log manual page says=0A=
=0A=
=A0 =A0 =A0 =A0--name-only=0A=
=A0 =A0 =A0 =A0 =A0 =A0Show only names of changed files.=0A=
=0A=
But when a file has been renamed, only the new name is printed, not the =0A=
old.=A0 I think it would be more useful and more correct to print both =0A=
names. =0A=
=0A=
For example=0A=
=0A=
% git init=0A=
Initialized empty Git repository in /home/eda/test/.git/=0A=
% touch a=0A=
% git add a=0A=
% git commit -mx=0A=
[master (root-commit) ca81aa7] x=0A=
=A01 file changed, 0 insertions(+), 0 deletions(-)=0A=
=A0create mode 100644 a=0A=
% git mv a b=0A=
% git commit -my=0A=
[master 7b3925c] y=0A=
=A01 file changed, 0 insertions(+), 0 deletions(-)=0A=
=A0rename a =3D> b (100%)=0A=
% git log --name-only -n 1=0A=
commit 7b3925c1ece26d08d79cf9f06bfcb0b38fea611f (HEAD -> master)=0A=
Author: Ed Avis <eda@waniasset.com>=0A=
Date: =A0 2020-06-11 11:59:34 +0100=0A=
=0A=
=A0 =A0 y=0A=
=0A=
b=0A=
=0A=
=0A=
I would expect that last log message to show the old filename a as well =0A=
as the new filename b.=A0 If you give --no-renames then both filenames are =
=0A=
shown, of course, but I think it should be possible to detect the =0A=
rename and print out both old and new names.=A0 There is --name-status =0A=
which will print more info including renames, but again I believe =0A=
--name-only should also show both.=A0 Thank you for considering this =0A=
improvement request.=0A=
=0A=
% git --version=0A=
git version 2.26.0=0A=
=0A=
-- =0A=
Ed Avis <ed.avis@qmaw.com>=0A=
