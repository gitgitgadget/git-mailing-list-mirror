Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E7C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiJFUs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiJFUsb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 16:48:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49E1429B9
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 13:47:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b2so7214493eja.6
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9A5qEnQMxc8ijBRDZ5g5J7vCajPe3kb4d0oWsVIxoA=;
        b=Yyc3QLUfhyGXiHN6GbkYHVuP4F2+YGKBirfe2Y7MVvUEXkmkHbI8basBTztn/ayDko
         Cqg5K26PPTQb/eIIPaITRqxEbM98bPuwf/yrhWQA4Z1exgZbiatI03LKx486OSfHTjfI
         8116K1T89sGupiCEWfbUbcEWkkeTAZsIk+P3H5Fbli5lxtagRN8I7T4WfnwczxhiAQGI
         1zxoxvpRZYE3ZVz0Hin9oJiP01F386g6NxlmE7Wy4cUeYh1T8n9eO8OBoEM/GrZbzrDe
         fNoII+alshtDAvq2L+vulAcKFoDWwH4/n3yQ30P8wrMsPei4UXZCLfIeTeU2OqEZRXrY
         WQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9A5qEnQMxc8ijBRDZ5g5J7vCajPe3kb4d0oWsVIxoA=;
        b=x7NEo0J3pknzFId4lnNQW7mhsgQZcKzEzBZHV160gv1iCb+FKb30GpwbCzr0NAUZZU
         aLqBkB+wiG1irl76X8fmG6oP9cmN86SfSKBBGhgr+5j1p/VzFGG1cKNbEqawMFcVNXQE
         2ZWxwHzparrJIkjyEqa7UrASrN+PvcEdLp87JKZHU7965Nc8gzM138BtBWCzqdcDyXgG
         /PVTp2pYjZp3fFPfvfKOTxuaLUO+RC7bRARXJt/oqbRwAM9II17KZuuyobZxBpvNhKeg
         HpxXB2Fi6P03FLZ9xyIbcX2SqY4dzJVOmsQ/Qa9sUeWrrD/8yWOLzr/amchoelqtT1kR
         2AAg==
X-Gm-Message-State: ACrzQf2NXoIR1iAGhTIRRonY9e2AzFp3CpiopynxXCMdEq3uxgQsNKIP
        wuaEc+2OAR/AOZJoHDnkQkc=
X-Google-Smtp-Source: AMsMyM4ez/yd+qyxgDDPzN4/tPQAy+Fo3mA41odlAdBTwbf7genrj62JwD5gfDmyRHs+i5JDo+snzg==
X-Received: by 2002:a17:907:a052:b0:78d:21b4:3898 with SMTP id gz18-20020a170907a05200b0078d21b43898mr1370243ejc.764.1665089256637;
        Thu, 06 Oct 2022 13:47:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id xf13-20020a17090731cd00b00730b3bdd8d7sm160334ejb.179.2022.10.06.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:47:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogXmJ-0034Uf-0R;
        Thu, 06 Oct 2022 22:47:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Date:   Thu, 06 Oct 2022 22:33:04 +0200
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
 <221006.868rltrltu.gmgdl@evledraar.gmail.com>
 <7306b890-641f-2c45-f610-2aa0361d6066@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <7306b890-641f-2c45-f610-2aa0361d6066@dunelm.org.uk>
Message-ID: <221006.86mta8r860.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 06/10/2022 16:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> test_todo() is built upon test_expect_failure() but accepts commands
>>> starting with test_* in addition to git. As our test_* assertions use
>>> BUG() to signal usage errors any such error will not be hidden by
>>> test_todo().
>> I think they will, unless I'm missing something. E.g. try out:
>
> It's talking about BUG() in test-lib.sh, not the C function. For example
>
> test_path_is_file () {
> 	test "$#" -ne 1 && BUG "1 param"
> 	if ! test -f "$1"
> 	then
> 		echo "File $1 doesn't exist"
> 		false
> 	fi
> }
>
> So a test containing "test_todo test_path_is_file a b" should fail as
> BUG calls exit rather than returning non-zero (I should probably test=20
> that in 0000-basic.sh)

Ah, anyway, I think getting that to behave correctly is *the* thing any
less sucky test_expect_failure replacement needs to get right, i.e. to
handle BUG() (in C code), abort(), SANITIZE=3Dundefined (and friends, all
of whom abort()), segfaults etc.

