Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F0A1FAA8
	for <e@80x24.org>; Mon, 15 May 2017 11:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933959AbdEOLGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 07:06:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33564 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755812AbdEOLGc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 07:06:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so27473756wmh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1m0hGcmeyhw8pLUgOQySd/CQmzdmgxGts9HxNvGjwA=;
        b=Tf2ekEDWPn0unLBUO9eeAFXp+1eU2gmtb4Q1iMvEhI4otSlfyB06e0+v3XREg4X6V3
         AZCWJFk+Fqg7TGeI3ci/Iz2IlUjFq0UNwSGu/fdO7yZ4fxeNR5KTas4jYSHC+GFd66Im
         vsUBR3z4PzNz9Pp38A0g885KawSoLO17m2QPMk0Y1l6aAJ/JHaNK8kqR5SgQbn/8X35b
         fKYrw6/pBuv/XQlkJbEILYn7Q0vxW9EVDEivdaUSiVGeuqeVSQ05Mp5i+tHF8qz2XTCW
         RAkDSDQxP8mbGvf0E60M8orjSTMdZ6SwWkj7yOpQZm5SIwTxTbsv3QASC7MYT9lgtR76
         4dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1m0hGcmeyhw8pLUgOQySd/CQmzdmgxGts9HxNvGjwA=;
        b=d27bY5VyKYatPhY52H0dFFoFG3BY0MM/f82/6r8g5pzMusZYUSYMXufsgUYPQVhDqG
         2g/StuESk9BJaZIMjXCuqdyuNziWLQYDLwKj3+qfWTV1J4G4Z79YJcLQybFJ+RCqHfiy
         qDi+NaBPgm6ZjCwXtZzIm+plvreS5ivKeGRxHor3JTsVy3YE0XtYHlwdgyw+KcUc2hTN
         WQOoVsMqRCzvh+Oc4+YvBQ/I7NabctQ9kgku95pAzbx6fFJowMgkI2513EgU0fmPJwCx
         0tOkL/2B71kiKb9xSYdEFYOOFnndJZF2E4qcL/7WFiOVN2GzpnBkEXmq4YQOHq4QJoF8
         XPXQ==
X-Gm-Message-State: AODbwcCBaRZ9DvzQVZTQrk3sOwWvEBI9GPaq32SBoDhQ2y7pdwvR8pbc
        pq5pwzBJB7DpMA==
X-Received: by 10.223.150.167 with SMTP id u36mr3816879wrb.184.1494846380751;
        Mon, 15 May 2017 04:06:20 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-151.pool.digikabel.hu. [62.165.238.151])
        by smtp.gmail.com with ESMTPSA id 20sm10363191wmk.17.2017.05.15.04.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 04:06:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv3 1/4] clone: respect additional configured fetch refspecs during initial fetch
Date:   Mon, 15 May 2017 13:05:54 +0200
Message-Id: <20170515110557.11913-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
In-Reply-To: <20170515110557.11913-1-szeder.dev@gmail.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The initial fetch during a clone doesn't transfer refs matching
additional fetch refspecs given on the command line as configuration
variables.  This contradicts to the documentation stating that
configuration variables specified via 'git clone -c <key>=<value> ...'
"take effect immediately after the repository is initialized, but
before the remote history is fetched" and the given example
specifically mentions "adding additional fetch refspecs to the origin
remote".  Furthermore, one-shot configuration variables specified via
'git -c <key>=<value> clone ...', though not written to the newly
created repository's config file, live during the lifetime of the
'clone' command, including the initial fetch.  This implies that any
fetch refspecs specified this way should already be taken into account
during the initial fetch.

The reason is that the initial fetch is not a fully fledged 'git
fetch' but a bunch of direct calls into the fetch/transport machinery,
bypassing parts of 'git fetch' that processes configured fetch
refspecs.  The configured refspecs are, however, read and parsed
properly when clone calls remote.c:remote_get(), but it never looks at
the parsed refspecs in the resulting 'struct remote'.

Modify clone to take the configured fetch refspecs into account to
retrieve all matching refs during the initial fetch.  Note that the
configuration at that point only includes the fetch refspecs specified
by the user, but it doesn't include the default fetch refspec, so we
have to append it manually at the end of the parsed refspecs array.

Add tests to check that refspecs given both via 'git clone -c ...' and
'git -c ... clone' retrieve all refs matching either the default or
the additional refspecs, and that it works even when the user
specifies the remote name via '--origin=<name>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c         | 20 +++++++++++++++-----
 t/t5611-clone-config.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a35d62293..4144190da 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -520,7 +520,7 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec *refspec, unsigned int refspec_nr)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
@@ -541,13 +541,18 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			get_fetch_map(remote_head, refspec, &tail, 0);
+			unsigned int i;
+			for (i = 0; i < refspec_nr; i++)
+				get_fetch_map(remote_head, &refspec[i], &tail, 0);
 
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
-	} else
-		get_fetch_map(refs, refspec, &tail, 0);
+	} else {
+		unsigned int i;
+		for (i = 0; i < refspec_nr; i++)
+			get_fetch_map(refs, &refspec[i], &tail, 0);
+	}
 
 	if (!option_mirror && !option_single_branch)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
@@ -989,6 +994,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&value);
 
 	remote = remote_get(option_origin);
+	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr + 1);
+	memcpy(remote->fetch+remote->fetch_refspec_nr, refspec,
+	       sizeof(*refspec));
+
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
@@ -1029,7 +1038,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, remote->fetch,
+					       remote->fetch_refspec_nr + 1);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index e4850b778..114b53920 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -37,6 +37,50 @@ test_expect_success 'clone -c config is available during clone' '
 	test_cmp expect child/file
 '
 
+test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
+	rm -rf child &&
+	git update-ref refs/grab/it refs/heads/master &&
+	git update-ref refs/leave/out refs/heads/master &&
+	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
+	rm -rf child &&
+	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
+	rm -rf child &&
+	git clone --origin=upstream \
+		-c "remote.upstream.fetch=+refs/grab/*:refs/grab/*" \
+		-c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
+		. child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/upstream/HEAD
+	refs/remotes/upstream/master
+	EOF
+	test_cmp expect actual
+'
+
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-- 
2.13.0.35.g14b6294b1

