Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B41C43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 16:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiKGQN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiKGQNP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 11:13:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFB205E5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 08:13:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so31429132ejc.7
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4CnCZ5LW6JTw8X+r8BRL1+rw3MX+DuHSBT8fqGufNw=;
        b=I1TChEIv1rQh9zkSvKCLwHekbWFbD+g1o471h/Ic51BRbefGnVoOkhwnDBZlKrZ3Av
         0rFRU6EOXvgMq3dSVChdYTsX+nME6MJSTJ7mW+SePHs8M1Pi3DehHkNLCFlZ/7M8zSHA
         PUDBWxQN6B22OlOs+TVcPTBUfeoojU1u87+qpjyicuKgWXLFZogrwzJbh6PZQ/ZEHLIA
         wmbH39a7uvZO4Xsc4juI7KAsCA0pcSNn19eAk1J9BHJdyXm1yWpxBxExUQi242KXH7V+
         bEGMnShQQB+C6FfRtiq7b1zkTRPm30BICjF9CcbwFQ+9p2DlNIi00o+POp7NMggxLT8z
         3QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4CnCZ5LW6JTw8X+r8BRL1+rw3MX+DuHSBT8fqGufNw=;
        b=TzX1ia1Jji1IErgCc8vIwvpfbKWrmJ8Z+wtnqi1ecqB2EygsZMq5huBY2vhwU3UEKl
         LwoSVSls+m2sTCmh+GFleivWPZRLCtylBx27jas4a8tB+Qf6Ozn8xyXHpSivefgcio3m
         4xx4hSMib89nZtdmshD15xe+shG3e/rogU5Rt7YqDuutkhtAF8diohPKMFgrGytOXANG
         lj4+scgQ9v+vIsAce28tBLrcpNQem1Dz2aqtjYk2d1QEiixkkeb+d7O1MCkPzQ7RUJOP
         xnt7u67xlyZFw3GM2rKxrmjgAL3q3Qe2DU339alorfkBwErQLwjI5POIkgGWksm1SW9/
         CDew==
X-Gm-Message-State: ACrzQf06b+AMdabMbHLmStm9Oj4klNl6k3Zk228fly8JhTtrhDh/Npfo
        XC66JVyrpcrVJOXDdHBR3FDD5UhFMJ4=
X-Google-Smtp-Source: AMsMyM5cT1ziU8ekGgafTnOUQwrzhJ0f9U+RLXPcsuzprrYw1boZUj9Hr4dWHtijJYjUUFsdyc9T5A==
X-Received: by 2002:a17:907:2c72:b0:7a5:47da:5893 with SMTP id ib18-20020a1709072c7200b007a547da5893mr48277405ejc.612.1667837593221;
        Mon, 07 Nov 2022 08:13:13 -0800 (PST)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b0078d9b967962sm3609785eje.65.2022.11.07.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:13:12 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:13:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 3/3] diff.c: use diff_free_queue()
Message-ID: <20221107161311.GC1951@szeder.dev>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-4-szeder.dev@gmail.com>
 <Y2MKKTz4nK0L8uW5@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2MKKTz4nK0L8uW5@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 08:24:09PM -0400, Taylor Blau wrote:
> On Wed, Nov 02, 2022 at 11:01:42PM +0100, SZEDER Gábor wrote:
> >  int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
> >  {
> >  	struct diff_queue_struct *q = &diff_queued_diff;
> > -	int i;
> >  	int result = diff_get_patch_id(options, oid, diff_header_only);
> >
> > -	for (i = 0; i < q->nr; i++)
> > -		diff_free_filepair(q->queue[i]);
> > -
> > -	free(q->queue);
> > +	diff_free_queue(q);
> >  	DIFF_QUEUE_CLEAR(q);
> 
> So, this all looks fine to me. But I did a quick grep around for
> DIFF_QUEUE_CLEAR(), and this macro is used in quite a few places.
> Mostly, as far as I can tell, to "empty" out the diff-queue by setting
> its 'queue' pointer to NULL, and its 'nr' back to 0.
> 
> Should we be freeing the memory held by the queue there more
> aggressively? I.e., should we make sure that there is a
> diff_free_queue() call above each expansion of the DIFF_QUEUE_CLEAR()
> macro?

Definitely not.  DIFF_QUEUE_CLEAR is often used to initialize a just
created 'struct diff_queue_struct' instance; by adding a
diff_free_queue() above those it would operate on uninitialized
memory.

