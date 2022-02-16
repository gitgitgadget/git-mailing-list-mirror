Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219EC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 23:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiBPXGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:06:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBPXGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 18:06:54 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D0E0AC
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyyLYKkxEGeWuHTj/jsTZD9qb2qr+xGcYQq1DyxJ6lo+OTCG7K+aioMy0AbmbdU/CWhjyQLERSk3BR89wVD5dNitrpKwA7gymwoQjNz7KSmgEOQvkRv1PyIcgxcwqPZ9gxcubfhn4e9CpanRejR5SnO4JjtgkSMbDew2WLBpl1aSVZS5doprZ5+OEMM5XipkqWGL6r1TavuzNs50DMiYurJ8oN7PJ/Rt5T8HCPYRABomuY9DBySxT6Qb2Bg4VqKedK7CfFkGIsc+y8gq2llW6ja9iFSl5+z4WS+ncTeQH867HgClQhpU6k+B9P+L9vkwv44ah9OAB2J4tGf00cqXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWpdFncIZGjBPENqO90J6wTTZ6N2eyw7WSZ4zGh3k/c=;
 b=XoAXcqQhWsGw83Oi0ughuseByOwsByONKT4iVtaZWYw0tpmTEKIL9DSdlY0TZ8S9E4TzTH+WupY1H7dMtBdq9Hc5wN3eJ4iXx2RhmzheQxWnrEe1kJhFq200GPctBipfca0oEXIhBhrc+rbowTh7X0bwdHG5ZS6u5g+W49l+iklqO3XIlx0msPbAQ3KSP1LDR1gI9fr5j1L9jRiYWbzQ18w1je0HLS6++twEjWorozE1iRB/R0D3pYYjzOa13eKWuNWhLozMi0g6G/9ORe1wkjbghn+XVdq883Qm13E/faDOb+EfbjtYKe4T9KlpZBMlywnE6x4KoI+ucPmqcCpPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innova.no; dmarc=pass action=none header.from=innova.no;
 dkim=pass header.d=innova.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=InnovaAS.onmicrosoft.com; s=selector2-InnovaAS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWpdFncIZGjBPENqO90J6wTTZ6N2eyw7WSZ4zGh3k/c=;
 b=O98t0X+3IiuzmbkwNvqiW36MyCyHNfAp4Yfr8GThKszzTTDVNbIkTAVoZhH8SyIvsBJCZGUKX0oZiXjyNOZlv+WmNJ+VlwW4KSG7gYetsYpsLHLLofl0Iu5NZdpGERwynnMjWrXxgPCLv/thXTmGSTk8LIRZebdOgFnWvEgf8tQ=
Received: from AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:107::17)
 by DB8PR10MB3911.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 23:06:35 +0000
Received: from AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9821:50c1:5abc:d3b3]) by AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9821:50c1:5abc:d3b3%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 23:06:34 +0000
From:   Erlend Aasland <Erlend-A@innova.no>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
Thread-Topic: [PATCH] branch: delete now accepts '-' as branch name
Thread-Index: AQHYIz6lb43BUNQhr0qRZh8P6cZkA6yWZSwrgAAkJQCAAEPgAA==
Date:   Wed, 16 Feb 2022 23:06:34 +0000
Message-ID: <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
 <xmqqbkz6vjkj.fsf@gitster.g>
 <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
