Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9739C5479D
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 01:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjALByM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 20:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjALByK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 20:54:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2094.outbound.protection.outlook.com [40.92.21.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905843AB0D
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 17:54:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG92YvXrJASFLtRepXuh562I5xu02aGN0pifcm9osWeX9nHJ62W+pzUtEy3FNJngrEYae/GyyzIbXjUbAFZXV3ICitEMCGejnT1vTKP82BPpxDd8Zor8TLnbcng6iIY2lVb+srPzSjxbDsBC0aG8S2jUxmDKXU7u5/dW2Kc5ZD1a9nRG4fIKmZjp+EVC50dUFTsvHED/tk8P2ZNZMun2TQ9VdomjiVm43inMNUF7HgYCAx6WKxi0z0/WKXendfwWjbfbWNWap/kPXxg6Pv1UX1T3t4ET2eKyDGIba6awxoO4Cusz3cfZMuKyA00Tn/WXhGtlzENub2LGxIm/khqCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlxD5EY/ivjPAtvOYfncGq+8w5qXgq5oPlWqFhHFyqA=;
 b=Wc3qCmSWu6QpigatKX4o+cMle4/7BIXrB23I0mo5HQPkz874FeFX//QLAUjhc4yTYOtXcoTESdjNQWIbPrV1/Q4B7qKR0Uc+wrEDkpvDEdQhR6lwTD6WBFCkurx47LfpMjjPMSkJ4m07U2yW1+efHkN4qfF8UNVVz/4hETa/rzYB0iwBTiNr4D03vjWuItRHL5ikjrDXsVCNBqbkbswLmuyXb3zU3Jq1epZby9S8H8OLZAIcLLLYIWkXjII5J7HwTDlCDcRgePw5YcWXX6QZFFV32eSYIyXpPFKCONWYTcEufslnPtX+ERAZYF9MkKAWRi6oVKLffSVdrwc+FAYbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlxD5EY/ivjPAtvOYfncGq+8w5qXgq5oPlWqFhHFyqA=;
 b=EJ3ZiARYpLyAvMaJb+59RmbEZetU0iJxH5Ob0XI2p5loRUvvPJHBdYVG4IqP6bP9LjW7MAmZaNfOfrlm+MesEdv91IqxzZD4Xk8eJjJurH2EQcH25HJ6mz9UrNZHnKhCn5piRvlLTkYZfXMr8ha/8/E9fx5poNKUBvioxA4t5IQiFRx/Jo5Se64VgNTb3szRzRdiEJ7cUkSISY6VCL+8uYDvXt92PzuzRNBGMcEmd3uss5s7YXIoQX4Mrxv1xT6LrWuaFB5RIv6owD5gh/lfS+c5FKmnIyocbL0ha3mfx6mRXVKwDz6FABXxIklclpXUX+AHS61KjVruYKRElLUWvA==
Received: from PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 01:54:06 +0000
Received: from PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f]) by PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f%9]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 01:54:06 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Topic: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Index: AQHZI8zQrYgXZgWbmUmkNkq+e9xLvK6W8qAAgABRgnuAAToeAIABKe92gABfOwk=
Date:   Thu, 12 Jan 2023 01:54:06 +0000
Message-ID: <PH7PR12MB779537896DF1C71188E0E683F1FD9@PH7PR12MB7795.namprd12.prod.outlook.com>
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
 <PH7PR12MB7795ED45E989E2EDE2364049F1FF9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BGh17pH1DUgPOoaDKBcKay3NAyi4js-HnEKAAyYUBSoYQ@mail.gmail.com>
 <PH7PR12MB77959E90F52C59140ED662DBF1FC9@PH7PR12MB7795.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB77959E90F52C59140ED662DBF1FC9@PH7PR12MB7795.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [LIrsrcC/VCnLL7kzki/kjO7HRYAiBB/QvolEs9T5+clEwqyBjg6zFw==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7795:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: fe0069b8-7be2-48ee-2fbb-08daf43fe360
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tpxHjeC31cXd9OgVTPa4lXotOYLkGy8ljevDL7S5LkHb0Qdt3G2BYr1Pk3pEhziJcmqDEYF4J2VXAT8AtISOptfOAHpDAug8l3PeD2h7QMd/5Ek/2PFNsudcm6qKcfgeBg9qotk+ST8sGfUmZClvqTqPx2t1eP8MxTMN8pIHg1f/Z0J0+PkVV0j0DTL/iysEYq0v4bjbwr/QjBahymwa8JRAd/7+t4tiqDI1GwyiubOLLU3y8AQZrRft/NQdNfTBsaKvh2D6qkflI24g56kuDeZaaigC+YQsLLBD5a2+6NLQbSxJgw4iJxXooXq5WCUqrhmx7SWEnE/V/RKAZtAqLYJB9IYayqxDbpQqwET3xvjQwulS9ZLXQLefKiGgK6jHop5CYpIdhuhjilieKmYGrC1XDG54CktT+06LKYO0GB9uREaNgDisIwGGXFl9ryYw7iOUnIoO51b6WJcpSX+B8l7ipPYNovGYXoOKZ4KAHOZiRB3k58WNlIRH1/++zIfuKBbHs1xMAs+rt41g7IcVQvve9uBoEsvNYLy9oppCbrx9d7UdpcyIyzwhmJirUB12Lz6Ri6hn1Qn92PbtGwjQHUtkdLkUZDmwCYlJn+KB/FhJJ5YyM26/CHt4gVObQbb7d4ZmKHD3P6cbPpzcZt7eA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g6EYbPaXbI/69CsXgOi2/GGIYV/WKIeWwaFOguldSZP/h3V12lBXVaFySY?=
 =?iso-8859-1?Q?/cLMR9w8qtC9pjGj3JTKURZ9/Jwa7tdjZMGfyhE51gxxHfASqLgBmedOYU?=
 =?iso-8859-1?Q?/SboYlBzg8TP/hQFYQ5pcZQMcDxAPNRw4rU7MC485d+Zrkllf6WkybVInY?=
 =?iso-8859-1?Q?YfwfFZcjTlDP5fzRcDPi4non4ut5bwCeyRrZo6a4FSo2MLPCjiMl54G0t2?=
 =?iso-8859-1?Q?dgpBAcqVyZzmkSKo3jIwdz27lj9l1y6pSp9u9atA3h87pk14BcZukMfO/j?=
 =?iso-8859-1?Q?PY2q1ZwOyOTYFO32gWfmutP4XTtxru0Ly310FKcmHXZsxUKgjMlLhkBrES?=
 =?iso-8859-1?Q?iNU0fP3rlM3qHsC8ivJ1e+a0KHhHH/6u86fGAWvONI03yx7+QsBeN1ecoN?=
 =?iso-8859-1?Q?MyJrPCFNYTxpZYn3W0cFVa+iXvqIxoD9rHxz69Kl4DWTC1QvkP6nJ8Rerd?=
 =?iso-8859-1?Q?wDXq5kfGgKoOObL8nt4hb2deb9BYRwfFQ8PpND3YNwnUaCz3ZTF+Frx/fj?=
 =?iso-8859-1?Q?N/8ENFk1KdbkM9zfvy2XQGeEsE5DWcWENwBBmm8jcosUKYQhlzXhPoR9US?=
 =?iso-8859-1?Q?xNfZObhScthVvSKFA59Kqh96iroSIrRhoLs93AQcaV1FnOl8BRTHFiNnje?=
 =?iso-8859-1?Q?cCZ/vS1BaNr/8+KE0OLG5RhPP7L1cB8FHGOUEYe1rd+yIv8+sSCp5cirr9?=
 =?iso-8859-1?Q?zhT0AqU+ZjSEsM3KDIj9YYByDZYtvWVo9J77QuvAncbpVaJWzG2C4dmPXJ?=
 =?iso-8859-1?Q?VIayiJBDwH2GIlsVT5qVaYumZoeHnOIYOLxnUTNz7HF+OpzZQHHBcNMYTW?=
 =?iso-8859-1?Q?yQLQXOh++bD+Bb80kk876UPT0LweyKusAtbnDN5niN63jATZF+aWg+aTS3?=
 =?iso-8859-1?Q?AcTW7X1wFQ98PKGkXPvm351ca6qos+GQ/tV7yZ19QSTHm3p7F1HjH55CV+?=
 =?iso-8859-1?Q?8QSDYdSmNQk/KSU/nNytFLeWGKmYr6SGYHrTf174MCR9PHazFCMM3GRvjd?=
 =?iso-8859-1?Q?kEd98IzphOdGA1CRJHnHfp21Z9ouo8vqtH6W6NtcNoQqpaNcRsHsdGFQhI?=
 =?iso-8859-1?Q?VwVoZtHiiJ4DV+r2gRo5Gjgfqnx0RDQlCSwl9xWwA4gHOLSwdMM3e5dO1o?=
 =?iso-8859-1?Q?NyEuaEoeRQ1LgvTdSY3UYmBPsOC8p1N5QhIENQCP6HW2DIrZXtBAF2PME+?=
 =?iso-8859-1?Q?7W4bA7+WrDlmRm1PpXIBKMVjkrG91hKG5nTvPtaHMjW8AyaqlZ+ShaOP4r?=
 =?iso-8859-1?Q?d2eprVa/SWFM0UlpxXUTrKjBN1Lw3xE6yJ+TrXGyXOai9Hr2r72Rmqny7X?=
 =?iso-8859-1?Q?l6r4sAp3J+EaxhE7HI0fT+mtuuB/+AtKlaidDnvDktvwjas=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7795.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0069b8-7be2-48ee-2fbb-08daf43fe360
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 01:54:06.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
I have checked the repository size at here: https://github.com/settings/rep=
ositories  and it got reduced from 4.7Gb to 3.3Gb.=0A=
=0A=
Thank you, have been trying to reduce the repo size from last 15 days.=0A=
=0A=
Regards,=0A=
Fawaz Ahmed=
