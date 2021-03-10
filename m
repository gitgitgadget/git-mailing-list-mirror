Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7844C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F1664FC6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhCJTal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhCJTa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:30:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75AFC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:30:26 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v14so5137089pgq.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6XfkPfjjocPSCDy/w69AWU6/W1pDBk6Dx9JsVh1v2zE=;
        b=mCu9BF1G1NYjJI9Ksh2mSzuLm0cFXTXymTVJZS9KYV8hV0DP9/8bTYolI+FweEyRqo
         G1960xLwmeq0zofbriR3R77g3vPo4Jv6MQjvB4xeCvyMJsMqECp8Xg6PLQ2UFxTC0ZUd
         1sw9pQv0RGFXMARuHfgmpibp+vRrCkfxYT/EgunubU93p4c6ySWhsLGCl+gLg4hU6BGQ
         LYp/YuvTDLolv3+8Z6pVwaE+39vsRN6lxhOki6zvU7emQmTsAhnIkcRDp893GXjTuPgI
         4Zq8VXyacQlKZ0YfNjAdDgaPbVPXoyCi96lOIeeEFQ8dp4Vm+10mvrvNe+pf+H/1HhsT
         QaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XfkPfjjocPSCDy/w69AWU6/W1pDBk6Dx9JsVh1v2zE=;
        b=VwhpU2zQibhdOU73AuB53elI/Xf99plEizcVBqNFVBEMUbYrfU70rCOrO2/MOdSvG7
         BwKCf0buhEc5bXezVMbz3QxTSNuF49d4XoQOpbzUpLFlG7ch+Jm+Mf0RqGlqwImgC1xs
         trbkUjx7Kl9lVR0g3/3EJAvfwkDn1DXUOw9i63EyKlU4XR9uIrLqKyVKBDLaiozN0tnq
         XrSbIgCdhq0bOMtJpxegtXUPvKaATrDeIzkSALIsvmNodRVZrU33AmCLqZGYMev4zMrr
         ahLByAVg4SSuijb0KLOkagmx7DukPbhPaFUMZ4Uc8S7FJU55NYI6e9BZ34QNaNYVsm3a
         6ceg==
X-Gm-Message-State: AOAM532uoUl18zjNA2ny9Z9NhDy//tDJdmkkGSD7/9GTGDn2GLy+yiPw
        RRYaM2It+lJjpkK4f5UvRTS9cA==
X-Google-Smtp-Source: ABdhPJx3sx6vBYzIaAQSP4WPqRcWcmi/fwaHSnfrX/an3o/AFC05LOK6jwrhYWSfIxWPMGm4ioGyCw==
X-Received: by 2002:aa7:848b:0:b029:1ef:4e98:6bb6 with SMTP id u11-20020aa7848b0000b02901ef4e986bb6mr4091688pfn.58.1615404625839;
        Wed, 10 Mar 2021 11:30:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
        by smtp.gmail.com with ESMTPSA id k15sm318917pgt.23.2021.03.10.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:30:25 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:30:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 01/17] doc: propose hooks managed by the config
Message-ID: <YEkeTB5MPjXJQRrO@google.com>
References: <20201222000220.1491091-1-emilyshaffer@google.com>
 <20201222000220.1491091-2-emilyshaffer@google.com>
 <xmqqa6snjv4m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6snjv4m.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 02:11:53PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +ways, providing an avenue to deprecate these "legacy" hooks if desired. The
> > +handling is based on a config `hook.runHookDir`, which is checked against a
> > +number of cases:
> 
> Don't we want to also warn when the setting "no" or something
> similar prevents the legacy hook from running, to help users
> who wonder why their hook scripts are not running?  I.e.
> 
> > +- "no": the legacy hook will not be run
> 
> +- "warn-no": Git will print a warning to stderr before ignoring the
> +  legacy hook

Yeah, I think you are right. Jonathan N suggested such an option as
"error" (as opposed to warning); I'll add it here plus to the enum and
take your description verbatim. Thanks.

> 
> > +- "interactive": Git will prompt the user before running the legacy hook
> > +- "warn": Git will print a warning to stderr before running the legacy hook
> > +- "yes" (default): Git will silently run the legacy hook
> 
> > +In case this list is expanded in the future, if a value for `hook.runHookDir` is
> > +given which Git does not recognize, Git should discard that config entry. For
> > +example, if "warn" was specified at system level and "junk" was specified at
> > +global level, Git would resolve the value to "warn"; if the only time the config
> > +was set was to "junk", Git would use the default value of "yes".
> 
> Hmph, instead of complaining "value 'junk' is not recognized" and
> erroring out?  Why?

