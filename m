Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CCCC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 10:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiGOKjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGOKjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 06:39:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB022BE3
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:39:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bp15so8271052ejb.6
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VKQIxpMWE9ZI0J9bG3EbzwzvcEwKAI7n/sQhtFQoedU=;
        b=pFNfaHdVrC+ztWgLvWtSPrzhA27Zk+79moWtxHQ3IwkyQMT5pGQYX+eHt7Gktl056r
         QuaobgYXkb94aD7Oy9FKwdfL6K6cKvL5Vs80FYXa3FLfJdlCBsy1cHn5p2sGJ3fAkALg
         6KIySJWeQH1yho8CkAM0KV4w7kTlTd5qoY5Z+lDQilla2cDMCBZbfNINUZ+RlWo8M/wV
         QVmTSGMfxNMcgu95H4ZZkQ8di8bZfQgXggnhoS/3px4n0sMwCM7dyeVQgKk5ldXHA+4A
         ODJILeK1HlnanOQpYvoZ2+SOFOOqMbniGwZFLbK1LAFCmwv1lYyn/TT03lvvxrYzpr7I
         eQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VKQIxpMWE9ZI0J9bG3EbzwzvcEwKAI7n/sQhtFQoedU=;
        b=xEqDX5tzlaiqJwt/mr+bDy0svdXFtDCTJ3qoM75w/jIkCZkWLjN5V1XkBAL62BMvC7
         36ADBgsv7MJkPdNn+klsMvbJJANba33ivz9x7U8g9UTyglO36CtHDiOtORMtwHSQHGcT
         0jHsVAUeCHd2lYqcw62qAYv/j+idAf7X6nVSmgy4k/WfqQrFECwVu+/d9tq2B1SHZHUl
         HbCm0KVzUkYAlg+BFSiIhurR+lQVzjQx8pefmdWBjiBCAWMuhWTrcA4KxehQ1Nz99hFE
         wwfq7d2A0DFF73bNsZPIAf9HKLxGKm8JNHx8kBUd5Lx1guIbGupaVs8Z7fF96+KiXXTJ
         fwRg==
X-Gm-Message-State: AJIora+BjndMG6sP16B+fU/59r7H7NzUYWZa2psS45HMnjDnmuJVtCF8
        h/C3O8vFhuROAiefjFZGVG8=
X-Google-Smtp-Source: AGRyM1vHkSG67yXtqlOPK8Pz+iFz3dLeEsgD+u/a/7Mp4UbWcwvu48M3LRqKiL5FI4rJuiymquEzlg==
X-Received: by 2002:a17:907:724f:b0:72b:8650:b188 with SMTP id ds15-20020a170907724f00b0072b8650b188mr13476058ejc.727.1657881541948;
        Fri, 15 Jul 2022 03:39:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i2-20020a170906850200b0072ac6d41207sm1895589ejx.5.2022.07.15.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 03:39:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCIiq-002eru-Bm;
        Fri, 15 Jul 2022 12:39:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: never refactor v.s. testing (was: [PATCH] tests: fix incorrect
 --write-junit-xml code)
Date:   Fri, 15 Jul 2022 11:35:41 +0200
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
Message-ID: <220715.86wncezmm3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
>     As if another data point was needed to corroborate my claim that
>     refactorings are neither free of cost nor of risk, this patch fixes a
>     regression I myself introduced while refactoring the JUnit XML output
>     code. At least this refactoring was motivated by an ulterior goal to
>     improve Git's contributor experience, not just refactoring for
>     refactoring's sake.
>     
>     Unfortunately, I noticed this regression no earlier than when I needed
>     to validate Git for Windows v2.37.1. Since v2.37.1 was an embargoed
>     release, I could not use GitHub Actions for the CI testing, so I had to
>     reinstate Git's Azure Pipeline.
>     
>     It will probably surprise only few, if at all, that this is far from the
>     only regression in the CI code that I had to fix just so I could run the
>     Azure Pipeline successfully. I plan on contributing all of these
>     regression fixes, of course, packaged into neat little,
>     logically-separate patch series that should be easy on reviewers.

I take your point that any code change carries risk, but I really think
walking away with the lesson that "refactorings" are bad is the wrong
thing to draw from this.

This is a textbook example of the value of testing. Code can break
because it's refactored directly, or because a library or tool it
depended on changed, etc.

The problem here isn't that we changed some code, but that it was
changed blindly.

Hindsight is 20/20 on the specifics of any bug, and I don't mean to pick
on you for having made a change without adding tests here in
particular. I've also done it, and will probably do it in the future
where I'm overly sure of myself.

But the idea that we should first consider basic lack of test coverage
before making (further) changes really isn't 20/20 hindsight. I think it
should be a basic part of our workflow, particularly in cases like this
(and the bisect case I pointed out in another thread[1]) where we can
see that we could remove the entire feature (or sub-feature for [1]) and
still pass 100% of our test.

As test coverage approaches 100% (which is often impossible in practice)
the risk of refactorings approaches (but never reaches) 0%. Plot them on
a mental graph and they're roughly inversely proportional to one
another. We'll almost never reach 100% and 0% in practice.

In this case we have no test coverage for --write-junit-xml before or
after this change. Before it were dying right away with just running
test-lib.sh with --write-junit-xml, So even the below up to
"test_must_be_empty" would catch it.

So we don't need the hypothetical 100%, just getting to 0.1% is enough,
and the below hopefully gets us past that to 1% (a lot of
--write-junit-xml remains completely untested):

1. https://lore.kernel.org/git/220714.86fsj4356l.gmgdl@evledraar.gmail.com/

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 17a268ccd1b..f3c12314787 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -238,6 +238,34 @@ test_expect_success 'subtest: --verbose option' '
 	EOF
 '
 
+test_expect_success 'subtest: --write-junit-xml option' '
+	# both --write-junit-xml and lib-subtest.sh expect to use "out"
+	GIT_TEST_JUNIT_DIRECTORY=.junit-xml &&
+	export GIT_TEST_JUNIT_DIRECTORY &&
+
+	write_and_run_sub_test_lib_test_err write-junit-xml \
+		--write-junit-xml <<-\EOF &&
+	test_expect_success "--true <>" "true"
+	test_expect_success "--false <>" "false"
+	test_done
+	EOF
+	test_must_be_empty write-junit-xml/err &&
+
+	sed -e "s/^> //" -e "s/time[^>]*/.../g" >expect <<-\EOF &&
+	> <testsuites>
+	>   <testsuite name="write-junit-xml" ...>
+	>     <testcase name="write.1 --true &lt;&gt;" classname="write" ...>
+	>     </testcase>
+	>     <testcase name="write.2 --false &lt;&gt;" classname="write" ...>
+	>       <failure message="not ok 2 - --false &lt;&gt;"> false&#x0a;</failure>
+	>     </testcase>
+	>   </testsuite>
+	> </testsuites>
+	EOF
+	sed -e "s/time[^>]*/.../g" <write-junit-xml/.junit-xml/TEST-write-junit-xml.xml >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'subtest: --verbose-only option' '
 	run_sub_test_lib_test_err \
 		t1234-verbose \
diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index 79c31c788b9..2aac1c6c548 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -22,7 +22,7 @@
 # that are are called at the appropriate times during the test runs.
 
 start_test_output () {
-	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
+	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/${GIT_TEST_JUNIT_DIRECTORY:-out}"
 	mkdir -p "$junit_xml_dir"
 	junit_xml_base=${1##*/}
 	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
