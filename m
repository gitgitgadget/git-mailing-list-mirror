Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C343C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D7E2467C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ekgkovBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgBTSzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:55:51 -0500
Received: from mail-mw2nam10on2096.outbound.protection.outlook.com ([40.107.94.96]:58145
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728315AbgBTSzu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:55:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgwjgZC9GWeEwX/WmcnrbUq30EkxNXrjyVomMu0z9Phpn35+bzhUDTsaoD4eCRwp+O48LOrWfZBZEGsmTTrA3SVnKQNyTyLgIAILW4y3nbk3ziWgqgqLwJW1x41kXW1du6rxQO++OjpHvvCHoAtIdibBkkvsOcZU6bUGCQHoD8O+OFl7op3udyx8Ctp58yioYWLbPLAJ9FkpgfbLmKn9k03/u7zjdZJGdfvRLoCwo8oyz5zq+lWWvrZq6LwoLEwwWLqefYA7anE0BplbS9MN48zQ9SP0Yl5qsXBf1O+K+GqkfguoE6TypNdoomnRMRiq9zxHN9ARBEDuPbt/8HHoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvxCVAmdxmU9rTDWIYF+KMpfVdT22jiU957A7ltXYuU=;
 b=M1UiDu8Jn0noKYZHF+lNrgAnu1OgEZ25YSQbZfVO4Jq17WhfN0DpIEBcYI7kkt3gbj/GkDGC2+E7a3qvWsiH4tI6HvP4RmOzBWBXHwouC5zrWEg3w08466mQsuZ7aNQavpiIMqmY4hNGjRYwLloC7qjmWQC/KNtJOAk2Am5WdMJpG/acv5RNe9PI0xJ7X+nKRxn2bEk/+2u2GJhMbqVGzyxtnC02m7Yqy1LDxeMV5AVqXqGH02cQI9pzeMuhXC86os8dUkDeZi1c9OOYMa5pcvOMaVJEU/+hMMK+9WeLaHAhPa3Ov/ky8Hx89GPTbUbINKxKUTHc7yhjFan0rGytwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvxCVAmdxmU9rTDWIYF+KMpfVdT22jiU957A7ltXYuU=;
 b=ekgkovBvYyiWFp+/4jTZHqD3LJhLJIgE/KF62HU0yM5ppWfGHSssCg6n/J3JtWPJnS2m74v5w0YnFNqo5aILWkB+2ZNnGoB5cnNn3E/LofWIgh/y1598CyF6FD9YmqvXwuRJ3xj5mVvJ8J/rBS9D95xwZpL2DstYHB3v/F/V2Kk=
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) by
 BL0PR2101MB0899.namprd21.prod.outlook.com (52.132.23.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.3; Thu, 20 Feb 2020 18:55:48 +0000
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe]) by BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe%3]) with mapi id 15.20.2772.002; Thu, 20 Feb 2020
 18:55:48 +0000
From:   Adam Milazzo <Adam.Milazzo@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
Thread-Topic: BUG: git clean -d cannot remove files from read-only directories
Thread-Index: AdXoHrH5FO1NZ7qPQtSWwmVAnLy0/A==
Date:   Thu, 20 Feb 2020 18:55:48 +0000
Message-ID: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=admilazz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-20T18:55:47.0455178Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b33ef026-7b2e-4eb7-ba60-e1a07a498ee6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Milazzo@microsoft.com; 
x-originating-ip: [131.107.147.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e2102f4-3df2-4b65-e200-08d7b6367fe1
x-ms-traffictypediagnostic: BL0PR2101MB0899:
x-microsoft-antispam-prvs: <BL0PR2101MB08994DB9024209FA4491613580130@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(52536014)(8990500004)(7696005)(9686003)(55016002)(10290500003)(6916009)(6506007)(4326008)(81166006)(81156014)(8936002)(33656002)(478600001)(8676002)(66946007)(86362001)(316002)(26005)(66476007)(5660300002)(2906002)(186003)(4744005)(66556008)(64756008)(76116006)(66446008)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1089.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKwbXZaWUir+p8rygpjbPvB5VsJz9p/F4ct8pW1hSXeJJHiAoQpatbsnpEQYM/aX5m8flJEvf0EsobVqiGIDq2OuSuMuKYNc7NvP9h74Bez4DUhzNSSKSyCBNc6q7mMYrhyWq+wqxfFhHgGONwaF9He9AtpKcQE6GEuPQSmazhtz+onrr7hfWdu67WGa6Sh2CG9S+CDjpCmKcO+XwZ5zyqrgx78EQWkg9Evp5ipKTrBRlKbTNakDqAhKAoXs1nmxRDg7bh6v7G8IHLFZcA4mF+8abTkKUh8DEaJWgDO4nGl+hs24nFZihT8UdQkyI2dlsFlsWTUKZnOGMVP3yZsnS48R05v2qkMBsAG8dV/PGYBeH11WAKM9I5TOodDiAHBn4xOzdjzxi5Rlw41OVreUCpQn7E16HSPSr6oRoXlAMge+M1nOI+nqLp87tFJGIcmM
x-ms-exchange-antispam-messagedata: 7AgordLGiNiNxL9U1UuE/ypwMpgf6w43Gn9ZuuKvWIZ7UpNM5AIL98i3q2A/uS4Ci7CTUy0LMV1WBj35IUFzci+x5Tr2aX1e9us69sxw+RkEFQZGsVEBNuMssPVBLjigAzVCS8qBMUNSGWSGIuxO2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2102f4-3df2-4b65-e200-08d7b6367fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 18:55:48.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULxP80xDRCy7rG/qsdWYu/fQoCk/uEc4EhglASItkBcmpKH+6nVLYWIGYWNh71cvciTymy7zp3lLqJBQCGAteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is how UNIX-like filesystem works, isn't it?

Sure, but it doesn't have to be how "git clean -d" works. In particular, "g=
it clean -ffd" could be more forceful, or there could be another option or =
a third level of force beyond the current two levels.

It really comes back to this question: "How can I avoid the failure, given =
that I am running 'git clean' from a script and not interactively?" The onl=
y answer I could find that's not unreasonable is to parse the text output o=
f 'git status -s' to find the untracked directories and then run 'chmod -R =
u+w' on each of those directories before running 'git clean -d'." I can do =
that, but I still think a "force" (or other) flag that really forces the cl=
eanup would be preferable, especially given that this isn't a completely id=
iosyncratic scenario but one that will happen more and more as go modules a=
re adopted (unless go is changed to stop putting them in read-only director=
ies).
