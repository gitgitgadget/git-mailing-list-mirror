Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED55CC11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4D6208C4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SZBB899/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgBTT3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:29:40 -0500
Received: from mail-mw2nam10on2096.outbound.protection.outlook.com ([40.107.94.96]:42721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728248AbgBTT3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 14:29:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFWKijWiI1b1mnpRCKRpep5yPUklbDt1IXpdm1hJrorhNAeA2xlIXUk0fUM7VDHbGqd8oR/5BefzW3pXHPbYDTsEef82b6KbUW23MO+wEvMtVrpeCmXKAd4l+C19bASllG9LW0WcmDCXO38I5DwwxlwEut1szBYZtTCnKzK4KTSltEsznL4rGIuvC7+Tc0npFOhxu827Hs/VawN0Cm9PgznjImD/x7JxkgP3XGJhK0u04MiwPLGEMbFUaNDdtUIvICGMyVlEHNr9MxfOQ//d5s3X1966gAs20MdYi0KD0rF5roC3pKFWajsqfUF4S6uAgSy6LyIAML8zpj3IktwEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSDfC0zE1aGauOGl81e0s3LZRTODaYD33YfnFDoacY8=;
 b=Ct94zaoeHRNR0sADeL/d6wI73dt9VrxSTwr3Fa6LLO0f57mvJd+CF6b6K11f/pG5eH73VQKF2l1IQhNDiclRXxEMFyFRxkWQcvTL8LbLFoK/plDZhCHNzxoBb9LPWmWelEDvvnSKKcGQtCZuqCNhDsOwk+rzTKyaARTrM+ZooE6mDgRHNKCZYbKqlOfZQdx11sSW5CrGIkxnjkGkcXO6B2Uc0oPyL+/fABK9jxdABwtDWSyU+7DMf04NwH3g/UQnqGECLVSArcXtC9TQgs1hulnQ+eo8loFaIPWOtH5yIK6/oZ6zJBIJod90DZ5Frdm6k2wgcjnpihLZcbKH68dGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSDfC0zE1aGauOGl81e0s3LZRTODaYD33YfnFDoacY8=;
 b=SZBB899/itUDZKtucmAdQ/AFpkREMqZq+5331F1l3VASVP/ApdchYxwKcY+TTR6XVeLPagS4uvt2pWqfHL+IrYyNoHbnW/Buy76tJxSlSom0gpMkAmYcA6IH/l8ipeMa0NAmQdU8ic8P5HCRCmPoTQ6f7QAPra8+BufRqxOSNZs=
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) by
 BL0PR2101MB0881.namprd21.prod.outlook.com (52.132.23.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.4; Thu, 20 Feb 2020 19:29:37 +0000
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe]) by BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe%3]) with mapi id 15.20.2772.002; Thu, 20 Feb 2020
 19:29:37 +0000
