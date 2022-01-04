Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28902C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiADMe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:34:57 -0500
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:39777
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbiADMe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:34:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLFhemFAogmdhpZ2v4sVljxYbafGGZjip9NZb1JOSoRc8g1pgsNlky+rEWIEOU61MRT+Qs3HA7RmHjo2sX+IY5oGb43tYt6eYJjOuXRH5G9DRN1zHwUZ3pLy8duEIkaCLgYqErlLQO30lV90zwZ6MFxVxJFgSFcTF+rGE3iL7eltJq2tO61nJRHWoJaSj+tNLgutjnKGE+hor398SkHA8V1M/P6ZQIObI/YQx939c+GwVpBAHJojAp7+7WuoLSrHlfHKOfAdNFiU22odLd3SXsfRG8rYBlBoh1em/XoPmwwCP0wmIZNOnAaXO/X1LnFOpcq5qY6xnrbjITR5aM77fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpm4yq9TG6LKi/z+jwHTZ+3bkFcvuwqmZUWai52KzYc=;
 b=MsSW7lP3yFlQsvbMOnlx0N1owa90BKjcVBq0oxB04/v7uKUPikG+KCBlE3WyjHKz6348Ha9fX/KIQtTc8mMv59K7+q3z8ZJVxsTlugj1mF9mQfU1HjRPhTXjHtLR2g40SHxGQZxC1xR/4BGEIJ9OxRu4dZDyasiJ5BvUdX3hXcl66IIq3qYS0YTUReqhLCwLSVJaQ7nj0nE8UMskeMwqrdneVlToP25ZeZxkpapUo8TqZ7tExApoWMjC4zqVpNhmyVKmSX2OQvYb8G5GdmURQoX//o9kVuAtBP4oBHjAh4O/AalI5pQkg90bPGmxX4pI+d3ctFsnZYJ/qFMoVF6vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpm4yq9TG6LKi/z+jwHTZ+3bkFcvuwqmZUWai52KzYc=;
 b=TLuosjhzuAMWoWj/cGv4CrOutvPGAA2V1DexJWHajrCWIPxiwoPmhrwXiq73Dj2lPMJYUn09qCwSSePXpS9aoMBzTiONsjKUfFPKs5hhcQmney1Hg9dsqKz4hFqYT0eDMhaHDeR4eB4mPurH3mVUCKz9r09a6yfX6eMA1Vh9jj/pfVXNsYsirdwxhdr6nCTpQskdwZshc0dgScSr20XwliP7uFSaUuJUVVkoJG3aWxrO47533SwpGdiMfKjrQ2zVTtmqQ4Dy8/QIDJfjFIah3rjsnxeCOoOEGfn6/x11GD/IxSjlto/7bA62qFvnVdmP7o9XFpZvNwkhw9v+nkE0SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:34:55 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:34:55 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 RESEND 0/2] git-p4: remove "debug" and "rollback" verbs
