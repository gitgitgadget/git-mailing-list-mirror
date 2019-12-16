Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C2AC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97F122464
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqGOKFcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLPWtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:49:35 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39717 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfLPWte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 17:49:34 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so3652690pjb.6
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qT+dlH9grL+5ChAGtxDwr/eeVTuwGWqIlREFvdmKuWs=;
        b=tqGOKFcmypOleeb9nZUUplfe6xLz6DQUA1DYj9qr7x/LBVbUtHTAdxAGc2wCxFsQTL
         ptVc8dJMUtpIIQ4XEQuF+GCU1doIx3275a6zpS/TBpkOIfhQrBYy/aaqP8mH2sR1/VS2
         3Wr0JszBFatP5p2NU6rU/h3qr8FR1rjYajjqp+YfKgagCKU371Vmp8tnC3P9vAC+Bnx2
         GulWhK9ddoWOskMkXgJBbzJ122WUA5aWaxZcf/LOdBAQFs+F2Jy0dz7fzt6MxyRVbOmq
         eoDOPXQU3+L6XMGEUWLAZfBQJXw4u6/8xsS3+Fr9zVOTYXN+zmxpusFkb4V9Mt9jvAKh
         cRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qT+dlH9grL+5ChAGtxDwr/eeVTuwGWqIlREFvdmKuWs=;
        b=ZYY5tEagSgEpiadv3mXxnN7wEan/c/jy/AbST7BNjHu3mj6w2FwjptwbLIQW5XzuI1
         iVa6BmsqsfmuCt/LO30lQ0zbhGVKXKzKviRxTgINE1bTlro//SNBAK6KUov3ofcahdxH
         PXeQr3sNNCbajyU/koypsueohKUQ8QQq+9naBqG6hOZb/cPJXbqmsDjG/plXfT4MkS5c
         D0W8OEzbJFTaFXwqn6DR2aK/PoQas3KYvAjXmC4q91eTahVzjgzx5igs8D6pJZsE+FdB
         GbfcPzn91TrhDNMM52ti7NaXI52JUrRckzNHvZECcLw1WeLGQRW8heokDYNRPTK25k8j
         nQ2A==
X-Gm-Message-State: APjAAAWBmWbWk8K77gmUF55SPrETNhf08mhAW4R0AqcHf0ACQz5dzhXz
        9V30LK7/pKEwEMei4+Zm+E+i7wsIWNU=
X-Google-Smtp-Source: APXvYqwUQNiw44evGbLW9LUYNldxe2Dxtf0NUULhDvev9adjKdwSKxLXZ2dqE68WpoY7lb0HQsnUbw==
X-Received: by 2002:a17:90a:33e8:: with SMTP id n95mr2150611pjb.17.1576536573493;
        Mon, 16 Dec 2019 14:49:33 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t11sm542142pjf.30.2019.12.16.14.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 14:49:32 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:49:28 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 07/15] bugreport: add curl version
Message-ID: <20191216224928.GH135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-8-emilyshaffer@google.com>
 <xmqqd0crj4qk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0crj4qk.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:27:31PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > It's possible for git-http* to be built separately from git; in that
> > case we want to know what version of cURL is used by git-http*, not
> > necessarily which version was present at git-bugreport's build time.
> > So instead, ask git-http-fetch for the version information it knows
> > about.
> >
> > git-http-fetch was chosen as git-http-backend was described as a
> > server-side implementation, and as an accidental fetch in case of
> > problems was considered less harmful than an accidental push.
> >
> > Since it could have been built at a different time, also report the
> > version and built-from commit of git-http-fetch alongside the cURL info.
> 
> One possible issue I have is that I was hoping that eventually we
> can discard "git http-fetch" altogether sometime in the future.
> Does anybody still use the dumb HTTP transport seriously?  

Oh, interesting. I was about to say, "I still use it to fetch, when I
don't really care" - but that isn't even true, as I fetch via https (and
have so much muscle memory to type https that I don't even notice).`

> 
> And the first move in that direction would be to allow the system be
> built without http-fetch, even if git-remote-curl (and its aliases)
> would still be built to access smart-http transports.
> 
> So, I am not sure.  This is just the matter of adding an out-of-line
> hidden option used only for environment inspection, so if it can be
> done to git-remote-curl, that would probably be much more future
> proof.

Ok. I'll move it.

> 
> > diff --git a/bugreport.c b/bugreport.c
> > index af715dc157..f5598513d9 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -5,6 +5,18 @@
> >  #include "time.h"
> >  #include "help.h"
> >  #include <gnu/libc-version.h>
> > +#include "run-command.h"
> > +
> > +static void get_http_version_info(struct strbuf *http_info)
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +
> > +	argv_array_push(&cp.args, "git");
> > +	argv_array_push(&cp.args, "http-fetch");
> > +	argv_array_push(&cp.args, "-V");
> > +	if (capture_command(&cp, http_info, 0))
> > +	    strbuf_addstr(http_info, "'git-http-fetch -V' not supported\n");
> 
> OK.  We probably can also take the compile-time "NO_CURL" into account,
> so that we can tell a misconfigured installation that wanted to have
> CURL but failed to install a usable http-fetch and an installation
> that deliberately omitted anything cURL?

Oh, interesting idea! I'll add that.

> 
> >  static void get_system_info(struct strbuf *sys_info)
> >  {
> > @@ -32,6 +44,10 @@ static void get_system_info(struct strbuf *sys_info)
> >  	strbuf_addstr(sys_info, "glibc version: ");
> >  	strbuf_addstr(sys_info, gnu_get_libc_version());
> >  	strbuf_complete_line(sys_info);
> > +
> > +	strbuf_addstr(sys_info, "git-http-fetch -V:\n");
> > +	get_http_version_info(sys_info);
> > +	strbuf_complete_line(sys_info);
> >  }
> >  
> >  static const char * const bugreport_usage[] = {
> > diff --git a/http-fetch.c b/http-fetch.c
> > index a32ac118d9..31844812a1 100644
> > --- a/http-fetch.c
> > +++ b/http-fetch.c
> > @@ -3,9 +3,18 @@
> >  #include "exec-cmd.h"
> >  #include "http.h"
> >  #include "walker.h"
> > +#include "version.h"
> >  
> >  static const char http_fetch_usage[] = "git http-fetch "
> > -"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
> > +"[-c] [-t] [-a] [-v] [-V] [--recover] [-w ref] [--stdin] commit-id url";
> > +
> > +void NORETURN version_info()
> 
> void NORETURN version_info(void)
> 
> 
> > +{
> > +	printf("git-http-fetch version: %s\n", git_version_string);
> > +	printf("built from commit: %s\n", git_built_from_commit_string);
> > +	printf("curl version: %s\n", curl_version());
> > +	exit(0);
> > +}
> >  
> >  int cmd_main(int argc, const char **argv)
> >  {
> > @@ -26,6 +35,8 @@ int cmd_main(int argc, const char **argv)
> >  		} else if (argv[arg][1] == 'a') {
> >  		} else if (argv[arg][1] == 'v') {
> >  			get_verbosely = 1;
> > +		} else if (argv[arg][1] == 'V') {
> > +			version_info();
> >  		} else if (argv[arg][1] == 'w') {
> >  			write_ref = &argv[arg + 1];
> >  			arg++;
