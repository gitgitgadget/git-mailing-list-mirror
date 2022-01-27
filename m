Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC2C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbiA0V7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:59:42 -0500
Received: from mail-co1nam11on2112.outbound.protection.outlook.com ([40.107.220.112]:1377
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241041AbiA0V7l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:59:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXTdw0+5GE+eF2y+SqNyiNpv3tLBb3iuf5lLQ52T1UOLqBob6e3p/fMkiz8S21swzrLXw8HTm7bsuibXd353u5YRplKFjv2/93F24CNt+z+JD7MZM+j0Yvkh7zUHsw+9p5XplSrKJFCVly8v+WNhkBClC0wmK25mYaIpPr/JL8J2DuWgzxJccsgrBzfp3RZfSTYlZWkioC4QhfkVO7LvMMU0hQpsKx0v61/jJd82nv8yj7QEHqAjW8USskZpTr25psw2LkT28bPnrO3lNl+0VoIUmLQPcV/HGRZCIcq6nRAtyPhqOF/XT0DEdLDAoF+0/IxE4+AdgyAyMu8ZuKFc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGxadYzOOzWn6ermA/NReqjpvVAgSuO3MqlfI0ZI0wk=;
 b=SPQAd4M2ed+XK2o4+melajiKfG0dC+XTrZ1Au1eZVHKxjpHswucIooDHYhQVA2bPFsvhXhhNAIdwXIsuIHRg+OEkUx7150EP5337/6ZBAHuOMMYTfZb3NRgVJlxMZp/fsCH9wqCbgUjanK2Vmo0WfNJ77JD6NyDBEF7Nl7FDlT7fvlwpPvtwrDXw4NbYUIwCkWodZZLa5aouK1HMCEnp8jqiUP8WimmJj3G7VnVXn7LXM3UldzQIxO9EO77fbzp5lru+KTVkQd20pVk3YNxbxCEltdcteoWc7tXq0IhyErj751t9NwFNHpwAO6yw8nSaqrybBFj/rqW03ohFO7f5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stratovan.onmicrosoft.com; s=selector2-stratovan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGxadYzOOzWn6ermA/NReqjpvVAgSuO3MqlfI0ZI0wk=;
 b=owZ4lIwzz093V/8TYeKUXRzZmZ9nnqaoobwiN9rnBoXXTOvPC0ALAJlcTp0mB+IuyXrx/QRJabIvAOIzDffk6NoCE2j3AKfhfproUma5Dbf8zXZKT8Myjlx50KK0+vw4hV3hVRjf9+DM1fbmODc4AbImNoEsb9iWriUREPDBFVg=
Received: from BYAPR20MB2728.namprd20.prod.outlook.com (2603:10b6:a03:f9::25)
 by CY4PR20MB1399.namprd20.prod.outlook.com (2603:10b6:903:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 21:59:39 +0000
Received: from BYAPR20MB2728.namprd20.prod.outlook.com
 ([fe80::749c:7383:b3b6:e50d]) by BYAPR20MB2728.namprd20.prod.outlook.com
 ([fe80::749c:7383:b3b6:e50d%5]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 21:59:39 +0000
From:   John Rocha <rocha@stratovan.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     John Rocha <rocha@stratovan.com>, John Rocha <rocha@stratovan.com>
Subject: git log bug: -n flag doesn't work with --follow
Thread-Topic: git log bug: -n flag doesn't work with --follow
Thread-Index: AdgTxoSYZ+WwlWuWTp2gsh8m18LY0w==
Date:   Thu, 27 Jan 2022 21:59:39 +0000
Message-ID: <BYAPR20MB27282CFEA29DA37516CE38E3B4219@BYAPR20MB2728.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stratovan.com;
x-ms-office365-filtering-correlation-id: de1f8786-101b-484e-67c7-08d9e1e050d1
x-ms-traffictypediagnostic: SA1PR20MB4371:EE_|BYAPR20MB2728:EE_|CH2PR20MB3223:EE_|BYAPR20MB2728:EE_|CY4PR20MB1399:EE_
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;OLM:8882;
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2728.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(39830400003)(346002)(376002)(38100700002)(107886003)(76116006)(4326008)(5660300002)(55016003)(83380400001)(64756008)(66556008)(66946007)(66446008)(8936002)(66476007)(8676002)(52536014)(2906002)(6506007)(7696005)(186003)(86362001)(122000001)(6916009)(508600001)(38070700005)(33656002)(54906003)(9686003)(71200400001)(316002)(26005)(37630700001)(460985005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR20MB2728.namprd20.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: ff6d40b5-2cbd-43e3-aeb6-08d9e1e00bff
x-ms-exchange-crosstenant-originalarrivaltime: 27 Jan 2022 21:57:43.8146 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: e42a1061-f875-42d0-899c-d53fb15218ed
x-ms-exchange-transport-crosstenantheadersstamped: CH2PR20MB3223
x-ms-exchange-transport-endtoendlatency: 00:00:02.0936759
x-ms-exchange-processed-by-bccfoldering: 15.20.4930.015
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: F9WPRx5I+QK6MdAk283KlFfkC18lsr4aDV7roLV2y30HfzFBrvti093zxen/DonlFqL1wlBr1UP48xa/h5d05g==
x-ms-office365-filtering-correlation-id-prvs: ff6d40b5-2cbd-43e3-aeb6-08d9e1e00bff
x-microsoft-antispam-prvs: <CY4PR20MB13991CC06FE7EE32BA408435B4219@CY4PR20MB1399.namprd20.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: P5IpPRTzCAmIAkBet5bfVpzry7fR1WEtMkVvgqaV3/9PZIqHUF5t3Un3CDUKFym+obomVJPdJWKT3IfXH1qerVKLs8YkQZGScV+YtPSwSxos1Brc3M1woJusEjijKrojroEaZavSao1u7oPdk8j4nJNilhvUBWuxe1+uu0qu4sAa+QZW538v+osqyBo1aokJRYzjEjw0FIm1ndVb0hGB+KmMpybXplD1Oyz/Alo4WIAL2ETquck5mVLwzpPNIaktHiCXz3tgLxJv0Mx6pwBM6MhnaYYU0BI1C+lMJklTHifPXvihlftjDiCOymgM/mg9pLZE5tQe/4Ar1PgZnTwdmtFHQv9sUuvbD/kTP+i43HhYkzv0uCyZB1Tyj+CEPMF+QgS0BuZau7oCSYVnionS44KNutgyL6Gb18Dm7oAyVvoPsVzFASncNPpsnGCc9NxuVHBk563AY7yyxE2288btHhODsH5PXCjjFlxIWcUoy5f9LwO2GlE6OkGAKu/Mk6YpBjpmqNSp/MAlY92WIEnb+B9gO+NiT/3aHPqkQWQ9l57eBzAjYj0fCpn6TfIzRWegn6wJ205IQW6vU5mGODVhS3l4L6vHAZOsM0/p7O06qrw/FpZJAj7D18MY0HIvNpfJM7ABquKqUOKkItr3E7OaadhY4m+bZEUdnth9HMz8/M1X+tHvOOhNaX4zTRgWrgNKt0VmJ8eSq81NfAfDb/JTr4oaXHZdb2wh+hdMmVCrmhE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tXW02XVImMIRTTHotPSB95RfiU7xUYh6qYmXnYC0IG1uG+BzSO54w4TCLn?=
 =?iso-8859-1?Q?cbUD9NsGam1sOq3mDHB1cRsruSh0/VRxP8PsXnARbfL3cbwxTGI9SSgvxx?=
 =?iso-8859-1?Q?cAjUSSl0WdA89vj8ERrwkj89BgrlCMHBfkaw88qp6xBuDD15W4CeVEnGan?=
 =?iso-8859-1?Q?qSPo1b9TxEr09U6pntGSlezzvIMDzU0mTHFMsJN3T2mktzc2KyA9zcJlOc?=
 =?iso-8859-1?Q?ODoJmQ4HwpGAVimFM4GE30BpVoV3s+8RRG6ZI2gwXCImJjMQGtYf2MCQFD?=
 =?iso-8859-1?Q?kxl5VBWJU/RTIPrfhu9gomAJYASkYy7dRX1gvYU7It/xfup7P35HCzQeGY?=
 =?iso-8859-1?Q?6ow/x+hM5wR11pP3BM5+n/r1llo4tsNJWdiODNKtAAyNlisPsK6riJrUxT?=
 =?iso-8859-1?Q?+h3Q9xUHbn94/g6NGsQhYeG6mQOhP8h9Y5Xkma2Um15c+fqdHWeF+BjRB6?=
 =?iso-8859-1?Q?ntiUVIDoVOW/M3kbOyrAHTjlPPZtM2/Rk82g+jpfucpjCnANSo16eqfPir?=
 =?iso-8859-1?Q?N9S7C2HSFcsEWHFJIjkJVstNdyfbMOjJs5isVRXFBj9SyNnzdWB2HmLZT+?=
 =?iso-8859-1?Q?q4DS11q6/wpd29X+x+cHBrU40+s5JV6myGHwAMXUw/W+pF8hs2JumlgDz+?=
 =?iso-8859-1?Q?cjCHdL3fXqHNUBEm4cqNAdrJ0UZf81WB9qduirZWYCkEs6y+vX/52585hF?=
 =?iso-8859-1?Q?nRjGp+KWEM+62LWaHqC6i/a2LK3m5JP7jD8Jcn66GFR6NLX8HBn2MhsP5N?=
 =?iso-8859-1?Q?3Us+LfHYDwVqcKFSUBolc5yuGzaR4qT7hrGVa+4YspGavAOFzrjCXhup5p?=
 =?iso-8859-1?Q?bdQOLdQVRWR4PzvxvJquzuqirsaYSRFzVF4a0tibk7JPP+VwqfbK6RvYVt?=
 =?iso-8859-1?Q?iBIv7lbKJUxXS6YjlsmuWFlRASCvP/5tqCNp4wxh1IeWfW2TFTCX5crhhs?=
 =?iso-8859-1?Q?b8eE0vZlLwCkDS+4qEtAQaxGabu7/ps+f/RBZIXSL9aEzHxObJg9pWtKwF?=
 =?iso-8859-1?Q?qBUvgtHXhfT4p4YVWBhLiU3BX++8E7Q6h1whQbbltURdlqjD/pEJl/WrHK?=
 =?iso-8859-1?Q?0fHhdEpwEwNnS+DyA69+ExSHh4XHhU1a9QWTiNapA9NJu/1SfGTnTSLzI2?=
 =?iso-8859-1?Q?zJDKWKMjo9PDVy76vDqad0doxFySbmNR6K4VR4iAfuV/IdqvYg6ju8BLYx?=
 =?iso-8859-1?Q?z13W5HoxFz++dM7LUvysKcolggAuJeBMeeMmOdXO3gcE9/Bsdx8zAg6ODL?=
 =?iso-8859-1?Q?1fxyyq4oKAEton5swck5ma03xWhJ4uQOEupARpCXF+5tpbHnYMPF0cpEWb?=
 =?iso-8859-1?Q?QIfZ3qCnfv56S0HI/iHJxgqpiYel0ipUGAQIjVum1KsNcWIcSNnVsf4nXv?=
 =?iso-8859-1?Q?nn0WhRPA6H/IRhIYvP7a6anCkum17KQdk4qflQztL/1PdzDuVOMbW3nkQb?=
 =?iso-8859-1?Q?XXu5y1MXpD5gPRMXwh6TjiJUA9YNSVesNVY4irWm8gUsH4c2hc1/C+eLqj?=
 =?iso-8859-1?Q?XfD1eHDHjTkWmVyjgian1k3aqA4dxwZxnjXJXkBvLUJVSXPeLPhsBjXHHi?=
 =?iso-8859-1?Q?SIixQtHFICtu1zdYh0uic5+Sh8Pyk4UY9ycVW9V4Q1bwiFMJQhlyTgCb0T?=
 =?iso-8859-1?Q?Useo8Q9/3cfdugVmmJJrohZfyIs6l2Y4YEwkHS6sTJ90DY7ycgkUivBQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506458)(944626604)(920097)(425001)(930097);
X-Microsoft-Antispam-Message-Info: kJHmEhmHwSPS9zVKZzOrsyhAMyJueR7ECP0R0jPv7Fkhes+fydHPp4UwqgNh1cJK0YRRqozGUwaekBF5S7JEJV8DWlLkYBE1JfZGr46QFK0hc1TRgsJq5CGTw0j3m1/yRGoWObvvG66ZeLQLm6WX61HE7S/f5NiA1WckCs18dGRKy2BvdzUx+vJAhBetyVgtVu9UgXbWBfzc83ERsQvVvMS5LAa4M6HB9O70RUeMrrdbEga93urGXd1KSgYqPzxSpRdIC0B6/bRGdo3OuPPHkU3R2lFXS6EZ/jg6bNxPsn4tgDkO/gFr/+ZupRqOsj6SgwqQAaIFrMo38YAKH+D38Py83s0MKXd1Au/em7zwUeP4ZaSlEko+4ob2I+gegTdJ3QO87HCP3WfcYSv6VKT+xTUgKIEqB33t4GyHmlE6COPYqFZ5QOT+QnpPadT8uNsn9AYKpXqr/eKpju/qszMDVErRVUxyvR3rXlYHfmdvLJTFcD72gaocpjsoEXger8a3++YRGmOpy4H9tVRNFfoslaXH18+UU6RGTGFP/bdtqsxD5fxYdD3T8A0IEjOIFfvZ88lFqI0QVQRd15EK1ReqVHEL8gXKHuKGNVBCzBjmQ7j5D/Ylbm1FaZrj97xkF0hquqCGNmjO8p3PP9n/mRMJMuFEpabi1WmqvqNz7IIn8Sg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stratovan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2728.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1f8786-101b-484e-67c7-08d9e1e050d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 21:59:39.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e42a1061-f875-42d0-899c-d53fb15218ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehwCn0ancG3CSq2wEKYfM93COlKRRh3ZA2xhiUwMFZJlpb1gYWNSvvB+2k7ntVcfmYb3WyLsX4UheE8ojSD2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR20MB1399
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was attempting to find the oldest commit for a file that has been moved.

I can get the entire list by using the command

$ git log --reverse --follow -- <filename>

However if I add=A0 the option "-n 1" or "--max-count=3D1" to see JUST the =
last entry, the command displays nothing

If I remove --follow, it will display the oldest entry for this file in its=
 current location.

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git log --reverse --follow -n 1 -- <filename>
git log --reverse --follow --max-count=3D1 -- <filename>

What did you expect to happen? (Expected behavior)

I expected to see the oldest commit information for the file, following it =
through renames.

What happened instead? (Actual behavior)

Nothing was displayed.

What's different between what you expected and what actually happened?

I expected to see the appropriate information.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1.windows.1
cpu: x86_64
built from commit: 05d80adb775077d673fab685009ede4a1003ed92
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19043
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]


