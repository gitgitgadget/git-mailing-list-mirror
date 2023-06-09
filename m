Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A54CC7EE25
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 23:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFIXZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jun 2023 19:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjFIXZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2023 19:25:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0D30E8
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 16:25:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8cf175f5bso7473078276.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2023 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686353144; x=1688945144;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mdQxxuHROnuOwHBytOQBVderJAfD7+YK2OupBO3WV0=;
        b=5rMINv3Uut12Yy7jN8VmCY/jjfOMhtjXN7WEbbmZmk8/IH9w1Z4NTEhOEdRcgmBCmS
         OE4cgVNgffacY4Ec/f4Hn1B6LCBQjm0/aem6YAnpWotu2syNvc5Tjof/kaA6Sv22oHhn
         DNemiiBAkjWM8pMDhXCqYKJxAF2NFhaZU7HDM46DdGblrrclUp8LyyO8wNkAKjtoyI5C
         k+o1v6Qf108itL1E6s6GzjxxztEcoUnCbnVTX7hBIhb8bEXmn6ibk15jD0lZ1RGSOS+v
         Q+pfHTRceDaRB0F4G9I/Hf1Lmqfn4xxMHA+tV2URzKlfmcImcvu7ekDxzt3l+hAK+xIW
         Et8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686353144; x=1688945144;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3mdQxxuHROnuOwHBytOQBVderJAfD7+YK2OupBO3WV0=;
        b=cdlSGgRG/32kVUoT/L0TZrksqgg6EwdJCuEZ9Y8MHybFvZAY47bHgsKunLrCrtikp9
         pscSGt3iO/SQGa3f2q+5iwanEbn3QxQb3QaZaB24/meM2tHeB+KLmfmrJB0Wu9bsDYaP
         /rvgG2yEd+GszcTFjZrNDF2V/6oiefM/OcfhH7MbkdS9UoW/FXih5BlQefHGbaiklEWf
         yXqJhnAP3d3XAJR6P+0MYqCbedRoRVX65LKcDGWR1Rs1F7s1quqzdcK2xJ0vMbNlnEDn
         KllK4Jrlp3ebUH2n4DzmUjHJ7a7nyVf2Cm4W8vIbciZwq1FuhcLaCHQlD9DXGXaumN5B
         rjnQ==
X-Gm-Message-State: AC+VfDzO+wHM1ooq+V5G624oQQ2b19nTm0Hu1beBYh/KvnngpUkayzPC
        Q8CpKgagRHs2IV8Ri0HELF5l7Ck0lkyJF/OSsUpAkBcQq7E4pdKIQ3g9Kn80bXZFjHq4aGM3YBe
        b6W8Dr219PGwPGsEnFLuaoott59o3wxm1WSfMZ7Z1OxDB/fvVNu0t5bGw9OCA2no=
X-Google-Smtp-Source: ACHHUZ7gSHWGNqG53U+FHD89jsGOI/kogCT40epRJ+opqJlKNXNNme6enPkfER5ic1S1q0ebo9VjmcTlt9ivkg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:a66f:7f98:2439:c197])
 (user=steadmon job=sendgmr) by 2002:a05:6902:38a:b0:ba8:381b:f764 with SMTP
 id f10-20020a056902038a00b00ba8381bf764mr1712530ybs.3.1686353143821; Fri, 09
 Jun 2023 16:25:43 -0700 (PDT)
Date:   Fri,  9 Jun 2023 16:25:30 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
Subject: [RFC PATCH v3 1/1] unit tests: Add a project plan document
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions).Describe what we hope to accomplish by
implementing unit tests, and explain some open questions and milestones.
Discuss desired features for test frameworks/harnesses, and provide a
preliminary comparison of several different frameworks.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Coauthored-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 141 +++++++++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/technical/unit-tests.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b629176d7d..3f2383a12c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,6 +122,7 @@ TECH_DOCS +=3D technical/scalar
 TECH_DOCS +=3D technical/send-pack-pipeline
 TECH_DOCS +=3D technical/shallow
 TECH_DOCS +=3D technical/trivial-merge
+TECH_DOCS +=3D technical/unit-tests
 SP_ARTICLES +=3D $(TECH_DOCS)
 SP_ARTICLES +=3D technical/api-index
=20
diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technic=
al/unit-tests.txt
new file mode 100644
index 0000000000..dac8062a43
--- /dev/null
+++ b/Documentation/technical/unit-tests.txt
@@ -0,0 +1,141 @@
+=3D Unit Testing
+
+In our current testing environment, we spend a significant amount of effor=
t
+crafting end-to-end tests for error conditions that could easily be captur=
ed by
+unit tests (or we simply forgo some hard-to-setup and rare error condition=
s).
+Unit tests additionally provide stability to the codebase and can simplify
+debugging through isolation. Writing unit tests in pure C, rather than wit=
h our
+current shell/test-tool helper setup, simplifies test setup, simplifies pa=
ssing
+data around (no shell-isms required), and reduces testing runtime by not
+spawning a separate process for every test invocation.
+
+We believe that a large body of unit tests, living alongside the existing =
test
+suite, will improve code quality for the Git project.
+
+=3D=3D Definitions
+
+For the purposes of this document, we'll use *test framework* to refer to
+projects that support writing test cases and running tests within the cont=
ext
+of a single executable. *Test harness* will refer to projects that manage
+running multiple executables (each of which may contain multiple test case=
s) and
+aggregating their results.
+
+In reality, these terms are not strictly defined, and many of the projects
+discussed below contain features from both categories.
+
+
+=3D=3D Choosing a framework & harness
+
+=3D=3D=3D Desired features
+
+=3D=3D=3D=3D TAP support
+
+The https://testanything.org/[Test Anything Protocol] is a text-based inte=
rface
+that allows tests to communicate with a test harness. It is already used b=
y
+Git's integration test suite. Supporting TAP output is a mandatory feature=
 for
