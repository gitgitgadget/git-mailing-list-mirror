Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C9C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C1B613A9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhGNWJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNWJF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:09:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756CC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:06:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ga14so5728124ejc.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pLbhTWF8aHSwkOEYFQ6hIEaz8jcUchDFon5WmyCeQBQ=;
        b=MPPQeuwUd7dKwp3NgzxkF0t/qZIKdVaxDscQSmgty/CtX27VKgIb6G9qr8LTvagdPc
         h6tljKfDrYmR0v665OVv/d0oPbkGM9ME7CLxh8y2jl6lOK75h1dHMkcmdzguSMXUjgtT
         ZpV2wtrORLn7sTkvyH4F8j0oN/PrNuq0sBjP7kF491RsrO/C0hdFXYxi0f+8f6TyQW96
         wKxxVxDKk7tRJGOUYHanT14xSrW8I4uQTwH9La5I2T4IwcVQx/w8G8YmlBqHhDiq1mbH
         5FgZN7qe9o0iErf9C2OXx8Vx+G4l5jEkX61SrkxgPnh1UOBx5tVwvB1Ca9EnAV9uhEL3
         0EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pLbhTWF8aHSwkOEYFQ6hIEaz8jcUchDFon5WmyCeQBQ=;
        b=JOg01c86s1MuBa/OlNcala9rviFvzjAtGAuLpaaZvbTwXdWAIXjQHDrGawzJTpggwz
         t+Kp/uAS26WuQxHKebfuh4OVmDOms0NbjNdMl9wGLokcCHtfgTps+g67xsPNNj9VFy53
         cIdFbBkgl26jTH41SB0BgVfoZJDlLTbJXlmIqQycWPCKXf0YZkx0N8CL7vb/+keMh+X/
         rME1s/RfYCVYTWkPYXRelED+gW80eaZVBqAciejXWCF9DSHeay0eBc27rt8WC3KE/Mdm
         nqN0Ve2HHJ7lILajoYnQo62DRavoc4hTrU+qJhmqoYRoW12U6yBC9/rf28QsxCUfKZ5O
         6AZA==
X-Gm-Message-State: AOAM5301vMn/i4nVpFv2rmtFMTqXtd5bnsrRWGwF/ParSeTOBEkFPF+o
        pgi4/Ol1Bh2fNYGSjFRCLpY=
X-Google-Smtp-Source: ABdhPJxXbnQ3dbLQ+bo9pfxIN1KgV4+HwUx8Mr7ohCOPTvgLgMzaZukM2GiyjWzRe5gEIE5P9Rortg==
X-Received: by 2002:a17:907:2d23:: with SMTP id gs35mr409142ejc.222.1626300370136;
        Wed, 14 Jul 2021 15:06:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n16sm1171177ejc.121.2021.07.14.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:06:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] send-pack: fix push.negotiate with remote helper
Date:   Wed, 14 Jul 2021 23:51:05 +0200
References: <87bl753i2p.fsf@evledraar.gmail.com>
 <20210714193220.4083070-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210714193220.4083070-1-jonathantanmy@google.com>
Message-ID: <87pmvkzh2g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Jonathan Tan wrote:

>> > +test_expect_success 'http push with negotiation' '
>> > +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
>> > +	URI="$HTTPD_URL/smart/server" &&
>> > +
>> > +	rm -rf client &&
>> 
>> Nothing in this test file has created a "client" directory at this
>> point, so we shouldn't have this to remove it.
>> 
>> I think the real reason for this is that you're just copy/pasting this
>> from elsewhere. I've got an unsubmitted series where I fixed various
>> callsites in these t/t*http* tests to use test_when_finished instead.
>> 
>> This pattern of having the next test clean up after you leads to bad
>> inter-dependencies, there were a few things broken e.g. if earlier tests
>> were skipped. Let's not continue that pattern.
>
> OK - I have changed it so that each test is independent and cleans up after
> itself.
>
>> 
>> > +	git init client &&
>> > +	test_commit -C client first_commit &&
>> > +	test_commit -C client second_commit &&
>> > +
>> > +	# Without negotiation
>> > +	test_create_repo "$SERVER" &&
>> 
>> s/test_create_repo/git init/g
>
> Done.
>
>> 
>> > +	test_config -C "$SERVER" http.receivepack true &&
>> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
>> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
>> > +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
>> > +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
>> > +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
>> > +
>> > +	# Same commands, but with negotiation
>> > +	rm event &&
>> > +	rm -rf "$SERVER" &&
>> 
>> Ditto test_when_finished, or actually:
>> 
>> > +	test_create_repo "$SERVER" &&
>> > +	test_config -C "$SERVER" http.receivepack true &&
>
> In my current version, I have changed everything to "git init". Should I
> use "test_create_repo" instead?

