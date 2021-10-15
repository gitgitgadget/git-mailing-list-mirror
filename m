Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F760C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103F2611C1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbhJONR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:28 -0400
Received: from mail-ve1eur03hn2213.outbound.protection.outlook.com ([52.100.16.213]:36958
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239289AbhJONRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIVP+AGyJKTYDuAEu+k91RssSTq3trtcCXgucEuuypx4rX1zDEwwVFjXPD3NuhkCgoqAi8Jj5pvbbO6/NBoM3BSEIipTWzPTE1n+Fo9RN/qkL/Nz9yTxKELh5s0tHgYa580bsX2KRt9gQMazTpVC+N1qf/x3srzzz/7cGJ9CMdltosG1SbLMPReZEZPgqOtgO1zqi711hltF1Cob+i0xBf1aCqzvCWV1yVrSjaF1mixl6x/plFEXNOaAdWpywO0mcI1ORCVmHAPazOsRIL7lpvLTzRVTnct0cVdZm0hglRxI/w0QS4rjbm2xVdJ8O14Ug8oa534Rv+Kfi1lwLZqDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bm1ujn41KDvz3w0QewLKuT/l4LpeHE927BXHbFVF6E=;
 b=I643ClFzOX0WsypHVBCiYJD6GyeShJq29SABkF9UFo8gT01BaB/jN8ClDBDTtJl5R04c25ViepAaNJsmfgq9NsBDAVhxz9A/6vGlPUzIgywbV07IRpAG83pyjIKvisyXZYECOPX7KvHmobtazisSz63Y1ArOGfbnDpxCAYkXnO9GPsoagMuh29mhnTCCsCY5+gqRhAS28/NLjVwUOOPKN76t5y7gkgRasasMpvGSyGjGSBzapizQiNAen6BgNYmkMSIkCpMdAa0XApEpHcjBeXQxxBi1brvOMiDRdvTmK0sMxmJrPyy+WttYG7wf6ZliCjEHvhvtTgXfnETjAdMhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bm1ujn41KDvz3w0QewLKuT/l4LpeHE927BXHbFVF6E=;
 b=mWZT2S5rULLjojn04/fY2DpTlAua1pSUD9SWMVzp6+X4xxcuZqXEMRwhADJ41hXI6tVNRd9OIVBCz+D300tdg/YzhpuYHSCiVyFqWUmzCgVNMgct5YJCDiSUq7ZnOE04ufJMszqSXHfbN5mLyalNDDLjO58qr8zpuDySzOPkoQ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:14 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:14 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 6/6] ssh signing: fmt-merge-msg/check_signature with tag date
