Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113EA1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbeKPSLn (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:43 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47644 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbeKPSLb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:31 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7xbKs022964;
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by3kq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 16 Nov 2018 02:59:58 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 16 Nov 2018 02:59:58 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 477592212287;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 04/11] fast-export: use value from correct enum
Date:   Thu, 15 Nov 2018 23:59:49 -0800
Message-ID: <20181116075956.27047-5-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g1796373474.dirty
In-Reply-To: <20181116075956.27047-1-newren@gmail.com>
References: <20181114002600.29233-1-newren@gmail.com>
 <20181116075956.27047-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=507 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ABORT and ERROR happen to have the same value, but come from differnt
enums.  Use the one from the correct enum, and while at it, rename the
values to avoid such problems.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f5166ac71e..e2be35f41e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -31,8 +31,8 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum { ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = ABORT;
-static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ERROR;
+static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
 static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
@@ -46,7 +46,7 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
 {
 	if (unset || !strcmp(arg, "abort"))
-		signed_tag_mode = ABORT;
+		signed_tag_mode = SIGNED_TAG_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
 		signed_tag_mode = VERBATIM;
 	else if (!strcmp(arg, "warn"))
@@ -64,7 +64,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 					  const char *arg, int unset)
 {
 	if (unset || !strcmp(arg, "abort"))
-		tag_of_filtered_mode = ERROR;
+		tag_of_filtered_mode = TAG_FILTERING_ABORT;
 	else if (!strcmp(arg, "drop"))
 		tag_of_filtered_mode = DROP;
 	else if (!strcmp(arg, "rewrite"))
@@ -728,7 +728,7 @@ static void handle_tag(const char *name, struct tag *tag)
 					       "\n-----BEGIN PGP SIGNATURE-----\n");
 		if (signature)
 			switch(signed_tag_mode) {
-			case ABORT:
+			case SIGNED_TAG_ABORT:
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
 				    oid_to_hex(&tag->object.oid));
@@ -753,7 +753,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	tagged_mark = get_object_mark(tagged);
 	if (!tagged_mark) {
 		switch(tag_of_filtered_mode) {
-		case ABORT:
+		case TAG_FILTERING_ABORT:
 			die("tag %s tags unexported object; use "
 			    "--tag-of-filtered-object=<mode> to handle it",
 			    oid_to_hex(&tag->object.oid));
-- 
2.19.1.1063.g1796373474.dirty