>> 	diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
>> 	index 80e76a4695e..1be895abba6 100755
>> 	--- a/t/t0210-trace2-normal.sh
>> 	+++ b/t/t0210-trace2-normal.sh
>> 	@@ -170,7 +170,7 @@ test_expect_success 'BUG messages are written to tr=
ace2' '
>>=20=09
>> 	 test_expect_success 'bug messages with BUG_if_bug() are written to tra=
ce2' '
>> 	 	test_when_finished "rm trace.normal actual expect" &&
>> 	-	test_expect_code 99 env GIT_TRACE2=3D"$(pwd)/trace.normal" \
>> 	+	test_todo env GIT_TRACE2=3D"$(pwd)/trace.normal" \
>> 	 		test-tool trace2 008bug 2>err &&
>> 	 	cat >expect <<-\EOF &&
>> 	 	a bug message
>> I.e. in our tests you need to look out for exit code 99, not the
>> usual
>> abort().
>> I have local patches to fix this, previously submitted as an RFC
>> here:
>> https://lore.kernel.org/git/RFC-cover-0.3-00000000000-20220525T234908Z-a=
varab@gmail.com/
>> I just rebased that & CI is currently running, I'll see how it does:
>> https://github.com/avar/git/tree/avar/usage-do-not-abort-on-BUG-to-get-t=
race2-event-2
>> When I merged your patches here with that topic yours started doing
>> the
>> right thing in this case, i.e. a "test_todo" that would get a BUG()"
>> would be reported as a failure.
>>=20
>>> +	test_true () {
>>> +		true
>>> +	}
>>> +	test_expect_success "pretend we have fixed a test_todo breakage" \
>>> +		"test_todo test_true"
>> "Why the indirection", until I realized that it's because you're
>> working
>> around the whitelist of commands that we have, i.e. we allow 'git' and
>> 'test-tool', but not 'grep' or whatever.
>> I'm of the opinion that we should just drop that limitation
>> altogether,
>> which is shown to be pretty silly in this case. I.e. at some point we
>> listed "test_*" as "this invokes a git binary", but a lot of our test_*
>> commands don't, including this one.
>
> test_expect_failure does not allow test_* are you thinking of test-tool?

I'm talking about test_todo, and the reason for that "test_true" being
needed is because test_must_fail_acceptable is picky, but we could also
(I just adjusted that one test):
=09
	diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
	index 52362ad3dd3..921e0401eb5 100755
	--- a/t/t0000-basic.sh
	+++ b/t/t0000-basic.sh
	@@ -143,11 +143,8 @@ test_expect_success 'subtest: a passing TODO test' '
=09=20
	 test_expect_success 'subtest: a failing test_todo' '
	 	write_and_run_sub_test_lib_test failing-test-todo <<-\EOF &&
	-	test_false () {
	-		false
	-	}
	 	test_expect_success "passing test" "true"
	-	test_expect_success "known todo" "test_todo test_false"
	+	test_expect_success "known todo" "test_todo false"
	 	test_done
	 	EOF
	 	check_sub_test_lib_test failing-test-todo <<-\EOF
	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
	index 8978709b231..9300eaa2c62 100644
	--- a/t/test-lib-functions.sh
	+++ b/t/test-lib-functions.sh
	@@ -1034,6 +1034,11 @@ test_must_fail_acceptable () {
	 		done
	 	fi
=09=20
	+	if test "$name" =3D "todo"
	+	then
	+		return 0
	+	fi
	+
	 	case "$1" in
	 	git|__git*|test-tool|test_terminal)
	 		return 0
	@@ -1050,10 +1055,6 @@ test_must_fail_acceptable () {
	 		fi
	 		return 1
	 		;;
	-	test_*)
	-		test "$name" =3D "todo"
	-		return $?
	-		;;
	 	*)
	 		return 1
	 		;;
=09

>> So in general I think we should just allow any command in
>> "test_must_fail" et al, and just catch in code review if someone uses
>> "test_must_fail grep" as opposed to "! grep".
>
> That is not going to scale well

Well, you're throwing the scaling out the window by whitelisting test_*
in your 1/3 :)

I don't think we really need it, but *the* reason it's there is to
distinguish things that run our own C code from things that don't, and a
lot of test_* helpers don't.

So if you want to pursue making this correct per the current intent it
should really use the current whitelist to decide whether or not to pass
things through the "should we change the exit code if it's a signal,
segfault etc?" part.

Otherwise you should just negate it or whatever, as the "test_todo" I
showed in
https://lore.kernel.org/git/221006.86v8owr986.gmgdl@evledraar.gmail.com/
does. I.e. we shouldn't be detecting an abort() in /bin/false and the
like.
