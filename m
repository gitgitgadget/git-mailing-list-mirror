Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EB0C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981FC208DB
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="g01gUnen";
	dkim=pass (2048-bit key) header.d=paychex.com header.i=@paychex.com header.b="tgknDO2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgFRVHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:07:45 -0400
Received: from s1-ba64.socketlabs.email-od.com ([142.0.186.100]:65058 "EHLO
        s1-ba64.socketlabs.email-od.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgFRVHo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 17:07:44 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 17:07:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1592514459; x=1595106459;
        h=x-ms-exchange-crosstenant-fromentityheader:x-ms-exchange-crosstenant-network-message-id:mime-version:content-transfer-encoding:content-type:x-ms-exchange-senderadcheck:x-ms-tnef-correlator:content-language:accept-language:in-reply-to:references:message-id:date:thread-topic:subject:cc:to:from:x-thread-info;
        bh=o9xPmu2Hav8kEkcnTi288j32EJfUw+i2S/IharZy94s=;
        b=g01gUnen/nAXFQpsj736AYeqwWsgCRklehb4C+U95NrkNX5fugHbxWoplLDbVqdOHJvq6DOfnm+WCw8Hebzp1xUVDkiuMo3L5uB6TznCpUBpqavU5NLe7tXoi0OMY2A8eRclIVd9e2LMLTQOFvLLBWjCKwPbXoVvG8PsNSD6KMg=
X-Thread-Info: MzgzMy45Mi4yMjJlMzAwMDEyMTI2ZmMuZ2l0PXZnZXIua2VybmVsLm9yZw==
Received: from r2.us-west-2.aws.in.socketlabs.com (r2.us-west-2.aws.in.socketlabs.com [142.0.190.2]) by mxrs3.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Thu, 18 Jun 2020 16:57:35 -0400
Received: from paychex.com (mx0b-0018d001.pphosted.com [148.163.159.161]) by r2.us-west-2.aws.in.socketlabs.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Thu, 18 Jun 2020 16:57:32 -0400
Received: from m0093316.ppops.net (m0093316.ppops.net [127.0.0.1])
        by pps.redirect (8.16.0.36/8.16.0.36) with SMTP id 05IKtPUD019001;
        Thu, 18 Jun 2020 16:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paychex.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp012218;
 bh=o9xPmu2Hav8kEkcnTi288j32EJfUw+i2S/IharZy94s=;
 b=tgknDO2FOGFCfmKCT7imAZkytOBT2e0/GdfG/KU57e/caitpEyOsWvFTjxHbZkBjcoSA
 LDBToEGGERBPssI5bAeozbWaGVYEs77JqqSL3rcVP41LWsFEuomJeyBYb+thUWbesmGh
 yA/yhJDIzAxOp0lBqCRiH6kCpDeCSJqh/hcMLfQ436H6BA4D5MHKbzpsrYakqD2daMJ9
 Lj7KX6WIKUjMJfmlkB10IZEAjNJ0+KB8To2Z/sNMEI2qMBpDFA3cNqcgQF+9vX39LdYq
 jS6O3uOKl5kQ6C4sGjir28HhZdQIf0H2XK9kZEVfDPaluxykNeybm/7SPKDGCNkjnW1T JQ== 
Received: from mailin14.paychex.com (mailoutoma.paychex.com [141.123.64.135])
        by mx0b-0018d001.pphosted.com with ESMTP id 31rcaegsdg-33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 16:57:31 -0400
X-AuditID: 0a2c1235-229ff700000069bd-e3-5eebd5392ec0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoNy0irv9Dssswf3WFosRl+6n+h/d5dtH4kMmHzouea+Y0zzjVSutGkiL7ZtNC4hTWkbpuXpqqIMr6IgLBdsMR93OSuNVVey87Vg/tx2FCrOohsuCBz1lwBWhXDUABHXdv4EhjD7KRPIkTS1U+gFJZxfEwtgRoDTaVaO5FURCTtqWyQlJaSp/Th6gu6mvyEO4knpXcm9G0hSXLIZaiaScBf680/dY1PjtgTGM4RFt9WArg8RyQdJMjSWf7irLP1RO4VADUYoyBGREc2JjXRRm+YPezTZ2rEE9YikVI+RFdPrVFN362nL2VR1YxEp4bSv1pkgM7X/c3msPiRNsW0szA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adRBt26kDXB/nJCV0gGH2jZUNocRvyvzeI1GAGZcwM8=;
 b=fFogS95gKBwviTlYS+6++X2jw6BZBlJXQ6kwIiE0IzKWm0OF41v+OKvGA7EnSw+/Kw20JczCVwFxBd0nosCyiRkhGs2+0uoEIPztbbTrx+QT5Ekd3on/2Xj6c20dB8bl4PnEqPCqKgYCrBbl6PJyYS8Oujg0eoB4Poy4UukBUGmy19RQeoVo/UFh9qvaZs09yyfsZ0qr8zmkj0c83pYgZQLHIssM7n4MEVf7f/ndPfzv4tD8dVhX5sIb7qDv02fnzUpeqkAtcN0RDynH6ZSOtGg4z0MeV6ak4CS50j6toFW7E5mWJNEpam7GG5tGH7kzofAlzHIom2uukr3ZYIxa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=paychex.com; dmarc=pass action=none header.from=paychex.com;
 dkim=pass header.d=paychex.com; arc=none
From:   "Riddell, Matthew A" <mriddell@paychex.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git config command ignores explicitly set file permissions
Thread-Topic: Git config command ignores explicitly set file permissions
Thread-Index: AdZFclKHAfiqC2yfRMecUkQo1I7KfAALJnuWAAQVWAAAAEC40A==
Date:   Thu, 18 Jun 2020 20:57:27 +0000
Message-ID: <MN2PR02MB66237FBAE6695D80B1182BA5D89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
References: <MN2PR02MB66232254F5F4BE27F21C441CD89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
 <xmqqsgesns22.fsf@gitster.c.googlers.com>
 <022601d645af$45d0e640$d172b2c0$@nexbridge.com>
In-Reply-To: <022601d645af$45d0e640$d172b2c0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nexbridge.com; dkim=none (message not signed)
 header.d=none;nexbridge.com; dmarc=none action=none header.from=paychex.com;
x-originating-ip: [165.225.39.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 913166e2-f902-4011-5516-08d813ca358c
x-ms-traffictypediagnostic: MN2PR02MB6174:
x-microsoft-antispam-prvs: <MN2PR02MB6174E5116D94DDDA3F3435A6D89B0@MN2PR02MB6174.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JrZo11GKYliQj9CCV50QTofthxH+BW1ymG7yXOD+DJmTiTQBOBIeZr7QTDRDpyGUItklwF0w5JzEMJcrvOUzKetsuuGtNCdRaa7sngmxqA9kJJ0zESjUVDNBp/WBIhUBd1PURaLjxVfZRWxjpdxWy2MDsoscfVVBlHOfqvh5gn4mzz+7uP5eeTG3FhsFFK5/7Jm9pwhDvBpk/SxlVKwPbEemlbUde8T/FDE0GeN6/QkacfFzHRerjfFvDAFeeGtb1AjR3h/ylRiWhr7PMeQRKNtGQgRpSffrCFoL8DEZMGmbIH5+gHyVM25YN5KBu7W4FS+RE2Uk78KPvwtPgAwnhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR02MB6623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(2906002)(478600001)(55016002)(7696005)(9686003)(110136005)(8676002)(6506007)(83380400001)(71200400001)(53546011)(186003)(316002)(26005)(55236004)(8936002)(4326008)(33656002)(66556008)(64756008)(86362001)(66476007)(66946007)(76116006)(66446008)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RqOK+fh1fi2LFXH4eP2noIh+lN5RL6ktwjs+0FYEEpa7g0fnbhWd2ufSDqPrf220uZrMjUcGXCznpUwmve/g7PjK5QKxi20d40tp7exlEim/bT8rV+9L2mJLyV+/44wvl6NG8Gw6Co1W4nQbBBmEwbYI2ZWer8/Sf28E3zV53o0OxDHE1y7c+KH+TmqjGdDk9g68EDDoVz2M3yv8k0aIMgpz5e+79qyAoBmh0TLvNg6niGFyBsRQUdJeVFJuOoIdQQbuK31+tXS11kifTNNcliX77yWVvfA21OgYcQ651iDq2S7V1gkjoMLce1CfJapGf4Tiak4R/MrEd6TwkGg9xY85ddNwDC3DTIsxNfyW4bMHtdOkq+/Ll0ZR4xU7pF2FSHNEi/dQiEdbVvQrZ9MEyC/w9WekNAvHxwWbBjr6LAW8pDOYNTppJDYP6zrUjdQktAYi0jWUAjYMY6GVlZDlEcPoM+q0d4qGw2JiRFn9P7Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 913166e2-f902-4011-5516-08d813ca358c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 20:57:27.3863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcc529c5-dfce-4f97-b44f-debd50891d83
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dsyQYiD6shTCah0ms1udFV4ZKAlZBH+JAGfX/xG5AMTHF+zONMH54ZsavJqu3kgZc9zBhPoMm9Hd3kxoedbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6174
Received-SPF: Pass (exetpnv02.dmz.payx: domain of mriddell@paychex.com
 designates 104.47.70.107 as permitted sender) receiver=exetpnv02.dmz.payx;
 client-ip=104.47.70.107; helo=NAM10-BN7-obe.outbound.protection.outlook.com;
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42Lh0mVh17W8+jrO4NR9G4uuK91MFg29V5gt
        Xm1+wezA7HHy9ARWj4uXlD0+b5ILYI7isklJzcksSy3St0vgyli64C17wUW5ik/tJ1kaGNdK
        dDFyckgImEi8+PecDcRmFFjGLHFhQ30XIxeQfYpF4sbm90wQzlZGiTVPfoFVsQkYSlxbuJsF
        xBYRiJDYceo4M4jNLKAv8enPASYQW1jAXeJE/01GiBoPibbuZawQtpPExxd3wOIsAqoST3ou
        gs3kFYiR2PlyLSPIMiGBXYwSK18vAhvEKWAjcWxaK9R5YhLfT61hglgmLnHryXwmiBcEJJbs
        Oc8MYYtKvHz8jxXi6imMEhvvzWWBSChKnHjcxwZhy0pcmt/NCGH7Svy9dRaogQPI1pLYeKUU
        Ipwt8eHTfagSNYkbbzqg5stIfFuxlBXClpNY1fuQBSb+4MZ2NpC9EgK/mSQmr13KCuG8Y5Z4
        eHgmM4QzgUVi49PtzBDbVCT+HaqcwKgzC8lDELaOxILdn9ggbG2JZQtfM88Ch5KgxMmZT1gW
        MLKsYhTJTczMycwzNNErSKxMzkit0EvOz93ECEoiOkKmOxjXblc9xCjAwajEw+sQ/jpOiDWx
        rLgy9xCjBAezkgiv8+8XcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5/8afjRUSSE8sSc1OTS1I
        LYLJMnFwSjUwSiu/jPJm0A4SS3C/umf2rbsFi19cU52tmTZrXvCDRZ9fh0tGPZ2xlPt76Snt
        iYz6u79Wt0ZffaivI7Nf276S07Saa7lCygahvpsFf9O5So++DNPU0f8noffFYGdMUsv25Cwh
        qWUSD4Qimu2f+foxRv3axz3NLt53lfkZjaXftL+4fdBXyhBWYinOSDTUYi4qTgQALRWGcB4D
        AAA=
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details-Out: rule=paychex_corp_outbound_policy_notspam
 policy=paychex_corp_outbound_policy score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 cotscore=-2147483648 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Riddell, Matthew A" <mriddell@paychex.com> writes:
> > I noticed while working with Git that the file permissions on the=20
> > gitconfig file is ignored and the parent folder permissions are used=20
> > instead to update the file.  An example is as follows:
> >
> > Before running git config ensure the user running the command is not=20
> > able to edit the file but has read access to the file. Ensure the=20
> > User has full access to the parent folder.  After running any git=20
> > config command the user previously without edit permissions on a=20
> > file can now edit the config file.

>>Forgive me to asking, but is this an attempt at replicating what other VC=
S systems do? ClearCase is an example where files are forced to read-only a=
nd if the user wants to modify it, then they have to ask nicely for a >>loc=
k on the file. The use of "read only" is a semi-guarantee that a user will =
not modify code and interfere with other users. In git, the rules are quite=
 different, where modification resolution occurs later in the process.

We have had problems in our continuous integration environment with builds =
modifying the global configuration of tools. I came across this issue tryin=
g to lock down our git global configuration for the local user running our =
builds. The workaround I found is creating a symlink from the user home dir=
ectory to another folder (which has read only permissions) which contains t=
he actual gitconfig file.

-----Original Message-----
From: Randall S. Becker <rsbecker@nexbridge.com>=20
Sent: Thursday, June 18, 2020 4:30 PM
To: 'Junio C Hamano' <gitster@pobox.com>; Riddell, Matthew A <mriddell@payc=
hex.com>
Cc: git@vger.kernel.org
Subject: RE: Git config command ignores explicitly set file permissions


Warning: This email is from outside the company. Be careful clicking links =
or attachments.

On June 18, 2020 2:32 PM, Junio C Hamano wrote:
> "Riddell, Matthew A" <mriddell@paychex.com> writes:
> > I noticed while working with Git that the file permissions on the=20
> > gitconfig file is ignored and the parent folder permissions are used=20
> > instead to update the file.  An example is as follows:
> >
> > Before running git config ensure the user running the command is not=20
> > able to edit the file but has read access to the file. Ensure the=20
> > User has full access to the parent folder.  After running any git=20
> > config command the user previously without edit permissions on a=20
> > file can now edit the config file.

Forgive me to asking, but is this an attempt at replicating what other VCS =
systems do? ClearCase is an example where files are forced to read-only and=
 if the user wants to modify it, then they have to ask nicely for a lock on=
 the file. The use of "read only" is a semi-guarantee that a user will not =
modify code and interfere with other users. In git, the rules are quite dif=
ferent, where modification resolution occurs later in the process.

> That is pretty much how things are intended to work on a filesystem=20
> and is not limited to Git.  Your arrangement, contrary to what you=20
> said, does not "ensure the user running the command is not able to=20
> edit but has read access".
>=20
>     mkdir newdir
>     chmod +rwx newdir
>     >newdir/file
>     chmod a-w newdir/file
>=20
> would not forbid you from doing
>=20
>     rm -f newdir/file
>     ehco new >newdir/file
>=20
> In other words, if you allow your user to write to a directory, you=20
> cannot forbid the user from creating and removing files in it.

Just inquiring about this, as git operational decisions are fundamentally d=
ifferent from older systems.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000  UNIX developer s=
ince approximately 421664400
-- In my real life, I talk too much.



----------------------------------------------------------------------
The information contained in this message may be privileged, confidential a=
nd protected from disclosure. If the reader of this message is not the inte=
nded recipient, or an employee or agent responsible for delivering this mes=
sage to the intended recipient, you are hereby notified that any disseminat=
ion, distribution or copying of this communication is strictly prohibited. =
If you have received this communication in error, please notify your repres=
entative immediately and delete this message from your computer. Thank you.
