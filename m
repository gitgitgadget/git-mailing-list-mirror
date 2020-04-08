Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09324C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF34920730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXGGJtpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDHBJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:09:12 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:55823 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgDHBJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 21:09:12 -0400
Received: by mail-pj1-f51.google.com with SMTP id fh8so478796pjb.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 18:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nyS9z/G+1PukHFpqALb5oYhCtYTqDcTMPq7oCCTAoaI=;
        b=vXGGJtpy2o1sm7pls2E1k83RQYDI2dRQ3OSEfHeXLRwMs3+qqSlG77rrQQwOJJu9im
         G/vlNvTBc6iZMSC4r/XjZER695i+vZq/uwmbd0E398K3s1dFLXGcMtESW66FdaDKEHr6
         onnXbub2Cm9rAI4F6k27gDBSPvUzlL8lTMoAQxampw5xZHEVEjV6VciEs9IuZd/PKjA/
         e6z1cHG5uydJPyY7zLwlHhro8GDHVHgyoQigUBTbw2VyH+xprh6L6lDwhjOOJ8ZdIr1k
         etOAzjt2XxirrjQwzqiCwsj3TxX3+tNEa0X87yjLNzh3dknfQBwkIS3xXavlD8n8DDuw
         ptnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nyS9z/G+1PukHFpqALb5oYhCtYTqDcTMPq7oCCTAoaI=;
        b=LK1YQmhUApp3UAsgQH0+qxie49n9+pAFJc9/vp/gJMsdWNzBUxYe8ZdNNPwIc1jvBe
         FPSE+YDelZC7up28aeZAXMNHBsVDRYax/7BiADMLKTe5r+93+h2w2CVMSH4bbNygHRVI
         Bc30BpTL6osR75wUxeA+G1SskQzz4GeRdXQxQJCI3BRWJ2Z4ec2qzDv9RBYfN3FjWY7e
         gKazql3XzTaEXiZ70gInTn7bmFc2kpq3gSRbFx7Ig4DOCYv5Zu59jBJ3x/ijN2odhQ4G
         J2MttI6IPQP8jxuN/dxcm0K42Hume+qDQxPN9XDIH6NFkKTkir8PUj1koiAfD8Tr7+Ki
         kvGQ==
X-Gm-Message-State: AGi0PuZZpX/w3vG0vHGFpXwJQE1FDQVF5/oMOfTJA6fAmGyOvZ6AefvT
        JvT400IG1A/KvWs2hI7QUP/jog==
X-Google-Smtp-Source: APiQypIoYryiaaNx6HumxFlHULAJdf9aj2pP4ybRmbVJch45F9ItqtiBynYkXbmeMQnyiuNBYFfi6A==
X-Received: by 2002:a17:90b:3645:: with SMTP id nh5mr2395568pjb.104.1586308149470;
        Tue, 07 Apr 2020 18:09:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i34sm14156648pgm.83.2020.04.07.18.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:09:08 -0700 (PDT)
Date:   Tue, 7 Apr 2020 18:09:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200408010904.GF137962@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <xmqq4ktures1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ktures1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 05:40:14PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > [hook "unique-name"]
> >   pre-commit = ~/path-to-hook.sh args-for-precommit
> >   pre-push = ~/path-to-hook.sh
> >   order = 001
> >
> > Then, in another config:
> >
> > hook.unique-name.pre-push-order = 123
> >
> > or,
> >
> > hook.unique-name.enable = false
> > hook.unique-name.pre-commit-enable = true
> >
> > To pick it apart a little more:
> >
> >  - Let's give each logical action a unique name, e.g. "git-secrets".
> >  - Users can sign up for a certain event by providing the command to
> >    run, e.g. `hook.git-secrets.pre-commit = git-secrets pre-commit`.
> >  - Users can set up defaults for the logical action, e.g.
> >    `hook.git-secrets.before = gerrit` (where "gerrit" is the unique name
> >    for another logical action), and then change it on a per-hook basis
> >    e.g. `hook.git-secrets.pre-commit-before = clang-tidy`
> 
> Sorry, but the description and the tokens used in there are so
> detached from the current reality that I am having a hard time
> trying to even guess what you two were talking about.  

Ack, sorry about that. Point taken.

> 
> For example, how would I express that I am using program X as my
> 'push-to-checkout' hook in a way consistent with the above
> description?  Would "push" correspond to your "git-secrets" and
> "checkout" to your "pre-commit", or would these be placed where you
> wrote "unique-name"?

If you are using program X, which lives at /bin/x, and you want to use
it as your push-to-checkout hook:

[hook "x"]
  push-to-checkout = /bin/x

"unique-name" is unique and arbitrary, which is why I mentioned it could
be either difficult to machine-generate or difficult to human-read.

 - Emily