Date:   Tue,  4 Jan 2022 12:34:29 +0000
Message-Id: <20220104123431.1710-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::15) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa12f453-ef4a-4e3c-5db2-08d9cf7e9ccd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4866:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48669EAE22144A60D22EC4F2C84A9@BL0PR12MB4866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7fjxc5NBEyrv7UD/fWbc54XgPv4tepJlvumq4UQGrvkS0bfzScaRs6lHQwBjTwn/q0oCt8Iz1phpXgAWF+0H4Ow0mrPHzIWZexJYZ7eR/vB3UZU7SAsk4hUdPt2TFpCVkGocSw5dg/WUz64fZwJarGQSuF1SvDT7RmwJmOfuIxeTnWISuxLwrUiTlQGm1x0HT9SS9DZ/g1D1G+RslmzxpXP0DnqzxzxGtVEMNaThVy8EM2FY6KtoO05GzD/VmO/rFtwK4gcFbQvTaE2LAfiesn8FTSNhZNNQ3AGoAkBTLArLrmsYqw61qv/bm6iONxqykA2eNDeBd2DSPw9ynSh6qcW4smUS0A/aZMWvQNN6FKSCK1kUuGB6EjAnMb5xoO+ZM2v7DgGjZEO6D0iCINyEUr8mSkTtDjyasXohSK/dvPcOECDOzTYX9WqHeg2uPmnEbk0tSzMyNoQOggKUA9dvrn2n6wl8gNHXc6CkiXivb+Irp+hsTpScu6G0uexMrWh6hpHg+Ajln1+IFVZ9/wis9KPXayRYS2hevLBv1m4eb4XF/lQuQhFZYDb90ARqnLdPiu0dTI3rQ21k3zn/hUyLzmRpeK9xhCvtcpMOwZxPkMGzXUpvPVdfJUSbwzP3zxmLCJMmt4uU1Mji0wH49LddhRzkJDuW5nIe3kCWN6IYjnm8PzVyJ3lPsWYRHn5m3bOfklFdvVGg2/5UKuP13kOrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(55236004)(38350700002)(26005)(6666004)(508600001)(2616005)(8936002)(6916009)(8676002)(36756003)(4744005)(38100700002)(1076003)(316002)(186003)(66946007)(83380400001)(6512007)(52116002)(5660300002)(4326008)(66476007)(6486002)(6506007)(54906003)(107886003)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dDUFxQ//Bnzge+gRs/oPCV27cElrHU2B+8Vi1hDY8zV3QXEmz/gCAt1BcWPj?=
 =?us-ascii?Q?J0FHH3vuOtfs09MHD95/PrDSQpN9Daz853Ahn7wcvb/+L6ZQb2pG4SxTojD3?=
 =?us-ascii?Q?35mDsj4RJ2PRPuKWlGDmakF4QF2hStaV/cJzgpNCq6W8pQgby876qwMtth46?=
 =?us-ascii?Q?yVtBhf4fTLwHZySCefufBrrBl9b7mZlj4ja+lJt8/EZCa6Oidyw1GY0A47+l?=
 =?us-ascii?Q?f0jcXa37MMxObvnEO3sstKTNLULsYqaaRLdaTJ4jSYjsRJH6+X9BztLpdU7o?=
 =?us-ascii?Q?mhffxZj0gVTDt+KxD/P7EcDvMjlxqkViNduUZ2jitttSJKRTRuJruxNtGmu7?=
 =?us-ascii?Q?CLsbL3xoy1TroEtQ1X3uXW73wwmosFHdtBs4cI+Ck6hOOsv/H2eT5XXJNQK1?=
 =?us-ascii?Q?puprC0aLk94k24bavAjLjnM5FoXya2BhsuQ054sn6jWMeo08Ki4EnI9EYOmL?=
 =?us-ascii?Q?j8x92DpNajBzakqRO+B1PCKZhCHQhzf17QO2nNe1bD1FadF9CoFY1d4VMg//?=
 =?us-ascii?Q?NVKa6agCNeKHQXOIax3X8wdRWYYyUg0nALWmkxIe5vFNnHMHOvMy4kE5PKXr?=
 =?us-ascii?Q?tiA4NErF3sFiRJjy5SEyu0C/334pKzL+zO/DDfChIA8XVUwDwAb5d6hLkE/0?=
 =?us-ascii?Q?3OeX4Ef+A4UZs7AhtXCP8j/DvY0ivSwQ2lWkRF+in5rB+SCIWKmsRp1hoEQG?=
 =?us-ascii?Q?M4odxWuL3ZhLAF4lgwIKfOtkXJCQRyOJk67pF4Wx/96ZC8WHGiNfIBFSBVD+?=
 =?us-ascii?Q?03iTWjcnSt9o/Ff0lkbLPVGU9ABqb5XjopDkJ9wOyElv5ss1ybPi/PhKeyqz?=
 =?us-ascii?Q?fWKWvYO1aT3JOxFGSmTyVtB2sR7S3TItD/kHjBl04biSpLA/JeFfaKPa49vR?=
 =?us-ascii?Q?VdKSGMwdn7hpF3M89gdNnmd/no8S5/Lki5rpNCPJBcO3h11pzTwQpg+AZU8m?=
 =?us-ascii?Q?/t/USUYAsHCIkEVx9VBewgyw/OjWMPWUjSkqFkCXhqrhoSDQuZ8UAs3zZ0++?=
 =?us-ascii?Q?HlPm3hxV/SUSPx8y9QLjmSZhpZYG3MTKz3wDIz0DN/BVXBkxn+NteqZ/Z0ga?=
 =?us-ascii?Q?OzrDizGGhaB5GoiowyMUiUiE1EhhZH2/WQ7u6mySioKlkZAKs2wLDQwmpul7?=
 =?us-ascii?Q?VuaVlc0l/TeJgjVnbVerikEpgwJGUxt/fCWIQxVE9doc8SUJAuAZNiAIPWC/?=
 =?us-ascii?Q?/odMXAIO7CgKEvCXkuKJBjAkyWtfedQLS91a2urU4OchxZE20RsluqeKp+l0?=
 =?us-ascii?Q?UQ2SFEH/cNNOtb4nSsTejBYKJm5z/TEiV4PNfqf06ydFVHoqobacoe7Cvp8m?=
 =?us-ascii?Q?ol/NYS+oU4yck50ZmGcEdompCNI2k/rDsvvaEQqf+LfJQMLwsgdpdll3r3FJ?=
 =?us-ascii?Q?dm1O9Jf2ZjqUVCGUDXJfKk59X3Aj9tU/cx4gdoS2ODfB4NRCFjhfTN4xTYa6?=
 =?us-ascii?Q?On48dF7q5QAsTg+0zvftp2fiNtBSVZb4PDRHnZMdCgQQuGPTnfICOh1T77pk?=
 =?us-ascii?Q?y8Ya3j29Y5PkIDrFUkpuDIqppFEzrn3Elxhq16Ott2aveaBMvbwyi/FMEiEe?=
 =?us-ascii?Q?ZDYJEWxizTSTJHXL/v+3H1vXN1LjJXpyANWBpU/YL5fSvuC9PlmmCPPTrt0s?=
 =?us-ascii?Q?M1XRcfPHHEJIubvjDfDVOhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa12f453-ef4a-4e3c-5db2-08d9cf7e9ccd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:34:55.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPW3Oec2FlnQbaJBoJaF+qGkLC/GLgUHMSsN6zv/8K7DilLY77J2sXf0wg59E28l1va7Har7t9kXeTMkRAh94g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains a selection of verbs for various functions of the
script. The "debug" and "rollback" verbs appear to have been added early
in the development life of git-p4. They were once used as debugging
tools, but are no longer being used either by developers or users, and
are largely undocumented. Removing these verbs simplifies the script by
removing dead code, and increases usability by reducing complexity.

This third version of the patch-set adds more detail to the commit
messages.

Joel Holdsworth (2):
  git-p4: remove "debug" verb
  git-p4: remove "rollback" verb

 git-p4.py | 76 -------------------------------------------------------
 1 file changed, 76 deletions(-)

-- 
2.34.1

