Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE395C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352911AbiDSNy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353326AbiDSNxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 09:53:13 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2110.outbound.protection.outlook.com [40.107.102.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174E938D98
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 06:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdjpWT3bmWjf3QvaWMBOKFZfH9kUfn0m/tStuMgeYjIRLG7HdOPnJrIHc4XJ9jIV6rPrDqnzNRQ3d4kavL7BgnY68rYwYbKbp201ZL1134YaJ0f8hLr7cOG/AMUIS8kYxo190rcW1BcR5X+XcR1G5rio9aqeGeuRykQ5OJzeJUkyhtYdYIoytZrd0vl8jXpw831GqkhXm/BK2gaK9atLf8H1SPx1Vw4t3H4XAnxYsPiTZeHGSK+qIKPy1hLdSdqOayMKcoT9W33n7UqHBwBuUQL4+09a9807RTNKfYRLEZKaSeZpSeqfe4tO95xaelN1Fiq4cGJC23izLIngkum+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCpCk9j72iJb1sePpjFo/C0UgM6Bt61Auy9BkvgqmlU=;
 b=ghY0sVTdPB8czsAlWArtzMu9wG8iQF3pth3tByDvdVOYCf0MHbtYG9RTEO47Ke2nhk6wIQWnzbQhrh3w1JGnshStKzMWJDjK10uNY/NV+xTNBQn+jcjCsBJDu2yMWYoZbJBIBUHbtpZU/GykVf69WxLKE9JLxLwDXQiVwLyelBRT54dZD7FYA2QA2KGNzgBJTcy0pgmABvWisSdroel3Fn8RgdfaLef+tKcgoT225qhTZkIMTotXyxOPs9VCPfiO9Uu6kj2mqKZUM8TMGxh8QLXELrfbe4im3sl5/FP4/wWDtFz2AecTn/r0V6YHoYolrcXQUotyz7Ih36LizQwN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucmerced.edu; dmarc=pass action=none header.from=ucmerced.edu;
 dkim=pass header.d=ucmerced.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucmerced.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCpCk9j72iJb1sePpjFo/C0UgM6Bt61Auy9BkvgqmlU=;
 b=QcqXwjTsNn00PntqlNcZL2yGbhoScy6aCjceqSG+5T7W+vjN+9rWVO0882YXVd8bEPrOuSvb6PGQMjuMeywxMSvMRaeQ/rQEmN5qD8+wo/rp7m7UddNW3XA8NyBRXGXsj2GGJEv5pK7zztEy4bampz+JfDvBf2iiWOhKf2OjJbA=
Received: from BYAPR06MB4517.namprd06.prod.outlook.com (2603:10b6:a03:49::15)
 by BN8PR06MB5748.namprd06.prod.outlook.com (2603:10b6:408:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 13:48:20 +0000
Received: from BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::48bb:88c4:a53c:af06]) by BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::48bb:88c4:a53c:af06%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 13:48:20 +0000
From:   Jack McGuinness <jmcguinness2@ucmerced.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC][RFC][Proposal] Unify ref-filter formats with other pretty
 formats
Thread-Topic: [GSoC][RFC][Proposal] Unify ref-filter formats with other pretty
 formats
