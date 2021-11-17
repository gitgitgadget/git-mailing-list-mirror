Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A7EC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95BF6321A
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhKQJjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:39:11 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235262AbhKQJjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:39:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMizy4YsMeZ7GC/J9EC5DNMjB+U/sm39i2mDdNFWfZbDCp+dqtOVqt2FaZy8+GRVEOOlVvSM2qMRdnVMFYIbqIHi7n5Ify8AkSBe4sutr8VTPsMx5snCiKlJZrM4O5dMjuU2GTRiIwn298kAYJCWTTMZuyOqmXY1xuHj+GzoCD+UTjPr4GzYIRGOucAuHdd2jon+/7zKX7TxJfjdvRo7pnkzWJRv8Vc7URXeGyCivfDiBuW8nAlW4GiAwK5pjH9mKGJMpKakq8IwvhnJR+mHacyRJ5WTJxYHY71ftd2rYLlJKUsRWUcrLC7dxJOiZkCUu3ifX0jPDZ1foM7QY0SxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=i1WOPGcU+83dT0hyw1KC5XlzWUrC6ZlAPXo8WfNLvMe0UvPcpAXj04zOotAUtzkeHaluelb/FLLrPoVdueFF7zCHV0e4vAaiHwDgNMJP98NcyZ1AWFBvbGlt7fPMZ3nd8wgjtpEBKLs7zIzoR937f0zmn7uoYWeXkxkGTx12Jsf5N1mpEPNUuHfxeuQuTTfWylQfAQ8eWRepl6CPI7sOrGoT1pS4x9ImF4lv6vlHUpI9/HDjav4RUmx/TWcMEZji0VOhJEjovqX4f7cQni07fd9Q08VwPooS3v6acszWjp1NltlT1ha+ZcfMXtMJV91hQq9I+HlY7qTc8JIYdwaeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=Qpv1IQ/UssGGSGRdaEu9ZtH7GWAuMu3+h1i1keZ/BFYmihv+HZpPTESTOBqYPYcnhhvVN0tD7Aro+SsPsSeQj/unJW1XRjVq1UWLVZNbeueb8EwYcVf7+B7LG82Nq6PzwyaEQERby6l0RmVE0bWQfiNkOsC/cMP3Wuw5EdlSP6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 09:35:51 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:51 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 6/7] ssh signing: make fmt-merge-msg consider key lifetime
Date:   Wed, 17 Nov 2021 10:35:28 +0100
Message-Id: <20211117093529.13953-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::9) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:20b:488::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 09:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd788b4-86cf-4c16-3dcf-08d9a9ada440
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38201A3D01D9EB440EF27EEBB69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZUI+F0Vcf42ChqRBnh65twAmt6zlRTn1BMxhPhQLcl30PtqtjwkZmJ71aNmd?=
 =?us-ascii?Q?wWQnIqlY7HYV7x33cXECuFtvHU26h2WC+0UL2V3ZTMxFhm3vACTC4KSyecox?=
 =?us-ascii?Q?CxlhVPRjXxAeRWhy/Nh5hLneVD0PDs+T4JMc4ERGnV3Lz+D8Obg0MK11LfQu?=
 =?us-ascii?Q?OXPRgTnWntG6YgcYARX9C9LMiBTqP0QHwiyt40Vlm3C48j+VSpTZGMOVEj8Q?=
 =?us-ascii?Q?lg/7P51fpy4WuPzBof88yQAoMuqudJkzb1lJRkMJCg7e3g/ukKr9K38grSwc?=
 =?us-ascii?Q?eYrjJmADMjhaNaC5Q+JTmqNj/2meT3Cu3Bcn2DLXOCigSDy6m4Lc2Zix4ViN?=
 =?us-ascii?Q?7JiJjFDpMS4bvxQ+jVcOK+gRVA7Pa003xLGjqnsA/GVGTcZQ7494OqZBGSat?=
 =?us-ascii?Q?95I5cd1+0UVgCJc7wCM/g0weoDUXVPp2RrcCbRxWyKyc16oXr7GCDc02bHfu?=
 =?us-ascii?Q?WEMvURctiaDsAy4mw+lhbHV8Kh+/J21rT7+sGLyUAEVJXXnv/2ikqk05hrIq?=
 =?us-ascii?Q?nyTuHLFKRusmYZpZX6jef60qjPCkuvLyLrj5H2Yh/RhTGppowbVRrSITj2wa?=
 =?us-ascii?Q?gDDtZ/4GlAcF6Z2XHucIp8i6ids247LhW86IQKm075XMeAB1s1bMefS8gVyQ?=
 =?us-ascii?Q?W5z5Buk0Rv2kf5sHawgyBOi4NAMd8XjuYF+q2qXPM5oU4Jn8j119VHfgloBo?=
 =?us-ascii?Q?DM24EgQlSDCvGeLiWEiQZodKbq1lZiw42TBXdS/P8+VuzysIuA1HQNgk4ebL?=
 =?us-ascii?Q?VtkLQ4un1RpLql3h6SOoVIpc4kS8z3Fzj9q2rSSIdUANHm7e6XPlQcDBYzdW?=
 =?us-ascii?Q?VxxE/hbJdHYL87bW7e2bN2i4r76W+rePUA/yTRxg/WxiF1lZiC36n7Dil6Pu?=
 =?us-ascii?Q?XjiabjhQ+9g+OcvASn6hOlZIjYn18JYtUQwmEEIlrPblaMGfAmfOoaLlvKVq?=
 =?us-ascii?Q?bvIecskmwLmyJR7UJFhpKjBiHrqmN/jjrPff9V9MVBqBxOSMst3xubJ1Avqa?=
 =?us-ascii?Q?8fWDXMfhrlnKcJuPw3K61oXs6Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVZoOgvNdDc4QrdvqhWCiGk8sd4hqNxDTGxrp1JzlqoecvgNJETDUx3ZmM4G?=
 =?us-ascii?Q?Ax7dnzYONROiKR367Dj7Fm/1NJjFndRi2AjfsnZJOkBLYadL0lfnf8iMgafF?=
 =?us-ascii?Q?mr+T1/6MtFoBNMK66xMs6kSoj4kjaxbwZTi0pwT5MiYS5TyvtYGO6m355/qI?=
 =?us-ascii?Q?9HIiJjPh/5G+0HWyW6+GXS5LLQnWDxsMGqf2QIxzjGDmLW1rkB+iYpuhhb+P?=
 =?us-ascii?Q?BAXlU9+Qa12i5t2LR9PD5QSvQH7V4RktMHBZ22DAgCgK5CdLcRH2wgNpANd3?=
 =?us-ascii?Q?hEOGKERhOl6FoiwXb61pE2TIGw9Nf+dRCAI9Op4l5p/yYGG3Lh0rzrD8BKIS?=
 =?us-ascii?Q?ZJU5taQHQWjmVkrKIpZC8mh3+L5YgZX7A8zbIFwJhNXlEtvGSfoAZ2PS0APk?=
 =?us-ascii?Q?4Cbgg3+H72Rudr7kxjxDN9H3AfiBAPH4HMOC+Vbm3OAJ6vj6wqfhhbHmX29t?=
 =?us-ascii?Q?UCks3Ln/HOf9Mp/yJIwRw2r6rJiOs/otM/L3b90vpN7SsOisMgmDxzWM+jkK?=
 =?us-ascii?Q?QUd/bQKhXQMSVpmWKUXcpuTg5YfdCO/lCIq6GNXb3qEuVlPZMRm49Q3EPrr9?=
 =?us-ascii?Q?eczrYUyZuym8oH4U78cl7cjT2WtFMfNQvu4dehHAqh3hBagUxzVqi1MjzQ6e?=
 =?us-ascii?Q?xvtQ6T18Vii/VcS460L6GxaxU65Cdb6aK3roxOGvpUEqpf1FZh4CN8nVkRxy?=
 =?us-ascii?Q?lfctWXEvOORR4S7mRoIqKS268jBIuDtGhxHzKsMmCt1xGdBuhw9004kLIO5N?=
 =?us-ascii?Q?lhwwY2GknUhQxpEpZEbTlt5KW2pOTqZivczxcWqxHUb5h3llRJRMyk0Nucja?=
 =?us-ascii?Q?PCJJ+2CFX+ogHcXeL8w9QBgqsZIyHUlPr1EPZPC4LE2wVXAeaKnMQ4MfsjL1?=
 =?us-ascii?Q?yh8mN3cXHrW+vMHNb6afom6/ODkDKZAPwFCiNCzcIONkTCkd3laj2g3/x8f8?=
 =?us-ascii?Q?73XL1it40B6S6JhejAhCd7K4LTm7cTGno9kWECSVapQpTB1YSf2WWGj401kN?=
 =?us-ascii?Q?8L2IZ8YxoV24x+ueGWVgTQJ7omkUrS+Bbrs8ji4/F1fObIcBUDG7Mwu/XLQW?=
 =?us-ascii?Q?iF1Iw60XvOG9FAQafH+9iaLo6A4GZC9DfGcvabMZCmJGrfU4YGUif2mixHij?=
 =?us-ascii?Q?hVmgzrA3muPR1xaWSCtDYaBi6ZxXgQsVq0oBFv0bYmLq69tsGUTpJd1bpG7r?=
 =?us-ascii?Q?PeluTohjHKCM/CVyxvNbDAycKtkeOhWjIH7zUR89lOJ3OujCA/92syYUeDIq?=
 =?us-ascii?Q?2FDN/DA3SfwcG6/2eILi5hdVoieG3g5+nDcg36eUD3LEfjqlbf/A/EmO3VKe?=
 =?us-ascii?Q?soj6iS6wn1yeaM5V81ffMHt9C/d4/5CSN3DPc8ut6OKTF5O8rHIP96hI7wvB?=
 =?us-ascii?Q?MMYAeRr77zo0h+nuj1TJrDzFkMqBbF9kKw5LyrN2rkKfmEPdWyzMUyej+HAX?=
 =?us-ascii?Q?6u6aFaiWPG4w7zmu+IULkVaJxI9SNoeTAIWFhnYPty6RM6NjeRFqGC+B1Lol?=
 =?us-ascii?Q?XNoQYIouZe2Khq0AxDGFLeZdAPqiOwzp5elKHR2iAu5TirqghMPhfA3bBy9b?=
 =?us-ascii?Q?kcPC9xeUE0W0viZgWL4xAzVlTa11uxePzrSodD0qtaPXsO/yK4sNEFLMMS80?=
 =?us-ascii?Q?RM6EKSGV6+NvkB3ffQ6oUPJPbmTk18FojV25VNso6SMGRKa8oq4vRc6E1peV?=
 =?us-ascii?Q?V80cSwwJ0BSA92F517as8sX/PPT+fAGAtkc+YkW2BZoQDUlaLEVYvRBy18W/?=
 =?us-ascii?Q?a/PRRCjtS+L7DqgFbmBhCg2/nCQZsLI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd788b4-86cf-4c16-3dcf-08d9a9ada440
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:50.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNpacsfz1WpH+Pmc4XeYQr7WpcYjeZ/gOSuisX/BFknqis1Vz52X+bMFHSbmvxPnV9yQB3ALJqcH6NDdFNtb+gUzdu0AiWQeAWILp1riTIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when generating merge messages to
verify merged tags signatures key lifetimes.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          |  1 +
 t/t6200-fmt-merge-msg.sh | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index deca1ea3a3..e4f7810be2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,6 +533,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
+			sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 			sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
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

