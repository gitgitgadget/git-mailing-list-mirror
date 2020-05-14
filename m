Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE287C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F11020657
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mhwr9apl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgENSCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENSCD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 14:02:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00AC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:02:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so1649947pfx.7
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iEpX8OhrMgA4QSIFZuCG+Lnp5nDevyBJFqGgdhsb7kc=;
        b=mhwr9aplAyXx2Ww3B7DVkS3q9G35uV1jYSPNORL5wIyusOMemtISX9dQuQnXln16G0
         U5HpfXzbWl1ePYd52rewptvXSnpTKHPqi5tJIKbnC/+b4Eq2XWJq2qAAY89PyMGNR5Ep
         8MmnhRc3EACspkh1aIFvctNB+e2qlh4OEMvveDvgTLZ204dcn4RDqvnGMCwuO6yyOcha
         +efnK1AgiF4rmfRD0JeDWGi+rloZtP3gp2bIniQ1ZUncG4Q67PiC+cQ17eKBSJ6Mp7g3
         +Mg2vuNty7hr3bdlx98wNtv2v8d6CtCRMbpzVZOxrUK5s2G2PbGsFOu8h4H9Ugi/OakO
         APmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iEpX8OhrMgA4QSIFZuCG+Lnp5nDevyBJFqGgdhsb7kc=;
        b=Pij4yV0Qu+hhUCc5kUNbdIfY/oj5oSdyxRcsofZi+OYoh5gx3ySzuOoHHTI4yo+ao3
         5IEUxdhJdEjuK1pENrwi2ZuCXkFMq3RYK1NekeewFiUoOR9Ed/DSBBvaVl5KrHj7rSgo
         F8EUnUnvidQBUaCtu8YolwG4zLpNP8gj5HPqx8BPQnf3rxwtrqALHWdYXwf2FB/PBCfi
         tviFWSEPRt5qq2Jh+lK5JR6PAYc0Ly7Oeg5Aob5LdaddhvMzjRNkbLrMlYhkZ135MfTN
         k8iGN2nCa/9LamZoTZhl55ev2AkHHqNdo7MPtIYopwao28La3p2G+8EUfoGTGbelnbVA
         A17g==
X-Gm-Message-State: AOAM5320+ddlkex0oPzGS2R9eWQPLfz9npp6CuvHjrjfNid0lghW0WU+
        FNPqPENtOVZdqbf1Bt2jTzxmsg==
X-Google-Smtp-Source: ABdhPJyCQBw+/+K6mMNNZnH8/wsDsYT4lYL80aOFkxBE0Mt9CHO6FJxlUXB0t1+tC6kGhzEPYWqehw==
X-Received: by 2002:a63:6e8a:: with SMTP id j132mr4422668pgc.301.1589479321916;
        Thu, 14 May 2020 11:02:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h193sm2836116pfe.30.2020.05.14.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:02:01 -0700 (PDT)
Date:   Thu, 14 May 2020 12:02:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/8] builtin/commit-graph.c: extract
 'read_one_commit()'
Message-ID: <20200514180200.GA86181@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
 <c37e94907b140f3d2e5a44293f2c1faa6d473712.1589407014.git.me@ttaylorr.com>
 <20200514175646.GA2430834@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514175646.GA2430834@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 01:56:46PM -0400, Jeff King wrote:
> On Wed, May 13, 2020 at 03:59:41PM -0600, Taylor Blau wrote:
>
> > @@ -209,44 +220,35 @@ static int graph_write(int argc, const char **argv)
> >  		return 0;
> >  	}
> >
> > -	string_list_init(&lines, 0);
> > -	if (opts.stdin_packs || opts.stdin_commits) {
> > -		struct strbuf buf = STRBUF_INIT;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	if (opts.stdin_packs) {
>
> This is a decl-after-statement, isn't it? It should fail with
> DEVELOPER=1.

Whoops. I'm not sure how I missed this.

> The strbuf could be local in each block of the conditional, though that
> makes your cleanup label trickier. Only the stdin_commits side needs to
> clean up the buf, so we could just do it there. Or I'd be OK with having
> the strbuf declared at the top of the function, and using the
> whole-function cleanup label.

Thankfully, fixing this by moving the declaration/initialization up to
the top of the function didn't cause any conflicts with later patches.

Junio: if you're queuing this reroll, please use the below version
instead:

--- >8 ---

Subject: [PATCH] builtin/commit-graph.c: extract 'read_one_commit()'

With either '--stdin-commits' or '--stdin-packs', the commit-graph
builtin will read line-delimited input, and interpret it either as a
series of commit OIDs, or pack names.

In a subsequent commit, we will begin handling '--stdin-commits'
differently by processing each line as it comes in, instead of in one
shot at the end. To make adequate room for this additional logic, split
the '--stdin-commits' case from '--stdin-packs' by only storing the
input when '--stdin-packs' is given.

In the case of '--stdin-commits', feed each line to a new
'read_one_commit' helper, which (for now) will merely call
'parse_oid_hex'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 56 ++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 15fe60317c..aaa1d0c738 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -138,12 +138,24 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }

+static int read_one_commit(struct oidset *commits, const char *hash)
+{
+	struct object_id oid;
+	const char *end;
+
+	if (parse_oid_hex(hash, &oid, &end))
+		return error(_("unexpected non-hex object ID: %s"), hash);
+
+	oidset_insert(commits, &oid);
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
-	struct string_list *pack_indexes = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list pack_indexes;
 	struct oidset commits = OIDSET_INIT;
 	struct object_directory *odb = NULL;
-	struct string_list lines;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;

@@ -209,44 +221,34 @@ static int graph_write(int argc, const char **argv)
 		return 0;
 	}

-	string_list_init(&lines, 0);
-	if (opts.stdin_packs || opts.stdin_commits) {
-		struct strbuf buf = STRBUF_INIT;
+	if (opts.stdin_packs) {
+		string_list_init(&pack_indexes, 0);

 		while (strbuf_getline(&buf, stdin) != EOF)
-			string_list_append(&lines, strbuf_detach(&buf, NULL));
+			string_list_append(&pack_indexes,
+					   strbuf_detach(&buf, NULL));
+	} else if (opts.stdin_commits) {
+		oidset_init(&commits, 0);
+		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;

-		if (opts.stdin_packs)
-			pack_indexes = &lines;
-		if (opts.stdin_commits) {
-			struct string_list_item *item;
-			oidset_init(&commits, lines.nr);
-			for_each_string_list_item(item, &lines) {
-				struct object_id oid;
-				const char *end;
-
-				if (parse_oid_hex(item->string, &oid, &end)) {
-					error(_("unexpected non-hex object ID: "
-						"%s"), item->string);
-					return 1;
-				}
-
-				oidset_insert(&commits, &oid);
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			if (read_one_commit(&commits, buf.buf)) {
+				result = 1;
+				goto cleanup;
 			}
-			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}
-
-		UNLEAK(buf);
 	}

 	if (write_commit_graph(odb,
-			       pack_indexes,
+			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
 			       &split_opts))
 		result = 1;

-	UNLEAK(lines);
+cleanup:
+	UNLEAK(pack_indexes);
+	strbuf_release(&buf);
 	return result;
 }

--
2.26.0.113.ge9739cdccc

