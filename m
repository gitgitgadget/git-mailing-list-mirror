Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE994C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 14:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjAQO3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjAQO2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 09:28:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F343F286
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 06:27:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fftid+oHVhWGKTOtGp07k6/POq29jY6G9i58nVmJ+54Stjq7Vw/Yv4BS7Gv2SLo5CSDUF/G2GNlJZX9A04r1DdslMOnz3+kHJCtxM/vpdrwd6SSu7uavEpknfR7BgUaBqicyBAlU8R3QLpuuR/6vmcJAhv3O4VvC4v3LmhkQIYkTO6NVKn3ifJTdGBG+7E64CTjoijGcBFyAusUW+nUJTaar+C45LznGhL1z4aAFXsq9bX4lU/nslHSjxd0TlSHhK7BElxZwxx0IZe1MSDT8GbrQy18SiCh0Ihu2UroxpkGV9HymPYKVrgnK5s2ISdcB0Y99+0Yi0JHd0qIsAl39/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U6GJwamggOd3+Ytbi1s+HuNzcHqgZRKVJTdAdgPW8I=;
 b=Fe3+ux82B5DIXQdWCUr6tQ+Gm2ggydOg5M+5SiNdSqWlXexB2/6HEShpxZk05f3bKoc33ATFC6SaHbhB7eVH1l+IwvaHO1Y5xcJeniW7AouvhfRkFJHdSxD+DoOOLvDn865ZAZ6g5Hv2G3ApLvTOx42KsKfb3J2Nx853eCCQ2/Hzqk00X6TT9BljQ768r8jZ1ViLqnnxmZV8Fi5ENR5hs5wYmJtc1OS+LSb76b+5LboC2wwOVJ5i3RaheSAbD3Js3UygmLHgPUui9up50yccFk/LNKHbvkLC1VPpaOhODc46v7Py59v+KnQkLh5otCOJZlI9zO/qXb7VrSWJZz1XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U6GJwamggOd3+Ytbi1s+HuNzcHqgZRKVJTdAdgPW8I=;
 b=LFXrOiHWgmSE+ddpiBqVLxeehtCeleQqA+G+4Iw4N3mpTlXXkbDbSnH4HxWgGNbEzIxA6vHXA+4T1lMWC/rv5QXwzR12vvp6PQVs/nz2Pwj65OptJIdQGHlX/D8fbJ87mn60dndvnJ67iK25a4pFhFvTuRk6NUFiPcuSRYCFR5o=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 14:27:13 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 14:27:13 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v7 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v7 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKn/K1qMF6DbXwUGWgHYYDVSGVA==
