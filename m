Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7F9C2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FB320747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nShhHgB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgDGXv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:51:26 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39247 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDGXvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 19:51:22 -0400
Received: by mail-pf1-f171.google.com with SMTP id k15so1545296pfh.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a31L181iIegQzPfqj+BqjmDabCswXiC1eI4GB9nLU9c=;
        b=nShhHgB4rl5XEsEFGi9cisYlYYk9uM89+uL7xZrYmHjKHOrUcVzuSqIGtZc0UBgkrO
         gliKCJQrZmo+5x/EYadmHU+rFAyn+Qc4GZajPpstelGo3Gh1Rew1sKpKx5v+Z+Wl/BfP
         vzukrHpsgE4aBYf3s0QHfqLjp5bbpkrlBvNqplVw4VVTjtSY8x6KZE1G/qA4dQWhu6pE
         wEUQHo3FRjl3+uXJlfG1bQo5WwXCHOY1QfNhfJchhuvE+ToTUhSa9hV77pBf3cGLRsDN
         eUYrZ5LHrlw7IMbbH4IY9jeAiEzuAvSMA27Yqx9CS2GPYnEtq9pTLX5ifEHg3gvXLmOs
         4OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a31L181iIegQzPfqj+BqjmDabCswXiC1eI4GB9nLU9c=;
        b=Tt6QEErkY948tCaxgnenutx4a4MUwpZZeEwQ/dE0HFGcbNrQ/UeehnRwO5yqBD5TuA
         XzHD6eCGA+yuVbiWq8VwKMkBqb1oCpci5HpB8hDFeTpW6tYcJDCZn/xH/i6VqfW+HIUi
         38B6Fspzrb1LIw9OB3YuLAt9hEZ8dHYtvlF1twsBcsfeobCE4skdjqYbSL7PVEQrz1Al
         j0X7UkdPbUxk/qOEpvGjlA4VeLPkszEc8S2iCwvwoME8WA1Y2d7WFp+mprpXauUu179/
         BMczPAjxcbrurF3wP6fiwcFcPqKOGcd5A2oe1nzHmY5k4g5MN/Cxd7oFpqLQc/Ho0es5
         PtMA==
X-Gm-Message-State: AGi0PuYPV+FnSoSn3SxHK4TGtd5E0C0ILVi7RXAbAy7vvT5XGEd1JRd0
        UtFPGyEwhrrZJoY5LgdkCxNk9Q==
X-Google-Smtp-Source: APiQypL9s8rRopvCR6f2BAfQzFHPi6UKHUbkC/S15Q57++oPRVOwkBLGZ5HRc4gpZ6qMInAzNO31+Q==
X-Received: by 2002:aa7:963d:: with SMTP id r29mr4674990pfg.87.1586303481599;
        Tue, 07 Apr 2020 16:51:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q11sm1047333pfs.94.2020.04.07.16.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:51:20 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:51:16 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200407235116.GE137962@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407230132.GD137962@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 04:01:32PM -0700, Emily Shaffer wrote:
> Thoughts?

Jonathan Nieder and I discussed this a little bit offline, and he
suggested another thought:

[hook "unique-name"]
  pre-commit = ~/path-to-hook.sh args-for-precommit
  pre-push = ~/path-to-hook.sh
  order = 001

Then, in another config:

hook.unique-name.pre-push-order = 123

or,

hook.unique-name.enable = false
hook.unique-name.pre-commit-enable = true

To pick it apart a little more:

 - Let's give each logical action a unique name, e.g. "git-secrets".
 - Users can sign up for a certain event by providing the command to
   run, e.g. `hook.git-secrets.pre-commit = git-secrets pre-commit`.
 - Users can set up defaults for the logical action, e.g.
   `hook.git-secrets.before = gerrit` (where "gerrit" is the unique name
   for another logical action), and then change it on a per-hook basis
   e.g. `hook.git-secrets.pre-commit-before = clang-tidy`

There's some benefit:
 - We don't have to kludge something new (multiple sections with the
   same name, but logically disparate) into the config semantics where
   it doesn't really fit.
 - Users could, for example, turn off all "git-secrets" invocations in a
   repo without knowing which hooks it's attached to, e.g.
   `hook.git-secrets.enable = false`
 - We still have the option to add and remove parameters like 'order' or
   'before'/'after' or 'parallelizable' or etc., on a per-hook basis or
   for all flavors of a logical action such as "git-secrets"
 - It may be easier for a config-authoring iteration of 'git-hook' to
   modify existing configs than it would be if the ordering of config
   entries is vital.

One drawback I can think of is that these unique names could be either
difficult to autogenerate and guarantee uniqueness, or difficult for
humans to parse. I'd have to rethink the UI for writing or editing with
git-hook (rather than editing the config by hand), although I think with
the mood shifting away from configs looking like
"hook.pre-commit=123:~/path-to-thing.sh" my UI mockups are all invalid
anyways :)

We also considered something like:

[hook "git-secrets-pre-commit"]
  command = ~/path-to-hooks.sh args-for-precommit
  order = 001

[hook "git-secrets-pre-push"]
  comand = ~/path-to-hook.sh
  order = 123

but concluded that it's more verbose without adding additional value
over the earlier proposal above. This syntax can achieve a subset of
goals but is missing extra value like an easy path to disable all hooks
in that logical action, or nice defaults when you don't expect the order
or parallelism to change.

Definitely interested in hearing more ideas :)

 - Emily
