Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6CB1FD6A
	for <e@80x24.org>; Wed,  8 Feb 2017 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdBHU7i (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:59:38 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38092 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdBHU7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:59:37 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so795965itd.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YOnniDei9rTQa90j1E2hUZXggFdMBch6QDUrVXI+i/4=;
        b=JpueqM69eUT8zfCQBTFPFI39BHnwnSzvEcZrCmgi3zShj9CpupV7/obo8Jcl3LhY6r
         n2ieUA50/FFSCLMokm+GWn2fZPNXClkMDf9u6c1zPkDRzFanLr5J+LVN7Fk7GmfXzkHP
         xXTlxtBd2I8Ka0wI0NM5YCcXcavEv8EHpF9np9m/xu18kY05BciCux1Xs0QPHAuSjGwa
         +35nOvi0yfSP+jYYxPnX1rJWFaSctNblOB4cwOG+S2LOoI79QOWmZrbxdL5tRtFhIDAn
         GE34yFEGA4W+7gUWUanbm1aTEZwWamn0KGI9dPORa1utEC/CrPPpO8LkJMoOVjWwPdMM
         xqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YOnniDei9rTQa90j1E2hUZXggFdMBch6QDUrVXI+i/4=;
        b=SAKiu6nS6qrEpofjoEDjTqUenDMRjz5xlz/j9MoqUj+pVa2C9PNhU0HHc2tGGN2mcW
         BM+0DHMIvVhriW+DokcB3TICWRupyi+/li5l3pbR8qnmjrPPuXG76XdJCEN1giv6rJZr
         KsY+DdwXDoDYxobhl4NC9XIsW8RZRxtSAHS48vo3VH9EhPNqVuEOkm3BzxgCtEdU62p3
         65W1LqQXQZQlpoaIOof6IMHjoGc43vnMNACdL6VRvp3ytfJC/JT7OZCKh5rstvocns8K
         xRlHk9NSWm/GjlTbhAJOieRQv6oOex4lnilaj75+Dph/BK4ashQ8GDm+sPLYgXUf3nKx
         T/Rw==
X-Gm-Message-State: AIkVDXLce3rDmZvzlzW+JINS7y/Arg93v08nB/ArpdsdKrM7ilb6OF+vVWuIO4Ik7BWEfj03
X-Received: by 10.99.147.18 with SMTP id b18mr28837916pge.22.1486583679041;
        Wed, 08 Feb 2017 11:54:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:2d1c:e524:99eb:f617])
        by smtp.gmail.com with ESMTPSA id n8sm22619471pgc.16.2017.02.08.11.54.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 11:54:38 -0800 (PST)
Date:   Wed, 8 Feb 2017 11:54:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] dir: avoid allocation in fill_directory()
Message-ID: <20170208195437.GA108686@google.com>
References: <73ec9cc7-8a86-8ba9-90fd-a954fa031820@web.de>
 <CACsJy8CE-cyTZHZZhvhdsNau7iSqBci1BdUqDYvxoE5odV2SBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8CE-cyTZHZZhvhdsNau7iSqBci1BdUqDYvxoE5odV2SBA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08, Duy Nguyen wrote:
> On Wed, Feb 8, 2017 at 5:04 AM, René Scharfe <l.s.r@web.de> wrote:
> > Pass the match member of the first pathspec item directly to
> > read_directory() instead of using common_prefix() to duplicate it first,
> > thus avoiding memory duplication, strlen(3) and free(3).
> 
> How about killing common_prefix()? There are two other callers in
> ls-files.c and commit.c and it looks safe to do (but I didn't look
> very hard).
> 
> > diff --git a/dir.c b/dir.c
> > index 65c3e681b8..4541f9e146 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -174,20 +174,19 @@ char *common_prefix(const struct pathspec *pathspec)
> >
> >  int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
> >  {
> > -       char *prefix;
> > +       const char *prefix;
> >         size_t prefix_len;
> >
> >         /*
> >          * Calculate common prefix for the pathspec, and
> >          * use that to optimize the directory walk
> >          */
> > -       prefix = common_prefix(pathspec);
> > -       prefix_len = prefix ? strlen(prefix) : 0;
> > +       prefix_len = common_prefix_len(pathspec);
> > +       prefix = prefix_len ? pathspec->items[0].match : "";
> 
> There's a subtle difference. Before the patch, prefix[prefix_len] is
> NUL. After the patch, it's not always true. If some code (incorrectly)
> depends on that, this patch exposes it. I had a look inside
> read_directory() though and it looks like no such code exists. So, all
> good.

Yeah I had the exact same thought when looking at this, but I agree
everything looks fine.  And if something does indeed depend on prefix
having a \0 at prefix_len then this will allow us to more easily find
the bug and fix it.

> 
> >
> >         /* Read the directory and prune it */
> >         read_directory(dir, prefix, prefix_len, pathspec);
> >
> > -       free(prefix);
> >         return prefix_len;
> >  }
> -- 
> Duy

-- 
Brandon Williams
