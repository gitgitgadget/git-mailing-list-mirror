Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B010C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E096141E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhD2OKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:10:54 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:60005
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239741AbhD2OKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 10:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6NG7fPM12ohc6YqV6Iq0nWW8LgzMwyU8E6LwoIBZeHJmhACmc6WnkAhQbvQzwUZJP2vGYeNET88JPleVhqrYwITrIuhC8IxxnGJMbDDSDfSu01ngbVFlWAXefoIpwsiuJJTqBJffirEVLVy0Z87X5JxIZV4xAyyhWaTk6e2x0FoT7Grnb0TuvQgjn0NnblCZIYNS+hYoU0neP7ukNtwtztUbV4js+cNiHzyIsICXb0mY+aOjDQIDsi9ygZFdqvDnxOlanmFvcDWjgBvzVsIC0Kw5rfYaoxgD6lUm5E4V1GUCaXvhjwLMgo9jILRJUbXzOcpuiGYftZ4Mq/N5hQS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUDbyaPLgm3pfamXmpupnjcekfsD6RIixd0reMwV3s8=;
 b=EWiLFX7oCJS22/OKxJ//SwqGJbhxgKYD/fMo0iqs4hloW/qja0gRUS8xHDmfkR3lNZrd4IsKXGkk9QRpCuP5KcNIt8ABrk/EOXqimTTpj9D2j5iBTlGRqERg/l75ZB5MEy+XExPG9y6FjuduL6O9/iK3UvVH0FSbH2qPLLFA2MEkFjZIp4IIQg4yOhXvyk3uzF+qVeme7VkjFAHyMQTXEUYk66nREfJXBZytw/hWxtv+AkCPhJLpJ3psDdFLyCAnjg5p5alcZWEM6o4COv3nvV7v6qYMhfoWvh42mDqu8mGnH9N+GT82Zl7S4Gyo0nE3nlUQIx0o3oBo7eDDzaZgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jci.com; dmarc=pass action=none header.from=jci.com; dkim=pass
 header.d=jci.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jci.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUDbyaPLgm3pfamXmpupnjcekfsD6RIixd0reMwV3s8=;
 b=rtLmYZ/8GlFAQxtWEdrWJE0G+0ybdEJtsE+UjWCu8z7Ce17hSGLy/QSsbxX+obD6DYiNUXIlCba+XZAkuwt3ixrOAy5cnesZ5vVZxVObdjBfMcgovOjainowxYEwf0Sgwguf6+c9HkQEfBK9D8tg41nBkSgyXDu7hJh/yuGC4EM=
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:1::27) by
 CY4P132MB0069.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Thu, 29 Apr 2021 14:10:05 +0000
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec]) by CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec%8]) with mapi id 15.20.4065.032; Thu, 29 Apr 2021
 14:10:05 +0000
