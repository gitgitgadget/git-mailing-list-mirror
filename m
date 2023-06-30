Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE7DEB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 22:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF3Wv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3Wv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 18:51:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6835AF
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:51:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c01e1c0648aso2156586276.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688165484; x=1690757484;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax7BHzUOF7A6Cz2MFC/EG0CtfQ2CoJH8hgKWw8rt09M=;
        b=LHh0DKUaHyIg2HfVeUstrsrj/y20euZSEZyvp+TLW4vFfqbO7JZ60gukJTwO0+YGj1
         cNDf+Ge5Le19Py4vRJ9jCLiI33jKd3UXyb29eodh/62tAAUkOsNbutMsoq3CPh0cljhx
         1UpazfEnjdG7jbmDTga7gf6cLITrfq5WkUpBK1MnkvcIQiccTFMCNaHF2Wc81CjIt6tt
         TXa0J00g96ti5wIQUKwveFi6Z3+lSaVxuX+3Ds6JFULHSn3uAAQCeX7fgbV/Bv9EJYCF
         f/K3Si5xAWBQ/oaWACs0tWaocj+JjxVEV8S+CIKxH9pRY3qp4LuNd+LICuFG9x708s7v
         GgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688165484; x=1690757484;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ax7BHzUOF7A6Cz2MFC/EG0CtfQ2CoJH8hgKWw8rt09M=;
        b=NBjzfAiHJAxSsLo7za7M/TTRbfHz6qi6c7KTjTrKGYOCaoOJ7qyDk3NSJUUmwS2zLw
         mUaWAKm8T8wcKhwWt3DyBIkSkgNbEzUod/b7gdnoFawWshP3EBdXPg8V8OFFxID3Opaf
         PwGR6NgaYazeTgPxYN/heVUcXHHZc9IKiTxtUEgPv/A/kd3tdvq8zbxT7ywA0Mzsn6gb
         jW/R/infUEIdx1V48wmbiXnfHy9fm7xMB16WrTwqaYQO3fCm7GnEnK+HGIHw8rW0Qw2b
         L78qWg2A4cAUiiVpQlPJNOIuTkd3kw8vAbxY6clgt5S9xu+oeqdeLE40zEk5pbGRY1OI
         psyQ==
X-Gm-Message-State: ABy/qLZdOE1i5/LA1z4ATxV4JIw3DSsryhQeAoazeBxKmEo2dLdI+Sp4
        BeFOCYeZbnD9foVk1qpTd5gada0GIdqF/y+VudoYA6WgpoqqxFYrN5AtZrnbXS2CNA1OWzaBk9O
        bX2QDi2Ip4Uoplcd1p3GcyT0smQx05BgqQUDBT2UoUK5ondp8c7MPGWRic9uwS0M=
X-Google-Smtp-Source: APBJJlHuobI4aXsrtpn4/x9UbCxUdjiUfFqBBWjD488bAP11TjtndaWHPz5y+psc1rZ/eAyRaJM7AiicqX69KQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:1498:3821:7231:6e96])
 (user=steadmon job=sendgmr) by 2002:a25:24d1:0:b0:bc4:8939:e1f5 with SMTP id
 k200-20020a2524d1000000b00bc48939e1f5mr26678ybk.4.1688165484123; Fri, 30 Jun
 2023 15:51:24 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:51:19 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-8c1b50f75811@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-8c1b50f75811@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Subject: [PATCH v4] unit tests: Add a project plan document
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, phillip.wood123@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, calvinwan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Describe what we hope to accomplish by
implementing unit tests, and explain some open questions and milestones.
Discuss desired features for test frameworks/harnesses, and provide a
preliminary comparison of several different frameworks.

Coauthored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Unit tests additionally provide stability to the codebase and can
simplify debugging through isolation. Turning parts of Git into
libraries[1] gives us the ability to run unit tests on the libraries and
to write unit tests in C. Writing unit tests in pure C, rather than with
our current shell/test-tool helper setup, simplifies test setup,
simplifies passing data around (no shell-isms required), and reduces
testing runtime by not spawning a separate process for every test
invocation.