Date:   Tue, 17 Jan 2023 14:27:13 +0000
Message-ID: <20230117142706.230404-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|MW4PR12MB7468:EE_
x-ms-office365-filtering-correlation-id: fc52673e-9dee-4e80-00b4-08daf896ed43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQVsDRmD0lKfG290Agtu+nOj60eqQQmTXPDMIvet1ZiXFGpaQ8YKyHmOgC8QOCKsGy5z3i/jWU+/47vFLSs4Hr9NWXRXxk2HjdKhhRQAe7EP4OkQl08sB53cj2OsmKlWiyqtqaJkcJ6BUy1Q/aQ2GiCd8e0KWT5TOR5dMTQYVhElj5zgfIinUV1tWwHDv07xqvK9FMJOKGkXLnZJliFb0iVxh8/dn+fQs6spptMuucqsdshtFIsakK1hOcqWyu97mpE4Euf1VS3Z2sTpaWueCNPdIdWWc3rR4Npypn9dL4x7g0xIeZdMFeFoExaL2XSx6nH49x3lK+AZ0O5WYzmokFT2vLrsZ63aPbb/41Uypl3x+zYoP6+mOcWCwPQ9RxQZ7wNENIY3trkAFUc0w8XdgBrcRsOM3UnVohtOLrCKZGA/89GLT9gV284GfgOjiFoXDUBYnDuDdkAKWcZNbPUYiWQZZQvzY0BUV9P41HEhqX8EIP/JnVFW1FYHAn/d8P/TOM65x8eU7cqVElCmwqAbTJqXVEfwwcQeyUyyT10mQY2hwwlbm8PrTi1bG/olP67dEFy1fLFBm6UmXJ4twaeMcZcf9WU3xh4NEjHgDBHX8TrfRtSEV/1Y7SuUJluP+9cG3YNribMpg4ToMIXd7nO3pq6ys3iMfJZFCSlzHAYPgJwyYv5RBUAXwzFWS9kWnY5ZgSN1zF8IbS4lldpI6edVeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(91956017)(64756008)(66476007)(66946007)(4326008)(6916009)(8676002)(66446008)(4744005)(76116006)(86362001)(83380400001)(316002)(71200400001)(6486002)(41300700001)(15650500001)(36756003)(8936002)(5660300002)(2906002)(1076003)(66556008)(6506007)(38100700002)(122000001)(38070700005)(2616005)(26005)(478600001)(6512007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p9NGyzn8CPjTw0spn51vE0ue5UKd6JpFSDq6YmhqznTWMgiKzqBjjLFQgP?=
 =?iso-8859-1?Q?cvgG81xn+QYwFQa9kuvKUrWNJmYCEW54o7sFKnnzceT1w/5XphbanFCUTz?=
 =?iso-8859-1?Q?TUICmCjQWFMVN2nr35ncnYADfMNYhdSD1l55RphkZ67ygRKBo/f/2UfcM2?=
 =?iso-8859-1?Q?JcEbML7iCwqn8tRmp8KLCDKQpkLqsw51nceQ/66gDjlwhj6THH/1VIWH6C?=
 =?iso-8859-1?Q?HOU6e5UFYfg8GZk8sAb/ImJOouPAPvGJUuIAlSO0ayDyyzqmrTbrYoQAXu?=
 =?iso-8859-1?Q?AupjRrfpyufyCSGFT5RnlCNMhtbDfIYEVy6qwNR1SzY7Ng2aNmvbthjyyF?=
 =?iso-8859-1?Q?KUiQKX929BL3+bvEUQQyIskhVt4iTsmbFEkjeJFtWrCr/Qm4BxerSO0Z31?=
 =?iso-8859-1?Q?ES/qpvI6xNC2cLZGvzu5w+nVTzy696EM4/U4gycPGlw0AErs5xET8rDdep?=
 =?iso-8859-1?Q?k/+hLjgG6WZh8wjDLxzIYlH2VGOXbvTviqISRDUgOcjDxw1y1JdOPH45Go?=
 =?iso-8859-1?Q?PaYZNY80FrWivK6Dagl35Y64fdmVPr9+LNHyKtyfZOKQjHSclQ8x3M3pTC?=
 =?iso-8859-1?Q?dsXGrB7E/jwncUTFZu88KpCmFYhWRwWaoO9+zKAjZFhNveyiMNAv62BIre?=
 =?iso-8859-1?Q?K+tGDKGa9858b4uSQ+z8JePqQoDfPn06j71XEboZnoC5yeJwMVzn6V/NpI?=
 =?iso-8859-1?Q?/nBR83BBuFX+ZovLO8sXAuoD8HXxI5CHN8EZnsHMXajquxXUgs+G6xOoBm?=
 =?iso-8859-1?Q?QpNydzRb3XuIDM3/lfPX370p9THiXn84Lb94q6R40b9NwldPBvuty77euM?=
 =?iso-8859-1?Q?Joy0ktVNhbmy6mWlJ5zIorVLRloNUlhKr4Gog2uBfV31qcKdrxyUFV5oXo?=
 =?iso-8859-1?Q?iYKW7RVTYo2EApN/lLsLoIa5nkDBO/EtGeaatjyWXq6Kb64m+0sLPq6d6k?=
 =?iso-8859-1?Q?oYeZay9KGzGFVAiRJAAmVKRtP2ZHT8+EOffUoBR+4g0YbppgLxujbDVKNM?=
 =?iso-8859-1?Q?hrZuA3lNO6gYEoTohfB6267/9Jhcwwf6hf9FPvwU0uSYjRw76NmYToGOlr?=
 =?iso-8859-1?Q?ni/Wg3erk7OLmy8pan84HtsHjxsyLcChgLkGYEy6w8LFSbuImECdQswzCs?=
 =?iso-8859-1?Q?ApGMQnQMp9sCgBrTqdhhwHBX54kQwhs0zF8fXJcun83FWUek14+6VuRnsb?=
 =?iso-8859-1?Q?hYeuNbabWeHMyJE8gQ6jKHqMVXHpweVbDQxbzKle2erBhclu94l9UjU/Ed?=
 =?iso-8859-1?Q?vhZaTA2qOftQVfmYelmbFBIrBHnhf+nFIAOdcA1893Hyqfvk9OGL2s5UC4?=
 =?iso-8859-1?Q?n1nhE1KnEYRW8zyBKAtesqN5NRJvSaYI72w1O65+CglViTay+hLHI8K04I?=
 =?iso-8859-1?Q?hzPINAOLvnbuPNiiOUE0c19k+7qB/xKczOFw0N6qp/oc6rrcRTGsMimhsu?=
 =?iso-8859-1?Q?M6RhY0QQ8kubKnl81nmQiA2G0wugqf5DXt2tTPmQwnzO7tz1uvWKYj8dmU?=
 =?iso-8859-1?Q?UrbFIiUS5yHzJ+LsVjsT/af+qGmCORebWMm2ln1WamZOcWj9shzHHu8+hg?=
 =?iso-8859-1?Q?nsYSpZRJIboRDcD8Z/rlGHUk0oyXMgj809VStnjQHSVwDL/PKFWtLA8jbq?=
 =?iso-8859-1?Q?s+f8vY7vrcm2scL+Z5Jj3VlufHMZ2vMN3F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52673e-9dee-4e80-00b4-08daf896ed43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 14:27:13.5408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fq+eer4lwunefYBaBhxhT4g+Wwh/pS8TjIRQjVbfVj2lACYMTZyH3U4AVZfq6XdHZHfibantWqpz1nGt8vGkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you both for the input on v6.  I believe that I have incorporated
all of your feedback.  I decided to keep a few examples of headers in
the documentation as I believe if I were someone wanting to write a hook
I would find the example helpful.  It points out unobvious things like
Cc being capitalized as it is and also how multiple lines work.

Michael Strawbridge (2):
  send-email: refactor header generation functions
  send-email: expose header information to git-send-email's
    sendemail-validate hook

 Documentation/githooks.txt | 28 +++++++++++--
 git-send-email.perl        | 80 +++++++++++++++++++++++++-------------
 t/t9001-send-email.sh      | 39 ++++++++++++++++++-
 3 files changed, 113 insertions(+), 34 deletions(-)

--=20
2.34.1
