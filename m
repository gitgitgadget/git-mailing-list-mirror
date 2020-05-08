Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80CC47254
	for <git@archiver.kernel.org>; Fri,  8 May 2020 22:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09866206B9
	for <git@archiver.kernel.org>; Fri,  8 May 2020 22:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FluaAbrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEHW7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 18:59:32 -0400
Received: from mail-eopbgr650137.outbound.protection.outlook.com ([40.107.65.137]:14755
        "EHLO NAM06-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbgEHW7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 18:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBNZyRfhWJyVMEVMO3axxIEZlBUJWa1KKyzr24Pd/E7IwbdroElsfCP4oCqkKZwO4zm5nGu/xvaQXM8tRBig2bkZyD2uKDG8ykiyLGZTXDVBeZZnh7wAaXktTBm9RKMWjGBjQgs4eUAXTuxxeD4E5VzxmwocOf6r0BCErgRArookBxBFdYYl8FlS1GVjGmUy1tHe+fCw9B+GM6/c4D1OLDyIYhP9k+XJCULyOIDcibbjrB+PPus2O9EPpmU9jjJ5Ncu1Baa5aPpeFZ1lvceLrocIWgzIyjumUOVFa3h7xsNILPHGk4UUSUepU3L1zPMfzdBkI2ss5egCYHzCt8MhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhmK/gd4509p3gBORF1haWxMHzFsrbDgHeSRDKMH/YU=;
 b=kZXJ0PiLhiCvNn/glwpEbsxa2dR/uPnkk9xtVeSxGE+4XM99sSoHg1K6MXAMjw3qzeYxNPhVQOEtVPvfAqZ/ad2UDdNCAekGtNqVWAdnxNkkTPJVfuOsRtwY35xUDl3RWSvbSPe5JJwbWdkMZeXT7rnfnjOkIPtE82fjYs+INKjMYWOe27yd/jcMdizJOKtItkFJMbwrSFskpEqkCVawGpNwxp5efFSR41uagDo1ghLXvVqsgBEUSTDW9fcQwDc3SF2cZfnZOh6PnT75iqyZCUu2h1fpV070cMYCNAiv6VaJLQDGHaavAp720Dn39eFUMhR7DKTHFEQWV0BrK9tfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhmK/gd4509p3gBORF1haWxMHzFsrbDgHeSRDKMH/YU=;
 b=FluaAbrcC7bJ3XQ2Xz0JX/NwNylJOy8aBQAB/87OXIxMbVPiXsqPJSTtGP0mGVpQ+NwY9FkSB/a55KKgG+9jQrS+jghTDD0dWrkZoh1mQEB516DF2iK3TlSiWqNIQc1MCQ4unZGH7JKC7jNdsGJyeFZdYahv/eJh61dOhJXPaq4=
Received: from SN6PR00MB0446.namprd00.prod.outlook.com (2603:10b6:805:d::17)
 by SN2PR00MB0110.namprd00.prod.outlook.com (2603:10b6:804:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3020.0; Fri, 8 May
 2020 22:59:19 +0000
Received: from SN6PR00MB0446.namprd00.prod.outlook.com
 ([fe80::88d1:96c:98af:1ed7]) by SN6PR00MB0446.namprd00.prod.outlook.com
 ([fe80::88d1:96c:98af:1ed7%8]) with mapi id 15.20.3024.000; Fri, 8 May 2020
 22:59:19 +0000
From:   "Christopher Warrington (CHRISTOPHER)" 
        <Christopher.Warrington@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christopher Warrington via GitGitGadget 
        <gitgitgadget@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: RE: [EXTERNAL] Re: [PATCH] bisect: fix replay of CRLF logs
Thread-Topic: [EXTERNAL] Re: [PATCH] bisect: fix replay of CRLF logs
Thread-Index: AQHWJL5hjntdnA4Rs0uuMph/8j0SWKidPzfegADq14CAACEx74AAFt85gABnQlA=
Date:   Fri, 8 May 2020 22:59:19 +0000
Message-ID: <SN6PR00MB044634979E0EA55CCAAF8B469BA20@SN6PR00MB0446.namprd00.prod.outlook.com>
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
        <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
        <20200508130831.GB631018@coredump.intra.peff.net>
        <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
 <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=chwarr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-08T22:59:17.0847280Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=62abc066-e4bb-4f62-8e74-902c8535157d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:8300:2f1f:44fc:c0eb:1d42:1ba7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ec66672-fd7c-4c99-027a-08d7f3a37113
x-ms-traffictypediagnostic: SN2PR00MB0110:
x-microsoft-antispam-prvs: <SN2PR00MB011033E39E2B76DD2381DC029BA20@SN2PR00MB0110.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+x7RTdgWFtUOCvPK8R8Ejd6p+ajrkz9Gx89GZ4/mM3F6u+t4Zz/C3E2XZ/oo8rCtMVAgIKEuyxKy6oUwldgRY52ipnIbGTVKzOj2j3gqC+s+eatME/qZNwezdl43kOLZcBJSwIM2632V4Ga+h94u8yUDxUQLs9D6vH6OGXabEcA6+si9s/DFUd+0b5vUe6oBcG+gnlXEVO7usi6zMjIwlZeC2UtQNN2AFdfmI4f8n2stF4rhEHV88Hd/aB40xQNftY0T72PSdjleDwgtIBBo4MCwYf2JMrO6xkKDzWMs7fO0yMWokWSZkDIp/FKrB1O8FlPDsJtNvh9AO3Ny1Qc9spAyx59tZMRmMtRaJnBaFPAirS4SjZdyJ9i4kk+IZWuE+0YjQDgZQlp8gGyzLhIhIwuMnd+fL3wd9B+n38DqQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR00MB0446.namprd00.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(33430700001)(8990500004)(76116006)(478600001)(7696005)(52536014)(86362001)(4744005)(82950400001)(33440700001)(82960400001)(9686003)(5660300002)(54906003)(8676002)(6506007)(316002)(55016002)(186003)(110136005)(64756008)(4326008)(10290500003)(71200400001)(8936002)(66946007)(66446008)(2906002)(66556008)(66476007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: d5erQelTVRE5hI9x+pyX7YKpBP+1n15Cbd77/sxck7LtndDKUHaNdOaPjfzm5LUgKZgtrXVMKaFswHLbwv7eDVra9vhGc9s5fz3ChjP/PLSayxCdfQ8AHRAtlJ+sHkezCP7W/UBUoOve/DoBrD+P1LsS1bkPuph4WVv/4eZyjssQcEYHo8x+tqMZrhtNJszus5hg17LID/3Qi0GlFguYz1nr/ZrVk7F4pIPMdExRM1HxtRJihGiVfszYHuvygfg5Ea2s/R2cV9tgTYgQr500dkTm0OCFy2qLwq43gCJnpysA9EKiq5RLl1ivdewqfsA5IAhiTDlT8duINqkb2V13YS3pLgQdaJ1G1xV+gobwODe7LruzW17zNO60ZyQR8J402fUloS12SF3PgLS5gNTAzKwlbeI9gx01BsY9CZQH9D5dSowolWXOmt5rcJSjc3rqHBg4iF3qBDivGDUTxExiKHKmLRWrXjmAhl+HjelvvWmeL96f53ZtJuo83mkJmCCJIXBeA5gOmG7SXzHNR2ftK0BSdde5sbd4XCvIGeDOFHc6HqxYeaX2j4emuKSRTrvU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR00MB0446.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec66672-fd7c-4c99-027a-08d7f3a37113
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 22:59:19.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owq9iFLEF95Y4+i0R0qcH8GGQXDrh8S7rF7PFRFvnYeTOSuCk8gHn2Nnw5G4DAyMqiMnngbDtpO9aHEdpgHdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR00MB0110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-08 09:31-07:00, Junio C Hamano wrote:

>> I wonder if we can add a CR to IFS so that the parsing logic of each lin=
e
>> would not even see it?

> So I got curious and tried this; it seems to pass Christopher's test
> (corrected with Eric's suggestion).

> As the implementation changed, I ended up rewriting some parts of the log
> message originally proposed and here is what I tentatively queued.

This approach is much cleaner. Thank you, Eric, Junio, and Peff.

I can confirm 6c722cbe5a (bisect: allow CRLF line endings in "git bisect
replay" input, 2020-05-07) works on a CRLFed bisect log when I apply it to
git version 2.26.2.windows.1.

--=20
Christopher Warrington <chwarr@microsoft.com>
Microsoft Corp.

(Apologies about the [EXTERNAL] in the subject. It gets added on the way in=
,
and if I remove it, the References: and In-Reply-To: headers get "helpfully=
"
stripped out.)