Thread-Index: AQHYU/Od+Ps8NeuxtUiUBV0McXoTtQ==
Date:   Tue, 19 Apr 2022 13:48:20 +0000
Message-ID: <BYAPR06MB4517C164C76C68394411C023E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8f6968a2-6041-3949-ecd4-5b96776b1947
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucmerced.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf2c1119-fc99-478d-5ab0-08da220b43a8
x-ms-traffictypediagnostic: BN8PR06MB5748:EE_
x-microsoft-antispam-prvs: <BN8PR06MB5748482D29A45679608C6B82E6F29@BN8PR06MB5748.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5qm/nYv5dyhU2eGaKoEd87UmyZ/P6PP/JFtEPeq5w/E1aYUQzrSEsAN0GSkeaOZCGDdf0MkBZxm9RqILjU0eVQ+SNi/nUFO7TZHR9fKEq/dvngeuYL1PxoJgjChl09+7+v8BdemdRl+hHgZiVQHcEcylBeeWn+gO9UpchgBR5OnzBbDtTcRkol4mKstyFqAcr2oIxnJp3dmx3deNjTd7sapCqBHLmZuoFfh1fRsErjR1JnBnd/VrxNFNYKYI6Uo2Lv7s0OZum7gds7oKV8uL1NVT5/PVf+nkI6Z3kKWGA7vqVuZT4Az2uwCNtqzYr4ZdK6z8fM8vbFMXuRVgly6o7yIaW5vTgtE512WgO5CToxTZ+51/+JcZZuFdC46MTLHDpJNze8dNLpUIaDizZ/8O/7QMzjuefxFiR39jykD6modf/zN6gjPZss5csjQ8MHyamgZnKSxXa861PdIdf57k9izeiz58+mcjIs+E+PCanfM4ZA4X7FUWwYapZ+ybyoeCCvIYH06s+B9a4dJ6bsHIwpVf1twzzWZVe+kPSzWSjo9A/At+kUb9VBCEZjboRaHz+eUaNtD2cbJAsp+8FErNfqx0waDjfOJx0ySkOdKM7tyX/SwklfFxt3bqsZ19SpXrB6Hf098Ciof/fMpXdEP+A1U28hJ7hVx/do9ExLSlYeVDwlSlDWYVHujdnGHd/8SVFbHrx+woPMZ3WQQ3e75aiM3UNIgolJksF3DRbkPdddIiiVXKvAJ3bDK2L1qalGvKp5IT3hLGaPEMDh/C1PgzcOUEdb/CmO1iYga+TxfUmY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4517.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(76116006)(66446008)(64756008)(66556008)(66476007)(5660300002)(52536014)(4744005)(33656002)(8936002)(66946007)(2906002)(786003)(316002)(122000001)(9686003)(55016003)(71200400001)(6916009)(186003)(26005)(86362001)(75432002)(38070700005)(38100700002)(7696005)(6506007)(966005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PPKEIaES91NEKMh4FwjHtj2zCXXB1GojiH15FstyM8qEz2H7GOEIWhy3r6?=
 =?iso-8859-1?Q?zW6bsvfkv2NuFAC7OeCW9Ap4gUWRtYPmolg7MOESjR5ejysm3m1Xi/pESP?=
 =?iso-8859-1?Q?/lbr+SrI/WvoNmvtUMo55ir+vMlmDS9FerwdOFGRwkjINHagM4Rb1+uD3i?=
 =?iso-8859-1?Q?Na+tkTxqF07Grcrr7nIl+lQTLa7j1PLstiLZmu66WynqqB3ZIZ4j9v02Kp?=
 =?iso-8859-1?Q?Wyq7t/3kvMt7Sr4zE7jxsoaer27oHQkFobEK8qnr/8h9vZuZ6WAkE8FgCE?=
 =?iso-8859-1?Q?p/Z1W0UV1ciBOuhEkYIvxTkXY4kHCAcNWptaCTFkkI/ufMQ1PkDPSKD3D2?=
 =?iso-8859-1?Q?T8JJcYD9ZKwrNQ280XjO3zxhjYyW2E4xGHbS1gwjZQzl8VLaaECw9F9DGS?=
 =?iso-8859-1?Q?IGQme59UyJV3QuwtvWzM/E7pi4JinbLiH4AWpk8qovq1ijK3fORKTzJbnF?=
 =?iso-8859-1?Q?6Jfnc+Jw3LrGjnKA5aZIqqQ3lBjOHJtwyzPbunny4O/cNSTe9ybg+x7OCF?=
 =?iso-8859-1?Q?pcE6BkJS1QHhv7j5uKaSh8m8sylFyAjdMLt5a5on6r8nDqLmVbn5bfKSkx?=
 =?iso-8859-1?Q?QVcGlG1CUQszxYjE1L2zi+Rv/EGDIiajszyWe6NG0OLzMP34XV7VSILC3L?=
 =?iso-8859-1?Q?gtwI4xaIiZycQf6e9DTPkgLh8K4+DKPlnlFjI4HpLehcXcfASz99DGJhaE?=
 =?iso-8859-1?Q?CID/17wkbD9Q+ueyrPfLkxX3fzaVZwzXlwuM+gPZQmsXKZhSXUgYMK+mMT?=
 =?iso-8859-1?Q?IxR+Vt4JEeFei4biZQHnqLyzV5pyS8HR2pyPcetlW5QhyExhbXqcKhe71f?=
 =?iso-8859-1?Q?MSiOYx+OhPDY6JbIclyKQ76zhaswypc7Y3Ds1/Mc9W8ABFERCPMj2IzFe/?=
 =?iso-8859-1?Q?a/X1OjIfItR1cOFH/8Pp2DTvcBc4yFZBnGHEAdH1TqYmf3b9OljXA+TQeO?=
 =?iso-8859-1?Q?1OndQ8eTdFzmd77CDdqhCsIuywnCEFRzu0nzXHCTzsTzFw4J19CySse+h0?=
 =?iso-8859-1?Q?hWr3mdUGF5Jt5EciRkb9uX2nRXJUukzZZJqQ9TxRreqgBMQwVhXikYmUv4?=
 =?iso-8859-1?Q?K+5LPV/I3BrthHWNFxX0KFK14oDlxwSCUz9igsVR96M1iNZAxqJDKz/5EX?=
 =?iso-8859-1?Q?EnnsRbHvU4dl89/9yG23t9AMwbrPvobfmpapfVRR7iPZI6S6pa+e8AAtBN?=
 =?iso-8859-1?Q?jzDXM5h0+V3QwI7MaTogGGWxFofDF4+xM54t2x8LYlE7YOFjnR+fyHFX0i?=
 =?iso-8859-1?Q?3P42pG+PmaFjJuEAjZh+mhqOg5BbOdSt5COMh/Mz1fU7HsauC1Zb9Ypbnz?=
 =?iso-8859-1?Q?5Yv5Jg/cetTcGHez3bVkwoYg3x9PsAHA3phA+qB1iOtY5r5mvL1ifw1exC?=
 =?iso-8859-1?Q?n2usIJvWaS3DQ3fW90GciUF/6cnd+t0Z2esa7ebk7joRB373UjJdpExLDc?=
 =?iso-8859-1?Q?KSPb34zOrdpONAhlU+QPZw8YUHCMgmHd8OAMGVjlpwEebVBqV4Lg1BWpsg?=
 =?iso-8859-1?Q?qsmoENeX/Lqjxgv1bsKD8m+EDZq/ZKtsLFAUk48UnS3/KDdOLxzH/6gidA?=
 =?iso-8859-1?Q?DAQPC3+PxJaCHwtLJ+Y1RKzsyyHmuNkzyYJ2V+lWL8s4ou7Be+nfA1MI1h?=
 =?iso-8859-1?Q?HPpCybyKDJ9SJsPC+m/UL9aoJxq+WGksZS2ciVhGd+AV5+w3+9j0sA94H3?=
 =?iso-8859-1?Q?3RvD4SYGdy4kBZaHSEnf4fCqxPp9EgtK+nSO346adHGaVxoNE0tJHf+Tde?=
 =?iso-8859-1?Q?nGHibAEQvLyUSUOQM/qoYYuCk8i/cv63YgvdOTSrSTC4X1mdKwzn6fXFue?=
 =?iso-8859-1?Q?ZcjffxMl/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucmerced.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4517.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c1119-fc99-478d-5ab0-08da220b43a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 13:48:20.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4dfe9a3-ca78-4998-b7a7-e6d0692eace6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZy/A9jCsSY0zDWzqRMtv1q16fPsGT5fxut8WbdJw9TQ7UX8/dBo7wVT4X+rcTvrCKRJzfyvD4Ns8tQ3Y5/Kg9ixTqcgjf1ap09lYyDiAo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5748
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, thanks for checking out my proposal. I know that I really couldn't be a=
ny later with submitting this, but due to some time constraints I had to ma=
ke do. Included is the plaintext version of my proposal, along with a link =
to the Google Doc version, which is what I am submitting to GSoC. Well I wo=
uld love feedback, I waited way to long and I am just going to turn it in a=
s is. =0A=
=0A=
Thanks for your time,=0A=
-Jack McGuinness <jmcguinness2@ucmerced.edu>=0A=
=0A=
Google Doc - https://docs.google.com/document/d/1KhVGkSgBaya8Q6X9z7tUwVJegm=
urwMS0xmzYj9DRMMY/edit?usp=3Dsharing=0A=
=0A=
Plaintext -=0A=
