Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BFC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiBYQ2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBYQ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:28:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D1F793AF
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:28:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw13so11858265ejc.9
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aR+oY/pRUMYQ2rrTSj0wxGwmHASatLXm5YvaK8HdYBs=;
        b=p+IPzwj0w+S6C8I/1mIrfmxQ0H6UO5oDUcoR/7dBLBpjqIaFZewFnXrhi9Fu7GaARe
         kFEzSC+z7ztbPRs8B8rdQaYf8lPod4E58JTt63tAPH4endA7LDlVsqX/iBfcI4C7lZVL
         XBuqtAcMmmHZwD8LXCY5zAC+BZr9qtSrk3XPuoeoBSkSfuMIYmROal76gYDuMKeQxlUG
         b1vAcQUUAT3xG7NU71iuItAIbvh647aXOzaCdVE1r7xijAEOPSNLTumI6mKaj7soz8NH
         B9T27Yqhb+oDQdFu6/Ptg8lkicyYMDYmYNkbMqWbUhtj+yPu5GK8Vp6iqG9izUZCpyj6
         zwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aR+oY/pRUMYQ2rrTSj0wxGwmHASatLXm5YvaK8HdYBs=;
        b=wvn45Pt2OXZefBmLNYiF4ZrQ07ietMFVoz+WcxKENNj4tS0t2PFS+QXwcEknGj62WZ
         h1Rz3/yAqLgwPqBj1viGKdTW5W4pX0gH1RgwFqkgncBvnJ/ikp/F4VHqe1UcGuCOXIUn
         RTp3wBs+5hAX9tcq9ZHhIVf2OFQQNCLufjR6SqV8ctmSDIr0fTrshm8bxXzsO/pwLGOx
         qa3R2hBKkgcEGs8Zzjlu8R4aaLYeam8tNJnAeYmDloUdTHT1y/IQX9UMWkuOVnTcmkfS
         Ni0kwGZ5Zxysq9mZfAaI0RuLfIbL6SxGZ/5+5KAAKleG0+a9ByGG//RakxHYm8LLMKP6
         bWWA==
X-Gm-Message-State: AOAM533yTyNITKaa/E8UZ7N7jf0+j/7QZOO28lgPHHV9K55hHCbMqkNJ
        uNmn8NDXq6kNjGAYbd+1Jrg=
X-Google-Smtp-Source: ABdhPJwbyNkg2c+VPJXKCtURsBnwrHglILUC8FGyNhqpZyupYRk5pvZkPqMgVG5tFs2ckig7KF0CRA==
X-Received: by 2002:a17:906:1995:b0:6ce:6b78:f9ec with SMTP id g21-20020a170906199500b006ce6b78f9ecmr6729189ejd.459.1645806484472;
        Fri, 25 Feb 2022 08:28:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709060e8300b006d0e8ada804sm1169743ejf.127.2022.02.25.08.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:28:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNdRr-000e2F-BX;
        Fri, 25 Feb 2022 17:28:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>, git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
Date:   Fri, 25 Feb 2022 17:16:53 +0100
References: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
 <20220222154700.33928-1-chakrabortyabhradeep79@gmail.com>
 <nycvar.QRO.7.76.6.2202251600210.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202251600210.11118@tvgsbejvaqbjf.bet>
