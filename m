Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED370C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C1060200
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 06:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhIUGnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhIUGnm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 02:43:42 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E4C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 23:42:14 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id f2so240711qvx.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9XcWYVu1GjS+abdBtWCQzAZq22cP0oBaqkA9SJPg8dc=;
        b=jEr0pnWU9JFWcoq5a2yGUro72wP/kk4ZwSAajsI7q8GsEIHDmoghg2wg2573BMhvNC
         2JWT+mASbFXDEd+ETYaqlaI8hu72W03TH6ZUrCcv48KjByLIxg2Nkya1dh0xJ6jvb5TQ
         GmX4dYSrh+p/2X7a0Ex04h9FSQ0WK8bqtUtc07ycDVUs7rZ2XUz5jwp9rjirk+BmGX2E
         ZWFPRpVV3GU2DJ6xLZJbBxEVaSZAJqqXthKYbcggJJLhgWDbszj3FJ9xLWiRXOba3DF6
         pRwhcsGwGccRUhEF/RhVN9XDJ8XKELA4mocJNMOQeBM2NuIRhwF7epoZeNvbW/cco1m3
         G9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9XcWYVu1GjS+abdBtWCQzAZq22cP0oBaqkA9SJPg8dc=;
        b=Sl9eHb2rsu+rHo/2PcKUL9vAXk+Ls3Ev76jr5mjrVEma0DaRUTf2SOsa8csxC7S1kB
         QHdxn58tHy5QEy03mJYJvGU//vsgcVkSspmr5MydMz1jLz+41ZzBlI4jsX9dPXs9Fz4q
         zUmisEFqriobDcBNWjv3ZaO+1wm37s4c6WB0sBP5Qe85jnsN7qy9n+Vwy4kHDOhRMlj0
         sw4gt06w+PnJuLY3u3QtduuM+URcJuTwzHxU+itNGeqmJllYJk70L5MdjlGpEDNqbYTK
         KswXIAJFSkHhtJyqEEhfELzL3Yr3n4NVbb6csO5cqCUeVKlaFJb9TVlwkUftElwtNSFK
         BeFg==
X-Gm-Message-State: AOAM531gmuK5Mjad9PsFFzuZos0kX86Hjdhmp9D0OWdGXLlgez1NPeWg
        7iN+b3eeK5WqXSBY9KUCD2Q=
X-Google-Smtp-Source: ABdhPJzJ1dQ3i3CLbQgC9osgbCOucQvuagf9dOySqMmxSL6XyYDr4DYfzMuucwLJkXnwHLVLcXoNDw==
X-Received: by 2002:a05:6214:2d1:: with SMTP id g17mr28818279qvu.63.1632206533853;
        Mon, 20 Sep 2021 23:42:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v8sm2673253qta.21.2021.09.20.23.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 23:42:13 -0700 (PDT)
Date:   Mon, 20 Sep 2021 23:42:11 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
Message-ID: <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
 <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:43:05AM -0400, Jeff King wrote:
> 
> So yeah, I'm sure it could be rewritten around memrchr() or something,
> but I doubt it would be much shorter, and the chance of introducing an
> off-by-one seems non-trivial. :)

Considering I am writing it, it is most likely warranted ;)

but it doesn't look that bad IMHO

Carlo

PS. I tested it in macOS with the compatibility layer that will be needed
------ 8> -------
Subject: [PATCH] grep: retire strip_timestamp()

After recent changes, the name is no longer valid, as the function
doesn't strip anything.

Having the code in the main function also helps with readability

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/grep.c b/grep.c
index 5b1f2da4d3..56fd86a7d8 100644
--- a/grep.c
+++ b/grep.c
@@ -922,18 +922,6 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 	return hit;
 }
 
-static void strip_timestamp(char *bol, char **eol_p)
-{
-	char *eol = *eol_p;
-
-	while (bol < --eol) {
-		if (*eol != '>')
-			continue;
-		*eol_p = ++eol;
-		break;
-	}
-}
-
 static struct {
 	const char *field;
 	size_t len;
@@ -965,9 +953,12 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 		bol += len;
 		switch (p->field) {
 		case GREP_HEADER_AUTHOR:
-		case GREP_HEADER_COMMITTER:
-			strip_timestamp(bol, &eol);
+		case GREP_HEADER_COMMITTER: {
+			char *em = memrchr(bol, '>', eol - bol);
+			if (em)
+				eol = em + 1;
 			break;
+		}
 		default:
 			break;
 		}
-- 
2.33.0.911.gbe391d4e11

