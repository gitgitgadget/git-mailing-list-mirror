Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF662C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCVKfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCVKe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 06:34:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2047.outbound.protection.outlook.com [40.92.89.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E5559E7
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 03:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPJNuJbgWIjo9Y6+vEsczaYBcqCty3Bglq2lndl5HqNJbH1Xt3m743daqneMTqXCCB6fOxLZ0O6iFhHs1fItkCbyMZ1dQP5+ed2PzwkTYuOHRxhWNdf4hguoj1PQdSNMK4OvwE42JYab/1G3NiYWMW8A/ZweNT+ovaqQLDLjCYt+GCmKL/0qv5kVmLfn0qdQCQZTq52YsILLJXn0luT0DZHZRsXPd2OTkM/JaUludMic4p87Bg7IA16Ac81SbjT8hIw5dsZiGXEQgIbgUlDj78SKI8Xza6hrgO9hlPiRTNAk4FURBMrnd0Q6cz9ehlaTy98XurXOOp2iudpbUxS8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgADfcfoMobx6GieWHov6N8fttCNeKBbkwhG1BDzNuA=;
 b=bua0L730BE3alkXlwclQHy7+TvlQ2F+JOw1TPYJZnKsuuA9utXS62YLI45h+g8pu/uWF5+3n7oETpgat12CV8Y8m676dWxAnfTalzWUz2RTUD20Lqpz1++5qpGr1bEPQSam3IqCEItWsaJWyOzspqtBof96ECPo2zVfq6SicGfKubN9GvQFIi2/JM0yQ3LdP3kwXjYqEdN4GzDjypoKa1y9tQqk2yRwIuWWvf5wJV1OJhu7swXrVv3ulXydKzuXAA1rzh2IAmJcVTGVjgV3XLAa2zcYsOTjqsN864iG2Oh8oUdSOnF+/3I5y2KIEIwp3fJRYW1Xu5+z5XFLD+aFSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgADfcfoMobx6GieWHov6N8fttCNeKBbkwhG1BDzNuA=;
 b=gSntuqsa3yDEJD+1+y51Sy6JprHEaC0jQIq0mExC8Q2nuELip7olodLa5yHmRYzKRjSNio4eFn4XesPFFPfHhsWIDZmseKO4GHDauUJuDvADIb2xw8Tw9hJ7sdAdhk0dG0AnJ2PwxWWDii2pFOQNaiGvQTdMpPBSse6HJQGKQnsDgtXyx8lQ6N7p4HAWekaaBK9bWmNJnN0KSbhgYv6u2Uh4u0brIzynISHVH3iexmx4vSbenizzDaOfWs7m44m293KZQ8YBQ5SfCD1MR+eI6JeSE6bKLJVT1QU9kpgRQT749pT8pCLTVC9eSFtAa15NwZUcf+dybVF/9EZwVefgIg==
Received: from AS2PR03MB9193.eurprd03.prod.outlook.com (2603:10a6:20b:5fd::16)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 10:34:56 +0000
Received: from AS2PR03MB9193.eurprd03.prod.outlook.com
 ([fe80::3438:3c30:15cb:d1e5]) by AS2PR03MB9193.eurprd03.prod.outlook.com
 ([fe80::3438:3c30:15cb:d1e5%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 10:34:56 +0000
From:   Richard Spano <richard.spano@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: System Environmental Variables being wiped on update
Thread-Topic: System Environmental Variables being wiped on update
Thread-Index: AQHZXKnFzCWeAFef60aRXyvsddmxdw==
Date:   Wed, 22 Mar 2023 10:34:55 +0000
Message-ID: <AS2PR03MB919368C4FB4C7F94255D2CEA89869@AS2PR03MB9193.eurprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [0RymLM8LcbUCiPhnhCzKpaRaXFt7iVwb]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR03MB9193:EE_|AS8PR03MB6775:EE_
x-ms-office365-filtering-correlation-id: 756f51c0-e7a3-4708-5605-08db2ac11449
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJ5w52M1juXkrCtOKGC0eCwiuHrRwfQSU6eTTvx6G7NeMReYXo3fM5XIJoqVPFsaTqcJ2/vbRfbaYdMr7UBajxPQyWsAeFvhGAVFwkqN84BfWxO42Ekmc+fUKE8JZFLn1o02eU6TupJfKrDAPjDdl4/wyM7UgCxfp5HEm85YpLZXXh3gaiaeYGa1ZI2zY2PenDSHxEM3YCJQkPoIsdzNupJr1D/6R3D1YU2C19lzebalAIudG+D/qPK8m108fhceqHBH7ECOUvnt+UL02kwEq2YnRIVyovrKXSAk4DI2cvaQ2sXJN859FErkDHoC7yiaq2cuDKMZ2IEU3EzN3DMQbW5Is9sBHOa7PWvGmaKFEDAIKErBHXVUokEejOvYJ+Hs9G5Dq8k4mgBKg1DGlTjcZUoOCO0BHyIumCrJdTYaQKVcTGqJgWNO5WL7mEnzNgrTayAbz7+ItsSiSpkd6u1z1JMlCLqIAvMCHac7NNpxxxoQtpis7EK4YK6HAYQaIO/FSfS9UnoPa+NOJpyOPPnDOEzRb2aYVDPl8T0zH1WzjDKraaYe0uHE7CbWnDwWTfmUcknJgj26dqflC4mJfoFe08gHEzXpKO6bQyMRG4oJ+T4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?2mWsee+ow1vU7ITttFiZ42c7cTAs1LoYqNUUUNzql9Fv+ha++I3kRd/o?=
 =?Windows-1252?Q?+pkA8KRfNxO++RepVfLTN6AC3+B5YptXuxczZLocZKPOA80Vkesl73wY?=
 =?Windows-1252?Q?6nVhpyRcA6Bo4uIA/aE9HJG2W5rCL5/SJlAtrqf3bsuj64TB7Vu54RtD?=
 =?Windows-1252?Q?3gxlHpVf4x5uNyNS35Kge/OJ32JB1GSGOtBGyv8eDWJITANtGPbPhzIg?=
 =?Windows-1252?Q?XekNGSXxzCuqIIF4x4Ax3xDzRuz4+H0plR/c8F5+fCQkAjE4eO/NQkZK?=
 =?Windows-1252?Q?ANlP4ghwvwzjMEkL0frRj3fdNnVp53QDeuT6B/Wks0Q09F2eVH96BdiX?=
 =?Windows-1252?Q?H5y5HNCZ06S01WeC1p4cXML96GIWt7nvDpWggHNPUSWUd7rNf8njLWwI?=
 =?Windows-1252?Q?0cygLaQ2edY7f2/dHy6fDrBZmskF2HUecFG574qimrtD6vZa7JF8Y5ZF?=
 =?Windows-1252?Q?qJSmbGm7ThDQkRgpL6sAvmtuxg3XWjq+lQmr9tLIodMeQva//VqSvE8Q?=
 =?Windows-1252?Q?DNjPChFk9MlufuVFQjNXxKgqJXdadgD6OZRfPpD89qHeRSDCzUjFGGbj?=
 =?Windows-1252?Q?hXoSA4f4X4iGZSUkqmYDjpk6QXMfTCfZ0ldMaiXX6xJkF2gnDbN2QyrW?=
 =?Windows-1252?Q?IQz9LO34zLjlbt881jrHRfEQ0NOta5Dws1FsjiHmliLF6Ty2OGaf7LbR?=
 =?Windows-1252?Q?1dkQ4nycWkPR2lQTCEgh5tDlORvPLxaR+l48I5FrwE53SjKoA7et8i1z?=
 =?Windows-1252?Q?oBQWauLukhhVeHM/Q09mdZyhRR5D+l8m8N4Cjp52D5nFWRkSXH2Lxfi+?=
 =?Windows-1252?Q?pTxqEZeOqSt/2oMfD1NoSMVWI2aa0cfgNB2/ss9j4pd5cNDYnR33WdhI?=
 =?Windows-1252?Q?uGA/VHyecgT4idjGcZTmf5PlEASURok+9hS95lg/NJLaldl4mJ+GY1tu?=
 =?Windows-1252?Q?gQaLywLK/mfsCIPqcIAlhk5xwqDMgei3tjHb8iILTeHQRV4SL3f/lHup?=
 =?Windows-1252?Q?Q87WopxqjSgNQWLc4/kAxzCgj3ebSElGGTFy3dXlVv3FJ14dBas8SwvQ?=
 =?Windows-1252?Q?XRjyNzOkMvlRl0IW1Toc7498mSEbAkySA2TbSjTFIZp9RidrMN+qmCjV?=
 =?Windows-1252?Q?qF+9qPALymaLo32u3xHZ7eNeS25yPOft3M6I13G9hPwCVWBV4sLTbloF?=
 =?Windows-1252?Q?MVC0Yn4InmyvqIQ1ekzcbgluvEM7rN50SsyKhrr7OFewsethNdRWTReh?=
 =?Windows-1252?Q?oyTdS2Y3m+DiUHi9fMCtLcT1k4DNf+Yd8df0+uehoKFrK8kRpytcuKig?=
 =?Windows-1252?Q?03CyxTPpp58gfVhn6dmwQV13ppvc2jRnUW+9Kc5fiAfurOq/4cbGwLKg?=
 =?Windows-1252?Q?TCwgSXGPTUGY0A=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9193.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 756f51c0-e7a3-4708-5605-08db2ac11449
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 10:34:55.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=0A=
=0A=
I couldn=92t find anything for this so we wanted to reach out.=0A=
=0A=
We have GIT installed on machine and we have =93C:\Program Files\Git\usr\bi=
n\=94 added to the PATH system variable (windows). When updating GIT this a=
ddition to the PATH variable is wiped. If this is not noticed then we have =
issues with GIT until we manually re-add this in.=0A=
=0A=
Is there a way to stop these variables being removed during a GIT update?=
=0A=
=0A=
=0A=
Regards,=A0=0A=
=0A=
=A0=A0=A0=A0=A0 Richard Spano=0A=
=0A=
=A0 =A0=
