Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE8CCA481
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbiFHPaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbiFHP2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 11:28:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75116A512
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 08:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvJHIQ8rOszGrKZ/EPC9D0hFoLB9ZQrBQjwrAEwj70V62ONS6lhM+WgLzBN3rMhGmDy75WO9UnYAbptWw3juUf/82A8SK4n538medzqOJSL9mF1LptVCFPK0XIom+4XutSqzU5avqyDYfI69KT6cjTEfDssYpP/R7nsGVYCljrKLiX4Mi+evhSIB5bHc+M6GnHMrEP+icWSxlo62NJ7/S+Azxw93vtb0WBrwoZd6DwZ2Mc3nDKkXvWzYqVJAzX7U2aRDpp1X6xjcx0Xy+WTx06tmg9ZH2SwZaIvVR4x6npPvWoXMfG1VHqMFRLkkn/RIZv6lpt56YFcXnItjqaPfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZo6P5dXecX/54H1KjsLK9hTe3FX10eD3ss46DdfQmQ=;
 b=PQyLkMewl9DB6mCwoL7ArhYJvn9d7uMYcy/4Kl4yKLomKG4Yv34JHTpgVE2C6EbvxcbwMXJdKj6RnINmnqEcEdBlPh6lsi+G2WI36I2xdsJy+JRkaBt9hZcf6HBAscISWf83CmHKHBFEvh0TSPzp8ZQoQYxXVBEjSIX+1vktiGlyw2Eor6J/M2kBJC6RX36plDcOGHYQzDqTMjfgCbHbSV6oRB6bhDj8wf5pg4tPpEI9LFd/kQ6ok8RYjZ202NCjKj+aVBnkUiS5Q9Plm+Wxbu3Oi8Ue1oZyzG5Y3gtQTtmxgSDCJqsiN4jw8jVD4sdCCLzZulam2CwVJqaFwozZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZo6P5dXecX/54H1KjsLK9hTe3FX10eD3ss46DdfQmQ=;
 b=tB2WOXR8TMKQxeZAILfaQK7z8nmDkDr0yI8hpwjZYZ8FEra/0DVTeChuXgw1gEu1ugjTPjj/+yRhLFQqRqylAzEJZHcsLG4Gobhkei4W/MQjzUw7x1BxDQnTJeAbvAinGidwjCghDx8GLUyyG1Px7hC3I3nEWngaR6K1r+6ptR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VE1PR10MB3902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 15:24:42 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f%8]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 15:24:42 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Andy Lindeman <andy@lindeman.io>,
        Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] gpg docs: explain better use of ssh.defaultKeyCommand
