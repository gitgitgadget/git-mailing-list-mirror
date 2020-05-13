Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA19C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0B2206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="rXCEa2Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbgEMUBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733135AbgEMUBG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:01:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B891C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:01:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so11461493pjb.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RrErtsbZ5Sii24sv2NUAPpMyxeXAH9UL9BinlU9Onqg=;
        b=rXCEa2QxPYxJUAIqhgeNTLtNQa3EKWTud31IEvRREBtxY4OBTTXyIwp78M+BdCm8NX
         TyrgMW6Kh5qUxmrJtMewwuG3bQW3dH6HAHcIpWoq5M3pGjVCf8ewprW5iZdD41JdMm3x
         ifL9foa+QwJSPtE/vx3B1lc/ZxyiQ/WsdJ0/APtoUpYGG7HFNOdIU6UuHB2qtMv5BQiB
         fWuLO/6eiA2xY7Su60orVUaifw/YvK+krH6dwA3is/td/tIP6eiw9FavoY+4agV43UF8
         zzDvUzhn6ZQLtwCv1MjB1uqsmMshQww+Zc1Kf/gpZUrAdgGEu6f5Og73lsfyPwtzUUyo
         M0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RrErtsbZ5Sii24sv2NUAPpMyxeXAH9UL9BinlU9Onqg=;
        b=CzM/BhoW33LFwjvbbD1NsfCRsVJzxBKWK76/KojJIhGOQjJzWPvzbiI3rscvFzUJfc
         wvklQ4cVGXCbwI92QaNhTiYMXPWaBIFW6DmhV9RKKYbDvr7Ee1N8OdbXS5d+gxpTTUDq
         fRNNistYFyXunm6QWO0weCJHbH9PdqOFgYsP9P2J9PYxl3XGtZUfPzkG9vhKdQ2l+PRC
         TRAkZXg7Phlvy3/reR51X7FbX3QfUxpeJ7IheT0LFsbSGD9lgucQRlw4lDwm59ZUkVj2
         rOJ8T1hW/HMNGua1vrp9eQdlOAVqdA8tQrgvOLu34NA1j/RZYMKjhYaogGEf+xZesQvF
         BjKw==
X-Gm-Message-State: AOAM531fmkpYiUT4gtjVxRwlDgfmwB2Vy7KTKJmbY9dYQCwZclUTnFbv
        yIEiHpOKK7uHscp1dQZxALPeyQ==
X-Google-Smtp-Source: ABdhPJwIjhTImCmlrolZaEK+yngsiYdJO+edAtRx4RRbFU1JewIOdUW5Y4vcqNNXX9I/dQXLkZ98rw==
X-Received: by 2002:a17:902:eb54:: with SMTP id i20mr746934pli.179.1589400066020;
        Wed, 13 May 2020 13:01:06 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l11sm2449825pjj.33.2020.05.13.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:01:05 -0700 (PDT)
Date:   Wed, 13 May 2020 14:01:03 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH 4/8] builtin/commit-graph.c: extract 'read_one_commit()'
Message-ID: <20200513200103.GB24173@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <9ae8745dc090de37af0475ab12b79d541a52713d.1588641176.git.me@ttaylorr.com>
 <20200507200305.GB29683@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507200305.GB29683@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 04:03:05PM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 07:13:46PM -0600, Taylor Blau wrote:
>
> > In the case of '--stdin-commits', feed each line to a new
> > 'read_one_commit' helper, which (for now) will merely call
> > 'parse_oid_hex'.
>
> Makes sense.
>
> > +static int read_one_commit(struct oidset *commits, char *hash)
>
> This could be "const char *hash", couldn't it?

Yep, thanks.

> > +	struct object_id oid;
> > +	const char *end;
> > +
> > +	if (parse_oid_hex(hash, &oid, &end)) {
> > +		error(_("unexpected non-hex object ID: %s"), hash);
> > +		return 1;
> > +	}
>
> Returning "-1" for error is more idiomatic in our code base (though I
> know some of the commit-graph code doesn't follow that, I think we
> should slowly try to move it back in the other direction.

Yeah, I know the -1 is more idiomatic than what I had written here. This
was done so that I could use the return value from 'read_one_commit' as
an exit code from 'graph_write()', but I don't mind switching this to
'return error(...)' and then checking at the caller for a non-zero
return value and returning 1 there instead.

> > +		while (strbuf_getline(&buf, stdin) != EOF) {
> > +			char *line = strbuf_detach(&buf, NULL);
> > +			if (opts.stdin_commits) {
> > +				int result = read_one_commit(&commits, line);
> > +				if (result)
> > +					return result;
> > +			} else
> > +				string_list_append(&pack_indexes, line);
> > +		}
>
> This leaks "line" for each commit in stdin_commits mode (it used to get
> added to a string list). I think you want:
>
>   while (strbuf_getline(&buf, stdin) != EOF) {
>         if (opts.stdin_commits) {
> 	        if (read_one_commit(&commits, buf.buf)) {
> 			strbuf_release(&buf);
> 			return 1;
> 		}
> 	} else {
> 	        string_list_append(&pack_indexes, strbuf_detach(&buf));
> 	}
>   }
>
> Though I think it might be easier to follow if each mode simply has its
> own while loop.

Yeah, it's much clearer as two separate cases. I'll send something like
that shortly once I get to the rest of your review.

> > +
> >  		UNLEAK(buf);
>
> Not new in your patch, but this UNLEAK() has always bugged me. ;) Why
> not just strbuf_release() it?

I snuck it in! ;)

> -Peff

Thanks,
Taylor
