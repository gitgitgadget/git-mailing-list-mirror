Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BE72018A
	for <e@80x24.org>; Fri, 24 Jun 2016 14:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbcFXOoI (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 10:44:08 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34673 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbcFXOoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 10:44:07 -0400
Received: by mail-yw0-f179.google.com with SMTP id i12so98931668ywa.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 07:44:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Wy8vaQIjHSx/CNt21+mFZyi5fTjLQ5Bgc2aTec5/I98=;
        b=y0g7HhLwJsHrHqMMH8gph5/5j+mVGG7w8Aa9b6nXjAsuUE/CoYe24TX44TMQPv29ul
         PUkLBb3YG5ot27Xs28KMydxLs4BF70pG9LRgdt3d/NoO+fgHMw4He0zYoS6o0KGY+NLM
         386KOe26YKUWqJmFFFX1raIyJNO6B7fi4gEheYJCzGxjmHSCSG2Y8JVjL9+uZCmiqGsq
         cAuZJ3gdoZhXT9cnau9Qdyzs/bIlYZBQxPLAbdjFAq2zLADbjGr5B855VilGGAEOzQJc
         jSkXmarNiCR1S18c8k+QHqk+gB1x6pY5Y5ZFa6/ftGN8eZKuLeBEMTqLG1HUgoBkS8Iw
         NdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Wy8vaQIjHSx/CNt21+mFZyi5fTjLQ5Bgc2aTec5/I98=;
        b=crmB48btloKrhpI6yZoyJuWRqWgk/qOr94Qqhpdu/80sqXESCQivK5vEdYNrHV6fnt
         yVFlmjKHzvmbQvcHVcpUrkJrWmirpqO+ypMO+qlI2y3TlhWPCnezcGEMyNuSB7OKQYDB
         Bo2Z2o74q2bjgO8wrb7W3/j9Ow76K7Hz5CcY8n8B2n3vkADh+BYNchGvgbDD415s6u/B
         AUk3qhp1ojt3TTb7AsqIsCN5diH+PVf6FWGE6gWl5D0z4VZO0XnfqEdvqy1/FF2Axg/t
         t5x54XbhTWLpa6PuzGcJkdfJ6RWxaJ5Vw0DH7G9jA1RIzy65DsNXX5bjZTrG//CK6m+c
         Mi4g==
X-Gm-Message-State: ALyK8tKrMWMdUR/yKbwBiyMF8OjRqoGpO1y8SG1SF9pXl3VOfBfKkvuxypMgbFiZySMvx6LA0FjXqFvA3s6xTw==
X-Received: by 10.37.10.4 with SMTP id 4mr3033427ybk.160.1466779445825; Fri,
 24 Jun 2016 07:44:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.136.1 with HTTP; Fri, 24 Jun 2016 07:44:05 -0700 (PDT)
In-Reply-To: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
References: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
From:	Jacob Godserv <jacobgodserv@gmail.com>
Date:	Fri, 24 Jun 2016 10:44:05 -0400
Message-ID: <CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com>
Subject: Re: git-svn aborts with "Use of uninitialized value $u" when a
 non-svn-backed branch is present in remote
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Sep 22, 2015 at 2:48 PM, Jacob Godserv <jacobgodserv@gmail.com> wrote:
> I found a specific case in which git-svn improperly aborts:
>
> 1. I created a git-svn repository, named "git-svn repo", by cloned an
> svn repository via the git-svn tool.
> 2. I created a normal git repository, named "configuration repo". I
> renamed the master branch to "configuration". The initial commit adds
> a README and some utility scripts.
> 3. I created a bare repository, named "master repo".
> 4. I pushed from the git-svn repo to the master repo.
> 5. I pushed from the configuration repo to the master repo.
>
> The idea is the configuration branch, which is detached from any
> git-svn history, can contain some useful tools, defaults, etc., that I
> can share with teammates who want to use git on this svn project. It's
> an odd use of git, but it has been working well.
>
> However, a vanilla distribution of Git for Windows 2.5.2 produces the
> following error when running any git-svn command, such as "git svn
> info", on the cloned master repo:
>
> Use of uninitialized value $u in substitution (s///) at
> /mingw64/share/perl5/site_perl/Git/SVN.pm line 105.
> Use of uninitialized value $u in concatenation (.) or string at
> /mingw64/share/perl5/site_perl/Git/SVN.pm line 105.
> refs/remotes/origin/configuration: 'svn+ssh://10.0.1.1/repos/projectA'
> not found in ''
>
> In the mentioned SVN.pm file, after the line:
>
>                         my $u = (::cmt_metadata("$refname"))[0];
>
> I added the following four lines:
>
>                         if (not defined $u) {
>                                 warn "W: $refname does not exist in
> SVN; skipping";
>                                 next;
>                         }
>
> git-svn appears to operate correctly with this patch. This is my first
> time ever editing a perl script, so I apologize if I murdered an
> adorable animal just now.
>
> I'm sending this in so more knowledgeable git-svn developers can
> comment on this and fix this in the official distribution of git,
> assuming there is a bug here to fix.
>
> --
>     Jacob

This e-mail has gone ignored several months. Is the maintainer of
git-svn on this mailing list? Should I submit this issue elsewhere?

-- 
    Jacob
