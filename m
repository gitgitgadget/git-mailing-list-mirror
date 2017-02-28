Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCB2201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdB1Ueq (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:46 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35596 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: by mail-wr0-f193.google.com with SMTP id q39so2986053wrb.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8c/msfanP+/G4uFYBXv9Qz3uZU2oNwVIOEUIc2X7VEE=;
        b=PMLSFzVsZxqkrAx9/kkj3R8OerfBOuG2Z+io44JMl39uqxyL79lAKSOsl0gMmutJg7
         YCl0Rhkfl9ewcUiv1vs7fdHIGuFkIdaiE7TDtaltJkyO3iel/jIRgqRo9qncIXNSvxe1
         ELh9qWUmVoXuFW4d73Dm2yhZ1IfsWUCDwlBOg+0zA456GCLlbE3zp3BH+Y937gX59r59
         NQsZDXxo8i37ifdD0lb7mcfQHQz5XCSb8H4iMG9Udef9BJU/JAoIo6MkvQnqrg4eRYxO
         g/BdFIe5QM6bgoniMawrKMHumQoOX8TXpgu37dfLx0eQMHMKYogZKQIs0yQEPxhXORbq
         5unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8c/msfanP+/G4uFYBXv9Qz3uZU2oNwVIOEUIc2X7VEE=;
        b=VmHvf3rqMOI6YFcRfIsDKkOeXkyltdr/VjdzMiylIDGCVBfiSpdXLvd86upfXj+9Tr
         0hGFuJ4TCMRbU3UzxDVOPeawzt0GyYbt+JI1lG6kaWZHZFojKh2ptRxPvHvTOf1WPRoq
         F9t6QcDS3ah93mqPUkC0xivilk8+Bhif9J/rm0i1UntFpz/XnKXj4oExYa/FGfyjxb82
         5bi/OrsV00CnwGPKIJke6PhiolglY9gI+5Y49TM/rGLCIF2r3MsJWwS+i3ucHsET7sas
         NAwzxV4dZ+iK1dgs3Uk8Db+pPMQAbA8Od58eGyvbOI1zSwkFl5WeWZlCVsxUMX74tl21
         lajQ==
X-Gm-Message-State: AMke39k422URJe3Xnc6O+3GwHPljGDN0v+/h8TmfEjo0vdrtwfCCeWsLyj1fZN87wnxIeQ==
X-Received: by 10.223.164.140 with SMTP id g12mr3111416wrb.87.1488314024732;
        Tue, 28 Feb 2017 12:33:44 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id c9sm4061810wmf.18.2017.02.28.12.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Feb 2017 12:33:43 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 0/6] stash: support pathspec argument
Date:   Tue, 28 Feb 2017 20:33:34 +0000
Message-Id: <20170228203340.18723-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.428.g67fe103aa
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170225213306.2410-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for the review and the squashable diff with the fix for
my errors.

I changed it a tiny bit, to use git stash push instead of git stash,
so the complete diff could go into 4/6, where I think I think the test
fits best.

Interdiff below:

diff --git a/git-stash.sh b/git-stash.sh
index 28d0624c75..207c8126f4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -300,6 +300,8 @@ push_stash () {
 		if test $# != 0
 		then
 			git reset ${GIT_QUIET:+-q} -- "$@"
+			git ls-files -z --modified -- "$@" |
+			git checkout-index -z --force --stdin
 			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
 			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
 		else
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f7733b4dd4..89877e4b52 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -842,6 +842,22 @@ test_expect_success 'stash with file including $IFS character' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash with pathspec matching multiple paths' '
+       echo original >file &&
+       echo original >other-file &&
+       git commit -m "two" file other-file &&
+       echo modified >file &&
+       echo modified >other-file &&
+       git stash push -- "*file" &&
+       echo original >expect &&
+       test_cmp expect file &&
+       test_cmp expect other-file &&
+       git stash pop &&
+       echo modified >expect &&
+       test_cmp expect file &&
+       test_cmp expect other-file
+'
+
 test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	>foo &&
 	git add foo &&

Thomas Gummerer (6):
  stash: introduce push verb
  stash: add test for the create command line arguments
  stash: refactor stash_create
  stash: teach 'push' (and 'create_stash') to honor pathspec
  stash: use stash_push for no verb form
  stash: allow pathspecs in the no verb form

 Documentation/git-stash.txt        |  25 +++++--
 git-stash.sh                       | 116 +++++++++++++++++++++++++------
 t/t3903-stash.sh                   | 138 ++++++++++++++++++++++++++++++++++++-
 t/t3905-stash-include-untracked.sh |  26 +++++++
 4 files changed, 275 insertions(+), 30 deletions(-)

-- 
2.12.0.428.g67fe103aa