Message-ID: <220225.86zgme7vxo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 22 Feb 2022, Abhradeep Chakraborty wrote:
>
>> Julia Lawall wrote:
>>
>> > Of there are some cases that are useful to do statically, with only local
>> > information, then using Coccinelle could be useful to get the problem out
>> > of the way once and for all.  Coccinelle doesn't support much processing
>> > of strings directly, but you can always write some python code to test the
>> > contents of a string and to create a new one.
>> >
>> > Let me know if you want to try this.  You can also check, eg the demo
>> > demos/pythontococci.cocci to see how to create code in a python script and
>> > then use it in a normal SmPL rule.
>> > ...
>> > If the context that you are interested in is in a called function or is in
>> > the calling context, then Coccinelle might not be the ideal choice.
>> > Coccinelle works on one function at a time, so to do anything
>> > interprocedural, you have to do some hacks.
>>
>> Though in this case, `parse-options.c check` method is better [...]
>
> I fear that this is incorrect.
>
> In general, it is my experience that it is a mistake any time a static
> check is replaced by a runtime check.
>
> I was ready to let it slide in this instance, but in this case I now have
> proof that the `parse-options.c` check is worse than the originally
> suggested `sed` chain.
>
> That concrete proof is in the output of
> https://github.com/git/git/actions/runs/1890665968, where the combination
> of `ac/usage-string-fixups` and `jh/builtin-fsmonitor-part2` causes many,
> many failures, but all of those failures have the same root cause: the
> runtime check.
>
> With the original `check-usage-strings.sh`, the user inspecting any
> failure would see precisely what the issue is, in the `static-analysis`
> job's logs. It would display something like this:
>
> 	HEAD:builtin/fsmonitor--daemon.c:1507:          N_("Max seconds to wait for background daemon startup")),
>
> With v4 of the patch series, it does not spell out anything in
> `static-analysis`. Instead, it causes 8 separate jobs to fail,
> it causes failures not only in `t0012-help.sh` but also in
> `t7519-status-fsmonitor.sh` and in `t7527-builtin-fsmonitor.sh`.
>
> The purpose of t7519 and t7527 is _not_ to verify those usage strings,
> though.
>
> The worst part? Look at the relevant output of t0012 (see
> https://github.com/git/git/runs/5312844492?check_suite_focus=true#step:5:4902):
>
> 	[...]
> 	++ git -C sub fsmonitor--daemon -h
> 	++ exit_code=128
> 	++ test 128 = 129
> 	++ echo 'test_expect_code: command exited with 128, we wanted 129 git -C sub fsmonitor--daemon -h'
> 	test_expect_code: command exited with 128, we wanted 129 git -C sub fsmonitor--daemon -h
> 	++ return 1
> 	error: last command exited with $?=1
> 	not ok 81 - fsmonitor--daemon can handle -h
> 	[...]
>
> Do you see what usage string caused the failure? You can't. And that's
> even by design:
>
> 	(
> 		GIT_CEILING_DIRECTORIES=$(pwd) &&
> 		export GIT_CEILING_DIRECTORIES &&
> 		test_expect_code 129 git -C sub $builtin -h >output 2>&1
> 	) &&
> 	test_i18ngrep usage output
>
> The output is redirected, and since the runtime check added to
> `parse-options.c` causes the exit code to be different from the expected
> one, the output is never shown.
>
> Arguably the most important job of a regression test is to help software
> engineers to diagnose and fix the regression. As quickly and as
> conveniently as possible. That means that it is not enough to point out
> that there is a regression, the output should be as helpful and concise as
> possible to facilitate fixing the problem.
>
> In the above-mentioned case, it was neither as helpful nor as concise as
> possible because in the test case that was supposed to identify the
> problem, the actual error message was swallowed, and instead of causing
> one test failure, it caused a whopping 42 test cases to fail (some of
> which even show the error message, but that's not even the purpose of
> those test cases).
>
> Since the entire point of this here patch series is to help enforce Git's
> rules regarding usage strings, it should expect things like the issue with
> `fsmonitor--daemon` _and_ make it as painless to address such an issue.
>
> I am afraid that I have to NAK the `parse-options.c` approach because v1
> of this patch series did so much better a job.

I think that's a bit of an overreaction to what I think is a solid v2 in
<pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>, i.e. that we
must go back to v1 because we encountered this issue.

A. I think you're right about the t0012-help.sh output being bad,
   but that's rather easily fixed with something like the [1] below.

   I've run into that a few times, wished it was better, and manually
   grepped or cat'd the "output" file.

   Part of that is ultimately because we're mixing and matching whether this
   "usage" output goes on stdout or stderr in various commands.

B. The fsmonitor--daemon case is worse than most because it's only running on
   OS or Windows, i.e. the error we'd get in various other CI jobs is ifdef'd
   away, even though we could run the parse_options() part there.

   IIRC that's something I commented on in previous rounds of that series...

C. The case of 42 tests failing because of this could be addressed by just having
   t0012-help.sh do these checks if we wanted, although in that case we'd need to
   make sure we deal with other test blind spots. I.e. the
   "GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP" suggestion I had.

D. These sorts of check, by their nature, have an initial period of growing
   pains due to other in-flight topics. Once we move past that it's usually a
   non-issue going forward, as issues will be caught locally before patch
   submission.

   Data in favor of that is various other checks in parse_options_check() being
   mostly a non-issue, e.g. Junio's b6c2a0d45d4 (parse-options: make sure argh
   string does not have SP or _, 2014-03-23).

In this case I don't see how some minor issues when merging this with
"seen" would have us abandon the v1 and commit to a fragile parsing of C
code in shellscript instead, or with some coccinelle check that would
have inherent issues finding the full context we need (passed-down flags
etc.).

1. 

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c3e1f7159d..5474d463467 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -237,15 +237,24 @@ test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
 
+builtin_in_sub () {
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		"$@"
+	)
+}
+
+
 while read builtin
 do
-	test_expect_success "$builtin can handle -h" '
-		(
-			GIT_CEILING_DIRECTORIES=$(pwd) &&
-			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>&1
-		) &&
-		test_i18ngrep usage output
+	test_expect_success "invoking '$builtin -h' yields exit code 129" '
+		builtin_in_sub test_expect_code 129 git -C sub $builtin -h
+	'
+
+	test_expect_success "invoking '$builtin -h' output" '
+		builtin_in_sub test_expect_code 129 git -C sub $builtin -h >output 2>&1 &&
+		grep usage output
 	'
 done <builtins
 
