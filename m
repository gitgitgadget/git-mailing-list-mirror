Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F10C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhLQUjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:39:55 -0500
Received: from mail-dm3nam07on2089.outbound.protection.outlook.com ([40.107.95.89]:1505
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhLQUjy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 15:39:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhJU19mK5WOW+Co+1Mps4ub3jm3aY5WBBJMOwX705iC4llrW3jXepQu1u59eWDoCyXpHiYWScijcW8ozazx8RRoC7e7mIqRNXL6bfoYslkKw/Z7ESm3Pm6HRYCi+GAjFnDRBALoFw6wQk9UjzNLQlvWQQyOFOVHRi/f1OX3KB/ld/dar/wINxWotjDHK4wdaQt3547KblI9JcdS9NfAOtbtkCXWIuI/TvteyLBjuDEDDWoK5wlAXGmUVOU9+JjGzkNW+1JGfBZdmf26rbCeVYMsf2Z1J6yBarAtcUdXW6CVZl8A9oMpzqlWU28VrJnxkpGgXYtH4RVmaKIJ1N56ruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phaNGyWQVi6ad5kbNRRR2VqMFbgHJb6vTlm178/+8HU=;
 b=CTzmQFY8YjCpAZ61gTdSpVnehEWu0Mne6CqfJ5TdoeK60wlSee4ZW2/piv5wiojDEChfuizEXkF4tqQzr8A7M5awG/PwLdwjQcTJkwB0FbwyZyuJ67m9ZFIps1Uz7tsoaiAIextvF2L85mhioM+gfhldG5/tcUKkfYuRKWLwpd3kH8XXsRjBkK7/vHNbrnZ2esn2vX+4Bl1DQEAQHvj+VBdGyKhu4V59XWo9Ku2ND1K1GqA4r3EQlLOdA1LRmpoSf1fm3kwcBM7AM5J1iLs2A04hXu0XWMGetwuOxrmoE5qLpLtyJSnNC4tqH29jORPJYtTsuL8i06CT1K/H5Kktag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phaNGyWQVi6ad5kbNRRR2VqMFbgHJb6vTlm178/+8HU=;
 b=TTDQ9CUcy+8yBAzMOZ1YKdN38ux8R/8u/CiffadPTrx6s1HKaZnrlnmfle1GgrxaO3NO05sd1c1YnckO39xn+UnDFXOurkuubRkj8LrGdgAYJCEt4OPL+yE/aYPsimj4RMkySFQu5DjJI24/a+XCAnOQ3tDRRuBNf2oBIN50mqZCN8vUrWlmdsoQtKt/p6oQD8kdjczXRLG1uF1/6spP4xQYkeeNbDhtFg2vMUAg4RR05A3QlKS1ILP7udUrqx6jzy4+8bDdA24cZ34nM+6G+jpUN9RuRqhLsV8DbMWynkm9v2L9+tgssc5TXUDf7mJSYzoLku7mBk3leo3+ix+SMA==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 20:39:53 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 20:39:53 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Andrew Oakley <andrew@adoakley.name>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: RE: [PATCH 1/2] git-p4: print size values in appropriate units
Thread-Topic: [PATCH 1/2] git-p4: print size values in appropriate units
Thread-Index: AQHX81bHsjWuyDBgFEuGO3ItIz1Joqw252KAgAA+ScA=
Date:   Fri, 17 Dec 2021 20:39:53 +0000
Message-ID: <BN8PR12MB3361AD895447CF05A034D68BC8789@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211217145949.2229886-1-jholdsworth@nvidia.com>
        <20211217145949.2229886-2-jholdsworth@nvidia.com>
 <20211217165627.49e931d6@ado-tr.dyn.home.arpa>
In-Reply-To: <20211217165627.49e931d6@ado-tr.dyn.home.arpa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5995b45f-bb96-46c1-d0c2-08d9c19d612d
x-ms-traffictypediagnostic: BN8PR12MB2946:EE_
x-microsoft-antispam-prvs: <BN8PR12MB294690298DBD31F765A43B76C8789@BN8PR12MB2946.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLGvoJSrs9SyvqA+mUMOYQk9/AXA028aJOpt1EmTaQBfC6Qp9BXET8Cb78cA4Lf9p4XNrO+x5yhQTVsi59kSSaptmslsltFTYL1Xutjn/3SMVbIIr8n8aa6SsV/6rRHxfu8bl8qJiVwGlUPZeAVsrmJssoOWhC8wq9T2dQIl75F43zpmOp9CbxMe5oErH9sCejxO8yVqzbeUjKopVqSnER/6h7gryVsrFeMMd/SsfraN28T7CqotOm9LA9//pQozK0cgGqW91NWLFpDopFcs2LKARaEPW4A49BCT0SQlN/GznYdsBrjTOEhUr0887OmPXFAXwafRmViF22KIS1rpc6nACgVxdX/M1fWrTin/+mNuNeWgOkUlHOLmq/7dBSntPtHTZ4Ky83kr7z4V9MKGTZzaXR2evuT8JwBlUKWA61Qco05pOjzznWfOHA3oXKK3xP5XPcaC/eaRG8Qx+VqTGTeDksEC6fyIaIdf9J99hXMNslJGKYvWJ3h47vJ588RCwN25pP4DjfAa3Eepqnbz3qev3renlNSeteHlrttJl/ekS3ljdxzrE242zrQJHOl08lfM84nTYJXkPBHmjiTZUNnpzoBXf+Kngq54usNKlIhe6CZ4uUUOvCrVDtdBleE4vwnfX/bJYjHDrkyTNix+pmdqwlvmdb7jgq7bi5VxdJtM+Z2/5q27bzMraXLHnPot
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(8676002)(5660300002)(76116006)(66446008)(508600001)(66946007)(6506007)(86362001)(52536014)(558084003)(55236004)(54906003)(9686003)(8936002)(33656002)(66556008)(316002)(26005)(7696005)(2906002)(186003)(55016003)(66476007)(38070700005)(4326008)(122000001)(71200400001)(6916009)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G1bhKOlKdwQEWf5ZcoInVFfOgP4Zhv81csR/M4DiQbhE999UywuC5eNzVEFB?=
 =?us-ascii?Q?dW4WwbDGrmb9sh87olQ5KcyVAX7zhNPKi1MKpI+k+UrmIC2UbgYLVUMBX5SH?=
 =?us-ascii?Q?Pv8z/QnMyiWSq4HgxqXI8ljTi9SXnzKoiuZ58Yds2YnfqWDefgVzTtqBOOYD?=
 =?us-ascii?Q?LXAj7Cyp/+97ZTnkgyzdDAFC84o3b3HuSFr6rJ1G2ntMizrCEn3MDDr/YMCO?=
 =?us-ascii?Q?FxvbUOTn4diDkR9Y0XBQvTlCm29jdWYX6YWfn6D8CPIiGwRlBrz+hos025RF?=
 =?us-ascii?Q?W4nCZ+Wi409Mu2nH8fusQXer6JqQ+5FjplIoKrC778MppHA0vF26LP6VFEYc?=
 =?us-ascii?Q?YBTaMPzlvBzEflj1yFpUBmXWBetGxfkorSofJW3crMwxN3teZ/RIN7kbBxZn?=
 =?us-ascii?Q?OAB+/7/gNuEXyENyCdpnWLjHMUv+SVuYcNLabdUi+oZrQiNhGxqnV0VeLGxd?=
 =?us-ascii?Q?oEF/fldgSqJVkDM7s8bopyIupAS1EJgm6qHFXYDKAjWYtmGwM1jBn32/OQEz?=
 =?us-ascii?Q?amP0JaRbrcJPTubnum6J/SvCYLiaunm9FZNTvFvrmDnyKbBqiGCaZJHn6smm?=
 =?us-ascii?Q?teYNUOZpZCvFagPMh/8z5wUEy0Knog6PlkLU0gsDJUcDDSN6dyuk0KzvPRy7?=
 =?us-ascii?Q?C27gFbUPLnkB2lHbTTNtQYGU791dwUIWDlilv0FFAzBAgsOUdskOmochwmuB?=
 =?us-ascii?Q?7rN6XcqDbUAjODtk51X1Z3G1kKBUVAqE8pRjcxw93PwtmYStCk6h0e7xOXkH?=
 =?us-ascii?Q?bCpC0STpnnYH1TYa9CZ16OjX2Oa7NPlYYGKMq3C8T+u7I0CiZBbprwp0nvwz?=
 =?us-ascii?Q?LaB9a7uqlOZkSr9H4kz27Sq7ACUzVUiRbqHilgdsGC2HFzlCe94yr0XD51eA?=
 =?us-ascii?Q?/EoZSi/qEgxPydrLOdTt5ZxZDCUKN8DNUOMDENi1KB+hFF5LiKeD866E4RPR?=
 =?us-ascii?Q?GeDl6kMBnP4TOmRq3cD5JwdRguvfSRpigm94k7t4TJB5JWan4B6I7K0rkTzI?=
 =?us-ascii?Q?7z1S6khYQAhUT+wCcxzAU0QX6/hBOgTumFnjx0tNK6mIv5TdWrkCcUJPksWv?=
 =?us-ascii?Q?Vjf3G4gRBraim29ErwP+t3ltMAYBJzFo735fbvixfeLByg1E4vWIv3MOH/Te?=
 =?us-ascii?Q?c/0mTBQwyQji+yc2UdjXcx7vYy+7bcnhmH4ZeF3AS9kxcgEUilXKhL3UJZwz?=
 =?us-ascii?Q?jAyh7euN2u8BCrJCWrqHbrC/KIuRaOA+bQwyja7gFdtFEFnE7w8qnGh6tP0D?=
 =?us-ascii?Q?zQOMKTy0ODR0r2b3STi6+InwwAaEhEj3YBfyVSpjM/EGliaT5pQxzWTVPDb4?=
 =?us-ascii?Q?SMZn3TbyZeMRj40tsymsdoZmnfozNcvBaV/oW/CpBje2j+qb2/n/Bv5Pg1F1?=
 =?us-ascii?Q?KpUdscrtYokIAm52XOgNEGUACjdugGYng/I/OSf0U0ZCB7rC7Wr2LPc8ryow?=
 =?us-ascii?Q?efj8+pS5CrS74hTPcjgpmdpNIFjRtJkhxDY9+DMSgZlGR+kdMUnrjR+6pIJY?=
 =?us-ascii?Q?s4vZ1Iwoa+q6/oZqx8CY91AAtA8KEC87wCdcKzNy+D+Qu8wV5DeLeiMlOfoK?=
 =?us-ascii?Q?aj/dBADvC6fFc5wHl6ff9YrMNvdr0b/YSLvVfRu73piG2fUyxFF7ddjI4idB?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5995b45f-bb96-46c1-d0c2-08d9c19d612d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 20:39:53.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QX3RY1KR1c5usC37VRFlid1pEvrEQJV0bYrYYdd+qgNP44fizRmtPxSDDy2H3SEPeF0K8CKLEP/00pCd3XYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If it's always bytes, why keep the suffix separate?

> You've left the "MB" in.  The same thing happens elsewhere.

Both good points. I've resubmitted the patch set with the suggested amendme=
nts.

Joel
