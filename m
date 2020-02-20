Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3904C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813B120801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pibx8iBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgBTXD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:03:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43879 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgBTXD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:03:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so2664062pgb.10
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3q9YFaV3VI5Mn0dXlKp1JhD2nt3hyNg+oUwPpgzhKs=;
        b=pibx8iBhpK5Gw2DNm6XVeoN0tSq7SaxBsJZ1zlANm2dXKOpyLo/Le2Dt13F/3h/7eP
         /Stw7bWO7NHg9mTVFHQyagKELlOmdpoaj6ivvFb7g1XVLp63CMJ/YeGynnMBfUCTcLCK
         //soLqMK69dK5X2gCzm8E3EH3AL35EF0zsgI/tY8zhFoGH5M4EizOAdonYvTN+CPaXmt
         N4LO4KIj/poy2RDvWaTJvGkr7QePl1qu0zxgaT0wBZQ82es52T8Cg2v3WHWac8EzRSU8
         +6KZDCAegAROHhQ9XSt8EnKtL07H80UTwQ5mImh/gVXtHxRxOA79IRrmUbb+z6a/016W
         kdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3q9YFaV3VI5Mn0dXlKp1JhD2nt3hyNg+oUwPpgzhKs=;
        b=px/8KxtaqyTwEcQfXZoqE7q3nZpzZZh5a5kSQ6vqLXTVyWMzDqviuTAECjtWcklNzN
         2x8kiW8Qxy/zInLfOSrE/sZ4Cq0MgCoO+pGtsvN5KThwOwwVtfu6YrN9/4bu/ScJIfEN
         U6MOX2FKsqN0G8TcpzelyF6ih1zXPm2vABVFz8PkORO/9A75vHqUI4UBNBPZcXGin0pc
         4Z0VkED/2wExsLpkOEZ2+9uFdoFgXGssY0zA59m4hKE4SegMZQUA4ihF1fgBB4QJvsJJ
         Vj1JldWu/JWOFxWwQ8ltcdNORHZcj1iNAfEaw2uPPf/+Zpc6w29cYwQ/leDfKOYkDr84
         5VCg==
X-Gm-Message-State: APjAAAW7HrxQijuFR3tnvHh4HQpYn7Dsz7UXTQiTOGXvGgy7NdklY21z
        i4uAE17amEJk9duZ74XB6NhfaA==
X-Google-Smtp-Source: APXvYqzitdyDhLEQ9DTnI2Ejy+cpZKeAKse4aVJj1nMsMvITjKuTvWGSD0FTRmd+duVd2ljA+DUBzg==
X-Received: by 2002:a63:f60b:: with SMTP id m11mr34216484pgh.288.1582239805492;
        Thu, 20 Feb 2020 15:03:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id fz21sm446682pjb.15.2020.02.20.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:03:25 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:03:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 04/15] bugreport: gather git version and build info
Message-ID: <20200220230320.GE2447@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-5-emilyshaffer@google.com>
 <xmqq4kvlaup9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kvlaup9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 12:07:46PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +static void get_system_info(struct strbuf *sys_info)
> > +{
> > +	/* get git version from native cmd */
> > +	strbuf_addstr(sys_info, "git version:\n");
> > +	get_version_info(sys_info, 1);
> > +	strbuf_complete_line(sys_info);
> 
> It is a bit curious use of "don't do anything if sys_info ends with
> a complete line, but complete it if it ends with an imcomplete
> line".  That tells the readers that we do not know what
> get_version_info() will do (now or in the future) to its output
> buffer.
> 
> > +}
> > ...
> > diff --git a/help.c b/help.c
> > index 190722fb0a..44cee69c11 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -622,8 +622,33 @@ const char *help_unknown_cmd(const char *cmd)
> >  	exit(1);
> >  }
> >  
> > +void get_version_info(struct strbuf *buf, int show_build_options)
> > +{
> > +	/*
> > +	 * The format of this string should be kept stable for compatibility
> > +	 * with external projects that rely on the output of "git version".
> > +	 *
> > +	 * Always show the version, even if other options are given.
> > +	 */
> > +	strbuf_addf(buf, "git version %s\n", git_version_string);
> 
> This ends the output with a complete line when !show_build_options ...
> 
> > +	if (show_build_options) {
> > +		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
> > +		if (git_built_from_commit_string[0])
> > +			strbuf_addf(buf, "built from commit: %s\n",
> > +			       git_built_from_commit_string);
> > +		else
> > +			strbuf_addstr(buf, "no commit associated with this build\n");
> > +		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
> > +		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
> > +		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
> > +		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> 
> ... and the pattern indicates the output will end with a complete
> line when !!show_build_options, too.
> 
> > +	}
> > +}
> 
> So, was the strbuf_complete_line() merely defensive programming?  It
> may deserve a comment if it will stay there.

It was meant defensively, here and elsewhere in the series. I figured
that for something like this, which is mostly bounded by human writing
in an editor and then by file IO, spurious string-checking was not such
a big deal.

Are you suggesting to comment around the strbuf_complete_line() calls,
or to comment around get_version_info() that it should end in newline?

 - Emily
