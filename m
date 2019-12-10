Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C78C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8820828
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBZNY6nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLJPHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:07:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38799 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 10:07:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so20508425wrh.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4MaQjEcfCwEI2shXVBqNo/7f89nzMVSM859NZTnwuQ=;
        b=hBZNY6nOnqMw1HGvihwmdXTje1v0rJ8IXzB3g1lFu9rHOVz3ZHfCuUgP0rz3mQqdVT
         lm2l4lORlip3yHkSQyTetr6PtQE+cvX3ywYnAxDVS1XWcwWVbA7PwNCMVuddh9nMCIe4
         Gvtd4F9HRibj5Bw6D833fTiv6mp8PxljXJ1/xDe+cAUU85HEcPLa7GGny3ZcnrTes16f
         kReLmrsU87ESqYw7+cPzeBSyDz2nZfv4Y8JcyXY/g+jWCiiJvnODJmxsvAh0JTnhqGM9
         njRE5lbkkvdbBmYUHUqyCgCHknPCDMvxuJ9nUigivWwzdr7KnKKA/JmFdmpX8rRRQJeE
         xyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4MaQjEcfCwEI2shXVBqNo/7f89nzMVSM859NZTnwuQ=;
        b=KJ2wgUMxE69PvlZErkSh5HpZ9VoOPy5cuYKODHiDKSDS31JIgiRen6gdwluraipe5q
         Wv1yBHXmqLSvZ8eDW9UGYku5ptZpgLO73IXfOPnPlKBCBTuiYg1YpE61NBl6c5++7Iw7
         b1hYDpw8fMygc/4/SSp3KWOXI/t+H22ze9P+M5pml6XHH7kqxicKGHmhP7dsk56Neo4S
         ta+UcUs/8lqUpgciLeCoRcGLLmKlFgTytwulpEiAcSPlGmyEZQtWMdeR+aCakQeJGNL6
         IPw+axjIYeCL1+SJ+mSEdtH6mf4aSaYyyOBzpvfUri3U9PJPOgBY+27c6X5V7gXo1soa
         P4Rg==
X-Gm-Message-State: APjAAAVhfXKXPq52yRLf3Cbovf/95c5yahxxdeYlCIRwmnGNkujes6NZ
        N6TeZVCmF7V/QUX3q97OYGQ=
X-Google-Smtp-Source: APXvYqwNjrjnv4qXmhTkF5j/QyFCtBdLwGFl0DPd/ZyZOOInNw0gyMH/0OrjgB/Ncmt9sif/yND8kw==
X-Received: by 2002:adf:c145:: with SMTP id w5mr3817328wre.205.1575990467974;
        Tue, 10 Dec 2019 07:07:47 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id g9sm3650093wro.67.2019.12.10.07.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:07:47 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:07:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
Message-ID: <20191210150745.GH6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
 <20191210100732.GD6527@szeder.dev>
 <b3e8ad07-b2cb-e024-405e-27d9f065f5fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3e8ad07-b2cb-e024-405e-27d9f065f5fc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 08:45:27AM -0500, Derrick Stolee wrote:
> >> Worktrees use a ".git" _file_ instead of a folder to point to
> >> the base repo's .git directory and the proper worktree HEAD. The
> >> fsmonitor hook tries to create a JSON file inside the ".git" folder
> >> which violates the expectation here.
> > 
> > Yeah, there are a couple hardcoded paths in there, e.g.:
> > 
> >   open ($fh, ">", ".git/watchman-response.json");
> > 
> > and, worse, not only in the test helper hook in
> > 't/t7519/fsmonitor-watchman' but in the sample hook template
> > 'templates/hooks--fsmonitor-watchman.sample' as well.
> > 
> >> It would be better to properly
> >> find a safe folder for storing this JSON file.
> > 
> >   git rev-parse --git-path ''
> > 
> > gives us the right directory prefix to use and we could then append
> > the various filenames that must be accessed in there.
> 
> Adding another git process inside the hook is hopefully not
> the only way to achieve something like this. The performance
> hit (mostly on Windows) would be a non-starter for me.

Oh, hang on, it seems that we could simply use $GIT_DIR.

I added

  echo >&2 "GIT_DIR in the fsmonitor hook: '$GIT_DIR'"

to 't/t7519/fsmonitor-all', and then run the test:

  test_expect_success 'test' '
          echo 1 >file &&
          git add file &&
          git commit -m first &&
  
          git worktree add --detach WT &&
          cd WT &&
          echo 2 >file &&
          git add -u
  '

with 'GIT_TEST_FSMONITOR=$(pwd)/t7519/fsmonitor-all', and in the
verbose output got lines like:

  GIT_DIR in the fsmonitor hook: ''
  GIT_DIR in the fsmonitor hook: ''
  GIT_DIR in the fsmonitor hook: '/home/szeder/src/git/t/trash directory.t9999-test/.git/worktrees/WT'
  GIT_DIR in the fsmonitor hook: '/home/szeder/src/git/t/trash directory.t9999-test/.git/worktrees/WT'

I'm not sure why $GIT_DIR is not exported to the hook script while in
the main working tree.  Anyway, as it is now, if $GIT_DIR is
unset/empty, then the hook should write to ".git/<whatever>", and if
it is set, then to "$GIT_DIR/<whatever>", so no git process is needed
in the hook, only a getenv() and a condition.

