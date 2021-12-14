Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC53C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhLNNMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:12:16 -0500
Received: from mail-bn1nam07on2060.outbound.protection.outlook.com ([40.107.212.60]:58459
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231987AbhLNNMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:12:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrD+KeFni2XGM4cOZNgsOEkf9IRpiokTTjKbD2W87i0F669FpPNEXNLS4Bqnf7JxxiQBZ/CQd2UIsLFbVqBXObrkddnxqh6r028Du/HItb4fh9oC1EiSffO/dBU8A1jIbkvRA4Z2lj09Gxx715Cy6I4ZCShl4cCr7dc30eHsmcJpWtYKoVU0iSuCHf3RE4YPES4XUuuRWUMO6Eg4L4vAnq6Ah9rVWG+KDeCIvBsa9jdZF2X6jE/ZA8GbuwQJ+lwJ57hGW9gq7i5isfliU2nzdYak/VR9ehkZZPJQOUTOUcWNFixdwI8vF+X+H4NqAGzOWyrd4s0g+1UpELdPRavyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFYJl0Xg9rPQjwL+9pDW8B/7mMdo1v6eG/YsozhaeAY=;
 b=a4VPcC12PLxYPQnyJF5c9OUFVp9uos6kCIISFgB3baJ4ohOCtQZk1ggkGTPAeeoBablMP/ne8tOVTn6t+FMHw5QbSRZbXf83Lc53oHYrqvo+4y4FogM9hAeiXs4JShQMr+mVomZVGMdZYZd5p2FyuBy/iqhGyHwMjj3l2KG2OyrCzHjZaTf3aho0giLGSZpw8HrYlRE1SMBfmarf88feQmCDGfr46/YX0y8Cbr80MHhIi73c/9y/dz2SyWdybXZG3roey+fQomhCVxKSkBKFNgr0+YV45RMbXOggF2QHadq3jrCgIwS7cefrySG4MEZcjHZBetpToevwG3zTLxP+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFYJl0Xg9rPQjwL+9pDW8B/7mMdo1v6eG/YsozhaeAY=;
 b=lb/QPTiPnakEFJ2lzCVEpWUtEviC7InmyuxQU5/A0kRdokdzKqQ4N3OgjsVsb27Wjeh0KFSBHRyGO2P602Aa2XTACDgUZohyX8aKZ+w/o5qKuRKhX0bz5hj6JAV5yg+3SVvuA9nMIWgeJj3aN1qIavOppVhXJMDfDmAO9yAateFwI+9qND0ZFXeLe89vXE+482KK5NKmr6zylS6dl+yb5IrcUpNRtYD//neJgHiiaUt4HE9ORfrNndPRps3lJlkJ4V617O9XSb1R2qVtG7kPX8h/WCN8ZQlcOxjSgzUhJLpoY6rlljkDxH4BeuZ1zK0Sx+jZ80FbD9RK6d1dqlhLNQ==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 14 Dec
 2021 13:12:13 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 13:12:13 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH 4/4] git-p4: resolve RCS keywords in binary
Thread-Topic: [PATCH 4/4] git-p4: resolve RCS keywords in binary
Thread-Index: AQHX8HR7HB5+NQAEyEGSCX9wHLhEVawxEzcqgADeXgA=
Date:   Tue, 14 Dec 2021 13:12:13 +0000
Message-ID: <BN8PR12MB336146CB8B6FD458AE3BE42BC8759@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
        <20211213225441.1865782-5-jholdsworth@nvidia.com>
 <xmqqzgp484f3.fsf@gitster.g>
