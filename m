Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D86C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5C66112D
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbhKIVtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbhKIVtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 16:49:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE1C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 13:46:36 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r28so382053pga.0
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 13:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=np/u08LmBlh78YkC3fxOpnQOwcMRt6vE6aV/J4o+9eU=;
        b=nj3asU2Mfnlui7wkYA9PlgimVeiM4Wz7jtadwzqrn9Qllpr7Vq7ajRVJS6YMgm114f
         KLwN8HA83oFNmbQTzu2hbp7JJ/DuF1L/yxtJvsXYwJfyEjxSCcF5PQRwwFHrBMe+xyzN
         dP+QB58/yt7HMmn4xN4Y5Mal2nqDsMC+aIcfAaiFaHpDl+HpiHUo0jigsTShfIarzq6Q
         hu37QgcmcEUYnvjJIQCG6P+WnoLYb5VZwqAe64J2kAyu/OYLYpuYtEE+6k9SYRwGXF7+
         zkNO18LZDoPyraLTFbq8zMZolIjwfZrYh1yDt+uVllo/AVOP/Ts70aZ5DzRBE4HIi/xk
         fDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=np/u08LmBlh78YkC3fxOpnQOwcMRt6vE6aV/J4o+9eU=;
        b=ACvnoModj1oIy1taOTykTm1jpW/JHfAcyuzT1mQZunFAE3lqs8Muak0IJ7tByHBc6R
         tf6nIKvVijkNUMq2wftyazw9MKBtEs4BfrmEYqzMzhZE04s5ryi6z4f7SWRaKJ03iiqG
         ytLy+SmOTaBxSQyMLPn4lZoXLiGCnM/wn3S8AYSTYBaimER956dIquD52mMCfNRIsF0B
         E/cshXjDGb73TGceVMxoXD5pBzNRm1slPxQt1iM+QNtANulKghDcQmI22wbZMTFkRqSu
         HqigINjNSqAB682Rd2g2DOlgYYubRp+Kbh/A5+y+KPrc+dvNtsS6XR+qKxq3qyzqP+2/
         ty3A==
X-Gm-Message-State: AOAM5302Z6SeIcv/bBTm1XK9VvPL4Cd2XqoOgW5MgUfElks0SXlCa87k
        cwV7NVYvv6Q1ktwjmrkKQpxpVQ==
X-Google-Smtp-Source: ABdhPJxkqnLjaRXtyCCGox/w7YHI2T0o84qLVdzwbPx95rAyiKJhefd3FOTMeW9+N/OVmiEgYeQcMA==
X-Received: by 2002:a63:1d03:: with SMTP id d3mr4627188pgd.149.1636494395533;
        Tue, 09 Nov 2021 13:46:35 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c26f:39be:d0b5:a747])
        by smtp.gmail.com with ESMTPSA id b7sm21207223pfm.28.2021.11.09.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 13:46:34 -0800 (PST)
Date:   Tue, 9 Nov 2021 13:46:29 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Message-ID: <YYrsNagtHssb7jBF@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <xmqqzgqjxl4e.fsf@gitster.g>
 <211105.861r3vhtot.gmgdl@evledraar.gmail.com>
 <YYmw8vEyFnQpe58z@google.com>
 <211109.86v912dtfw.gmgdl@evledraar.gmail.com>
 <YYrb4oCaIXIwN/bF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYrb4oCaIXIwN/bF@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 12:36:50PM -0800, Emily Shaffer wrote:
