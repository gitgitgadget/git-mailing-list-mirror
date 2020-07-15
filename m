Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6EC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB052206E9
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Bj+d99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgGOOxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOOxq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 10:53:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E68C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 07:53:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so2197352pfu.8
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iH3DqHvhFA5Q6Gys0fxPI1McL/wp67oiRIYtGQYlF0Q=;
        b=O4Bj+d99XrDxRts+LYX+Ql4Xnh9P/mjIarfhEGOyl9YWJhLKRLJFoj+tnrmu58KKe7
         rAT7/5JWAh65w6pigwtAElye2+IlpOL/EaNICP6sBjurgIf6ST0KsvrGyT7zZQxDrHxa
         0f8aByGtlrB1yNnHMgZSipvlML2Jy1pzDeTZ/YH5jjLeroncg5I1/6ppWo6nzkWsQx0U
         i0lJJ148TNOuQNvi+Tt03cViIzZgtUKXPRVDMj3ILD0n2MhuBarduC3lHvICBYiv7LbV
         c9LnRfSzCJ3DDXKSTh3ExeYpv1Sba0ai4J/x4HfHtxYso/GdVnDfzw28tun+4MIt1nHv
         WYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iH3DqHvhFA5Q6Gys0fxPI1McL/wp67oiRIYtGQYlF0Q=;
        b=Qb8VApCgJXBa7mde5PJ0lZ2Jymz4NScX6MJ5EQLA5wZuWC7Ls5OkTffgUOnFjA4PYf
         n1x/mEXIYx7mPSwrmvazZS4XDmXJbgX1erfmsp0tX2BiTdEJ3/E7Q39iSGJdEqBNBoKi
         bra4puA9RUPz2AyeNHYXlQSt7Lc0fWPS8yA/LO8TGcwCwQrIX6NFyqb1qNhjwnSRQg+8
         ELEW04Ek0YyNKpygR0c5MaGRa2B2t5UjSH/t/XATB0+aSldGnih3Z6hWzQm0595lwY0j
         fIVktBGrO3jIRJOrBf1X2VmACOb0X5/ZE3CEs85b99/1fL17US+gPlTJHiLv7UqOjQeW
         nFMg==
X-Gm-Message-State: AOAM532lPSIcXjYP6QUSieET4YSG4mXnx1sV9esZAfNHR5MabGdKBCTV
        z+VwfWnMzn1Lfu777rdXvsE=
X-Google-Smtp-Source: ABdhPJyrM+eC/K+qny07KjP7EEagDBkswwv/XUPafJefkxEQ+x8IzrtwJLO+v6Wsao2DUhsEtAyJCg==
X-Received: by 2002:a65:55c2:: with SMTP id k2mr41647pgs.451.1594824825390;
        Wed, 15 Jul 2020 07:53:45 -0700 (PDT)
Received: from konoha ([45.127.46.26])
        by smtp.gmail.com with ESMTPSA id c132sm2392145pfb.112.2020.07.15.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:53:44 -0700 (PDT)
Date:   Wed, 15 Jul 2020 20:23:36 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     kaartic.sivaraam@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'summary' from
 shell to C
Message-ID: <20200715145336.GA18071@konoha>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-5-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet>
 <20200705173458.GA5204@konoha>
 <0a2e53d4-7fc5-183d-663d-7a8f52b2a685@gmail.com>
 <20200706111559.GA10820@konoha>
 <nycvar.QRO.7.76.6.2007120230400.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2007120230400.50@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes!

On 12/07 02:46, Johannes Schindelin wrote:
> > > >>> +	cp_rev.git_cmd = 1;
> > > >>> +	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> > > >>> +			 argc ? argv[0] : "HEAD", NULL);
> > > >>
> > > >> Oy. Why not simply call `get_oid()`? No need to spawn a new process.
> > > >
> > > > Then everytime we need 'rev-parse', we simply call 'get_oid()'? That
> > > > will save us a ton of processes?
> > > >
> > > > But I think we do need to capture the output of 'git rev-parse --verify
> > > > ....' so I think it will backfire to use 'get_oid()' or am I just being
> > > > too dumb and not catching on something?
> > > >
> > >
> > > I'll leave this for others to answer.
> >
> > I will resolve this one after Dscho answers then.
> 
> The `rev-parse` command _would_ essentially call `get_oid()` and print the
> result (after converting it to hex, which you don't need, because the
> caller actually would parse the hex string anyway).
> 
> You can verify my claim by following the code:
> https://github.com/git/git/blob/v2.27.0/builtin/rev-parse.c#L956-L982 (it
> is slightly harder to follow because the `--verify` option makes sure that
> only one rev is shown, which means that the `get_oid_with_context()` call
> is separated from the corresponding `show_rev()` call).
> 
> So there really is no need to capture the output of that `rev-parse`
> command.

