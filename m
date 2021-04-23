Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12069C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 05:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB8E613E6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 05:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhDWFNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 01:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWFNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 01:13:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F2C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 22:12:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c4so8110815wrt.8
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ja38OZSvj8zFCbJUH/wEUb+IwKd4tQwgc2u5Nii2trk=;
        b=Jxr8fMBYJeqbAZ2Fe0aikZoJYWMthkV73mgvl/335M8kIwlmOHXf5/IFTD0DRwfbI9
         Wsb6uQsGGO++BQ8zsuMTn9FAySNvqabYBhKzyyPxZyu7CObzsRzIrm3MiZI3WsKa03bR
         90rNvuroNE6pp6T5s/qg7jmWwbDQaduia15dW/3uq4NOqabAPNW72w2L3WHdsGpNoMk9
         ok/ufEdL2Efc5jBbPKP48+KYF3zhaJFty4g8fPreGumySfsifikPqHAXo67FqEpqic+b
         WY9pr0bWCx3Du4vR7C7aC4wHVUiAZyMja+pQkXu0GxP5aFTHtlxW2J8HuRo/OjOnrUme
         39Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ja38OZSvj8zFCbJUH/wEUb+IwKd4tQwgc2u5Nii2trk=;
        b=ROPG3cgPMkPiOTrW00GY3KU+dWIOeNqqe4EEjNXwrfR1sHXlvNCmZfr/HpciCi2zTr
         AcLj/NTAznUQ6ruS1tIWoU0BUNJF4LQEGdDa21aTN5V69C2BONNnUvqDTln/aKGyMB94
         NcN3IpyeAR6GMLzlyW469SzEdWF6S1ikzCNNsuMrDl/CNhYwPNpGPw3Ke45OYFvkSu1t
         Li+nowChnFsY0oOg7b3Pl5H2AaR5XwlfUK02xo4Pc9siE635crgeiAvf6A58bIZkIuUS
         ERh8KbllvE85CljZm+ZxeP2PpWr+96/gBv6AnxgCYW0O+vW7KpQOeBbjy1dBKUOmwMyK
         aetQ==
X-Gm-Message-State: AOAM533wZ6K5lC0XZgMaLTZ/tkY98ulTfIMHdY5045/1/hA8NFRlRZxZ
        q1p5t5y8cs3SStg/nuExxHA=
X-Google-Smtp-Source: ABdhPJyVV/QX/GKhjCV/10yEuDo93cK1fa70XG+Unl8NfYSuBH0kUpouvg2l+hT9QWVDRVdUdu8vRA==
X-Received: by 2002:a5d:4405:: with SMTP id z5mr2178596wrq.313.1619154777887;
        Thu, 22 Apr 2021 22:12:57 -0700 (PDT)
Received: from szeder.dev (94-21-58-226.pool.digikabel.hu. [94.21.58.226])
        by smtp.gmail.com with ESMTPSA id v7sm7355903wrs.2.2021.04.22.22.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 22:12:57 -0700 (PDT)
Date:   Fri, 23 Apr 2021 07:12:55 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
Message-ID: <20210423051255.GD2947267@szeder.dev>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com>
 <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
 <20210422045953.GC2947267@szeder.dev>
 <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 03:01:01PM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 22, 2021 at 6:59 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > > See the comment above the changed line: we don't want auto-detection
> > > to clobber the surrounding git repo.
> >
> > Indeed, but then this is not a faithful conversion of the original.
> > That 'echo' will write sane content to HEAD no matter what state the
> > repository is in.  That 'symbolic-ref' command, however, won't,
> > because 'git --git-dir .git' turns off only repository discovery, but
> > not repository verification, and in case of a corrupt '.git/HEAD' it
> > will bail out.
> >
> >   $ cd test
> >   $ git init
> >   Initialized empty Git repository in /home/szeder/src/git/test/.git/
> >   $ git commit --allow-empty -m initial
> >   [master (root-commit) ec0df0b] initial
> >   $ echo "foo bar baz" >.git/HEAD
> >   $ git --git-dir .git symbolic-ref HEAD refs/heads/master
> >   fatal: not a git repository: '.git'
> 
> But then it's working as intended, no? It will not corrupt the
> surrounding repository.

No, it definitely does not.

