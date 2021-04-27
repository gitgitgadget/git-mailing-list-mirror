Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9459C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 16:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3C6613C5
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 16:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhD0QbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 12:31:03 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:44769
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236449AbhD0Qa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 12:30:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwYqgI9useS+me/jNElBLujdAWGVHgJ8wYcEkWSEf5AQ0FKx1XQJD8qcs3KPtJ5D54WrCVf21bngh5z+TyhgPuoZ7ZrYlJhc0srq6wvdhmf7N6uIhuMibIsXau0FXICbA30W6/SPkfAi9JQC5Ky64JcK7qRu8KqTIqZ3/Yx8Z6Dm4iqRH44ZwSutEFkvNn6mo4pziq8p2w/cUZN21pmNGRCfoEnpWQR88/gVJgca2scKqZ1TnwyNxmA7eT0C9ZD7mzmPgDDkJvp07wynoB5mfcnkHwn1AzF5msntlBkuRLfirDdh6ln9VvX1jasj7wNYDNxr2g++QnOaFCEnLTIOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgkgrY33ejFpx1RN/Mv2L6TwveHkqjSI24ybxolaOac=;
 b=VSkx6uwQxS6pRjHqE0q2v3JYSwx7WAYRlxrnzbA+3fAiMGm6oQ349wXv1OxAftki2hm9rdCyeKxD4fKz7+q8hqsiwT4cqoHq4V2QhanxdaMdTnffeoPJc/wwCunzJJmO+QBOGOR7aDADz6FJ+y75G9FOzhr16ScKGErjSRnDqCRykrH7Ue42DlaDs3j2OWAN8/VFm5T03nZb1IAu3BdceIBoKY29ZjFA5LBFBW2zzxlBJOLI3FD8VpJiBNABnOQeoJMBf8x3akq1MF1MBpJYrfIleNigLLSVvTCZszcnCuzrKlkflAAWAEcdmyM4rXIW9wu64uWKK3mm54nU33LBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jci.com; dmarc=pass action=none header.from=jci.com; dkim=pass
 header.d=jci.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jci.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgkgrY33ejFpx1RN/Mv2L6TwveHkqjSI24ybxolaOac=;
 b=FwURsocXyYc7tudRTF09ka0aFH3k4yJA3jFj8/As5sWrtRqM7GrQKrNJRdl59AzYcvnbcMW48NaZ5gaowwiTUvmy7+LU3cyL01qC9jbSshBZdJSiX7Lwfpm0bD/6bvWJ0AnigkGEFYBck1BZ+JfgLXRoC6sGvQcHPZcf/cY+5mQ=
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:1::27) by
 CY4P132MB0124.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:48::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Tue, 27 Apr 2021 16:30:13 +0000
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec]) by CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec%8]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 16:30:13 +0000
From:   Jeremy Faith <jeremy.faith@jci.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug:git-check-ignore exit status is wrong for negative patterns when
 -v option used
