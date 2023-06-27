Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1958CEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 18:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjF0SHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjF0SHd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 14:07:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2084.outbound.protection.outlook.com [40.92.40.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81310A
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 11:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJonn6sRqSu/7GHPSwvVAp+qXOZC+X6Ug3jOm6JjdydqRXGHg6/9GpU3iK2JX3sRQcltAIaG6UzwSNwoohVf0kzHPQGZD0uZ73jOm1MlL3kStEnpY3c2UWgRrcg6Qkq7WodFPqkNWVdUjq29lWfeKLcsKsdZZAMHCTTDAq2qFx7SaB0AH4usmzEPgZ8pEAxKty4jt/UyMuCsttVwuQO9XXfcSCf9fvBnPa0KWKXBT4QqGiJC61gJFdVc/LOxIxNNU+fu+oJfDHiZAKPHjg1Bx/AbSEBjQOkIfruzxWg3dbsXCjJJa3GP0DD9n3W861BvJFaXohhPGiLMt4UOBfN0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7tX6FxqFZ+PguFygRvm/VodF1EwTU9Jn5R68n80saU=;
 b=obp6FRnDaNC2+Khg42xqrGqn9xmX+AmyRah5M+yPMwowigzv91aR2N6bnXhqfJzKhTVJKU6KQHm/xM0DrcWYUVzOJa6U3Uo2z5Hzj6o92NJ+nAnKjubP1AzsBnC8/wmFM2p8PKeHy+366nzos9P6e49ubKOlxeyTaoI2wBZXFmudCv39RDmHevFyc97ps6d+nJ1N9EuQU6zLzRt+hpfb/N3E96XLs1x84wYBse4vnyKVlANLo+VJGdRw98w0EEoQO8TVQoaRWRALlUyzQBJFM8mlW/sfsAR7rQfUJ/B/xE17yxY5P31PhSpxmjmNl15L+Zgj4qXxALmQDHSVo3rjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7tX6FxqFZ+PguFygRvm/VodF1EwTU9Jn5R68n80saU=;
 b=oCnNnvRhLhnfiz3voSvMnYRENOynt7YX77i/DFVxnYF6eZWhpUNbAEjzg2ygl3rS2bM/eIOKR1888BTMjjBXjQjJiOCyWWSLD+qpODBQFMk3aGgrsj/gNIaZK0QQGmBGok1XbLb31/5Jq8MExQqhzkZeLek8AED6IzgYCnOYWmq89AQzVfN1AwIhXNt3VBc5FWWyBRA5V9Nutw7iBLrOquIsYoQkNAfQ3ISKIEt+VjysnV6nLbYY37myuExNb6cYw6qdfefjTS0Mtq7iVtfzyrc37kgrhZP3zGpbMhJ3db1eE28WyifHud9dycrkVQbfCPqacAvAgo3u9I5K+WC88w==
Received: from CH2PR07MB7334.namprd07.prod.outlook.com (2603:10b6:610:ab::12)
 by CY8PR07MB9498.namprd07.prod.outlook.com (2603:10b6:930:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 27 Jun
 2023 18:07:29 +0000
Received: from CH2PR07MB7334.namprd07.prod.outlook.com
 ([fe80::abe8:5ec2:f7bc:233e]) by CH2PR07MB7334.namprd07.prod.outlook.com
 ([fe80::abe8:5ec2:f7bc:233e%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 18:07:29 +0000
From:   ross thomas <rossrecovery93245@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Send out for squad
Thread-Topic: Send out for squad
Thread-Index: AQHZqSI8HJ3Uo8umA0Oii1YYYsU8Pw==
Date:   Tue, 27 Jun 2023 18:07:29 +0000
Message-ID: <CH2PR07MB733445BD7FD5F35984A2BA3AFB27A@CH2PR07MB7334.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [GiLNSJLoJTt8Qc1UZ0eJSMuf3G8RNr5zarNIdK9NYnw=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR07MB7334:EE_|CY8PR07MB9498:EE_
x-ms-office365-filtering-correlation-id: 3fb992bd-4d41-4760-2b27-08db77395f0f
x-ms-exchange-slblob-mailprops: EgT5Wr3QDKz0tpAFxEX2B1AKj4NQrtWzl6eGGDK45gst4WSTI5Pa+kY1R4cTADMgfQF1W4uRlaM0YZSKVzoeH5OLDjZmYkENjBn2YkLKbeAyuMxbTrBBSKzGyn/8TUaSzl364tXYyKNLAA9xd0f1QGGxh2JLmXmKDDHWCZtxRgPuihTl7I9X1W3arSo+lVearDFO84sRjOydNsaP1/BGE4nuPnWW9n9DIv9Dbr2sTLOvRsrIzBwc76bO0yK3zxJDCgcshqoTF9CZ7DPmus4iYxtEiLBu4yDiOZMoeIqQ3KGrEiT/qbUVVJPpnhJ1DyFK6acrnjkEfiBpIQGhkWenW3I4J8L2vNhYjVETrsmwVAdv7LK+acj8gKWAxAE8rCQlavZsjxYxe3wA+vxWObaOv9aNZ0Axh+d6PRi31OHda3tPX1uAg2iLB9JDEvrEIj5FXijPyN2NO/deWDj0rE+Yx57Onk4iQo1xe/aPgCwWRurP7s9crEjn5YWCbRzLs1bB0zyJGqt8KKoMHOdD4jHaNDhTlNzpWwtIV7tVeT+qDTo2u7v5+MXQLlA7fAyUO6XjBfgiaGKKnCLvTlH6wb5NoX56ELOchZF8+JiW1QcD5N527MW2gu9g9CbqDyUfAfJMHSuPPdchd+Vt1gcKNYXt96AiE/6B2U+VnKEDjzFAcT+Us0JteEkfEgtJwyw2aotxlY+7ZTs0Fxmg3BTrrKjQWcCT4sUgj8HpXt90uf3hmW4=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x801S0tZpno7XlhGitpQZsB5x3gnHMWTB4XiNjh7xzieODutrOyy6AMUsc2d6EpxvqEtPnuwjyIWv8UVzZsUKDrc8wQ2T7PwtGacCH7ZGlMy9rLwjN+q9NTu6W3maWHfqNQoNME7Ne+wWI5Cc1jK9Z9fu+7EDSuWT04tPnQ15oJ5c8b+PeuQuME5bYung/0lOTUSiIH3Eqo3elzpYCPAYmfxTIxk8311hqPEz3+wKUsqlBX4AfpMeFURO/Jyt4KeN3TQDoyGhNakC4bTDGK/busH0BkbC3h+x+kH+9QYmRMpMsZkPqv2c6Pb2ExsruK9MBFvW0Cf17hIXrj8oOFAMhHd/Nr3vpQXFvnwjqgaFzkA++6rbxuXN3BEP2To6c/4QvgtmVPX8QCcqvW66eeP6jjWsD437ytknhTY2ff2h6/eTXFVAG/Fzt91vHIIXkj8jB0Ss4kz1pAOggSZAsgXo/w31WAWOMMDyvmD9xQm4EH1c1UMdQ4kX1XQ5R28wDGG7kZ2wbhzI2VHd0dU3/uOGYZd7ui60SodiLnA6GozQ+KlZHrqFg4VnpSdVc9Yt9N5p4/P2BhXHR34v+7jGS0CFF6NqQzMWKbt2FLoHYoiNiN0WZe1Ij6GHfJxkGORmR3t
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8lDO3eybg/Heb+dC4GrP4XGi4qY5Vg9lUgU/TUybA7mnbAcm/OGr+x9xWbfL?=
 =?us-ascii?Q?K51i6Nfa/NZpgefmuSGfNPw8I48D8bIM9sUw4mM7tYxhwdNh5jexNG7JtaRl?=
 =?us-ascii?Q?dnIqDnRcuxD7cohWMUNRPOGzCC07qr/4TeJucsP/X7fhtn6ZoCOmFfi3uKi3?=
 =?us-ascii?Q?+zKxaKO5ti34Wq2FJZsNH3xWLCNNJfY4+7IEszM3VLF+O4l8OVx5wHu071EM?=
 =?us-ascii?Q?3NYDCts0YPp048TCO2jO8v/a7rYDA0DJRDUusCWDHQVs5yXKHVBoo5LslNaG?=
 =?us-ascii?Q?d2RJG051L0S8RG+RPhwyuvWTLwyowASPvOpiyeiFoofGCPir3v++cCYu/czi?=
 =?us-ascii?Q?JAQokO61sfSJPAqi8jRtLbEyq4SXEGpZUhm2MbBmimRAoNcKCqXjMvbRu/9/?=
 =?us-ascii?Q?1hMdlw2zrmFC+gT4tr6ntOLAyqJGa2+8aVw3hPImOxNunYiKbr4ocQRKIb8e?=
 =?us-ascii?Q?Y3dxWZS5tYGifw2XySx3G3XBovKhN8+X8qrHZR2oUjaZZ2uL4adL88UlQs0z?=
 =?us-ascii?Q?yodGXlCDDPiiEqFlRIPEiD19Euz90JRmlBid6KEP9Kn6LoHPlwMlG1w0J9nm?=
 =?us-ascii?Q?kTXrlLZKWLa3svvGO+2uUPnFTiShUzdja/ORZcbqTQoviEpisf/HcqwxkhKs?=
 =?us-ascii?Q?wVjJ9CdmSBVLC0fVCcRCZGKqGTlHcWmZk4uSOsNb9dZsPIz2a6eZyh/KZ64/?=
 =?us-ascii?Q?Oo8//ldXn7b/7/SkHfh4hWMVU/kC4Bn82Onmxi8XQPr1P75GVCXuIGXlwe+U?=
 =?us-ascii?Q?zMvWwBaS7rOOIa89YhQ5a0hQ91oZsmSqtF5v3s8UMiJq1c8FHrH8cXQWnVls?=
 =?us-ascii?Q?OlBOHqhA2/BMRv/f6QszMWxtRAQ13CjzMNTOcOt4aU56Vsctty294Eg0am4E?=
 =?us-ascii?Q?vAB9qnO0WzxW+Rfg4Safo4efeWyeyTZmW0FOhh4r8g2einG0efAgaKTew5AG?=
 =?us-ascii?Q?hAfN/PEJUGLBn1uGPy1dJ8cg1q3a1+lLaBsEIa+J+WhgKTwbSmUZdaQqJXVC?=
 =?us-ascii?Q?UOjmQRtaGuUFGr2S/hDsA+ISAD/Db/8oeA/g5xWF0Vz164wTjkBHN9bQYUbE?=
 =?us-ascii?Q?g2+M6OztIsTm/URxLb6WHlplCjSVXU+/GWe3DCVxP2+Tf3zI73fkhVxGzsap?=
 =?us-ascii?Q?chYdcYh4Z4rxuEBSbnfEVdkCOu9FUDqSFBqlwiNS7xBDl8iXTmYa/UZj1Y9D?=
 =?us-ascii?Q?FEunA1zPVrPFfY3utW6SlqY4Kky2QWSarD1Aah9cyAJICSk9SNQl280TpT9o?=
 =?us-ascii?Q?hmEyZUr8K6u1MYTT56sm?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <956E3B308B66BF46AF49417E5B189F13@sct-15-20-4755-11-msonline-outlook-5fbaf.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR07MB7334.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb992bd-4d41-4760-2b27-08db77395f0f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 18:07:29.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR07MB9498
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Send battle squad for Joseph nickolas Thomas Joseph manual Thomas, Sherrie =
Lynn Thomas Joyce Thomas, violet rose, ray rose, dalton rose this is Ross N=
icholas oneil thomas, octocat=20

Sent from my iPhone=
