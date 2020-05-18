Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368EC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F6320756
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="e7D/KN94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgERT1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgERT1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:27:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F2EC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:27:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so4622441plz.13
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHRd2I0VXIe0ibC8D0F8g6mm2Y/dDZu37gS952iLpfY=;
        b=e7D/KN94kvz1TyxqfhLf1vzuQHezhbeUMTlMiE64tL+hbQTLURUFFY91LPymlmKrGK
         XziGtfcjqGGcDSa9QAjHbSer0UmkGxfZY3rujDv1OCnjmcj0xoacdizdxaYuEeSzoVwL
         +NOUnBN+am7pZo0tTJt9wB58anNIN3k/rnLNMepWso4de13kaAgjP9lXQO7/yz8VybfP
         tCwAdWhz+t3+zVSWib6M5stgEEa2p3LMpv8jqRAJCxRNzbYM5FDfjq8E94LIVx3SfNhD
         nSfftpf0MRiuugXa7oUq7a4xFAMsMSzYSCG/Q35RCUBrdUiBZtvhfdfJliPp1mK78fJI
         tEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHRd2I0VXIe0ibC8D0F8g6mm2Y/dDZu37gS952iLpfY=;
        b=AIp9QbiFzZyONSlPm45tyoK8CXGg3PRUzgmCzCw6l8nggVlFvISFnILWWO3DeCOy2r
         wVrvmTM9jpVPGAQr3ShnhhaI0kMDhp47JizZXm+uGXVhxIoppgxM75TotgQGw7feDQAY
         JDiZC7jG1vWFg3Nlj45h5Hn4+L+7I57e3Hey2xft2sbv8ICTLxxGBer4YCL0shEYH6uQ
         7Ot7g+T6bnlIv9y5RUi9J3AEdRCJiOLknCP8f55i7w3ZMAXAEJUSa6kXfE5pIAzksb/6
         FRsqZgtQji8gQQprNNAzbY1vtTEvdo4/prtntH/1rx+DURQdMo/Fv+3Mn6gIrZsuNIeg
         wnPg==
X-Gm-Message-State: AOAM530l2HNLuOE17zQvkWGSSPHK+BY6+Y/0OszfgZFLm/ezC2IB3ntl
        e28/vkNxl+4iMZCBmyufEMbMOQ==
X-Google-Smtp-Source: ABdhPJyUMJRvcUZ4nCgDrIQxAwvrkx51MLWSKg2l8vOyosgcwnguxyw4iHVXqaSukJyABvHvooCTjQ==
X-Received: by 2002:a17:90a:2306:: with SMTP id f6mr941926pje.231.1589830032964;
        Mon, 18 May 2020 12:27:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 3sm9737080pfo.27.2020.05.18.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:27:12 -0700 (PDT)
Date:   Mon, 18 May 2020 13:27:09 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/8] builtin/commit-graph.c: extract
 'read_one_commit()'
Message-ID: <20200518192709.GA3906@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
 <c37e94907b140f3d2e5a44293f2c1faa6d473712.1589407014.git.me@ttaylorr.com>
 <20200514175646.GA2430834@coredump.intra.peff.net>
 <20200514180200.GA86181@syl.local>
 <xmqq8shuqsnf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8shuqsnf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Sorry for a delayed response. I have been working on something that I
hope to send to the list shortly to discuss. In the meantime...

On Thu, May 14, 2020 at 11:27:00AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  static int graph_write(int argc, const char **argv)
> >  {
> > -	struct string_list *pack_indexes = NULL;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct string_list pack_indexes;
>
> I would strongly prefer this to be initialized here, not ...

Thanks for the suggestion. Your approach is much more favorable than
what I had written here, since it does allow me to unconditionally call
'string_list_clear(...)' instead of 'UNLEAK', which all three of us
dislike :).

Below is an amended patch; please use this as 4/8 instead of the
original when queuing. I'd send you a re-rolled series, but the rest of
the patches apply cleanly on top, so I don't think there is a need
unless it would make things more convenient for you.

-- >8 --

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
 builtin/commit-graph.c | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 15fe60317c..a5c2332a86 100644
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
+	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
+	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
 	struct object_directory *odb = NULL;
-	struct string_list lines;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;

@@ -209,44 +221,32 @@ static int graph_write(int argc, const char **argv)
 		return 0;
 	}

-	string_list_init(&lines, 0);
-	if (opts.stdin_packs || opts.stdin_commits) {
-		struct strbuf buf = STRBUF_INIT;
-
+	if (opts.stdin_packs) {
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
+	string_list_clear(&pack_indexes, 0);
+	strbuf_release(&buf);
 	return result;
 }

--
2.26.0.113.ge9739cdccc