In-Reply-To: <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
Accept-Language: nn-NO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=innova.no;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 155b8869-7202-4449-d680-08d9f1a0fa84
x-ms-traffictypediagnostic: DB8PR10MB3911:EE_
x-microsoft-antispam-prvs: <DB8PR10MB3911622F9A082C27720A1C589C359@DB8PR10MB3911.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZCCew9wM/A3jgLFHGZlK/3xvKpX1EW4eoWAWPWSUIBEqezW9WqMpUWgTXC3thCdaWjDazDIYrMYNFp7voTBNWllfNZIPNAqdqyMjynV3tfii+ceET2WUUKhjvyaDBGtz9zsYQ9rnVTp4pqPya8Q4nkRk+QzcJsMkysZwZZDWJ4I6bJiGTf4/wC8lHqQELD6U2RN1bhel/XMXBS0fQtpCbVsLuOZuGoUOgZgkw8KepU/x5E4SJw+zpJyFrQMV2y0PlLDjvxeQFIDKFB2tB50SPFz1U8PhZjPDyks4PuanlSp5KaWMvbA5yTi23jhzFl737jR7GR9YabGjKVj0H0/VUA0U8O0vBTE//swENY5fsVuAj6vtMRdpnFClgrITWis6RpxzmTDe6zTH5Uucfre09jkrp1LRuV+dFrdQfCLtI0ycXjaJCPhFYaS37XJhfmhDxbAdsuuuvOBDxtNk96OMTyfl1ruAj5ilFD7cgkHQXY0myx70Yr1yLCuT4x1VKp7sgWBHw9Bz2wJpIVHQJnX9M4BSSEAYrzUiSV/RniQ7dM/8eRN0iGk64VE+YZnhqf9suKS7nHoJD3uYtOs6D4PfKnPOXM29dCV/MQ8QQ/tNqT5y3x71DaP7r+wffePJ0IdVVAzOPdh6Ed4NcNBPs/X7htM6DKIPRdpr0ts34FJv1G3+AsW1ItNnbH5ZU4Qe0jBc9e1rxYdL9oJfGnO2VOuz+g5SNPOZ55R52bWBJhNId9dygTLwBECnZi58cSOstW+WZqf0Rqjiah0eM/3SI2BgZTxFMTCwUOsf1+vNWC7JIn3vXeQpw+3AlUAkz7gYV5xgfog9Z08Xafjta+SgFZmZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(346002)(39830400003)(366004)(136003)(396003)(6486002)(122000001)(38100700002)(966005)(8936002)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(91956017)(8676002)(186003)(26005)(508600001)(71200400001)(83380400001)(6512007)(36756003)(6506007)(5660300002)(316002)(33656002)(38070700005)(2616005)(86362001)(2906002)(53546011)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/3ksWGq+m9b5s4SNFo8lmdOE39C4Xwy6U4conwQm8PSkBhUs7E+XWV3DETO5?=
 =?us-ascii?Q?ZkIS+VVBq6re2OBOE2Q42cLN1q2kI0DJfdpfvIs4V7Ob02QfCKPqfeJUJ4mh?=
 =?us-ascii?Q?XX0sne2LRgIi+ufQYEod3xGXhIxgeITI/BC7YjhmkOyyV5WqlQ4PWEkUdD1P?=
 =?us-ascii?Q?apd7HFAq359zA42ojBp1iGlXRSPQOnHCdyDHV0aOY54fzXMX5YeEvl/Va0ZX?=
 =?us-ascii?Q?/L+Z+en1bpOWiU+sZQDuEQ8p6I8gdOzbUVXRtxboMJ/YJHuAz+gIOsVgQrcg?=
 =?us-ascii?Q?ZrIML1//jEEdR2o8m9QeZSxqqjXCxSn3Ew7T2NZVf6MRl4839lnXh/BtKxPV?=
 =?us-ascii?Q?kBkv7vfd7i6q1sQ3+gGn9nAdj3QKPYvs9To/k+WJQ1Xuf1PQkQEJDr6ezrZm?=
 =?us-ascii?Q?yqaRe7+zGBffJL6zwZ3HXeJ31n2+aexTxietYI8RhCKDA/hIyOxYFmA5WByp?=
 =?us-ascii?Q?8yJ7Q4xrwxJzg79tI4JEVnyJ8hmLdJCqS/+8ykhLyWAfbOZuI89hiSoKydCa?=
 =?us-ascii?Q?phNujRz2U2mMVYAnop96DwtO7dmLtIRL+f53hp1pWyfB7+Qx+iCUOTNKruuK?=
 =?us-ascii?Q?M6lYatHhTX4+ANN7VrYCmgE+MrOjerDJ+bPsBomojZbJ2AL2ATwyYQyl30Dd?=
 =?us-ascii?Q?mAPP0zx8HipNbJ3qLZK/MxXs+Jssxv6xz85sxgXKp6AkRonv8IiAKR9ZiqJ3?=
 =?us-ascii?Q?lQ+B4v9551LEN9PeNP2r9GHOEm/G31OiTT5+NdBaOI2iByOUk6V1POgtNW9q?=
 =?us-ascii?Q?Rvx0r5ynngXrZ0FJxkXk/dKHmvNlrcaksoOCk9jw5dWAvQ0piSBbzBgb1EDO?=
 =?us-ascii?Q?qr2955hMrvN1JeJuNs7btSLUhGKCRV/bE8NnCwj4Y23n/iOE+JoWvaq+wuMs?=
 =?us-ascii?Q?8RM768eAH3LMNTjfqKD68lKSVuWrHeNVn/Tq3xmxn9+Yww1bn8uA/ZdaStda?=
 =?us-ascii?Q?2SaWt5RbEWBAv/2vWHG3g3fJoQ2nVDPMlScl/ALHjTJu0jMAQf6ssW80OxeG?=
 =?us-ascii?Q?Hbvoq/BAkP3kc5wY2DsQ72Q3ohQCK8rzSDJrIomqsIeBGnPyF7yCnOkDRo4l?=
 =?us-ascii?Q?sn0Mne2x8bqd/fDxC750VEvVHbEJQfWPJu+alDRjpQcvPSmZ9FtPmyXBOV96?=
 =?us-ascii?Q?ThhxD880Siqi4TheTPaVG+kPjdoxxDuteFDQeia9jUmCknsk31eGnpfhD6ZQ?=
 =?us-ascii?Q?zpOzCdoF9L0R1vp4k2qKb3BV0Qr3bEJ9XTDx7y6tuNuOoWM8zaGVLOyUdeVS?=
 =?us-ascii?Q?fZ+mzXmMO2Zo6sKIXx46JcKnMfnAHqkH3DNuLXtjGULfTlNSts8gT62PQAdv?=
 =?us-ascii?Q?zuF9X/UK146NwPp4w/mjQu4tBwe3I0L5mw4HsfIoaSE0QHOhibp5/RHj5VqV?=
 =?us-ascii?Q?FNUjLs2KPeb9aNL+tUO2yp39BRGLxBOUQSogUat6+bVH9ELQVLNHaRUlSVKx?=
 =?us-ascii?Q?HvmuEvkRpc2Lp4KP+9tlZo5jNyrW7LyEAbSn2AonS9/v6piJTJ7/IpmombqN?=
 =?us-ascii?Q?cCKhDixTiL4JN2a1/zX0vxm9a+dJXW4dN6QIj5HYU5Cv1bAD0+98hfjkye9o?=
 =?us-ascii?Q?OoQoGs8B92XRNLDLV4C8MIG51NMeIUGJxfvkNfY5vC7qabVmZvfS4DLY6yt2?=
 =?us-ascii?Q?d0I5JAXnlLR5pah9/wSKTzU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75D8037DCE0595458CEB1DA7EE558FC5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: innova.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 155b8869-7202-4449-d680-08d9f1a0fa84
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 23:06:34.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b7619df-4c48-4446-b5bc-62bc2f3cd746
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dht5AFm7I9Zp74ObasxwWjT7Rr9u8DmZytGY2U27KefU96Rmr65bqRYMm5VeeJn9TnB3HxTxoKvCrp1WMpQi0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3911
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Feb 2022, at 20:03, Eric Sunshine <sunshine@sunshineco.com> wrote:
>=20
> Patches implementing this behavior for `git branch -D` have been submitte=
d previously but were rejected (if I recall correctly) since "delete" is a =
destructive operation, unlike other cases in which `-` is accepted. A relat=
ively recent submission and ensuing discussion is at [1].
>=20
> [1]: https://lore.kernel.org/git/20200501222227.GE41612@syl.local/T/

Thanks for the heads-up regarding previous discussions, Eric.

AFAIK, switch/checkout, rebase, and merge all use "-" as a shortcut to the
"last branch", so for me, it made sense with similar semantics when deletin=
g a
branch.  I understand the concern regarding "destructive operations", but
deleting a branch is not comparable to, for example, deleting a file.  Dele=
ting
a branch is "soft destructive";  unless *explicitly* silenced, git kindly t=
ells
us which ref we can use to immediately recreate our branch:

$ git branch -D -  # oops, shouldn't have done that!
Deleted branch stuff (was 580cd9ab29).
$ git switch -c stuff 580cd9ab29

Until now, I've just been using the @{-1} notation, but - is very much fast=
er
to type ;)

There are no new arguments pro this feature, so I guess the conclusion from
2020 still stands :)


E
