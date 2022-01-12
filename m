Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3773C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiALNta (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:30 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:40385
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238942AbiALNse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:48:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6ZNou42aRgZnMHF/tWzZGVRZLEVwVvBVFNWA1Yauo5sG5peT6GvP2SVUA9GUIqugu26XDlw5ek8kg3aTWxOQxpcCNRmE8qljJyQYvhlpOQK1I13dMwwisrN44zphYc8q47N+qA7wZq3HZn7DPNaZFZasIO+jmZZuayoy2ERwCqvHIVMydQwW8TUyK5a3e/Zv6VGvNMXQHuEmo0iESG4ABRcTiff4NgeHT0ce53ir3SlDOF8qw03CHLRCBhmGFK6XLR4zzeYCUJO0dhtFTkahUZElmt4QC3qW4iG2p+y031bpkcpwArftih6nV57Y5Tl0j2VYhvSWzfTR1H8Af6WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bli4UoNcdCpTOEyiKH+QpAYjNgFaUYRJqS6RR0EvHnU=;
 b=mXMeY7CTjkj9z8a3RH2/uUXrm3n8GkyKOxZjgSo/xZ7LRvF+hzN0j4Nwcn+4MXqxiAHjQf1+s25vtLn0Q9O0K/Pbt+dq8vcBE3q98nBVtBWim7H31cfDTALaWEX2vabKHfauapeLI0UMJk83J5IQg4rRcME/PhZaJKTPL3rUh0bJjdVMXhMV9Puow43SUiVWpFBlsU3Y6rKR3VhEjMMRPIlBnqzqll/2HWJ7+dS/Rd93+P8lLV8z3MVLC0IsvlJ266j2Hod2HCLa4oM4gzStc+MOy9aKK3YTuHGFdtccAKhWMmhilnhza/UCh53pdyjES7J8XwcJ1BLkEG63WAwcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bli4UoNcdCpTOEyiKH+QpAYjNgFaUYRJqS6RR0EvHnU=;
 b=XRrwcEpnF2hLVHF6BcX3+GBvWKwAABs3mvebMQOTQ2bAbePOZCZKCwZp3tGcvJX2fd2LZ02WlO5b52trOklJT4o6OzBPwJOsEB+4dTiuhAjsWFGtznO9OuhmjbTlKsMfS86POX7rQt3WvD/LWltqjAkF8tby8QTtnIboN1A6ydqQEb68eQZPJ3J20tUbr+6pwQKflM8xbtVoX/SvnfN/vgXK7yFlHuK/hQ+w6j5t1ForvZziuYpnBCQcfPaCOoInn8bDkywMx5pm+UxG1cPCmhd4Mg5ob71+qglPVbyXhVJaUXkDPHdFjqwExlwuaPdpQEk9XrRtIMKoS/BSRNOdLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:34 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:34 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 13/20] git-p4: remove spaces between dictionary keys and colons
