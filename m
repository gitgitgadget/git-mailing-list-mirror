Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF2C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 01:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7CE2465E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 01:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAICg8Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLTBq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:46:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLTBqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 20:46:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so4314345pfn.4
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 17:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IG3duvAX2IIKqblmnT6QqJ0z/jdxYC8nGrLyVwpAFn4=;
        b=GAICg8NqbK2Lt9cgd29Ab1U6nTKKGAAQG+lcwary2IiW/Qd9cyvHraiOJewRnwLMWJ
         nY57vM6SZWzjgArxsP3KqnZGmPgh7NwPEzWA8aSD4lE15CHD7YGEqQ1+CNjFRiD6lwO4
         ZhEOzEfruXEqNQRRIDFzjk0/Vece+Fn6U9guKLmfqkFupWGig0XEwAQ7hXYWcX8nO1X0
         sJVyhXoxVxEhHTPNxK6ldF0i6VjsHZwXoJCV90INcDwdntxqC4F9yTi3byQaCQewwCTE
         cU7+giJc9IjDYsH+bMn9Bi0BmV9SfS0tyE1qmrWSnGAQqWVVJCt6vfl4v2kQd6EzZbPt
         Hfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IG3duvAX2IIKqblmnT6QqJ0z/jdxYC8nGrLyVwpAFn4=;
        b=JzGOcw2uhCNYZIYjjrbH3jV2muSJT5IytKQ+xF9bYfqOkI86OviBs3p0pJADQQe+q6
         Zcn8SFGHolxP3tIG9K9Q4xJauQgWsQytObnp9gBpzwQyn/hA6ZM26ewFNsWbeCWYW2eV
         hu37EBi56vFXKqPD+mk8o7kpnzIjUgJXoFT977lBH3N0cLyJjhm7SkrXjUO1Afzi65SN
         xl2gYAqQCUnAeI+vMM1CbTLOG00X8R0ve4DhHasD/fWdhILA/+qja84eK+RhPoFdn19f
         1hUpj2nEhosZ8FwibpSRLykb2eMtfLtP8hMmQS3plKZ/egDoYIgONL1XVXfyzYULKxa4
         Ua+g==
X-Gm-Message-State: APjAAAVQdMIf0BxJ04Yg93of3rqSwzFHuoXkAT1kTZ3qNqxGXADc4utp
        6iju2CHfpWALC138MhK7GPKdi23uqgQ=
X-Google-Smtp-Source: APXvYqyOVmnqtyPgAgdosRWsZwx8U0jkblGMzkkxkNVBC8kCZOTCnE/HImE7oJCZzndgebPHmwG4fQ==
X-Received: by 2002:a63:1106:: with SMTP id g6mr12125967pgl.13.1576806384766;
        Thu, 19 Dec 2019 17:46:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id hg11sm8044660pjb.14.2019.12.19.17.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:46:24 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:46:19 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 03/15] bugreport: gather git version and build info
Message-ID: <20191220014619.GC227872@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-4-emilyshaffer@google.com>
 <xmqqr218hr56.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr218hr56.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:06:29PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Knowing which version of Git a user has and how it was built allows us
> > to more precisely pin down the circumstances when a certain issue
> > occurs, so teach bugreport how to tell us the same output as 'git
> > version --build-options'.
> >
> > It's not ideal to directly call 'git version --build-options' because
> > that output goes to stdout. Instead, wrap the version string in a helper
> > within help.[ch] library, and call that helper from within the bugreport
> > library.
> 
> Move to strbuf() from stdio makes sense.  
> 
> > +	// add other contents
> 
> Style.

Sure, dropped this entirely. I think with the helpers the code is
self-documenting there.

> 
> > diff --git a/help.h b/help.h
> > index 9071894e8c..54f6b5f793 100644
> > --- a/help.h
> > +++ b/help.h
> > @@ -37,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len);
> >  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
> >  int is_in_cmdlist(struct cmdnames *cmds, const char *name);
> 
> 
> Many new helpers are called get_frotz(), but only one among these is
> called list_version_info().  I do not think the naming of the
> get_*() ones, that are private to the bugreport tool, matters that
> much, but unlike "list_commands()" whose purpose is to list the
> commands ;-), the new function does not list versions---it just
> gives information about a single version which is the one that is
> being run, so perhaps it is a misnomer.

Hm, sure. I renamed it to get_version_info(); I had named it list_*
because all the other helpers in help.h are named list_*, and it does
print more than one piece of info. But I do see your point (all the info
is about the same version) so I've renamed it.

> 
> >  void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
> > +void list_version_info(struct strbuf *buf, int build_options);
> 
> It is not clear to the readers build_options is a boolean that
> tells the function to include (or not to include) build options.
> Perhaps rename it to "int show_build_options" or something?

Agree, done.
