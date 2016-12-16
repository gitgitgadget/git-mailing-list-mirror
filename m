Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B89F1FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 01:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758404AbcLPBpS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 20:45:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36559 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754045AbcLPBpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 20:45:16 -0500
Received: by mail-pg0-f65.google.com with SMTP id a1so860702pgf.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nS+ChJXHN1tEuqvY+44uNuvOsVvHKxyPDkUw5ljawfI=;
        b=GoZLmP0vS5tSp9nE+N7v7Er8MJGP17ymnPuHu2R3Cwrt5crKQpCyfDb9O9oTpqQ2T0
         bagbVn1Xvf6aSAVHIHGyZBRVAV0aa/ucQLDRUD9ConMbvzPHMPg+kyKYczJPJ/jRzQ44
         YDuDqpShukAQq7Ln0BjtCV1CklDhHguaENWPef/Zxh2jy+b1TlOdcKP/X4xvq2BAbf6u
         W0vMToglj9kUe/N09GUMZedED3tReESenPVTsyl92K8elHLxuxhn3/1uTsrRbVJ5xFNz
         nsLc0r2HUwEbKlR4F+rEglOhceZNEpSSaigVnexHDVDhUGNhjZy38HHRKcN0Ga1aedKH
         IOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=nS+ChJXHN1tEuqvY+44uNuvOsVvHKxyPDkUw5ljawfI=;
        b=UIbolwGosRa+EJfszDWWbxcI913/o78ucT/Hn/IKU+w/EK7HL8mhn6ubIoxW8COPMI
         JPn9vMH8zZbveNnqgDj4Osm1H/r0NxOVvT7l6ev4YpWKS+kyf/nLnShLiTX1VMcqFK5n
         tFlqfLZ7Tmz3dyYxmqJZu/ZdnjOonMmfPt8yV/eWdYhpJfSQ3Qt0RmCDjuOFEp4COM0N
         uK7A4Sx98QtA8vhnkAihwW47ECbWUxGabySQaCs+64UnSUEu0UQ6agscPAmcz0JlVFrw
         1n2yyoogAPQXCJW3oy6fLjTuuJE9DOOPRC3rf+RYdA5pzltS3TIdj7EFDfHLpNc2SUw0
         0ZYA==
X-Gm-Message-State: AKaTC02jyQf4vdnhj06ydjM6Qudt8UH2lNZyDQYb9n+JWM8VS8r56yIPjtzsUnamokwQig==
X-Received: by 10.84.135.34 with SMTP id 31mr1190618pli.50.1481852715572;
        Thu, 15 Dec 2016 17:45:15 -0800 (PST)
Received: from i7 ([67.168.201.187])
        by smtp.gmail.com with ESMTPSA id w125sm7211645pfb.8.2016.12.15.17.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 17:45:14 -0800 (PST)
Date:   Thu, 15 Dec 2016 17:45:14 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/1] Allow "git shortlog" to group by committer information
In-Reply-To: <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1612151741280.3583@i7>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com> <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com> <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Allow "git shortlog" to group by committer information
Date: Tue, 11 Oct 2016 11:45:58 -0700

In some situations you may want to group the commits not by author, but by 
committer instead.

For example, when I just wanted to look up what I'm still missing from 
linux-next in the current merge window, I don't care so much about who 
wrote a patch, as what git tree it came from, which generally boils down 
to "who committed it".

So make git shortlog take a "-c" or "--committer" option to switch 
grouping to that. During the merge window this allows me to do things like

   git shortlog -cnse linus..next |
        head -20 |
        cut -f2 |
        sed 's/$/,/'

to easily create a list of the top-20 committers that I haven't gotten 
pull requests from yet (the committer is not necessarily the person who 
will send the pull request, but it's a reasonably good approximation).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin/shortlog.c | 15 ++++++++++++---
 shortlog.h         |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index ba0e1154a..c9585d475 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -117,11 +117,15 @@ static void read_from_stdin(struct shortlog *log)
 {
 	struct strbuf author = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
+	static const char *author_match[2] = { "Author: ", "author " };
+	static const char *committer_match[2] = { "Commit: ", "committer " };
+	const char **match;
 
+	match = log->committer ? committer_match : author_match;
 	while (strbuf_getline_lf(&author, stdin) != EOF) {
 		const char *v;
-		if (!skip_prefix(author.buf, "Author: ", &v) &&
-		    !skip_prefix(author.buf, "author ", &v))
+		if (!skip_prefix(author.buf, match[0], &v) &&
+		    !skip_prefix(author.buf, match[1], &v))
 			continue;
 		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
 		       oneline.len)
@@ -140,6 +144,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	struct strbuf author = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
+	const char *fmt;
 
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
@@ -148,7 +153,9 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
-	format_commit_message(commit, "%an <%ae>", &author, &ctx);
+	fmt = log->committer ? "%cn <%ce>" : "%an <%ae>";
+
+	format_commit_message(commit, fmt, &author, &ctx);
 	if (!log->summary) {
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
@@ -238,6 +245,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 
 	const struct option options[] = {
+		OPT_BOOL('c', "committer", &log.committer,
+			 N_("Group by committer rather than author")),
 		OPT_BOOL('n', "numbered", &log.sort_by_number,
 			 N_("sort output according to the number of commits per author")),
 		OPT_BOOL('s', "summary", &log.summary,
diff --git a/shortlog.h b/shortlog.h
index 5a326c686..5d64cfe92 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -13,6 +13,7 @@ struct shortlog {
 	int in2;
 	int user_format;
 	int abbrev;
+	int committer;
 
 	char *common_repo_prefix;
 	int email;
