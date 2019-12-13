Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA14C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BEA2077B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVxEjCNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfLMEAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:00:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41271 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfLMEAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 23:00:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so862037pgk.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 20:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9j2lJ912fnSryymNZRQq1J1PBK2iiInGgjE2M5LtoI=;
        b=wVxEjCNv41pfC1CzpNU7FDpBf+F4YB1h3DCyAkRlufGO5mGCFGw/L9Npo/z0F0A0z6
         ZWrZmAvl3O52E5IpZNX3Krl/GBiBbvT2ai2cbWX6b2PAU7PjZjeh7kGjL5w3neslSGZc
         KMX32U+T3cIW5jRWFfVRJ7m6f/CteHu1UauyjDTsw5U4iUrqVr7uxj928LKzon3xUJlN
         LwJuGw6sZOsqFKz8mlthk33CL0vWlBwO9gquTH2J/sEKGHJc2Fa9ydqO6Oq0nRnhFuit
         Qr1V6IjWfC7Uua8qITq3xvWXhyEQCKrFEOchMMb/j5TRkMQc4jy6U3QlHy3xCmbU0h2a
         pikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9j2lJ912fnSryymNZRQq1J1PBK2iiInGgjE2M5LtoI=;
        b=qtn3O0MU6hgNJDyXGFJnuZ8hGnQam0145WlbUrd4tk0J21xmz6Ys0Sa7o4O/TZz10W
         naGMrUD+0Ere+oeme7ze6L1jnApm5ytjKAabaq/aEu0xXSM0TcVXn2lOUB5FcStlGilA
         /TFiurrW0tAu2mlpj6aBE5Sgy6iYHN46/B7qyEmnc8B79XWjHkbcDxzUhoYN/9fxmHeC
         wejz/vozzDibrheG6IawX4/7FF6K1lyPNNfcmHulPVm8O+2B0Gwhz2nR48hKWndGFdJx
         zGxZY60IjmBHiZI84v92jvjJ5ucaAeXTDclJZZ4lZpGhdvxtVEpQx2+Oew78lII4GH/x
         XNoA==
X-Gm-Message-State: APjAAAWCckDAYpqkq1qtGxxonosbV7/pVQgGumKFMd0k22i/flYxH9zU
        1ix0a8Z2S+VcsBiW7KeIqIhG7g==
X-Google-Smtp-Source: APXvYqxafev54ZLyhZvndQaaRnKRuvW8Cdm+mbcOc6Qu0x3F90qllAuCIhJab3eKSVRCkf7FFJRqRA==
X-Received: by 2002:a65:6794:: with SMTP id e20mr14648437pgr.152.1576209647682;
        Thu, 12 Dec 2019 20:00:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t1sm1393809pgq.23.2019.12.12.20.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 20:00:46 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:00:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
Message-ID: <20191213040042.GB135450@google.com>
References: <20191204203911.237056-1-emilyshaffer@google.com>
 <6af006eb-6d67-4eb5-c4f5-1677d6cbd120@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af006eb-6d67-4eb5-c4f5-1677d6cbd120@syntevo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 05, 2019 at 12:58:19PM +0100, Alexandr Miloslavskiy wrote:
> I'm excited to see someone else join my effort, thanks for continuing my
> effort! Also, less work for me :)
> 
> On 04.12.2019 21:39, Emily Shaffer wrote:
> 
> >   static int file_callback(const struct option *opt, const char *arg, int unset)
> >   {
> >   	struct grep_opt *grep_opt = opt->value;
> > -	int from_stdin;
> >   	FILE *patterns;
> >   	int lno = 0;
> >   	struct strbuf sb = STRBUF_INIT;
> >   	BUG_ON_OPT_NEG(unset);
> > -	from_stdin = !strcmp(arg, "-");
> > -	patterns = from_stdin ? stdin : fopen(arg, "r");
> > +	patterns_from_stdin = !strcmp(arg, "-");
> > +
> > +	if (patterns_from_stdin && pathspec_from_stdin)
> 
> To my understanding, this check will not work as expected. `file_callback`
> will be called at the moment of parsing args. `pathspec_from_stdin` is only
> initialized later.
> 
> Maybe it would be better to convert `file_callback` into a regular function
> and call it after the options were parsed, similar to how
> `pathspec_from_file` is parsed later?
> 
> This will also allow to move global variables into local scope and resolve
> other small issues raised by other reviewers.

Yeah, I think this is a good idea for the reasons you stated, so I'll do
so.

> 
> > +test_expect_success 'grep with two stdin inputs fails' '
> > +	test_must_fail git grep --pathspec-from-file - --patterns-from-file - <pathspecs
> > +'
> > +
> 
> It is usually a good idea to test for specific error, like this:
> 
>   test_must_fail git grep --pathspec-from-file - --patterns-from-file -
> <pathspecs 2>err &&
>   test_i18ngrep "cannot specify both patterns and pathspec via stdin" err &&

Sure. Thanks.