Yep.

> It is a different story, of course, when capturing the output of Git
> commands _that are run in a submodule_. Those currently still need to be
> spawned.

Oh alright, since we don't need to capture the output and rather use the
command for a particular functionality it offers to, in our just fetch
the OID of head, we use a helper function which the command actually
uses to make things happen instead of spawning a process. Is this
correct?

> > > >>> +
> > > >>> +	if (!capture_command(&cp_rev, &sb, 0)) {
> > > >>> +		strbuf_strip_suffix(&sb, "\n");
> > > >>> +		if (argc) {
> > > >>> +			argv++;
> > > >>> +			argc--;
> > > >>> +		}
> > > >>> +	} else if (!argc || !strcmp(argv[0], "HEAD")) {
> > > >>> +		/* before the first commit: compare with an empty tree */
> > > >>> +		struct stat st;
> > > >>> +		struct object_id oid;
> > > >>> +		if (fstat(0, &st) < 0 || index_fd(&the_index, &oid, 0, &st, 2,
> > > >>> +						  prefix, 3))
> > > >>> +			die("Unable to add %s to database", oid.hash);
> > > >>
> > > >> Umm. The original reads:
> > > >>
> > > >>                 # before the first commit: compare with an empty tree
> > > >>                 head=$(git hash-object -w -t tree --stdin </dev/null)
> > > >>
> > > >> It does not actually read from `stdin`. It reads from `/dev/null`,
> > > >> redirected to the input. And what it _actually_ does is to generate the
> > > >> OID of the empty tree.
> > > >>
> > > >> But we already _have_ the OID of the empty tree! It's
> > > >> `the_hash_algo->empty_tree`.
> > > >
> > > > I did not know this 'the_hash_algo'. I will use it. Thanks! :)
> > > >
> > > >> I hope that this is covered by the test suite. Please check that. The test
> > > >> would succeed with your version, but only because tests are run with
> > > >> `stdin` redirected from `/dev/null` by default.
> > > >
> > > > I guess yes. My work passed because the tests are written this way.
> > > >
> > > >>> +		strbuf_addstr(&sb, oid_to_hex(&oid));
> > > >>> +		if (argc) {
> > > >>> +			argv++;
> > > >>> +			argc--;
> > > >>> +		}
> > > >>> +	} else {
> > > >>> +		strbuf_addstr(&sb, "HEAD");
> > > >>> +	}
> > > >>
> > > >> The conversion to C would make for a fine excuse to simplify the logic.
> > > >
> > > > This was kind of like the 'shift' in shell. What equivalent do you
> > > > suggest?
> > > >
> > >
> > > I think that's just a general comment after the other comments found
> > > just above about simplifying things.
> >
> > Alright. But I do have to simplify the logic right?
> 
> You do not _have_ to. But it would make for a good opportunity to do that,
> I think, as the code is really hard to follow.
> 
> The idea here is actually not at all hard to understand, though: use
> the speficied rev (falling back to `HEAD`) to compare to, unless it is a
> yet-unborn `HEAD` in which case you compare to the empty tree.
> 
> It is very, very similar in spirit to the code in `do_pick_commit()` in
> `sequencer.c`:
> https://github.com/git/git/blob/v2.27.0/sequencer.c#L1765-L1774
> 
> The only difference is that you will also have to fall back to using
> `HEAD` if the argument in question turns out not to refer to a revision
> but is actually the first pathspec.

Alright. So do you suggest a code segment like this?

--------8<---------------------

module_summary() {
struct object_id *head_oid = NULL;
.....
.....
if (get_oid(argc ? argv[0] : "HEAD", head_oid)) {
			if (argc) {
			argv++;
			argc--;
		}
	} else if (!argc || !strcmp(argv[0], "HEAD")) {
		/* before the first commit: compare with an empty tree */
		oidcpy(head_oid, the_hash_algo->empty_tree);
		if (argc) {
			argv++;
			argc--;
		}
	} else {
		get_oid("HEAD", head_oid);
	}
.....
.....
}

*Passing head_oid as a pointer into the fucntion below*

compute_summary_module_list(..., struct object_id *head_oid,...) {
	.....
    .....
    if (head_oid) {
		argv_array_push(&diff_args, oid_to_hex(head_oid));
	}
    .....
    .....
}

----------->8-------------

When I try this, I get a:

    BUG: diff-lib.c:526: run_diff_index must be passed exactly one tree

And this occurs when we are inside the first if-statement. I do not
understand how we are passing multiple trees or making it seem as if
there are multiple trees? Also, even when we do not enter the first if,
we still get a segmentation fault. Why so?

Is this logic correct? I took some inspiration from the links you sent
above as well as some advice from Christian and Kaartic on this.
