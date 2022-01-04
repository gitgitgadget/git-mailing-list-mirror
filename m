Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A5EC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiADMtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:49:36 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:26048
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231970AbiADMtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqUb9fstUuahBK56YWmiaNaeY2aGnPrIG3UUMy1tNK/lu3ApT7/Hki7XuBXZZUuexYlHRtjH1jMNvr7KZ4ynvLpTjs4+TrSaAfriYFAvUdYXDmbT4zVKttRpVnl5R33oTFBTGe3SceMVJICjaKYyRB3QFfqaAN9dvfHhybrIwHRtO6y/kdg4qITB5uwlUpsKWOeg4PUk8fhk83N69JKpiogdyp2Z4Y2/BailtY0Ls/Warp6fIL7lXC9NiutlKoGYt15Q6lObcihkGWmKrJUFWrqNgzYla4440geurbhl0XAkCozrWi0VrAZ7B4Zv1N1n3EfOLwI3uDbZ0DD4nbg7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwFctxm+7eX4fXfGdW7IIJq8ITJwwwJ2Qz5mbTLZIV0=;
 b=ATpy2Dg35eVW5GSCnBz9XcBWi3wLi/h0Q6cnb3KVcabmJzJSzCv9ehINdwSuu98Qp0H6yUQbLBNfanfx+pBK9SHMjuojYPk9d/qy64R16O4Wnix770fbWUkcamOFFtJmbKa0kQgYnvU077RuJutj8FrAg6k5a+Eqzds7b+tO65kBkIy8JbEFiniVYs1IMsbiFaYjPRI+RnGPlpTzAno52hAFrENkm/4rbUowN4f3vLgm5UUupPHKcnBETL2ByG+e2a1Njb+46kXyqja8nxYuMfQIfMthyYHESxW7zYgwYmR9B93KTsQ7quvEqXlBhEa60R5oL6rRbp2kdlyosg9gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwFctxm+7eX4fXfGdW7IIJq8ITJwwwJ2Qz5mbTLZIV0=;
 b=Yborf+PuQf3TLDDxYR6kdzx9jYc/IHH487WLz8QQ5ndt22EfJTiJSRS5aYdVvGHPQj29yg/auBk1ijgIvpw9OtsQrlh7X+nM0+llqbyiHFl5D/8JKLBclDX0sKBu8kn7keUfAIAXTpVR5rbdxDSjifRXxI1it9hXJPLuy7UFgfTR0AvOFXQxr7GK9gyhkSdWd9ycYZdchpScKFwRcQnBl7kSy94VCBWqvhM9VR6U5o8BDSMq5TdcKneqWomd9CwsrrKK3BimJcUBh+EzXYA/TImxE/L/wsXLimqmrHklKbeidvVwIzaPXw2GgFkFSoRxn2yp90/UQYLED5m7ohun5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:49:31 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:49:31 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 RESEND 0/5] git-p4: fix RCS keyword processing encoding errors