> 
> On Tue, Nov 09, 2021 at 01:42:03AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > 
> > On Mon, Nov 08 2021, Emily Shaffer wrote:
> > 
> > > On Fri, Nov 05, 2021 at 09:43:56AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > >> 
> > >> 
> > >> On Thu, Nov 04 2021, Junio C Hamano wrote:
> > >> 
> > >> > Emily Shaffer <emilyshaffer@google.com> writes:
> > >> >
> > >> >> A recorded hint path to the superproject's gitdir might be added during
> > >> >> 'git submodule add', but in some cases - like submodules which were
> > >> >> created before 'git submodule add' learned to record that info - it might
> > >> >> be useful to update the hint. Let's do it during 'git submodule
> > >> >> update', when we already have a handle to the superproject while calling
> > >> >> operations on the submodules.
> > >> >
> > >> > We are hearing repeated mention of "cache" and "hint".  Do we ever
> > >> > invalidate it, or if we have such a record, do we blindly trust it
> > >> > and use it without verifying if it is still fresh?
> > >> >
> > >> > Also, this step and the previous step both say we record gitdir on
> > >> > their title, but we instead record common dir.  Whichever is the
> > >> > right choice to record, let's be consistent.
> > >> 
> > >> I had similar (AFAICT still unaddressed) feedback on the v2[1]. I'd lost
> > >> track of this series, and see one reason is that the In-Reply-Chain was
> > >> broken between v3..v4.
> > >> 
> > >> I.e. it seems to me that this whole thing started as a way to avoid
> > >> shellscript overhead by calling git-rev-parse from git-submodule.sh, but
> > >> now that the relevant bits are moved to C we could just call some
> > >> slightly adjusted code in setup.c.
> > >
> > > No, that is not the case. It is the case that `git -C .. rev-parse
> > > --git-dir` is *very* expensive in the case where `../` is not, in fact,
> > > a gitdir; when I attempted another series which relied on finding the
> > > parent superproject's gitdir in this way, our testsuite took something
> > > like 5x longer to run than before. In other words, the expensive part is
> > > not the shelling out overhead - the expensive part is searching up the
> > > entire filesystem directory structure in the worst-case ("we are not a
> > > submodule") scenario. This is still needed, even with 'git-submodule.sh'
> > > moving to C.
> > 
> > Do you have that test code somewhere?
> 
> I messed around with it a little more, rebasing the no-caches-involved
> older implementation and using an in-process lookup with
> setup_git_directory_gently_1.
> https://github.com/nasamuffin/git/tree/config-inheritance-no-cache
> 
> The recent experiments are in the tip commit, and the original series is
> in the two commits prior if you're interested.
> 
> The upshot, though, is that I think there is still not a way around a
> second subprocess. Before, we determined the superproject's gitdir like
> so:
> 
>   # Does a git project at .. think I belong to it?
>   git -C .. ls-files <args> -- path/to/submodule
>   # Where does that git project's gitdir live?
>   git -C .. rev-parse --absolute-git-dir
> 
> Even if we can do the second call in-process, we still will be
> performing this ls-files call to ensure that the parent repo is actually
> our superproject. (One good example of a time when the parent repo is
> *not*: the entire Git test suite, where '/path/to/git/t/trash directory.t1234-abcd'
> is not a submodule of '/path/to/git/.git'.)
> 
> We could reverse the checks, which will make this much less painful in
> the real world, but will still slow down our test suites (and hopefully
> you'll forgive me for combining C and bash so brazenly, but it's for
> illustration purposes only):
> 
>   # Is there a git project above us?
>   setup_git_directory_gently_1("..", out, 0);
>   # Does it think we're its submodule?
>   git -C $out rev-parse --absolute-git-dir
> 
> That will still result in an extra out-of-process call for every line in
> the Git test suite, though, because of the trash directory layout.
> 
> I looked briefly at `git ls-files` // `cmd_ls_files()` and it's fairly
> close to being callable on an arbitrary 'struct repository', but not
> quite there. But I am pretty afraid of the rabbit hole ;)

Jonathan Nieder and Glen Choo pointed out that I can read in the index
to an arbitrary struct index_state from a path, and then call
'index_dir_exists()', so this part of it is not as scary as I thought.

I'll mess around today and see if I can come up with an in-process
version of 'get_superproject_working_tree()' and
'get_superproject_gitdir()'.

Thanks for the lead - a fine example of how useful it is to receive
high-level input from someone removed from the problem ;)

 - Emily