Date:   Wed,  8 Jun 2022 17:24:37 +0200
Message-Id: <20220608152437.126276-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <xmqqa6awvp60.fsf@gitster.g>
References: <xmqqa6awvp60.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bbb0106-96e5-4ec6-e6d3-08da496302e0
X-MS-TrafficTypeDiagnostic: VE1PR10MB3902:EE_
X-Microsoft-Antispam-PRVS: <VE1PR10MB3902D11222121744B8263563B6A49@VE1PR10MB3902.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MW90jH85C0CrrCviNaVkjF+Ta+glwyAeiX4yCIyXu1MhM9166qZDhZEAUSGlvbmUCKdmn388sBM0GVB8XHbLSqPS0X3SjUjVky/Vs2uAhVj0goFVzmiY0/Cq2M4Y03Zwmjols4sxScGfL8mEgOZJU7WZ+cdcFXi7ABo7oSzF0fUgkqf3JoEPYFAX3wd+TEGH6Vx759jmKzCjwlFiiO+Uw2rB1Ffqgf3pGxqIy3mU1jVCulM0onF/ueTIT4kTm5VEx74Zr83Xq85NFHBtID3FS8BMjl5w3Sm87+lgCgV6l7+agrgtGLWnwUI6tlo1OsocGb5mGSlV6siseFQO5XlPbtjgkzOHgqmnjdzCp52StdPK573X9tg85JJc5lPRmQ/SDCz7KRN7GJFrhCbjWKkYRH2+Brk5e0SCI798lDYtJw9lcqc93QQ7l5cg76sBlrSVTQ8MTqkPViPQyHdExsyudo95lJPUt/fviLnadyuXcNkWv9aN5mpsPYtehdiGCEreF0U5eJKxn/adNZSJdlYnibfaU1LikqSAk4WHDGw5tfvGaldZwCXJcUewHvGLRlhrykz+9YmoDc9H6aSjUrM30OyYtEMyDZtd5DTu1aUNGE5HFbKszIRrKJfXYnNlj9sDdWSuY6flMN8+MiiXhyKcQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(136003)(39840400004)(346002)(366004)(6666004)(38100700002)(2616005)(2906002)(5660300002)(36756003)(508600001)(26005)(6512007)(6506007)(41300700001)(186003)(8676002)(316002)(66946007)(6486002)(6916009)(66476007)(107886003)(66556008)(83380400001)(1076003)(86362001)(4326008)(54906003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqhHsIikoDoiErK+LDedaY0rTdzIl/TXntor0zPASct+Lr87EqGFv+ZREDwV?=
 =?us-ascii?Q?Y6QnztKdecrwCkwhtFQUpRKZqc/92mMMSzUgdQPq7ky6Yi7r0nsnsx0X9bEU?=
 =?us-ascii?Q?yf2Rko41M/ivUBVRUSet9KB0dneYYQwDYGr1XU5fm/+zdhW99JXPc4SZGjOo?=
 =?us-ascii?Q?aeo2tfd5Z48IVwwb7HVIYNbPzPbdhfPOw1Rv7fcJ/FUN2y1bY5GTSDLNWJ+W?=
 =?us-ascii?Q?PutIx9lmUMgYqwa/I5SFtTKeJ3eDnMCBr7I09Yv/IJKUXcDHvoGmJtppvEp2?=
 =?us-ascii?Q?PWYlS1QdMRv5szQMLGFN9Eyut5PgUon+dfezO527E9sEF0MsMNzuNIay0yTM?=
 =?us-ascii?Q?8Su77RXLbKKKCAr7m5VK25ikm/UdiP2NsnOfGVfCbuExYGmj9L0+vNXclhuE?=
 =?us-ascii?Q?zgqNLsp71TwNy/4ZKClVPpP+qLcsLmHKFhpXKVMfToRyA0kgQaNyHtfzpXbe?=
 =?us-ascii?Q?t6VSKpVvkXRYZivhUf9U3DcmJkiho7qFAL3/chk8vtKpjpdtK7Tq9pcoLkem?=
 =?us-ascii?Q?R47ZTPw/qGHV+vxS9lSjmocvIU43o267YlrHLHaqu4tpzW4qtZoGfcjocylK?=
 =?us-ascii?Q?XkK6flGBzSzES/9uUTALHOWVIQbEIbhsc7nKU54hLjjDUT6PsaCJGUyoR3Am?=
 =?us-ascii?Q?9xOnA5m9v7rmqvVD5GyjfsAlJbgvNnkZ1oQf2FrMwihJzeT1TPFYFYFMggXl?=
 =?us-ascii?Q?EnX//si0IXF3U+rDP3I4qvWz7jB5OkZgrZNFfSMUS4JR9FWLgULQbEdEyXMa?=
 =?us-ascii?Q?Bt+pQ0d/sR335PpY52OZiAmBFEerOoh1GilWjeAhfbJ52G6O223TBY/dvftH?=
 =?us-ascii?Q?IRaRY2FeBFF8tRqZTLrB0bnSNikXvN49X8mrL7Oj9J53VG0+2OWbFslU8nh9?=
 =?us-ascii?Q?TH09BIQVtdz4gMv7CVe4ZsOVrNj1YU9VxAk2DXcQmZzuK+dniuck0gsBfBf/?=
 =?us-ascii?Q?KO2aAMgBHokSDbXwPMbqyXA8a+ho6dV9ohDiXkUz5CG7kjKY/7EJm7KP1DM7?=
 =?us-ascii?Q?k4Wzn/pBJ25+nhYfxJR56u2NrBMtu97qxJ+3nrnHeQ/upP4Z9yYV7mv73DBe?=
 =?us-ascii?Q?t48ZJgxakHEWkFfXx6q0IgBdsfIzR/vRzknemdbHnjjSHQJ6pghc8fiRA+8h?=
 =?us-ascii?Q?X5fVz/3fopHsghbz7SY+HZiA1zfCcJe+NXA8f1td7asArhZEowGEsLKfZ8Gz?=
 =?us-ascii?Q?HxYsPxetHhjNK5Cbun/dJji+lv67AdpUtwQQeVqiwXUrNtJX/eIppx8eTNuQ?=
 =?us-ascii?Q?YS3UKhJjT0J67Fdj+lOmZlk7reutVPkOM0RaSGWco6zonKQ9HSnE3iIZDRLf?=
 =?us-ascii?Q?/CasDy7oLQTqmgXy1MqRoDohbj1arlpuXlGtsBB4jUbGkwnrvx8cFfo+WZc7?=
 =?us-ascii?Q?ZbDloWGQUm6i+RDPfPbjzsXBDcRskVrlFttKmOmdi3lVVC6WTC8WAs7QWQD7?=
 =?us-ascii?Q?X7j6gTAWqCOi61zIG+veGLzVhCMPntpUzbUx19Im5+KEoXPbEtY9r3gXUscr?=
 =?us-ascii?Q?hLTeW4F/XGtSK5UmM/Y5/RjzmqU5O2frt1G3Pay5tn7YRrC5CASpW6vyOwSH?=
 =?us-ascii?Q?1ZbbxvvQusbcKI5oiizR3fZvj52FggOr9dEvDg10DaZhjujnSRspRVJkLAi3?=
 =?us-ascii?Q?FC8I4+/RK09YChFvvSDcip9VS3owks/4+kNXFUJrsOOgTZWnbhmrNRhsNwn/?=
 =?us-ascii?Q?9d27nuV6bHdmlo68U3CODvpa/1ef2uu01tYtXTUx0nuw3cNOCxcJcWL9PQLt?=
 =?us-ascii?Q?aY7tkptiimuKx6yL9PCJM+a8xYKau6g=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbb0106-96e5-4ec6-e6d3-08da496302e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 15:24:42.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHsqSkrEjmqhkbx6jvYU0d9npPXgR3pv9q8P+VU3J93G9sRjWTLy2Eyx3BPkRXHdGUUwoBR1fPiWpc36F8k69qwgCB4RQeTmHn7Eyu8poO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3902
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using `ssh-add -L` for gpg.ssh.defaultKeyCommand is not a good
recommendation. It might switch keys depending on the order of known
keys and it only supports ssh-* and no ecdsa or other keys.
Clarify that we expect a literal key prefixed by `key::`, give valid
example use cases and refer to `user.signingKey` as the preferred
option.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 86892ada77..86f6308c4c 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -36,9 +36,12 @@ gpg.minTrustLevel::
 
 gpg.ssh.defaultKeyCommand::
 	This command that will be run when user.signingkey is not set and a ssh
-	signature is requested. On successful exit a valid ssh public key is
-	expected in the first line of its output. To automatically use the first
-	available key from your ssh-agent set this to "ssh-add -L".
+	signature is requested. On successful exit a valid ssh public key
+	prefixed with `key::` is expected in the first line of its output.
+	This allows for a script doing a dynamic lookup of the correct public
+	key when it is impractical to statically configure `user.signingKey`.
+	For example when keys or SSH Certificates are rotated frequently or
+	selection of the right key depends on external factors unknown to git.
 
 gpg.ssh.allowedSignersFile::
 	A file containing ssh public keys which you are willing to trust.
-- 
2.35.3

