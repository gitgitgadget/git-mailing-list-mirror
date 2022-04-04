Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD3C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378324AbiDDOu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378160AbiDDOty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 10:49:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4E433A1
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 07:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdoeVofllqq9dzhzGUgSyHEc6QIUtjxONjPL+dkwyBKgeyk7LQGiBAhYh/avxPq1PQC+PYDdSCCFc+rXii6ur//OCT9DbO749kJan/5E7wRLL3QltwKcIf951cPu+Fqo3jqGUiVeCYqF1CcbjDd9Ci3PZGBmqMU1nSE81taVaIVhYgVAl336cEF1kWmL6KNx+EBF1WWTGkA0EAbzyM2vkiGDVhaFyMw+CEI890TTLuwaV2XeRuPRke30oondigI0jDweL0z9Y3U02i+tp4P8Ruc8JLpP9giJgSvUWnsUEGF2gxhLGfWZAP56gqNS25c2WFNjaIIil8GM23uOfnmWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHLSYblx/j7CqgSgyiJowgj1lzGB7lOVXxpBmoezyxg=;
 b=bhMHEh5KA4rlZXfrPIJV39jv2KCBijnhU+zy0K6yvgBYbC5dWAPUwjIJY6VNbD+WjGketwJWH/9qE5cPSOt6s8J0b7t5PZVpNC40+LrcXAYeBzmxNp4swgOC1aSYbR0EKMJ1CxGqXJ9jyxDgdENFy/JT3s9Kk4YrCo/1DC1pWK5JbNroJnQ0XUL/xzUfqK7tUIr4e+LZ9/2TyO1hwL9YHkPZYBfFZKpx61Eg4cz7jWE6XLuc3A/Clrw+YLyoQlnJ5glJHwiWxIXgUq4+YiE16XC7dyF2rUD6IMwd8HDnHin4zNzMbXNKD59fEGXrQsxCMKsYW5pwCmVuveGtL9l0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHLSYblx/j7CqgSgyiJowgj1lzGB7lOVXxpBmoezyxg=;
 b=SWZ9sUdLlIgG+b3J0XXgPDTDNWGLb3UDIwIMAc3/g4t5Ygv78rI2IQ6nAmELDJ/f5uXhushJcIovFnnNLyvy+TMOpFAucIjuYLKs2rpFUqDyl5TSrbuWODjOyqOifcJzawJmRBH6/J6+21WDKBgZvVZNwPKWy7Tg4Jy0TjiWXOGmkkwJ07rXnU+/G36HqAoiQvu9bEN8z/jxZzuHcNui5fdOCKeUggI/DV0L+dL/MXsl3O5vvpxmBVG8UrIP8GUz8E9TI7ywNTKrHiO4qOFCs5KNk7gBjPOX/yqsf4Dag1Unb5ag7aLPA14M50k5rFVUP64NNDFWmUtLffnuSQUw2w==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3200.namprd12.prod.outlook.com (2603:10b6:208:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:46:08 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::94d:8b2b:ad19:a2d3]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::94d:8b2b:ad19:a2d3%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:46:08 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Tao Klerks <tao@klerks.biz>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH v4 00/22] git-p4: Various code tidy-ups
Thread-Topic: [PATCH v4 00/22] git-p4: Various code tidy-ups
Thread-Index: AQHYHp3NpnMnyJaeRU6TK2LFtcePFqzc2RwAgANLYLA=
Date:   Mon, 4 Apr 2022 14:46:08 +0000
Message-ID: <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
 <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
