Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865BBC433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 21:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJEVn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJEVn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 17:43:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A607C82D08
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 14:43:23 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so128305ilq.8
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YVbEnFgsdYXPd9EqrF5ooP1rP8H7hWj1HRfgZ1BXECU=;
        b=1p/+HFKvjswwo9Ws3C3i7bTGv7FjGffKgBigERbG+Cc355Lc/sMOpl/JfqnfUlHU9N
         QuYY7PBzIMKYH/6SxaOaJBXNF111qkpxha56rYcNVQOZ1GWXOFrIxwcyKQgXJsxwiK24
         fGu0wHB8hAmNnnw86h3GK7BzgrjsKniE7tBXHdSx/0GHmUq4h5bKeKBsmHw5lLPD4uM/
         MTovMDYL+KuMoKYhQuJteaMMczqE5sCUCZRCSA4yfFtFPHGMtxi/FTCYImkTdRpKh9ov
         VSdwmHBRLpTFpYuxKLieg6zGVqkvD8x19YNdnTi8bcHL5WzZC7YvKUtctqP6Sto6cLWL
         4zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YVbEnFgsdYXPd9EqrF5ooP1rP8H7hWj1HRfgZ1BXECU=;
        b=P/MJJE4+lfJWGWyMAyVxldt5YvXUHqTDSF+u7GLqRbn3GaSVCPSTfTi7bYfLcO05MA
         VL8I/CkF7fPpiVaMPYkLpqcIRIzqc9ouF+N2B8lcWDWsGlQAqa0trp07ga7sMhxeZzwr
         pXfB8Ot0NNAlYIOPDZxm2b4vl5OYLWOvIG4SQY63jLoqBXIGSwBPaJaPKrPzELobvbRc
         AvlCCA5KKZEI/h4Ges76L8JzUJhzG0m7APJjLmAGMjDE5rzVjg7kgPdOt/dqrjOxnn2e
         8Kn2UeDmDOmxwdsYSIb2APpkF40niINOlsL+Djhkh3WbVqflDeckhdYtaAl5X99vICtZ
         90zQ==
X-Gm-Message-State: ACrzQf24IBG/+LDqtV9WWBIEUNjnZMi7skEIOR75E3JHRCfZgQeKfBcG
        T0l79CPMqFv4jtQsB0gWj+iwKeePX1Kwgw==
X-Google-Smtp-Source: AMsMyM6R5oD/WhMfiiZdSsEzhIcxo+dpxmqeXWS01RMGEvkmXgt1PG1/7LbZ45zMorPaXui1SRr22g==
X-Received: by 2002:a05:6e02:216a:b0:2f9:d95f:2852 with SMTP id s10-20020a056e02216a00b002f9d95f2852mr790839ilv.226.1665006202814;
        Wed, 05 Oct 2022 14:43:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i9-20020a5e8509000000b006a1f242b529sm7161037ioj.13.2022.10.05.14.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 14:43:21 -0700 (PDT)
Date:   Wed, 5 Oct 2022 17:43:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yz36eFeGyQ3ha1pw@nand.local>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 05:58:56PM -0400, Jeff King wrote:
> On Fri, Sep 23, 2022 at 09:17:10AM -0700, Junio C Hamano wrote:
>
> > Not a suggestion to use a different implementation or add a new
> > feature on top of this --group-by-time-range idea, but I wonder if
> > it is a more flexible and generalizeable approach to say "formulate
> > this value given by the --format=<format> string, apply this regular
> > expression match, and group by the subexpression value".  E.g.
> >
> >     git shortlog \
> > 	--group-by-value="%cI" \
> > 	--group-by-regexp="^(\d{4}-\d{2})"
>
> Heh, I was about to make the exact same suggestion. The existing
> "--group=author" could really just be "--group='%an <%ae>'" (or variants
> depending on the "-e" flag).

This caught my attention, so I wanted to see how hard it would be to
implement. It actually is quite straightforward, and gets us most of the
way to being able to get the same functionality as in Jacob's patch
(minus being able to do the for-each-ref-style sub-selectors, like
`%(authordate:format=%Y-%m)`).

Here's the patch:

--- >8 ---

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7a1e1fe7c0..68880e8867 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -200,6 +200,29 @@ static void insert_records_from_trailers(struct shortlog *log,
 	unuse_commit_buffer(commit, commit_buffer);
 }

+static void insert_record_from_pretty(struct shortlog *log,
+				      struct strset *dups,
+				      struct commit *commit,
+				      struct pretty_print_context *ctx,
+				      const char *oneline)
+{
+	struct strbuf ident = STRBUF_INIT;
+	size_t i;
+
+	for (i = 0; i < log->pretty.nr; i++) {
+		if (i)
+			strbuf_addch(&ident, ' ');
+
+		format_commit_message(commit, log->pretty.items[i].string,
+				      &ident, ctx);
+	}
+
+	if (strset_add(dups, ident.buf))
+		insert_one_record(log, ident.buf, oneline);
+
+	strbuf_release(&ident);
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
@@ -243,6 +266,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
 		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 	}
+	if (log->groups & SHORTLOG_GROUP_PRETTY)
+		insert_record_from_pretty(log, &dups, commit, &ctx, oneline_str);

 	strset_clear(&dups);
 	strbuf_release(&ident);
@@ -321,8 +346,10 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	else if (skip_prefix(arg, "trailer:", &field)) {
 		log->groups |= SHORTLOG_GROUP_TRAILER;
 		string_list_append(&log->trailers, field);
-	} else
-		return error(_("unknown group type: %s"), arg);
+	} else {
+		log->groups |= SHORTLOG_GROUP_PRETTY;
+		string_list_append(&log->pretty, arg);
+	}

 	return 0;
 }
@@ -340,6 +367,7 @@ void shortlog_init(struct shortlog *log)
 	log->in2 = DEFAULT_INDENT2;
 	log->trailers.strdup_strings = 1;
 	log->trailers.cmp = strcasecmp;
+	log->pretty.strdup_strings = 1;
 }

 int cmd_shortlog(int argc, const char **argv, const char *prefix)
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabca..d7caecb76f 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -20,8 +20,10 @@ struct shortlog {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),
 		SHORTLOG_GROUP_COMMITTER = (1 << 1),
 		SHORTLOG_GROUP_TRAILER = (1 << 2),
+		SHORTLOG_GROUP_PRETTY = (1 << 3),
 	} groups;
 	struct string_list trailers;
+	struct string_list pretty;

 	int email;
 	struct string_list mailmap;

--- 8< ---

> I don't think you even really need the regexp. If we respect --date,
> then you should be able to ask for --date=format:%Y-%m. Unfortunately
> there's no way to specify the format as part of the placeholder. The
> for-each-ref formatter understands this, like:
>
>   %(authordate:format:%Y-%m)
>
> I wouldn't be opposed to teaching the git-log formatter something
> similar.

Yeah, I think having a similar mechanism there would be useful, and
certainly a prerequisite to being able to achieve what Jacob has done
here with the more general approach.

I think you could also do some cleanup on top, like replacing the
SHORTLOG_GROUP_AUTHOR mode with adding either "%aN <%aE>" (or "%aN",
without --email) as an entry in the `pretty` string_list.

Thanks,
Taylor
