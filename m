Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C2C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D9E221FB
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 10:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgLBKza (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 05:55:30 -0500
Received: from smtppost.atos.net ([193.56.114.177]:16845 "EHLO
        smarthost4.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbgLBKz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 05:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1606906528; x=1638442528;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=2l0I/upg6nOrVGXrOcXYeTa8E4UIEV8DC1Mk/ajv8t8=;
  b=8zScB7tJo7PoFGlLJ/h0utrZeDxWHzyqsk/LPoSlv43SROxyNfvd6Vf7
   An4tV0H5tN22lMhpSk74oP83fUjFPsWN7Z++nsOVdUdc9tCP1JdPY1dj+
   VZ2nJ0R3GbksN7OPh4cCRCYDH+bs+/K/SoyDLoHXjcaBQ5FAtfrbAfCTv
   8=;
IronPort-SDR: Q1/EnfH7/nBha6aHiPXsYCtkjlsOFCEx83vfpMoH5P/KB1rAD0pbro4Gxcdl7aDyZJSlRqEgXU
 TUPg4u1doMNwNzLPD8a55BNS5G3MO3PZz6lPWClTLD7LH2+mmLfs29Aapk+PWo/j5VktFaXoUX
 BSjT5px+c1SVtIG7auhSX1GRu3UzBTdR04nyJhpC1sPGuInk5iOQgF8cqXYK5J6B28hKf/iu+3
 zkPjtDpDlgvcv1JnXQY770w7PEM/glhZhfW8SQS+1KQzajFm0PaQVknumQTupk8HrjJUWRnJA8
 9Uz4rcKd72+sLNSjjJ5I1jnM
X-IronPort-AV: E=Sophos;i="5.78,386,1599516000"; 
   d="scan'208";a="132678618"
X-MGA-submission: =?us-ascii?q?MDGEJV8ej48vqtsGTFfU9luvHQOQ8e4fTXKNQ7?=
 =?us-ascii?q?XHYg3KGA9tsr2zTm/ERCCQUu9tqUzhsdHnpfx2GaWFfgfQ7TRSmpJwOi?=
 =?us-ascii?q?wFRSOiCEVs6m4+YiBuLsRaCRS+SxGqcr7bswtYvNZwMZ7D3lOqTcym5X?=
 =?us-ascii?q?in?=
Received: from unknown (HELO GITEXCPRDMB12.ww931.my-it-solutions.net) ([10.89.28.142])
  by smarthost4.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2020 11:54:10 +0100
Received: from GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) by
 GITEXCPRDMB12.ww931.my-it-solutions.net (10.89.28.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 2 Dec 2020 11:54:09 +0100
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (172.16.214.171)
 by GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4 via Frontend Transport; Wed, 2 Dec 2020 11:54:09 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibeabcjAhiT/88YcPXTVGRCFE4D3tG+GEuzQ4OUUwd2+YKoxG/NpMD/mutglRd60Xv4lnYkXgHrxq4KmutNdDTXx6lPdVRLDSzNSA39mZpVp17X4aEnmSNEd3ohyvuj03hpz85uH6FdNaUyg8UHTxHVAb/PLXReiL2nhYFDfFik0lI0GvsJYbJATNvqrvjtMa1dbPVU/f7N2mFj4i83KfBNgH1se2xKoeCQz/8DC6YHnEf8TfXIahd7SE86usPiR762+aSMqibSkBCMmlRwiVj1AbPOfwazmZe7dFhfLkO3S/P3WzVW4U7+miGkQ9H1Y0UVVZ0e/E1OQkQFho/LFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l0I/upg6nOrVGXrOcXYeTa8E4UIEV8DC1Mk/ajv8t8=;
 b=V9eXadswLx5HVWHQnPy9hpqF4uEvuzO6QbbjGCg9YdADnnkkT0l6AnQSHivayN7Jlc5/6JEoXlZFOZ16lXlQYXzBScJCxwfcnjCZjfC8yMbxjrU3deUKw27gSXIKiGyieBkr7YV7Px8ywOzKuWYy1kAEcLkkBkbctWstwc4JVU3vcbyiE/5UdvHFqxFhNxuKp6OPCNx2Pb6xyX9MZVIqYqhN3Shpj+HgjwJTyBsBPZu779VjKkwt0qMtD+peBIumg8L0wGOU4z0XuINyJ1o7559X8UM4ctct4qriewUGJzdxOm5dEl9kngSjLXA6guTMYSYYAKV0qIrRAxvK5wHnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR02MB4290.eurprd02.prod.outlook.com (2603:10a6:208:d8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 10:54:09 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::dc1:bba8:912e:5228]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::dc1:bba8:912e:5228%3]) with mapi id 15.20.3589.037; Wed, 2 Dec 2020
 10:54:09 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Can I Insert some Ancient History into a repo?