In-Reply-To: <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bbe2122-8ce3-471c-152b-08da1649dab9
x-ms-traffictypediagnostic: MN2PR12MB3200:EE_
x-microsoft-antispam-prvs: <MN2PR12MB32004A36989B6FA589BBEFBEC8E59@MN2PR12MB3200.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8PpkKvmJ4Wt6dCih5WZfP34MCdDvJrLGQZ6M8KLleBKsXlOSTugXKtXepljoAD/I0jBXNNM1ZFKoiHsg+TjOYM3pJ9t6NH7LDwJJCNzItlo6KHXFOAoPCX0SvVJ+1siF1pcLClzD1+lIiQXPjaJPscmPCoHbjkN5cw26/HDyvmCea3eQT86mU0cXXtEvz8+hNuGbX/i+fQP1uYWbbqXb8KGSYfStGu32OET8xCphIAIqEPeGpUq4WeQwYIS9GS5uzwZkxzFttXRw/hyLFfu3Ofdgoe9JcnSd91TPx7BnjL7loV0vAKYX5xngPzgTqO5K54arAWwWGWQBs1zqnme55qjf3UaO7zU9ccag+WyMClDcNbUutl5zUDmZ/we9p5fsdpGb6vf8yVzicAqWLXSS1+VkDQU8uO48Z7UT3DuGBXVDogP2d72ktvAdAXa39Bop4aFYh3aRo8X4eLr470852gItSUliixv32vbxuzsVLhyeseVAwF8C/fyaau0hZtl+1P3LQ0WVuuu6wWkUGX86GbFyTO35GmvhlQuwXmRcSEaIANfMsWtVdllpVMR5ScGPMOvw8RY6Bjx+8c2pA9yJ4UtpYm6CqJ/bbXRA5wsoTGHnO63SYAgTZOI6rcDxEu55YHCHD+F3zDCD2xPUbe8BR4PC7kGqtNNaANIdn6g6T3y4evALkoqUoImaqFEYnJ/yKiaXCPUB0AClO7R1xcw1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38070700005)(8676002)(9686003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(83380400001)(86362001)(4326008)(52536014)(55236004)(8936002)(7696005)(6506007)(7416002)(5660300002)(54906003)(26005)(186003)(122000001)(38100700002)(71200400001)(2906002)(33656002)(55016003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+Cg8EuprVOTEyUTzWO4wqLBqzGUBDr6T3I9V7oI5QaJxPZY3cFV/jEZzbW+?=
 =?us-ascii?Q?DZiaBBzhbaDTzWyh5XJT00O30K1VZEaR+WSfebLGPr+tVa/RGe28t/cPnrwp?=
 =?us-ascii?Q?x9vIf/GK8cZ52ZhmqBcSJH260KE2B793uBN4nMFGpTJxT9CMwX+WDUjAT+jU?=
 =?us-ascii?Q?T2kxiv5wUYpY+pVK+30/8L230ZCPP3CN/PTX88EbyXTXiolCTWV7gr1uqkzT?=
 =?us-ascii?Q?CB6vItPAHDN3/qIUXwKMp9T+pEmzC65u2kiQEesV7X83Kc0EzTqvPkl8MwS8?=
 =?us-ascii?Q?zEjiBTNC9ZxErvpVUrbDdFlZemUSMinXP3NW+fLZkhWq811PtzgbNSHv/e1i?=
 =?us-ascii?Q?NIhXQNVll47dmOD3vV2sYg5sE2HFSpBfZOT0q3kORbeJ83WbtqTW8U0elJjB?=
 =?us-ascii?Q?vpBLEqlfoTguG4/eF9owROGUbpM11ukEVPvOPnxMeuWpTD4H3aoR/LHlZ3hU?=
 =?us-ascii?Q?phutznL5Dwglkgu2oMbpQT75PfYY+1MH88jmSISjWUahzjKafAMJYXt0e7AQ?=
 =?us-ascii?Q?5irGbBZyD5wtF6xuOOg9hQfLvhoyHJg/unqYQV7dmKygfgHGEdmLtWTCbpag?=
 =?us-ascii?Q?s9wPxs/oMCL0AXL5YM6fmnT1W/BS4uk0Haa0loN0O7gf3cTWPAhFPhdqZi6t?=
 =?us-ascii?Q?k4FjbvSQqruZW+YNoFmieuh6ThRrEyAfWnwV2gzZMY2uKyiV4hZVEvBfFv/J?=
 =?us-ascii?Q?9rk3xFNY70Du+MT0YknELgfGMKcCl23mwS9kn9COaiUm05Zw+cXjhC0ZKXK0?=
 =?us-ascii?Q?XZOpFLY/clDxNOSiouH2xt9e3T/+8Nx+2yLWXF1BJF5lomLCiCD2aVtptYvY?=
 =?us-ascii?Q?9jkUiB3CMKW9V80J0oKIL/x5MLBZKJLk6KwTwnCbevoRLvyFxJ2YfPHnIr6a?=
 =?us-ascii?Q?XAnRlJuZoLQTihz1GN2hyyhPc070sR/lea822sPE2aUdCwFzB/4UI80Z1Ovf?=
 =?us-ascii?Q?LsfnVuZ7BlK9YBqLKTCbFBUOJNxZwYNpryRzaINuAjm4Nm1HDgJA0UVMuolS?=
 =?us-ascii?Q?MHXrBWa+1+aCu/qOWDhcQFTKX3F0fPM1mdKjXxs2EzKDSd+66LycqjGRyxTG?=
 =?us-ascii?Q?PKGU01fUbmtm3Yvlol4f28faY+gTYkdvHCimRdhU2XCkgjm0GZ86d/jzgcBZ?=
 =?us-ascii?Q?S+E0TpsYUGc9qJ8Lz0aLlVaIOGzNlm9UfHDrYmPyoHLZaAkWIa4WhhHxn53L?=
 =?us-ascii?Q?EMWMXCiAZbk9WUyKoFsIjY8G+9J6jAvXX7EVrpnpzmwDjhmIcUGhfgifnBm6?=
 =?us-ascii?Q?8hPRVNHoiFj8gASWymDaqTwKOlGOyD+S13zqSZbasiY5R+wJ96thadBx1wYd?=
 =?us-ascii?Q?jvnPrihjBrOX/W4dP/yvY+DdMkJBHtd8tS7t1GwBkjJzFKWV1TsXCp1kuVwJ?=
 =?us-ascii?Q?SGajhLAFzgHAuHRFNqYogzkrUxIq1ziKV6NQHnvtkWgZxH48OI7IZueMDrht?=
 =?us-ascii?Q?jQrvz6DrO0hHAhF0zxcBLyz3unYfmW8HZLXgLBBKp5zOHxo+bjhlSeTuJ9pd?=
 =?us-ascii?Q?+kUddRdFORtNyw0iZ/b9hWg10d86o0ZOPzQdsIf0ZsS5NG/shkmAP/39jUrQ?=
 =?us-ascii?Q?9KjeETKM7jbGOJUZyoxFc7vvPUPrGmsugwF4JT+77URNncTXDyExmjC3iFP8?=
 =?us-ascii?Q?USSGk6aIhnQYy2Jfn9tHTMqCAPz3nCLPuUBV/ZqU5KiPKDtUy7VC3exUp1Ax?=
 =?us-ascii?Q?n++l+HiGAwz5YiZNlt+JqflDBNQ059tNyTzlUNkJXbcMSOEgHAwm4pIy26G+?=
 =?us-ascii?Q?IqRuL+Q7fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbe2122-8ce3-471c-152b-08da1649dab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:46:08.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+gbJo8GkSOFadnoSTQp8nZOcRYHYfE5sA9brgAjXxLxY94ZWMYNNlwA3IMWJYgkuRsaTFifUygmn4T8/IXdWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I've tried to run pylint on the previous state and state after this patch=
, but
> unfortunately there's a *lot* of noise either way - from all the "pylint:
> disable" entries in the script I have to assume that at some point it was
> compliant with *some* pylint version, but at the moment it's very far fro=
m
> any sort of compliance with checks I can run (both before and after this
> patchset).

I'm using pylint 2.12.2 on Python 3. I agree there are still many pylint wa=
rnings - especially if we start trying to cut down the disable list. Howeve=
r, quite a few of them are false positives.

The majority of the unsuppressed warnings I get from pylint suggest changes=
 requiring Python 3 e.g. conversion to F-Strings.

> 1) Is there a tool that can be used to check for PEP8 compliance, and sho=
ws
> only the two remaining issues you highlighted above?

I used autopep8 to locate the issue I fixed here. It's not nearly as thorou=
gh as pylint, but PEP8 itself is very patchy in regard to the issues the au=
thors chose to address.

> 3) Which of the "pylint: disable" entries remain meaningful after these
> changes, if any? I imagine "disable=3Dwrong-import-order" for example mak=
es
> no sense?

I don't know if it is possible to cut the list down any more yet. However, =
"wrong-import-order" certainly is required to suppress warnings about the P=
ython version check mixed into the import list.

> I personally have an interest in making sure this script keeps running co=
rrectly
> under python2, so I plan to test this when I can. I imagine this is alrea=
dy
> accounted for in the t98xx suite somewhere, but I haven't found it.

Can you give me a bit more information about this, because I was going to t=
ry and push for the git-p4 to discard Python 2 support later this year in a=
 bid to simplify the code, reduce the testing burden, and move toward clean=
er pylint output.

Thanks for your comments
Joel
