Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF2C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412B46112D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhJVPMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:31 -0400
Received: from mail-ve1eur02hn2210.outbound.protection.outlook.com ([52.100.10.210]:57385
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233237AbhJVPMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpZ/7nIsU/T9qcRw3hA22hLq3orU5y9bTf21B1+MDQFL6+4isYuxied64uT57tBU+VKbiZsCQAVNMpPVpkMKNRMcXO7zjVqfujkaSn5I4JgORlYL5D1TvH8Cfu0SLCdgHnNVaz0ByJ8slg9uyoBvEXYgRMoFKbx2bP9PP3ROKRTVfBL4rgN6Cbg4BJKLUkbys/eGIF9zbLoppI4sgxhfV2rwtOXK2hg0//vRq8idzsP0tVh0G8PWg4xnOmPYmO8XKEWN0hb1OOjQFoiMTCJ5M3R6Y3C0dZG81+1md7Sf1uO6hkLXZ8wyyuRwoKPwFhbT1hE4/KkZm9z6iqHXzTKn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkYDhM9t1n5evBkikaiaIGHFD6dY1eFulxkrjMeKBBU=;
 b=oKnkZ29TzOL9MraGDJRhDboZV3r94BF64oh1AZKvInGDxNzreHyNoUz/156/Pnu1ReclhMQe4sy4zFhuVnByoCkEu1XzffAzeoHoMdsbRe6ptxV115uOSvJuD54KYD1zVLzrgVw1xw7pxjy4sbE610BJ4nNp63n6ahHyTYrLMe8vU7bNY+N/knxPAuKYjPaSjSJV1Ob+iyANGnKegYkqLu9Jkex7Cw/r6IZMziJTgtUzyi6pffbjripwNdJrWY23r0lZG8zBODrLdzN/9aNkM1xMgHe69Ye5jEmolZZFXgJ+plL4KidDcm/zhnm5XcVFtpfiUjDbj78KC/fANPuMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkYDhM9t1n5evBkikaiaIGHFD6dY1eFulxkrjMeKBBU=;
 b=PaiZJ1gkRT8t8rp01UCJNrkRbQI96s414vohq0w9xszgCnj4UdKB7mFRWEVnQSr+kYEH/H7BAjD4KThq98k1xy69Z163/pQ0L8wZ2fG7XpDELUkumIGZLaZ+AN3R5hWw82mJbLGbj7f1jlG1gX0FmZfSbEm8wXWAaINSVCUe/fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:06 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:06 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: [PATCH 4/6] ssh signing: git log/check_signature with commit date
Date:   Fri, 22 Oct 2021 17:09:47 +0200
Message-Id: <20211022150949.1754477-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022150949.1754477-1-fs@gigacodes.de>
References: <20211022150949.1754477-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0196.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::21) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0196.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 15:10:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd66908-bff6-4ec2-0915-08d9956e07f7
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB46370BEDDCF3A943D7ECA9EDB6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g9GzOMZrY1huCix8ADldyeHX+Xq2nniTlRmnvChkbtaW4XXPKDLDHeqO6YJy?=
 =?us-ascii?Q?3qyagZuFRZ+3lS8dH4qr2CalfSGVcJiDC27TL+D5FIfOjtFXFC70mFa2UaUK?=
 =?us-ascii?Q?pAK1UkHjIaJBXChQzgLReIpSgubTPQrT5v9ePiuL7MCTn7owxu0rmYiyLga+?=
 =?us-ascii?Q?/8i08NPj1wVWqGjhAAwtKR7R60gCs+vfq5+iGq/MHpcgajNtNFbOSLHEeHB6?=
 =?us-ascii?Q?zzbiDFPvB3hgvz2XYIeY0mbXWKsQz8faCMYQW2SmvcWWd/zATmI7zCypsy4i?=
 =?us-ascii?Q?DVN44GPouzKgPFJ1iUPjwsqT7gBOT+OLA8EvWsUpCGsv2EAkZ3+4GK0OrxMZ?=
 =?us-ascii?Q?9BuYhVcgc9AsOXg3kTjY8v7U4O7Usk9+mU5PpkX9CjIlVyYhG4ZSGc92zcaB?=
 =?us-ascii?Q?UGeqm2Q7RDgGMw/JDP2vVPlYomer1cLhp2NU5UQWaJJ+xImW8f9mMiSsD2tR?=
 =?us-ascii?Q?IkJjzGPcnecvd9Ha6MInDKF64PySu4uDLKxER/6MmvHw2vKagFEoKkMjsTgN?=
 =?us-ascii?Q?uDVEOgH5vVAWpj6JgkWBMpxUIKt/xofIvpbffxKFrexE/ctWs5ySOQ3WefOe?=
 =?us-ascii?Q?leG82+qlAYXOECa2SRh3BabojOUpv2/zBLMVFH/kaDWpLeRxt8LcNGHl7PDW?=
 =?us-ascii?Q?R74go1UmEU8Oy+gXAc7wWK8Wel9a9jCjGeirNBLgi6IIcAl0OwwwSQ7VfA6J?=
 =?us-ascii?Q?k7pWyla10rLvnLzVZWSOx22XfGT8qUf2AzQKP1SXkvmdsns+oj4MMFBkW0Uj?=
 =?us-ascii?Q?hnQploBv0jHyBofyyg6cMzTXwEtsCz90dT/dE4HVamzfcOTcW4O8lIDlhgF2?=
 =?us-ascii?Q?5KuA9NfbHm60pGdjQXdPNjf6iv4Fqo/ICxhxL2jqpfX5DF0ZOSABDl1nP8Sa?=
 =?us-ascii?Q?EPoD0eZGmCZz0bbxEMAQlt7Uq62U0I7KOHK7B/iyLh2v9wUR+OdUSQKtQx1S?=
 =?us-ascii?Q?gg/4yINc+SMvWe4m9hNyQY/yFlTWS5AucvL3nOtAhAAjj8xka6BvJ09c1l8I?=
 =?us-ascii?Q?2fWKyetn3VKXciyRmFfUXuG4QA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wS3ODvTQoWxv03uJ0m0RljFbFkgxksFIAE7u46hxB4XV1vuvmWEm6anQC2Ds?=
 =?us-ascii?Q?BkydKf4shYkIk14ZXsVLpJu1hAG0gjofrJAzmk1b3XTQ88dzAz3L0b8hmK/R?=
 =?us-ascii?Q?VLLW4Px7ZFXP2TgzdcvOMNNg0IVttVZwr2GglHmnkebTfWELt8cC6HcGrX/m?=
 =?us-ascii?Q?o83fl1S9GtapI4KO5KOfR51DMB7uYK0YEkRiONUcBQZxt8W5z9/CCggN3h3d?=
 =?us-ascii?Q?XPJOwGWlfyplmXEHj3RzG5PN4YylFyTG6wl7yoTA8UmQfe6SqDtOZxE/vXIs?=
 =?us-ascii?Q?XeXyolrsehBX/Z4GNUxZpBzibj7L6aukrz0l/usEtIP2rD7NkAsykRNS42Zr?=
 =?us-ascii?Q?mNZ5W19eVy5V6TJHwIoA0zgD48+K1OY7gG6amQdmEp2boceNDSgxf6nV7HKQ?=
 =?us-ascii?Q?+Y+gC+XSiZw+OciVodovzuaDNXuyMbdVE+XjZ3baoUl765xY1VO1TNOXm2Jx?=
 =?us-ascii?Q?DBPZOtTaQMQ+hjt7DrpUKJ02RYORh9LXVsslrei7QUhgF8rZVvH18dunYS4j?=
 =?us-ascii?Q?TFrswpLL46iiIoPZ1WW+KzPssA9XGErJInXp7TaiAVWD6r5FzhFMs3dW3m6Y?=
 =?us-ascii?Q?KPthZrpOZzrxGkPN9MgQf2E2Pdqa6APQYYWZwX/xaP+l4VKjpx+sIjpp0NA3?=
 =?us-ascii?Q?kBxOjexq3zm6X4TjCNuaIz00rndG8KArSLTM7SShhUe8DkhxyjSdoJbReAhn?=
 =?us-ascii?Q?VMaAM29JwUt4YkIpLVMXuNvf1vD2oaXfVJuBBPLb80OohPpXChKoa+89Z4n2?=
 =?us-ascii?Q?Dwp1Sed+StUYoM+CdQ1rxXD6OEKcup/RIMAlnbUcpfSHp4Y3g+sO9YNdkyjl?=
 =?us-ascii?Q?9k96ekLKtvXdi+HDWnmtINh7cERqX2p3xVX2D0vLKs95rIJaFyBfN+1wnDiB?=
 =?us-ascii?Q?1Cf8y92eR3sm3+4ZgsZgd+ClOoaxy5SisFFv0fIAxfA3/ZSKNiBYmPOWY6rq?=
 =?us-ascii?Q?PM+ev24xSv5bG8RMGye/lFCmPA8I8pnRj2spmCJAIQPC9zasPxrbqtAvqnwo?=
 =?us-ascii?Q?lEhN8+QrYWEilrH2lFYfU+A7bN4iyWNDwbop+NCMWbUkdOCTTVS/6rX/VRYo?=
 =?us-ascii?Q?T49akMTvIeNCdXpP4FZ9pEUCKxwthnFyN4l4PsfbQrKGLCcxUy3o8/HpLZq+?=
 =?us-ascii?Q?Ajk8Sgtb40z2cyVArfrk9M4CcdmecO13d4uRJY+h2O7vYGWnj/BEqrQU1FkY?=
 =?us-ascii?Q?jSkVPfGknU/zOM3nU4X66DEeDgo8Mr24BsqNtdbeX0l6aHWk03WOfS3F7yDd?=
 =?us-ascii?Q?4F1eACzrK92Sruf+dOmwxBc97g35pXQ2WB96QxeFc3uAKoQxz1buBbYdmmbK?=
 =?us-ascii?Q?zI64YvZmf/sjyoBX7cqDF8CwcrL8nNWMDlX5iNRczBR+uLKAupHzQKd474/+?=
 =?us-ascii?Q?J236m4oVF8L88hWYqQuEwywtdzoJ3NZ/zk1ajyNWul68FK4KUJecdVNb2dJc?=
 =?us-ascii?Q?r9/JE6Q9nPZx8P8ewu2fzu7jQiDPJjieGPAz0WxfVNqeXqEQw6qsgWzD2W8z?=
 =?us-ascii?Q?pezVi3haijxbV3Gxtf6cYd8wK/KBQemXIEeB?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd66908-bff6-4ec2-0915-08d9956e07f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:06.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the commit date and ident to check_signature when calling git log.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 log-tree.c     | 24 +++++++++++++++++++++---
 t/t4202-log.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 3c3aec5c40..2b29874265 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -509,12 +509,19 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	struct strbuf signature = STRBUF_INIT;
 	struct signature_check sigc = { 0 };
 	int status;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
