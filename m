Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC1C2BA12
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311B5217D8
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EasQsLOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgDCUkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:40:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46641 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgDCUkT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:40:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so10001339wru.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7kkOkUiVtNHnSOe7KbWWWygZ4U68gLXsnnvPN+A21Hg=;
        b=EasQsLOaJrbskDhKp6QT/+WR8IdAxYoTvNG60/IfCrvxQX82HSdQtDL5ayIGD8VUQs
         I04vpB9JrEUoRd54+NlNXZDAWn/1X7mDp4ADm5OjwyXBXnVGIgGsmeAJHVK0Td13aKr5
         I+U64D2g7ZSq1KiskYW/ZK2YuF5K4FDuGJS7NSSbonfyKbjuvGK5HFhgnaV9kRt7b8AC
         LsU1n0kVK38C4ft9rjuRRlyVODKDYryU9o70QGdOYAYgmKw/emF7WBAPSB2LOzIyif1s
         TX55YSRuUX3hHE7Q/A7H73xb9gvqhM/VthTwKF58YOtt4dqklNPZOLx+UPoJwb2Mhy6+
         1MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7kkOkUiVtNHnSOe7KbWWWygZ4U68gLXsnnvPN+A21Hg=;
        b=Fbh6yNd6ubZ1/8u2UxQpToPslNAv+E9vkmY+6noifxQ0UMbGvkZr43hKtba9RLODHW
         AU38UW9OJmCOh5uJJaNQbb+1UooXBTCCDvmp7xcX0cZ7cKZGi3Cb/1cVkUhXSTEWzWK7
         9wDiechWibAQn2nIBVp37VQM2ks3FuwoW8FQPnauctFGXtFVBuaAquJaTRo2TQ23xt+k
         /6J+APNjwGglMpFShYQIFfJrg7m1J0D60bkrFSDDEMgnDCFdOGEKdbN/kv9AIIzLtTxv
         I2AOzG08ePsvesT2bjOAGLjTMM/NFw8G5i8rVuiEowBQP/6mwftcdx8XGfK/TK9zYKCq
         1VHw==
X-Gm-Message-State: AGi0PubsqArfbWqGZId+xz9iYlmeReeMnH6xT99FLPss5A8hLbAez/RA
        XEQ5TMLGLqlIlzV/p0jptFA=
X-Google-Smtp-Source: APiQypLPSwNPFsJAn4aTOYTG8lBO106scTVKvRYk/xEzXra4burdZcTXbhI418lQ0sB+YOAdDIz0+w==
X-Received: by 2002:adf:e44a:: with SMTP id t10mr10765148wrm.322.1585946416518;
        Fri, 03 Apr 2020 13:40:16 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id g127sm12971227wmf.10.2020.04.03.13.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 13:40:15 -0700 (PDT)
Date:   Fri, 3 Apr 2020 22:40:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403204013.GC7859@szeder.dev>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <20200403193842.GA7859@szeder.dev>
 <20200403195103.GA663412@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403195103.GA663412@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 03:51:03PM -0400, Jeff King wrote:
> On Fri, Apr 03, 2020 at 09:38:42PM +0200, SZEDER Gábor wrote:
> 
> > > > Can you explain more why the old behavior is a problem?
> > 
> > Because when I do:
> > 
> >    # sometimes I forgot that refs are not good...
> >    $ echo HEAD | git commit-graph write --stdin-commits
> > 
> > then I get _nothing_: neither an error, nor a commit-graph.
> 
> OK, that makes more sense: it's an input format error, because we only
> take hex oids.
> 
> Do you care about complaining about:
> 
>   git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
> 
> ? That's the case that's much more interesting, I think.

Hm, are you trying to go in the direction where '--stdin-commits'
would keep erroring out on any non-full-hex-oid, but would accept and
silently ignore any hex oids that are not commits (perhaps even when
there is no such object, dunno)?  I think that would support the use
cases you mentioned, while it would still save me when I do the 'echo
<ref>' thing (somehow I regularly do that, remember doing it the day
before yesterday!).

I only mentioned the ^{tree} form in the commit message for the sake
of completeness, i.e. to show various cases where the user would get
neither error nor commit-graph.

> > Or introduce 'git commit-graph write --stdin-refs'?  Or teach
> > '--stdin-commits' to DWIM and accept and parse refs?  Though the
> > question still remains what to do with refs that can't be peeled back
> > to commits
> 
> Right. I think there are two orthogonal questions:
> 
>   - whether to resolve arbitrary names to objects and how to handle such
>     input if we don't
> 
>   - what to do with an oid (whether given as hex or resolved from a
>     name) that isn't a commit-ish
> 
> -Peff
