Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7AAC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8486135A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhGMXgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGMXgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:36:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD54C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:33:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hc15so121756ejc.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lsGO+gu4CYqMCYYJ6eA8R7z70qu6QzHRNhRM6x/Kl3M=;
        b=RPr94juoMy26vRxf/UT1yq3bFskNwPXtn8fsIT8Hi3G+qaMeqPhPNldy5M9eJBlZKM
         xdsp4sc250m9ShsKzyewYG9yjOdJuKBYo4RYEHQwtG2mzUaJXRdfFCGz3YanH/pmAgGh
         0KDP8E1ZWd1uUYVNsC2R5hgedO5dQNf2rwYJjtztzJy/aDnvflga/d0swlEIcIf0rh0m
         SxCFIKEt39VhlCdN1DHI1CWzbNXKlpT9sv1u6r/rgp927wV2l1M/WJ/oEBpWA0Cr8ztb
         wAmKW49p4YMKnVROKgfQkmEzGQJ9HQL8hOn49C8mU488nU9kfYlX8+TnOb1w3zdqrY0J
         +wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lsGO+gu4CYqMCYYJ6eA8R7z70qu6QzHRNhRM6x/Kl3M=;
        b=aJGqQMZtq903JV3F5++eABpGnvGOIyXtWXOQJiSA5gKoJpHQExXgiYpaqJcf1ZaDzN
         FxoQIE8H6VrfUfndKBYLipNejf/zbmFAce2rAzIgTRBUMgapjQokQ8tcD1QIZbEKFBea
         TgKIO8PzQNGQFH0nNub9PFEJl+iKCgCNi+eunD5UaY9f9Z5AyO19ddbSzg383CLVPtUZ
         0kGdOdmXwGhxIqiAg2aELlX2YhcOQlKkyPP6coZDF1wTFM6wKDwlOCUu4Xb8460EG6ls
         V2PeyX8BSIQOoY9WQ9IMOYClxmbDpyT12A2N06cji+Prs9AadnNmOxgSAML1EBKJjD8I
         kVMQ==
X-Gm-Message-State: AOAM5312pT3r4qbIJ3KTzuORLemqmL9xZqsU19b2NlizeJdRePGKf+O5
        GUgmt5rOte7wiXhoCsIYMfM=
X-Google-Smtp-Source: ABdhPJwdPeGtMeMHAA+lBZHlRWBFtRpDWG7VsPQv4iR4dJ/7PMQW1DmRBUQetNa9aVlVk9jjaoMl3Q==
X-Received: by 2002:a17:906:58cc:: with SMTP id e12mr8758855ejs.279.1626219194569;
        Tue, 13 Jul 2021 16:33:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l18sm175970eds.72.2021.07.13.16.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:33:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] send-pack: fix push.negotiate with remote helper
Date:   Wed, 14 Jul 2021 01:11:48 +0200
References: <cover.1624486920.git.jonathantanmy@google.com>
 <042612733181ef348a67edc736637c7cd13c7a6d.1624486920.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <042612733181ef348a67edc736637c7cd13c7a6d.1624486920.git.jonathantanmy@google.com>
Message-ID: <87bl753i2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Jonathan Tan wrote:

> Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
> introduced the push.negotiate config variable and included a test. The
> test only covered pushing without a remote helper, so the fact that
> pushing with a remote helper doesn't work went unnoticed.
>
> This is ultimately caused by the "url" field not being set in the args
> struct. This field being unset probably went unnoticed because besides
> push negotiation, this field is only used to generate a "pushee" line in
> a push cert (and if not given, no such line is generated). Therefore,
> set this field.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/send-pack.c   |  1 +
>  t/t5516-fetch-push.sh | 49 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index a7e01667b0..729dea1d25 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -230,6 +230,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	args.atomic = atomic;
>  	args.stateless_rpc = stateless_rpc;
>  	args.push_options = push_options.nr ? &push_options : NULL;
> +	args.url = dest;
>  
>  	if (from_stdin) {
>  		if (args.stateless_rpc) {
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 0916f76302..5ce32e531a 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1768,4 +1768,53 @@ test_expect_success 'denyCurrentBranch and worktrees' '
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
>  
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +test_expect_success 'http push with negotiation' '
> +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> +	URI="$HTTPD_URL/smart/server" &&
> +
> +	rm -rf client &&

Nothing in this test file has created a "client" directory at this
point, so we shouldn't have this to remove it.

I think the real reason for this is that you're just copy/pasting this
from elsewhere. I've got an unsubmitted series where I fixed various
callsites in these t/t*http* tests to use test_when_finished instead.

This pattern of having the next test clean up after you leads to bad
inter-dependencies, there were a few things broken e.g. if earlier tests
were skipped. Let's not continue that pattern.

> +	git init client &&
> +	test_commit -C client first_commit &&
> +	test_commit -C client second_commit &&
> +
> +	# Without negotiation
> +	test_create_repo "$SERVER" &&

s/test_create_repo/git init/g

> +	test_config -C "$SERVER" http.receivepack true &&
> +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
> +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
> +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> +
> +	# Same commands, but with negotiation
> +	rm event &&
> +	rm -rf "$SERVER" &&

Ditto test_when_finished, or actually:

> +	test_create_repo "$SERVER" &&
> +	test_config -C "$SERVER" http.receivepack true &&

If we're entirely setting up the server again shouldn't this just be
another test_expect_success block?

> +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
> +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
> +	grep_wrote 3 event # 1 commit, 1 tree, 1 blob
> +'
> +
> +test_expect_success 'http push with negotiation proceeds anyway even if negotiation fails' '
> +	rm event &&
> +	rm -rf "$SERVER" &&
> +	test_create_repo "$SERVER" &&
> +	test_config -C "$SERVER" http.receivepack true &&
> +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> +	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
> +		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&
> +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> +	test_i18ngrep "push negotiation failed" err

s/test_i18ngrep/grep/, or actually better yet is there a reason not to
do test_cmp here? I'm pretty sure there's not.

The reason I've got that unsubmitted series is because I found a bug
that was cleverly hidden away by an earlier such 'grep the output'
code/test you'd added recently.

There *are* cases where we e.g. get STDERR output from the OS itself
about bad connections, or races, but we should at least:

    grep error: <stderr >error-lines.actual &&
    test_cmp error-lines.expect error-lines.actual

To check that we get the errors we expected, and *only* those.

> +'
> +
> +# DO NOT add non-httpd-specific tests here, because the last part of this
> +# test script is only executed when httpd is available and enabled.
> +
>  test_done

Also, instead of this comment let's just create another
t*-fetch-push-http.sh test. Because:

 * This test is already really slow, it takes me 13s to run it now. I
   haven't tested, but setting up apache will make it even slower.

 * It's also an anti-pattern to switch midway to needing an external
   daemon v.s. doing it in a dedicated test.

   E.g. if you have the relevant GIT_* settings to run http:// tests,
   but not git:// tests we'll skip the former entirely in
   t5700-protocol-v1.sh, because we'll "skip all" as soon as we see we
   can't start the git-daemon.

   That specifically isn't an issue here, but better to avoid setting up
   the pattern.

 * What *is* an issue with it here is that the "skip all" in TAP is only
   handled before you run any tests, e.g. compare:
       
       $ prove ./t5700-protocol-v1.sh
       ./t5700-protocol-v1.sh .. ok    
       All tests successful.
       Files=1, Tests=21,  2 wallclock secs ( 0.02 usr  0.00 sys +  0.80 cusr  0.80 csys =  1.62 CPU)
       Result: PASS
       
       $ GIT_TEST_GIT_DAEMON=false GIT_TEST_HTTPD=false prove ./t5700-protocol-v1.sh
       ./t5700-protocol-v1.sh .. skipped: git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)
       Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.02 cusr  0.00 csys =  0.03 CPU)
       Result: NOTESTS
       
       $ GIT_TEST_GIT_DAEMON=true GIT_TEST_HTTPD=false prove ./t5700-protocol-v1.sh
       ./t5700-protocol-v1.sh .. ok    
       All tests successful.
       Files=1, Tests=16,  1 wallclock secs ( 0.01 usr  0.00 sys +  0.63 cusr  0.59 csys =  1.23 CPU)
       Result: PASS
   
   I.e. if you stick an inclusion of lib-httpd.sh this late in a test
   file we won't get a prominent notice saying we're categorically
   skipping certain types of tests based on an external dependency.

   If you had your own dedicated test instead you'd get:
       
       $ GIT_TEST_HTTPD=false  prove ./t5705-protocol-v2-http.sh 
       ./t5705-protocol-v2-http.sh .. skipped: Network testing disabled (unset GIT_TEST_HTTPD to enable)
       Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.02 cusr  0.01 csys =  0.05 CPU)
       Result: NOTESTS
