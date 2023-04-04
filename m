Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BEBC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 12:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjDDMA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 08:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjDDMAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 08:00:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B834E56
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 05:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUn5iSjnS4R22Oqr3nh6cKEhpwowARbM8AG/I45AkJffAiJid99TKJU0syx1URtpUtpPhLbaA8gZG/iqSPySv7Z1h5OQCQpw18ww0VtUq8+ga42T/MIUBLqHmqRobM4w83hEg2533H5Qvz8+YtYalc7KB7yjkA1fA12aQDxLyfHjiFL9p7omHNWgMIXVmL6KLi3EDpwtU9QXmKzX3vufR6eBvr+XBhIFh18gA5AX1ZNXLoonb0dtgsLJrRhtFvKYyHpBZKNoele13n73VNAwmv7Xo4L2Z/D/BLX80NmGWVhIPPVDttUBS4xKKHoU0e1rfpjeRqDd12QSVq5U3xgXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPIqD1kzYJ+BAlPJE9zGxV8KIS37oxCHGuqUsj91eI8=;
 b=cTCSkjNaXHVrfGqVd/KKACdi333rZj4TiRVqVvR8GeX9UYShXhxMGLvkYnrBUDxiqwUib2nwrdX1R7F3nv8/poTXQ40EHZReEE+X4mjCb43ekO20e852BQ3lAF+kaOlehROwLvKRRVS/6260NK0ixfuB1PRooui7cXqNWasRrCZed85aix28wkBhJN8BBlYoqVdOaKBzjYTNIycwxBC1VKMgwQTlt8wCGVoWqXf2IG0V0kcNJNaHR9NkUwB0IEwXhS/rjMV8QklA9lwyGO/+/V8KYIv4TXjTwSvMo/vC9dv/fogJg135C+6+5Qsneolo1Pb495ndeg0iknLhRS/aKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPIqD1kzYJ+BAlPJE9zGxV8KIS37oxCHGuqUsj91eI8=;
 b=Cggkw6um4zF6FLvwrXDxYady3Z6osEA+28q2fIagZZ7Y7+MsCFCC3+df8gJM273QN24sdlwC0LTRJrVgnTApGoEl2hDJ5BHGiYt6fbzz9BOfUoCpGNgwT8zOCXwJtcgaON3Sz/Ng5ITAYEj4+SpQ156qgHzFWpEUYtACkz0TrS8NF1XnA9xrOjTPkgONrhSV7Hj52eiarBfII6O3L2ovmerqPr7SCl0R+neVqYIO57xYFFOuwL9jDiIi34O3Vxiy2Vhk+YYoykEIN8CYU22jnG3jZP+8/hwkOe8AkJRs0deVPfFk4GKBlb0J5AVx1iSkHzLHCbZIz+Eu2cv0vataQg==
Received: from GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:116::5)
 by VI1PR10MB3695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28; Tue, 4 Apr
 2023 12:00:18 +0000
Received: from GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d989:6959:ae70:ff84]) by GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d989:6959:ae70:ff84%5]) with mapi id 15.20.6277.022; Tue, 4 Apr 2023
 12:00:18 +0000
