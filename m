Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E9F1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbdFPT2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:28:54 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38369 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdFPT2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:53 -0400
Received: by mail-wm0-f47.google.com with SMTP id u195so19201278wmd.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtJyqYsqWubk0EbfmQt/ov2AkPTXRbt6bciJtHAGsok=;
        b=mF1YqEVcNGyuKBW+PIfCtrms5g/T4G+KJpXsoNeOv1FgaAzTkUN3nRYaPE1ZxIw/eu
         4Ua1RUefyamCs7/L8OEDKMHXemdmZ2ih3tUixY9lCdXyHlqPgf90Oy3IgaGTQH5Fh7Mr
         uTIi1Ryz0vTfQE7TbDEsNdaW/rusgASEeesIhSiL3Y8kn9ji00WLy5LspLDhLuDPbpFl
         Nos0F57xuSerGK7bVzdTWuKvhxyvjvfRG6cYeevkyQ+1KrxybiVJ/iQetcq/z/OKEa+P
         5fChnn+AzhQ8CSDv/ixSCBfcAIczgnD5lqVxN66AEZebNqRozLnNqybWZuDRkphtwsBH
         fi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtJyqYsqWubk0EbfmQt/ov2AkPTXRbt6bciJtHAGsok=;
        b=qjJRq37/nQXkPrpNc7/TPyEJnxWyDWRt4J7X+IdofpuvQ21cbZppV1OvQqsydlaBUd
         F86scRdMcrikZLIhDrap5zWr120vzDvlcpC8DUWZJ1mjU7LwjbTrrwMJxMJ+SfuYXld2
         Hh5smS+2q9VkOrVQA2gA7AqvmIJhn6bf90Z8lcbcrWFh6RwnDpGOBohZW2V4aBa8/ecM
         w1UPBZF1HZREM7lrV/Nw65YraJMIlfW0Ox0DfD6CB/nad1ySkjDa2TZov83Axb8+GWdq
         +ERGb6SW2w0uNgI1Oz3YEQaInUyi7xLJ0UqoC4cagkQvpS/wXPW9QJlygtK7D/tRRJ5T
         vFqw==
X-Gm-Message-State: AKS2vOwOx4HC3YVvH9F0EED9BJcQ9oNu8Bv4xDPjHqqgtzVfM0EcGfnO
        A6XUDLkcjRW6ntU+
X-Received: by 10.28.146.12 with SMTP id u12mr8467967wmd.15.1497641331171;
        Fri, 16 Jun 2017 12:28:51 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id c71sm2658026wmh.21.2017.06.16.12.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:28:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] remote: don't use remote->{fetch,push}_refspec
Date:   Fri, 16 Jun 2017 21:28:33 +0200
Message-Id: <20170616192837.11035-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.501.g45ae33cbf
In-Reply-To: <20170616192837.11035-1-szeder.dev@gmail.com>
References: <20170616192837.11035-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/remote.c uses remote->fetch_refspec and remote->push_refspec,
i.e. refspecs as strings, in a few places, e.g. in an error message or
to set configuration variables.

Since we are about to eliminate remote->{fetch,push}_refspec, recreate
those strings from the corresponding remote->{fetch,push} entries.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/remote.c | 22 +++++++++++++++-------
 remote.c         | 20 ++++++++++++++++++++
 remote.h         |  2 ++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f1a88fe26..7f0072fe5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -334,7 +334,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
 		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
 			die(_("Could not get fetch map for refspec %s"),
-				states->remote->fetch_refspec[i]);
+			      refspec_to_string(&states->remote->fetch[i]));
 
 	states->new.strdup_strings = 1;
 	states->tracked.strdup_strings = 1;
@@ -576,7 +576,7 @@ static int read_remote_branches(const char *refname,
 
 static int migrate_file(struct remote *remote)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, refspec = STRBUF_INIT;
 	int i;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
@@ -584,17 +584,25 @@ static int migrate_file(struct remote *remote)
 		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
-	for (i = 0; i < remote->push_refspec_nr; i++)
-		git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0);
+	for (i = 0; i < remote->push_refspec_nr; i++) {
+		strbuf_add_refspec(&refspec, &remote->push[i]);
+		git_config_set_multivar(buf.buf, refspec.buf, "^$", 0);
+		strbuf_reset(&refspec);
+	}
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
-	for (i = 0; i < remote->fetch_refspec_nr; i++)
-		git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0);
+	for (i = 0; i < remote->fetch_refspec_nr; i++) {
+		strbuf_add_refspec(&refspec, &remote->fetch[i]);
+		git_config_set_multivar(buf.buf, refspec.buf, "^$", 0);
+		strbuf_reset(&refspec);
+	}
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
 		unlink_or_warn(git_path("branches/%s", remote->name));
 
+	strbuf_release(&buf);
+	strbuf_release(&refspec);
 	return 0;
 }
 
@@ -647,7 +655,7 @@ static int mv(int argc, const char **argv)
 		char *ptr;
 
 		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
+		strbuf_add_refspec(&buf2, &oldremote->fetch[i]);
 		ptr = strstr(buf2.buf, old_remote_context.buf);
 		if (ptr) {
 			refspec_updated = 1;
diff --git a/remote.c b/remote.c
index 336db8298..a021decee 100644
--- a/remote.c
+++ b/remote.c
@@ -919,6 +919,26 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 	return query.dst;
 }
 
+void strbuf_add_refspec(struct strbuf *sb, const struct refspec *refspec)
+{
+	if (refspec->force)
+		strbuf_addch(sb, '+');
+	if (refspec->src)
+		strbuf_addstr(sb, refspec->src);
+	if (refspec->dst) {
+		strbuf_addch(sb, ':');
+		strbuf_addstr(sb, refspec->dst);
+	} else if (!refspec->src)
+		strbuf_addch(sb, ':');
+}
+
+char *refspec_to_string(const struct refspec *refspec)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_add_refspec(&sb, refspec);
+	return strbuf_detach(&sb, NULL);
+}
+
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
 	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
diff --git a/remote.h b/remote.h
index 9619f94dd..ee6c432d0 100644
--- a/remote.h
+++ b/remote.h
@@ -177,6 +177,8 @@ void free_refspec(int nr_refspec, struct refspec *refspec);
 extern int query_refspecs(struct refspec *specs, int nr, struct refspec *query);
 char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 		     const char *name);
+void strbuf_add_refspec(struct strbuf *sb, const struct refspec *refspec);
+char *refspec_to_string(const struct refspec *refspec);
 
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
 int match_push_refs(struct ref *src, struct ref **dst,
-- 
2.13.1.505.g7cc9fcafb

