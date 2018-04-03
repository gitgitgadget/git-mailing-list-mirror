Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B368D1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 12:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755470AbeDCMB1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:01:27 -0400
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:22187
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755371AbeDCMBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MYkCmeZQvi/Wm1NHQcev7LSuWGYllycqQLzRlcWzkaw=;
 b=CNHnf9TVMmFoo8mzi4oZgmMfc2JuNSrmRfx8nKT0G8cmnD8450fAsq3TNECjRxlZSjrR0+i+LPX/Thzm1BkBBFVB5g+BWoaG4zloIvF9qxJSc2qV2cZGUgfADlVHpsMnqRLAULlFgSN5YeSpBhubpfjN7tuCCfT32i5hgg737l0=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 12:01:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/3] commit: create get_commit_tree() method
Date:   Tue,  3 Apr 2018 08:00:55 -0400
Message-Id: <20180403120057.173849-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403120057.173849-1-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: DM5PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:3:37::11) To MW2PR2101MB1019.namprd21.prod.outlook.com
 (2603:10b6:302:5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 322ea3e4-1e6e-4e88-aa04-08d5995a9ded
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1019;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;3:7V9PJzB6Jdr+QOYpxiqVTQWt14irOXCmeWtufZmPhgDDwTOE5+V7UfdM+qEuX3eWOaxNZL78cNCsxUisy/fICdAraTwrvlYj+ENRE+EesrQuP9wUJ4YukkUgJCP7dgNBkISiZNXn80jCUD3RO6khtGAFjfbBzGSdRZbVpYyOoDIUs0MONYGrUz4g8VwLvBdd1Fu80YpYH6tlm2N+qBTiHhMG+SVhoM1Xa+e2mu3o+bfs2AdvyFCH/LmDbqw1baqx;25:PXSwMG1isrL3ouA6iD8OuTZ84J1pu4hT7BKFzKGRLcCDcDRjQlOb2XXlhneCoX52PP3e3OXonCN83cHgNpF8fJ4j9Kbwao68tid0kLt+DqvmvLjl/DZJCZNzqRP6hBB2UkY/xV/6JJeACn0lp3H676HGwcWDzBu1GILHB6Zznycvjg86QP4ZnD1JR/WRiB+9uVBO/pUUvXiOWaSfThA8esrOnbCl9d4Ze5NmE7Lbnlmc/YUW2z6zQlN1zLQEKGmzTU4r1zM54pZvuD8Y/U5dp1+OAnwsZw08KGh+/2cy21w+w02VBp0P7oZcvBwdZJWKiuNXjrUseh7UqQdiSjwAHQ==;31:9R8uCLfmCyR8c7SQ+rCNGsXZeKmNgf2RLW7t5woUDnBKI4FZZrUTD+efujTbL35IZ6p8Z4sUyl/o3Ba618uO092kKakZUzsotSLr4W7QenyHAjez1H0xnlV95Ne818l6wmBtiEKnBZVwBRvqoJcZgrjqft8L+ZvMximEeHlSzhzvSNDxNrJI2kNqwEkQ8bDgMDb/Scc1UQD7NW9UQjOG7fYLsSJ0arQUW4bVyqryh5s=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1019:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;20:6JT6KYfiiN1u47cGFwZxDiHjgTGcYSPkOKHbJ8sVL3O4z8n34XP5NU36mGw0jMWGtGjyWU5008lY1FOMu5E2+V+PVxM5rW2J7BSy6JQKmqHNQiNgfT8S7dz2xq2FpUCy8nGD0H9iJC1AqpjQSWrIH6FzP30J5VMZOGxUTbTXjNaj8WW/FxyLI/Z1z6EQZ2q0/8LqgzmIn0zDv4nNG3oEQV3QzpRhRtBd93kfFvXMFbrcSjTNmJ3HLQSx4EsTfTA8R7KxSqGo/V6C8y439uK2FV4tUaWiE7czrE0bm0dwMGc25bxFdoX3kO7Pl92f7GJirdnsB5eSm5jVJnTYAodiHhkkqPhiARI7kQCGt9rEtAA1lxyxy/ktk/E8m9IFftUqgaLRBEFys9bZ0vjA/PtHlGRLHmCjTy/shY8D01i/mDaCAtYl6tO59KMeqPIMg9w2FfpTziD1+8zsTDAuuZ+V+yDM+mTl/w784skKZGRzvrXSdt2sQ3ZBSe0MVkj42SWC;4:EXS6zOoeXyN69w+0TsMuLirvOje2wytApqnnwDfGZQtO+WA8XViHRgDDWJVipYhwk6Mk3m9jdrE3LJ1NttxvmXKu9EzdAa2UGjSvcdPDmzVamSXtMb3xrT0MQTySgiV/JZjNOOoJGd0QiBLoSbOyfVrr8eLzuFLneoK6qY9G4xhFVOIzBTeHHwQlmmiack49qe+tDGNXx6FckoFlcPyWpBfXoQYiZfIG0WUP9kTvh9EuyKwFscKcnfNokikxPO3j0RdQbRJ0zd+AXN/Ri0xRox6882cObY9SiyKXGgGFsEG7dpOWsl9HU6t/tr2XgZzPgXlEM68GToXVzvQ1tKqeoKXoupL1mpoNhYomnVMuubY=
X-Microsoft-Antispam-PRVS: <MW2PR2101MB10199F46809FEA9B86E2A4E6A1A50@MW2PR2101MB1019.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1019;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1019;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(47776003)(7696005)(6116002)(16526019)(1076002)(52116002)(50466002)(476003)(68736007)(97736004)(486005)(486005)(51416003)(11346002)(25786009)(106356001)(186003)(6916009)(10290500003)(6666003)(76176011)(52396003)(386003)(305945005)(46003)(7736002)(16586007)(316002)(86612001)(48376002)(2616005)(50226002)(22452003)(478600001)(36756003)(8936002)(81156014)(81166006)(39060400002)(2361001)(86362001)(2351001)(6486002)(10090500001)(53936002)(8676002)(4326008)(107886003)(105586002)(446003)(5660300001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1019;23:s8ZaCXRSjg3DAPRWCSz2Ce8+jRhK7WePlecCV2o?=
 =?us-ascii?Q?DKbhujYMMgSC3488Kh/ArpO2jB3FOOxSLRroB7c81Vaqig4uLo/+1PtoCfAg?=
 =?us-ascii?Q?ldxOR774XNO+uC2hUasmmbEkiCqsosqRo1XQGOLz4QeLzPIsmXXd0L7d2cyJ?=
 =?us-ascii?Q?bZJRbABCQlPTELlywPwXmMFqKLdts4LFgKDrPW262bFuU37nNB59feuag1s1?=
 =?us-ascii?Q?Nu7IPOYk7XLoj5zKu6KsRGiIOAIOnOJjaTmDstI8BT/+oHoH3FL2yLSJWIYA?=
 =?us-ascii?Q?EGsHsMYFSVcrdeNjj9JbLI7dvRYJiaDJcmqXDm87Js+DXlSdSwyaXPq+lhN8?=
 =?us-ascii?Q?r00MzXFCXcs+SKJgs1KSKOLlpXmnS8U0K0Recla4bH0hSRPPppeoPyv78Gew?=
 =?us-ascii?Q?AK/BFzfYHk/saE/uSLsUrGniSEiEX0Yh1kCeDoDdUPI4VrVCP4EH70N/Nh8t?=
 =?us-ascii?Q?b3ZhEN0loSa6rlhzQSNeX17luNpjb6hjg2Byi5qLoxFx+eTyVjLb/qd5O3dP?=
 =?us-ascii?Q?lpNdKE4bM6p2nR+xnX/wFxB007FUkZtLNJaYPycP/eEQOAskvMlFKqrZBIH5?=
 =?us-ascii?Q?+pmqi+1zNxuNfeKUuDEQK/XGe657U45XHIEWZOVRXfeQGoq3SIlVbLz0Opr0?=
 =?us-ascii?Q?t0qwGKxqozVJgpXyXYk93zTNtSUWdholeJxD48rUxdT62eva457oFyv1ZsfU?=
 =?us-ascii?Q?l1xlI6Yf/rDg9o3HuU4D5dSKq03JTi2zS5c8MurxYC4NYBfimc7xVfid/Gu9?=
 =?us-ascii?Q?YV0kuVQTB4/xBoxBZqts0dlDBXj7/DEgOY15z4+bwWB5TXt+YBFzvb63LxCF?=
 =?us-ascii?Q?icFT9VsXoWHnx76heBfYirKJK/K0MJySfc1YwcDCPAJeDe0BcCpK8Ki3XkA7?=
 =?us-ascii?Q?hKOcY/9uJwdsg9djjenimSvlqAW5Ivk8EpkjpeGnuFgagwlC38a1hL5acswl?=
 =?us-ascii?Q?t4HcQzTHjyuw2DF4kfI5QqdLOhocQxgeYbbD+sWZPdBuW5+bjlukNgtp6UnV?=
 =?us-ascii?Q?M7lJD7X3/ZWO4usmJNr2gsZ2pnSUA47RzefmeyaG8NWPH65KRuT/pHKjZmjN?=
 =?us-ascii?Q?iamijmKnMpAVIpyoBKNEsABakTooJ7kCpW5fPlOGa2u9Xx+AD+0LlC6tYV2E?=
 =?us-ascii?Q?O1qFlqyOPOwGUjplAF8O1HXOBo1B1vRVS4OXYg7WEwgluNDWvaSj4HSa40o7?=
 =?us-ascii?Q?EWCq+BZmd+TgoHlIFYlgYxO0LjHegwLxlfdevYCGhLBvVgoKz1yOYFmiawzC?=
 =?us-ascii?Q?RSNh3Dw1LivptzVn54i/ngsG5VibrlvNME/JQcWTA0W2B+N5TidaNNuboTOo?=
 =?us-ascii?Q?+KsUsRjGMbJoEIIvQm4TOYzZYAqF0i2Xyt8m8MNplaX/X?=
X-Microsoft-Antispam-Message-Info: JhWjx+aTKFAdsqBWZbii4Xm9oGIIDkw2jD1gqkk6lAueMHeMwVLkkQ2Yb163KKVJZlI6pQ3ahXrWNtU2qnVmXVtqQRx1ATIu90fXl9LYYTENLFUY6o/oPQgA9wk85X9mstC3MIJ3Cxcfoq00/GF973R2iUghuueLuqrJ6NLN5WhjwDYrDcKr58O4L+i3OCb0
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;6:TgiOXBkW7TyOke6mHhKI1yBapJArmxlYSGDb0mwoPPZJ/rP5zHopZD0YwXNb+gTT7VhaDMIbWGh49rSkwZwo9Pak3vWVrjA3C2xmGRBkBFTSd4fQt+Ke+CiYsEqxMEn0SfBKYgZTWzHWAL4C3iAIjnIOmmXv+of9aYbqwG2l4C394ZL2MIcRAJRluWK6gB0q5k6DinOuLjnXjHsLDqkFJ2J7KvbS6qPhufFKfZZM7WlFo7x+oLua4gh+rUkIbdNXzEckdoTAzRSLnmSCgnCBNMggCaqPt8axN9vwmNnmV/cRNJPwTNmPPVmFW1IdD2+aXW53m2cvjkBNvqDh1qgEcvNjPbpGyI2sBHHu2kTH5bBCqgoeiVbfHLYBm0dhnKL7QR0cyf+ulC5ITlqJ1o4wZvys1h5SzF9ebtwuSQdLJ/8M2Atj9EZat71EvkMvSVjRR9ouur1uJUuTi9kfNs136A==;5:hVIv0XOEBh+AhWOSdgxhXL+e0+4Zma1W+62ITSf+3jRQb38aW30Gdth8rOUNzGbBsvMsyrt4oOMjCvsREZ9xW6cq2aIs2h6hlrm55yl4Bw13giggUv4+gpIslMuKFuzxb9TwH+hVEz8tfcwmF9qJQZVXSNc37p/6Nea/TGFg+eg=;24:u7JtSmLZOV1Z2py3Bk0s8RF3dQ58pQT7au5G6x0xVhC2kp0LL+Brfw5PaCzztvplqF3Xza0NNloXuQs5XspocURh33VZsNoI9a206jcRmpw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;7:+YRpnjEA4zml4p4mbGzSwBjDrmK5WE+ngBAMA5KikxQOyl9o5yIJcoL/pn+r/NpyPYiU6JymztC23n2DJup4WiCdQR2pimt+y2V5uM8hWbZ8syNuBd5uZsOT/2WIFlzuH8tTbYUXYJwle74zcZqc1kxknrPlyjMpW+XH0dYB70gQ4pzgxHzrtfF6eAkEPD0PFg74F/bQHXBWJF28z3Z0DJMTPfj+CFe86rFK4rqTU8SfuSpACYMNShOgTB/e9dF7;20:FRsLx/fq26iUKXqwuVu7rLaYhxus4TEii2u08bUfYB5sJEF0VNhscSEUdjEO0az8+KaH8ySdFY7jgdtOYrRJwNBGlMIFuDug3cIW4Vx8zw8U2PhW5qdStN09LU4Y4Guc67yElVPELeTMUlgFlwKq34/pAK06y/cPBWPeo930Omg=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 12:01:21.1779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322ea3e4-1e6e-4e88-aa04-08d5995a9ded
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While walking the commit graph, we load struct commit objects into
the object cache. During this process, we also load struct tree
objects for the root tree of each of these commits. We load these
objects even if we are only computing commit reachability information,
such as a merge base or ahead/behind information.

Create get_commit_tree() as a first step to removing direct
references to the 'tree' member of struct commit.

Create get_commit_tree_oid() as a shortcut for several references
to "&commit->tree->object.oid" in the codebase.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 10 ++++++++++
 commit.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/commit.c b/commit.c
index 3e39c86abf..d65c7b3b47 100644
--- a/commit.c
+++ b/commit.c
@@ -296,6 +296,16 @@ void free_commit_buffer(struct commit *commit)
 	}
 }
 
+struct tree *get_commit_tree(const struct commit *commit)
+{
+	return commit->tree;
+}
+
+struct object_id *get_commit_tree_oid(const struct commit *commit)
+{
+	return &commit->tree->object.oid;
+}
+
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
diff --git a/commit.h b/commit.h
index e57ae4b583..fa79cc4d1f 100644
--- a/commit.h
+++ b/commit.h
@@ -102,6 +102,9 @@ void unuse_commit_buffer(const struct commit *, const void *buffer);
  */
 void free_commit_buffer(struct commit *);
 
+struct tree *get_commit_tree(const struct commit *);
+struct object_id *get_commit_tree_oid(const struct commit *);
+
 /*
  * Disassociate any cached object buffer from the commit, but do not free it.
  * The buffer (or NULL, if none) is returned.
-- 
2.17.0.20.g9f30ba16e1

