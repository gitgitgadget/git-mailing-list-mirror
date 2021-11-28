Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01004C433EF
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 09:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhK1JUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 04:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhK1JSk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 04:18:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E7C061746
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 01:15:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so10075133wmd.1
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tupSa7sr5U7v9oLcJRuULTDmDZHd7I11EPgOLF2lQQE=;
        b=MH5iblxbmYAxYqWhSEmfh2axsrSxIdXQEH4Kqb1rAe8V0P7ESWoXVhdV48sd2m+cQb
         JXFACE0y3UohmKWyWr49u2a31MhqmgswY8iQUBkAskfI0X7WSHjeNVqGtW2wXeb0OIil
         IEjnSUUxK2YrzAgKq3LBWOWmgS+LoVYB0iDV9ISnCC5tK8CusaBKwM6OTNAFqF3qYZRj
         Oii5LXJ54LhHhcTbpVqKqkPM2kZqIe8WWxD4e2CAWiPEL0D1ExBsjBnxlC1YSuY6m2pp
         IplIG5HQBMWS5aKcceLW5d2O/0fQfBQ01xr7279RGRzzrqUPsieLIg0LdkCH5KFe6Iyn
         XzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tupSa7sr5U7v9oLcJRuULTDmDZHd7I11EPgOLF2lQQE=;
        b=vmHtUe/yaBAgQ/qOiup4lFRoLvrWG9/t6fxavIGks5DE3x0kSpfRiWbYXFOySKZK9Q
         bhcr4V7PeJOzhtDI7ip/eZCC5BCOrZUUyCmML7TjhvNmj9k0lx9YkLwEC2MvLjb+fDsj
         JXuDUXfdiN/l6JR6zs/AtZMm+PNwblIvn47DcdLJ+5pIhJfWJ+d779dbrwaWXtNZTYmo
         BPX24mPEDejUrIJyLJuZgCdHZVruYTV+bb/SV6DdE8qGF4+ymXftLDaVwzM62HWJlCMx
         Ub34wsPG+gneWlQqonrXEV5szSUeyRhnEryy0iLD6+Gz0rVtohM2sqB2h8ZKu8qiP4LG
         W21A==
X-Gm-Message-State: AOAM532FK3w5yrs+4HzWm7h0khqCyYo0z0gKWnbHf9brODMJnKuWdqqV
        Snu064c8jec2nLxJ4DR9NogtyvrZoKw=
X-Google-Smtp-Source: ABdhPJzt75CMtR2Rj6h7hmwlDKZU53mxUrUcyA4KVSKmR040MwkzqxT8qWw3Xd6WQmM9WbUy2czIxw==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr27907192wmi.113.1638090923514;
        Sun, 28 Nov 2021 01:15:23 -0800 (PST)
Received: from gmail.com (194-166-82-161.adsl.highway.telekom.at. [194.166.82.161])
        by smtp.gmail.com with ESMTPSA id t16sm3573750wrn.49.2021.11.28.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 01:15:23 -0800 (PST)
Date:   Sun, 28 Nov 2021 10:15:21 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: git diff -I<regex> does not work with empty +/- lines
Message-ID: <20211128091521.7ysocurtt4qlgcf6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff -I<regex> suppresses hunks where all +/- lines match <regex>.
it is useful to filter away boilerplate changes.

Unfortunately, it doesn't help if a hunk has a blank line, because the one
obvious way to filter out blank lines (^$) match *every* line, surprisingly.
This is because for a line "01\n"
we have a zero-width match here ^$ (offset 3).

IOW, while we succesfully ignore deleted blank lines

	printf '\n' | git diff --no-index - /dev/null -I'^$'
	diff --git a/- b/-
	deleted file mode 100644

we also ignore non-blank lines (very surprising)

	printf 'non-blank-line\n' | git diff --no-index - /dev/null -I'^$'
	diff --git a/- b/-
	deleted file mode 100644

unless they don't end in a newline (special case)

	printf 'line without ending newline' | git diff --no-index - /dev/null -I'^$'
	diff --git a/- b/-
	deleted file mode 100644
	--- a/-
	+++ /dev/null
	@@ -1 +0,0 @@
	-line without ending newline
	\ No newline at end of file

This patch fixes the second example. Is this the right direction?
Do we want to honor core.eol, so we preserve the \r when we have Unix endings?

In any case -I<regex> won't be able to discern between "line\n" and "line"
but that's not important to me.

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index a4542c05b6..23325022b9 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1016,10 +1016,17 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 	regmatch_t regmatch;
 	int i;
+	const char *end = rec->ptr + rec->size;
+
+	if (rec->size >= 2 && end[-2] == '\r' && end[-1] == '\n') {
+		end -= 2;
+	} else if (rec->size && end[-1] == '\n') {
+		end -= 1;
+	}
 
 	for (i = 0; i < xpp->ignore_regex_nr; i++)
-		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
-				 &regmatch, 0))
+		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr,
+				 end - rec->ptr, 1, &regmatch, 0))
 			return 1;
 
 	return 0;
