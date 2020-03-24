Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56209C41621
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8FA20724
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qmaw.com header.i=@qmaw.com header.b="S+SXpSFD";
	dkim=pass (1024-bit key) header.d=prudentialus.onmicrosoft.com header.i=@prudentialus.onmicrosoft.com header.b="xlIGapVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCXH67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:58:59 -0400
Received: from mailgate2.prudential.com ([161.151.157.53]:14151 "EHLO
        mailgate2.prudential.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXH66 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 03:58:58 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 03:58:58 EDT
Received: from p2erscba1087.prudential.com (HELO ironportnjprod.prudential.com) ([161.151.153.23])
  by ironportnjprod.prudential.com with ESMTP; 24 Mar 2020 03:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20190808;
  t=1585036156; x=1648108156;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qgTExKx77PsfAHWxzEz3yp9btUb7lxE6d0/EkyQTBTs=;
  b=S+SXpSFDUN7w3/+zbIvz2qjITtypZqo1UocwCS6N0Xp6f473/sJ/GDIq
   OBvH+RfrQSkUPQpM07/TsR9qe/oOAaiyueHeCkMYeMwVceAwrvcBdvEcL
   bK7ZuwH7LN2B7EIgP83bJh2GUiGkhkz6rkErIiYu8WojS7eT7IXubVeE5
   zUGN82DmOp3w7wwSJtZIAEGtx3atVFh/v2nNWxmlqGMBjRk1Lg6kcRG7F
   vKMEYiurOO93vpq5X9fhrcyIt9v6a5xh/RdnLfYJZ4nJ82TX+B/XpkaQI
   LG9FTAZNUTshfW1hegmtzBdt0Nxl1RSiJ7PmquLCq6ltARBwazEBhYowB
   g==;
Received: from NAM10-BN7-obe.outbound.protection.outlook.com ([48.96.18.99])
          by p2erscengw004.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020032403491549-194996 ;
          Tue, 24 Mar 2020 03:49:15 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSWo2JSEPyail9482FZSulWEMD3nzrWGSIsk30Ihi+XC2k2ItSGPq88U3bWLoBKoozCEOmblhYmkX2HGCiux+5HX6u1k5ytCRVzInDttxwq7/2dGn91C7I9q3vauSzTePtEvi5oTOJhlmBpSRG1DRVU8zmCOknWoQTZKNy8BJ6l4HYHBzLE3PVzni37dnmtFezmTcQEKE6PNmxkHq+UXZCWMz/k7OPGkr5ig0k6KVd1Anqwm1wNUAE2PWdSOHyxxLapBpTYSDzxRdApPksfi89LM4S1hSr3INqK9kINsH6nIR4lkTPXBcGUc2wVLZ17YLvRbcDkyRIWNljjcnLCokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpI61/PEgSgKpo3qrlb7lwu2rO2h70L06pEyVa6asqk=;
 b=Bi2wJ3XbfsFaabfVfp1t+XET85gkyD+zJ4y40S3UMWd3tciVcPnMpL+9jsIk0sNIMZlGs6jDe80QfMpzLdTw2lVD6sI1hF3rZaYkPFZWAh4MWSkDT+xmDKKTydwrxomvoHqLnVA2ltsgQbjrL7SUFMN6yG6jtA/Y53KjMO3hczS5gifvabXjKq2fRcEkdEIeLM5CyJhutsiG054fydyj2rCY5o2hb+OE//uHnyfw4VFP0MSYM6phY5+Y9YX4tICUM+Dlt/VinPlnKTtE7fQg8Ubz6Joy/1vEsnp8UZji5G60Ynq1Sx1fzT0jLRM0leuFdeCof2nJamOWdZT3aKHTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpI61/PEgSgKpo3qrlb7lwu2rO2h70L06pEyVa6asqk=;
 b=xlIGapVmCT6RQT8Q7vJCE84FuHZNN+7FGLswiMOsulqYMvwSc+XfUuz5AjSB3ndfsYMhygaaNs9PNwoNb4QjrJgyoj6RegPmEH5sL/P6i6LKCQdn1b4H5IDtGsBZLujOrjCkBQXd2opQv6p77KdOUXQkKvJoxV7LZVQrORJS+VM=
Received: from MN2PR11MB3663.namprd11.prod.outlook.com (2603:10b6:208:f5::32)
 by MN2PR11MB4550.namprd11.prod.outlook.com (2603:10b6:208:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 07:49:13 +0000
Received: from MN2PR11MB3663.namprd11.prod.outlook.com
 ([fe80::2957:5499:ba70:fb66]) by MN2PR11MB3663.namprd11.prod.outlook.com
 ([fe80::2957:5499:ba70:fb66%7]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 07:49:13 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature request: 'git grep' over multiple working trees
Thread-Topic: Feature request: 'git grep' over multiple working trees
Thread-Index: AdYBsFps/lU5GYHyQTOTfXbrVEUzNw==
Date:   Tue, 24 Mar 2020 07:49:13 +0000
Message-ID: <MN2PR11MB3663C042590097D7A7F4B2409DF10@MN2PR11MB3663.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ed.avis@qmaw.com; 
x-originating-ip: [37.244.66.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 108b11f8-c113-4645-ab1f-08d7cfc7d870
x-ms-traffictypediagnostic: MN2PR11MB4550:
x-microsoft-antispam-prvs: <MN2PR11MB455081A06E0B5D5523C3417A9DF10@MN2PR11MB4550.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(9686003)(66556008)(66946007)(52536014)(76116006)(66476007)(64756008)(71200400001)(7696005)(8676002)(66446008)(8936002)(316002)(81166006)(6506007)(2906002)(5660300002)(81156014)(4744005)(186003)(33656002)(478600001)(26005)(44832011)(86362001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4550;H:MN2PR11MB3663.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: qmaw.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhFVk/2mLAMGKVAv5lSA4nKLquOTe/kxCLbTzcQCLXXOJSGmGoSDStQAgLGhSjFiSEodrpGAUe0vnzn027m8X5Am6LKtAyDJfUbVDN5gIZyd3pm35xG+ueIc+zB9iqIW1tGDjxBq28NoJ9PdUduVE87On1uWhzY93iRGPl5In/wDwoj/2TMieccu17qq6/EqqvrR1YzUwIcmYqs2/MhMMXpglDOiQb9temcFPzLzGB55ONUTS1Tg2mRce1HNgIajGGfzwvvGOc/0yB/fbJWbtp1O/OlPG4hKKD6y0cmv4PJQas/q7cb0HtAonK/d9cLCzz9zawjQdC1zKkVuoMxCPMsPlPG3u3dEUNi49SzX2cl2YSRXSseWq8RMDhgH/Od4d7gnfQe7qNJiWuxjpVw5gWkoH1MZYcP709H945i8q1WeF6cOezqOibtJSJ4YeJs0
x-ms-exchange-antispam-messagedata: nrYQfaw9ekX0+xkuqKpsaZMwhqUKEM4u/uoh0GUhZEEz5fiENJQSiq8n3wlu0mitkOJg600AVvraZZeX95wVouSEx3C7MyiAzPbeuua4xZ5KF3N3d3BG7pqrH8TZCW1qUnm0O5S/n/TWKfo1f9Rvag==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108b11f8-c113-4645-ab1f-08d7cfc7d870
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 07:49:13.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFigvS/5xYqZjjXX6jW81W1jlXav9LU+nN1lb4iETQcW+8LI9JAezAMW2Z4enNkrkceUunYQSxyByzXbkLeVMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4550
X-MIMETrack: Itemize by SMTP Server on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 03/24/2020 03:49:15 AM,
        Serialize by Router on PAERSCNGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 03/24/2020 03:49:15 AM,
        Serialize complete at 03/24/2020 03:49:15 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
Content-Language: en-US
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the current directory contains several git working trees (each in its ow=
n subdirectory) then 'git grep' should search all of them.  It would be rou=
ghly equivalent to

% for i in * ; do (cd $i ; git grep whatever); done

except that the filenames listed would have the full path.

As you see it's fairly simple to script up, and there are tools to do it (o=
ne called 'multi'), but having it built in to 'git grep' would be handy.
If the current directory doesn't contain any git working trees, then 'git g=
rep' can die as it does now.  If there are some working trees and some rand=
om other stuff, it can warn and skip the other stuff.

Please ignore confidentiality stuff after this point.