This patch adds a project document describing our goals for adding unit
tests, as well as a discussion of features needed from prospective test
frameworks or harnesses. It also includes a WIP comparison of various
proposed frameworks. Later iterations of this series will probably
include a sample unit test and Makefile integration once we've settled
on a framework. A rendered preview of this doc can be found at [2].

In addition to reviewing the document itself, reviewers can help this
series progress by helping to fill in the framework comparison table.

[1] https://lore.kernel.org/git/CAJoAoZ=3DCig_kLocxKGax31sU7Xe4=3D=3DBGzC__=
Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/=
technical/unit-tests.adoc

TODOs remaining:
- List rough priorities across comparison dimensions
- Group dimensions into sensible categories
- Discuss pre-existing harnesses for the current test suite
- Discuss harness vs. framework features, particularly for parallelism
- Figure out how to evaluate frameworks on additional OSes such as *BSD
  and NonStop
- Add more discussion about desired features (particularly mocking)
- Add dimension for test timing
- Evaluate remaining missing comparison table entries

Changes in v4:
- Add link anchors for the framework comparison dimensions
- Explain "Partial" results for each dimension
- Use consistent dimension names in the section headers and comparison
  tables
- Add "Project KLOC", "Adoption", and "Inline tests" dimensions
- Fill in a few of the missing entries in the comparison table

Changes in v3:
- Expand the doc with discussion of desired features and a WIP
  comparison.
- Drop all implementation patches until a framework is selected.
- Link to v2: https://lore.kernel.org/r/20230517-unit-tests-v2-v2-0-21b5b60=
f4b32@google.com

 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 196 +++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
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
index 0000000000..e302a0e40f
--- /dev/null
+++ b/Documentation/technical/unit-tests.txt
@@ -0,0 +1,196 @@
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
+[[tap-support]]
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
+In the comparison table below, "True" means this is natively supported.
+"Partial" means TAP output must be generated by post-processing the native
+output.
+
+Frameworks that do not have at least Partial support will not be evaluated
+further.
+
+[[diagnostic-output]]
+=3D=3D=3D=3D Diagnostic output
+
+When a test case fails, the framework must generate enough diagnostic outp=
ut to
+help developers find the appropriate test case in source code in order to =
debug
+the failure.
+
+[[parallel-execution]]
+=3D=3D=3D=3D Parallel execution
+
+Ideally, we will build up a significant collection of unit test cases, mos=
t
+likely split across multiple executables. It will be necessary to run thes=
e
+tests in parallel to enable fast develop-test-debug cycles.
+
+In the comparison table below, "True" means that individual test cases wit=
hin a
+single test executable can be run in parallel. "Partial" means that test c=
ases
+are run serially within a single executable, but multiple test executables=
 can
+be run at once (with proper harness support).
+
+[[vendorable-or-ubiquitous]]
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
+[[maintainable-extensible]]
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
+In the comparison table below, "True" means that the framework seems to ha=
ve
+active developers, that it is simple enough that Git developers can make c=
hanges
+to it, and that the project seems open to accepting external contributions=
 (or
+that it is vendorable). "Partial" means that at least one of the above
+conditions holds.
+
+[[major-platform-support]]
+=3D=3D=3D=3D Major platform support
+
+At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
+
+In the comparison table below, "True" means that it works on all three maj=
or
+platforms with no issues. "Partial" means that there may be annoyances on =
one or
+more platforms, but it is still usable in principle.
+
+[[lazy-test-planning]]
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
+[[runtime-skippable-tests]]
+=3D=3D=3D=3D Runtime-skippable tests
+
+Test authors may wish to skip certain test cases based on runtime circumst=
ances,
+so the framework should support this.
+
+[[scheduling-re-running]]
+=3D=3D=3D=3D Scheduling / re-running
+
+The test harness scheduling should be configurable so that e.g. developers=
 can
