Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F09C11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24861208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deloitte.com header.i=@deloitte.com header.b="gQUpCaQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgBUDoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:44:06 -0500
Received: from esa15.deloitte.iphmx.com ([68.232.143.59]:60814 "EHLO
        esa15.deloitte.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgBUDoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:44:06 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 22:44:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=deloitte.com; i=@deloitte.com; q=dns/txt; s=us1;
  t=1582256646; x=1613792646;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=v8yXM+KCQixDhIBRTpZp83TCSKmc5TySAvicGbMyFRo=;
  b=gQUpCaQ+anIJ76C4gC/a2MbkluKXykQcaoABLSszmmiI1eD65+Vl5XKr
   4BpLy4nEZKdDStiYyVQiCrEu2yyk0M9nHZxB1qfobLtyrPVAn+RcznD4s
   AmLGn50vNoq0AGyaJmEuS8QCvMPMQldZzT5HAgLnFfrGLQb8AKH5lnQOv
   fWQHt063SdgmfIGUPhPsvmLowG3UCnjSQi9vZqhb1CIinO5yRVM4ip1tL
   XtHAfy5vIh4vTNa3ojrvaS8bzXyrJNNHSFXod0AMSaOz0sEayqsJjDOtn
   fjKF/8mD9CI59LFNphbTO2/KM0ajvCtY35e+d2x8rJzRs75b2FU4WUCFX
   g==;
IronPort-SDR: y2impdtt1sovwClqnDC7091zXvaDRGJzl20GFqXsdQ/O1ylMrf21qDyl6gtJHKj1L9wpz5Mij1
 D6e49SPdio1mzjRdKpWLyqx5uc4tlVz0pQj/9BKsblhw2ihnCxNmDYJMso16mDkQ3jgV7WHS80
 uIIpor3FVmT38wVvHqhJffGY5kBWrufPCnZMUr14aHK1vk2je/nkFOpsj+T4EDFIWtlfshmHG2
 ew66FdUBOnoEmJ2O8IOBlhlwbF2EpmlowLqXDx5cidgiA8vokMTSefIb2yF4Wtgm5hlEjCMZSc
 X/8=
X-IronPort-AV: E=Sophos;i="5.70,466,1574143200"; 
   d="scan'208";a="45655912"
Received: from unknown (HELO usndcirpt1.us.deloitte.com) ([167.219.90.173])
  by esa15.deloitte.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 21:36:58 -0600
Received: from usndc1423.us.deloitte.com ([10.28.30.58])
  by usndcirpt1.us.deloitte.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2020 21:36:58 -0600
Received: from USHybrid.us.deloitte.com (10.27.30.23) by
 usndc1423.us.deloitte.com (10.28.30.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Feb 2020 22:36:57 -0500
Received: from USHDC470.us.deloitte.com (10.27.30.21) by
 USHDC472.us.deloitte.com (10.27.30.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Feb 2020 21:36:57 -0600
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.27.230.225)
 by USHDC470.us.deloitte.com (10.27.30.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Feb 2020 21:36:57 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/NDWP726JviAzt7FEzz6MgROHafhQTDYDUEroir9jeqvin7dAQTukGwHKrijQK0lrBIUD1pw6RGEEBJLfOg6G4Os7Rmuy/fbSFR2wW8qt4A/NkPB0Jz+aNxcmoh1I4ur/Wsa+20nItBukuDemGRhhTYBlNr+fig2b5BaOTOYCduxTEH5IvhoC9FJbqwr2fDogYePS9v+PtY/s38heY8jjTvfJwNTtmipJT5qGfXFv0z7hK/Jtne7KB+7+ApXgzc0M8sbFkNv1kcb8u5VUjsu+6VjoFaHsRnFlXgnaAMe8E1WN0V6T5JQTLO1dDsEf04S5izqNixiDW8bOjbPfRAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8yXM+KCQixDhIBRTpZp83TCSKmc5TySAvicGbMyFRo=;
 b=UZ5c4mtg+6MbTbgBgKfRRN4pIREoYi8pyBslhi0YtYl2EiV4R6AcwISrWQ7irNi7+fydzdYh4gl+igyhVlRJZ6Q9BWO9mmYZtmK53+34qEuAP7G4ocjB/+qd38iKFV4AjLDyf5ukecVqEBFcb7/ttivOIl7OomxBCoOZGBspuh6np1+pqOCZKQxOFppTM3wkq8g5mLfWvxJ/B5/SwNpfuVETa6OK8FtcVoDR/FzoXLyNhAT3Xc/2Jrlrj7W4ML6HJh9lRzrodPod+C5h3OELBOIEpolN4OF4SVcR9TI5g6wWUmiykJMRK+pg1LjzJJjQIoGNGKKsNLKVNHBvmE00dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deloitte.com; dmarc=pass action=none header.from=deloitte.com;
 dkim=pass header.d=deloitte.com; arc=none
Received: from SN6PR85MB0271.NAMPRD85.PROD.OUTLOOK.COM (2603:10b6:805:10f::12)
 by SN6PR85MB0288.NAMPRD85.PROD.OUTLOOK.COM (2603:10b6:805:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.31; Fri, 21 Feb
 2020 03:36:56 +0000
Received: from SN6PR85MB0271.NAMPRD85.PROD.OUTLOOK.COM
 ([fe80::c56c:fef8:915e:d36f]) by SN6PR85MB0271.NAMPRD85.PROD.OUTLOOK.COM
 ([fe80::c56c:fef8:915e:d36f%4]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 03:36:56 +0000
From:   "Savaliya, Mathur" <masavaliya@deloitte.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Peer's Certificate has expired
Thread-Topic: Peer's Certificate has expired
Thread-Index: AdXoaBd9/Q+z/JM9Su2kE/k9TILe7Q==
Date:   Fri, 21 Feb 2020 03:36:55 +0000
Message-ID: <SN6PR85MB0271C3772FDD480A6095C11CAF120@SN6PR85MB0271.NAMPRD85.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masavaliya@deloitte.com; 
x-originating-ip: [70.106.203.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f90b7ee-ef29-430a-61fe-08d7b67f4cbd
x-ms-traffictypediagnostic: SN6PR85MB0288:
x-microsoft-antispam-prvs: <SN6PR85MB02885F128C36BC55167D6430AF120@SN6PR85MB0288.NAMPRD85.PROD.OUTLOOK.COM>
x-ms-cloud-o365transportrule: EA10=US Cloud to Internet
x-transport-rule: Disclaimer - US_Disclaimer
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(26005)(33656002)(52536014)(2906002)(316002)(478600001)(8676002)(86362001)(5660300002)(66446008)(64756008)(6916009)(8936002)(81166006)(71200400001)(66556008)(66946007)(15974865002)(3480700007)(81156014)(66476007)(76116006)(7696005)(6506007)(9686003)(55016002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR85MB0288;H:SN6PR85MB0271.NAMPRD85.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MH2PkvDGwo0pwuVlqad0UrQyjxrITrtU+7Z9MOENeAF4GrjnyHe/0H+9l0/0TP6d2IrY+MT2AjUPZjSmvOYdWdyxxp3AQtKR9/sbtx2t61ohvdvjUUUfGPekhUd/TLQL2DdSdgXzOXXwAH+9Nv1LNnLdia0eJMPwqcTwS7sqCzo22tT6uf4fJCt7Af2e1H8cuNqg/vFq0FuXmkcXQiBdsGFdrnjhFvu7NrLwhQ1jUK8h3xLVj8FF29mlPETyTMGAJm7GMdY6nYT+Wt4I7eakJKwroICUxYbVSswNmEwWbTq7hSVxUitGQHpfB6nZXqZ4mBIyEkI5qXTakcQgiOqWbRBhm9nRgJCToBFxHhI49YodaSZtRDDuwlb05SAEQYyhslbSYr+lldCoYt0Wcbq5gEuptux/xFZPaAIqOLupdldYvNb7SR3CgbuuTdQigNz6xBmlwa7ehyoLgeX5zTu8h1ASNd/ToH+azNd4+rYJRKbi/J521rIGIuFXYKtikq87I9aQLbTmwAlRMbM+Hl6tJA==
x-ms-exchange-antispam-messagedata: sb0wdkvKeqK63XUGvE1jJAmaWu7oLwHN2yJKQ3b69JuAEQgit0V3b5r+s+pQIStl0xy/K7Ml8sojpy+VetBMr5gMYvc1KskRoI2/C6bv5zw5GyfFwWQzsujK5gjaQ0/UF0akuPsz3G3UfoPQH8QCdA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f90b7ee-ef29-430a-61fe-08d7b67f4cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 03:36:55.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 36da45f1-dd2c-4d1f-af13-5abe46b99921
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKBHWBHhMTdbDWzRQRSyC+VHFMzQy95mxQ6ij0Ud1YvQIBsZgAP9Ukpyabi4oqT7Z7SMSBxHK5IrVcgIoHL2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR85MB0288
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am trying to access a GIT repository located on a Windows machine. This i=
s what I have done so far.

1. Installed/Configured Windows GIT server.
2. Created a Repository on Windows machine.
3. Have GIT installed on Linux VM
4. Trying to connect to Git Repository located under C drive in Windows mac=
hine.

While I try to access the repository I am running into SSL certificate issu=
es, please see the error below. I tried different options to provide a comp=
lete path

Error:-
fatal: unable to access 'https://xx.xx.xx.xx/C/GitRepo/GitRepo/': Peer's Ce=
rtificate has expired

Troubleshooting Steps:-
 I tried different options. Disable SSL verification, Provide a complete pa=
th to the .pem file. None of them worked. Any help is much appreciated

Thank You!

Mathur Savaliya
Deloitte Consulting LLP
Tel/Direct: +1 571-882-7288
masavaliya@deloitte.com | www.deloitte.com

This message (including any attachments) contains confidential information =
intended for a specific individual and purpose, and is protected by law. If=
 you are not the intended recipient, you should delete this message and any=
 disclosure, copying, or distribution of this message, or the taking of any=
 action based on it, by you is strictly prohibited.

Deloitte refers to a Deloitte member firm, one of its related entities, or =
Deloitte Touche Tohmatsu Limited ("DTTL"). Each Deloitte member firm is a s=
eparate legal entity and a member of DTTL. DTTL does not provide services t=
o clients. Please see www.deloitte.com/about to learn more.

v.E.1
