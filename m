Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD4C3DA78
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 02:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAPCID (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 21:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjAPCIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 21:08:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AF5262
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 18:07:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so18701748pga.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 18:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52zEtKsCUnhO+8DhSDsjLVzKY+3gPUoAltWHRy8fBnY=;
        b=AXryFVQqqsrONB+V/mWc/geVf/th1EBHaNuRg4y/B2a63eigWzvS1QDuj5LPSThUL2
         D7miENqJ//JmKSmi5fhTkNBVDR7jRr7HSSmj9Mk1VkWXxPi5wBPTif6+1ccoQPffd+KG
         OvXuYnY008tQT7awamqPuY/p4Dbmj4nIKsq7AD8Lh7OS5zB/gAQSrry7RVVXT6rzs/kq
         OoO7ZegcHGlMJhPBzjzl3RVis4KqHHi9w5if8TL3YkjQC5rXSIvR75c1qVQFb078iEzR
         NePpw5xuB33L4VymHuCYQz4tp1d0x5Kogu7lKagcj52AsRQ/gsvLvTJbhdnuaw5zA9x6
         JetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52zEtKsCUnhO+8DhSDsjLVzKY+3gPUoAltWHRy8fBnY=;
        b=VnKXY2Gv0+MJea91nx14Y4I5KO70jb1HFySoFUAUbwshBKNcRYeSrH23a5R+aFp/fV
         ttztp8yP+L47M/e4zj1gXaQ1hxa82DVDMAMDHrdeqDjXs5t4oDpibu9e1JkgurCHxMpv
         t5gxXmCyDVIw3xWp6VFyfS73F+ngUfHP5PNfl/21yoXyYs7WpIJ9+/Qm+nfJYhueXMCf
         SO9niOQSCdOfwTGvA7oo6bZxo3AshgpZ5r9XtPHlNjId+wd9kBKNGzYi5D4Q1QlwYo4T
         s/GgIu8/uF+MAdhyuQ+zwhBEkXNfFRvk/2uXOJSGyLKcAP2J+GUgg+7lGovh/ROzhXQ8
         JHGA==
X-Gm-Message-State: AFqh2koF1o/j9Ot5s7qey1JhBdlit8B8mTifJ8lsNTLX9rKCHQH+Zzwt
        /iJhd4qDVHGbo8IwNxO3khg=
X-Google-Smtp-Source: AMrXdXv/re3Y0cNdasG7XNDKnD1DYl0odaGGoUCEk9gVJPLpCyjfDQTL6yrYjOQVDSyt5s+BMLnOgA==
X-Received: by 2002:aa7:9796:0:b0:58a:66a8:edf5 with SMTP id o22-20020aa79796000000b0058a66a8edf5mr23417231pfp.3.1673834878295;
        Sun, 15 Jan 2023 18:07:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g73-20020a62524c000000b0058b540b7ffesm8769443pfb.29.2023.01.15.18.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 18:07:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Crls <kaploceh@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
Subject: Re: ctrl-z ignored by git; creates blobs from non-existent repos
References: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
        <Y8Qfj32h89hq5UD6@mit.edu> <Y8SCZvMu7DZZH1Pl@localhost.my.domain>
Date:   Sun, 15 Jan 2023 18:07:57 -0800
In-Reply-To: <Y8SCZvMu7DZZH1Pl@localhost.my.domain> (Crls's message of "Sun,
        15 Jan 2023 17:47:02 -0500")
Message-ID: <xmqqmt6jdyf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Crls <kaploceh@gmail.com> writes:

> ... Coincidentally speaking, why does a username warrants a prompt
> from git, is simply beyond me. I mean, that is certainly the more
> far-fetched reasoning of implementation I've read in a long long
> time.
>
> Can you git-clone a user? What about the user's settings? What
> about the remainder its gpg tokens and so forth? In other words,
> if a user's repo is not found, why even prompting for a username?
> The latter, that is, the user's repo, is redundant, when the
> prompt is clearly asking for a username, and not a repo.

When you "git clone", you'd give a repository path to the server.
If the repository is not open to the general anonymous public, then
the server needs to check who you are (by asking username) and
verify that you are who you claim to be (by asking password).

Here two things you need to pay attention to.

 - A user can be the
   owner of more than one repositories, and

 - a repository can be accessed by users other than its owner.

So even after the repository is known by the server, the server
still needs to ask you who you are.

Imagine that there are many projects hosted at the same site, the
repository path is named after the codename of the project, and the
project codename is need-to-know secret.

If the server side reacted differently between an attempt to clone
existing repositories and missing ones, an attacker can try

	git clone https://site.example.com/projects/$X    

with many X's and observe the behaviour of the server.  If the
server is known to respond with "no such repository" for a missing
one, while responding with "please identify you" for an existing
one, you can easily tell if a word $X is a project codename, that is
supposed to be secret.

> Preventing the disclosure of information has nothing to do with
> the issue here. If anything seems clear to me, is that prompting
> for a username, does indeed disclose usernames, private, public
> and whatnot from either github or gitlab.

When you need to identify yourself to GitHub or GitLab, you'd give
your username and password.  You know that GitHub or GitLab have the
username so it is not secret to them.  Otherwise they wouldn't be
able to even recognise you.

So I am not sure how it "seems clear" that asking for the username
is a problem.  The observed behaviour to ask for the username even
for a missing repository is all about avoiding to disclose one bit
of information: whether a repository exists at the given URL.