Date:   Wed, 12 Jan 2022 13:46:28 +0000
Message-Id: <20220112134635.177877-14-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a3f8704-ec4f-47ab-df1f-08d9d5d21621
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594B5C4F9211496845D62B3C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qS5LllIJ68ORTijcq5mwxRwXMD3y4EPOxHsqSFEIu0PcbWikBPi/swtaHE2m+CZfgPDxbWn/FOJwxHFP7dvx0TAreJVChYD59/Zl9cpp9EzI/y5nzM2dWRUCiiEEzgCic7krTFbk8gd1wvuwhoyXdvVQjvyeMfCh2Kb8ezP17oVwnFayGTv9+w85m/40YaBAlJAYGFdQrabBDhchfrGedFYgbQGY+iCe4iTBOXtfcAto+LaWdg3pZvBz/2hpBLDc6AKJ54CWbh6Z23EjU1QdcxqgjP4bal9tbuLJELhQYtcHVM2Krmzh/GAbkBvlVXfEDnCKbFPn1NuThVrGPNyXgmNBK1dSOHSFnYzxM4m8VXU/ixpZJLxaomlb4IYAL+sjA3eNP7mqa/4SwkVc6yWKQdbkg4/7Q/Z6gPsf9tzK6iyqEDneTOi4YRFeb9YdbWdNMD8QBCIFAaJZWJhUPKSsfp6ScihbFR0BLOrFtKGdVwipczLswjUCXqPrrg01gqpwdMbsc6CW6HUcY2E40MoJvEzf2ibyDs5D+xzq00yVTa0BWg869PjU166bfJFpBFNAbDPyTOEp6+WYCEf0janUKi4m1ijFI7jSI5fI6AwLuuCp4bqwGmjPBcSogzn3XJ28cx0gAi/x+LuUBkvj03dRYtR4MTcBSrV0WDWhShdcPES6M8diOvd8l0cMQAlH6CXE+H7zyNqai9aoI5km+9jaQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(4744005)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIB7VykQav85Efs0C6HIEYF5U2rYrbt6846p8x2mWlzy2akPst5Dax9WQiz1?=
 =?us-ascii?Q?ZbCYpMehWb0giqbHcHhzo85XifQ5etMZk9T/5odn8GoVVavu95uV/LEf5ivy?=
 =?us-ascii?Q?MVF8A2ETAK4SJUAxJq4z1wDEWCp1Br1mkZmLxVBapUW6hyMOnEavxRGjCaht?=
 =?us-ascii?Q?41hdqhG6FcjDOg9smu0oe23vWioWrZgZksuYa104iKNTfi5B4662VJIX5xB4?=
 =?us-ascii?Q?rL3p4eKSFRbcgKrZQtctrMJ4eKpynSIrfw0xF13YAOMqqPHu0j+hkz02UxIA?=
 =?us-ascii?Q?qcqGSWkYRIGqqGVHGiZQ0B79zYSk5kvX1d/LTxh0X/j/4ivZpcmWgFOanRZ0?=
 =?us-ascii?Q?WODtmCPIfUyVMfGnEIss+Xd0SSVzDJoIUhCnZx1S/VUYeeOBzp+DHucDgz3O?=
 =?us-ascii?Q?FIhGUccBXLaHaDXDBaVOhKiDxRhadvi/vyi/+xnR0COGUApZVFtOEtbMjp2P?=
 =?us-ascii?Q?p+ai6Fv/qbjJAM7NMsDrXV6lypwBJTLsiAcFFY1Ipwk0Nbn1U2jR5f9tb0Z5?=
 =?us-ascii?Q?/6zu1BpdYgYva2POjKYNT3D6WizrKDFcF7oFBcU+z9ZMZLhZDGeh+zWgu3nT?=
 =?us-ascii?Q?3ann02Zo1Hsl0XVus7d4oKck1vu1vonSvvhInk748SxqEmrlfOHv68dl/haE?=
 =?us-ascii?Q?iGEL+QA/BXPXLB6dWiZ9orHBx7nMd4nnqAtMgc64QMRhLFPL52TpQ8Gu3Vpt?=
 =?us-ascii?Q?4LFzzy0gcSULma9R+7QMH8v3Y8cX5vGu24AaQQu9KETbh3vWXRkCQx6edWQv?=
 =?us-ascii?Q?2HlVXcAYHgcusEtiBBo5UnHjh3GAdc3IiurIHH25LLfsn++yWM+whLKFe/6S?=
 =?us-ascii?Q?Mt5JRAVnuqxxooZl+cJ5d2LgA1iMnJeWbh3NcdUyjC1FI9LyujP2uI9c54tP?=
 =?us-ascii?Q?FPliGiGPWanN4+zjdA8kYzGNyD5lZKvHwxXDXqW4oTRBlh0aOq2KfofD8mhf?=
 =?us-ascii?Q?2CZks94un4krnK/79dHzoEf1L9m7U/2GqSS5PvQiovKVrNLySyNbc8jSGOdS?=
 =?us-ascii?Q?MRjGXgud9GySp7yVg2bVCFvgSh719cjy3U/E4K9Fh7Jm3yhXup1bTeBUin7U?=
 =?us-ascii?Q?Rb9bojUtx8X6/pix05o4AEG/JdbuUTWI0HLNZn9fLH2kYcjoOY2+NxGjmcUK?=
 =?us-ascii?Q?QFhWD79uIj15LXz1o11jFQaYa+t+byelF1VodU9zhb+2PkfODTNn9+dole+p?=
 =?us-ascii?Q?JiczcDcvdj0QcA8ErmsBf0TBrLpcjC5e9cAedu9u8FhD7YChB0IED6gFtOe2?=
 =?us-ascii?Q?gzCXV71wWo2OW4Nq5xdhKDA5Kdnkfzd43K6nyPfvEhcMbZh3s0cDX1ffjq7V?=
 =?us-ascii?Q?8OtfEqvZCn3coR+pCk56ZoPqUAUxYhIjAWgqnYLA1MAg4MpNH5O8d1csOyEv?=
 =?us-ascii?Q?Cd5JqP2OWrIeo8HgGyp7IRwhFYfurj+E7Y1ZYmR0M09NFCHgIC5uaLgP9ORA?=
 =?us-ascii?Q?mjF5iu1VG6Sc7r0He12L/JONzdgDd+H2kY6tOmFnmQONvV7vIqpgNntNh/sx?=
 =?us-ascii?Q?cs/OvT7SdDR1fwT9SeKk+cq2pp7TxkCgcqlK7ldBCovu1F2T2zQCd2wBJyZA?=
 =?us-ascii?Q?S5qjbBwoAiXXCy5SLmJrN4Clu/KTutF+a7e9XAAS+AqGYUtYtaznL0IOruXw?=
 =?us-ascii?Q?UNOuZeS9Yt7rAoHJB+0wWEM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3f8704-ec4f-47ab-df1f-08d9d5d21621
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:34.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bm+Cw4tzN/lS2LrxNVWG7wxhlX+hNdX3vR18USPSxj9Edc6eX7+eUXDZZDCNZzfDmuWW5pYXIqao7SXPsNk7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 makes no specific recommendation about spaces preceding colons in
dictionary declarations, but all the code examples contained with it
declare dictionaries with a single space after the colon, and none
before.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 80101e02a1..7bfa282f7e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4451,13 +4451,13 @@ def printUsage(commands):
 
 
 commands = {
-    "submit" : P4Submit,
-    "commit" : P4Submit,
-    "sync" : P4Sync,
-    "rebase" : P4Rebase,
-    "clone" : P4Clone,
-    "branches" : P4Branches,
-    "unshelve" : P4Unshelve,
+    "submit": P4Submit,
+    "commit": P4Submit,
+    "sync": P4Sync,
+    "rebase": P4Rebase,
+    "clone": P4Clone,
+    "branches": P4Branches,
+    "unshelve": P4Unshelve,
 }
 
 
-- 
2.34.1

