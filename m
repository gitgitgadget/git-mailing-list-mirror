Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51190C11D20
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23180206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfjwiUp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgBTVPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:15:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43475 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBTVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 16:15:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so2027072plq.10
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGT8X/qj1OlKQwMoZqnXKUO4obpv+P81IDL+Mq20vTM=;
        b=ZfjwiUp/gDYi79ooQHZFivYHECFDiJKdw20xUaBWTGxx0tQW5quKHbbxyh/nbE3GQr
         62mh+yUZaGjPyd62zOzG1bC971rdRBkC9ozCokmLy0Pcsd09wrGfVAenVhBRdBqj5vN+
         2lH0+yZMZP6Clnf8NL6Zt+d5/35q9dxGNsRxBqAgkzRXJYDTpKUrHVEt5rzhfkOR5S2k
         9diy7clh6HqURrqd8WnHpmx57zpZ9QW1J0PVpefEL4Ype/9sEABdkz6QJzQ00AvLa/am
         +5KXpSkAC6T3oy1Xy5GzbJbWwkiUFTUryEs+tN3akDKEsnLf2UMVsjyBboQSxDge0kru
         qf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGT8X/qj1OlKQwMoZqnXKUO4obpv+P81IDL+Mq20vTM=;
        b=SRJ36eMx6QWeOCmVwaVja7NqAEZ7sgQXqi6Rn+sVtv1nTb3MTE6GKneOcA6a4FdMJl
         ZWdzdFCkeyL+cOPizf5Eevgaj3PIalz68tACVtc0cS/cG7XLKSBQrfCE8w3YbDjvvwwM
         3/ObCZtg+GwaDb7vBgz8BGRAu5I+7mwW7QqfYiV9I0yqZgzu0m00MwZfpygNuIq0938G
         ceRVNqm551FtiR4k4xPiOJMh9v7KGXJJzMrVXG3fAFi+wzhgUTSOzrrh1cgGNQPQzJaH
         fGK9CuWSAyBT8ajYdiaJ0Nn6pY0T9fXyqR6tqNF+x2yC6MWgxj19bDCoY/kTFMAen+37
         Smig==
X-Gm-Message-State: APjAAAWk10S+e+miQkQeS4m3xDfNGHbL61HALrkgIRqIrGFFi7ibzPVt
        WgXVrXzoLeohJmpmRejDuKnf7wl9+PU=
X-Google-Smtp-Source: APXvYqw4V/558togw1btK1O+cUNAND7YpORClpAGgOTku1jS8pYr/nBpOKKKBUHupcbZ/9yukuxTxg==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr5760895pjb.10.1582233330983;
        Thu, 20 Feb 2020 13:15:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id s125sm225830pgc.53.2020.02.20.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:15:30 -0800 (PST)
Date:   Thu, 20 Feb 2020 13:15:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 02/15] help: add shell-path to --build-options
Message-ID: <20200220211526.GC2447@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-3-emilyshaffer@google.com>
 <xmqqeeupaxnk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeupaxnk.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 11:03:59AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > It may be useful to know which shell Git was built to try to point to,
> > in the event that shell-based Git commands are failing. $SHELL_PATH is
> > set during the build and used to launch the manpage viewer, as well as
> > by git-compat-util.h, and it's used during tests. 'git version
> > --build-options' is encouraged for use in bug reports, so it makes sense
> > to include this information there.
> 
> It probably makes sense to capture PERL_PATH, PYTHON_PATH,
> TCLTK_PATH, and TCL_PATH, as they fall into exactly the same
> category as this one.

SHELL_PATH was already made sure to exist in git-compat-util.h before
this change; these other utility paths are not. Do you want me to add
them now?

> 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  help.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/help.c b/help.c
> > index a21487db77..190722fb0a 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -654,6 +654,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
> >  			printf("no commit associated with this build\n");
> >  		printf("sizeof-long: %d\n", (int)sizeof(long));
> >  		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
> > +		printf("shell-path: %s\n", SHELL_PATH);
> >  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> >  	}
> >  	return 0;
