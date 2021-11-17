Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BDAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A37619E5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhKQJiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:38:54 -0500
Received: from mail-cy1gcc01bn2066.outbound.protection.outlook.com ([52.100.19.66]:8327
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235110AbhKQJiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZiwyyxBz5721MeWgLT4X3QRI9nuNoG5uuNhzfaWa+WOnIthtPjDOvF0lMBzqWukWZnDGDI36Dr3gyHoFMLCEeTrTR5hLrPaYFNdoHDszzyTWn3BOx+Z6/oB0Mi+QLgttf4IkkP4bGYvv/a9+7CCNSr7gGYl4/JkcsrvNrQ7md8fBl+ZHrdePrKc7eqVkiXw08VEaK2s7h7Pv64oiCdCHnmqz2iM+fd2z8JKHVagnlyDEmbykKudm8dH5dde4RYTJeX8Q1EWnxs9LZyQ85+V/2uYlE2zT7qnQBUMppx+zOHr2n9BWeXY5OgHxcbV3vqk16D88fyIt+NKAzv8i9jqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95NXDTcJeEuBT8WYyDOXPJWZmPCDei4sVUzJgdLqj4Y=;
 b=PtfdXeL1m9pht1+TR5g07L1plYCY7BNYV0eIPCvVrdwDhjWfEfufdBpXXE18hAEeIGlD/8g3Z2kbR+v+spKfAvJ6cmS6jQvJxUJ4peSdWUUiA9+2NX1BhmXXOzIIF0z5YubmxWnxo0d+lzvTXKKe9f+IlXfQuB5C9IzWemZJy3DvQRE9dqxyJWqruI/qvMipSUxG31/ENsqpZZgFeVtdZV8VrKbgUeDyJzAvVuNCZJwrrbIaWiTtNB2H35UYUNnt6iOICxtmJedzdETzoAuGwbkb4kPqbACSbvcRQs/m6vblQW7HxMRytzTjHqwkCRej+TZka1XzJl8dLXVCs0ugJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95NXDTcJeEuBT8WYyDOXPJWZmPCDei4sVUzJgdLqj4Y=;
 b=tg90nz30vpIQ/gdVXYs2ip5lOLFlK0acOyZowl2+t0qYfURxZqCRaTnMcQgsxgCnmA565SOYq38+ybycs/BOhlvR631xh9goIuWiPNDrQsLxmvev7ThW/Mfi/k2wPNfHlOiqtIFST5lxQDX9RB/+23LgZ91pH5ixL0Ydcy6vmb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:35:45 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:45 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 0/7] ssh signing: verify key lifetime
