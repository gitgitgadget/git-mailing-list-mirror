Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1408C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECB8207D0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKMjHLNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgFEJKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgFEJKn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 05:10:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F86C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 02:10:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d6so11336076ybn.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=RmJ8P1zORveQgjOwdiMozhPQUQkmB7jV+D9BfhzEPrg=;
        b=sKMjHLNRdyX1idK5VNrLToFzhK/pA5aoYqB8dAGU4lX9hCQvYJlsFbih6X/MLaHGBc
         LIqlavJ5gIdgl42loQ0he9Y3XmaUYdpRsYZZoMddePZW+YUFVqorMP9sVP7D/qTfJcUV
         Bu3n6hVhEkE0rMPqe6XkSNeuCe3u/Bc3dR9YtfmZ42JfrQ1USqus9RTJcmOgHdKL1S3I
         JxHZCde34xj2JiQfbX9ncSXqiQtEtvf4az61cSdtsfhW2Pj8a7R5CycO5eNta9Gpz20f
         94LG5E7KWgfvc1LbSKa6AKVjIj4q5LXIBkVJFcQd02DKMgaegz1w9iYtuD7ifCpnvDs8
         RPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=RmJ8P1zORveQgjOwdiMozhPQUQkmB7jV+D9BfhzEPrg=;
        b=p6fpYfbgyPBfAQ9CZE38s3rWRAw/rOSnRNRY0xnWOIrNfJe2kPIrNsIV2sohfJXwg+
         ILgwVOARRj9bZhj2WZr1NYHTQzVHZcl7nToKSf2gfLbhQ45jcc87mMIc5Dr0hb+mpssH
         JB80rUzJCNvMUl3s+CIanulaxs0sZw9HDe+bGjouL0KD5g+IVw/+eI6lLAvO6wCSdkkm
         7HP+fQr7dEnFm6lrBTloi8n7t4IugNB4AkXqXkqxFFjnUPY2h+T2dglcuh1ylW0xQRjh
         l2UkD3/RjYTKzp7Od5OdcpJRIpJuACEkaT6Mr/Lvo78cO8xm+7UmV5NFExRIBCrhuiFA
         RKnA==
X-Gm-Message-State: AOAM531W6/rTc0tNgT5m5qWXXhMB1GQGf4d4i3wVYdZL85cL3Ii2hgDL
        OXpe8PoGYjqqJ1mxH353cfk/tnWMnp+Qn9g5ZCy+q8XR5yr33O6J43sJZwTzuZd0lZZUs+8TlIl
        fQ8XgL42q35WbEPY2+PxBJrf8QrcLU9WgCZWzy/DaFcZv/g6iESRdxwJxfUl7
X-Google-Smtp-Source: ABdhPJxIG3aUE+S3SXphYXqm6esFXr4sEKvFpRkkTP/dRrNCLULiiGZuoMfL1uRf0sOIlqlWI663NdXM0qbF
X-Received: by 2002:a25:7a06:: with SMTP id v6mr15011315ybc.152.1591348242540;
 Fri, 05 Jun 2020 02:10:42 -0700 (PDT)
Date:   Fri,  5 Jun 2020 02:10:02 -0700
In-Reply-To: <20200605091004.208668-1-delphij@google.com>
Message-Id: <20200605091004.208668-3-delphij@google.com>
Mime-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com> <20200529000432.146618-1-delphij@google.com>
 <20200529010119.GE114915@google.com> <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
 <20200605091004.208668-1-delphij@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v6 2/4] fetch: allow adding a filter after initial clone
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Retroactively adding a filter can be useful for existing shallow clones as
they allow users to see earlier change histories without downloading all
git objects in a regular --unshallow fetch.

Without this patch, users can make a clone partial by editing the
repository configuration to convert the remote into a promisor, like:

=C2=A0 git config core.repositoryFormatVersion 1
=C2=A0 git config extensions.partialClone origin
=C2=A0 git fetch --unshallow --filter=3Dblob:none origin

Since the hard part of making this work is already in place and such
edits can be error-prone, teach Git to perform the required configuration
change automatically instead.

Note that this change does not modify the existing git behavior which
recognizes setting extensions.partialClone without changing
repositoryFormatVersion.

Signed-off-by: Xin Li <delphij@google.com>
---
 builtin/fetch.c                  |  3 ---
 t/t0410-partial-clone.sh         | 12 ++++++++++++
 t/t1090-sparse-checkout-scope.sh |  1 -
 t/t5500-fetch-pack.sh            |  1 -
 t/t5702-protocol-v2.sh           |  1 -
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5788c16bf..3347d578ea 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1790,9 +1790,6 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen =3D 1;
=20
-	if (filter_options.choice && !has_promisor_remote())
-		die("--filter can only be used when extensions.partialClone is set");
-
 	if (all) {
 		if (argc =3D=3D 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a3988bd4b8..16ad000382 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -30,6 +30,18 @@ test_expect_success 'extensions.partialclone without fil=
ter' '
 	git -C client fetch origin
 '
=20
+test_expect_success 'convert shallow clone to partial clone' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=3D1 "file://$(pwd)/server" client &&
+	git -C client fetch --unshallow --filter=3D"blob:none" &&
+	test_cmp_config -C client true remote.origin.promisor &&
+	test_cmp_config -C client blob:none remote.origin.partialclonefilter &&
+	test_cmp_config -C client 1 core.repositoryformatversion
+'
+
 test_expect_success 'missing reflog object, but promised by a commit, pass=
es fsck' '
 	rm -rf repo &&
 	test_create_repo repo &&
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-sco=
pe.sh
index 40cc004326..f35a73dd20 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -63,7 +63,6 @@ test_expect_success 'in partial clone, sparse checkout on=
ly fetches needed blobs
 	git -C server commit -m message &&
=20
 	test_config -C client core.sparsecheckout 1 &&
-	test_config -C client extensions.partialclone origin &&
 	echo "!/*" >client/.git/info/sparse-checkout &&
 	echo "/a" >>client/.git/info/sparse-checkout &&
 	git -C client fetch --filter=3Dblob:none origin &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8c54e34ef1..0f5ff25179 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -999,7 +999,6 @@ fetch_filter_blob_limit_zero () {
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
=20
 	git clone "$URL" client &&
-	test_config -C client extensions.partialclone origin &&
=20
 	test_commit -C "$SERVER" two &&
=20
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..8b27fad6cd 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -348,7 +348,6 @@ test_expect_success 'partial fetch' '
 	rm -rf client "$(pwd)/trace" &&
 	git init client &&
 	SERVER=3D"file://$(pwd)/server" &&
-	test_config -C client extensions.partialClone "$SERVER" &&
=20
 	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client -c protocol.version=3D2 \
 		fetch --filter=3Dblob:none "$SERVER" master:refs/heads/other &&
--=20
2.27.0.278.ge193c7cf3a9-goog

