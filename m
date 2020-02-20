Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0216DC11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14A6208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G9lvZFpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBTS13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:27:29 -0500
Received: from mail-dm6nam10on2105.outbound.protection.outlook.com ([40.107.93.105]:47392
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728334AbgBTS12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:27:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkK+PJ3lAa5stHnz8/sytgLlKZoL3GLiAbb0UKVSKowVSEpMONnN/sNFDzgkfZIo/fEA9XjRD+DToiw//S3hNxhz3MbZSIzN40VnIb7dzfcNJ5f8REF5rjZyd/F3U8op0i//ZBG+7tgQhmJccwtjPXOP25lVJdNlj2IRbqQGD4pTNxQLAxlFv8cstkKgShVIt7qtWpCOxyvOLa5K5l1tnGcXStAVkaPSEu+BVjjGRYddbtFoKsuTr5D7+D58xOXTy4cEBwelIpWLyvoJe9urBJO91G6pmkO160/y/xRjmLRU61nl3W7wPFYSzm9VByztGpMf5h3ZJpq9nXUBI89Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFFgps+yOoTn9EsnTo1X34A8uVKOntvaMPq+Nw7UtLw=;
 b=fCrfE3VN2M28LayYuLcjzVkip54lPOoLqLEEnzUxCm8oWsdWDB8C0zg7Y5c/FJ0HC8ueXKS21AoDVtAPMzx49N7PktV+Qhzl0Nw+F9CgzNBLhblULtT7T0TnpyDVi09U8BTd6FHnJrAc1EP5L02GiY9VSm9NyTPLo5RItpA9df9jjiPGkQe76DgMRo/Kbx0NKjuL/fAO1VF54u5WurJu6F+8bj1YqYoG9pgIezaGmHl5jT4twicplD90QTuSAI+nVmlf3s1+hc1oNonAg28OtSMEhWrbiH4psFPi9D7XxcAGp3Ifv/9JTu/vDanDO0c0tQV2j4im2vDEKPPiOkv63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFFgps+yOoTn9EsnTo1X34A8uVKOntvaMPq+Nw7UtLw=;
 b=G9lvZFpfMTR0vpbGlNhthCHnzQvx3093tsK60A6cEKYsA2O36r31WFHEtHYKBL4JECb0EDnhx8FsRfHD9o7o++hcF2p11Ns3fhtQkM3x0tjS9YZkSVDqZmlKywNhVZTRTBTWdYYZ8pa20xFjk/LrgYPq/1uADiORjsmwjDB7hoA=
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) by
 BL0PR2101MB1025.namprd21.prod.outlook.com (52.132.20.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.4; Thu, 20 Feb 2020 18:27:22 +0000
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe]) by BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe%3]) with mapi id 15.20.2772.002; Thu, 20 Feb 2020
 18:27:22 +0000
From:   Adam Milazzo <Adam.Milazzo@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: BUG: git clean -d cannot remove files from read-only directories
Thread-Topic: BUG: git clean -d cannot remove files from read-only directories
Thread-Index: AdXoGL+T74AnrQcITTSQBlAGzI3fGg==
Date:   Thu, 20 Feb 2020 18:27:22 +0000
Message-ID: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=admilazz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-20T18:27:20.6044849Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f399fe8b-94d1-4d43-a1a0-8f3b3674c777;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Milazzo@microsoft.com; 
x-originating-ip: [131.107.147.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e2dd3c0-8626-4b88-5cb6-08d7b6328709
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB1025341BAB13A42732E31D4B80130@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(8936002)(52536014)(8676002)(26005)(66446008)(81166006)(81156014)(316002)(86362001)(66946007)(6506007)(66556008)(64756008)(76116006)(2906002)(66476007)(55016002)(71200400001)(5660300002)(478600001)(33656002)(6916009)(10290500003)(9686003)(8990500004)(7696005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1025;H:BL0PR2101MB1089.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87rO5PlD/8HMhkjWuoEiYh5GNu5HntjjMRnVUSokIzx0Uw5XRYku/KUHtq27WOCHr1z3WIDw9TeyY93pD0dJfyWIoj331v7qRlfxPLX6jz/4exOC8MvFtR8yEnWR5QFzl2F15xW8SPbs0wOanJHP2+1n6yuFAfHKqVp2AtNA3ZfT3Y3shslpj9pNbQKtyuPkG0bil0LmjX26l1sQ/KT54TvNhM6ia4TVWrjhzzcmtNWYYLx8g55ycQf8q5pAValg6RYkUUNzE3NQil477HjT0+dWzS8QmhT/qd6LOz5JcL4qsmcaT1UtKjghYbYliWPGh5WicCeEBNqNB1VPUQGd5lehvK/whkbRik2kHSgI9tdIPo7Mc2lJxNzmFiObyYma2mdcIn732koS7M1N3XgcE/fRnCnuN3ytMNmT/YmPCM+hDEUaQ0ybVPsOPJPFHaRb
x-ms-exchange-antispam-messagedata: lgNbtjpUSPSCelt75Zp+h2I7OFKdTn0mCn15gmNGjVjwpqSVLRzOkN8HLVgg0vdxVxTh8sdTzNQemACMRo+AzYnLq3WSOR1LiaPJOMtz/eFkezjz2LSa2A+BYN0Nz62+febMY/mqhHKYePl/2xm4/g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2dd3c0-8626-4b88-5cb6-08d7b6328709
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 18:27:22.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTAyTz2oDmmQCSBq0ejnjyvibPExrFRSs9NAZIx5tYlHj5DpWbpn+lLhzWkX/DMIlTZpyJZgnzeJKwkw2i9S5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Repro steps:
1. git init=20
2. mkdir d
3. touch d/a
4. chmod -w d
5. git clean -fd

Actual result:
Git doesn't remove anything, saying "warning: failed to remove d/a".

Expected result:
Git should remove the subdirectory 'd' along with its contents. Note that g=
it can remove a read-only file (touch b; chmod -w b; git clean -f) with no =
problem.

Environment:
git version 2.7.4 on GNU/Linux

Why this is important:
* This has a significant impact in real scenarios: the go language, when us=
ing modules, will download referenced modules and place them in read-only d=
irectories inside a cache directory, potentially inside the git repository.=
 These cached modules can't be cleaned up by git clean. (Furthermore, git c=
lean then returns a failure status code, which causes our build system to f=
ail. I don't want to ignore the failure code.)

* There is no simple and reliable way to find out which directories I would=
 need to chmod u+w in order to allow git to delete their contents. I'd have=
 to effectively replicate git's algorithm for determining tracked files. "g=
it clean" is invoked at the root of the repository and the repository conta=
ins many projects worked on by different teams, so there's no fixed list of=
 things I can manually chmod to make "git clean" work reliably.

* It seems inconsistent for "git clean" to be able to remove read-only file=
s but not files from read-only directories.

