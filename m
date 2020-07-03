Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7AC433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7091B206DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qmaw.com header.i=@qmaw.com header.b="m9t/6Cyn";
	dkim=pass (1024-bit key) header.d=prudentialus.onmicrosoft.com header.i=@prudentialus.onmicrosoft.com header.b="yX43u5yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGCIiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:38:13 -0400
Received: from pa-mailgate.prudential.com ([12.42.58.8]:11074 "EHLO
        pa-mailgate.prudential.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgGCIiM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Jul 2020 04:38:12 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jul 2020 04:38:12 EDT
IronPort-SDR: kmV9e2AA2dtbgnsuvztg35/2wc575QrGK1HKZmm2flJC0x2Jq9j5h2g4PXLa1KQncxKhdkWQMF
 g+TYpXH+laLA==
Received: from p2erscba1086.prudential.com (HELO ironportpaprod.prudential.com) ([161.151.153.22])
  by ironportpaprod.prudential.com with ESMTP; 03 Jul 2020 04:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20190808;
  t=1593765064; x=1656837064;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fyQRSkphgGuJ1rZutnswqPoIR0dhQWpeFT+sycomJNo=;
  b=m9t/6CynI3paE9CRZbxjTzZ2vJ1wQEp7oFdxkzV1zhnCiURnjUtCnvsJ
   7Z7tkST8ZO0FRvJC35/az+WFGXJEPlHmcL6IarEAGbPZDBbu3lQpdj/UI
   qVtk7xIhLz67mwiN30+i2Qrqo/FWa9ih/C02qbYdW4E6q8GutzIRSTDTA
   sKHGvZBO7YeRC/HF1RkLTVTjx2o3CTG3dQiL9XICYZY8qUL/4qba4uswQ
   A4IYpquITsySmSV+LohPG0tXAw/6OH6QgzanY8TBFhC9wQ9JagAqu2sKw
   xNJehd82a9RICqzTxsonupA4QV9kw49xTX8sVH5mUbQogTbwgoJWxCQPv
   g==;
IronPort-SDR: Jw4tApAzH5BDiog4ViivS0yhQYhD2lSgJDTJSM5IIlAWvjhQV4TqAtDOc8NDtuP7Tm9BFWZJXx
 QY25rLzzk0ww==
Received: from NAM12-DM6-obe.outbound.protection.outlook.com ([48.96.18.99])
          by p2erscengw004.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020070304310432-2278071 ;
          Fri, 3 Jul 2020 04:31:04 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWV4n4joQTZxxKVgB4wLQYQIpfh0qNXTe+LzQWhSLhFJGCA/gkUziaEqv8NVwYRGCC+EpltDWMi738o8a9Z7ZTGuOqQvhcw6O0bJaLBMJcF+wlYZz5Shuv3I/K/hBrRjxk7vNMKaz6TE300myYPdbw8yc3sRbMYTmHfB7caSU9zFkdA9Rs3Or0niw4aJFjk5GosYnaLl0nGSqKBS+/hxjGelDYRQimuMxpX6tzfdwyOqsF+jGiOq5MjTcQ4acKdxCQvlZCut3jc1J0BuoPB9TAzcuzsF1211DBohL76Z/fsfRb3cB8EHAADySrGyMLNQqZKysoYVgyE6QcRRAYkf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyQRSkphgGuJ1rZutnswqPoIR0dhQWpeFT+sycomJNo=;
 b=iaWL9F9sFLOVc44AGzV+xExmhyfjheI+/45TdiCkvuO5GbTtpkby53INxkHoK1PZhtKfuGQjxzhK9jHJH20IqxCV15rCRgynW3frnx9SgFanxncTw2NF9N6tIOuG5akOBDAaME+X/A6flHSKaspRcO0lMJPy40xVwVCp/g+CRtwSw3uYlMKncTfTO65PXIUl8AE5oTOQ0k3zaqttPZgtfUIl9/IW+dKMuoLwI1wQSS06Ge/1rwnIecA18KJvszNbAFVW1wZO+uuB3TSTQbxk1rIQykYv0oEOe2/owg+lGbZUuueMryqeeiHSq0skI3QLafkwlarAkvQYry8SmXEQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyQRSkphgGuJ1rZutnswqPoIR0dhQWpeFT+sycomJNo=;
 b=yX43u5yC0l/A83VJ6zDAtX1BDx0BeBACdWRxH3AVGNmtRkwY+snYdgY4pYElw2zNAOV99hhKnwD05bOs/KDHEqnXovfQBvSwqT36izPCwpQUW9SyMWa2r7HRbJJfO8FJz4sTE86senT2IOPkdiGaWwA/3Ud2435NFfJfsnUXBNs=
Received: from BL0PR11MB3460.namprd11.prod.outlook.com (2603:10b6:208:6e::21)
 by MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 08:30:52 +0000
Received: from BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659]) by BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659%5]) with mapi id 15.20.3153.024; Fri, 3 Jul 2020
 08:30:52 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git switch -c message improvement suggestion
