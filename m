Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C18C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 02:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46295206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 02:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKMO8Nrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgC1Cem (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:34:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46415 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1Cem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 22:34:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id s23so4176119plq.13
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BkoW36SWuWfdjLbNUtmyJ2Ebo/4xVR2VGbyg/01347s=;
        b=DKMO8NrftQlLKHchldNFdxd9B73oD5wPA0ZZGOJb1kNDRN5tiyAgz5vgCnJeclH6YL
         F4dcHMmm01vOf9iuiKbW1AEPjzeslhsJoOfJMjJcBQCsbj+a+9Scl7xsPOrVP5RNOu+H
         eAvbdWMnmL3sUyb9wmxURh/cLQCGL/PC76SEqXJMy/Y0OMRPdh7bwft8zYfToteHq9l6
         3Hf+3MvMKlseq+aCL1SCQbyOriOzkudwxmLFyBUx7PNgjUmABy/ENa0uiP5N6U2+ImuN
         YjlFqsrMcyEpw6E5ouHtf984J9ssfhcEUhoW8x0ElJRpALMHmN4EUcpYuS8vI6wBMKpS
         k4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BkoW36SWuWfdjLbNUtmyJ2Ebo/4xVR2VGbyg/01347s=;
        b=Gt6q6QIiKOjzC33iyictirc3FJchL8ZFOR0Y8DcHyuZTVxqYlI+az9EmknsuuuLdwy
         yXHA2PBuimIwBnqZG6LmRM6+nw5NqK5DNat+8V8HH/4lE2D3NkNgllSczZoU1W/C6y8M
         gthVKs2khuFyeM8Dl7pPcnTCIQSJgvHlh2sWbGw7kfEUk2M3kD1wAXs8a3w8O/TyHcM5
         ry4GKQLaPFyuNyHeCtlfJaX3Eocnlh5XqfOVqfExlmtX3JX2OE1/zfgQBLFVjMrmx3We
         E5dDqCBYT+R6FL85J/L0v9FnIUWFrfQLR0TEKOigf1B+ATjmUwYuvKq8UZR+E11gLyua
         dnzQ==
X-Gm-Message-State: ANhLgQ0uE3FLUh58pk1CfUfwBRSPQKcKErINXuitAFDDBrmPoeoVRb+8
        0UNKbocv88pNQonuwMMmKjg0o+pZ
X-Google-Smtp-Source: ADFU+vv6SAguSCqTDFifk8bboAjDWYeDwYW9NMYkU38H5xj2oRQjRi6d1xIPcxC4gCZWAoj6trFMQg==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr2022962ple.102.1585362881065;
        Fri, 27 Mar 2020 19:34:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id my15sm4875574pjb.28.2020.03.27.19.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 19:34:40 -0700 (PDT)
Date:   Fri, 27 Mar 2020 19:34:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org, Paul Gevers <elbrus@debian.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: git-rebase ignores or squashes GIT_REFLOG_ACTION
Message-ID: <20200328023438.GA202996@google.com>
References: <6776c32d-35f5-3134-35c7-1c9b803d8c37@debian.org>
 <24190.33234.108820.211871@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24190.33234.108820.211871@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ian Jackson wrote[1]:

> [ some git-debrebase invocation etc. ]
> + git reflog
> + egrep 'debrebase new-upstream.*checkout'
> + rc=1
>
> I have looked at the log and repro'd the bug.
>
> git-debrebase (which lives in src:dgit but does not depend on dgit)
> must invoke git-rebase.  It sets GIT_REFLOG_ACTION so that the reflog
> is comprehensible to the user.  In previous versions of git this works
> as expected.  In 2.26.0-1 it does not.
>
> This is easy to reproduce by running
>   GIT_REFLOG_ACTION='zeeks!' git rebase --onto <something> <somethingelse>
> with arguments implying a nontrivial rebase.
>
> The test suite in src:dgit, which is the checks that its
> GIT_REFLOG_ACTION manipulation is effective, and it is this test which
> has now failed and which is blocking the migration of git.
>
> git-rebrebase in sid produces quite different looking reflog entries.
> I guess the code for generating the messages has changed and that
> git-rebase is now *setting* GIT_REFLOG_ACTION (or the equivalent
> internal variable) rather than adding to it.
>
> ISTM that to preserve the documented semantics, it is basically always
> wrong of anything to unconditionally set GIT_REFLOG_ACTION.  In
> src:dgit I have a small bit of code to arrange to always *add* to
> GIT_REFLOG_ACTION, if it is already set.  There might be several
> precise ways to add to GIT_REFLOG_ACTION but the failing test case
> here should be happy with any reasonable choice.

Thanks for reporting.

The main relevant change is that "git rebase" switched its default
backend from "apply" to "merge".  This makes it more robust by using
three-way merges in a similar way to "git cherry-pick".  The "merge"
backend was historically already used for interactive rebases.

I believe some reflog behavior changes were noticed in

 commit 980b482d28482c307648c3abbcb16ae60843c7ae
 Author: Elijah Newren <newren@gmail.com>
 Date:   Sat Feb 15 21:36:37 2020 +0000

     rebase tests: mark tests specific to the am-backend with --am

but we didn't investigate at the time (shame on me).  Anyway, we have
a chance to improve things now.

My first thought is to look at when rebase prepares its msg, in
builtin/rebase.c#set_reflog_action:

	if (!is_merge(options))
		return;

	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
	if (env && strcmp("rebase", env))
		return; /* only override it if it is "rebase" */

	strbuf_addf(&buf, "rebase (%s)", options->action);
	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
	strbuf_release(&buf);

In the --am case, is_merge is false and this code isn't run.  But in
our case, GIT_REFLOG_ACTION is not rebase, so this code still
shouldn't be run.

My next thought is to look at when this function was changed:

 commit c2417d3af7574adc1fb14f7df31b862aa9551e2e
 Author: Elijah Newren <newren@gmail.com>
 Date:   Sat Feb 15 21:36:36 2020 +0000

     rebase: drop '-i' from the reflog for interactive-based rebases

If I am reading

 commit 13a5a9f0fdcf36270dcc2dcb7752c281bbea06f1
 Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
 Date:   Thu Nov 29 11:09:21 2018 -0800

     rebase: fix GIT_REFLOG_ACTION regression

correctly, then dgit requires that to be '-i' for interactive rebases.
Are we sure that that's not the issue here?

Thanks,
Jonathan

[1] https://bugs.debian.org/955152
