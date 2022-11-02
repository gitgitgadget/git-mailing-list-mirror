Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0542C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKBWs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKBWsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:48:55 -0400
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476296390
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:48:53 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id qMXSo68vDLVi2qMXTojVpI; Wed, 02 Nov 2022 22:48:51 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=prd4j-8_f37wwCn8SYQA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [RFC/PoC 1/5] doc: provide DocBundles design document
Date:   Wed,  2 Nov 2022 22:48:39 +0000
Message-Id: <20221102224843.2104-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221102224843.2104-1-philipoakley@iee.email>
References: <20221102224843.2104-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP+5GEMKmOJJ1OjmZfyD96VPuiapPur3v2rUxs7JwZAcvb/Mncp2kz08XkYkGHtKtUw4CjAhy1EpJD1AWqRH6t5+A76hrwsVWFP9zcAQZS6Sk/xFKqZZ
 a8Pc4ayHzhBJqNriM7sJLR9eFWxTwVY/3IgZfyzzVZLoRmw84ea0/S8oQybRTKzTMW1dgYSzKEL7lhtQ3wHAQgMV+9ciN0Oi+hXoeRgQEYoIg3eSyPnGYUDv
 OkGdJg9fF/yOOC9vE59RbFTsFwg5IJyE0TlX4N5f6zM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DocBundles are exemplar repositories, provided as bundles, which
contain either 'interesting' test setups for exploration, or
the described examples from within the man pages.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/technical/docbundle.txt | 97 +++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/technical/docbundle.txt

diff --git a/Documentation/technical/docbundle.txt b/Documentation/technical/docbundle.txt
new file mode 100644
index 0000000000..8c17a7847f
--- /dev/null
+++ b/Documentation/technical/docbundle.txt
@@ -0,0 +1,97 @@
+docbundle Design Document
+=========================
+
+The Git man pages contain many example setups to demonstrate aspects
+of the related Git commands, such as history simplification in the `log`
+and `show commands. However, while illustrative, these are not
+accessible, as example repositories, to regular, potentially confused,
+users who may need to understand the set up of the examples.
+
+The docbundle concept is that for each of these examples there is a
+matching `bundle` file, provided with the Documentation, which can be
+simply cloned to provide an example repository containing the example.
+
+There are also many example repositories in the Git `/t` test system
+that could be exposed to users which already demonstrate some important
+testable aspect of Git within a carefully constructed repository.
+
+
+This proposal is to provide DocBundles to users via the Git project.
+
+
+Firstly, it should be reasonably self-evident that the man page examples
+should, in themselves, be tested for accuracy, especially if provided
+to users.
+
+Secondly, the existing test system is the proper place to setup and
+test any such docbundle repositories.
+
+Third, that the bundle is an obvious pre-existing mechanism for
+transporting repositories (see also the Bundle-URI proposals).
+
+Fourthly, the preparation and distribution of the docbundle should
+require minimal maintainer effort, preferably being integrated into
+the existing automation for Documentation preparation and distribution.
+
+Fifthly, the docbudles themselves should not to be part of the git.git
+repo. They are prepared via the test suite and should be stored (locally)
+in a designated Git_DocBundle_Dir, and be .gitignored. The DocBundles
+are transferred to the maintainer's Doc repo via the automation.
+
+Sixthly, the docbundles to be named based on their `tnnnn` test number
+and a (short) descriptive name.
+
+Seven, (dev) start with an existing test, rather than add a test (most
+doc/man examples aren't tested!). Add tests for missing examples later.
+
+Eight, (option) add a `git docbundle` command to assist in locating and
+listing the docbundle examples. It also provides place to explain their
+purpose as "Tutorial Examples" (Note, many existing examples are to
+illustrate complex/difficult scenarios where the wording was insufficient;
+the docbudles are minimal examples).
+
+
+Status
+======
+
+This is an RFC/PoC (Request for Comment / Proof of Concept).
+
+The attached commits establish:
+
+Set out this design in the Documentation/technical directory.
+
+A default location for the docbundles and an env variable to allow
+flexibility by extending test-lib.
+
+The docbundles are ignored, as is the default directory.
+
+Two docbundles are generated from a 'random' test that I happened to
+have open in my editor (t6102 rev-list-simplify).
+
+The docbundle creation is protected by `test_expect_success` wrappers.
+
+
+
+ToDo
+====
+
+DocBundles - Is this the best name, or just a convenient way of
+indicating the delivery mechanism?
+
+Add Prerequisite to control if docbundles are generated (don't waste
+maintainers PC time when not needed).
+
+CI integration (i.e. whether to test the bundling aspect - should be
+reliable).
+
+How to update the man pages, perhaps by inclusion of the test comment
+(exported?), and distinguish between man page descriptions (being
+packaged by the test suite) and tests which offer users insight into
+Git operations, usually with 'interesting' commit-graph set-ups.
+
+Claim t999x as the man doc bundle test sequence ('999' is the UK
+emergency ("Help!") number; 911, 101 and 102 are taken test areas.
+
+Other stuff implicit in the eight point list
+
+
-- 
2.38.1.281.g83ef3ded8d