Date:   Fri, 15 Oct 2021 15:15:07 +0200
Message-Id: <20211015131507.1773153-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015131507.1773153-1-fs@gigacodes.de>
References: <20211015131507.1773153-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0355.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0355.eurprd06.prod.outlook.com (2603:10a6:20b:466::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 13:15:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2b0635-af37-4c18-1197-08d98fddd31e
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB4046DB8D89AB1CD971C51B15B6B99@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:91;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QXA6HHRXTmjsjczUtDgxZf1GnalFB55dH5puyd2592c/nDb2rPPcz/Ok150R?=
 =?us-ascii?Q?5ibfrh6YiDnm0QF8PSt4qs+lTZlHf1Bda9Oa3XhX5QUxnybePYptkfUtuynh?=
 =?us-ascii?Q?ufE8VP9UHlzys7GFfdB7mNP3fRgTTBQ9AWC1iqz2uDHhsiGuC+gz42fomKW/?=
 =?us-ascii?Q?gfx+F7720yR0yNCDzwBXtxzAYHFTWU4nvx7BZrMAWpnytHAjGTxacdGPukDi?=
 =?us-ascii?Q?eLQUcXh8oWOC5ORViaY2WixaR43xdEXg2PVHy2xk0XBVfpwnWc4UCtTvSBL4?=
 =?us-ascii?Q?vvydJe3ZHgJx2HOnoc4cNpGWhdATSPExajS+Kw3oG2OGEeYxeD8dpRuDTI+4?=
 =?us-ascii?Q?JTBZUsv6uLyyVph+QcnDm4iBtFcRAqRAE3gKUGcFeoVnSuBC5siUEzBWLfZb?=
 =?us-ascii?Q?SrMFm12YJROvSmgCNZCcUeQJM9n9FUI2JkgIQIOCQidW4hLTtTnw0WGCMYA1?=
 =?us-ascii?Q?8sVUJp1kbwDH/7yHIqW9PyrKnLGQNCSPZOulH5CyNwxtrgPlD7dggojWL3QQ?=
 =?us-ascii?Q?DiR8hPk4hw5zUkx0FhRMZJOqVDJrfz7fA28WeZ5GskJbhACUESvUxyH4PK6M?=
 =?us-ascii?Q?HEDBaztoUpGugpEM+wnXP+rAjjP3c6oHf3ES9Kx1+5n9rJsthQ5dB7LkttPX?=
 =?us-ascii?Q?rbty4oVYLjSlA4jzxaXj4UcRfQ/GcumjOTbxJFC8bg0cWu/cKt3Zus2kOb9f?=
 =?us-ascii?Q?76B3QY/AuWaxYonuvFqH1cSxxnR6yHY46XXzVHpT7fEwahyvTkECR08trbpW?=
 =?us-ascii?Q?mqym7YIJqyzyxmJOhtU7EzohM++JN0kzdB7AIp1zorV1JMhUIt+v1pfToKm1?=
 =?us-ascii?Q?2qoPx4CafjhEdSEWyJ9c1q1a19FeiemEaA5Yg+7IIlq0k5oYfCpNZkCODRjU?=
 =?us-ascii?Q?werJZmUH+dWhHsQB3307hzOAVeyjBFgFeQLWBShXXVeTvQErmWzrJWVidhfZ?=
 =?us-ascii?Q?Wai4fK0aJmBP7+TYbHX1JzdYTYxIkNvPH5SHd9y93LPzjUcSqVe+kohaQDzW?=
 =?us-ascii?Q?hDBlCk5j1+TnKQl98UGNvtufBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(107886003)(36756003)(2906002)(1076003)(83380400001)(6916009)(316002)(4326008)(38100700002)(6496006)(8676002)(2616005)(5660300002)(66556008)(66476007)(66946007)(86362001)(8936002)(186003)(52116002)(6666004)(508600001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ITpLkSB84RB6Nv0N3IKbSAnJ0D8QV//4VFADccD6b7p9xx2EvRlL5pQaxRge?=
 =?us-ascii?Q?wfSo7vEeYRKyIjBR1nFqdoW6UnM8aJuJVNkiHE3TbqmXaXBTVFB/1yNyjhL2?=
 =?us-ascii?Q?LksBTrhZQ3KGFDct6IOe/b1+gkMZD2azR44XV4Z+HGDs/jHW5keCT2XlJT/j?=
 =?us-ascii?Q?E4aCagGy3twOzwquFPo9iQLTtPUVW+KapeD39DPcAM382/8D7sHAY3wrM8Sr?=
 =?us-ascii?Q?cu5kQHiC83LYWC8hViBreRK3O6mROmpa38UcGoV69JDFXKilGaGXdegEaMyX?=
 =?us-ascii?Q?8z3E1FYhxDtKflGcl8SsuW1WCt6EzGyw/VHGxUJv8hDw91KyEdXXnZrXxg3A?=
 =?us-ascii?Q?bBNm/mapQHH0QXTy4XZe2OABAOQNo+ARdVV6QrnrrqgncZYe8sKDvyj0VXo4?=
 =?us-ascii?Q?HEeejzANi0d60ffALwVbOgjvq8AG44usHp45YIu66Ix8KXmM8FYN6Z6uXSUS?=
 =?us-ascii?Q?B0Z/I9lFA8iheWaKUTLiCCRYkWNUy1NsdB9Lz668shglfuq0lLHuWFNLEcty?=
 =?us-ascii?Q?f2yr8MeiSSTiLM1LY080mET2aTvIT5nERt59G8+by1eq1AUz4dbLvH+j/omP?=
 =?us-ascii?Q?x050Xb7Zy5rMsiAPhB5hA2RBh3ZaJlcESAIZhTth705Dkay/O+ZEWQptwnLO?=
 =?us-ascii?Q?DZGTqQFOnU7wM33eIKCl0Ul0UeNet2wJ5itVPmpDZxAKeLgD78IyhJNe5rP7?=
 =?us-ascii?Q?fb4nHesUurPUrRWh9bi0G5h6vDqqJWCKZBn2dM26cTggm3aQd91MyCSo0EDN?=
 =?us-ascii?Q?iDVHx0lw2h1qfbb+avGov/9trlsRLMVU4aU/zYeQDinMB3UTXS66S/xQwPXH?=
 =?us-ascii?Q?8dlYE/eUlkkrBGlGku6D4dg3BAVDraTQmtvb5oOLJfUp8S0GdhHd12o3wrSw?=
 =?us-ascii?Q?dvKZzAm10soQ1UDswUr4/xKkhde8go+GEIYjkdsY5ocHPfr6XJPvPVsVW8H9?=
 =?us-ascii?Q?g+jzP8MjosM3dO3p++VpWONKXh+JyQUM/ExzMyY8sDGx545avYxJIBM974xb?=
 =?us-ascii?Q?ZvooOdAuDaBLjPwnB8ZAjSeOXACAP/sme9Sy1XYxyZdU0jnNF1LvFCXe8a2V?=
 =?us-ascii?Q?boSs1oeS6H4QjHjnYCnzOrE2mMhWGAs+CINbEcVa7oZ1u72UeKd/dlXbA5PY?=
 =?us-ascii?Q?d2iXbbVFHrKXfpaOem379esWTNBZggwQlwB/X8N5nwgxtD+NN/VjLSlVkJ2r?=
 =?us-ascii?Q?VoShHyYQc2Yaa1AvmObWt7bOrzt5Hx/V0+83sR0XgeZVR4zUbFrVQpVfahbS?=
 =?us-ascii?Q?Cb9pDzQqZ47CSgRkbmE8oI0JcQLM+C56TwY703AyImVYUmaQ6iV+RhM41fJn?=
 =?us-ascii?Q?/KDT/I0xBDMkW3q8BqgyB3FQhdqXCh/vloYVgF6lbWZ4/FYsYzNbJrVlgog+?=
 =?us-ascii?Q?vq7M0cY6tAh7BhIHYvNh23PYOVEl?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b0635-af37-4c18-1197-08d98fddd31e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:14.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VltW1xzuFfbsFC5u5M7FZJldRs/Alb2tzncYzppTm0fSwjX6yOm+cv72o7wcosZAo8P560/4yh0ZdVCJ268yCqROG25bnzrxEFVMAExa3ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the tag date and tagger ident to check_signature when generating merge
messages to verify merged tags signatures.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          | 14 +++++++++--
 t/t6200-fmt-merge-msg.sh | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index d2cedad6b7..95b747e85a 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -524,6 +524,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		unsigned long len = size;
 		struct signature_check sigc = { NULL };
 		struct strbuf payload = STRBUF_INIT, sig = STRBUF_INIT;
+		struct strbuf payload_signer = STRBUF_INIT;
+		timestamp_t payload_timestamp = 0;
 
 		if (!buf || type != OBJ_TAG)
 			goto next;
@@ -533,9 +535,16 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
-			if (check_signature(payload.buf, payload.len, 0, NULL,
+
+			if (parse_signed_buffer_metadata(payload.buf, "tagger",
+							 &payload_timestamp,
+							 &payload_signer))
+				strbuf_addstr(&sig, _("failed to parse timestamp and signer info from payload"));
+
+			if (check_signature(payload.buf, payload.len,
+					    payload_timestamp, &payload_signer,
 					    sig.buf, sig.len, &sigc) &&
-			    !sigc.output)
+			!sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
 				strbuf_addstr(&sig, sigc.output);
@@ -564,6 +573,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		}
 		strbuf_release(&payload);
 		strbuf_release(&sig);
+		strbuf_release(&payload_signer);
 	next:
 		free(origbuf);
 	}
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..2dd2423643 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -91,6 +91,26 @@ test_expect_success GPGSSH 'created ssh signed commit and tag' '
 	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted signed-untrusted-ssh-tag left
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	git checkout -b signed-expiry-ssh &&
+	touch file &&
+	git add file &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-signed timeboxedinvalid-signed
+'
+
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
@@ -137,6 +157,40 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . expired-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . notyetvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedinvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.31.1

