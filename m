Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CD3202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdGLSJ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:09:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33744 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdGLSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:09:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so3879539pgb.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dMQt04Odo8PLxQtfAmuzj6qk0fG4B7rnlzuElTo8FXE=;
        b=tojOHlw+UmgXuGnB0WPd2VxzeDJlHzBSpyVeh+LP7FCPFLMZu9YsFEhVNnkAesN0+L
         uWmQnNotrz/tsgrTRjUqwcU7ICJUyCrJP2kUzLMhQPyJlvOVMNbTD5Jg0D3xtNnkhAU+
         8gqtN+//Jttqc1d1a/BQXZp7ZLf7qvSw1muZYNv/MDKVkxsio50Gyye6R1HEeAY8dte5
         cqQ50nlxf3jHnCFs5QX2Mqyo5EaqSTXsvsSqIFKiTn7qP7IfxbqNoFuhY9l/wXhN4Le4
         LLwhbqZFpDD2B44GVQqFrTK/TbrEFl02Qi1pA0z3O5K7fFw5b0xmQQ1+RUCDeiTucJRE
         bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMQt04Odo8PLxQtfAmuzj6qk0fG4B7rnlzuElTo8FXE=;
        b=peqPHVnn1bc3yQAaZs5qnSHvLK+GBDn2nWKDolfR4Vt7ja4yEdPlv+q+9QQcg5Dof/
         l5Rv1Rxjba9lU4RqoVdtjbS/Gb363divEZZijEvH5EpzC+6KesyXZxR7857j9EFpFzTj
         joO8RALGFoZwjFtgCCJ+yJaiLxOu8j5nxqcsX80evOELymklQJKAdSCyHBl91yUbPLjt
         tGARzlzo0u9kHUJl+0sgW+HDOeogI+1ziKBltYbs1TVPaKswNgOF+BzqYsvxZSbdar20
         yHNB36UTHxSzjQFcfW3VggYz0DIdziE4RHY5X0RGWc2u0ke+GZgwcPEdRP+8VppEdlSM
         Ze0w==
X-Gm-Message-State: AIVw113io76cKr0kSqESvyaLSgdKobrTjf7kEZt1So5dmv/nHpiaUjYH
        BYKlCt/u5fUeCg==
X-Received: by 10.84.143.34 with SMTP id 31mr5527990ply.198.1499882967130;
        Wed, 12 Jul 2017 11:09:27 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:25ad:9264:1cd0:bb62])
        by smtp.gmail.com with ESMTPSA id c191sm4130199pga.15.2017.07.12.11.09.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:09:25 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:09:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712180923.GE93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> I didn't follow the rest of the "struct repository" series closely, but
> I don't feel like we ever reached a resolution on how config would be
> handled. I notice that the in-process "ls-files" behaves differently
> than the old one when config differs between the submodule and the
> parent repository. As we convert more commands (that use more config)
> this will become more likely to be noticed by somebody.
>
> Do we have a plan for dealing with this? Is our solution just "recursed
> operations always respect the parent config, deal with it"?

For settings like branch.<name>.remote, I don't think anyone would
disagree that the right thing to do is to use the per-repository
config of the submodule.  The repository object is already able to
handle per-repository config, so this just involves callers being
careful not to cache values locally in a way that conflates
repositories.  It should be pretty straightforward (for commands like
"git fetch --recurse-submodules", for example).

For settings like grep.patternType, on the other hand, it would be
very strange for the behavior to change when grep crosses the
submodule boundary.  So I think using the parent project config is the
right thing to do and the old behavior was simply wrong.  In other
words, I don't think this is so much a case of "deal with it" as
"sorry we got the behavior so wrong before --- we've finally fixed it
now".

But this is subtle.  Maybe some notes in the config documentation for
relevant settings would help.  That would make the intended behavior
clearer and make debugging easier for users.

Thanks,
Jonathan