Thread-Topic: Can I Insert some Ancient History into a repo?
Thread-Index: AdbImLDW4svDywGtR/ak5dzepEH+WA==
Date:   Wed, 2 Dec 2020 10:54:09 +0000
Message-ID: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-12-02T10:54:08.2378941Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=d1faa16f-12c7-417a-8d9d-89b336085777;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-12-02T10:54:08.2378941Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=d1faa16f-12c7-417a-8d9d-89b336085777;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.81.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d112c493-6aaa-4111-7220-08d896b098a5
x-ms-traffictypediagnostic: AM0PR02MB4290:
x-microsoft-antispam-prvs: <AM0PR02MB4290752D5820131341AD5D869CF30@AM0PR02MB4290.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/GbIxAko/kgsVXJfLer0CjU3/SGPxIUJU+uLqHOA6igpb5OHfe6nbFgKmRkxyhSWW8X4v7gSHG6Q5dTiZDpt/hC0Ejc1OxIxCY2Lw9B8FwE+pBig4wJQPqjrvQRXsOdrcr7QXrkfw5Tg4HX2iNkeeEcLiFIfssi/dN/LfrHqewhHaBDTwU1HeA5hgnE9TBeP7RbgLTxkj0kY+9oJ3NPMObyaKWgfX8EczOl3QZKHwgNkbgytSqCDcoWQqpZHRkmP8TCAcTMoSVwjcTXbYymCswjLbwIOiy4hRq0QVOYAm66pnqOI2LNItUCBwOU/f1mut9t66ssj03hoWNEWkQTYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(6916009)(66946007)(9686003)(55016002)(83380400001)(316002)(86362001)(52536014)(66556008)(2906002)(66446008)(26005)(33656002)(66476007)(186003)(64756008)(76116006)(71200400001)(478600001)(5660300002)(8936002)(8676002)(7696005)(55236004)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?SSH9knntDRDMPZ/jSDqFNbJ7rhL1S+0es8gE4RKOoBBqcYE+T/FZWL/lCy?=
 =?iso-8859-1?Q?ekGO5mRzVwbTM9VLywRXn030eVkzh6SHAfpcN7F/2PFhCOZu4OK10NRrF+?=
 =?iso-8859-1?Q?hGwX8l+7L7qQcyMfruWLZBf2Mog4jAsx81B8OwYP+kHvyrh4dBWd06P/8+?=
 =?iso-8859-1?Q?XBivVtyTwD1HAce69hy5tpNHl3S9XH7d1TBYypjOMutJivMmKp5dH7kNSS?=
 =?iso-8859-1?Q?rgpJUAFaHMTqAgFJ8+H1JbiZ6R44JtfS4mCAiZbVF1qzxoNE4SAMj/pkh8?=
 =?iso-8859-1?Q?IDGfHDvtzkzxluMibL7EKjarvKev/i/I8oLKCvIeKa3NDAH0k260Dwn4hh?=
 =?iso-8859-1?Q?WLMKv6hwR8n+XacN5ssyMsQ8AIRyf8W4IKMZbjFE83lCBDDqS+gGLr6eM0?=
 =?iso-8859-1?Q?v9X0zrqmYnHbj3ul0kXWZm48wbd2nwe8t50H2S83DetNKRRMt9rHiG00Jh?=
 =?iso-8859-1?Q?BZdvtn6KZ7p6HEhsn0L/3ErZgk5wNMmtaKLMzlm/kYUIPUOIRLQA/poDf7?=
 =?iso-8859-1?Q?iu1ljHibG7GHKnijN3nrkuuuGpJ7Po1FIzby00tz1/UJTiioWcA+l+wUMs?=
 =?iso-8859-1?Q?eYvUPERC7CHDViC8R/pNEauyfw+rVetEDXJ004bOxYMvsqgTz77OQ+jE23?=
 =?iso-8859-1?Q?upbiq5Jre0qQ5v6TOW+LJtrXd4z5H0vSCp+pUiw4cr5F4ZEzw1o+5kDzHN?=
 =?iso-8859-1?Q?g3GuUHKblbZvQzry5eUkxmWmXcseOKC9opS3IgQFD1xI4qHcn0zDeFOuCI?=
 =?iso-8859-1?Q?F7pg6ba4FKoCFlRbV3p4YyVA3c3Cam/igAr3oj+ht87Tejl9nntL8UOqKS?=
 =?iso-8859-1?Q?C4Q/8KGYI2Zu9RarV6yqy+BfF78emPjodNtXpQOnTLQf+hczg6YDLS0bkU?=
 =?iso-8859-1?Q?8oQdF6sRKEegc6eUyMELqxsEIqQ9i+jAbeOohE5jp/jcDMueMK9a7y04dE?=
 =?iso-8859-1?Q?vauWP0n9Z7N4JaBG5j8sqIrhcDWmOtWuSLLJQ4vbmCb5zraO7NApjqakUs?=
 =?iso-8859-1?Q?TXaX42cdqeqQs4Nwk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d112c493-6aaa-4111-7220-08d896b098a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 10:54:09.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V72QtSKf+0dMYoMwFIIt8doObj4g+N3Z06/y8IyQ9bkuWI/D/o4cN3teeR/ez+/JbHIIpLfajkQg+brAkpXs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4290
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=A0
The Story
- - - - - - - -
My project, "L", has two branches "L1" and "L2".=A0 It was developed as L1 =
for a long period, then a branch, L2, was made and further development done=
 on that.=A0 Since the branch there has been further development on L1.
