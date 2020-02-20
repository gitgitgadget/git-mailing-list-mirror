Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB8C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFFE20801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCuwqJNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgBTX2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:28:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37759 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTX2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:28:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so190069pfn.4
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fk1Dasf9i4JTCBSU074Ezd9maDKcUS+Z8xdu7RAVZDc=;
        b=eCuwqJNmjKrWdv3vT96KE0NxJgDukYPt1jgMfBi4+T35lsFWIM/WMNluqV6bBHgfVc
         GXImZ9apP0blcGt4D09DP2uY3LrUsLzYf1PA5QZ2KBNyBJGhS1U41Uf2smS4+GHpbhTQ
         Uptk3CI8fVh50jcmFeo1F8I9Habvb/RpzB2zc0CBhYdGSn7GvR1mH5VfxEGgqSrkb8qm
         FAgy3MoDFpftm5GPeihoKAsCz/9mpOQ0b83eTQbnA1fuIqA77KmKDD+iLrjA2BKxvfLp
         wdBsb8LXi1IWT2wVnb2+pdHUVOs6+xfpSIVkZ7ah0scSS3wmYB9+tQNVZLHNvxbiLa9x
         4Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fk1Dasf9i4JTCBSU074Ezd9maDKcUS+Z8xdu7RAVZDc=;
        b=qQJM0W19f6WraIqKHKdGp1p6WQjjQNtx99+kCV8pu6kNtxTl3GfW9JiezXmoYYq00q
         NQ8XWeTtlBEQALUeZG9PZ7A5Bcm85sImSNsyKlZ2MaaqSv+yovBN72oDDEsv9j9p91tO
         7Q1BVL84dYU5xT1tRrFksIUpQSM8Foz+JGCESjta3m7dDNiDetV7PtbgVN9Ja5c6YXeM
         73tPNKoO31UJ/eJ/lUMEeQA6rGSxSI+b1QfxRY35XnOOVknwRnl266sAxadjcBfvcNQR
         A4p+oiBcgWiW/cy0n7Xp3lOFO8jlAB0B6wDLs1W5EB+kWbD6tiS00JCBhWF/gvM4/kLh
         4a8w==
X-Gm-Message-State: APjAAAUQVorKZ9CLBhIeGMjPVOS/w5HeM82ya/JY1RUEJTCUtKriqSXT
        V0U4bttmizuWIjSsHyRNSTfjeg==
X-Google-Smtp-Source: APXvYqx/viYwW3CRsd8aCcQs71tnKQit4NLYop7aNFnNZsxA3KB00wIdvmG7z1oSwsGo+2kgii8LdA==
X-Received: by 2002:a63:5818:: with SMTP id m24mr35761161pgb.358.1582241296935;
        Thu, 20 Feb 2020 15:28:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e1sm642508pfl.98.2020.02.20.15.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:28:16 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:28:12 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
Message-ID: <20200220232812.GH2447@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-8-emilyshaffer@google.com>
 <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 12:35:37PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +static void get_git_remote_https_version_info(struct strbuf *version_info)
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +
> > +	cp.git_cmd = 1;
> > +	argv_array_push(&cp.args, "remote-https");
> > +	argv_array_push(&cp.args, "--build-info");
> > +	if (capture_command(&cp, version_info, 0))
> > +	    strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");
> > +}
> >  
> >  static void get_system_info(struct strbuf *sys_info)
> >  {
> > @@ -29,6 +41,10 @@ static void get_system_info(struct strbuf *sys_info)
> >  	strbuf_addstr(sys_info, "compiler info: ");
> >  	get_compiler_info(sys_info);
> >  	strbuf_complete_line(sys_info);
> > +
> > +	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
> > +	get_git_remote_https_version_info(sys_info);
> > +	strbuf_complete_line(sys_info);
> >  }
> >  
> >  static const char * const bugreport_usage[] = {
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 8eb96152f5..73e52175c0 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -17,6 +17,7 @@
> >  #include "protocol.h"
> >  #include "quote.h"
> >  #include "transport.h"
> > +#include "version.h"
> >  
> >  static struct remote *remote;
> >  /* always ends with a trailing slash */
> > @@ -1375,6 +1376,13 @@ int cmd_main(int argc, const char **argv)
> >  	string_list_init(&options.deepen_not, 1);
> >  	string_list_init(&options.push_options, 1);
> >  
> > +	if (!strcmp("--build-info", argv[1])) {
> > +		printf("git-http-fetch version: %s\n", git_version_string);
> 
> We are letting bugreport grab this information from remote-curl, and
> they are different binaries, so git_version_string we see here is
> that of the remote-curl.  Good.
> 
> > +		printf("built from commit: %s\n", git_built_from_commit_string);
> > +		printf("curl version: %s\n", curl_version());
> > +		return 0;
> > +	}
> > +
> >  	/*
> >  	 * Just report "remote-curl" here (folding all the various aliases
> >  	 * ("git-remote-http", "git-remote-https", and etc.) here since they
> 
> Makes sense, except that it is not clear what our overall stance on
> i18n/l10n of the bugreport output.
> 
> I think there are two schools of thought.  
> 
>  - You can stick to C local, with an expectation that developers can
>    read reports in C locale.  This will allow developers to avoid
>    having to read reports written in a language they do not
>    understand, and also makes it easier to mechanically process
>    reports.
> 
>  - You can make sure what matters in the report is localized to the
>    end-users' locale.  This will avoid forcing end-users to send out
>    a report that they may not even able to read (which is what
>    happens if we did not do i18n/l10n).
> 
> I am not sure which way you are aiming at.  The boilerplate text
> we saw in a very early part of the series were marked N_() but some
> of the messages in later parts of the series are not.

I mentioned it in another reply to you at a different point in the v8
conversation; I took away the localization on the boilerplate at your
suggestion. Unfortunately I agree that we wouldn't be equipped to handle
reports in other languages. Not being able to understand the
user-fillable part of the report extends, I think, to not being able to
understand the diagnostic info. If the point of the report is to skip
back-and-forth, then writing back to say "actually, run all this stuff
manually so we can see the output in English" is not going to achieve
that goal.

 - Emily
