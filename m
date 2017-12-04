Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A691D20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdLDX7v (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33247 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLDX7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:13 -0500
Received: by mail-pg0-f67.google.com with SMTP id g7so9388257pgs.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEPSmU2I5ndMcQZaqFoj4gqgJlWmVkm6xJO5Y/1alak=;
        b=qdGs2THqiQnfBS2DZDx0971+K2GWPPCJdcflDd+12d0aRDmV6dYqq8JP17FMs2+6wX
         3D/PQGEC8za67QIwEmc8QeT2gxV6xBe9tRshdNTv5XGi2Uyfgy4x4jBFLKH1WHBxmzdS
         XVEDxBTL6tHrG0aQA8iz1Zpb2cCBgZ9B1S+Vudn1BHqAQk7tS4IoEWdE9qdL3pWMa35f
         960kAC6Clfv4KkPXf1C/qlsV+JB6sm6xc0vA/COCbICNbQhuWneemxXdH+0AXN5aY7i/
         89znZsxApp3NBvE0GMMP+huUj8dlnr3xz5qI672j6O0OXecer19Oah6T6Qxa93Ty3A2Y
         ZGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEPSmU2I5ndMcQZaqFoj4gqgJlWmVkm6xJO5Y/1alak=;
        b=Ms/R5hS8sFvuaIgknWPzfTDlOBXUG06c1x2ImtfjsGK7zsuUzorOzKdMNVfnzsqBA2
         a9mTsJiJwZVwiffz/wDZzngzl5ZprvtUSo3OdrxDeUlww6L4jkk0qMnDc6eW4Ia/y5P0
         +Q8TBnOpOvVvaNxfsqV6DayLC27aq4wmWldBJ/dRY0CGa0cSipG7XL0ZnEI3x7U2kKRg
         h/fZmkhHHqYvPhKXvD59SSpwNHeij7nJWdanZ9LcIjsxvwNFgvTQfsvslRkrgiI5E/7v
         A2Aq06FkdCUFUB8st7YG/EKF6pQSsXii6Ze/QVa80ft6TjjLlXpgW64siaSEShDcU8cz
         Bb3Q==
X-Gm-Message-State: AJaThX4zQIOX+6rnOjE97lWSJt61DgQfEursVS+9qTQiZ86mYmOGk6rs
        UXAJGQGMTKctVD8pwaqVT36HPkX2yLg=
X-Google-Smtp-Source: AGs4zMaQg7zrFDWOIZ8EqfCTpMqI3ehxF2qJxmo07EkKCpte7G6TRU1Z+8jKzk8WGYnAUCfN9EebHQ==
X-Received: by 10.99.113.91 with SMTP id b27mr15444135pgn.351.1512431952337;
        Mon, 04 Dec 2017 15:59:12 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:11 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 05/15] upload-pack: factor out processing lines
Date:   Mon,  4 Dec 2017 15:58:13 -0800
Message-Id: <20171204235823.63299-6-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic for processing shallow, deepen, deepen_since, and
deepen_not lines into their own functions to simplify the
'receive_needs()' function in addition to making it easier to reuse some
of this logic when implementing protocol_v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 upload-pack.c | 113 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 39 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2d16952a3..d2711e4ee 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -731,6 +731,75 @@ static void deepen_by_rev_list(int ac, const char **av,
 	packet_flush(1);
 }
 
+static int process_shallow(const char *line, struct object_array *shallows)
+{
+	const char *arg;
+	if (skip_prefix(line, "shallow ", &arg)) {
+		struct object_id oid;
+		struct object *object;
+		if (get_oid_hex(arg, &oid))
+			die("invalid shallow line: %s", line);
+		object = parse_object(&oid);
+		if (!object)
+			return 1;
+		if (object->type != OBJ_COMMIT)
+			die("invalid shallow object %s", oid_to_hex(&oid));
+		if (!(object->flags & CLIENT_SHALLOW)) {
+			object->flags |= CLIENT_SHALLOW;
+			add_object_array(object, NULL, shallows);
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
+static int process_deepen(const char *line, int *depth)
+{
+	const char *arg;
+	if (skip_prefix(line, "deepen ", &arg)) {
+		char *end = NULL;
+		*depth = strtol(arg, &end, 0);
+		if (!end || *end || depth <= 0)
+			die("Invalid deepen: %s", line);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int process_deepen_since(const char *line, timestamp_t *deepen_since, int *deepen_rev_list)
+{
+	const char *arg;
+	if (skip_prefix(line, "deepen-since ", &arg)) {
+		char *end = NULL;
+		*deepen_since = parse_timestamp(arg, &end, 0);
+		if (!end || *end || !deepen_since ||
+		    /* revisions.c's max_age -1 is special */
+		    *deepen_since == -1)
+			die("Invalid deepen-since: %s", line);
+		*deepen_rev_list = 1;
+		return 1;
+	}
+	return 0;
+}
+
+static int process_deepen_not(const char *line, struct string_list *deepen_not, int *deepen_rev_list)
+{
+	const char *arg;
+	if (skip_prefix(line, "deepen-not ", &arg)) {
+		char *ref = NULL;
+		struct object_id oid;
+		if (expand_ref(arg, strlen(arg), oid.hash, &ref) != 1)
+			die("git upload-pack: ambiguous deepen-not: %s", line);
+		string_list_append(deepen_not, ref);
+		free(ref);
+		*deepen_rev_list = 1;
+		return 1;
+	}
+	return 0;
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
@@ -752,49 +821,15 @@ static void receive_needs(void)
 		if (!line)
 			break;
 
-		if (skip_prefix(line, "shallow ", &arg)) {
-			struct object_id oid;
-			struct object *object;
-			if (get_oid_hex(arg, &oid))
-				die("invalid shallow line: %s", line);
-			object = parse_object(&oid);
-			if (!object)
-				continue;
-			if (object->type != OBJ_COMMIT)
-				die("invalid shallow object %s", oid_to_hex(&oid));
-			if (!(object->flags & CLIENT_SHALLOW)) {
-				object->flags |= CLIENT_SHALLOW;
-				add_object_array(object, NULL, &shallows);
-			}
+		if (process_shallow(line, &shallows))
 			continue;
-		}
-		if (skip_prefix(line, "deepen ", &arg)) {
-			char *end = NULL;
-			depth = strtol(arg, &end, 0);
-			if (!end || *end || depth <= 0)
-				die("Invalid deepen: %s", line);
+		if (process_deepen(line, &depth))
 			continue;
-		}
-		if (skip_prefix(line, "deepen-since ", &arg)) {
-			char *end = NULL;
-			deepen_since = parse_timestamp(arg, &end, 0);
-			if (!end || *end || !deepen_since ||
-			    /* revisions.c's max_age -1 is special */
-			    deepen_since == -1)
-				die("Invalid deepen-since: %s", line);
-			deepen_rev_list = 1;
+		if (process_deepen_since(line, &deepen_since, &deepen_rev_list))
 			continue;
-		}
-		if (skip_prefix(line, "deepen-not ", &arg)) {
-			char *ref = NULL;
-			struct object_id oid;
-			if (expand_ref(arg, strlen(arg), oid.hash, &ref) != 1)
-				die("git upload-pack: ambiguous deepen-not: %s", line);
-			string_list_append(&deepen_not, ref);
-			free(ref);
-			deepen_rev_list = 1;
+		if (process_deepen_not(line, &deepen_not, &deepen_rev_list))
 			continue;
-		}
+
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_oid_hex(arg, &oid_buf))
 			die("git upload-pack: protocol error, "
-- 
2.15.1.424.g9478a66081-goog

