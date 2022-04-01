Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20050C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbiDAOjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiDAOcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:32:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249CA1EF5E6
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO0fSDQUyQjLwXAMKZbSHgwW1Oyv4Ufu2MomJqsAgr2JnHKU5msDgPLIbw9pUg4evFyIQJfhYgMpe9FsaPHrBfzfj4kpuYYCA7cT23qD/ukf7RVKz2BXK7jbfZYsVZZ3jXhU9P+avc8lHj2BesiTHJiQtWWk9KT37PH3bu4mHAzU5Li0KA7mPSCGYWMpSnX0crqSUkxlc1Y7DIhm/5dsWoMUjMUkEQ33NRM909KmQzFUmdoYsNMYoEUPoAQr1UDtqZWxjmMQhbJQXOZ0z0rdoDMeKD3oT6bxQePWWKR2f0D5qSjcLHYM+VN00j1UMBgjjMfXjDn6jywL93P2yiBdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvTyRRafp87U4gBbE8OpOFUbPoF6z+1BO9WE9j5+tG0=;
 b=a6qm4iWD4rl24Yaw7sTF1LAj0oUVkdD9isNhSqj8Be+WmgFPrMmY33m+VxJUxKb4WOUj0e38bKSA2+d+u39F+ggXg9kdo9VLe3q7uvClDbCIUDHLIU95ZdLiTR42oEnNBVKPajGC3JrFCEvHmVX+GtDmMFrVDfaHkWLHa9k2/86LTm63tiYwPlDsy9+gQT/pUpEz4TSEX/oFBycZIMyWH7fQ5dmuply92Jl/QxJ9CcSTJ8p0BHaPkyYUhYIASMiRte273dO18NKMfEFbeT9q/GT+9FWfPeitUtDQ1neXq/YbKAxkJwvpZ48geCbG+sm+9W67WA0SZcuIEuDr4PPhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvTyRRafp87U4gBbE8OpOFUbPoF6z+1BO9WE9j5+tG0=;
 b=jR6xhiGMS8ooOaojSnPoe5eNdkpiz1udhbcvChXahk3GQccVN8hU9/U8izOM6rnpu8/2Vt7RcHpS67C+mzOwx1GcCDKzJuAXLRniE9ue43mTwaSz6qh/0NutDi0E0khYd/OEvhw7h7StoZp++8HUNCckcczwS9Sm0zCBqBJEiVOzld6Wy0+uhG6ehzDc9q1zsLEZYLz0pkLsRR34kkRN/PedaFsiR4m6p+9sXpjKcD4rDul7rQE67TdzqUfmHjwTXGTmO10fga8f9yxdMneMaEBowHsqMi9qy1biFGXoinO90d+5z93swognpksFtlqmIq0FgFAaxuByPqwAnnDVqg==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4653.namprd12.prod.outlook.com (2603:10b6:208:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 1 Apr
 2022 14:29:08 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::2830:9ce8:f579:927b]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::2830:9ce8:f579:927b%8]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 14:29:07 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: jh/p4-various-fixups (was: What's cooking in git.git (Mar 2022,
 #07; Wed, 30))
Thread-Topic: jh/p4-various-fixups (was: What's cooking in git.git (Mar 2022,
 #07; Wed, 30))
Thread-Index: AQHYROP1gT0GdaPVB0S6JXUW6eEUnazbH5NA
Date:   Fri, 1 Apr 2022 14:29:07 +0000
Message-ID: <BL0PR12MB4849859E5291E8204E87BA9AC8E09@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <xmqqee2i50h9.fsf@gitster.g>
 <220331.86czi2sbg4.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86czi2sbg4.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 183f6bc7-6af6-44bd-5bbb-08da13ebfb3e
x-ms-traffictypediagnostic: MN2PR12MB4653:EE_
x-microsoft-antispam-prvs: <MN2PR12MB46534873436D2358E842312FC8E09@MN2PR12MB4653.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PsT8A4WWxGnBCIkiff/wilELLDR0gtT+/LOQ2+DW2peHaxzh0TwmXotUNBRvJ999CVusZJTBNsLnlB761h1gRr7rwqaie1rR5+VVpgKDoRJOVhHAY/4yLbKHrXQwtOlA6g6r3L7epXXlHLE3P/uDdwWbq1FYsMfN8ciFyCf2rWydCts1l9viSiMPgXLSZB2QN+1tOu3oUNpcsuJF+XUxJjAEIUXYgfu8BZkzQBZSkw1IP6oWUBs/2s2uKHHKUjfFnUY+qHnNDMDNsWJX8rCwWUQOuMmzdhVZAkSfF538EXq958RxDrYBwk9MbCqaiKraQgFErApUeI2vVMqMgjyDEQXF0Ulo+5ir9NGFTM98nsmytyWABlx3Amlwfdbxhl7IDJ0nrh1bAzRCh6S1y9cSLZ+gKqOANg8onUG3nWavTpEQfyN/ttyE8n+VrEaTeUbMazTK3vtZTV9zY4a3aWkbEloc/RFilDfBwumRv5rvosxk4uI8poM/GuPFFXOhOhY42YnEYxoqV/ql5Bl6zBYgQROifoW5lsoMGjtvn/GxPp5dNR3sY+QD7YwqNXD48cIHFeLqaEMKKmCve420zbg/+tj/GT4h6izAMaVW8HsQD8lZDrx0zSMmTSdxiS4FiH8ImAeUsH2SVHdTWWnal3PJi3whnypBD1UWWAsOND3GWsAAM9BfP/lBqjAGeCyNPKj/r9THbVuYl+Tstk7UjT76lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(122000001)(186003)(110136005)(26005)(38100700002)(9686003)(66556008)(316002)(55016003)(55236004)(86362001)(76116006)(6506007)(7696005)(2906002)(33656002)(558084003)(5660300002)(38070700005)(4326008)(66946007)(508600001)(8676002)(64756008)(8936002)(66446008)(52536014)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pJP3nXfF2znCSv0Xo3icBoJlKUc+ElpG+qBeLbAvILgAOUIo9DLxr0REJ9?=
 =?iso-8859-1?Q?ZMLIG246cNgZajMpYL9V+LBQF7cadZLug3CPMFe4mnPjet3AyDfrU2EOWS?=
 =?iso-8859-1?Q?wtSUS5QOoHimBNb1iIdUp7xJMBupRnUci6Ua+sA1ewkpseKz2BPvW9/Jg4?=
 =?iso-8859-1?Q?5nQxPuliu2eJfZJ9Waqfwd53wn/80NsorC+vOg/koOzwKszvIUrcUYdewH?=
 =?iso-8859-1?Q?RfPVb+DLu168Ct7RKLqSE6T5+cKp/+/K7eYsZnsUNg23j4Efd251ePmxfO?=
 =?iso-8859-1?Q?XrjG6ICr2P9AMegF2tmiALunGfiDZU2UtW0nrT96WoshD+g+exMz+T177O?=
 =?iso-8859-1?Q?lIah0rNOvuYesrtt2YVsNL6gRRJE+D/f5pQIpc3alybKYk5XtPiH4+QeQl?=
 =?iso-8859-1?Q?UY9g/DtcgvdxKIL3xBg3EFxLwkvD0v5elsPVEhVs8jCXMjT5bwPCgXUkLm?=
 =?iso-8859-1?Q?GqzoAvpMqfDBUSDum6ReYCoJpf4jaRfbCRIWKi5LNqqux9ICHjWLlOPDKL?=
 =?iso-8859-1?Q?4/q3higTH1FLMCGyNcpWeosBMt0M7rikejxpqZxW898+27elAWGVfmP6/l?=
 =?iso-8859-1?Q?ql5y/gRzRUuqBpe1qaeXZ1aF4xEfwOD+1CTEaUYHox96yqW7wVjudIlklr?=
 =?iso-8859-1?Q?TTG/KGNvPUYWvIa0Ea/yNhM8yUPXNsZHC8R5WYZvh791OW3I5gWXQ63dYv?=
 =?iso-8859-1?Q?s4Z4FaGHbz4cg90LRJ2H6MhdBm4AVBaYDhqkL1I4KeOhmwaXlb0mC5iX6A?=
 =?iso-8859-1?Q?hiOkJiWe860/4wJ/5Bw1LwEVRY0GXO+yQJs5nquohf9/9X7KAVnjlj8kkP?=
 =?iso-8859-1?Q?uzBKAKZtZGXtkdaU6gBGy1MJNiWWae1h6PWCa2R3Wwxk+MWAtSbmKxIDUv?=
 =?iso-8859-1?Q?bHRxdfy4sQlitY9aQd6Os7owj6m248QZ8EBfXwvvmtLg7AcSLk6eSbZxD9?=
 =?iso-8859-1?Q?DLxnuBZlc0UCQwJfwgRIGz8zokLY7ZfiF6OO6cOR8G0EeLn6dQxhFh9+G9?=
 =?iso-8859-1?Q?/5NVWRIrvEDJsBHv2OYD/eWlubDGTgpvds4PY5NnpFfSR6QwnL1O17sWvZ?=
 =?iso-8859-1?Q?sLpfppqH69QUkXBUHqxt4ZSF6nN7oJLLgIYHfkoZQ+r1pI8Tr7tTh/VeFN?=
 =?iso-8859-1?Q?hmBmhniqenxjH0dVp+WdJOZvivRHSYK0eVp8GYfv9ImBoeVuAGcZUDxwif?=
 =?iso-8859-1?Q?kSVh4+mQa8Gt/DItht78kmYs0kPKwqrUEZ/Y4M2L4oY5nTuOqW7NdC7zTD?=
 =?iso-8859-1?Q?T2ctbSvUgKvw5ziTI1Z9icRPPz+0v8R30JWCcyOFSr/4IvxcYoqm7zxsCn?=
 =?iso-8859-1?Q?q+6xXln7T81dwjEUy6x3QRLwKhOfw1TEkYYKarjkHK9frunWMMB/5BGZA+?=
 =?iso-8859-1?Q?BdlTk3bVXU0Pp0+T0ugMAWQ65XteFU5dYNPhYXJxpMesfjT8cl091GQtWv?=
 =?iso-8859-1?Q?/1BMQE4YZbKzq3nlqBByEGIXzWKs6+f09YDA6aGJkPBGGCqoGt4OrhzKRR?=
 =?iso-8859-1?Q?pNNWbRp4mWNQbHYpklCsYqhlQfZvNYB9zQfDpJtXHBFesRcV5mJkLkX/1P?=
 =?iso-8859-1?Q?cj3bR5m5Xwy8NkcKkTAINyxCYvncVZ2BigfU490NrgUEPh8BynotfO1GJj?=
 =?iso-8859-1?Q?9wujD6RRRM4YkZm6+9aQixA9GJTaONoM+ArUct6NN3riQaBYKAftJ5/zSW?=
 =?iso-8859-1?Q?ALrY8fFgHfLKGJJ4yN72Or8CiCPg91WOeSmKQ/pd5Cddy8yxik8J05HDKf?=
 =?iso-8859-1?Q?wS3hmlI9Q19es4TUqh0G7ykjoOcC+M+RVueEIjEgXYEsCAiO2wvYLz9QVI?=
 =?iso-8859-1?Q?2EtlqwZp5Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f6bc7-6af6-44bd-5bbb-08da13ebfb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 14:29:07.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5SMIlc2fDbiwXAHR5U6Sb9i88VMUFcHGWj+3035NttSVrmMu0JhHryryDLwAdStLtHruW0UrvgUw6ANkByxIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4653
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The tip here lacks a Signed-Off-By, but this otherwise looks good to me.

Thanks for the comments =C6var - I've just resubmitted with the missing Sig=
ned-off-by tag added.
