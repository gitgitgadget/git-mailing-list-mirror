Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C2C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 09:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiACJxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 04:53:49 -0500
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:48389
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232480AbiACJxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 04:53:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyKKrus8h8MUlRPzj/FcdF7cGd1hD2FYf/txCPHBzktDaJyf7+uW4KYB2sAWEM948xGpNKY5qdzlw8CCDujUY6F+j5kE8XHjutw7iJ3LITGq39eDl1LBAck1WS0A5ibrwVhDxh+FmTjsYpqzEC9ecxEToCj9rajgS12n3ruwghBI6HAEixLGrTuBkhhM6CSV5LjrNJns4ObnhO9U0I+0I4b4LNahXAciJId+0+HXvvP0VJID0mOQXvP3UJtNW/Mst7BgIN/grE1qrQQ9NyDDXp79JUEbNdxAw1Imm3VPv4jV0TTtnh5Wnar2cA95QymXhqBcpV2H49L7tvrtLJEY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSu+2r5Zs+T3FxzWsy2mh6fIy2e/Omme4Q7TjqbT/Bo=;
 b=JeVaHXR7EZp45WcZq59iED7FRXM9gWnDh/PuQ51alOda5y87shKZ+HdUqwasedvf5WWMTqCwUPSKADnAPJMJiW0evJaHTjdZo1cpQwhs3izJjzWkEy4c9qA07qyl21qBba+boo7jhlTjy0sGI0xZZ0rPrZB/L3CBohHHeWyvQwRpd/6Wb5FEzMQ56pAH0BTCfQ1nf/e/lckBzG58OEPjC/6xACp529MuRbi1IqE32FPibmerUO80hVZxxA4s2ofl9FiLEkZVhxpXVZ9GL3F6jTqkSt87Y6B0OrtWpVVUsEMGWN8FakHVzXDnwJif5FnqkfqH1odgjvya2AYrRzWpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSu+2r5Zs+T3FxzWsy2mh6fIy2e/Omme4Q7TjqbT/Bo=;
 b=D3a61P1bJuL+kkb6fo9M8MG4SuMBGcQdhttoNib1OCkmHg0Wg0DU54rPeVBcTn6hCiIAiytX554K7n/feUXmv5XZgwX3BNYaaxbMHlLShQDbHFH13CvySKVHIQk/WGbQroBCprQe5f3ipb8CJvlbKG4teCGoHmnr2/Dyw0ieO0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 09:53:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 09:53:46 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Pedro Martelletto <pedro@yubico.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] gpg-interface: trim CR from ssh-keygen