Thread-Topic: git switch -c message improvement suggestion
Thread-Index: AQHWUROss4Et0801CEutkLTxIXuHXA==
Date:   Fri, 3 Jul 2020 08:30:51 +0000
Message-ID: <BL0PR11MB346072F896E88001502324C69D6A0@BL0PR11MB3460.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qmaw.com;
x-originating-ip: [82.69.86.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52d854b5-4ccc-417b-02ba-08d81f2b659c
x-ms-traffictypediagnostic: MN2PR11MB4712:
x-microsoft-antispam-prvs: <MN2PR11MB471204E8310F7753858E56839D6A0@MN2PR11MB4712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+3dQiDKb8BwecbJNxsNIM0D7kYqauHcSIgG7x25VecXXyNp2JOzWzqRsUhGo0Fh/j1C2rD/zk2F4+cdZUlMh2VVBh8/56ViV5UwhhEk3gyzks8v0w7NSkQf7Mf48jPgu9cPe2S18ujsET9rb3F1rrG5i+m8n1MQO8Z/6hlSfsojITiSdP+ql1wCwxWTtClwr9JjQk7p2fvPbPqT6gFozjN1il31ZNxCTubDG4g6zV5ft2mFphYAg1A9ucAISHz0ClsroUvuJtK1inwwMKo65BcfImDQ/wrMrMpI9fZp7SHZbszi1l5cuvbGFS5uQmw73m2OJFTw4Ih8NmUwkcSkKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3460.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(64756008)(66446008)(66946007)(66556008)(66476007)(76116006)(478600001)(316002)(71200400001)(9686003)(6916009)(55016002)(8676002)(2906002)(8936002)(5660300002)(33656002)(7696005)(558084003)(86362001)(44832011)(26005)(186003)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tXbtYTFT7zySkzJTUqK31KWcoQ5VDjGDwIKgyJ23TUne4hwQiVVmh1gcxbGksvdgUKQ2UaJT6OzPC5qVw6jSP41mUZ7XSbphBpmpNfMJGj1CZizbrassAjEJ6HE5xzdtMJyUL9tVRhoq2+6OWZYPaRGLoy4KFHept1d2jc7nnUgxbLspDks8NjqtMNF872YDhS2nOohfqOFZHWQLvN0hVit1CTqD8MJG5CWXsHEcgGWgF3uBlUA+ZoGhudbTcvgMiA6FqTjE1Lo03/+djQvqneYwnedRQN6lv58u3xtJndxHsnqAmrlV+N/Q0/7b1RWxQD9SLKffEpykYHVu3E1VNBjVm0c9ab+geQmFDJzVPxbFoWs4Ivvt729fQOYlq1DyPMhUWm5X0HXBM9zzEW+zvdoWIQym2kpgmS8INDgyyp9YliBAHDjmNf/w7CHHxJNzFTyt6mhsSXd0lnYzFZsMP6SV19xCiRaP4xVRygq3Lqs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3460.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d854b5-4ccc-417b-02ba-08d81f2b659c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 08:30:51.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81SWkTw6xkUPVqmX2SVQLk5RpyctVhYJom/MrrjOS4yQlJ2DkyLMyugM/CmP9PH/95gwVodZdWxEIaO+OsAD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-MIMETrack: Itemize by SMTP Server on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 07/03/2020 04:31:04 AM,
        Serialize by Router on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 07/03/2020 04:31:04 AM,
        Serialize complete at 07/03/2020 04:31:04 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-GB
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think that git switch -c could tell you not only that you already created=
 the branch, but you already switched to it!=0A=
=0A=
% git switch -c branch1=0A=
% git switch -c branch1=0A=
fatal: A branch named 'branch1' already exists, and you are already on it=
=0A=
=0A=
-- =0A=
Ed Avis <ed.avis@qmaw.com>=
