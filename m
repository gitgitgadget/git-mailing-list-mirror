Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1E1C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA4061056
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhJLJYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:24:55 -0400
Received: from mail-vi1eur05hn2238.outbound.protection.outlook.com ([52.100.175.238]:6624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235306AbhJLJYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:24:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfx0149T3uItrU4AAYIwppgxaVd1PBMzctvEQvVP8LVnRWcxqAFIZ9eh3m4PlRISIT/o7lGNKFaCKwcGUO9Aenq3AGY9htBBO8/UwPqHAFfZgAt2/TAbpdO9uCmV7QUy/bYC3vQrx+4zF16JC1NY/00mzRHUCdg4nQcqR0vHIlWgE/oqOtO1ineWbfqWxK0PxlcLDMdKKGg1YmPK+L4vaj1nZrk/ub0xEqUejaPumNrrzVyHYy2CCyfspGKp7OCKpt1uSHACkIfmGV6gk+/sjkXT/3zp61eaZc6QChdfwSy61XjJU12TDOUSVT0NQ+fvDKrlJ9EheUxANv544L+IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZvYIpW7087ikHAsvuCtMRQieVI+KN90xjzqW/xlNYs=;
 b=INytwqeTrTL7gNttss6qDP27+yhkzNqlM7lvIX9W0BH4Ikr/h/FY5peK6r88DNrIpzYKtSQqLAvmEhpPBJ7sis7y5g9Ar3v2vekOc5kq43zxdN5SQ7h7DxRXofQWtZiDWcJeLqd928CXFazAlotcqOiHxT0fnCStVwmOkmllXRovMciBvmcUSCrCWj5mwI/nYGkPSKmT4NZwOoxjSxM6exw/XEFqrggoE9OrvLjZcRNA01XlJZzNgULBO/TPDKMteOj1OmPymjRkJ6MYhLRgBkujJh1QDyrq4ICk3nQFVik6DJkKggYYn8/0PLDyNIZo0u31ybVNryMrqsK9ynUgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZvYIpW7087ikHAsvuCtMRQieVI+KN90xjzqW/xlNYs=;
 b=fDXTr015RR/cpizT8bvcKJmV5GSzCUTY5cnYZArVWcjAwWEaCizXvy6TZsxbX9k1G/HIQ0MUbSyKDnQif46iezx2ddG+C0i8xXO4wvhltQOKgh3A1LtE/fOJ/E5+KqDDVCRSuvyabtSadzsrtHvZRBEqalUkCwsfUVYrVB2QLBc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4495.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 09:22:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:22:50 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 0/2] ssh signing: fix merging signed tags & docs
