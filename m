Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B33C5ACC4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515DC2469A
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMGlfOiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBSW2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:28:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38500 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBSW2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 17:28:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so679106pjz.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 14:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzQKbPpf51TCOoWS7Ph9UqQhRbvVtiyFUCn8hO8HpFI=;
        b=UMGlfOiEC/Eh7dyrj4AD90Ial50B7NKooYwILY9e4HQomNDP+UyJHISGbFnpFbmuNR
         Zh1eMtsCZoBW+1HAd7DjNFRedgTwfnwi7Ugig/LWCgISQzZQB2Lf19KFOXBsGxuyD1Eh
         g91RFjADW465FJFuWuF0tRttPlOiWF975rYG3m54Fj8DWVDeSPU5EcD+3+eGEo/B96Q0
         xOUGPZCMQnD59tvppqMVpORAWb20Gt+CgeoNqVyfojgnZwqOk7r71OmJhQhzqgWgtist
         KQlTRF77RbCnbl4lmU0JBsaMi5/ejewSv0KwdG4XxDb2IPafG/hWF3mxYUqeFHB8LcZg
         CS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzQKbPpf51TCOoWS7Ph9UqQhRbvVtiyFUCn8hO8HpFI=;
        b=qKktgZHEXwpKQYgPPPjTvmQgZbP7YnIhOk1r7ri/Z0Eh8671RsGdSDydswrLihHVIk
         vKn57PTj3xlEGv2JjOPxFi0OfKfzFU4zUcgARpNi7JuT17jkuSHFNBGehnyBAiUEkqLa
         zqPwTxM1/BivEU6arI3z5bYCxEmMEX8phjteQKz4LAzu8FMPsLUGkqqU78U4pc5aFE6e
         Lpy7z98ddoT3i3rE/n1WpMXN+UoZDDs/Xjn8G/sQm2WfnoF3VRzyEsNdyWYKa30pmGfM
         vOXFTame9+OjQh/Bi90LoDFA5GNaYUETu2Nm7Fd9Gw5/rDfwHStjD0KhXUfjzMbFk7Fi
         BzFA==
X-Gm-Message-State: APjAAAV7mOnalXcNzq1hL1RV0fNBM8fS6gh7kfIq1+/dg95P+p7L5Dkd
        qJj9zOzm71CbofYhrqcFIMhlwzVHy0s=
X-Google-Smtp-Source: APXvYqwBSUWpZlOPboXBbMnYkdL160LqTqOIB/7yLMhI+MkSXICuMncy2bTcZjTp+uFwiqwJERVd+Q==
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr26486635plb.274.1582151293058;
        Wed, 19 Feb 2020 14:28:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c19sm729306pgh.8.2020.02.19.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:28:12 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:28:07 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 07/15] bugreport: add git-remote-https version
Message-ID: <20200219222807.GB26221@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-8-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2002191524460.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002191524460.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 03:28:35PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 13 Feb 2020, Emily Shaffer wrote:
> 
> > diff --git a/bugreport.c b/bugreport.c
> > index 4f9101caeb..bfdff33368 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -5,6 +5,18 @@
> >  #include "time.h"
> >  #include "help.h"
> >  #include "compat/compiler.h"
> > +#include "run-command.h"
> > +
> > +static void get_git_remote_https_version_info(struct strbuf *version_info)
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +
> > +	argv_array_push(&cp.args, "git");
> > +	argv_array_push(&cp.args, "remote-https");
> > +	argv_array_push(&cp.args, "--build-info");
> > +	if (capture_command(&cp, version_info, 0))
> 
> Let's use RUN_GIT_CMD instead of adding `"git"` explicitly; It documents
> that we're interested in a Git command, and if we ever build a
> single-binary version of Git (as some Git for Windows users already asked
> for), it will make things easier.

Hm. RUN_GIT_CMD is an argument used for the run_command_v_opt* family of
calls, but it seems that setting child_process.git_cmd has the same
effect. Done.

> 
> > +	    strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");
> > +}
> >
> >  static void get_system_info(struct strbuf *sys_info)
> >  {
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 350d92a074..c590fbfae3 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -1374,6 +1375,13 @@ int cmd_main(int argc, const char **argv)
> >  	string_list_init(&options.deepen_not, 1);
> >  	string_list_init(&options.push_options, 1);
> >
> > +	if (!strcmp("--build-info", argv[1])) {
> 
> The context does not say this, but at this point, we already verified that
> `argc` is larger than 1. Good.
> 
> Also, in keeping with the existing code, we would need to use
> `--build-options` here (this is what `git version` calls the equivalent
> mode).
> 
> _However_.
> 
> I like your `--build-info` a lot more than `--build-options` (because the
> latter is very misleading: the commit and the date of the build are not
> "options" at all).

Sure. Thanks for saying so.

 - Emily
