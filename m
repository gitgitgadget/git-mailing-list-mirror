Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517771F78F
	for <e@80x24.org>; Mon,  1 May 2017 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbdEAQvX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 12:51:23 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35147 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934557AbdEAQtz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 12:49:55 -0400
Received: by mail-pf0-f171.google.com with SMTP id v14so76721862pfd.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NNioQiyFxnkoY/FxLSXpUOeIfH1kdL8L7jYb2jce40=;
        b=NSzrJHeRZNX0RQkXjz+wrOVF4sJKBBlahwEJk87jSK09aknB674FrHvIUA7OKc1HxM
         gLk7P2iOntU8kgl5ew/XmKbYQS+4sidJYJ+vfC2OVzgYQ0OkkujAZVrtRcUS1PTpjYsF
         E2JvWDtLDRkrI2dYwnyFRf7M7ZUMTbLFlulMsd69rtP9bBmA54dKPgRps3y/OYnlai9d
         BkUreKGyz3YvDyWilIv2wdeZP9qavJ2s1BYZ5DLlhoMKJT2Q0Ubn3DRmmh3xiYwcVbrV
         9wHDJYXH/oWjaaJE4BYYlQi8M5VvNz1ax5ckhtJRhuqrfduRFjn7Te6raZSDiPmD1wfl
         broA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NNioQiyFxnkoY/FxLSXpUOeIfH1kdL8L7jYb2jce40=;
        b=bFVzqJHik/TJU9yFHX3jtYWOOLYSAgAnDwakUa31ZY9/S/4X6Zb8Yf/KyP+q91hvzL
         zqKxHReK5vgLKdYvUqOuaE5KLUZyofHrFzrVoKOSoCuMI83AP37ucbrzaYMsRUVdkv1m
         h0ZXLJYnVWoA41h9zkFPMVOG9XXX7MPNt0gVaWs9+JXVdzGM0M47dOPPBgW+tdtjJ3iB
         DbyHMMhAXGxaQ9oFos/lmNvr9OSZ3EkEF0C1CJYNKyQaEku/uikmP3bJRNPHWC3uLL9s
         YzUGGkfCWrY2eYDHf22EJPjFY8/vAj1W/+VFwY3I6qqnTXtas3xYvSvNoQCBUU4c8J+H
         Xscg==
X-Gm-Message-State: AN3rC/5ADdYotLQaT0Et/9sVqKP62Vieuh+kXdqgRj7h+jCK2WKy1gDK
        VetB12dSru5oqAW9TC4ZxQ==
X-Received: by 10.99.97.215 with SMTP id v206mr16313106pgb.235.1493657393227;
        Mon, 01 May 2017 09:49:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id t71sm26762408pfk.29.2017.05.01.09.49.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 09:49:52 -0700 (PDT)
Date:   Mon, 1 May 2017 09:49:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] submodule: refactor logic to determine changed
 submodules
Message-ID: <20170501164951.GD39135@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170428235402.162251-7-bmwill@google.com>
 <CAGZ79kYqiSyxtpux77RSGx56Bzj3YA7Tu180=oFbPb1fMgEMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYqiSyxtpux77RSGx56Bzj3YA7Tu180=oFbPb1fMgEMkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/28, Stefan Beller wrote:
> + Heiko, who touched the pushing code end of last year.
> 
> On Fri, Apr 28, 2017 at 4:54 PM, Brandon Williams <bmwill@google.com> wrote:
> > There are currently two instances (fetch and push) where we want to
> > determine if submodules have changed given some revision specification.
> > These two instances don't use the same logic to generate a list of
> > changed submodules and as a result there is a fair amount of code
> > duplication.
> >
> > This patch refactors these two code paths such that they both use the
> > same logic to generate a list of changed submodules.  This also makes it
> > easier for future callers to be able to reuse this logic as they only
> > need to create an argv_array with the revision specification to be using
> > during the revision walk.
> 
> Thanks for doing some refactoring. :)
> 
> > -static struct oid_array *submodule_commits(struct string_list *submodules,
> > -                                           const char *path)
> > ...
> 
> > -static void free_submodules_oids(struct string_list *submodules)
> > -{
> > ...
> 
> These are just moved north, no change in code.
> If you want to be extra nice to reviewers this could have been an extra patch,
> as it makes reviewing easier if you just have to look at the lines of code with
> one goal ("shuffling code around, no change intended" vs "make a change
> to improve things with no bad side effects")

Yeah I suppose, I was having a difficult time breaking this largest
patch into multiple.

> 
> > +
> > +static void collect_changed_submodules_cb(struct diff_queue_struct *q,
> > +                                         struct diff_options *options,
> > +                                         void *data)
> > +{
> 
> This one combines both collect_submodules_from_diff and
> submodule_collect_changed_cb ?

Yep.

> 
> > @@ -921,61 +948,6 @@ int push_unpushed_submodules(struct oid_array *commits,
> >         return ret;
> >  }
> >
> > -static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
> > -{
> > -       int is_present = 0;
> > -       if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
> > -               /* Even if the submodule is checked out and the commit is
> > -                * present, make sure it is reachable from a ref. */
> > -               struct child_process cp = CHILD_PROCESS_INIT;
> > -               const char *argv[] = {"rev-list", "-n", "1", NULL, "--not", "--all", NULL};
> > -               struct strbuf buf = STRBUF_INIT;
> > -
> > -               argv[3] = sha1_to_hex(sha1);
> > -               cp.argv = argv;
> > -               prepare_submodule_repo_env(&cp.env_array);
> > -               cp.git_cmd = 1;
> > -               cp.no_stdin = 1;
> > -               cp.dir = path;
> > -               if (!capture_command(&cp, &buf, 1024) && !buf.len)
> > -                       is_present = 1;
> 
> Oh, I see where the nit in patch 5/6 is coming from. Another note
> on that: The hint is way off. The hint should be on the order of
> GIT_SHA1_HEXSZ

Yeah agreed.  I make this change in the earlier patch.

> 
> >  int find_unpushed_submodules(struct oid_array *commits,
> >                 const char *remotes_name, struct string_list *needs_pushing)
> > ...
> 
> >  static void calculate_changed_submodule_paths(void)
> > ...
> 
> These are both nicely clean now.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
