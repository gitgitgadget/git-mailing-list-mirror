Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DEAC77B76
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 21:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjDXVTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjDXVTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 17:19:34 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9A7D8B
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:19:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54fc6949475so56120047b3.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682371163; x=1684963163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAiy1fU/I647G0IDDydN72OTuDEw79YWfsmrF4T+FQ4=;
        b=NlZGzAyYrlc+UJycr3ZtzGCggTleRXglJLL6m+Q13I4jcQoT2j/QnpsbwTgzRqCQe4
         JVq5wl4OdCsD5btSFxPSFhZtjwhjGwFXanO8/XzQ6CTINQ0Q0M3vssRwf+H7Wzj+C8Wz
         7P9Sb0VtxmbIeW2+tz/ekVUd7aHeJ7aTfi3hsRU9m261bK34b5mbmKBpMnT1S3QJzVo/
         HUGxNqeQ/R9UBQkHaIczFlusvZRvUA0EdC6pgIqRpYM/yIOED3Nu6sgjqdZ3pMLgrSNV
         m9Zk2kFEQbNfUzI2e15uirPcL0YTsHU1Hq9O8my3SOM9pgiDh7d6/pP/nRR5AfcSArOf
         GSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682371163; x=1684963163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAiy1fU/I647G0IDDydN72OTuDEw79YWfsmrF4T+FQ4=;
        b=foxeFHYtTn6dA0oU6bA6G4ApS2WeG9EOJYUWHtluHZntZOFswb/1kwOtY8f6GgoF/i
         qNosbxdTHKoonHAa8IG3dlU8V9rKpiXYgm0+VECA+GrGzix5YPxfawZHih6VN9kg3IPQ
         +wIHMyh5BxqcKy81nFKXKahHBtPwcxMJCSX63G3Y5cnl+i/GfPznwtNF+xPB5mCU+lFf
         d7Ldiqlv6hnBhnutZaN8Csz9F9WC4TS4/aGZbr6Scfcc2vloemgxItDHtHg7Wip9LZYK
         sUcnGbUruOh+l9guX7TZ3FMo2bHxX9tKcYEn1P77DP0wxhNoCwBagE7eQ2hgvjXfOQJf
         G+Jw==
X-Gm-Message-State: AAQBX9dkbkkTNVB1aHvCCbb9kueIqIlbU//zEzSM3UA8lHHVXA5nkLUY
        ev2LKUvZmPzx1r8k728HeJqbdQ==
X-Google-Smtp-Source: AKy350bT9au3N/OX7Mbz7k9H7KpN1pH8Zlwpd38vuj4ChrWVgOY2KoHaz7kgIvIWlTC9PyKodPMyLw==
X-Received: by 2002:a0d:e082:0:b0:54f:a3e9:c8f1 with SMTP id j124-20020a0de082000000b0054fa3e9c8f1mr10303737ywe.37.1682371163609;
        Mon, 24 Apr 2023 14:19:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t190-20020a8183c7000000b0054c26b34e8bsm3128665ywf.144.2023.04.24.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 14:19:22 -0700 (PDT)
Date:   Mon, 24 Apr 2023 17:19:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <ZEbyVDWhSGAyKDJL@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <0ae07dec3663d7cbb0f8662c47485c0667a879b9.1681845518.git.me@ttaylorr.com>
 <20230422111657.GD2969939@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230422111657.GD2969939@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 07:16:57AM -0400, Jeff King wrote:
> On Tue, Apr 18, 2023 at 03:18:49PM -0400, Taylor Blau wrote:
>
> > @@ -159,21 +161,34 @@ int cmd__hashmap(int argc, const char **argv)
> >
> >  	/* process commands from stdin */
> >  	while (strbuf_getline(&line, stdin) != EOF) {
> > -		char *cmd, *p1 = NULL, *p2 = NULL;
> > +		char *cmd, *p1, *p2;
> >  		unsigned int hash = 0;
> >  		struct test_entry *entry;
> >
> > +		/*
> > +		 * Because we memdup() the arguments out of the
> > +		 * string_list before inserting them into the hashmap,
> > +		 * it's OK to set its length back to zero to avoid
> > +		 * re-allocating the items array once per line.
> > +		 *
> > +		 * By doing so, we'll instead overwrite the existing
> > +		 * entries and avoid re-allocating.
> > +		 */
> > +		string_list_setlen(&parts, 0);
> >  		/* break line into command and up to two parameters */
> > -		cmd = strtok(line.buf, DELIM);
> > +		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
> > +
>
> I'd argue we can drop this comment now. Having string_list_setlen()
> makes it a blessed pattern, and I don't think there's anything special
> about this caller that makes it more or less so. Obviously yes, the
> string list items won't be valid as we enter a new loop iteration. But
> that is always true of split_in_place(), not to mention strtok(),
> because we are overwriting the buffer in each loop.

Agreed, I think that part of the point of string_list_setlen() is that
this is a blessed pattern, so shouldn't need a comment.

Thanks,
Taylor