Date:   Mon,  3 Jan 2022 10:53:37 +0100
Message-Id: <20220103095337.600536-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR05CA0014.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d5d153-6c5e-495a-1ace-08d9ce9eef3d
X-MS-TrafficTypeDiagnostic: PR3PR10MB3997:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3997584F258A9E664049FFC5B6499@PR3PR10MB3997.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DO9c2U9c2QrTlJX2KwzAUUj4pgvTOYijMsIsFnWuQ6ITOqC8QR1CEMDAHvjRll186mBwV0nsKLKhpfPCyyNYC4OySGyOljQttcmKJq53L5DhBLBIF/A8ZJjuHFhIBZ+ydSMQ1v7VN1m1v2XyQ2MJyg7gT3/jDElKK95Qu5uT1x3dt/jn0+UkFH/P8XoWFYcHldlJBHG6vfcGs6zD0YDhpYn5zsOdvcxzwJKi+iZTBodIUu6jUgY9S7P8G+tj5Y0aC11qTAdG8ygK2BR9S82TjDOdiGyqzBWpCThNepUQWtbou4rpUQ4yzuwRtM3IoBC2WQTkD4ZQsbu5Gf6wgzhGJbNkQTkUbS5rfjJAEYU0UjKww1OKjPVL8RufZs/XUhbvD3OhO20/34yRbodXd/FnPuSoBe4ofmz4bo4CMmxoEA1yHPOkCPdVe0/BbvORSV8mIO/J0wJwNPXjYGIrCEqXMQdtXdmGC5D9x9QT6P8Hq0L64TFYnqN8PEOZIsG3NUKmbQCNLwdtX9Bi6ChrdF+CR9TfbHOxW7KW8nHymV2dQFkRS4Knu4zmeHzZIP6vre5Sv/OqbxlQaWmqDEsdqPpamxCj78b3q+/7rFQNOP3bfKQ16vV6xq1OW1aUJ6xpFU/Wp/fLnXKL2oWLPcRTakArQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39830400003)(396003)(316002)(86362001)(66556008)(6666004)(6486002)(6512007)(26005)(66476007)(6916009)(54906003)(66946007)(186003)(8676002)(36756003)(2616005)(508600001)(2906002)(4744005)(5660300002)(4326008)(1076003)(38100700002)(83380400001)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2dy52b1mBD+5FrgZZlql1QsDmtevQ/DYE3fo/014eMmUI2aBufabDs6F5xI?=
 =?us-ascii?Q?bqLcma5cWYJWrOo68GJUtMuW1ev5837anvQTVImvA2ceLkp9RpFyES7jrGBs?=
 =?us-ascii?Q?VTKJYZi66u+4zOFlpwQ/XdgX9RnKM8gm8TLjupQaWq1uEnybPNj5qev1z682?=
 =?us-ascii?Q?thGqjsIHLWew79pyq68ZSg7difXROzPLsIyDmgTijBx4NcVO440UcWzgU+cX?=
 =?us-ascii?Q?rvMOBB9hs81g9ELolCRT1Pb5uaFmpMSahu78k8W/9DZJEwgpJNEp9TMOJhBk?=
 =?us-ascii?Q?LWOEJYLVPkD7LBJXYWnLd1HTiTr9Ns0MhpdmhKL+6BqTpkYW7lFXR8a92F5a?=
 =?us-ascii?Q?Zpt1CocGlaT35/SjYHU07gx22Cpn7v8J5qLuLz0kBSkUmGkfGcjY91y/Qv3l?=
 =?us-ascii?Q?jPEKcH+v0xQViM2r1+z9p55XNUtAZ/SbUj3dZuhkj5uo5b7/LnP6BhvMqBOm?=
 =?us-ascii?Q?YjLr9mdfzgfKJdKvhvA2QE76N0RYTh8ozv8u1mNu/NR/s9vghXMPtcZwlEBR?=
 =?us-ascii?Q?5ENwUTvpIBgpKpftmBaf+bAhWRYd73lJRzJk9lw0ri40zBY8vepGNw+J8SIT?=
 =?us-ascii?Q?eX1xoQw2Svb8EFeJ1oIuLNUqMUVIkwhQvrizdrD00SG9DyQJZYENHRhKPnC0?=
 =?us-ascii?Q?SM2o3AWUpsZX3Ic27yF8iZQH18qUO/EvV7FEB/5bixrD5jt8A+AyBRc2FKGu?=
 =?us-ascii?Q?wN8QatWv5DWT1toSEAIfukrE/n/fuk84Pwk4j5nRbFGmDMHci10YtDXol6os?=
 =?us-ascii?Q?FiFrE/PzpmNrTRN+xwkNCsrrCFZ+C8ckxe10esyU75bsxxo9M9wjpAwbNDMR?=
 =?us-ascii?Q?ezDIsHHC4yneV5P1rf7ECYsWHFi+WSCuErs5faqlT5TUbjWazlgY+6de7Fy3?=
 =?us-ascii?Q?1AuizJm/DPCF5AHPbR2RYVnjkDSMSf2BIh7vtUnfufbn7MbpsyoxxPfVYOXn?=
 =?us-ascii?Q?PVi13xDptOH/Vm56l1Josqo1J/z78pWzVcPS2R6JMwn8Ny9QjoKAc233RTBC?=
 =?us-ascii?Q?zvryBcUj2ODMBCUyZCf5x1uyCEMWvcC32Fs7FgudR0gi4Vog6LqG5h9Jaw+L?=
 =?us-ascii?Q?bsi+fFtSaMoKKM9ocrRD0qqecMjFTxV0J9roT25iDR6gnC7iC9tkHiIyqvwT?=
 =?us-ascii?Q?1ymBL9q5YRToNneH49garVudBZ3m8DD/sBhTls+xa0RWTWOP0g2/IKUxNwdO?=
 =?us-ascii?Q?bSaXlJ7XDE8i54ovBXZoLOtDn5mzLl07BFOFtrTRyE0SjjboNFGXs2nM4CCv?=
 =?us-ascii?Q?J7M+JRATObmW7JThB8ID7H0bGK42fIGXn+56Lsuhi+acy8ckRJMBQAAzxeA6?=
 =?us-ascii?Q?JpQLnqZPxdXLuidLJceLkChZWnKZy1GHvI502jm74Jm/pTz7CTdANH4OIZlW?=
 =?us-ascii?Q?Xk62aStr2S3o2OQ9pmzH+HA+fNR7VOx4lSK8UKf+sNSwnVxZ09iE0Z6i93YL?=
 =?us-ascii?Q?q4n0bibw47SZvWlVEMKjNGPl81prgm17xleJL5MxuX1zaYwCvAcvXbz5ZI5i?=
 =?us-ascii?Q?AQOG3V7koBqCASwfO+9h8qjHWqiElvJTRLf7XVmWPR0RUMvfIq8QW0PRjm7M?=
 =?us-ascii?Q?uAEkyw4A43kd6QIvBhggIshX6Y2Ae9AwMR6p39fZiVExZcJDTjwnEBasroDi?=
 =?us-ascii?Q?DBeWp/XpReTXBcP6e91VM0yGmCfAiXms6FkKZVVJa7WZ2z96Oqc78SG7bMSO?=
 =?us-ascii?Q?r8aMKfwXz9XzAsnxGWep1hVbP4I=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d5d153-6c5e-495a-1ace-08d9ce9eef3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 09:53:46.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/iOinSfoAIoKjZUoMTPRjMtt/HrcnU5A778Cc+0VFoTwwiK41DX2dhzKawlHQQiGV6lmMKXBtys/EN+xlH433XdU7V6vS7ArLFe+0xvwZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3997
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
this hypothesis. Signature verification passes with the fix.

Helped-by: Pedro Martelletto <pedro@yubico.com>
Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index b52eb0e2e0..d5eca417e8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -509,7 +509,10 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			if (!*line)
 				break;
 
-			trust_size = strcspn(line, "\n");
+			trust_size = strcspn(line, "\n"); /* truncate at LF */
+			if (trust_size && trust_size != strlen(line) &&
+			    line[trust_size - 1] == '\r')
+				trust_size--; /* the LF was part of CRLF at the end */
 			principal = xmemdupz(line, trust_size);
 
 			child_process_init(&ssh_keygen);
-- 
2.33.1

