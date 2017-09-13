Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F344420286
	for <e@80x24.org>; Wed, 13 Sep 2017 19:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdIMTtV (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 15:49:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36263 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdIMTtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 15:49:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so559538pgt.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lVcxzYHwBZfJcTj7AdAa/QpWJx0tJTb+gj7XUtxGNjU=;
        b=a6KnXh66cxjx8mmihrteR2q8Q7HAckHxxEdH/yXTyU4qs4gEKKD5cRMBnGDlmJ+rMe
         AX+kd7NGH+h0U6aM+KDOA+BNlZIe7mMGswoJWMioxOy3cm1PvzyG0+Ei3+ZB7nbEWhhR
         pbGg0VcXtVF5BDq5PRsUfrBikbayQgvX638y/zbYiu2uQFX1H7Uyb6AdV+IunnA3CAD4
         hlJj8PB+UORvB6pnYySK2eYHrmCRsNZSMKsV3gOCoqOMJ0MmAOjlqWPovAoxstL8cp8+
         s42BbcC+sN9hbr4oAkUyn3UddFrsrYlhBVYHRkR4exZ5OGezrJqNc5LEZVMW4olzTibE
         m6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lVcxzYHwBZfJcTj7AdAa/QpWJx0tJTb+gj7XUtxGNjU=;
        b=ae52/TH+imR5zFk8Qyugu76amzaAnK9U66CWUTqQ7+ykJbXmkAD41RLTiWOK4ALGSs
         I93L0zsJg2aTmHYvo5izHRLNWOB+kCrK/NT81sqiJp5YEb5sKJyPJawu1SwkX/f8nrts
         5nLqw1bWxpLftPqlTpYYlVYzRYo2v2Sm2hKsOfVVYW1N15g5/YzO9X32qu7uhG1P45Az
         BiULwXEMHoI3oOXfpokdqaILEYX7WtBGoOOYuRHicX0jPGKIEfi3VMe/c48j0O0WB4Nw
         1WBO3rZ0lkP2UaWzsblNt25hjpzcMzOsHXieNlxdgKS+LVuE++rtR6cEGoJclsYXGh+n
         0UDw==
X-Gm-Message-State: AHPjjUg2sBSembxr0QjztZ3zDPccYJo9EDlkaAQNIx+Z9QvZ4brXX6fP
        0/Ach/YzTMAznA==
X-Google-Smtp-Source: ADKCNb54BObE/05YzEU0IX8R7K+rg3PVTw8VMlEeYBAcZjU0MY9uSrVMeu0enrtemNLc65NKCTzW8A==
X-Received: by 10.99.121.77 with SMTP id u74mr18451454pgc.180.1505332159815;
        Wed, 13 Sep 2017 12:49:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id b8sm8057856pfl.62.2017.09.13.12.49.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 12:49:19 -0700 (PDT)
Date:   Wed, 13 Sep 2017 12:49:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913194917.GI27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
 <20170913182431.GE27425@aiede.mtv.corp.google.com>
 <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> AFAIK there's no way to turn it on for specific functions, but I'm far
> from a gcc-warning guru. Even if you could, though, the error may be far
> from the function (e.g., if we store the result in an ssize_t and then
> compare that with a size_t).

It turns out that yes, we have two of those.  Both handle errors
separately already, so they should be safe.

While investigating the second, I noticed that read_in_full can
overflow its return value.  malloc doesn't typically allow allocating
a buffer with size greater than SSIZE_MAX so this should be safe, but
it would be confusing to static analyzers.

Combining these observations yields the following (just for
illustration):

diff --git i/bulk-checkin.c w/bulk-checkin.c
index 9a1f6c49ab..f8e3060041 100644
--- i/bulk-checkin.c
+++ w/bulk-checkin.c
@@ -114,7 +114,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 		unsigned char ibuf[16384];
 
 		if (size && !s.avail_in) {
-			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
+			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
 			if (read_in_full(fd, ibuf, rsize) != rsize)
 				die("failed to read %d bytes from '%s'",
 				    (int)rsize, path);
diff --git i/combine-diff.c w/combine-diff.c
index 9e163d5ada..e966d4f393 100644
--- i/combine-diff.c
+++ w/combine-diff.c
@@ -1026,7 +1026,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result_size = fill_textconv(textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
-			size_t len = xsize_t(st.st_size);
+			ssize_t len = xssize_t(st.st_size);
 			ssize_t done;
 			int is_file, i;
 
@@ -1040,6 +1040,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (!is_file)
 				elem->mode = canon_mode(S_IFLNK);
 
+			if (len > ULONG_MAX)
+				die("cannot handle files this big");
 			result_size = len;
 			result = xmallocz(len);
 
diff --git i/git-compat-util.h w/git-compat-util.h
index 6678b488cc..20fea81589 100644
--- i/git-compat-util.h
+++ w/git-compat-util.h
@@ -903,6 +903,13 @@ static inline size_t xsize_t(off_t len)
 	return (size_t)len;
 }
 
+static inline ssize_t xssize_t(off_t len)
+{
+	if (len > SSIZE_MAX)
+		die("cannot handle files this big");
+	return (ssize_t)len;
+}
+
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
diff --git i/wrapper.c w/wrapper.c
index 36630e5d18..2b52b7367d 100644
--- i/wrapper.c
+++ w/wrapper.c
@@ -314,6 +314,9 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	char *p = buf;
 	ssize_t total = 0;
 
+	if (count > SSIZE_MAX)
+		BUG("read_in_full called with absurdly high count %"PRIuMAX,
+		    (uintmax_t) count);
 	while (count > 0) {
 		ssize_t loaded = xread(fd, p, count);
 		if (loaded < 0)
