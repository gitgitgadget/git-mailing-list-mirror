Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE371F453
	for <e@80x24.org>; Thu, 17 Jan 2019 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfAQXdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 18:33:16 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45041 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAQXdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 18:33:16 -0500
Received: by mail-pl1-f202.google.com with SMTP id b24so7001505pls.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 15:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HdeDuwAZPdUr/VAFBxrgeZ2lN5TCQT8dJ9aj53PZdUs=;
        b=Ps8pSjBqp814Ma9fm7EGVNSBpz/8ywK6RNT+q2NTm6od6SnUgO23SlWg6hh/4V83Ih
         GAUciRcouNDpxuMETYpe+TA0zl/LTunesxrQgLd+cVwZtOCd4T2waUvvWHbzhAWXH/tu
         j+R6+BrHDuEvZtUJsLGBiUxTJkgkYvef/x25CMsP6Q4/9vD6Auxi46ZAembSEaMgkXei
         hgB21KFP8defa+Wzprp1CZFGJ8qfRqp5/0loyoNlqkG1BsfuZVzRi1lfLDFYNQ/TGiwh
         NeyvONMsoi4p1ZcHiNlypI3saO4oeo+UI2lZuI9PyVUe49uJlKuyP8ieL9LyIIhvOGa8
         6qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HdeDuwAZPdUr/VAFBxrgeZ2lN5TCQT8dJ9aj53PZdUs=;
        b=AhiZP/CtWXXLZE1pjkQFSFq1zc39GPdf2y0dCEWxd0ROjRrR0c5DS5ucG2K3GUO7+t
         wSY5NVwtt6bNvuSOWvzPxmrvyQhT81LTWXAV1ZXOVA4xp1/oC5mpRmB4kmxuQAdqPM7p
         cCD7TH2BKa17HqrUhn7fWdWiTQbZlOuzsEArFPDjlOf8h2GQgY13sSFshGRnlDHLn/Gt
         HvyiIX2G7cEg2AUzHn5iB5Rh9h5+tQhRnYKbZPwhrE8ObUJqHMMi+HqtueFy1+g+VroK
         7TbxVDiWLoE246TI6ID2OofHtp9rcrkaWpcdFt8BkeM93hIhjNk84TNxnzlCThngy4Ar
         F6xQ==
X-Gm-Message-State: AJcUukcLtqfeAu4DkLAAlg0sGgnGz4wsYjJ/i7rWD1PsAh86DesP+2dv
        eXRKb+0zd0DItDqgBmTAirvXbpYCfz7sUZP35b8DhPvdCBrLlR0aBCrGaGBHexxvaaVlNiVV5D/
        YUbnMEWyUOryUOVf3geA3EVP8M2pFwTRzp5F24vARwTeW90AX11DCJLwFp0/FOk4WzgHkdjqOVc
        Oc
X-Google-Smtp-Source: ALg8bN7UHgMnMv9FT4vSQzVSWVTZk0MaTYkFafULAPbJngddejn7bbVwSkDJwohQBeJMNGPKlX36Df/IigofQPTGD1n6
X-Received: by 2002:a62:c541:: with SMTP id j62mr648192pfg.147.1547767995390;
 Thu, 17 Jan 2019 15:33:15 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:33:05 -0800
In-Reply-To: <20190117200207.81825-1-jonathantanmy@google.com>
Message-Id: <20190117233305.42679-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190117200207.81825-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2] ls-refs: filter refs using namespace-stripped name
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user fetches refs/heads/master from a repo with namespace "ns", the
remote is expected to (1) not send the real refs/heads/master, and (2)
send refs/namespaces/ns/refs/heads/master with the name
refs/heads/master. (1) indeed happens now, but not (2) - Git only sends
refs that have the user-given prefix, but it checks them against the
full name of the ref (the one starting with refs/namespaces), and not
the namespace-stripped one.

This is demonstrated by the patch in the test. Currently, it results in
"fatal: couldn't find remote ref refs/heads/master" despite both
unnamespaced and namespaced master being present. With the code change,
it produces the expected result.

Check the ref prefixes against the namespace-stripped name.

This bug was discovered through applying patches [1] that override
protocol.version to 2 in repositories when running tests, allowing us to
notice differences in behavior across different protocol versions.

[1] https://public-inbox.org/git/cover.1547677183.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1:
 - updated commit message to explain from the end user viewpoint
 - wrote the test using end-user-facing Git commands

Thanks, Junio, for your review.

> OK, so "ls-refs: filter based on non-namespace name" (in the title) is a
> means to the objective 'ls-refs: make sure it honors namespaces"
> which is a bugfix?

Yes and no. I've updated the commit message to explain that it honors
namespaces in that it doesn't send the wrong refs, but it doesn't honor
them in that it doesn't send the right refs.

> The new test peeks at the protocol level, but wouldn't we be able to
> see the breakage by running ls-remote or something and observing its
> result as well, or is the bug only observable with test-tool and not
> triggerable by end-user facing git commands?

ls-remote wouldn't work as its filtering is incompatible with ref-prefix
(see 631f0f8c4b ("ls-remote: do not send ref prefixes for patterns",
2018-10-31)), but it can be observed with fetch. I've replaced the test
with one that uses fetch instead.
---
 ls-refs.c              |  2 +-
 t/t5702-protocol-v2.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index a06f12eca8..7782bb054b 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -40,7 +40,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	const char *refname_nons = strip_namespace(refname);
 	struct strbuf refline = STRBUF_INIT;
 
-	if (!ref_match(&data->prefixes, refname))
+	if (!ref_match(&data->prefixes, refname_nons))
 		return 0;
 
 	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..3d802aa587 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -514,6 +514,27 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	grep "git< version 2" log
 '
 
+test_expect_success 'fetch from namespaced repo respects namespaces' '
+	test_when_finished "rm -f log" &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" one &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" two &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" \
+		update-ref refs/namespaces/ns/refs/heads/master one &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
+		fetch "$HTTPD_URL/smart_namespace/nsrepo" \
+		refs/heads/master:refs/heads/theirs &&
+
+	# Server responded using protocol v2
+	grep "fetch< version 2" log &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" rev-parse one >expect &&
+	git -C http_child rev-parse theirs >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	test_when_finished "rm -f log" &&
 	# Till v2 for push is designed, make sure that if a client has
-- 
2.19.0.271.gfe8321ec05.dirty