From:   "Brown, Chris" <chris.c.brown@siemens.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Negative patterns in cone mode
Thread-Topic: Negative patterns in cone mode
Thread-Index: Adlm7OeCRKFtiy/rRRGXi7zzMWcApg==
Date:   Tue, 4 Apr 2023 12:00:18 +0000
Message-ID: <GVXPR10MB8199D186532A7A285CCF1538B9939@GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d1178165-263f-477d-8cac-9191484c8599;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-04T11:59:04Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB8199:EE_|VI1PR10MB3695:EE_
x-ms-office365-filtering-correlation-id: 22b30d45-ea06-47a2-1414-08db35042915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJ4m2VnSNcK+Z0vG8X+6fT7pz1sb4RfRNJ3P6JiR+iXpd3SaNncO2HRelMxXrmQQsZQYbNMf+ZliqcF5yKxWdgp7VC+83YcBAp3QBYurx/WwVxSQvrU4DmY3AYUkBIOkCyEvkyO+XQq1C1Sqe6lF/wLTZ5EiznlVuFP3Q63kLPYF7SmMNmCKinRtPS0JTqUzTlILIDazz98keagu+f90+h6URoM6GQPbvt1NaHsYH99E5O1zFizZfJadaMjvMA0jXCW3vYudLQp9xFnaS+zandEBjlarmhg+HM8BnV3Nz6wWNEOi+ZSNhbvk7gAFcSlAZc0zbNZiObcUmV30aU89pHbKAOFuOZyLMUFEoYvak/KcuRM0KJdcJpK/a1V8U9Kv7HNRo8rb/bqE5QHdrjWNi7yPDXb4bwB2AWR4cjXbMa7Y6s60TyjNBn0Q1mz3NOQur9FyHBk1+oB/xfZFnJrxjG+RZcC+ULes7GyWLEoP0k4fldg+WkTgxqU5Ot13bGXZ0RuHTpmWr35LO5VoqvBHEbP66TSLotRaTT00WOrYELNbnQRmTqNRxz/FNg70fNsCRUDvNM+AmauVq806k0DHEQnNAp3cAGri+AAIcJfyMG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(66946007)(478600001)(316002)(5660300002)(52536014)(8936002)(38070700005)(33656002)(4744005)(2906002)(86362001)(55016003)(8676002)(6916009)(82960400001)(64756008)(76116006)(66556008)(66446008)(38100700002)(122000001)(41300700001)(6506007)(966005)(9686003)(83380400001)(26005)(66476007)(186003)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6QpINF6IQRlZHpOEE0nI0ZXZVm3JOtlUTtujoT9N8KpbfYPNHxfoP77fxg?=
 =?iso-8859-1?Q?5slKOBjhH725nvgNSouBERrFtKYn2h2X3hTqSvYBplWwexOS40KEXfjz1g?=
 =?iso-8859-1?Q?czoy1Is+NoEGqPTltt9y+Tzv6NlJ3Hf7RJ7xMC/ffFfnR97QS3OZplDMA9?=
 =?iso-8859-1?Q?9rQaYMBUPeTyObBpeBxazp8k3OmUUKz3FHmelkyMEWvEonD5wzBQIqVNIp?=
 =?iso-8859-1?Q?Ds3GHgRqonHP9jXQg8bFSYUfwCaMOoSCe/EtxI0YY9fmrj46rH0RPeyIH6?=
 =?iso-8859-1?Q?JPTvPMMczyOLJrH2IzervM6MqxJqxP/2vm9/pN0hFIMSnqusze6Ox2VSpZ?=
 =?iso-8859-1?Q?jYZneEnAoJ1fW7BpJ8Y5kDEZz6GspOBdgC3dreKJpujL9cofi1AeSAEtLD?=
 =?iso-8859-1?Q?6GeEPc1IKjKH6rRQRDYbP8VppWvVmZy1fK/zICN4BY3xKq8yTsuZAS4qwF?=
 =?iso-8859-1?Q?+e2IWyY7tM/kr8Whh0xznvV57x6Fzsr45e8JCSjl3WvlD2HT18Rs7khTBz?=
 =?iso-8859-1?Q?fC4JIsfGTI38lMz79fThtG6VHs+r6QOcfjIW9myyA7PGX+PSGEQQDbHzfE?=
 =?iso-8859-1?Q?Hc9ut4qzt+lMTYJ8IwLJgsLJ7t3HWnCx2YDxutAykvJ2+6DErcEVIOft5k?=
 =?iso-8859-1?Q?fTpYwmF/dO1hPqXKVGY6Xfxxm2Vld05jsEU/yNa+aiXoBLfd9o+N6aDVzN?=
 =?iso-8859-1?Q?YRpDntu4IS2tvlZtHd/OqcnrRLAVF3dq1PxeBMq0dMFsgc4TOEDIXRI+hn?=
 =?iso-8859-1?Q?V6np4/4yH85LSV9QxXXjR6EknnO/EU0z+7eFJQSOx47JcDbkLJ2kTCvA+g?=
 =?iso-8859-1?Q?Tu+KRWjwiyeQIzslYvb9rBtPq8N3c9+3eal/+UReGM63hpwLEFE8s+PV9Y?=
 =?iso-8859-1?Q?LAK/ZvvuwZYh43Euf6StLuV2zJiJSz+3FpMehZjZ6xcHxA352HDPH02Sda?=
 =?iso-8859-1?Q?qjuqJbZrGUWU56tiDN8NUnobf0q/lHq1fcR3d17+D9gso5J4QQp0B1PbtI?=
 =?iso-8859-1?Q?NMxfmQU7KWv9gcXp+bM7Nrzbmj1+dLbeMQR5o71eS4GvM/FI8z3EEMISF7?=
 =?iso-8859-1?Q?KFR/KO8OWcU8Jxco8E6ozerLUt9Bi2gWZ93Ne6DqOdIidORwzujujo/Izy?=
 =?iso-8859-1?Q?KlsFh9iCNZof1xi/EtYcBkYzUrylaXBqNO1lA51t9DWWQzAN4nVWteaUJC?=
 =?iso-8859-1?Q?LzlUKuAVBI01c+qre/sELhS1KqdomXHRWeytPpOFdEiMVDa0IW3ZVYfiap?=
 =?iso-8859-1?Q?hdvXRadgdXbcwt/K57GcLEXVgNXiNPCXGED/vjvhCKDsJX8FhrYIvtKx+8?=
 =?iso-8859-1?Q?/HQfyLkBjRQzdc14ouDtom7oGCFIt06eChiVc6frdKOLdTYRWlCbw9cz6N?=
 =?iso-8859-1?Q?uQC+yXS7LOAWKBJ14BPBqTmlB1DxzmUX/j2WhwbihqilDhRFQBarJK3oTG?=
 =?iso-8859-1?Q?byVOe0I96U6gwM0hn/m7etB5erdyZqHYSvZO+EkTJ+KmPCOCattOKCo6Kv?=
 =?iso-8859-1?Q?+POAPNigs4SUj9xrF+b4o5lE+R+AOcenkNVta2LMdVZjZRmk3sCs7TgGAv?=
 =?iso-8859-1?Q?GTBvlTY9TqOYGjF+/mwICumO+dCIjvJuWoXwIQEU8AbkF5Qlhia0d3Cuqs?=
 =?iso-8859-1?Q?sGeReX/p7Ziy+fJYnl3pxjAfzVicwseZl2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b30d45-ea06-47a2-1414-08db35042915
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 12:00:18.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzpN/Gk2Kpwi8RAsEQT9/Iwpv+17gnOEZehcqqKvznh2e3otLABh6BFPstz7kiO7e7h1LwU1EieW/QFrpsWU+oZER3zxmKod9mp5MLf4N9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3695
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm facing an issue with negative patterns in cone mode. I can't tell from =
the docs or git code if I misunderstand the usage, am trying something not =
supported, or if there is a bug.

What I want to do is exclude a small number of directories (and their subdi=
rectories) from a large repo, without explicitly declaring all the other di=
rectories that I wish to keep.

My directory structure is:
root
^----A
=A0=A0=A0=A0=A0=A0=A0 ^----B
=A0=A0=A0 =A0=A0=A0=A0^----C

My sparse-checkout file is:
/*
!/A/B/

I've set up an MRE:
1. git clone --sparse=A0https://github.com/peakschris/sparse.git
2. cd sparse
3. copy sparse-checkout.txt .git\info\sparse-checkout
4. git sparse-checkout reapply

Output:
git sparse-checkout reapply
warning: unrecognized negative pattern: '/A/B'
warning: disabling cone pattern matching
warning: unrecognized negative pattern: '/A/B'
warning: disabling cone pattern matching

Thanks! Chris