In-Reply-To: <xmqqzgp484f3.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 576a9fdd-6f33-4b4d-de59-08d9bf035802
x-ms-traffictypediagnostic: BN6PR12MB1620:EE_
x-microsoft-antispam-prvs: <BN6PR12MB162092D8216FE42F6A582E9EC8759@BN6PR12MB1620.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMvjqPr0oXqJ17iKP+te7O6a50UV4QRbSWouUWoew928uKpIlHnbCMqDpSjPoErhBPIqPDJumz4ooT0WO7GunJ4sIwjadyxqBO6brUiIbz65ojHmQnqX5aXyZMICiZ59MrwaQ8zYGUEWejBiwq5vepsQVODaYhN9Knbnxld6+RDrz9Z/n5yRwsTw3+eVMhnk1iB/tHKeANMpEMI5Hxp1CpHFecvUyh3bOuCKOVKn9yx0aeq3pu45Ut3xNZD6Fl3fOTZrT+7k661RLRnZo0kiFElIKzMGGj1cbT7K50YTSuYnITUtJf6LD7nv4g9H4ZufDKAkxrcJDHHENjsYGMwSEFg26tTVZh7CjZd+Vv0f4FgS51deDkbuBFlFCwPoDls01+B2OaDgPqK8vmqVE4Q93BYgOEBCYFPpH8kxxob7TQlAxeTCeiqcvXDU4Ey6n6xdcENX5T0ghUr5CJHuxyfY1SPJn+ce9DbD4waFVb3ZrlNkC4ezTUcfOhV73jgXGYoPRJ28t5dfyW17CH7f4vzgZff4NAm8bc6sgDmMvT8vhyMC5txuFvo9MXFAbrs1dZFWFIGyjDWk8vdnTuY2V7mHI17ay1qRtkOewhcK418boVDpJgUwh74RoHf0XLdMe+WijF6gdV4TBTFGEiGvmUx7mLpkxkw5dxsppRTIH40iLXQtWznqaT2xmVCTqckOBBsuARPK5U+YlcByIxmyEmdygQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55236004)(4326008)(8676002)(6916009)(55016003)(66446008)(316002)(26005)(86362001)(64756008)(122000001)(66556008)(54906003)(38100700002)(71200400001)(7416002)(186003)(76116006)(508600001)(5660300002)(6506007)(38070700005)(66946007)(33656002)(52536014)(7696005)(8936002)(2906002)(9686003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bGb58wJuN7tctJVOv+agpxq6LEvm70jan0K8P6fckBWyPRXvPSHEWl+CJ78K?=
 =?us-ascii?Q?NnptCtpJlElWTxuBplf12E3JfK4Q2DfTkucWitFmWzhzvwPshWBCxDtfdhFG?=
 =?us-ascii?Q?YRCsQNL6yXnLalny+A8G0asnUDKprUsnjz7LNb1T7Fmar2uJO/bH4Sc8QBgz?=
 =?us-ascii?Q?YJ2aaATuRW8rFLGVR+bD0zIA7ahpAjr7tDp3DUq6HiVkA0OzsEguVyJdhC86?=
 =?us-ascii?Q?j+4qoZ3MfRZn1Sg/xOiMPeI3Tt7P2o1B1WECoOh/cMHU8fqs6yXuD5BCNdGa?=
 =?us-ascii?Q?ZWq3wlM3azMnEHgndl7p6DfSgfbTtoQpYAXtAZNEdSswma7+8FDttBah7QB6?=
 =?us-ascii?Q?0VYTAFbNKSkl/2CXkz/zFFqYRBwQ/UdbMZTiUpX1rFUAzepkCNSLapowg6ss?=
 =?us-ascii?Q?KndIQrgxdbxXk6l+CS+/r9zhqIcHhmezA5DR3PBmsyo6mbpWUUV+pAZKJmvy?=
 =?us-ascii?Q?pHNq3lVMHEAGvkTnAlI4xZuH3e1+Ebs5anNqY7PgBk12JeUYoTgJWW0cxH2b?=
 =?us-ascii?Q?ve5C+LmwxiG1ZjW++B6v56mV76/KnHMTlXHT/NcozBk6cHViOa9meUcMXQaI?=
 =?us-ascii?Q?t2jOkinph8poBOCNaoVAY5JBLAdcKK2fjOHZogLsxfSXM1HR5oytavsuwDar?=
 =?us-ascii?Q?0wfFpdAuFH4P55CAMSqVLzPaeLgZku9IEOzalWggxXKN0Fw5UuXeDOsqJWBx?=
 =?us-ascii?Q?/xVP/VWka7Qq95ZJ2/5A+XhNg1OpZz3vD746fkulwRMObHWIW+55LlM9zDML?=
 =?us-ascii?Q?Paa91B/KVmsyeO049q5RxOGcbgH5qhVTzJIu0DVShkbWgicKOuLW3ZJ5stu9?=
 =?us-ascii?Q?r/xgVNX3hNB3nu5JUb2cTlmR9zdoecrv6h6557J76fJlov+YdnZwwtdT7RT3?=
 =?us-ascii?Q?8/Foi6x2Yc2DXPNjGwUwETu4AL1nsWKHiD+TayT92EIywAyF9Kr5v6rVs6nl?=
 =?us-ascii?Q?CQRib38hWW3fKMGoUw8SREhulxAB25Ro1vO88QZllrs7aLr1t4STFIx7rcOj?=
 =?us-ascii?Q?BlyvuJDVtXkVtL0ey3eQ1V7FYU/vVBSEfQhewx/vW1SQUC+UdBYtt0vBqJfU?=
 =?us-ascii?Q?qi729+3UBMTx394T3PwTLUNBTeBOJvq8E2Xg9aFyb11dFTonoBPERtYtcm8h?=
 =?us-ascii?Q?126wZ1JCt57ilgtQumuGwI4TCSm8x91nNEHNhskzXQ6QXsYOmUIx0fdSJAnk?=
 =?us-ascii?Q?KCPX2aab4glGmln0u6RtowC6nM3fjQOKBXbXNmIFJrBGUqwOrQ04JhJSw1Vi?=
 =?us-ascii?Q?8GKBVe3OYpI9RQw7XJ2oPL/HbJqUiSir4goL8lHliVwHeT10Dlf5oW4MtVRX?=
 =?us-ascii?Q?ODhRZuAhS6uPr7PwsCn2r33C2GeEvB0cEZVTupICGibwFghB2xS2rpupniWr?=
 =?us-ascii?Q?cMGFS2kR2u9U2ZXxCmtG1fHzlz5Kutw/oMRespX6B9g62n0K7hZhgxt2/Fsg?=
 =?us-ascii?Q?50M+F+J/ULIPty0jZasJR0yC85dVKskzE4c/r2sMCvpBui4zx6N3mZRws9pf?=
 =?us-ascii?Q?5GLyzhR8Uj5vq/CZHcYTPijEzxevsPJb1ZPHlktDdX1ICaOVGkn8nf9E5JcV?=
 =?us-ascii?Q?BkAgNn7KQWSqLqkzPCuQDfae3Ux91YnanNuKeogF5D/FBXjcxGo33foieZl5?=
 =?us-ascii?Q?Z6kRsdD7MbJ2qzPdrgj2K8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a9fdd-6f33-4b4d-de59-08d9bf035802
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 13:12:13.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEIBFZwS4HkqMiLXUaRORXO6HE47wQaRRD+8LDONmFWAWQAXy7mZ34MU7N+a5Ahl+j2OX5mCDFtHaKKjW9DmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Makes sense, and I am with others who commented on the previous
> discussion thread that the right approach to take is to take the stuff co=
ming
> from Perforce as byte strings, process them as such and write them out as
> byte strings, UNLESS we positively know what the source and destination
> encodings are.
>=20
> And this change we see here, matching with patterns, is perfectly in line=
 with
> that direction.  Very nice.

Not bad. Fortunately, it's not possible for $ characters to appear as a com=
ponent of a multi-byte UTF-8 character, so it's possible to do the matching=
 byte-wise.

>=20
> >          try:
> > -            with os.fdopen(handle, "w+") as outFile, open(file, "r") a=
s inFile:
> > +            with os.fdopen(handle, "wb") as outFile, open(file, "rb") =
as inFile:
>=20
> We seem to have lost "w+" and now it is "wb".  I do not see a reason to m=
ake
> outFile anything but write-only, so the end result looks good to me, but =
is it
> an unrelated "bug"fix that should be explained as such (e.g. "there is no
> reason to make outFile read-write, so instead of using 'w+' just use 'wb'
> while we make it unencoded output by adding 'b' to it")?

I am happy to split this change into a separate patch if this is preferred.

Joel
