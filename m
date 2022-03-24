Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF71C433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352017AbiCXQ4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352112AbiCXQz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:55:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C893E10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:53:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h1so6347988edj.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cZhoCK6HuR3987FYCbWbb7s+WP+FMXDZWEQ/de3qNwU=;
        b=cLpk/c1OpNAh9GRdzoTR6SrGYTAfbxNfSqLX3GYSqBsEmS7BMqUvTQF6oknpt1aal1
         WBAwN9UJjo2HwGHjtLxLTsQpzg8Tu45Hy9nMgDDDaqiZVfOykGZW2bmMxskSmXtqHAsH
         me0TkyHeRTf753GrKBh6Bg1uEhkqTl0OPjx8H/3KhyP+DSFqC+R9qBSPgl4LCaQk5+t7
         572U7lCRXxa/fpYiz2ZyJp39Kodt4DC15xD/SAsLmd2/wWjSv/4c9NX4es9AWnRPmpFn
         U+09ZvJRZ/QNNYa+7jhKdLYtN3qkAgrZ0/V5a/YixuVV0CocQEpeWhAVDTG/uVsMKHRM
         t7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cZhoCK6HuR3987FYCbWbb7s+WP+FMXDZWEQ/de3qNwU=;
        b=oMgcJ0mt7wXwu4WZthnTFyB55TgRbCOT9TpJM+EUYFpySRtmVW+dnnO4THGD+GPeLQ
         MSPCAd8HRCE5PY4wHaa0mtmY3yB4xDbi7It/m6EgolF+q68NCMq6RWVZm05FnvUPL2gW
         hgN7eE6LlY4r9ahVv1wrEj5k80QTtK5AF6JlrY7MIlsGbBdbJTtOB5rBrVktcVf+DvJb
         6hS0mwzj23q/Ip3zyEMJAXc/GWnuZOTi8Fj/5r8YyQHbyd959TjPBUZ3bnoXmdIy1GFA
         +ym875zamsuJ+oqfHyg8ga7o8+4j6vkeAFsMlSu8rzlB8dUjykas/XROlWE6KqfelmYU
         orUw==
X-Gm-Message-State: AOAM532IlBh0uL8S7Qx3Ywba5AH6/SuJZWXTNNOsvhqSPzkgupBOTyZx
        HGs1MyGV6pW5BACguYmeumRLb1w1uVmwyg==
X-Google-Smtp-Source: ABdhPJyPWxNChaWygEoXu9/ZKXMCYkze0hD+BRRAJRSFJ7vgIlb1u8/WUVWfF+Jk22cHiKpuKtnmOA==
X-Received: by 2002:a05:6402:d69:b0:418:f7bd:b076 with SMTP id ec41-20020a0564020d6900b00418f7bdb076mr7825383edb.268.1648140780466;
        Thu, 24 Mar 2022 09:53:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm1702979edj.49.2022.03.24.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:52:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQhn-001ip1-90;
        Thu, 24 Mar 2022 17:52:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 09/11] core.fsyncmethod: tests for batch mode
Date:   Thu, 24 Mar 2022 17:29:28 +0100
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <b5f371e97fee69d87da1dccd3180de0691c15834.1648097906.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <b5f371e97fee69d87da1dccd3180de0691c15834.1648097906.git.gitgitgadget@gmail.com>
Message-ID: <220324.86tubnmgwk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Add test cases to exercise batch mode for:
>  * 'git add'
>  * 'git stash'
>  * 'git update-index'
>  * 'git unpack-objects'
>
> These tests ensure that the added data winds up in the object database.
>
> In this change we introduce a new test helper lib-unique-files.sh. The
> goal of this library is to create a tree of files that have different
> oids from any other files that may have been created in the current test
> repo. This helps us avoid missing validation of an object being added
> due to it already being in the repo.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  t/lib-unique-files.sh  | 32 ++++++++++++++++++++++++++++++++
>  t/t3700-add.sh         | 28 ++++++++++++++++++++++++++++
>  t/t3903-stash.sh       | 20 ++++++++++++++++++++
>  t/t5300-pack-object.sh | 41 +++++++++++++++++++++++++++--------------
>  4 files changed, 107 insertions(+), 14 deletions(-)
>  create mode 100644 t/lib-unique-files.sh
>
> diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
> new file mode 100644
> index 00000000000..74efca91dd7
> --- /dev/null
> +++ b/t/lib-unique-files.sh
> @@ -0,0 +1,32 @@
> +# Helper to create files with unique contents
> +
> +# Create multiple files with unique contents within this test run. Takes the
> +# number of directories, the number of files in each directory, and the base
> +# directory.
> +#
> +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
> +#					 each in my_dir, all with contents
> +#					 different from previous invocations
> +#					 of this command in this run.
> +
> +test_create_unique_files () {
> +	test "$#" -ne 3 && BUG "3 param"
> +
> +	local dirs="$1" &&
> +	local files="$2" &&
> +	local basedir="$3" &&
> +	local counter=0 &&
> +	test_tick &&
> +	local basedata=$basedir$test_tick &&
> +	rm -rf "$basedir" &&
> +	for i in $(test_seq $dirs)
> +	do
> +		local dir=$basedir/dir$i &&
> +		mkdir -p "$dir" &&
> +		for j in $(test_seq $files)
> +		do
> +			counter=$((counter + 1)) &&
> +			echo "$basedata.$counter">"$dir/file$j.txt"
> +		done
> +	done
> +}

