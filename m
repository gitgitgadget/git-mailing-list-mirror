Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE460C7EE25
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 22:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjFGW6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjFGW6N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 18:58:13 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EF10DE
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 15:58:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5689335d2b6so84313117b3.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178691; x=1688770691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImVVGiT3MyqaC6QecFlAOhmQoz3eziu8WpxB5QX+z7s=;
        b=ZJPhxCCh4BuOJtxJY8vajSCz2riIQXs0g5qtP+61Gr9QsOWC28LudhBB+RLiwPerXR
         qxXUi+i6fTxOlUK0SzUwhbnX5++83uc5Ji47iusJYTOW7zDsvQRI+5Mh8v2sopUfZRux
         7b2hu9zgAZ3hVqueG5oZyfyw04lyBeYTJokoYQi9IxjwOILS9bfAdm6AV9o/+upe1RTR
         rihpQRNhfcvYjVdoEvXNDi+Ky5JZfPzrpW5fDJjHofVK47LIlHz6IOBQ8NybeeHQL5I3
         0dkFGdE5YNCQnGtFzIiyBkQ8E5zxgu+QKSzlGY+c7weBJdFsw2phyrFNW03vZsO8dSNq
         8L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178691; x=1688770691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImVVGiT3MyqaC6QecFlAOhmQoz3eziu8WpxB5QX+z7s=;
        b=cksrBsZAFsu8YOGFXWcyqJ6evXH7BhKWbc3mjvMkdQ6VIjnzoahAOYDiMIQCAFOfZ/
         eCwN6MVaEgsksOfle0YM46iNahGUUe4MFUq+bUlgmQma7bzbajGYP50N63sMGP+Q7wNL
         +N7FWiNNE3VsY40pWMx5NLIhb2oQYKhqMC2wQsGhI2Jjg1I6PFiuC0PwZpxz/Yu2xS9u
         H+T4PqQ1j/olH3ajgxmKm/gMSwCFOS0wtnm/uLuPeP/bhduu6TuXgti9fm/rBrNHhpmt
         C4bh1q+/AeqhFvIL9EtQ2Dn08SGaRt1VlU57x+LIMLYdGz+Q4junZMX5L2LUJaAMOnq2
         Pl1w==
X-Gm-Message-State: AC+VfDw/gtXrZ/vfXBRo1CaHiG+VUG4FsTx7boajGtVm5wrEnNLuykar
        xW8ADANGv4WW1VObrD0J9h12oEL8KtvekafqtHtt3JNY
X-Google-Smtp-Source: ACHHUZ5ZJ6L6OjbIVRRf/pA7Kh7jQ0gHR189I0dfLHXoA4+z0sgJH6szw74bsE8Bqd6JArltcIYQkg==
X-Received: by 2002:a81:688b:0:b0:569:ecfc:dd77 with SMTP id d133-20020a81688b000000b00569ecfcdd77mr7713016ywc.6.1686178690929;
        Wed, 07 Jun 2023 15:58:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d186-20020a814fc3000000b00555d2944284sm5032678ywb.67.2023.06.07.15.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:58:10 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:58:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: [PATCH v5 0/2] gc: introduce `gc.recentObjectsHook`
Message-ID: <cover.1686178684.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a version of my series to implement the mutli-valued
"gc.recentObjectHook" configuration, which allows users to define custom
programs whose output determines an additional set of objects to retain
(along with their descendants) when GCing, regardless of their true age.

It is largely the same as the previous round, with the following
changes:

  - a small handful of wordsmithing changes in the second patch's
    message thanks to a very helpful review from the Google team's
    "Review Club" meeting.

  - removed a pair of stray references to "cruft tips" in favor of
    "recent objects".

  - rebased onto v2.41.0

Based on previous rounds of review, I think that this version should be
pretty much ready to go. But I'd appreciate some extra eyes on it just
to make sure.

Thanks in advance for your (hopefully final!) review.

Taylor Blau (2):
  reachable.c: extract `obj_is_recent()`
  gc: introduce `gc.recentObjectsHook`

 Documentation/config/gc.txt          |  15 +++
 reachable.c                          |  85 ++++++++++++-
 t/t5304-prune.sh                     |  14 +++
 t/t5329-pack-objects-cruft.sh        | 171 +++++++++++++++++++++++++++
 t/t7701-repack-unpack-unreachable.sh |  31 +++++
 5 files changed, 313 insertions(+), 3 deletions(-)

Range-diff against v4:
1:  9c1b59c8cf = 1:  38c4c4a17f reachable.c: extract `obj_is_recent()`
2:  18e50d2517 ! 2:  f661b54941 gc: introduce `gc.recentObjectsHook`
    @@ Commit message
         be pruned. Our options today consist of:
     
           - Point references at the reachability tips of any objects you
    -        consider precious, which may be undesirable or infeasible.
    +        consider precious, which may be undesirable or infeasible if there
    +        are many such objects.
     
           - Track them via the reflog, which may be undesirable since the
             reflog's lifetime is limited to that of the reference it's tracking
    @@ Documentation/config/gc.txt: or rebase occurring.  Since these changes are not p
      default is more aggressive than `gc.reflogExpire`.
      
     +gc.recentObjectsHook::
    -+	When considering the recency of an object (e.g., when generating
    -+	a cruft pack or storing unreachable objects as loose), use the
    -+	shell to execute the specified command(s). Interpret their
    -+	output as object IDs which Git will consider as "recent",
    -+	regardless of their age.
    ++	When considering whether or not to remove an object (either when
    ++	generating a cruft pack or storing unreachable objects as
    ++	loose), use the shell to execute the specified command(s).
    ++	Interpret their output as object IDs which Git will consider as
    ++	"recent", regardless of their age. By treating their mtimes as
    ++	"now", any objects (and their descendants) mentioned in the
    ++	output will be kept regardless of their true age.
     ++
     +Output must contain exactly one hex object ID per line, and nothing
     +else. Objects which cannot be found in the repository are ignored.
    @@ reachable.c: struct recent_data {
     +		ret = run_one_gc_recent_objects_hook(&data->extra_recent_oids,
     +						       programs->items[i].string);
     +		if (ret)
    -+			die(_("unable to enumerate additional cruft tips"));
    ++			die(_("unable to enumerate additional recent objects"));
     +	}
     +}
     +
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		# ensure that a dirty exit halts cruft pack generation
     +		git config --add gc.recentObjectsHook ./extra-tips.c &&
     +		test_must_fail git repack --cruft --cruft-expiration=now -d 2>err &&
    -+		grep "unable to enumerate additional cruft tips" err &&
    ++		grep "unable to enumerate additional recent objects" err &&
     +
     +		# and that the existing cruft pack is left alone
     +		test_path_is_file "$mtimes"
-- 
2.41.0.2.gaaae24b3a6.dirty
