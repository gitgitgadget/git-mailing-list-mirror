Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C4C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A6660C41
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhHLU4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhHLU4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:56:46 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2591C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 13:56:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h11so12583538oie.0
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RhXhORa/y7Y+hOqsoKMRIzxeOAIs2TGVa5OeL2ZDGLw=;
        b=Caw8RgLz+b9WQOil2le96trFjio5ccgvw3jrwEdZ5aGMKZmj2DZLpxbONykNzEC+7P
         FlhakByvJ0Z6IT6nMR8c8QmtV8KYk9GQev4ZHq34KpIcknodqnJgT+Y4ggyiFnuXBivl
         nkWQ18492UsZKu22J6QItze1oPYf7C5XTgdDYBxekOURTQddLq5oxZuZf6SYLqEGu19U
         FJAsGGKLDyZbeE01/dFZGABXYBNug4n8rpBj3tJJ725iQq0lMPoPO8Mo8yprsRR5v9j8
         JZLc2i6x0GBXzwK1B7t57uqFJd1NlIdUavRaZx8rAnn8TEbIpDNLV3ii2GhpE7wTofr9
         8kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RhXhORa/y7Y+hOqsoKMRIzxeOAIs2TGVa5OeL2ZDGLw=;
        b=ewNp79rKpa8K0jgkyv21JqhdYGCrAwc3cNPaHofmMQixkkl5//Fso5Mb0SS3WeDQAj
         owrkiM0mG4iZH6pNfwBljtNHHuDbEdCZHr7N6CtlQZzhW+Jym4t7jsECg1PVXg6Trkfk
         t8L4lYlnMcQ4WSbGGvDCvdLrqZExLjnK06miAQZE7Ryl36UpNKxfCMQOzgxFpY14Ez9/
         5PHmVOqGLpoF6908GpIjmoQKKPm32xoEyRLN489X3it8BER6t+Vhvz34W5XvscduQDCt
         8MFTri5BvFJ3xtXP61pvduxeTWGEqS7P++4/CjvdF0aaW9ZneafcjoY4ihPQtsp6ToJc
         M5nQ==
X-Gm-Message-State: AOAM532P86v0PAS6lDsFUpM7yEd+Mi9lk3nGgXkIpX1Fip0rIzzrnujj
        kQxXXc1HWPEZa0gKSyAvvg8=
X-Google-Smtp-Source: ABdhPJz3ICQHKMXo8iA5jKDKcpYZHqpJauB11APDkLMGxwJ+vY7np4Y+CtHXEkIb6matIzObG8+65g==
X-Received: by 2002:aca:de8a:: with SMTP id v132mr1771869oig.74.1628801780070;
        Thu, 12 Aug 2021 13:56:20 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id g5sm429788ooq.17.2021.08.12.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:56:19 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:56:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Xingman Chen <xichixingman@gmail.com>
Message-ID: <61158ae83406a_a3522086a@natae.notmuch>
In-Reply-To: <CAPUEsphWN_-BWyfF9mnPhL56RSnmPZfmvh_QwhjoAb3xin8V-w@mail.gmail.com>
References: <YRHQAFDXs5xvyDND@coredump.intra.peff.net>
 <CAPUEsphWN_-BWyfF9mnPhL56RSnmPZfmvh_QwhjoAb3xin8V-w@mail.gmail.com>
Subject: Re: [PATCH] apply: keep buffer/size pair in sync when parsing binary
 hunks
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas wrote:
> On Mon, Aug 9, 2021 at 9:24 PM Jeff King <peff@peff.net> wrote:
> > diff --git a/apply.c b/apply.c
> > index 44bc31d6eb..4ed4b27169 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -1917,6 +1917,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
> >
> >         state->linenr++;
> >         buffer += llen;
> > +       size -= llen;
> >         while (1) {
> 
> Ironically, I was looking at this code because of your previous
> patch[1] that you suggested was ugly
> and because I was going to suggest moving from a for to a while loop
> to avoid the overly long line.
> 
> It is interesting to note though, that having a for (and obviously
> removing the last 2 lines from the loop) with a comma separated
> increment instead would
> have made this issue IMHO more obvious, and also why I decided against
> that; would it be a good idea to fix that as well?

What's the point in updating size when it can be calculated? Just add a
pointer to the end of the buffer, and then size is the difference
between the buffer which is moving, and the end pointer which is fixed:

-- 8< --

diff --git a/apply.c b/apply.c
index 44bc31d6eb..cfb5a00356 100644
--- a/apply.c
+++ b/apply.c
@@ -1891,15 +1891,15 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 	 * to 1-26 bytes, and 'a'-'z' corresponds to 27-52 bytes.
 	 */
 	int llen, used;
-	unsigned long size = *sz_p;
 	char *buffer = *buf_p;
+	char *end = *buf_p + *sz_p;
 	int patch_method;
 	unsigned long origlen;
 	char *data = NULL;
 	int hunk_size = 0;
 	struct fragment *frag;
 
-	llen = linelen(buffer, size);
+	llen = linelen(buffer, end - buffer);
 	used = llen;
 
 	*status_p = 0;
@@ -1919,13 +1919,12 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 	buffer += llen;
 	while (1) {
 		int byte_length, max_byte_length, newsize;
-		llen = linelen(buffer, size);
+		llen = linelen(buffer, end - buffer);
 		used += llen;
 		state->linenr++;
 		if (llen == 1) {
 			/* consume the blank line */
 			buffer++;
-			size--;
 			break;
 		}
 		/*
@@ -1955,7 +1954,6 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 			goto corrupt;
 		hunk_size = newsize;
 		buffer += llen;
-		size -= llen;
 	}
 
 	CALLOC_ARRAY(frag, 1);
@@ -1966,7 +1964,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 	free(data);
 	frag->size = origlen;
 	*buf_p = buffer;
-	*sz_p = size;
+	*sz_p = end - buffer;
 	*used_p = used;
 	frag->binary_patch_method = patch_method;
 	return frag;

-- 
Felipe Contreras