=A0
A-B-C-D-E-F-G-H
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
              J-K-L-M
=A0
(That's supposed to show J branching off D.=A0 I'm writing this with propor=
tional spacing so it may look different on receipt)


The Reality
- - - - - - - - -
L was developed in CVS as its trunk.=A0 That is what I am now referring to =
as L1.
A-B-C-D-E-F-G-H
=A0
At some point a snapshot was taken and put into Subversion.=A0 That is what=
 I am now referring to as L2.
It is either=20
D-J-K-L-M
Or, more likely, just
J-K-L-M
(If some work was done on the snapshot before it was used to start the new =
project in SVN, which I think it was)
=A0
L2 has been converted to git using git's built-in Subversion handling.
I have a backup of the CVS repository for L1 and I can easily convert it to=
 git using cvs2git.
=A0
What I would like to do is to merge these two branches into a single git re=
po.=A0 Specifically, to insert L1 into the existing git repo which is curre=
ntly only L2.

(The subversion server no longer exists, and I don't have easy access to th=
e repository backup, and there may have been work done since the import.=A0=
=A0I have a full backup of the CVS repository and I can easily convert it t=
o git using cvs2git, with any extra parameters required.)

I've read up on merging repositories and I can easily get L1 into the same =
repo as L2, as a separate line of development.=A0 However, merging it is no=
t the right thing to do, as that leaves me with L1 and L2 having separate s=
tarting points, with a merge leading to there being only one head.=A0 That'=
s the opposite of what I want - I want to keep one starting point (that of =
L1), and branch L2 off it (with L2 ending up as master).

cvs2git works by generating fast-import scripts, so I can intercept the res=
ult of that and edit the import scripts if necessary.=A0 I can even dump L2=
 and rebuild everything using fast-import if that's the best option.=A0 May=
be L2 needs to be imported into L1 after generating a tag in L1 to indicate=
 where the branch happens?=A0 That seems to be a more complex work-flow for=
 this task - I would hope to be able to do minor manipulations of branches =
and only one fast-import (ie L1).


So, I'm still looking to see if I can find any other way of wrangling branc=
hes to make this happen, but I'd appreciate anyone else's advice on how to =
achieve my merger.


Regards,
Richard.