+any prospective test framework.
+
+=3D=3D=3D=3D Diagnostic output
+
+When a test case fails, the framework must generate enough diagnostic outp=
ut to
+help developers find the appropriate test case in source code in order to =
debug
+the failure.
+
+=3D=3D=3D=3D Parallel execution
+
+Ideally, we will build up a significant collection of unit tests cases, mo=
st
+likely split across multiple executables. It will be necessary to run thes=
e
+tests in parallel to enable fast develop-test-debug cycles.
+
+=3D=3D=3D=3D Vendorable or ubiquitous
+
+If possible, we want to avoid forcing Git developers to install new tools =
just
+to run unit tests. So any prospective frameworks and harnesses must either=
 be
+vendorable (meaning, we can copy their source directly into Git's reposito=
ry),
+or so ubiquitous that it is reasonable to expect that most developers will=
 have
+the tools installed already.
+
+=3D=3D=3D=3D Maintainable / extensible
+
+It is unlikely that any pre-existing project perfectly fits our needs, so =
any
+project we select will need to be actively maintained and open to acceptin=
g
+changes. Alternatively, assuming we are vendoring the source into our repo=
, it
+must be simple enough that Git developers can feel comfortable making chan=
ges as
+needed to our version.
+
+=3D=3D=3D=3D Major platform support
+
+At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
+
+=3D=3D=3D=3D Lazy test planning
+
+TAP supports the notion of _test plans_, which communicate which test case=
s are
+expected to run, or which tests actually ran. This allows test harnesses t=
o
+detect if the TAP output has been truncated, or if some tests were skipped=
 due
+to errors or bugs.
+
+The test framework should handle creating plans at runtime, rather than
+requiring test developers to manually create plans, which leads to both hu=
man-
+and merge-errors.
+
+=3D=3D=3D=3D Skippable tests
+
+Test authors may wish to skip certain test cases based on runtime circumst=
ances,
+so the framework should support this.
+
+=3D=3D=3D=3D Test scheduling / re-running
+
+The test harness scheduling should be configurable so that e.g. developers=
 can
+choose to run slow tests first, or to run only tests that failed in a prev=
ious
+run.
+
+=3D=3D=3D=3D Mock support
+
+Unit test authors may wish to test code that interacts with objects that m=
ay be
+inconvenient to handle in a test (e.g. interacting with a network service)=
.
+Mocking allows test authors to provide a fake implementation of these obje=
cts
+for more convenient tests.
+
+=3D=3D=3D=3D Signal & exception handling
+
+The test framework must fail gracefully when test cases are themselves bug=
gy or
+when they are interrupted by signals during runtime.
+
+=3D=3D=3D=3D Coverage reports
+
+It may be convenient to generate coverage reports when running unit tests
+(although it may be possible to accomplish this regardless of test framewo=
rk /
+harness support).
+
+
+=3D=3D=3D Comparison
+
+[format=3D"csv",options=3D"header",width=3D"75%"]
+|=3D=3D=3D=3D=3D
+Framework,"TAP support","Diagnostic output","Parallel execution","Vendorab=
le / ubiquitous","Maintainable / extensible","Major platform support","Lazy=
 test planning","Runtime- skippable tests","Scheduling / re-running",Mocks,=
"Signal & exception handling","Coverage reports"
+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com=
/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[lime=
-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-ba=
ckground]#True#,?,?,[red-background]#False#,?,?
+https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#True=
#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-background=
]#Partial#,[yellow-background]#Partial#,?,?,[lime-background]#True#,?,?
+https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-bac=
kground]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[lime=
-background]#True#,[yellow-background]#Partial#,?,?,[red-background]#False#=
,?,?
+https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[red-=
background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#,[=
yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[red-backgroun=
d]#False#,?,?
+https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#Pa=
rtial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,[yellow-b=
ackground]#Partial#,?,?,[red-background]#False#,?,?
+https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?,?=
,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]#F=
alse#,?,?
+https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,?,=
?,?,?,?,?,?,?
+https://nemequ.github.io/munit/[=C2=B5nit],?,?,?,?,?,?,?,?,?,?,?,?
+https://github.com/google/cmockery[cmockery],?,?,?,?,?,?,?,?,?,[lime-backg=
round]#True#,?,?
+https://github.com/lpabon/cmockery2[cmockery2],?,?,?,?,?,?,?,?,?,[lime-bac=
kground]#True#,?,?
+https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
+https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
+https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
+https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#True=
#,?,?,?,?,?,?,?,?,?,?,?
+|=3D=3D=3D=3D=3D
+
+=3D=3D Milestones
+
+* Settle on final framework
+* Add useful tests of library-like code
+* Integrate with Makefile
+* Integrate with CI
+* Integrate with
+  https://lore.kernel.org/git/20230502211454.1673000-1-calvinwan@google.co=
m/[stdlib
+  work]
+* Run alongside regular `make test` target
--=20
2.41.0.162.gfafddb0af9-goog

