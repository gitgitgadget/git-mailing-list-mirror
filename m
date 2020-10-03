Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC2C4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 07:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0E5206B8
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 07:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2n17nZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJCHE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCHE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 03:04:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62668C0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 00:04:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so3929851ior.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2020 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YX1NwkoV12Jbq6BQc52xHrc0vIRI676Z4EZplr3c9T4=;
        b=M2n17nZzuJZT1+WCEH4HfVGaAkYJLDbo/lv5+HJ8IUrK7WrRlgU4BpP2ghUxIsKmYR
         01qCv8hGSpD1K0yt6wgJ+RDGjPuF6rduMihuRw6WQdDdBUF0FFMF6kmQsgEfF1IgFFjL
         OZiKrJft6+mTwltVUGt3GwcSkq8guX/NRylyijqbOeLCMJ6U+oOhyT3U9iRzTgQoWQmW
         WSAfm0p6i5Gz6MTL51Sps82P/+6zxBgMa3P60iTalWZP29AwMJE3JAB9WhryuissZjKa
         o9ra9EhThWBsFqovCDBEdsdt5G5V2sGwGzdfinPDJC6otpOKCwV26iREgaNPQTEmqWjg
         zKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YX1NwkoV12Jbq6BQc52xHrc0vIRI676Z4EZplr3c9T4=;
        b=ZoMV93LGfzF87H3yIHji6BnJcCEZR7/pgnCbj4C+2ZhzpCbHXZlZ75+XRiwsRELUsY
         JBClw6njg2V2DkAn7pnEdwHfbU+aCt+jIlO0Pgj9/FOY5c6StVk7ZvsWNManZdA9xRFp
         aG0JMMAVew78QtdZY0+kVsqiUsBmXyeMU0NSc2C7aAaDHEXokVxI/wzo7ozziAdquKQU
         RRPb0MX8TyWR8cz0ZlNq3tNatrA16+9AbAzslDTc167TWzXgFvQmiv1+ZBFJQkXZFEuC
         0/UFvPGvG5/WH1HZNUEsOYaiMigIt7lz705uLgqd036FyXYm2ux6RF4SAvoZEkBAfuzE
         PCYQ==
X-Gm-Message-State: AOAM531beqt1QXyeNq/aA9f2ONF3cU4/EKqFemT0gXQJ0UDuC3B9Oc4E
        Vsfeb+OlzsnYFrJw7f1CUC/iYmdYWIc=
X-Google-Smtp-Source: ABdhPJwUKo+NJrwl5AdXbuUFlVX2uqxZfX6H9nm3MBBdwL3A48bu7Z3OTEFRLICkiz7v1gRySD2GWg==
X-Received: by 2002:a02:9f0d:: with SMTP id z13mr5439368jal.60.1601708697327;
        Sat, 03 Oct 2020 00:04:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 2sm1777069iow.4.2020.10.03.00.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2020 00:04:56 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] test_cmp: diagnose incorrect arguments more precisely
Date:   Sat,  3 Oct 2020 03:04:12 -0400
Message-Id: <20201003070412.33015-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <xmqq4knxwhkc.fsf@gitster.c.googlers.com>
References: <xmqq4knxwhkc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09) taught
test_cmp() and test_cmp_bin() to diagnose a missing input source. Even
though the arguments to test_cmp() must name regular files (or standard
input), it only diagnoses whether a source is missing, which makes the
check a bit loose. Teach the check to be more precise by diagnosing, not
only a missing source, but also if the source is not a regular file.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

  On Wed, Sep 16, 2020 at 5:14 PM Junio C Hamano <gitster@pobox.com> wrote:
  > Eric Sunshine <sunshine@sunshineco.com> writes:
  > > [...] I ask because test_cmp() was updated not long ago to
  > > provide better diagnostics when one of the files is missing.
  > > [1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)
  >
  > Yes, you did this with the commit,
  >         test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
  >         test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
  > and I do not immediately see why "test -e" shouldn't be "test -f".
  > It should ideally be "stdin is OK, otherwise it must be a readable
  > regular file".

  Perhaps the present patch suitably address your concern?

 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d59b90348..4bc54e9e80 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -955,8 +955,8 @@ test_cmp() {
 	test $# -eq 2 || BUG "test_cmp requires two arguments"
 	if ! eval "$GIT_TEST_CMP" '"$@"'
 	then
-		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
-		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
+		test "x$1" = x- || test -f "$1" || BUG "test_cmp '$1' missing or not regular file"
+		test "x$2" = x- || test -f "$2" || BUG "test_cmp '$2' missing or not regular file"
 		return 1
 	fi
 }
@@ -990,8 +990,8 @@ test_cmp_bin() {
 	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
 	if ! cmp "$@"
 	then
-		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
-		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
+		test "x$1" = x- || test -f "$1" || BUG "test_cmp_bin '$1' missing or not regular file"
+		test "x$2" = x- || test -f "$2" || BUG "test_cmp_bin '$2' missing or not regular file"
 		return 1
 	fi
 }
-- 
2.28.0.942.g77c4c6094c