Sorry I just copy/pasted that from your version, yes indeed
s/test_create_repo/git init/ (a trivial thing, but they're 1=1
equivalent these days after a recent change of mine in
test-lib-functions.sh).

>> 
>> If we're entirely setting up the server again shouldn't this just be
>> another test_expect_success block?
>
> I only made one block at first because the test without negotiation is
> there just for comparing object counts, but OK, I have split it up into
> 2 blocks.
>
>> 
>> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
>> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
>> > +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
>> > +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
>> > +	grep_wrote 3 event # 1 commit, 1 tree, 1 blob
>> > +'
>> > +
>> > +test_expect_success 'http push with negotiation proceeds anyway even if negotiation fails' '
>> > +	rm event &&
>> > +	rm -rf "$SERVER" &&
>> > +	test_create_repo "$SERVER" &&
>> > +	test_config -C "$SERVER" http.receivepack true &&
>> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
>> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
>> > +	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
>> > +		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&
>> > +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
>> > +	test_i18ngrep "push negotiation failed" err
>> 
>> s/test_i18ngrep/grep/, or actually better yet is there a reason not to
>> do test_cmp here? I'm pretty sure there's not.
>> 
>> The reason I've got that unsubmitted series is because I found a bug
>> that was cleverly hidden away by an earlier such 'grep the output'
>> code/test you'd added recently.
>> 
>> There *are* cases where we e.g. get STDERR output from the OS itself
>> about bad connections, or races, but we should at least:
>> 
>>     grep error: <stderr >error-lines.actual &&
>>     test_cmp error-lines.expect error-lines.actual
>> 
>> To check that we get the errors we expected, and *only* those.
>
> I didn't want to make the test prescribe unnecessary details, but good
> point about hiding bugs. I have switched it to what you describe.
>
>> 
>> > +'
>> > +
>> > +# DO NOT add non-httpd-specific tests here, because the last part of this
>> > +# test script is only executed when httpd is available and enabled.
>> > +
>> >  test_done
>> 
>> Also, instead of this comment let's just create another
>> t*-fetch-push-http.sh test. Because:
>> 
>>  * This test is already really slow, it takes me 13s to run it now. I
>>    haven't tested, but setting up apache will make it even slower.
>> 
>>  * It's also an anti-pattern to switch midway to needing an external
>>    daemon v.s. doing it in a dedicated test.
>> 
>>    E.g. if you have the relevant GIT_* settings to run http:// tests,
>>    but not git:// tests we'll skip the former entirely in
>>    t5700-protocol-v1.sh, because we'll "skip all" as soon as we see we
>>    can't start the git-daemon.
>> 
>>    That specifically isn't an issue here, but better to avoid setting up
>>    the pattern.
>
> I think this is a pattern that we need, though. Sometimes there are
> closely related fetch/push tests (as in here, and as in t5700) that want
> to test similar things across different protocols.

Yeah, in my split-up WIP there's a bit of that, in my split-up of them I
didn't find the end result harder to read, e.g. in
t/t5702-protocol-v2.sh it's mostly in different sections of the file,
first git://, then file:// and then http://, with some misc in-between,
having a t/t57*-protocol-{git,file,http}.sh didn't make things harder to
read.