If one of the test cases fails because 'git symbolic-ref' were to
write bogus content to HEAD, then that new 'git symbolic-ref'
invocation in reset_to_sane() will not corrupt the surrounding
repository, but, crucially, it won't restore the test repository's
HEAD to a sane state either, and git commands invoked in subsequent
tests won't recognize the trash dir as their git repository, and will
operate on the surrounding repo instead:

  ~/src/git/t (master)$ vim t/t1401-symbolic-ref.sh
  ~/src/git/t (master *)$ git diff
  diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
  index a4ebb0b65f..8f8d93bf6a 100755
  --- a/t/t1401-symbolic-ref.sh
  +++ b/t/t1401-symbolic-ref.sh
  @@ -23,7 +23,11 @@ test_expect_success 'symbolic-ref reads HEAD' '
   '
   
   test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
  -       test_must_fail git symbolic-ref HEAD foo
  +       #test_must_fail git symbolic-ref HEAD foo &&
  +       # Lets pretend that the above "git symbolic-ref" did write that
  +       # bogus content to HEAD:
  +       echo foo >.git/HEAD &&
  +       false
   '
   reset_to_sane
   
  ~/src/git/t (master *)$ ./t1401-symbolic-ref.sh 
  ok 1 - symbolic-ref writes HEAD
  ok 2 - symbolic-ref reads HEAD
  not ok 3 - symbolic-ref refuses non-ref for HEAD
  #	
  #		#test_must_fail git symbolic-ref HEAD foo &&
  #		# Lets pretend that the above "git symbolic-ref" did write that
  #		# bogus content to HEAD:
  #		echo foo >.git/HEAD &&
  #		false
  #	
  ok 4 - symbolic-ref refuses bare sha1
  ok 5 - HEAD cannot be removed
  ok 6 - symbolic-ref can be deleted
  ok 7 - symbolic-ref can delete dangling symref
  ok 8 - symbolic-ref fails to delete missing FOO
  ok 9 - symbolic-ref fails to delete real ref
  ok 10 - create large ref name
  ok 11 - symbolic-ref can point to large ref name
  ok 12 - we can parse long symbolic ref
  ok 13 - symbolic-ref reports failure in exit code
  ok 14 - symbolic-ref writes reflog entry
  ok 15 - symbolic-ref does not create ref d/f conflicts
  ok 16 - symbolic-ref can overwrite pointer to invalid name
  ok 17 - symbolic-ref can resolve d/f name (EISDIR)
  ok 18 - symbolic-ref can resolve d/f name (ENOTDIR)
  # failed 1 among 18 test(s)
  1..18
  ~/src/git/t (master *)$

OK, only one test failed, and the surrounding repo is not affected.