Date:   Tue,  4 Jan 2022 12:49:08 +0000
Message-Id: <20220104124913.2894-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::19) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bd018c4-5e44-4423-9965-08d9cf80a6a3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500E4955060B5F950159B75C84A9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuDJx5DS61ECNROnsmst/4nnQ7nTOdhg+TGIeJM5EckHPGJ4v2gb9BAFYAu9gvFXUKCBKtv8HL1gjPEpJv6pMa0bsI2eANrXryFQ00DT6GNtmVY1UT4jhvqkEVq6P00Wbb7GkfNhk34YUnAXqZOCVy1UH1xHZA7bdch+JHvLoqEHMBAISG/C9tz0ddIhFWYTP6K/wrXp3afASPAr1woFGfL6NwyC/j55CuN57EL8gHqhCFzV74+aHcEflH4vAiVlki42cwecZQQMo7FK16VD26HObaHWDZGhghwbHaYZzNTS0cLGBa8FhIZ73SVt/6HuFCsDGiv+Cr2EzqRjWLzMS1WmgK1pPa2WVWmU9PcAoJaC0vEiuYuLH2J4fXbX/cUc1RhnxVQM4JjAzo/cMMpNJTNb2YO2wTX0bvMoNijazekpd71mNtxmEwOimXXizHiL6S3L+1BpHijI1iI/ApgOewK4i2sF+O2eCuAvGGuryHtARDQmEzlcIiJwee0VN7l6BI5atYiebdzIVTRdmCBUnrdhm2PyMVpYqW8Iz7raBL+5lBOhXe+Ii/HsL21a1TTwO8UPvC9H0T4NnuDG+LI4QmESFXtuVnQxyEgkTM1yRR6QOPRMy2ZbXa3tHk/zPjmcAqL19eiA2AjGjhkELln5IE7ogvDVwOH2uikfQJWjcKkVzPWCcyjh3qKbLVOv0bAk7s6m1QK8KAy/THfmbomwmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(38100700002)(6486002)(110136005)(2906002)(26005)(66556008)(54906003)(66476007)(83380400001)(4326008)(86362001)(1076003)(36756003)(4744005)(8676002)(6512007)(186003)(5660300002)(508600001)(6666004)(6506007)(8936002)(107886003)(38350700002)(52116002)(316002)(55236004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4ecNHWn4FnL3mOmjyibrt61MCOlO2eckJeDtUyM1r6q4PBBl36BrVeBWxpV?=
 =?us-ascii?Q?WV3muPPdhh0pu9cUjTDDlHc0NATEm+4/8FAEu44tnz/kfYzg0+iunZku4c8A?=
 =?us-ascii?Q?HJriUM+U2a8GGLmHVcGX1wb+iqBY/NGaEYn6zhOKmTPdXftkyZcIyvOXsYwD?=
 =?us-ascii?Q?unHK8WJuf2LnUnjb6Vy59UviTbnf1NiquST/eTZJReETd35arHTfwnLC0YMt?=
 =?us-ascii?Q?jkBFDiSI7DC7XnyW1pvPXJ+N3tj84RoMOl5hXJhbr25n+tfIWVmeb6N402Vn?=
 =?us-ascii?Q?ZFtDKUObCTI1VRHCpkEmZHx1dLYBomy8a7/ONKSPztjQHy4PlSTztmuUq2Bw?=
 =?us-ascii?Q?KM2gcWPRX6OZ/LF58aXbsIHuVBOvrjbzze7ranXCpIGZiRBlqLSlz+km18ry?=
 =?us-ascii?Q?GTeSpqKrMV5m8SMcsPNQCCT5QHkBGhcM6Inq1dMFlHoNDSbJLLlvAfFhN3X0?=
 =?us-ascii?Q?leoSUqSmq5/YbtIct8lwQglOKH+gK3kqP777ik1EehopuAKHTril7RFMHet7?=
 =?us-ascii?Q?BTUM4wTiHR+DGFbDQUN13gAZ6kBaB5xKI4C9LnqMqjp3Q6C4rX5p4l9UlgBL?=
 =?us-ascii?Q?CYm695cHhlQHbu10AIrMZv/RjWINUxqKW3pAR6qfHW+nhL9pe2KgqPVoRCCT?=
 =?us-ascii?Q?zIwcmGpjbghDFX83VeSjG2WAN6Z1RzXQmKWyhCYPuLmbwYPHJ22xtrp8N1wI?=
 =?us-ascii?Q?PKSzNNGTQdd1t65+KotGow2LYIjTx43+a5HVVh32U2BcWfgwLAl+ljKZ08By?=
 =?us-ascii?Q?AjVkUa+CoO7EtwlZZ3tNFBh19AbG3rPipAj1Zj79j0iO0oX2zSK+vU7F38HC?=
 =?us-ascii?Q?1gdLTHEeKAVpzAL3Jg3t8OzdrPoTeufSH0uerlcD5nzLgJVEOo+mgAgiQDYi?=
 =?us-ascii?Q?xgz/Gehornk+mompiaoHSO/orz2INa0L/ODOblKetUUu08t87pWVsOnKj2SB?=
 =?us-ascii?Q?f558ARDe+PK9Ns8BwUveVrXLEK4GHonxBHABZH+HHJNNZ9fNqT1Z0ZFWjvQJ?=
 =?us-ascii?Q?W3mxVfFf0i4iUsCGpmHHWWS2sRlFQZj4aSmMYwNR6CfhnMgZ6Ke9RUMpNrOQ?=
 =?us-ascii?Q?nUpnNPVo5JwXW5Wsh51SYRzG9gy8RRJtiKaD4bI8vClKT1TedBeDcHr9A2z6?=
 =?us-ascii?Q?Ti7E12+uwkRmbwQvNU//Z/Nlg5rhmnQ9c98ksYZNc+uh4MeKFCZiI6fvtFOM?=
 =?us-ascii?Q?b6M44RYmm8fXjjWTSt3JO50JcRXbuLHuCOHvEzPoV/7lXt9KTOYiHZHk4ryZ?=
 =?us-ascii?Q?zAi/xpK060Fmyh6IN1B9CeC1Cjxpdebdxr+ZYDr5HrMRcuyPGCYAenZ1FxCq?=
 =?us-ascii?Q?wjPzmZARqJ16IKlprCHwSv/wn5pp/Idsihxh58VYDIrCDE7FON246voZ4uqD?=
 =?us-ascii?Q?6ADBP6cfmoVJKmgPAsASt8pJ7B2/hxBqQO/H7wX5YiPBgXrXBKAFJ1pUu/P0?=
 =?us-ascii?Q?voXRa4gNzl5DqBkhRC4bARwgek2iSgoj/JAFiBrSSY+aOsVuCqZdW9ZTseNx?=
 =?us-ascii?Q?/b0m9O6ryS6eyKc2+jIx+Aqil236cuZITCqLdf5tAmXbxNTVfrpCX2qGtY8W?=
 =?us-ascii?Q?8NfUMd4yhMc/iYNuPk7hF5OFYQeZbutVeZ0htLQe1/AQROQGoulxseVWF2gS?=
 =?us-ascii?Q?F6PLKVYTpKDJWvPQP9ufvA4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd018c4-5e44-4423-9965-08d9cf80a6a3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:49:31.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA5MvtkWY7++8fKcS1PfXxYgoAKvJr2XFEf+kK5MeTUDi+zPGJ7MuUbu5HSfEsA2KDwGWiL8VXwPRwDq5A1xHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set fixes a family of issues with git-p4's handling of
incoming text data that contains RCS keywords, when those files contain
bytes which are invalid UTF-8 codes.

Among the patches is a fix for the issue, as well as some peripheral
tidy-ups and improvements to the existing code.

This patch-set is compatible and has been tested with both Python 2 and
3, and includes a test.

This v2 version of the patch-set separates the read/write mode fix (4/5)
out from the RCS byte processing patch (5/5)

Joel Holdsworth (5):
  git-p4: use with statements to close files after use in
    patchRCSKeywords
  git-p4: pre-compile RCS keyword regexes
  git-p4: add raw option to read_pipelines
  git-p4: open temporary patch file for write only
  git-p4: resolve RCS keywords in bytes not utf-8

 git-p4.py             | 66 ++++++++++++++++++-------------------------
 t/t9810-git-p4-rcs.sh | 15 ++++++++++
 2 files changed, 42 insertions(+), 39 deletions(-)

-- 
2.34.1

