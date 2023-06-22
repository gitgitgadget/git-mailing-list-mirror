Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F4BEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 19:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFVTiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVTiY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 15:38:24 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2121.outbound.protection.outlook.com [40.107.11.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73F1BCC
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 12:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4PKeIotJK+9kw9/4O6xHOv8IiAvMhB3pJZ8Pjg6OOi67umkO5puDh17ydKFetwKUseEOlnxBSeiMzggzh+fVJ+JJBFftLJTwOrLju06602+UXmBeJib69k9e1lUWNqw35mTJFIhQ1ZvZCA62h761a3iHLjsFstRjy1NzdFPBf1i0/vdmxMRU97L8gYye2To4Nol2OPbJnmlgctd+QqaemrenRAOvyAy7EY8iEt4kEnk9TprOmmUEJ9xvcn0BbWfxC0BfgWjTior8b8d92C4VHsIlcGJlCPCnzb29lZhroipwGF5Mcnq0/Q2L33rMVeruPl/D88nSaFVwoO93cL9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QywGcPTFf+/JzUszwrHb6xxXQqmcsSsdZsj40938E3U=;
 b=D2CHGczn5ToPXegyKZ2yn9pGs87BBkzZSmmPBiQ3gRxUdmScvKOceAKyjREhIgbA03kaGaZFTBAAspST9sBYGglAGZT4AKuag5gzAwVIoQ/sx4Uv2S3Uh8vxWywrzcl2h3vbRXEjopPF0ILRLegW882BymPyTlmI8YYKsXZENrnIFgKDPNVl2lew9O2HduYdRsFdGh+pFBhPRANCY1FiXDqPZTZU+RRyBj5stMdYfirAIH4R0dBNmy2JIJFWDvs63vl5RdUdlzVy3Lk/OZwC2a6A9RJiOEy5gVeCVJRR+h1n61EF2j7VrvV6ywJivaDofPVd63ctVFGnOBq0FzUaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doulos.com; dmarc=pass action=none header.from=doulos.com;
 dkim=pass header.d=doulos.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doulos.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QywGcPTFf+/JzUszwrHb6xxXQqmcsSsdZsj40938E3U=;
 b=qENsFWGDwAwxEN8zKtcnWyswIE71JoZgxwSnG0n6y2OLv1ZzfPtP/GX8Q0oQc1tZcJdWMsXGpOOt44szQdNNfE4Ogckp2djGEfZZn7EkzTJG+BP0V690t8Xb4IrqAhdQGN0pOm0876fZiMyafdJcNZGTxEdKNeVPB236O7Qp19o=
Received: from CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:108::11)
 by CWLP265MB2402.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:65::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 19:38:19 +0000
Received: from CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM
 ([fe80::98d3:95c7:463:8b20]) by CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM
 ([fe80::98d3:95c7:463:8b20%6]) with mapi id 15.20.6521.026; Thu, 22 Jun 2023
 19:38:19 +0000
