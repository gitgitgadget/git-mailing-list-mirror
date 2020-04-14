Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A525C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B8020767
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 19:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b54TID7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504776AbgDNTbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731147AbgDNT3q (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 15:29:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC6EC025482
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 12:24:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so341963pgb.7
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=suIxCiXumn/DBRDEymuOmjrb6oIlsAhhl6/VDUFJiAU=;
        b=b54TID7CnTzpg2MzatOjiHoAwwDypEj6AUcrNYOh2i0xQOyxQNkiKdykQ33BX+0VVZ
         EiuZKCbpUKeq1R+fWmPfMwzaR+yTMheO6uOG/QYB3nLa+3/UC2JyHU92y5n2CzILDWeL
         MTRE1zttQR48pe00TIypNWxIgKqS95c7v1j64zlnxom+ehhIjtBCFOkoQfrX111ZfB/Z
         TjM1d8pV1FmkPl79teG1ob4yMTOjv5I3WVbTUlGoqp9+zQUevpKYNKKK1VTRITYLs6OH
         uZMklgMhCVt5RwS5/znIyTjgbPlbtSoGSnPni6z9T2HOrXBiw3VfAF1A4jkoIS9ltOTf
         idsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=suIxCiXumn/DBRDEymuOmjrb6oIlsAhhl6/VDUFJiAU=;
        b=fjJNPivCU6gqeBCyUVYd8+HF28hxOhNgZ14ZgHfzmwW/GUIYocG6gJADnYMs9YQkeQ
         nEqIorgZ3krEE8LATe00kSU2/JhoisLKpAGxY+BF/XrPJYe7JTANzluDDk0WB/x6QJbc
         GXbqX7mjp2BPpn9KQ+TCbMksvB48EqEInZgNma6qMZykJBkSSJjXpCnoIXUVyCuduixu
         GISollissxy6wUlmW5cY6tGJdbWKC3aFnxF2vlLJjdC8R/QtAj2FLhz0fMJZnmRpdSZi
         b65QPgA1/7Fg30i94GG89sSycMTbRjwGJU7wINz8zptLtraRGSnHpkxRqHXCbTPdwas9
         bFtQ==
X-Gm-Message-State: AGi0PuYdKW2oUPDRKyfxTJwwIpKVPhjMW9TCMP/JiTtIk0Jg00jPCwRw
        OSJU4xUhmxONSqWE0bi0wwg0etS2LFU=
X-Google-Smtp-Source: APiQypI8BrTpmnVLWCNTxVbHwBprlU/iQCwWziq5jGj7B4gyWqKnM9XpUm7PuEukYwTQwRk+002RSA==
X-Received: by 2002:a62:fc82:: with SMTP id e124mr9884571pfh.126.1586892263307;
        Tue, 14 Apr 2020 12:24:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b18sm168811pfp.88.2020.04.14.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:24:22 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:24:18 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
Message-ID: <20200414192418.GB5478@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:15:11PM +0100, Phillip Wood wrote:
> Hi Emily
> 
> Thanks for working on this, having a way to manage multiple commands per
> hook without using an external framework would be really useful
> 
> On 14/04/2020 01:54, Emily Shaffer wrote:
> > Not much to look at compared to the original RFC I sent some months ago.
> > This implements Peff's suggestion of using the "hookcmd" section as a
> > layer of indirection.
> 
> I'm not really clear what the advantage of this indirection is. It seems
> unlikely to me that different hooks will share exactly the same command line
> or other options. In the 'git secrets' example earlier in this thread each
> hook needs to use a different command line. In general a command cannot tell
> which hook it is being invoked as without a flag of some kind. (In some
> cases it can use the number of arguments if that is different for each hook
> that it handles but that is not true in general)
> 
> Without the redirection one could have
>   hook.pre-commit.linter.command = my-command
>   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'

I think this isn't supported by the config semantics. Have a look at
config.h:parse_config_key:

  /*
   * Match and parse a config key of the form:
   *
   *   section.(subsection.)?key
   *
   * (i.e., what gets handed to a config_fn_t). The caller provides the section;
   * we return -1 if it does not match, 0 otherwise. The subsection and key
   * out-parameters are filled by the function (and *subsection is NULL if it is
   * missing).
   *
   * If the subsection pointer-to-pointer passed in is NULL, returns 0 only if
   * there is no subsection at all.
   */
  int parse_config_key(const char *var,
                       const char *section,
                       const char **subsection, int *subsection_len,
                       const char **key);

We'd need to fudge one of these fields to include the extra section, I
think. Unfortunate, because I find your example very tidy, but in
practice maybe not very neat. The closest thing I can find to a nice way
of writing it might be:

  [hook.pre-commit "linter"]
    command = my-command
    before = check-whitespace
  [hook.pre-commit "check-whitespace"]
    command = 'git diff --check --cached'

But this is kind of a lie; the sections aren't "hook", "pre-commit", and
"linter" as you'd expect. Whether it's OK to lie like this, though, I
don't know - I suspect it might make it awkward for others trying to
parse the config. (my Vim syntax highlighter had kind of a hard time.)

> 
> and other keys can be added for ordering etc. e.g.
>   hook.pre-commit.linter.before = check-whitespace
> 
> With the indirection one needs to set
>   hook.pre-commit.command = linter
>   hook.pre-commit.check-whitespace = 'git diff --check --cached'
>   hookcmd.linter.command = my-command
>   hookcmd.linter.pre-commit-before = check-whitespace
> 
> which involves setting an extra key and checking it each time the hook is
> invoked without any benefit that I can see. I suspect which one seems more
> logical depends on how one thinks of setting hooks - I tend to think "I want
> to set a pre-commit hook" not "I want to set a git-secrets hook". If you've
> got an example where this indirection is helpful or necessary that would be
> really useful to see.

Thanks for sharing your workflow; as always, it's hard to understand the
ways others work differently from yourself, so I'm glad to hear from
you. Let me think some more on it and reply back again.

 - Emily