Date:   Tue, 12 Oct 2021 11:22:34 +0200
Message-Id: <20211012092236.619822-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::26) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P192CA0013.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 09:22:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8038a022-50df-4ec0-c495-08d98d61dc5b
X-MS-TrafficTypeDiagnostic: PA4PR10MB4495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR10MB44957A13DCE9504645AD7D86B6B69@PA4PR10MB4495.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z2MB8iP67JI27p5uf6sM4lQxpc+oozkq+DYbty4H59LmKtXthCiAG5cALV8v?=
 =?us-ascii?Q?cxfK7NDYJA5GLIsJzN1+g1d9ngPzNfpDAJZWIR46AAA9W2UL3PwdqPaVBgCh?=
 =?us-ascii?Q?2SzYnX4/P0ShoaKI8GDJbr36JiZkLCKsM21uZ8zKm3lBkQrFP0Fam1tk1zEw?=
 =?us-ascii?Q?8dNXSMlTrPAwhELk2Twe2HDyzVE4qom63zq2FbRsGm1n/0uv441DHOQSywUs?=
 =?us-ascii?Q?w2K1FbJJrAkYHcpl/JgbLKomjrWFTAsSwTZYZ0TdUTtlZmnUgkmixPwy850m?=
 =?us-ascii?Q?DIVCUHAQ7w61im+KxP6MvgT1ZyLOB+AajYd1Q3XSQyPB8E1dSFJVWpLmzQKJ?=
 =?us-ascii?Q?GMn8f0bJRb/ZNNUFSByVXEAVlMH45o6jHpDWC+gjXw/7Z6inv8ojENn11zss?=
 =?us-ascii?Q?v/sFeVqRNQ3s9FzEHKYOD5MxJGFyoWtZRM7/sSZgImq4jr0qvpZMF8Zw8e/o?=
 =?us-ascii?Q?pNDrEaxorXx66mR80i6CVN8RSrCg6hqdAun/Ka/J6iQVeEpXp7vU4tphjESF?=
 =?us-ascii?Q?oGK+2VT2v/aqeZ9o3AJa4dTv4BpBr71l7CGIhlCts7YaD80XG7HxHcskqW8d?=
 =?us-ascii?Q?fk+lzZkvJPJ58RurTQ2dlNavOyYfcI4FYjix5E0dfXs/tZqPb/bqX01yGany?=
 =?us-ascii?Q?HquBzXZoa44u5ULtiVtqNOzAuCWu2pgYd68QFZFK1XqCCnmjweGiywyZstCo?=
 =?us-ascii?Q?atY7hpzuKb6aSjFiULUQZUzO3p1UVZxNxek7HFl+KXxUa0rgwJFnaS3AWsak?=
 =?us-ascii?Q?zMSUuE0Xyq2f2+ijpnj4cynbwYRpnxvgj0p27jkIcwhtKhvIs/3iNc6ie8kK?=
 =?us-ascii?Q?/LekgnNhEkcMb5SUdr+N8AlW2wFV0pAG1biAxTYBizj0KYlfW9ZuDL0AZhR8?=
 =?us-ascii?Q?3xtERpFqxbeQPJiGNwJZ1TopMLMo9c7k9t8+uYj/HkfIJRFwt4wTxGikKPDB?=
 =?us-ascii?Q?N5mB+4hBX+mEcWnc+PTjg6u4BaCotaQbA3dasYtuqzkkhtlPx00BDAL5IvrU?=
 =?us-ascii?Q?wJmhY4qp/3oFrma7zgiNeUeuHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(376002)(396003)(366004)(39840400004)(136003)(38100700002)(66946007)(2616005)(316002)(66556008)(66476007)(6916009)(6666004)(2906002)(508600001)(52116002)(8936002)(107886003)(186003)(4326008)(1076003)(6496006)(6486002)(4744005)(8676002)(86362001)(36756003)(5660300002)(83380400001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opM/RTEC7OPNBf8ZpVOv8Q8T2oNelSRyUxCICmD2r1MHx6TGjpb7rG76Fkcs?=
 =?us-ascii?Q?oDha+iRWBEYvgr+VRpnr/U22ab7VX9b6INo9dJn3qnpbJEXSZe3xRojtHvlS?=
 =?us-ascii?Q?fLaXo6MwHAUXl7ibu/jSDXzXnnZTk+kRp+ec6ngtndn85G+dR8jdAT9sSop0?=
 =?us-ascii?Q?nxEZ4fe/UfVmrIVZDcymCAITFbKjmhyf7XE5SSY5adh7aEQ9OehMhBSqAtgJ?=
 =?us-ascii?Q?7x+ghsjErBB1GnPYiKyDJsQ4b32CDRO4lVdHMRYu0w4L5BY8p6qwtH/9yGs9?=
 =?us-ascii?Q?TB/Q22SsF6cWPkLuE/gYaPaH4EMQoD0Wq1NmVEiQxKkdrtMH8zvd46niFMwR?=
 =?us-ascii?Q?P89IBkmQ24V2l9IPj6yZP8dYGcdg4sok77P39+z1aByTn8fwcnPTDHw5ssvb?=
 =?us-ascii?Q?cA+Wlx1c2NT5B4HKWJGzR8pgZbneimdoHKJN/aTyZ5SOz7l788OKIoW+2+mD?=
 =?us-ascii?Q?q4ymGAeAz7hYHkCS6UJ5InMh2M9qMzZ7Tbf7JVzmCPEPo+LzFiKz+DcNxnz+?=
 =?us-ascii?Q?zojMy03Hkc19H0dkQkbcLe8qBEZws1IaNWtuYd5xr97PZoEYgE0sfOjcY2U9?=
 =?us-ascii?Q?MAtmLiMR3Tnphe6xX9/nRVBXbmoCqdsZ3QbDJbhSAnobJrzdROgde0GU2ov7?=
 =?us-ascii?Q?KCFE65ZqQ69XQRHddN9NZ4JafZ/vKAn4UYsZGnynYlNuE3jduN31y6Ql4HMS?=
 =?us-ascii?Q?PdjqBfUJn40F6OOeE6mYJbc1u/Ms8RfbmOqpFssnrSTvUWP2ylsos885gyAM?=
 =?us-ascii?Q?HALZL088LbdLsVzel0dnCDyCBHXye3yBLLszaf6KNX0BEThtuJNuk3PL6dcO?=
 =?us-ascii?Q?n7XlMAIhjSKwE1rDV2Nn+oel7wUDOcWcgZhsTYN8WdOKaprMRRGCvfFi5sAl?=
 =?us-ascii?Q?pOqXOaX8x2JJPOmp98S6iAMKH4QAypSyIf0eL+cp1RK1l1KY183R2I8uRg4z?=
 =?us-ascii?Q?F9q7cSFj5Z3l3J8k1bm0odsVebsxXTKftLEkOZOidaCNRfk2cS7zzunyKv+S?=
 =?us-ascii?Q?r9P0+Cl0KbRqaiq5FOSpi8/FiZnrl6/Q7nfKueScnC8UqukbBAzgv8RfsnKS?=
 =?us-ascii?Q?wgUCLa+rwGxNPddTz5QQhtOoikiAuWq1NYfBGy9GeNbDJ+5/toiDe6F1pX+n?=
 =?us-ascii?Q?J/oOrlTcRrvV6wo+FRsPjj2z68ooiA/cOUUk7avUb6hQ/pSD+9VsSyja6Tn2?=
 =?us-ascii?Q?oSZ2GD0+CphjERSZKHPlINizcjih97PeBZuDEA/Lu0GkalHhWAzyrW3DaaJw?=
 =?us-ascii?Q?4X+SVXpVlsPJF1uGU13cuFt2o8ekW5FsIfhSR1EiJvy9H87LF4KiZ84LBtgz?=
 =?us-ascii?Q?ZLkesIUj2HlV5aC/E8idmlD+pCOQ3BZ5AgdahV6r8A/gdrgwoeboPscVC3kE?=
 =?us-ascii?Q?LNLj9IxQveYD6SofQ8WFrn6hUrw/?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8038a022-50df-4ec0-c495-08d98d61dc5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:22:49.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mkacykn/rhA4PK2jA10kstYTq15yscanL2dqU97MWtyFnjJSNjqRO8cmpqAEdbh5ZqhOWvVEMGonKMrrj81oTGlx2+l8j5vCBCFRUGTDpZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4495
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two small follow up patches on top of 1bfb57f642d. fmt-merge-msg needs
to load gpg config to be able to verify merged tags. load it and add
some tests. And i forgot to adjust the docs when we changed some
behaviour of the original patch during review.

Since this is my first incremental patch onto a next topic via send-email
(not sure if can do this really via gitgitgadget) i apologize for any
process mistakes in advance.

Fabian Stelzer (2):
  ssh signing: fmt-merge-msg tests & config parse
  fixup! ssh signing: verify signatures using ssh-keygen

 Documentation/config/gpg.txt |  4 +---
 fmt-merge-msg.c              |  6 ++++++
 t/t6200-fmt-merge-msg.sh     | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.31.1