Thread-Topic: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Index: AQHXO4AUDQX8jTZiwE6IhVGEoYJRiw==
Date:   Tue, 27 Apr 2021 16:30:13 +0000
Message-ID: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Enabled=True;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SiteId=a1f1e214-7ded-45b6-81a1-9e8ae3459641;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SetDate=2021-04-27T16:30:12.914Z;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Name=Internal;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_ContentBits=0;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Method=Standard;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=jci.com;
x-originating-ip: [82.24.136.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d45ae52d-6066-4953-a99c-08d90999bbee
x-ms-traffictypediagnostic: CY4P132MB0124:
x-microsoft-antispam-prvs: <CY4P132MB01247B74B7B6B0936455EB5985419@CY4P132MB0124.NAMP132.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /piQiy7rRflGQGc/9rKZZ9LiwVO9jNmkrq6V7avCNz2uxPWVMLhbhMtFK7E+o7JpUr6IRbCRR30aKFHOVJvcUwgd36iym19g22ktQJbJVaDTNs3w5EzP0mtes3S3ZNtnJykn32Mr2LLgg66FbHc8levMfC8u8TEEpkjWseYqwsQrnrJkFzpXRXu7ZUWQUk5nmnRJpXxpglAmhQF92QxorlkS6BkGaaUyVSDUyMiH4CdqY9WIBSuSxvp39Gtxh4wWByhwYO/76hRxn0dxe0wD5p6mGEG0AUdtRe5Nh7E+xKUloi71pijO3367X/JLJmVb+lBF+XlVbz6K3eyhF7uyDSXUqVpM0qO8pQpCXYdHjGFDqglS6SXsxT6yBdsSjm+6bWSDRxMQblz4wBUY5s7v0SJ4SsQVXRceCZ6q5DzNz5nGIznZWs3Ano1E+SE04sSdF5u8cWil+HugnhV7R+CKMMF+oH/wlYb8FqVDqa+v/HthtGbwskFQcbAumNgry6XtpfY617CHJzSXtXERpkUszQMf8+lrGACdiLwd493Kds0yN+jfC3DPPoNEFfhnHZ1Z47HXVsmIiccQ3Pg0KupW4nQb9z1QSTwngQSx0QiY46k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(52536014)(66476007)(66556008)(64756008)(66446008)(33656002)(7696005)(9686003)(44832011)(6506007)(2906002)(26005)(186003)(55016002)(316002)(86362001)(122000001)(4744005)(478600001)(71200400001)(8936002)(38100700002)(6916009)(76116006)(8676002)(5660300002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Dtf3ouWu57dfVpmIrH4vKBXspz7WF9xO9qIXMtoIKNnWM1EQQ0Hk1Gzlak?=
 =?iso-8859-1?Q?kaf8gMHJyh5oD5JhjhRYexRtVOY8IjgtMuQFUbG2fFfY5VsLL1RCsiN3xD?=
 =?iso-8859-1?Q?qQpM2B3CcCX87I+fI6mPB7yf9GoTUZWzv++XAkbyJDPqfVlHrOAvisf60x?=
 =?iso-8859-1?Q?G6OTjYEUcqx69PkPGehKl3ezDeaVo16ynL5uzwVRzEX913r/KG0P3OpwWn?=
 =?iso-8859-1?Q?9CWN2jt1c3W9szmQJ3w7DtesBRDqbG08DXYlOYGUcUzFsZbZSHLZfIi2vK?=
 =?iso-8859-1?Q?pR+JC6t9FAG+7EmQneNkHC4LNC2DzqhEHYEBZxEJ/ed5e1Oi2rypybqgNM?=
 =?iso-8859-1?Q?i1WM10FnRUF2SnNkhnsAzkspkR63fDHUfF6JdSs0Fpap1ggNn4XzoTrmpp?=
 =?iso-8859-1?Q?NyC6EwLgSVLWpBM09MDmkYWIKA6k3fa2nAV8zSY+zcclTVSggNtjRmPFC8?=
 =?iso-8859-1?Q?MOKj358OBNJTDBkJ0BMykNdp5odLw4/2+X3/vcPm5udG28ydi3WCRDWeGm?=
 =?iso-8859-1?Q?qi+a9fo8nxn0K8Tj6fsj8z65uZkPck0HFodZ5tKVeCT0R/VZHPeVH/y8V2?=
 =?iso-8859-1?Q?N2rZMYV33k4qWTXxWJWl29tkY0qeEwGavWORW6X2K68+WaJc7io/uZcLQP?=
 =?iso-8859-1?Q?wQce7ODvc9CjPYQ+sgw3HNGx34u9bFsEusepX8txDxE07rD7yfbZDXB88B?=
 =?iso-8859-1?Q?s904pk6Y36e1VDBeVFrevO5SXHhV+0nVlSxskh/GgDRspoUe6eKxIudXKQ?=
 =?iso-8859-1?Q?6UhpAk47rEUAOUYSFW79rUvwIKGWRr12WCQpZMJiMEMYdAJ6aRoyYkfxJr?=
 =?iso-8859-1?Q?JiyzrMKxGl8cL0lBsQz3QJwFIrTWpOFZB/6vrnDzrzZu5+Y5gtYD4j1hkG?=
 =?iso-8859-1?Q?r+ZnBQ2ang0RiIoovCQLNDOyr/3F4PN40GnIVIFDe9keG4EVZjqpL2Xt/1?=
 =?iso-8859-1?Q?/ZgpwzzVa0M/kGKQzlf0nVbX98P1Gs/G88iDzxtRPIumfW5fWViXJAMEpC?=
 =?iso-8859-1?Q?avKQhJ8FWa8L1iIUK19Hn4obhvNhOkLyxp0uEWaolZN2C3iPr4k62yLkIX?=
 =?iso-8859-1?Q?HfL9OnvPTQyLCJJjv97XrlEcTVZTm3wVwEyuhcKkQe9nLLsIoThgNJfstC?=
 =?iso-8859-1?Q?cV93XaEn5xrtVAdEnY+tBfXONDHm3t73AZ5LiOTUx/UXLyehUf7XVg0QiY?=
 =?iso-8859-1?Q?0ZwrNe9+zKZaWp0+VvR5e3H5T280MyDSBa7p4Q7J0oHAuyqomHac6zxALd?=
 =?iso-8859-1?Q?KzaAiO/VM+l2USqfr7lKEVJfwf0pMW9U7OTGHamGwQDqxY7h6e+pW+8p1Y?=
 =?iso-8859-1?Q?cfdtvZtLqRX0Tr4GyUQCizlIP0ug1yfjpxteosKFQ14+3wY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jci.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ae52d-6066-4953-a99c-08d90999bbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 16:30:13.5333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1f1e214-7ded-45b6-81a1-9e8ae3459641
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LWvyce+Ci9kwnapyPYNRrz89vpWfoYw0b3T5uof7GSftpRgrCh8TIRmbbYMGKUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P132MB0124
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
git version 2.31.1.362.g311531c9de=0A=
git-check-ignore =0A=
When a negative pattern is the last .gitignore match the -v option causes t=
he exit status to be 0 rather than the expected 1.=0A=
e.g say .gitignore contains  one line: !hello=0A=
git check-ignore hello #outputs nothing=0A=
echo $?  #shows correct exit status=3D1 i.e None of the provided paths are =
ignored.=0A=
but=0A=
git check-ignore -v hello #output is next line=0A=
.gitignore:4:!hello	hello=0A=
echo $?  #shows wrong exit status=3D0 i.e. One or more of the provided path=
s is ignored=0A=
=0A=
Following change seems to fix it for me=0A=
--- a/builtin/check-ignore.c=0A=
+++ b/builtin/check-ignore.c=0A=
@@ -114,7 +114,7 @@ static int check_ignore(struct dir_struct *dir,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!quiet && (pattern || show_non_matching=
))=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 output_pattern(pathspec.ite=
ms[i].original, pattern);=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pattern)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pattern && !(pattern->flags & PATTERN_FLA=
G_NEGATIVE))=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_ignored++;=0A=
=A0 =A0 =A0 =A0 }=0A=
=A0 =A0 =A0 =A0 free(seen);=0A=
=0A=
Regards,=0A=
Jeremy Faith=
