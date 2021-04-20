Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC68C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6F761029
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhDTSsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhDTSsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 14:48:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80700C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 11:47:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z16so27250393pga.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kysPBV6XC79bCxScrZJ7/D8TcnKHLPzzGPHUG4yjv8k=;
        b=tQCSaqcD/O8VFMHgfwHcCcDYEGTtWc77+kODpocvO7vsmsA5bfxZb4amhbZReciZQo
         AZ/of3ziSEl2t08e4lfo6c0wrp+dLdJfIdnMJkCFX3CXz9fFcd7iJsLvf7rMSmZKUBIv
         pdbvQm1VW0kIZbCjFky3YBkmpsJrXpG9lOI4JHAZKql2YZg61gSsXyvv9AKvEAZ4vWD6
         IP//bvMP8dsA4otQ3HWYqPEL9jC6gVAd57LqBdZsBFItOQmGG9P8+wN0/a2DZCmRgK3U
         omga6RuiYi/E+his1LuE96Y9JYF3GL22hebvzGwXTsLIiPvDhYOeuVxiG2R4hLIAAICv
         PZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kysPBV6XC79bCxScrZJ7/D8TcnKHLPzzGPHUG4yjv8k=;
        b=IslDXxiQKyPXCStxIFYlJBrWQLsi4LV5XxKsrhr1RgXpYUl/0VdZOC+YBKirc3RDQ+
         Onons5OJGdqbJyENzhCLjmSmw0D3np/MMbCwT44MZhS8eO2PpNT1FFqcj1QG1dczSrAS
         O8vd0TlfGFakRO+lWKIZQx9a3q/Htq9CczQzZ5CdHKypdu8FMAi2uGBGszGBr4JRgx5L
         1cdHCDXT/1soSvuWcIAY9LRz8g9iKcroq+1QMNDWqpKMZsiRz93RzsVjL8ys7X3NpIXM
         FFPFez51CRT9PDzvPlbR5JfWeMTdlXVOVvgtorYSEP6lqkjGJX4Yz7t4jQOclpF51imJ
         fCkg==
X-Gm-Message-State: AOAM533g7lWjIDpJlxfhwIrRfChK5YEv0SK8Fgn4juX1gpV+tRQ5EvRh
        W69bOOrfBHYzH5X3es96/FyWSA==
X-Google-Smtp-Source: ABdhPJyzKUG6RDsz81b7vynLAWTJ0dBjcrAwevryhkuCtKFwOivBg0jBq0lyLuTlU7NrGSThJYHbsg==
X-Received: by 2002:aa7:9e4f:0:b029:25e:cf65:c554 with SMTP id z15-20020aa79e4f0000b029025ecf65c554mr12538156pfq.66.1618944458827;
        Tue, 20 Apr 2021 11:47:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:828e:a107:e159:3343])
        by smtp.gmail.com with ESMTPSA id g4sm16703346pgu.46.2021.04.20.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:47:38 -0700 (PDT)
Date:   Tue, 20 Apr 2021 11:47:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git mailing list <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertcui@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: RFC/Discussion - Submodule UX Improvements
Message-ID: <YH8hxQKarZW6sU+9@google.com>
References: <YHofmWcIAidkvJiD@google.com>
 <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com>
 <013401d73552$287f49e0$797ddda0$@nexbridge.com>
 <CA+P7+xrOuhG5ujQRYS0=o7S9=xD5zm6BGp5mBRt493Lme9xYcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xrOuhG5ujQRYS0=o7S9=xD5zm6BGp5mBRt493Lme9xYcw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 09:18:05AM -0700, Jacob Keller wrote:
> 
> On Mon, Apr 19, 2021 at 12:28 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > On April 19, 2021 3:15 PM, Jacob Keller wrote:
> > > A sort of dream I had was a flow where I could do something from the parent
> > > like "git blame <path/to/submodule>/submodule/file" and have it present a
> > > blame of that files contents keyed on the *parent* commit that changed the
> > > submodule to have that line, as opposed to being forced to go into the
> > > submodule and figure out what commit introduced it and then go back to the
> > > parent and find out what commit changed the submodule to include that
> > > submodule commit.
> >
> > Not going to disagree, but are you looking for the blame on the submodule ref file itself or files in the submodule? It's hard to teach git to do a blame on a one-line file.
> >
> 
> Well, I would like if "git blame <path/to/submodule>" did.. something
> other than just fail. Sometimes my brain is working in a "blame where
> this came from" and I type that out and then get frustrated when it
> fails. Additionally...
> 
> > Otherwise, and I think this is what you really are going for, teaching it to do a blame based on "git blame <path/to/submodule>/submodule/file" would be very nice and abstracts out the need for the user (or more importantly to me = scripts) to understand that a submodule is involved; however, it is opening up a very large door: "should/could we teach git to abstract submodules out of every command". This would potentially replace a significant part of the use cases for the "git submodule foreach" sub-command. In your ask, the current paradigm "cd <path/to/submodule>/submodule && git blame file" or pretty much every other command does work, but it requires the user/script to know you have a submodule in the path. So my question is: is this worth the effort? I don't have a good answer to that question. Half of my brain would like this very much/the other half is scared of the impact to the code.
> >
> > Just my musings.
> 
> I'm not asking for "git blame <path/to/submodule>/<file>" to give the
> the same outout as "cd <path/to/submodule> && git blame <file>"
> 
> What i'm asking is: given this file, tell me which commit in the
> parent did the line get introduced. So basically I want to walk over
> the changes to the submodule pointer and find out when it get
> introduced into the parent, not when it got introduced into the
> submodule itself.
> 
> This is a related question, but it is actually not trivial to go
> instantly from "it was in xyz submodule commit" to "it was then pulled
> in by xyz parent commit". It's something that is quite tedious to do
> manually, especially since the submodule pointer could change
> arbitrarily so knowing the submodule commit doesn't mean you can
> simply grep for which commit set the submodule exactly to that commit.
> Essentially, I want a 'git blame' that ignores all changes which
> aren't actually the submodule pointer, update.
> 
> I think that's something that is much harder to do manually, but feels
> like it should be relatively simple to implement within the blame
> algorithm. I don't feel like this is something strictly replaceable by
> "git submodule foreach"

I think I understand what you're saying. Something like the following
tree:

super   sub
b------->4
         3
         2
a------->1

producing something like this:

'git -C sub blame main.c'

1 AU Thor	2020-01-01
2 CO Mitter	2020-01-02		int main() {
4 AU Thor	2020-01-04		  printf("Hello world!\n");
3 Dev E		2020-01-03		  return 0;
2 CO Mitter	2020-01-02		}

and
'git blame sub/main.c'

a Mai N		2020-01-01
b Senior Dev	2020-01-04		int main() {
b Senior Dev	2020-01-04		  printf("Hello world!\n");
b Senior Dev	2020-01-04		  return 0;
b Senior Dev	2020-01-04		}

or to put it another way: if we are treating superproject commit as "the
whole feature", then it could be useful to see "which feature added this
change" instead of "which atomic commit inside a feature added this
change".

To me, it sounds expensive to compute... wouldn't you  need to say, for
each blame line, "is this commit an ancestor of the commit associated in
THIS superproject commit? ...how about the next superproject commit?"
But I also don't have much experience with the blame implementation so
maybe I'm thinking naively :) :)

And even if it is expensive, considering that Jacob and Randall both had
different ideas of what their ideal 'git blame' recursive behavior would
be, maybe it makes sense to use a flag to ask for the more expensive
behavior, e.g. 'git blame --show-superproject-commit sub/main.c'?

 - Emily
