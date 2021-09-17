Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F6C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B441961130
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbhIQW7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhIQW7q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:59:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019BFC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:58:24 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 72so10599938qkk.7
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KHlt0fTVE7QBhjKkI6ZdBIj4ej2nDzTVwt13Jx5DXCQ=;
        b=JOpY2ae5+8YijCW6f9MLc1ftpslnD0RN+PSmSnaQVfvZMPOgYxExfk2hg57KTX/Cnj
         Yhu13dsgKkLMw/k1eTHsHRKIcgujm4WEGWGuZ0w2YuINk1u3l6Cy4k6CbQoF1Qf+5fPN
         Ewv1z3lQg1MiQNVUH5f8Ujo3c8Gzz+lYqdi5D6tVT74VZaM90gtdOU+lSck1YzUbLq/6
         W5QbQRr8ULabO+5SbRblD55zSz9wxWGP7F9Lw2gHN+qt0F/D9EmGdzw3oRHMhk1HBb/q
         AH8vu4Gbg6T4DgpD2p4bAYKcuMVRl8gDezzrJbelRDv3AGt5t5dbaeOJjZtnX3oMYhIV
         UPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KHlt0fTVE7QBhjKkI6ZdBIj4ej2nDzTVwt13Jx5DXCQ=;
        b=SgeTlPqlDQrlw+rCbzzrvfi2AWhWj8DAqTTeiJpJYa6gbfsiWykv17MJfgv5PkvoQl
         pi3wFfgKPuXnwnX2e/e4RcsLYr8D++FIpcqJb2RSvS9Ynr0U2/R5lGVv07bVq4VDcoQQ
         hvEZSv0TtWpeBYzdcz0/Pp5tjf2giY8XM4jcrmUaia9DDrpRx/GbDITUTO0u2/mMLzV/
         jEvCjRobmrUa14VlDyptePxT4cF5piW7RcU9mcFwEtUy7yM19nr/UnUazlNuANtkP/qK
         hNrmjRxe0pKPeVzKnThYzXRvjg9pKBR74uiFi5oBIsu1KrP5VNUotVb6WCT0r/D4uYD4
         7fRA==
X-Gm-Message-State: AOAM531wElnpCxe9M46ReETBYkDUhyF5S9g8TSc7NNvqgdgZf5pmo6uE
        q9EqOrSLlzEUw9NYscjZE5g=
X-Google-Smtp-Source: ABdhPJxl8idWcgQIsyZup1UtXi9hanTyl5NefTuBbqKPSZ7yWrMUR1C8irUsGBp9XRpol5oAUG8WoQ==
X-Received: by 2002:a05:620a:4001:: with SMTP id h1mr13131140qko.454.1631919502997;
        Fri, 17 Sep 2021 15:58:22 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id i67sm5686784qkd.90.2021.09.17.15.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:58:22 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:58:20 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        gitmailinglist.bentolor@xoxy.net, git@vger.kernel.org
Subject: Re: Should `@` be really a valid git tag name?
Message-ID: <YUUdjNDkL7Uy5erG@carlos-mbp.lan>
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
 <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
 <xmqq4kaihqjj.fsf@gitster.g>
 <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 05:47:17PM -0400, Jeff King wrote:
> On Fri, Sep 17, 2021 at 01:53:52PM -0700, Junio C Hamano wrote:
> > > On Fri, Sep 17, 2021 at 7:12 AM <gitmailinglist.bentolor@xoxy.net> wrote:
> > >>
> > >> A SO commenter pointed out, that git-check-ref-format forbids @ and
> > >> maybe I should report this as a potential bug. Is it?
> > >
> > > a reference that is named "@" only is invalid, but refs/tags/@ is not.
> > 
> > ;-)  
> > 
> > "git check-ref-format master ; echo $?" would show that any single
> > level name is "forbidden", so probably the SO commenter (whatever
> > that is) was confused---it is not about @ at all.
> > 
> > In any case, a tag whose name is @ may be another source of
> > confusion in the modern world, after we added @ as a synonym to
> > HEAD.  I do not know, for example, offhand which between the HEAD or
> > that tag "git show @" would choose.  It makes sense to avoid it.
> 
> In the past when we've had confusing names (like refs/heads/HEAD), we
> continue to allow them at the plumbing level (to retain backwards
> compatibility), but flag them at the porcelain level to prevent users
> shooting themselves in the foot. This seems like a good candidate for
> that (for both git-branch and git-tag).

I was leaning towards something like that plus a Documentation update, but
noticed that the current behaviour was inconsistent, and the confusion
pointed out by Junio seems to indicate it is better if fully restricted.

Carlo

----- >8 -----
Subject: [PATCH] refs: mark "@" as an invalid refspec

9ba89f484e (Add new @ shortcut for HEAD, 2013-09-02), adds "@" to
the list of invalid refspec, but does it only for full refspec and
not as a component.

Move the logic to validate it at the component level to prevent also
tags to be created with that name.

Reported-by: Benjamin <gitmailinglist.bentolor@xoxy.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 refs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9f7c3a80..2ca6995c0f 100644
--- a/refs.c
+++ b/refs.c
@@ -47,13 +47,14 @@ int ref_storage_backend_exists(const char *name)
  * 4: A bad character: ASCII control characters, and
  *    ":", "?", "[", "\", "^", "~", SP, or TAB
  * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
+ * 6: @, only valid if used around valid characters
  */
 static unsigned char refname_disposition[256] = {
 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
 	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
@@ -137,6 +138,14 @@ static int check_refname_component(const char *refname, int *flags,
 			 */
 			*flags &= ~ REFNAME_REFSPEC_PATTERN;
 			break;
+		case 6:
+			if (last == '\0' && *(cp + 1) == '\0') {
+				if (sanitized)
+					sanitized->buf[sanitized->len] = '-';
+				else
+					return -1;
+			}
+			break;
 		}
 		last = ch;
 	}
@@ -167,14 +176,6 @@ static int check_or_sanitize_refname(const char *refname, int flags,
 {
 	int component_len, component_count = 0;
 
-	if (!strcmp(refname, "@")) {
-		/* Refname is a single character '@'. */
-		if (sanitized)
-			strbuf_addch(sanitized, '-');
-		else
-			return -1;
-	}
-
 	while (1) {
 		if (sanitized && sanitized->len)
 			strbuf_complete(sanitized, '/');
-- 
2.33.0.911.gbe391d4e11