>> 
>>  * What *is* an issue with it here is that the "skip all" in TAP is only
>>    handled before you run any tests, e.g. compare:
>>        
>>        $ prove ./t5700-protocol-v1.sh
>>        ./t5700-protocol-v1.sh .. ok    
>>        All tests successful.
>>        Files=1, Tests=21,  2 wallclock secs ( 0.02 usr  0.00 sys +  0.80 cusr  0.80 csys =  1.62 CPU)
>>        Result: PASS
>>        
>>        $ GIT_TEST_GIT_DAEMON=false GIT_TEST_HTTPD=false prove ./t5700-protocol-v1.sh
>>        ./t5700-protocol-v1.sh .. skipped: git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)
>>        Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.02 cusr  0.00 csys =  0.03 CPU)
>>        Result: NOTESTS
>>        
>>        $ GIT_TEST_GIT_DAEMON=true GIT_TEST_HTTPD=false prove ./t5700-protocol-v1.sh
>>        ./t5700-protocol-v1.sh .. ok    
>>        All tests successful.
>>        Files=1, Tests=16,  1 wallclock secs ( 0.01 usr  0.00 sys +  0.63 cusr  0.59 csys =  1.23 CPU)
>>        Result: PASS
>>    
>>    I.e. if you stick an inclusion of lib-httpd.sh this late in a test
>>    file we won't get a prominent notice saying we're categorically
>>    skipping certain types of tests based on an external dependency.
>> 
>>    If you had your own dedicated test instead you'd get:
>>        
>>        $ GIT_TEST_HTTPD=false  prove ./t5705-protocol-v2-http.sh 
>>        ./t5705-protocol-v2-http.sh .. skipped: Network testing disabled (unset GIT_TEST_HTTPD to enable)
>>        Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.02 cusr  0.01 csys =  0.05 CPU)
>>        Result: NOTESTS
>
> Is it useful to know the count of tests that are skipped? (The user
> presumably already knows that some are skipped because they set the
> environment variable in the first place.)

A thing I do really often is to run some glob of tests, say I'm working
on git-fetch, and run *fetch*, I'd get this in the output:
    
    [23:58:15] t5527-fetch-odd-refs.sh ......................... ok      121 ms ( 0.01 usr  0.00 sys +  0.72 cusr  0.38 csys =  1.11 CPU)
    [23:58:15] t5535-fetch-push-symref.sh ...................... ok       90 ms ( 0.01 usr  0.00 sys +  0.14 cusr  0.02 csys =  0.17 CPU)
    [23:58:16] t5536-fetch-conflicts.sh ........................ ok      180 ms ( 0.01 usr  0.01 sys +  0.28 cusr  0.07 csys =  0.37 CPU)
    [23:58:16] t5539-fetch-http-shallow.sh ..................... skipped: no web server found at '/usr/sbin/apache'
    [23:58:16] t5550-http-fetch-dumb.sh ........................ skipped: no web server found at '/usr/sbin/apache'
    [23:58:16] t5551-http-fetch-smart.sh ....................... skipped: no web server found at '/usr/sbin/apache'
    [23:58:16] t5554-noop-fetch-negotiator.sh .................. ok        3 ms ( 0.00 usr  0.00 sys +  0.07 cusr  0.02 csys =  0.09 CPU)
    [23:58:16] t5537-fetch-shallow.sh .......................... ok      641 ms ( 0.03 usr  0.01 sys +  0.87 cusr  0.31 csys =  1.22 CPU)
    [23:58:16] t5582-fetch-negative-refspec.sh ................. ok      564 ms ( 0.02 usr  0.01 sys +  0.77 cusr  0.32 csys =  1.12 CPU)

It's useful to know that a portion of the tests was skipped entirely,
whereas if we do git:// tests first, and then later http:// the loss of
coverage is silent (unless you run it individually under --verbose) or
whatever.

This is really useful for the http tests iin particular, it's really
common not to have apache installed.
