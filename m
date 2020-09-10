Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4CC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B2220882
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE2+Jr9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgIJTkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbgIJPhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 11:37:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A48C061368
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 08:19:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so437879wmi.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xSYG1oJu59JXEwOfJH4KwbcQnRwb6TZwm3sr5rIWgJk=;
        b=pE2+Jr9Sc+FuRG6kpnLqXUK1pTLuH2upL/v3lESjpNpmqkY/D2HJGVNSZr1kKpBhDW
         OD2U5/QITWY79fcAD6NujpxY2p+BsZiyNqxBCpa+CW+XrDZVy+Dq2/jtN3BReuBKUeC+
         n73wHRKPlM5OJxDjvpkU/AofdQrNvW96IlZ5pFdqW9P6fKEUM9x8kFJPXVWoVsbQJQNM
         gVsz6wGc4E8y/umlhE+og3JuB3lPGhjcwZQYNIjJQ9v/uY2Q11SBKWfSWd+95N99/ZHj
         5L8AZ9tK/G/CVjR4nSJt8mSmtHWPEv/WyWFwQx2d2Z92rTo8Ql7t6rg6uA2BncuIn4eA
         30+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xSYG1oJu59JXEwOfJH4KwbcQnRwb6TZwm3sr5rIWgJk=;
        b=dwhSLlMpjh3sTsG3j0T+iSVA/rMQhWjSnjGbAZxo4CbCLNqjbHGoG4OjFFihy8upjW
         pzpweQYHEmPWExmjmX4bFIQSCD0aRD3HUlrPm37PBT5fNo7gvJMVhR7/mZh/QSMZm8ID
         +dRWLrO1fGVC993AhenzgJq8oC/lcstt00DmWOU6R1aPx4HfqL7VPYbCpXkNAUl6f8xp
         kQbI06GbEQFE+9Oss/eJCwZE+VXSMOdNaffa4P/FdG75/qoYjfeAUdPQVLUlco7zKXpO
         xgfo1GfavR5WsLUAOzfVcBu0tcGg7Niy7fcmCLAB8oCFsVVnMMWA73/BCyR9LS8gF56L
         GY0A==
X-Gm-Message-State: AOAM531EDvv+JHAAl2Cb9Wj6lFxKRkET5WDuCt0AndYJ9I2vl+ePwGml
        07/69K38z7lPmRirA5Hp1nSyzm5w2KE=
X-Google-Smtp-Source: ABdhPJzu7VlEzgsGB7g0gMD7oPz9RWbT49VtCVIdp16DRJVQGsDcUxco5N8FPZ4+W/EWZdxifEmu9A==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr549545wmc.112.1599751181912;
        Thu, 10 Sep 2020 08:19:41 -0700 (PDT)
Received: from szeder.dev (94-21-23-168.pool.digikabel.hu. [94.21.23.168])
        by smtp.gmail.com with ESMTPSA id l9sm4003122wmh.1.2020.09.10.08.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:19:40 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:19:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20200910151935.GA5265@szeder.dev>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <20200909145114.GE6209@szeder.dev>
 <20200909222333.GH241078@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909222333.GH241078@camp.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 10:23:33PM +0000, brian m. carlson wrote:
> On 2020-09-09 at 14:51:14, SZEDER Gábor wrote:
> > On Tue, Sep 08, 2020 at 06:50:17PM +0000, brian m. carlson wrote:
> > > diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> > > index 19b12b6d43..6b95292559 100644
> > > --- a/Documentation/git-rev-parse.txt
> > > +++ b/Documentation/git-rev-parse.txt
> > > @@ -208,6 +208,15 @@ Options for Files
> > >  	Only the names of the variables are listed, not their value,
> > >  	even if they are set.
> > >  
> > > +--path-format=(absolute|relative)::
> > > +	Controls the behavior of certain other options following it on the command
> > > +	line.
> > 
> > Does it affect only one subsequent such option on the command line, or
> > all such options?  IOW, while standing in the top directory of the
> > worktree, would the following command
> > 
> >   git rev-parse --path-format=absolute --git-dir --git-path foo --show-toplevel
> > 
> > print three absolute paths, or one absolute paths and two relative
> > paths?
> > 
> > The wording here is not clear on this, the commit message doesn't
> > mention it, and the tests added in this patch only check one such
> > option, but looking at the code and doing some testing of my own I
> > found that it affects all subsequent such options.
> 
> It affects all subsequent options.  Moreover, I believe it's possible to
> switch in the middle of the command line if you want some things
> relative and some absolute.  That seemed to be both the easiest solution
> and the most flexible, so I went with it.  I'll add more tests for this
> case and improve the commit message.

Well, on first sight it seems nice that scripts have to specify
'--path-format=absolute' only once when querying multiple paths at
once, though on second thought no prudent script would query multiple
paths at once, because they might contain newlines.

> >   $ ./git -C Documentation/ rev-parse --path-format=relative --git-dir --show-toplevel
> >   /home/szeder/src/git/.git
> >   /home/szeder/src/git

> >   $ ./git rev-parse --path-format=absolute --git-path foo/bar
> >   fatal: Invalid path '/home/szeder/src/git/.git/foo': No such file or directory
> 
> That's going to be a little tricky to fix, but I'll look into it.

Yeah, I think I found trouble that way, too.  I wonder whether
'--path-format=relative' is really worth having, though.  Clearly
there's a need for absolute paths, because getting relative paths
causes difficulties for some scripts; I described one such use case in
a2f5a87626 (rev-parse: add '--absolute-git-dir' option, 2017-02-03),
and you just ran into another with Git LFS.  However, is there really
a use case that requires relative paths, because an absolute path
would cause similar difficulties?  I couldn't come with any.

So perhaps it would be sufficient to introduce only
'--path-format=absolute' (or equivalent) for now, and add a relative
path variant only when there will be an actual compelling reason to do
so.  And that would save you from the pain of addressing these bugs
shown above.

