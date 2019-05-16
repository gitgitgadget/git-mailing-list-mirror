Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A041D1F461
	for <e@80x24.org>; Thu, 16 May 2019 11:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPLjR (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:39:17 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:33749 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPLjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:39:17 -0400
Received: by mail-wm1-f42.google.com with SMTP id c66so6841368wme.0
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MR4n38AFDL8Mr4oNna2bJ3E1s1m/FfOgP9Wi+i8zCmc=;
        b=laA2XFBCyz0VBItkINswySPGu9znRW6oJt7UTCbjQBe75OLZDddxA+ovTk07Ol3VRv
         wU2KPOdgz3nv5JG9Z9NIqdEeCxcgmsuT1o+h0ETYhHdMbCDP4MPynuzlw0lgEipK3UgF
         A6pLDo/53UmNUG4DbX2SQbfo6HveTlf++vBcM0o5+ixzMtAQyOpCTjpZuIAUpdY9aoo/
         8qreNJGONGJvM0/WLIbsKCud/5JYpG5hiJALKVs22OClOPjfv8vlC+jwdIKp/3GDCW4G
         3t4z7zzjhJrOYhvRLb+d2Bqo5AwIAuc253v46Gul6jTMnNrCzMaWiMCOZfYxEHXOLtSI
         1Ipg==
X-Gm-Message-State: APjAAAVhnajbS30cmn/5Sj+n+sHRi8unIRJBDyaWbEDvDgVrUFVG/1fr
        /0b7KQLpLiXuGoTg4RiiqjPsDFOZzq4R+igPjIE=
X-Google-Smtp-Source: APXvYqwMNIJqR4Wnf5qLWt8xWV1MmJt8U9hmNxuWcWW/z037L7UF9rRw7mUlettwmMDgnEccx9DM3KP364RwZ8ZA2/g=
X-Received: by 2002:a1c:7614:: with SMTP id r20mr5647572wmc.31.1558006755356;
 Thu, 16 May 2019 04:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com> <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
In-Reply-To: <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 07:39:04 -0400
Message-ID: <CAPig+cS1iypB9oZ+O=KsJ7CHyWUEOKzr8djRthrXMdC+uNHVKA@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:33 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I researched this also and concluded that it's a bug in git-commit.
> You run afoul of it in other situations, as well. For instance, say
> you have your index file in a non-standard location:
>
>     $ export GIT_INDEX_FILE=../storage/index
>     $ git worktree add --detach other
>     Preparing worktree (detached HEAD c9156d2)
>     fatal: Unable to create '/.../foo/other/../storage/index.lock': No
> such file or directory
>     $
>
> I think the correct fix is for git-commit to assign GIT_INDEX_FILE
> with the absolute path to the index file, not a relative path.

Thinking more clearly on it, a better fix might be for git-worktree to
deal with this itself, converting such a path to absolute before
cd'ing to the new worktree directory (or something -- I don't have the
code in front of me to provide a more concrete suggestion).