I think for the exact case you're describing above - where I forgot some
useful combination of "run/don't run" and "warn/don't warn" (or, one
could forsee, "first" e.g. to run the legacy hook early on instead of
late, or "only" e.g. config hooks don't exist, etc etc), we add this
flag, and some enterprise (like Jonathan N's team) distributes the new
config to folks' system configs before 100% of machines are using the
newer Git executable. It's a long shot :) but I'd rather be flexible
than inflexible.

I will update the design doc anyway - I ended up implementing it as
"complain about 'junk' and then do default behavior".

> 
> > +[[stage-3]]
> > +==== Stage 3
> > +
> > +`.git/hooks` is removed from the template and the hook directory is considered
> > +deprecated. To avoid breaking older repos, the default of `hook.runHookDir` is
> > +not changed, and `find_hook()` is not removed.
> 
> Presumably, we'll have documentation somewhere that instructs users
> (who were taught by slashdot and other site to add certain scripts
> under their .git/hooks/) how to do the equivalent without adding
> scripts in .git/hooks/ directory and instead using the config
> mechanism (e.g. "when told to add script X in .git/hooks/, read such
> an instruction as if telling you to do Y instead") by the time this
> happens?  It probably makes sense to do so as part of stage-2, at
> which point the users are _ready_ to migrate.

Hm. Where should we distribute such a documentation? git-hook.txt?
githooks.txt? I think it's a good idea, sure.

> 
> > +[[security]]
> > +=== Security and repo config
> > +
> > +Part of the motivation behind this refactor is to mitigate hooks as an attack
> > +vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
> > +however, as the design stands, users can still provide hooks in the repo-level
> > +config, which is included when a repo is zipped and sent elsewhere.  The
> > +security of the repo-level config is still under discussion; this design
> > +generally assumes the repo-level config is secure, which is not true yet. The
> > +goal is to avoid an overcomplicated design to work around a problem which has
> > +ceased to exist.
> 
> I doubt we want to claim anything about security as part of this
> series.  As you say in the paragraph, .git/config and .git/hooks/
> are equally (un)protected and if we decide to punt .git/config
> security, then not moving away from .git/hooks would not hurt
> security-wise, either (in other words, security is not a viable
> motivation behind this series).

Yeah, I think you are right that despite my best efforts to spin it that
way, it just isn't a security win :) Ah well...

> 
> And if we stop advertising 'security merit' that does not exist,
> what remains?  Isn't the biggest selling point that an identical set
> of hook configuration can be shared among multiple repositories, and
> it allows more than one hook scripts to be triggered by a single
> "hook event"?  There may be other good things we should be able to
> sell the new mechanism to our users, and we do stress on them, which
> is done in the motivation section.  So...

Ok.

I would like to keep this header and make it more clear that we didn't
fully succeed in the wish to make zip attacks impossible, but I will
remove it from the motivations section at the top. I also added a little
more clarity (I hope) on the other pieces in the motivation section.

> 
> > +.Comparison of alternatives
> > +|===
> > +|Feature |Config-based hooks |Hook directories |Status quo
> 
> Sorry, but I did not find this table particularly convincing.
> 
> The only thing I sense is a hand-wavy desire that "we could make it
> better than everybody else if we work on it in this area", which can
> apply equally for other approaches---they could enhance what they
> already have (e.g. "discoverability & documentation").
> 
> As a list of "these are the points we aspire to do better than other
> people", I think it is an excellent idea to have a table like this
> here in the documentation.  But that is not a "comparison".

Ok. I'll see what I can do to frame it better.

> 
> > +[[execution-ordering]]
> > +=== Execution ordering
> > +
> > +We may find that config order is insufficient for some users; for example,
> > +config order makes it difficult to add a new hook to the system or global config
> > +which runs at the end of the hook list. A new ordering schema should be:
> > +
> > +1) Specified by a `hook.order` config, so that users will not unexpectedly see
> > +their order change;
> > +
> > +2) Either dependency or numerically based.
> > +
> > +Dependency-based ordering is prone to classic linked-list problems, like a
> > +cycles and handling of missing dependencies. But, it paves the way for enabling
> > +parallelization if some tasks truly depend on others.
> > +
> > +Numerical ordering makes it tricky for Git to generate suggested ordering
> > +numbers for each command, but is easy to determine a definitive order.
> 
> OK.
> 
> Have we decided what we do for hooks whose interface is to feed
> their input from their standard input?  The current system, I think,
> just feeds the single hook by writing into a pipe to it, but if we
> were to drive multiple hooks, we'd need to write the same thing to
> each of these hook programs?  

Yep. There are a few ways to do it:
1. Provide a file to be used as stdin. This way we just hook up that
file's fd to each hook process's stdin fd. (Example:
https://lore.kernel.org/git/20201222000435.1529768-11-emilyshaffer@google.com
in builtin/am.c:run_post_rewrite_hook())
2. Provide a string_list in the run_hooks_opt struct; hook.c treats each
entry in the string_list as a line to stdin, separated by a newline, and
"replays" the list to each hook in order. (Example:
https://lore.kernel.org/git/20201222000435.1529768-12-emilyshaffer@google.com)
3. Set up your own more complicated version of (2) by writing your own
callback to provide "next line of stdin" based on a context pointer. The
context pointer is per-hook-task. (Example:
https://lore.kernel.org/git/20201222000435.1529768-17-emilyshaffer@google.com)

> 
> Do we have a plan to deal with hooks whose outcome is not just
> "yes/no", e.g. "proc-receive" hook that munges the list of refs to
> be updated and the new values for them, or "applypatch-msg" that
> munges the incoming proposed commit log message?  Does the second
> hook work on the result of the first hook?  Do the two hooks work on
> the vanilla state and their output have to agree with each other?

The only hook I found this way was 'proc-receive' itself - and in the
end, because it's somewhat interactive with two-way communication with
the caller, it didn't seem like there was a good way to reason about
multiple hooks, like you say. So in the 'proc-receive' case, we disallow
multiple hooks. See
https://lore.kernel.org/git/20201222000435.1529768-15-emilyshaffer@google.com.
> 
> > +[[parallelization]]
> > +=== Parallelization with dependencies
> > +
> > +Currently hooks use a naive parallelization scheme or are run in series.  But if
> > +one hook depends on another's output, then users will want to specify those
> > +dependencies.
> 
> An untold assumption here is that the questions I asked earlier on
> having more than one hooks that is not just yes/no is something
> readers know the same answer, and that answer is "the outcome of the
> first hook is passed along (as if it were the input given by Git
> directly, if the first hook did not exist), to the second hook.  It
> should be spelled out somewhere before the execution ordering
> section, I think.

I'll make an explicit callout about that case, thanks.

 - Emily