-	status = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
-				 signature.len, &sigc);
+	if (parse_signed_buffer_metadata(payload.buf, "committer",
+					 &payload_timestamp, &payload_signer))
+		goto out;
+
+	status = check_signature(payload.buf, payload.len, payload_timestamp,
+				 &payload_signer, signature.buf, signature.len,
+				 &sigc);
 	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
@@ -524,6 +531,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
  out:
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 }
 
 static int which_parent(const struct object_id *oid, const struct commit *commit)
@@ -558,6 +566,8 @@ static int show_one_mergetag(struct commit *commit,
 	int status, nth;
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
 			 type_name(OBJ_TAG), &oid);
@@ -582,8 +592,15 @@ static int show_one_mergetag(struct commit *commit,
 
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
+		if (parse_signed_buffer_metadata(payload.buf, "tagger",
+						 &payload_timestamp,
+						 &payload_signer))
+			strbuf_addstr(&verify_message,
+				_("failed to parse timestamp and signer info from payload"));
+
 		/* could have a good signature */
-		status = check_signature(payload.buf, payload.len, 0, NULL,
+		status = check_signature(payload.buf, payload.len,
+					 payload_timestamp, &payload_signer,
 					 signature.buf, signature.len, &sigc);
 		if (sigc.output)
 			strbuf_addstr(&verify_message, sigc.output);
@@ -597,6 +614,7 @@ static int show_one_mergetag(struct commit *commit,
 	strbuf_release(&verify_message);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 	return 0;
 }
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6a650dacd6..2b12baab77 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1626,6 +1626,24 @@ test_expect_success GPGSSH 'setup sshkey signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
+	test_config gpg.format ssh &&
+	touch file &&
+	git add file &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag timeboxedinvalid-signed
+'
+
 test_expect_success GPGSM 'log x509 fingerprint' '
 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
 	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
@@ -1663,6 +1681,31 @@ test_expect_success GPGSSH 'log --graph --show-signature ssh' '
 	grep "${GOOD_SIGNATURE_TRUSTED}" actual
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 expired-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 notyetvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log show success with commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedvalid-signed >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedinvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
-- 
2.31.1