No lets switch to your 'git symbolic-ref command in reset_to_sane():

  ~/src/git/t (master *)$ vim t/t1401-symbolic-ref.sh
  ~/src/git/t (master *)$ git diff
  diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
  index a4ebb0b65f..6ef221d1bb 100755
  --- a/t/t1401-symbolic-ref.sh
  +++ b/t/t1401-symbolic-ref.sh
  @@ -7,7 +7,8 @@ test_description='basic symbolic-ref tests'
   # the git repo, meaning that further tests will operate on
   # the surrounding git repo instead of the trash directory.
   reset_to_sane() {
  -       echo ref: refs/heads/foo >.git/HEAD
  +       #echo ref: refs/heads/foo >.git/HEAD
  +       git --git-dir .git symbolic-ref HEAD refs/heads/foo
   }
   
   test_expect_success 'symbolic-ref writes HEAD' '
  @@ -23,7 +24,11 @@ test_expect_success 'symbolic-ref reads HEAD' '
   '
   
   test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
  -       test_must_fail git symbolic-ref HEAD foo
  +       #test_must_fail git symbolic-ref HEAD foo &&
  +       # Lets pretend that the above "git symbolic-ref" did write that
  +       # bogus content to HEAD:
  +       echo foo >.git/HEAD &&
  +       false
   '
   reset_to_sane
 
  ~/src/git/t (master *)$ ./t1401-symbolic-ref.sh 
  ok 1 - symbolic-ref writes HEAD
  ok 2 - symbolic-ref reads HEAD
  not ok 3 - symbolic-ref refuses non-ref for HEAD
  #	
  #		#test_must_fail git symbolic-ref HEAD foo &&
  #		# Lets pretend that the above "git symbolic-ref" did write that
  #		# bogus content to HEAD:
  #		echo foo >.git/HEAD &&
  #		false
  #	
  fatal: not a git repository: '.git'
  not ok 4 - symbolic-ref refuses bare sha1
  #	
  #		echo content >file && git add file && git commit -m one &&
  #		test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
  #	
  fatal: not a git repository: '.git'
  ok 5 - HEAD cannot be removed
  fatal: not a git repository: '.git'
  not ok 6 - symbolic-ref can be deleted
  #	
  #		git symbolic-ref NOTHEAD refs/heads/foo &&
  #		git symbolic-ref -d NOTHEAD &&
  #		test_path_is_file .git/refs/heads/foo &&
  #		test_path_is_missing .git/NOTHEAD
  #	
  fatal: not a git repository: '.git'
  ok 7 - symbolic-ref can delete dangling symref
  fatal: not a git repository: '.git'
  ok 8 - symbolic-ref fails to delete missing FOO
  fatal: not a git repository: '.git'
  not ok 9 - symbolic-ref fails to delete real ref
  #	
  #		echo "fatal: Cannot delete refs/heads/foo, not a symbolic ref" >expect &&
  #		test_must_fail git symbolic-ref -d refs/heads/foo >actual 2>&1 &&
  #		git rev-parse --verify refs/heads/foo &&
  #		test_cmp expect actual
  #	
  fatal: not a git repository: '.git'
  ok 10 - create large ref name
  ok 11 - symbolic-ref can point to large ref name
  ok 12 - we can parse long symbolic ref
  not ok 13 - symbolic-ref reports failure in exit code
  #	
  #		test_when_finished "rm -f .git/HEAD.lock" &&
  #		>.git/HEAD.lock &&
  #		test_must_fail git symbolic-ref HEAD refs/heads/whatever
  #	
  not ok 14 - symbolic-ref writes reflog entry
  #	
  #		git checkout -b log1 &&
  #		test_commit one &&
  #		git checkout -b log2  &&
  #		test_commit two &&
  #		git checkout --orphan orphan &&
  #		git symbolic-ref -m create HEAD refs/heads/log1 &&
  #		git symbolic-ref -m update HEAD refs/heads/log2 &&
  #		cat >expect <<-\EOF &&
  #		update
  #		create
  #		EOF
  #		git log --format=%gs -g -2 >actual &&
  #		test_cmp expect actual
  #	
  not ok 15 - symbolic-ref does not create ref d/f conflicts
  #	
  #		git checkout -b df &&
  #		test_commit df &&
  #		test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df &&
  #		git pack-refs --all --prune &&
  #		test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df
  #	
  not ok 16 - symbolic-ref can overwrite pointer to invalid name
  #	
  #		test_when_finished reset_to_sane &&
  #		head=$(git rev-parse HEAD) &&
  #		git symbolic-ref HEAD refs/heads/outer &&
  #		test_when_finished "git update-ref -d refs/heads/outer/inner" &&
  #		git update-ref refs/heads/outer/inner $head &&
  #		git symbolic-ref HEAD refs/heads/unrelated
  #	
  not ok 17 - symbolic-ref can resolve d/f name (EISDIR)
  #	
  #		test_when_finished reset_to_sane &&
  #		head=$(git rev-parse HEAD) &&
  #		git symbolic-ref HEAD refs/heads/outer/inner &&
  #		test_when_finished "git update-ref -d refs/heads/outer" &&
  #		git update-ref refs/heads/outer $head &&
  #		echo refs/heads/outer/inner >expect &&
  #		git symbolic-ref HEAD >actual &&
  #		test_cmp expect actual
  #	
  not ok 18 - symbolic-ref can resolve d/f name (ENOTDIR)
  #	
  #		test_when_finished reset_to_sane &&
  #		head=$(git rev-parse HEAD) &&
  #		git symbolic-ref HEAD refs/heads/outer &&
  #		test_when_finished "git update-ref -d refs/heads/outer/inner" &&
  #		git update-ref refs/heads/outer/inner $head &&
  #		echo refs/heads/outer >expect &&
  #		git symbolic-ref HEAD >actual &&
  #		test_cmp expect actual
  #	
  # failed 10 among 18 test(s)
  1..18

Uh-oh, a lot more tests failes, and, much worse!, my git repo is now
on a different and orphaned branch:

  ~/src/git/t (df *+)$ git status 
  On branch df
  
  No commits yet
  
  Changes to be committed:
  [...]

> I see it as the test writer's job to clean up to the extent that
> git-symbolic-ref can reset to a sane state.

No, it's the job of whoever updates the cleanup routine to make sure
that the updated cleanup routine still works just as well as it did in
the past.

> We could reset back to a known state in a more drastic manner
> (extracting .git from a tar archive), but that could interfere with
> the test functions if they're not isolated from each other.