Having written my own perf tests for this series, I still don't get why
this is needed, at all.

tl;dr: the below: I think this whole workaround is because you missed
that "test_when_finished" exists, and how it excludes perf timings.

I.e. I get that if we ran this N times we'd want to wipe our repo
between tests, as for e.g. "git add" you want it to actually add the
objects.

It's what I do with the "hyperfine" command in
https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z-avarab@gmail.com/
with the "-p" option.

I.e. hyperfine has a way to say "this is setup, but don't measure the
time", which is 1/2 of what you're working around here and in 10/11.

But as 10/11 shows you're limited to one run with t/perf because you
want to not include those "setup" numbers, and "test_perf" has no easy
way to avoid that (but more on that later).

Which b.t.w. I'm really skeptical of as an approach here in any case
(even if we couldn't exclude it from the numbers).

I.e. yes what "hyperfine" does would be preferrable, but in exchange for
avoiding that you're comparing samples of 1 runs.

Surely we're better off with N run (even if noisy). Given enough of them
the difference will shake out, and our estimated +/- will narrow..

But aside from that, why isn't this just:
	
	for cfg in true false blah
	done
		test_expect_success "setup for $cfg" '
			git init repo-$cfg &&
			for f in $(test_seq 1 100)
			do
				>repo-$cfg/$f
			done
		'
	
		test_perf "perf test for $cfg" '
			git -C repo-$cfg
		'
	done

Which surely is going to be more accurate in the context of our limited
t/perf environment because creating unique files is not sufficient at
all to ensure that your tests don't interfere with each other.

That's because in the first iteration we'll create N objects in
.git/objects/aa/* or whatever, which will *still be there* for your
second test, which will impact performance.

Whereas if you just make N repos you don't need unique files, and you
won't be introducing that as a conflating variable.

But anyway, reading perf-lib.sh again I haven't tested, but this whole
workaround seems truly unnecessary. I.e. in test_run_perf_ we do:
	
	test_run_perf_ () {
	        test_cleanup=:
	        test_export_="test_cleanup"
	        export test_cleanup test_export_
	        "$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c ' 
                	[... code we run and time ...]
		'
                [... later ...]
                test_eval_ "$test_cleanup"
	}

So can't you just avoid this whole glorious workaround for the low low
cost of approximately one shellscript string assignment? :)

I.e. if you do:

	setup_clean () {
		rm -rf repo
	}

	setup_first () {
		git init repo &&
		[make a bunch of files or whatever in repo]
	}

	setup_next () {
		test_when_finished "setup_clean" &&
		setup_first
	}

	test_expect_success 'setup initial stuff' '
		setup_first
	'

	test_perf 'my perf test' '
		test_when_finished "setup_next" &&
		[your perf test here]
	'

	test_expect_success 'cleanup' '
		# Not really needed, but just for completeness, we are
                # about to nuke the trash dir anyway...
		setup_clean
	'

I haven't tested (and need to run), but i'm pretty sure that does
exactly what you want without these workarounds, i.e. you'll get
"trampoline setup" without that setup being included in the perf
numbers.

Is it pretty? No, but it's a lot less complex than this unique file
business & workarounds, and will give you just the numbers you want, and
most importantly you car run it N times now for better samples.

I.e. "what you want" sans a *tiny* bit of noise that we use to just call
a function to do:

    test_cleanup=setup_next

Which we'll then eval *after* we measure your numbers to setup the next
test.
