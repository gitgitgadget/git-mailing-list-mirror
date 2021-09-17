Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A26C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0BA60555
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbhIQQ1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:27:37 -0400
Received: from mail-co1nam11on2113.outbound.protection.outlook.com ([40.107.220.113]:33889
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229925AbhIQQ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFExTmxKAgqv0TI5id6qDc7a6USaGQQVk/qtABTyf5etP6mOSCx6VaDi3J59oQ1+8A0xqoe2HYtkD/USTkutNzCJNVvvSzTcbk2QWpPMnTKmFCna1eX74DMr1iT0wdfnFCzxxdM/T3rYOwGu3Fh2m+aHZ5NG6jj0obkFbIe8V41bsX7lwRcjCVRPkKqjS9WhPuZ9F80Sf9chqaHK7OWZSC3zZ81KBuD/7cYH5Y3b+KFV2gPvPkQ3hWiwgs8S2GsOTbTZzduSHctpNdxHjXr+AzwkRNM8HRE0HJJ3GC9Arqajl6+Dd37FTR4bOXaOxSVoCQSmLmrGCfvn+bqzPIbv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AuIDSOSjI/QHCkVaMXQLDH1GxRWcfa61qpmqnaf8DK0=;
 b=itGao3ov/92lZUFwFhwtdLjdrloPHPQUWlkn0YzrRPunN8PuOb/AXImijYf2IzZ2vW4XhV6pmvCDhfpgRX7c+TxedoZlp8I/0vyKZIfMqIVk5WvbNRjZms/Wk2weOtuYBMuPV2cCVrZbDCyyCXB4MhRiwDwIsHVhkKw6RBjclNUftrcP1JhEltGdq0WcehZXycguKFTysRtxYioBv5tBKMgJrEDBkavEUYUNFIu+0iJXBJPseSffzLP+CQvQxwXMwTO88xBgQKpfETo5fQcT4mPIiHnlmp2sjnZ6sMldkm2zJzHIRXtrKwknU3YBYqI3Q+vQedqFtR5Tdw13JSqpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spideroak-inc.com; dmarc=pass action=none
 header.from=spideroak-inc.com; dkim=pass header.d=spideroak-inc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spideroak.onmicrosoft.com; s=selector2-spideroak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuIDSOSjI/QHCkVaMXQLDH1GxRWcfa61qpmqnaf8DK0=;
 b=aJeGOiRSFqHR+XrnI8QpPqSJXUXAKJfKSc95mCd+C3+dnB/mYKz+jm/FJKJhvXFDPVrAL/bQwvzOjKZAtgq4Lp+ncpj88WRr3ntKTZVhyKi5wWMIyRGTAY8cliLwHEelbkoBiX7cOmjVR1PoOYqefhebQOJ26+4VOg/DkBfXLpA=
Received: from SA1PR17MB4610.namprd17.prod.outlook.com (2603:10b6:806:195::13)
 by SA1PR17MB4724.namprd17.prod.outlook.com (2603:10b6:806:19b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 16:26:11 +0000
Received: from SA1PR17MB4610.namprd17.prod.outlook.com
 ([fe80::14bc:3528:b59e:1433]) by SA1PR17MB4610.namprd17.prod.outlook.com
 ([fe80::14bc:3528:b59e:1433%8]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 16:26:11 +0000
From:   Geoffrey Knopf <gknopf@spideroak-inc.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXT] Re: Feature Request: Submodule Warning When Cloning Repos
Thread-Topic: [EXT] Re: Feature Request: Submodule Warning When Cloning Repos
Thread-Index: AQHXqxsv1imrcd7+P0OTcC7c31iEGaunsgUAgAC4cFc=
Date:   Fri, 17 Sep 2021 16:26:11 +0000
Message-ID: <SA1PR17MB4610F6F2BA6BC9D220EC5C4B9BDD9@SA1PR17MB4610.namprd17.prod.outlook.com>
References: <SA1PR17MB46101CC190E4CDDD00F2AD2C9BDC9@SA1PR17MB4610.namprd17.prod.outlook.com>
 <3ff1426a-73a4-731e-3b6f-269d9a900019@gmail.com>
In-Reply-To: <3ff1426a-73a4-731e-3b6f-269d9a900019@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3f51bc02-08f2-2f1a-5974-f367fccf94b7
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=spideroak-inc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5013d6-2584-4d05-90a7-08d979f7dc63
x-ms-traffictypediagnostic: SA1PR17MB4724:
x-microsoft-antispam-prvs: <SA1PR17MB47244147F98E4819E402521E9BDD9@SA1PR17MB4724.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MK7KiR2nOQhwTqOLcoThX7okoKwvawp1lA1CuhH8+yndGpEe+yPdXQkmpeJF9cnln1iBueAJ6ShkvCCoGmixDKsqLUNN8wNaKEcff+sSKNyuSw92NR8r04Y66g+MwRVciauz5PuvdrBqM+WkxGQfB1KShvjSRdr8ZqUM85YQNzuCgeiifJDeNy8yr1KMW4A3FZp+wdsA0IWbEICclzShCZBwQ6cNrvNYHqvKk/IZfCKDkQD/IvsIUn0t92oqgse4jO5S3yjRuJJj3LybLGbX9qJl3zWgfF+knBfbrf/I2yyw6V3rN5CVxTQ5I02YBx7BfcRgOBvq5f7Yf2lEjS+L/J5BGEWJLK/TMv9UtzCOX1BCaKUTAwYAFtdOIjEDfumYDq1qlGXWx3O7jxmuCayheV7t6BrbhATkYuFUvwdJuJx29zLfmx2YrGKI8C5q3q55epeF8xEhwvqrly56fTyGUyY9VMQ/4fFQZFjTQFMw8XdZfR7tlq9wTN/U+1eL5Lfu9YqlDscdFgHcj3GIq9h0NGbVOL80NpQlihk+Hca2f5GqkfctRaUYqJPyNz/fS4qPnLfShXPAtepY9FmPBCy1RGqFkIgh8dILEVsbB37HGlwbEEB8YyG9CJqizIT/G8J9OoGMmnDu0/kuM+ijS2gp1bzG+HI3WE6gjjOQ6bHKTPtn9GlIax+Yo0n5d6dWK3io3jbf0UjdaEBnGBDTv3xbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB4610.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(83380400001)(122000001)(66946007)(66446008)(71200400001)(64756008)(110136005)(5660300002)(86362001)(2906002)(7696005)(8936002)(316002)(8676002)(52536014)(186003)(33656002)(38070700005)(9686003)(66556008)(55016002)(76116006)(66476007)(6506007)(478600001)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jFmXXyGqDKK7VhnITCxLqSVAXdxA1jehmyR6Bbe9vqu/1WneK0Vrs7o8bh?=
 =?iso-8859-1?Q?2HpEY7/dImP2THbHispxWpCyyRBWls/eqrRHJ/y22woXX+9uGPbuHst83n?=
 =?iso-8859-1?Q?ihTCyqfGCjeR0MOhuSFc/ZUH25gda90Va1qL6MOulAukhJREj4/MKl3rIp?=
 =?iso-8859-1?Q?5t1/Nmaj3/d9OI6Y9i6lM/glJF4nViVb2R6jL6a/JUjtijS/yZTN5HVHm0?=
 =?iso-8859-1?Q?W8NQTd675hyVR+carh7vQn2MjpHGnln0MYwCTrsB3jh+IagxqAfar/k/tW?=
 =?iso-8859-1?Q?J3F7e6J29Nn7IazlU93jOt+bYR4zmhC7E0JPFXG9g8FaFO9wZ79fibZqWr?=
 =?iso-8859-1?Q?LHhziASFzNjIjtJ7SIN5Az+V8gYD1ruyNVpUtx2mklsiP4BNbZlp934Vj3?=
 =?iso-8859-1?Q?FGtWeG2iOPdqFKqF8URxNcuV2MnS2XkYQCnKQ7grVYS/dXB8lwbvuV9gg8?=
 =?iso-8859-1?Q?3S2iSmeApBz9w38j0/0QBr0YHixDmNgEcFavnCjd/suPpUknEMdFWAJ5WZ?=
 =?iso-8859-1?Q?sEXs6IFQdJJPx66lc9npCXn+Bl/S2u0MJ/7ZSY0qQ/8TgEPnl8/x0Jf8eF?=
 =?iso-8859-1?Q?xIDMHew11b5CK17MIPN7+c93yP0SuoFVVCO1pFTWUdf9VyXdPzNr/8gmda?=
 =?iso-8859-1?Q?mSdccy0H3NRT93O3PJTEctpWQyYG9iybUrCerguSpp9+wwVjQiMEhLYd67?=
 =?iso-8859-1?Q?kogUihEuEL8BTTegcIxXwzrSnesvKF9pwpU2oQs5mIkzwjAsp+Ur2v0Ngz?=
 =?iso-8859-1?Q?NbYoFQTeFYj03HsPeoqistjN00hgsnIYy82Rbi6/oyCfpgEY/pAdqf0lOv?=
 =?iso-8859-1?Q?1McWaZr1DhCGSvIdimlgLIpUdfITzMvdJZqDLrOKql3pnAoeptBTzx04iF?=
 =?iso-8859-1?Q?Ux9l7Fd7hdcuNmByYTsSVBde1n+RJgE/WAAGjI1tPu536RZ5Bj60ijcWMf?=
 =?iso-8859-1?Q?JMgYY1Du3b0+yVC1dzY7D98VrolqAmwX2OFPo4WIAeBSS6EMOnr24ESzGM?=
 =?iso-8859-1?Q?Yr3QBD5mrTcRMFiJcCm3n2ai58ibHxywjYAOvqeY0MumQEzX84Rn139pzp?=
 =?iso-8859-1?Q?qWgk6CI6N+iIluO44jOWSlFw075b/Qki6UIrcbmjVc44pdQRHfsafMz7K9?=
 =?iso-8859-1?Q?bafh+GhR6+HOT3DOCkEwsyCGNCq0v/i1vtLQLwA6jBvji8I4bWQyzTPJ18?=
 =?iso-8859-1?Q?NH3qLRnyry2Xsdmc5o7yMLoI9JkYBGFAljh19Egr5mv2zJJd7FsrDJeGrt?=
 =?iso-8859-1?Q?yVgKGWUAHHszvcmzywVDCcIulrfkWd6Z0ifHs5ynasF/DBE4CRi4JMqiYe?=
 =?iso-8859-1?Q?ndcnMR0co7529mFtJBEvaM/3mvglo3xNWL5QVeXt8OP2KK0JDE/2Qvg4E0?=
 =?iso-8859-1?Q?9RvRLkjoRn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: spideroak-inc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR17MB4610.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5013d6-2584-4d05-90a7-08d979f7dc63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 16:26:11.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8920c0f-48a7-4213-900c-6b853968daef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deMirx8snP0ngesh0m8X7I6+tW3mSa4ydJ3D56ICvfyQG0RLFU4rjX6krHjAX9glFQO4U/1Y4Fj1T7SwM8qJ8Tz0jx47K5n2DPm1EVgxVbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4724
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah could be a note. Thinking it could be printed to stdout when cloning.=
=0A=
I don't think there should be a prompt because that would interfere with au=
tomated cloning which needs to continue working.=0A=
=0A=
Something like this:=0A=
"Note: This repo contains submodules which were not cloned:=0A=
-=A0Submodule A=0A=
-=A0Submodule B=0A=
Try the '--recurse-submodules' option next time to clone them automatically=
.=0A=
Or run 'git submodule init && git submodule update' to clone them now."=0A=
=0A=
It doesn't need to print out every time a repo with submodules is cloned.=
=0A=
Only when a repo with submodules is cloned and the "--recurse-submodules" o=
ption was not used.=0A=
In other words, if there are submodules which have not been cloned/initiali=
zed/updated.=0A=
=0A=
Backstory:=0A=
I've encountered a few situations where developers cloned a repo that they =
didn't know contained submodules.=0A=
Sometimes it was their first time encountering a repo with submodules so th=
ey didn't know to be on the lookout for that.=0A=
They tried to build per README instructions and it failed.=0A=
Then someone that knew there were submodules had to inform them to run 'git=
 submodule init && git submodule update'.=0A=
To cover all bases, the submodules and git commands for cloning them had to=
 be documented in the README.=0A=
This adds overhead to the READMEs of all projects containing submodules or =
causes development time to be lost.=0A=
I believe that if git printed the note mentioned above it would make clonin=
g repos with submodules more intuitive and user-friendly.=0A=
=0A=
=0A=
From: Bagas Sanjaya <bagasdotme@gmail.com>=0A=
Sent: Thursday, September 16, 2021 10:23 PM=0A=
To: Geoffrey Knopf <gknopf@spideroak-inc.com>; git@vger.kernel.org <git@vge=
r.kernel.org>=0A=
Subject: [EXT] Re: Feature Request: Submodule Warning When Cloning Repos =
=0A=
=A0=0A=
On 16/09/21 23.59, Geoffrey Knopf wrote:=0A=
> Problem:=0A=
> Easy to forget to clone submodules.=0A=
> =0A=
> Existing Solutions:=0A=
> Always clone repos that have submodules with the "--recurse-submodules" o=
ption.=0A=
> Manually look inside the git ".submodules" file to see if there are any s=
ubmodules and initialize and update them.=0A=
> =0A=
> Request:=0A=
> When performing a clone, warn the user if there are any submodules that h=
ave not been cloned.=0A=
> Recommend that the user try the "--recurse-submodules" option next time o=
r initialize and update the submodules.=0A=
> =0A=
=0A=
I don't think warning should be granted in this case. Maybe better as note?=
=0A=
=0A=
=A0From what you wrote above, did you mean print the message when cloning =
=0A=
any repo with submodules?=0A=
=0A=
-- =0A=
An old man doll... just what I always wanted! - Clara=
