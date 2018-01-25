Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB7C1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeAYX65 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:58:57 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:55295 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeAYX6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:58:55 -0500
Received: by mail-ot0-f202.google.com with SMTP id 40so5942607otv.21
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PoPTneuj8NTTU/fFEn1x9koX3PYfoDoyEjXKEnL/YoM=;
        b=YRTzm9GAFJFrnqD4PIEtVLOeUJS2iuALmQCRpi8232Ss2dyE7UbnvIH7AH55sWPknj
         VlVbtblwNO3SMZdUrDi1UPsxLBz8iBMmjsodKRBmKw5BqlLKtvgt8HK54rJYOFP5CEh4
         Qq2ms783n0fJsQQp3K6e1dShUHlSDMZpdSsrurompd3Yo53GmP87PEJtsrlLhoCHRqjH
         XqgvdOnxMCPHF6IlyTpC4y8xfWp9upQ4Do0bR6InsT4aaOpMpmw0b+uzZHFK/Wju8F7N
         OPIsH8swZgLkbZufxRDou3nW2kmbHOMFbn/eFb1yOlAFo9+LQ2JXpjscVvAbyeVVAfyg
         m+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PoPTneuj8NTTU/fFEn1x9koX3PYfoDoyEjXKEnL/YoM=;
        b=E/8v4/I+mVcmTNMmtIJHWDZ95dZ9WtaP1ZGz9W5PeWFKE4xqCTfES7XOdFKovfm3Gb
         43AbUbUL9tzEy3dtP4RhrLPqyHieaF4UX2CF3+IDvsDb/ojDYvG6JUftHuwwN+mIfQ7n
         awR8bDnhOdKKpdkl9iB860zuo8nKZqvBs47A/sbcLaCl56Hzyxf7SNb3A/hENSiIwlPe
         ngEMroMaqDGIyOgOAUb6tywittdSEPdEBxf3bE+ExGmAC4KR0ZyLsIf3aFsqPkQFlP1r
         HACiEgPjQGgAX7Kk9FblZT3oG1TvjX68PX7Z7EDnyKj6/yKRMys+yThsFAENnOU5tDt4
         HjFg==
X-Gm-Message-State: AKwxytd0HaTHVQVLpqP440GU7QTfrT8Eyla69vydKCJi4wgpkeKEx85v
        ll69sipVZjOJDpkPb15LaAEaxu4sZMtwvv7HXEe/OGQILEw0f1WYsu8fR1qlBlT4JxbalDen3KD
        dQD2qV/DrPny0Acd6mLEBRSNpA4inkWICK0fd1W0JUds/EtzSod+gxQeKEA==
X-Google-Smtp-Source: AH8x2276fxj9Un78oFJOXOIc8GwLc9vNIpUAd4ouw4w1dl1sfeHn3Dqyb7nB4DG623OBnfBeVabJ8drw1mI=
MIME-Version: 1.0
X-Received: by 10.157.89.162 with SMTP id u34mr7307oth.83.1516924735161; Thu,
 25 Jan 2018 15:58:55 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:16 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-6-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 05/27] upload-pack: factor out processing lines
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index 2ad73a98b..42d83d5b1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -724,6 +724,75 @@ static void deepen_by_rev_list(int ac, const char **av,
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
+		*depth = (int) strtol(arg, &end, 0);
+		if (!end || *end || *depth <= 0)
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
+		if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
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
@@ -745,49 +814,15 @@ static void receive_needs(void)
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
-			if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
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
2.16.0.rc1.238.g530d649a79-goog