Date:   Wed, 17 Nov 2021 10:35:22 +0100
Message-Id: <20211117093529.13953-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <xmqqsfwmus5g.fsf@gitster.g>
References: <xmqqsfwmus5g.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P195CA0055.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 09:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29625c87-7947-4ce5-a6e3-08d9a9ada184
X-MS-TrafficTypeDiagnostic: PA4PR10MB4349:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4349641C6C6E6AD113234654B69A9@PA4PR10MB4349.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+D9ELVFQcUgDqg7/6ZNniUUE1uemt6WeAI8qDF1Gd04Hxlv3zAJQE9vlIOfW?=
 =?us-ascii?Q?KJnm4G6n4fXhC+/IVK8GDK272cP87wn1SNjm5YN2Nf70RZV+gbSkPtUElN6K?=
 =?us-ascii?Q?XJsrps0+k55eIlPJQNR3GOuyidammnIh/iXSQRA7B9SRf2Yfq0ebIguJ0mAb?=
 =?us-ascii?Q?119SLfQ96Pi3x/uU/Zv6C+RKVDdk4/BkpuE4BLF5YZa7ZFrXF3nCWmw7ZddO?=
 =?us-ascii?Q?GYbEIAcj8npxSzQyWoWCp6XOjbIfODmowxRkHqOAUVfBMyPl/3mH86R+FEyi?=
 =?us-ascii?Q?i3ASg/3gr9KZsh7VG1qCcamT0hFXyJ5JVLIMg9rKQsRVpOCdM04HNvs9NHQ3?=
 =?us-ascii?Q?kF60SMVY0YSk5RUVAguN8kLxSb3u/HJoTLUiQw1Q1zPZ3E98/NfS46FP6ODF?=
 =?us-ascii?Q?lhPwzF/u0+WH9CU4tthlSTAPxcAKRR6oYf7W+9r4urugBr+VRZsu2P+pDYf7?=
 =?us-ascii?Q?l8tB+OU3FJF0xmxGh85p/2dof9XcYquVqOvIZCEc4mG8SdudbgA3on592J8+?=
 =?us-ascii?Q?hc+uqFSTOj8Hzvtm9eXqZhBcqXkhht1nR3XU3eTPJv6g6ACSin91pLkcYM+/?=
 =?us-ascii?Q?9kVJnY6U2kZHRK74ygnmbVjPDNY5X448c721cyPbdiGQjUvlRXDNnbG7NUHw?=
 =?us-ascii?Q?0lchXRmQ+y2LF98MYs4WSHxc4Et0IGOwodIEzs+LB7eZETYP4ti6Oe2gGf/p?=
 =?us-ascii?Q?a32i8pb27Tai+QfXq2lKDk/cZ+6aXkD1nys3fFyz90/nyEt+uE+QdD0RAujy?=
 =?us-ascii?Q?qz8xyh/U8gG6SK+XDopP2H2B7QfQqwUlyTS1hrusClu2blGnTfS7GVKV1seE?=
 =?us-ascii?Q?oqvIjQGqWx40jhDM2pnuY1GiUcGjgTotj9w1iqTLF3Prvu5KG3zS6SXwY7bk?=
 =?us-ascii?Q?cBUlKzsuHSQkcjNShso0cFLK9vQJ0SyiGvwvsMM4poUXh/Dy1+xCCPA0qGvY?=
 =?us-ascii?Q?7jb81hzYZifU4OA3ItBHcITFM4lXu2HEM4yzniEBFFNQ3jDjH/jvZnVJLQz6?=
 =?us-ascii?Q?R6uBwW2zaF7sR0zdFtYNeFHoWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(366004)(39840400004)(346002)(396003)(376002)(6496006)(6916009)(508600001)(2616005)(38100700002)(52116002)(4326008)(316002)(107886003)(8676002)(2906002)(6666004)(6486002)(8936002)(86362001)(54906003)(5660300002)(83380400001)(15650500001)(66476007)(186003)(66946007)(1076003)(66556008)(36756003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Obv/ojZp/DisulOOIzDAJtsITOjoOMaBD06DV+mXHikbZU7KV0XDsemuS3Xc?=
 =?us-ascii?Q?s4QlKQyfb2lpFmF/CvstlUQDxW1z/eh1BOskUFe4IbfoffoM0ZFxAanis5fH?=
 =?us-ascii?Q?uo4yPaOcXgMavks8WcGBDCw/CQL8kw0NqBa3qzEKdfaHCZYKGMnjgyKMbIlu?=
 =?us-ascii?Q?SJsSFfePsL+6Ti+8x08UPYmhIRsDkjMEdR/4NyFmnAjo0MtUtL+G/+Ihy9fE?=
 =?us-ascii?Q?2y/CT5lDNGgPlCEqXSSLKtq8HdMZaLl8zBPh4bn2A3qdBgz2mV32/S7OOCst?=
 =?us-ascii?Q?Dx7ZPj/yCJ2bsSFWYgH6LDCZvJcvM1gsleGTG9x3Dn/3o8f3Odx6xNbN6Yxi?=
 =?us-ascii?Q?GTO+v22IDqkNXMhZp1MgwDBpESdw2bOpSZD2Znz2tlZEGJ02sJf0GBEFNiZR?=
 =?us-ascii?Q?C6f8YlA0o1BdNOJcu+MwBARKl/WzHhwKUzeUEGaTxE6T60wicccX/82lte/r?=
 =?us-ascii?Q?OBv0NCOEaUyTmwWaSUljQ9VGZ4mrMAvib83f85sS90akP+8/Ga2FqSqXFFLl?=
 =?us-ascii?Q?j0VSPPDTt9xsbkwYM/MYSp6t+oRBewehDnYKTfuHV6HsZUkTv0VTP8GNHIwd?=
 =?us-ascii?Q?nZCztdkhL5E0YGSuKYxKBH1/kSDkst9t/7yhquQGG3oiQc8ZU1tCpkswloCx?=
 =?us-ascii?Q?MWOJ1AWgKLQfuE/nx9ilsEPl3LKGtpvkfjqFYlwq9qM9GQKYp0Rdj1/VYt/7?=
 =?us-ascii?Q?9BdFfVsLOtoTMFB+DDrv0xA+uSNU5ZOMcWw4ilJK0WDm8ZVnvJtXQW6DBXbv?=
 =?us-ascii?Q?eVNIKqqfki5NGS9YU/VghAMCpOClmtKdfOGx15uDb6ylJ1zHAErtcpophkNj?=
 =?us-ascii?Q?6U7LsRSmRZ2T2b++pp1e9tKi6AYf9cYxmLTH9Dh9EH5Ln4vgn4mBeQuxzad2?=
 =?us-ascii?Q?s7m63rsNO5CxeoOY6mYOko7LBR7k5cZS0Lo4vnrrnBbxdGZ0QAK46T15/idq?=
 =?us-ascii?Q?P7I4aZEh2Z8/6dJ2zZbNuE8ds5xNxIZ7OEToFoHyvTn9p93pYfAdFGOePkcx?=
 =?us-ascii?Q?zkezM9z+WdUfR/NPl9Q66yonjRuSGY273MDGfKhltDCAVrWmQSGh/3KKJZUV?=
 =?us-ascii?Q?+BAxipRlc0Q6scFjwmdABT9qupkvRlcamm3to2C8bSn9s6uWMDYoDnA5HZDF?=
 =?us-ascii?Q?DK9F5WGMzFIGw3dfWd607IHm4iVlag+TxjbiEIU2g8FjbgTO/irW8878dfWO?=
 =?us-ascii?Q?LXDn7kbllqtsB7sLDbvFXqFYhG+6HwuufKtC8SoGXt0XCO3PMEV1P67u/lwC?=
 =?us-ascii?Q?kOf5ay500dfABdAtavq52+dVoQ3e/iEYYfz9pxFBgqPQ4EchazLuODTvLmmE?=
 =?us-ascii?Q?Zn3gcSzRQS2BiSNmYSojOD21P15fXKr4K/mny9JbSjg8ToiZ3snc+teFomee?=
 =?us-ascii?Q?b6RzRJ6LnpZwpXgIJmbCoMQDV3L6tpmPAsfRV7WHxQI4wENf+PlAiiCcvGmM?=
 =?us-ascii?Q?QU3bL0wisKLkuerNTaGnd3ayVIQrQKv0RgnCtEA9gLtdksQaaIYzKiRcnnU4?=
 =?us-ascii?Q?dFM7ppzQB0ySpJSQxXBHv2BWue+ZWFg005qGLLGbpmCQbkgXOI59mt5715AN?=
 =?us-ascii?Q?R1uf2C3gQ4SEXuvhOB/MbzzgylqJt1+q1ciTFwlelP1DFa2SxusxqG8h3CmO?=
 =?us-ascii?Q?LpzxhYNicC/slQ643KN+/9BUi1UX4nE2dhRhHc1qaaKGqVQ499aUCQbrNtCl?=
 =?us-ascii?Q?jMd4LC9CQ5HtthHdbLK+jMM+w1PJUzKxmtNvIulocOQ69xkZVZk8LOaEJcNV?=
 =?us-ascii?Q?Jw7IlcWSijBPcT4efNz0PNN50WUTKhI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 29625c87-7947-4ce5-a6e3-08d9a9ada184
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:45.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKmlH0hpxptX1ZQICxv6DYNxzvf9LGriTUtz6cvsHN8fa6rIwFfV/J7GWyoJpzIIXlxulBB5yTjywABMvVvJGmXh7+CeZEzinXNbtBQnRXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4349
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes since v2:
 - fix swich/case indentation
 - BUG() on unknown payload types
 - improve test prereq by actually validating ssh-keygen functionality

changes since v1:
 - struct signature_check is now used to input payload data into
   check_function
 - payload metadata parsing is completely internal to check_signature.
   the caller only need to set the payload type in the sigc struct
 - small nits and readability fixes
 - removed payload_signer parameter. since we now use the struct we can extend
   this later.

Fabian Stelzer (7):
  ssh signing: use sigc struct to pass payload
  ssh signing: add key lifetime test prereqs
  ssh signing: make verify-commit consider key lifetime
  ssh signing: make git log verify key lifetime
  ssh signing: make verify-tag consider key lifetime
  ssh signing: make fmt-merge-msg consider key lifetime
  ssh signing: verify ssh-keygen in test prereq

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  6 ++-
 commit.c                         |  6 ++-
 fmt-merge-msg.c                  |  5 +-
 gpg-interface.c                  | 90 +++++++++++++++++++++++++-------
 gpg-interface.h                  | 15 ++++--
 log-tree.c                       | 10 ++--
 t/lib-gpg.sh                     | 36 ++++++++++---
 t/t4202-log.sh                   | 43 +++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 54 +++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
 tag.c                            |  5 +-
 13 files changed, 318 insertions(+), 41 deletions(-)

Range-diff against v2:
1:  11d275b53f = 1:  9f71fd8639 ssh signing: use sigc struct to pass payload
2:  35ee285887 = 2:  5ee143bc38 ssh signing: add key lifetime test prereqs
3:  ccfba23934 ! 3:  3183e84e2e ssh signing: make verify-commit consider key lifetime
    @@ gpg-interface.c: static int verify_ssh_signed_buffer(struct signature_check *sig
     +	struct ident_split ident;
     +	const char *signer_header;
     +
    -+	switch(sigc->payload_type) {
    -+		case SIGNATURE_PAYLOAD_COMMIT:
    -+			signer_header = "committer";
    -+			break;
    -+		case SIGNATURE_PAYLOAD_TAG:
    -+			signer_header = "tagger";
    -+			break;
    -+		default:
    -+			/* Ignore unknown payload types */
    -+			return 0;
    ++	switch (sigc->payload_type) {
    ++	case SIGNATURE_PAYLOAD_COMMIT:
    ++		signer_header = "committer";
    ++		break;
    ++	case SIGNATURE_PAYLOAD_TAG:
    ++		signer_header = "tagger";
    ++		break;
    ++	case SIGNATURE_PAYLOAD_UNDEFINED:
    ++	case SIGNATURE_PAYLOAD_PUSH_CERT:
    ++		/* Ignore payloads we don't want to parse */
    ++		return 0;
    ++	default:
    ++		BUG("invalid value for sigc->payload_type");
     +	}
     +
     +	ident_line = find_commit_header(sigc->payload, signer_header, &ident_len);
4:  ef8178f88b = 4:  e35515867c ssh signing: make git log verify key lifetime
5:  c12457020e = 5:  e20177d950 ssh signing: make verify-tag consider key lifetime
6:  fe17c60276 = 6:  2af2b6d098 ssh signing: make fmt-merge-msg consider key lifetime
-:  ---------- > 7:  e6e2236a52 ssh signing: verify ssh-keygen in test prereq

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.31.1