From:   Jeremy Faith <jeremy.faith@jci.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Topic: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Index: AQHXO4AUDQX8jTZiwE6IhVGEoYJRi6rJhO2RgAIDcT8=
Date:   Thu, 29 Apr 2021 14:10:05 +0000
Message-ID: <CY4P132MB00885F00AAA46BCFAC76881B855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>,<xmqqfszac25x.fsf@gitster.g>
In-Reply-To: <xmqqfszac25x.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Enabled=True;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SiteId=a1f1e214-7ded-45b6-81a1-9e8ae3459641;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SetDate=2021-04-29T14:10:04.989Z;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Name=Internal;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_ContentBits=0;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Method=Standard;
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=jci.com;
x-originating-ip: [82.24.136.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff009b6d-a2e0-4354-849b-08d90b187d23
x-ms-traffictypediagnostic: CY4P132MB0069:
x-microsoft-antispam-prvs: <CY4P132MB006950A54AB2434285A24C18855F9@CY4P132MB0069.NAMP132.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCK7GUP5ma5wa1nADX1VDkxLGXJ8JHgvot3qZB7x/hiuPPiJZdonomj6qBvyCyeEDj/iOC+YFLzQehSq8J17UsAMOKhneGoD7hID3LWxZtgbJw79sOPuqbUulCkBWX/hHSWAE1OG9r5nAkXjemBQCuFLWre6JQZzj+v1DNSEdG2fn4iSuTT4RMnwxEnynFk3+iz/isqahJmDuTZjpDvSfl4e+eVSZgYdUjE5vW3LpufmK/bvR1EdflTmgf099CC9nJwTVWoip/Q8IxZXahLuakvUiwmOQA236t+yMr2iHfo+qXNHdNFdMzP4MPT6TGgR9j2O2xZ0ZAQm4XiAgMCQwQEXwQcvTC4QnWdfxq+jhkxa0BcOLbkNM15WNR1T9s3PFVt5yddaPvedwDSi2GMSZFfs9Iidwwf5gAVgYa5aW2KRiFdoQ0rowjb+YvQRnCjhbTfd0YOTplqiXSQ5sCwkZKRmZy75BcUjuDI93kv+A8UIajJpSvErIjASbkt1cIYFBHNLVe4z836KyFX1M6kt62nuRbFXOwwXBcSlUTUns3Oc3dOTZN17RZyR5++e/Q70LxZtR49zETesJfHmUKVnhvcW+zVSQTXx0XZBNwH+I9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(2906002)(9686003)(55016002)(33656002)(38100700002)(122000001)(4326008)(86362001)(6916009)(6506007)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(8676002)(7696005)(71200400001)(186003)(26005)(478600001)(52536014)(5660300002)(8936002)(44832011)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?88Y4lfr59J4OOI8+udnrW1Xlv2WcvK9BRIGHU1CeClTCmtYi/KPaCglEaT?=
 =?iso-8859-1?Q?7zzp9If8KF0b7zAS96L6IWfEQ6crcVXf70Xxqgg9iwa/IFCxzg9DliicID?=
 =?iso-8859-1?Q?6eeAKhKAuB7ZAZ4uPNJGJ3HsUf1MQwyyaq8fG+hBAOHxdBMlWZB2Bl+zSs?=
 =?iso-8859-1?Q?c/dMrEFoTgeSDt/XmhRIlMUmw/v30XB+yFkhzxnK9ZMko23FmH/ylonGKg?=
 =?iso-8859-1?Q?vV34OsfpPeODxEL0M+Z3sZI8gGEivT1Awg0MdEqgkKprcxUc5stZVqZQ/9?=
 =?iso-8859-1?Q?4C3IZ9NMfujEp8Z18tj55cpcVTvyQtMwzOPUaNl3UaxT1R8oxrtnOTOPoR?=
 =?iso-8859-1?Q?0Qm3jFBlV9qNjfHlIAsm7Z9JS2g3HRaGc8tIHBf8smqG+ZaRfk0NVpAw9V?=
 =?iso-8859-1?Q?XktKYBZ3526z8q++9rchSqCyCMYfj1X/ELYrXNXLXVcVmceXVqmjvN9+A2?=
 =?iso-8859-1?Q?I9S0a7U3z29B1VipfQ0qNQI5yexlYNVMBNC9qRwRlLhLC3We4nAZblZ71z?=
 =?iso-8859-1?Q?EOnuNdhmzwycy2taVMATo/CtSDd4k9fbqCNT8B5DNNRk4Mnp7QJWS8x1Ew?=
 =?iso-8859-1?Q?8OI7rCs/TOsGzAEcRdW2wFsSF/QHdv+/YJU7NIt521jB9jsZQUeQ9z2I0W?=
 =?iso-8859-1?Q?Dvmw/6SohjPf7/HqOd7ip7KEzjk/aNIkU2bFosGM12kEHuy6rGiwQtVi8Z?=
 =?iso-8859-1?Q?CJWGN7Dpl/jCkc3K2f8XOWDGa5OGLnyjVHERENAOsUQXvAcbbvOi91YU56?=
 =?iso-8859-1?Q?WCnC6oYG22NRbvQxriMAx+29ometPx+Uaa4Sgw8v9UTq4oT8dJS5FuRcvR?=
 =?iso-8859-1?Q?A666oyoB3m7K/wRid3/EtR0G9MaO1ep+XRuNV0OJMQCzAtr7f1BTDJjzjB?=
 =?iso-8859-1?Q?BSDhdv2JKbaYapcyT+Dm01N7q4qBedOoow0iB0AyjlEBCxiZmuL3Y00NQS?=
 =?iso-8859-1?Q?TN3vEWGuQ6pDuGudaHMGPpEzBFHoa1dnTQ+7jHo53v0H/ItN8mmFcij/Ox?=
 =?iso-8859-1?Q?NjaQJLchtzSAEP/EcfhmbP23t2YadukA0j1g04LFEQj5mznEOVgsgStZDp?=
 =?iso-8859-1?Q?T+nsbhKoOM1sciOpp7nE6rUd6iaBgSYZHzALVduLh7layXO5LxI7/16N/g?=
 =?iso-8859-1?Q?7OykQQi5oE61tnfmlCSGfPqzQFnMmS3369kxnTfYvxX6JEOKzjuOvOZFlY?=
 =?iso-8859-1?Q?urskWFy4suwJ40YsKdEOOdWkcdVX+d2NtlnpgEToyl7sM4ZtiVBLC8AJM1?=
 =?iso-8859-1?Q?OqDZRpfUPa0AObRHg1CxIkWhWzzkxuzFC4d7ZhzYOA3v1j1A+HziiyGlox?=
 =?iso-8859-1?Q?Loy92rZ2n9j46ZkdzSQYV9fQLkjkfw9plALqgev2h52tTI8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jci.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff009b6d-a2e0-4354-849b-08d90b187d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 14:10:05.5456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1f1e214-7ded-45b6-81a1-9e8ae3459641
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fror2G4hA48E8GSgQX5lFxkt0YKfyTnouJQA1ipad8itN6olG8m99pa+HzVihkMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P132MB0069
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:=0A=
 =0A=
>Jeremy Faith <jeremy.faith@jci.com> writes:=0A=
=0A=
>> git version 2.31.1.362.g311531c9de=0A=
>> git-check-ignore =0A=
>> When a negative pattern is the last .gitignore match the -v option cause=
s the exit status to be 0 rather than the expected 1.=0A=
>> e.g say .gitignore contains=A0 one line: !hello=0A=
>> git check-ignore hello #outputs nothing=0A=
>> echo $?=A0 #shows correct exit status=3D1 i.e None of the provided paths=
 are ignored.=0A=
>> but=0A=
>> git check-ignore -v hello #output is next line=0A=
>> .gitignore:4:!hello=A0=A0 hello=0A=
>> echo $?=A0 #shows wrong exit status=3D0 i.e. One or more of the provided=
 paths is ignored=0A=
=0A=
>Hmph.=A0 This is kind of understandable given the history of the=0A=
>command, which was *not* about programatically ask "is this path=0A=
>ignored?" question at all.=A0 Instead, it was invented to answer this=0A=
>question: I am puzzled by the fact that Git considers this path is=0A=
>to be ignored (or "not to be ignored").=A0 Show me which entry in what=0A=
>exclude file made the final decision to ignore (or "not to ignore")=0A=
>it to help me debug my ignore file(s).=0A=
=0A=
>And the exit code was to signal "yes, I found a relevant entry",=0A=
>which made sense for the tool's nature as a debugging aid.=0A=
=0A=
man git-check-ignore states:-=0A=
EXIT STATUS=0A=
-----------=0A=
0::=0A=
	One or more of the provided paths is ignored.=0A=
1::=0A=
	None of the provided paths are ignored.=0A=
128::=0A=
	A fatal error was encountered.=0A=
=0A=
So my change matches what the manual states.=0A=
=0A=
>So, I suspect that this is working as designed/intended.=A0 I agree=0A=
>that it is debatable that the way it was designed to work is a good=0A=
>one, though.=0A=
=0A=
I doubt that changing the exit status when -v is added is intended behaviou=
r.=