From:   Adam Milazzo <Adam.Milazzo@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Daniel Knittl-Frank <knittl89@googlemail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
Thread-Topic: BUG: git clean -d cannot remove files from read-only directories
Thread-Index: AdXoH54AwymbjpaxRJ+OGvDl8+8sgg==
Date:   Thu, 20 Feb 2020 19:29:37 +0000
Message-ID: <BL0PR2101MB10899B3D9499E43B59F6D55680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=admilazz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-20T19:29:35.8373868Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a538bf11-73bb-43cc-a582-c96a1d3d1127;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Milazzo@microsoft.com; 
x-originating-ip: [131.107.147.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e374b208-1b9d-4432-7b70-08d7b63b391c
x-ms-traffictypediagnostic: BL0PR2101MB0881:
x-microsoft-antispam-prvs: <BL0PR2101MB0881D6B234E271208236CDB280130@BL0PR2101MB0881.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(53546011)(9686003)(6506007)(33656002)(55016002)(2906002)(26005)(186003)(7696005)(66446008)(71200400001)(8676002)(110136005)(316002)(66476007)(5660300002)(66556008)(4326008)(64756008)(66946007)(76116006)(52536014)(8990500004)(478600001)(86362001)(81166006)(10290500003)(8936002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0881;H:BL0PR2101MB1089.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UILaw219IDqnFgGVvk9aDa89YOkXfP1NH5js3Sg4fea8WaMsk6VrwdxJfcUWTPXRVeZT65pKWmpOwIPUlMK196ttxrVl8hVK0wH5xcN8ELu5TGP3SpDiGl270dcuBfp/LBH02Dv3rQUjTIWGjRuOsQzEeXG/N3wD7uy93GTTqrvHR30vsHBGhAJIR03C/ugw+o++vLygt27Z1c1Pt97qclFrTppPfOA2ESHHtnUKG6au9fSHA/3LJ48VM01MB+e0Tw+DC+O6CXhVqLFjrXkIb02hLqBTl9Dqk9do/srif/TSfMaVLh3hEY9IHyBQ0yQEwvQeVUAvw29XlhWdGRe24kUzKXQsdfzf60c6zpbq8wj2o+FzmF5YMGwFz/VIORcJ1OVH6QgzBM9tn4FLNqKBdUexmz8V6lBwCyclTgMrhA0oJLJK55eIzYlwMZcU0M7N
x-ms-exchange-antispam-messagedata: 7TNgMr0AjTLTdcT593FtqqeooU2H1QUaSl0xxIrv8hD1FEXKBbRXsobZAOv4/ZMMFAT4h5qFsGMN9fjurR95Yaw19pn4f/TazqW/FgQPAgCAwF+jj/huYKJFppygXM94AzE9fGi6w2+lK+9uxCzxSg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e374b208-1b9d-4432-7b70-08d7b63b391c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 19:29:37.1859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQjLuXlb5axYc221+GQckAEpT7IiDlMM8mSsRYNOCEROFRvoQO4GQj7jFPuspV0z60nYwqpDU2YOTXc6cTcHeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0881
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your explanations. I don't think "git clean" must necessarily=
 mirror the behavior of the underlying filesystem and must be free of any o=
ptions that implement a different behavior.

What is the purpose of "git clean"? Broadly, it's "Perform a mass delete of=
 untracked (or, with -X, ignored) files to put my repository back to a clea=
n state". I would argue that paying too much respect to the permission bits=
 within untracked directories that we're planning to delete anyway goes aga=
inst this purpose. Consider: why pay such respect? If the answer is "to pro=
tect the user from accidental deletions", we already have interactive and d=
ry run modes to do that, and at a logical level, one might expect a read-on=
ly file to also be protected. (For example, "rm" will prompt for confirmati=
on before deleting a read-only file, though "rm -f" will not.) If the answe=
r is "because that's how UNIX file systems works", then I'd wonder why we s=
hould be a slave to that. (If the unlink syscall returns EPERM or whatever,=
 you can check if the permissions on the parent directory may be the cause =
and then change them and retry if 'git clean' would be deleting the parent =
anyway.) In short, when a user says to go ahead with the mass delete, and e=
specially when they say to "force it", why not do so?

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Thursday, February 20, 2020 10:48 AM
To: Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc: git@vger.kernel.org
Subject: [EXTERNAL] Re: BUG: git clean -d cannot remove files from read-onl=
y directories

Junio C Hamano <gitster@pobox.com> writes:

> Adam Milazzo <Adam.Milazzo@microsoft.com> writes:
>
>> Repro steps:
>> 1. git init
>> 2. mkdir d
>> 3. touch d/a
>> 4. chmod -w d
>> 5. git clean -fd
>>
>> Actual result:
>> Git doesn't remove anything, saying "warning: failed to remove d/a".
>>
>> Expected result:
>> Git should remove the subdirectory 'd' along with its contents. Note=20
>> that git can remove a read-only file (touch b; chmod -w b; git clean=20
>> -f) with no problem.
>
> It is how UNIX-like filesystem works, isn't it?
>
> As long as a directory D is writable/executable, any regular file=20
> inside it can be removed regardless of the perm-bits of the file.
>
> 	mkdir d
> 	touch d/a
> 	chmod -w d
> 	rm d/a
>
> would not let you remove the file d/a from d/, exactly because you=20
> cannot modify d/ (it is not writable).

I realize that the above is probably a bit too terse for those who are not =
familiar with the UNIX/POSIX-like filesystems.

A directory is a record of what files (and subdirectories) are in it.  If y=
ou add a file to or remove a file from a directory, you are updating that r=
ecord---so you need to be able to write to the directory.  You do not have =
to be able to write (or even to read for that matter) to the file you are a=
dding or removing to the directory, because adding or removing a file from =
a directory involves only updating the record kept in the directory about w=
hat files and subdirectories are in that directory (hence you need to be ab=
le to write to the directory---but perm bits on the files you are adding or=
 removing do not play a role in this operation).

A collorary is that modifying an existing file in a directory does not have=
 to change what is recorded in the directory---what files are in the direct=
ory does not change.  You only need to be able to write the file, so you ca=
n edit a file in a read-only directory. =20

Note that some editors, however, implement an "edit" as "rename the origina=
l file as a backup, create a new copy of a file, and edit that new copy".  =
With such an editor, you cannot "edit" a writable file in a read-only direc=
tory and the reason would by now be obvious to you once you understand the =
explanation above.  Both renaming the original and creating the new copy wo=
uld be updating what files are in the directory, requiring you to be able t=
o write to the directory.

Hope this helps.