From:   David C Black <david.black@doulos.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: git add does not process gitignore properly
Thread-Topic: Bug: git add does not process gitignore properly
Thread-Index: AdmlQMAulPbc16SAQRiuSVt/rOZ3uw==
Date:   Thu, 22 Jun 2023 19:38:19 +0000
Message-ID: <CWLP265MB3841D32521E79202079DB7F58C22A@CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doulos.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3841:EE_|CWLP265MB2402:EE_
x-ms-office365-filtering-correlation-id: 2511b09d-8108-4bde-7722-08db73583b38
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzJweWS6mxDKI74IxvqKHhfbwg5Xuh0/TQ3zbjd462/M/uSdVC/M7u5UERJ5BAmxS60M1L+kZOBvPH4OYpgIj89fCKi9+FfWE5mZl0+R4eQtLWWLVoaSwrLN3+3EGCYNKvbDhSv1A3zpb1OWrwksSaQUJZaEPMkoZTgR8bL7p9UGrdc1EWyIx3ceDZEdtL4hBXBVX9OPJmbWaVTq4xXIilymY8svOsh3WdXuNmPCEFZfFpX5nsxzY50IKVUm3nX08gNqPS6LbIQ/I73v6yT2ELXXz4BIjAP6QKhHfrG6Ub11LdmLZ7RB57usZfv/NS/o1kxnhGkNN4Z0KKhHspWAek9QjD7eTOg3SOc9AlTF1JUz/nSC+Pdpa9DIku4a7VH37o/JA5KAKrMZJ10Vw4DqpQxtZvBnm3NKP2kIPqYVrnwyYH8PFB/PiiUEPzKhw37afxQEu3Si87OemH2dCjdFokZFzS4+v0fSFdIgSeTQf1HkfVk1Y79MKPx8+Y8SiIDiKRcqcJYET9SbPWOe/M1ODTzoYv8dPY7l7Di959P7BeAS2Z4IBuJs3ZvivkK1S4oX+xzSsKEKXBB0SemYGT3l85J7qk7eF9Oyg5IJEJLbF3nYOtS08F8n/wEuZuHemrv6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39840400004)(366004)(136003)(346002)(451199021)(186003)(5660300002)(66446008)(76116006)(66946007)(66476007)(6916009)(316002)(66556008)(33656002)(64756008)(2906002)(52536014)(9686003)(41300700001)(8676002)(8936002)(55016003)(7696005)(86362001)(38070700005)(478600001)(122000001)(38100700002)(6506007)(26005)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qVfX+PPaQI/FwBIoFKJcYVe1O+mlyabm8VAD552wnE/c/JXxxqj/GKDK4H?=
 =?iso-8859-1?Q?+KihtI/RRtf3EpRaY45H/U2Apd68hwv07rITIob8iUsQFL7SfAddM7Ln2d?=
 =?iso-8859-1?Q?LR+ZsmNOEys7huZSp/4yP8bZKEzRP/MrRCPWHdEnpgFN/s+r6sd6jIDMVl?=
 =?iso-8859-1?Q?0uElpbHz4qOE/yRVBK4FUwshRoEyLLpz1CJZPWvIZ6iNehRFRm20gvTx0u?=
 =?iso-8859-1?Q?iywf780f8E4LhBlmKRUhSktdlfEZ5DISnUYsuIlUJKK9Ob/2RlC+x04Kum?=
 =?iso-8859-1?Q?gI+IZJ8NTIJzS0rUDRwwV8b5y/+SKyoMDo43tnzTjKM4hH8TM+Hn1XLD8x?=
 =?iso-8859-1?Q?3K1jz6OCV8G3Nv0kP46auxrZ1miC7XDcb4JIutBXgjSFOiXziigfN8l1ZX?=
 =?iso-8859-1?Q?x6zBTWpJSA3xZ5Mw75h6UXkZRgmgiy5Argev6te++WYeqi5jz7/5f1j+kF?=
 =?iso-8859-1?Q?+ke1cFZ8aY67mUZbpHREd60qS//hsdW9Rio+P6LowBX7vS/n+HZWGVk7eR?=
 =?iso-8859-1?Q?xysP7nr321wZJVniMMaBoHE/4H/1NueZScBlfNm28chgFiUivDxwMCcJwv?=
 =?iso-8859-1?Q?Vvm/dN7o5tZdCuRbidVMh0IUpMyqB3ajY/LEtWFITytZxzVKjHu5jht/ob?=
 =?iso-8859-1?Q?uxUavzyAIl9pMvdybXnTI46EAcDjupbKI0aN7SqA8SWV8lJgmJrthfz1su?=
 =?iso-8859-1?Q?QMCWajxpsLZvPJxG/AWo70BniFzsfMUqW33tPb6ds0OCVGxdK4ijfsZdXi?=
 =?iso-8859-1?Q?tjLR5Zk6HQlhBLwe2MTCxacEchEhOWCqdFbP8C6Q0wBFeMmPMdIY6DnSIb?=
 =?iso-8859-1?Q?3F/AAXrZCJOJ58oPGfbLANdh2QFlYJpv/I3X1t3JlIA8q4GHherTpGVnJr?=
 =?iso-8859-1?Q?Gk5hDFTOnbi+v5PpHsEYU1Qs7WHe8sfRPuNJi1LftIKWm/rQ+kg+U3RReI?=
 =?iso-8859-1?Q?Q/SfJz5D+Yv0u0VqnzvzlXeqS2LnUzRE+ZzoXT45kkZeJJbAITbg8F2c/p?=
 =?iso-8859-1?Q?Dvmdyq5Z5/mgDK1Y+tPvX4SWv13HvS+eh7JN4kuY4oCyBsc6/BH1DykiOq?=
 =?iso-8859-1?Q?XzsZsYTIHElj80OOl7N4INP3YeL93W8Ap/Lhg9Za3Zwt3XmGMdN0vnI6iF?=
 =?iso-8859-1?Q?PvVaaSqvS4vPE3Q1m0kkKFsLYpxt7EH6IZzI2qvF44xJxAYwGFRhJTilMu?=
 =?iso-8859-1?Q?6tiHEEEPjsISgOXuDeM+PIKVRIuSPp7lEzzMYYHFuTeq27rUpCNjFRArbl?=
 =?iso-8859-1?Q?95SrkWoSfUgUM7opSYNPiVdrqiC6ZMOyR06UHmmUeezzpL5QRia21dzcpx?=
 =?iso-8859-1?Q?X5jdkYC2zI18Xo+cYO51V3F2WYD1c9Qzd74PjtiUmszyOcg3judYpVpJuu?=
 =?iso-8859-1?Q?234UYVAvcQQsST66Km0RBJ1NLx8+dUzOGm9WFJ9sOHTsF049TKfH6kS2+y?=
 =?iso-8859-1?Q?nfxD+loX520GGxBBFeVWWPEWxfGfuVUtE3N82FN7frEeMtpKgak4gjKWNl?=
 =?iso-8859-1?Q?wScCyKESIC2NjF+M/CNC6lOlpFIqkCWo0bedR8Y1OO9AbE1ZPILDMgXax+?=
 =?iso-8859-1?Q?N4f/9r+PPEWZWszBPPlgrUCCSSbJxDSx6RnpilHJ6AM8EotW0ulLKGWUet?=
 =?iso-8859-1?Q?7flSP+t7OKyAu/bJJLQc18UMUTF7WBn4gc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: doulos.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2511b09d-8108-4bde-7722-08db73583b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 19:38:19.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d152b39c-c0a9-477c-b38c-e5bf00f10979
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zY/Ubn8TavBvRkm6f6rMkUGw27fu/Jd+Edgi8NkEdkv3jPsCnmCNDQsTUN2dfpwU+cy/+n0zXAZ9PexbMGp58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2402
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.
=A0
What did you do before the bug happened?
=A0
Sitting at the rood of my working directory I attempted to add a file to th=
e git repository with:
=A0
> git add extern/bin/build
=A0
The repository had the following .gitignore file contents:
=A0
> /extern/
> !/extern/bin/
> !/extern/ABOUT.md
=A0
What did you expect to happen? (Expected behavior)
=A0
I expected it to be added.
=A0
What happened instead? (Actual behavior)
=A0
I received an error message:
=A0
> The following paths are ignored by one of your .gitignore files:
> extern
> hint: Use -f if you really want to add them.
> hint: Turn this message off by running
> hint: "git config advice.addIgnoredFile false"
=A0
What's different between what you expected and what actually happened?
=A0
By negating entries in the /extern/bin/ directory, I did not expect an erro=
r
message. Of course adding -f made it work, but I think it does not match th=
e
described behavior for this tool.
=A0
Anything else you want to add:
=A0
Please review the rest of the bug report below.
You can delete any lines you don't wish to share.
=A0
[System Info]
git version:
git version 2.41.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Mon Apr 24 20:52:24 PDT =
2023; root:xnu-8796.121.2~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
=A0
=A0
[Enabled Hooks]
=A0
--=A0
David C. Black, Electronics/Programming Technology Instructor
