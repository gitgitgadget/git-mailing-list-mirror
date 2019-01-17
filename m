Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32131F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfAQUCN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:02:13 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:41539 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfAQUCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:02:13 -0500
Received: by mail-ot1-f74.google.com with SMTP id n22so5311952otq.8
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9bBFBU7XI4T5SPKXbqGMfvHLHUZ9lUQCsd3961/ip4Q=;
        b=ON3/AhPuqsrHXnxig53Iaq+pjvr/jg8jHxPmLjL83moa0Rkw7pNd+9lClgtRILhG7m
         bFXsEKGNH/+YEYMUxJuYGN1Ptk0HxxASFUvmcSHxCbVcGBd4WaEIfkVREV4Z3XBqdmKm
         vlkgxm00InEaxlIv3oRhJnOyjSAiR/cumJG/QWzweAQj90q6f/cvwyaHnL++2UVBl2Ru
         GB3syOJx7bKck7n+qW5SQNgGr5HpjYJSHDYdhaRrpmCvAlyFsM+cs9sSmFTXiOFqYLQy
         KfeM2iEyMvpTnXqfDef/MxdBZlSyUeEFwiy/KQ6a0yMyYZJTZ5jw6lEvziDauAMSNpDr
         vGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9bBFBU7XI4T5SPKXbqGMfvHLHUZ9lUQCsd3961/ip4Q=;
        b=jOy3GROKzw4MLoV34V0pcFLUDeSLa+bjAvF6yFZ/YzugODxedIaaEE9FOHHNls84Ru
         2BcjvB01a4NjsA8XctBqIn2Kxnn2PDQ+osSbyfurrksHzexPOZUSRqQX9PQBv15MxL8J
         Pv3b2YwbY7FquVNbh2z37riA+hM2lFDv2x3fTyxhjJp3fqlQ9kfxrdtyswZ7XwDd9uqE
         FQiImrChOkVSxRbDBXEf+Sb+qifx7FS5P1rMJ0lZYry2JHNhcYpdXEwdjjAGDWNQY9io
         2XIjVWfG6AjXLruDOgcTIi4t4CjfPJkvaVzmALNkv2zsI1XGdz8V/YkxkWcjn84JC7ZZ
         2ZlA==
X-Gm-Message-State: AJcUukdlUkNuTno6nNSPNTVATULSliaZ4tzzHRqSgBj11R0Qd4g4yWcR
        cSR/9f0d3QcVaF4bM2YmmECtTN84MDlyIpLV04FgWeJL4R/gaMCZWKvknYUn0poZ/6eneCg2LQx
        nipSyz9MA/CmO+6rqMX/lxnJekeSvWNwUE1sas9CwMiDNYyOb9Ss9IIsH7cSUpZHxUK0pxuwt78
        au
X-Google-Smtp-Source: ALg8bN634sV+yWuyW4WpNdx900l/FtEBb+kLPVSs21GSTFfsJDhe9NpixxT7vWoB9zV3zHKbXZL1tC0oRGaOONBzcI6z
X-Received: by 2002:a05:6830:1014:: with SMTP id a20mr9172683otp.43.1547755332446;
 Thu, 17 Jan 2019 12:02:12 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:02:07 -0800
Message-Id: <20190117200207.81825-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] ls-refs: filter refs based on non-namespace name
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 allows for filtering of ref advertisement based on a
client-given name prefix, but inclusion/exclusion is determined based on
the non-namespace-stripped version (e.g. matching a ref prefix of
"refs/heads" against "refs/namespaces/my-namespace/refs/heads/master")
instead of the namespace-stripped version, which is the one that the
user actually sees.

Determine inclusion/exclusion based on the namespace-stripped version.

This bug was discovered through applying patches [1] that override
protocol.version to 2 in repositories when running tests, allowing us to
notice differences in behavior across different protocol versions.

[1] https://public-inbox.org/git/cover.1547677183.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Another bug discovered through GIT_TEST_PROTOCOL_VERSION.

If the patches in [1] above are merged with this patch, a test that
previously failed on GIT_TEST_PROTOCOL_VERSION=2 now passes.

I'm not sure of the relevance of the last paragraph and the "[1]" in the
commit message - feel free to remove it. Since the relevant patches are
not merged yet, the e-mails are probably the best reference, and I have
tried to summarize what they do concisely.
---
 ls-refs.c            |  2 +-
 t/t5701-git-serve.sh | 21 +++++++++++++++++++++
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
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index ae79c6bbc0..ec13064ecd 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -112,6 +112,27 @@ test_expect_success 'basic ref-prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ref prefix with namespaced repository' '
+	# Create a namespaced ref
+	git update-ref refs/namespaces/ns/refs/heads/master "$(git rev-parse refs/tags/one)" &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	ref-prefix refs/heads/master
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/tags/one) refs/heads/master
+	0000
+	EOF
+
+	GIT_NAMESPACE=ns git serve --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'refs/heads prefix' '
 	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
-- 
2.19.0.271.gfe8321ec05.dirty