+choose to run slow tests first, or to run only tests that failed in a prev=
ious
+run.
+
+"True" means that the framework supports both features, "Partial" means it
+supports only one (assuming proper harness support).
+
+[[mock-support]]
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
+[[signal-error-handling]]
+=3D=3D=3D=3D Signal & error handling
+
+The test framework must fail gracefully when test cases are themselves bug=
gy or
+when they are interrupted by signals during runtime.
+
+[[coverage-reports]]
+=3D=3D=3D=3D Coverage reports
+
+It may be convenient to generate coverage reports when running unit tests
+(although it may be possible to accomplish this regardless of test framewo=
rk /
+harness support).
+
+[[project-kloc]]
+=3D=3D=3D=3D Project KLOC
+
+WIP: The size of the project, in thousands of lines of code. All else bein=
g
+equal, we probably prefer a project with fewer LOC.
+
+[[adoption]]
+=3D=3D=3D=3D Adoption
+
+WIP: we prefer a more widely-used project. We'll need to figure out the be=
st way
+to measure this.
+
+[[inline-tests]]
+=3D=3D=3D=3D Inline tests
+
+Can the tests live alongside production code in the same source files? Thi=
s can
+be a useful reminder for developers to add new tests, and keep existing on=
es
+synced with new changes.
+
+=3D=3D=3D Comparison
+
+[format=3D"csv",options=3D"header"]
+|=3D=3D=3D=3D=3D
+Framework,"<<tap-support,TAP support>>","<<diagnostic-output,Diagnostic ou=
tput>>","<<parallel-execution,Parallel execution>>","<<vendorable-or-ubiqui=
tous,Vendorable or ubiquitous>>","<<maintainable-extensible,Maintainable / =
extensible>>","<<major-platform-support,Major platform support>>","<<lazy-t=
est-planning,Lazy test planning>>","<<runtime--skippable-tests,Runtime- ski=
ppable tests>>","<<scheduling-re-running,Scheduling / re-running>>","<<mock=
-support,Mock support>>","<<signal-error-handling,Signal & error handling>>=
","<<coverage-reports,Coverage reports>>","<<project-kloc,Project KLOC>>","=
<<adoption,Adoption>>","<<inline-tests,Inline tests>>"
+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com=
/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[lime=
-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-ba=
ckground]#True#,?,?,[red-background]#False#,?,?,?,?,?
+https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#True=
#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-background=
]#Partial#,?,?,?,[lime-background]#True#,?,?,?,?,?
+https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-bac=
kground]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[lime=
-background]#True#,?,?,?,[red-background]#False#,?,?,?,?,?
+https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[red-=
background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#,[=
yellow-background]#Partial#,?,?,?,[red-background]#False#,?,?,?,?,?
+https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#Pa=
rtial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,?,?,?,[re=
d-background]#False#,?,?,?,?,?
+https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?,?=
,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]#F=
alse#,?,?,?,?,?
+https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,?,=
?,?,?,?,?,?,?,?,?,?
+https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#True=
#,?,?,?,?,?,?,?,?,?,?,?,?,?,?
+https://nemequ.github.io/munit/[=C2=B5nit],[red-background]#False#,-,-,-,-=
,-,-,-,-,-,-,-,-,-,-
+https://github.com/google/cmockery[cmockery],[red-background]#False#,-,-,-=
,-,-,-,-,-,-,-,-,-,-,-
+https://github.com/lpabon/cmockery2[cmockery2],[red-background]#False#,-,-=
,-,-,-,-,-,-,-,-,-,-,-,-
+https://github.com/ThrowTheSwitch/Unity[Unity],[red-background]#False#,-,-=
,-,-,-,-,-,-,-,-,-,-,-,-
+https://github.com/siu/minunit[minunit],[red-background]#False#,-,-,-,-,-,=
-,-,-,-,-,-,-,-,-
+https://cunit.sourceforge.net/[CUnit],[red-background]#False#,-,-,-,-,-,-,=
-,-,-,-,-,-,-,-
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

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
--=20
2.41.0.255.g8b1d071c50-goog

