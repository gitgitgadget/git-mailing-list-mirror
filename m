Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D93C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiJCJXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJCJXf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:23:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB3303E8
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 02:23:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so15755194wrb.13
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=GWAGgDsCb8XTog2WBXoD+SIGfWyw4E+b/hVzwOQzqIs=;
        b=IP8Ixynyizk19p/ELtE7WqgMaU096ChazdjOhXgmTnIsgzd2gP65Ayf9BJ4T9fArLL
         GSWLnYCKjEdRg4kS3UfpNRCqH8tEL+Q5UQ80yMrWbTFuyi4TknjHeKP5FvV2hJClhaQB
         jCsNnBT6zqR+FpN2HZ8+2y/DIwI5B3jc/gozbJnnSGTKgOfFTGeaUEyovjEiFRgnb8ap
         JQRc6rOv148Q5Cr5VBC3D59LT3waFyZ80qKOdS91s1f99ThpVE+fUJaRD1LmBoM9DHdw
         tHYSGWpEHOn5uGOdl6FjgCF8Vx4Uyu7tLawI+5q0KHB0GZi0WJ0jSBqng+i2Z8cW3XfO
         Ghdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GWAGgDsCb8XTog2WBXoD+SIGfWyw4E+b/hVzwOQzqIs=;
        b=WlcTYBqZIzwL3CkbYhtcRn6pSRnHfxt6ZBTQ6vqXCOFlSOV+IgVt+hy+qpg58Nvb6H
         53ab3nKOISlAo3sZwSyj1pDmcR4B/pX58pfjVesP6UqY/0NopwHjsGwnadWKtApElKiq
         rxN3HRcEuGk8cGx1cpOd+dbEHZznd/UKJqEM/EjgiFcsgG44C4VkvNZZfik8uMyhDIun
         PvJbeo9nHQ1LWmTGm1rKqA+Ln8lmdj1jj5jIkuwoGPn92Qx32H+aDTljCdKR4nVFQHn4
         OAbPpZ4ICieikCp+ogbEgrjEs3E3B4Ptp4vk8ioXtHQWIP6rHfClCj9aFXh2MKVCvq1l
         Kp3w==
X-Gm-Message-State: ACrzQf1jp/Kqk0x2OOyjwdDoJsS3/BCM4QdtuhQEjlwbnCtV3jxkM7ee
        oTZdLNPDLC6j+imjOazVSnNEIHbZyGs=
X-Google-Smtp-Source: AMsMyM5g7H+ouYjuuS3cftvHiwew2xKvVnBSI1qMo5ZYI4E6TFceL6GS5aCWMPdLhVj+UQPSkaC6Dg==
X-Received: by 2002:a5d:5983:0:b0:22c:b9a0:e874 with SMTP id n3-20020a5d5983000000b0022cb9a0e874mr12607971wri.306.1664789012237;
        Mon, 03 Oct 2022 02:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y25-20020a1c4b19000000b003b5054c6f87sm11033883wma.21.2022.10.03.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:23:31 -0700 (PDT)
Message-Id: <pull.1372.git.1664789011089.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Oct 2022 09:23:30 +0000
Subject: [PATCH] mailinfo -b: fix an out of bounds access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

To remove bracketed strings containing "PATCH" from the subject line
cleanup_subject() scans the subject for the opening bracket using an
offset from the beginning of the line. It then searches for the
closing bracket with strchr(). To calculate the length of the
bracketed string it unfortunately adds rather than subtracts the
offset from the result of strchr(). This leads to an out of bounds
access in memmem() when looking to see if the brackets contain
"PATCH".

We have tests that trigger this bug that were added in ae52d57f0b
(t5100: add some more mailinfo tests, 2017-05-31). The commit message
mentions that they are marked test_expect_failure as they trigger an
assertion in strbuf_splice(). While it is reassuring that
strbuf_splice() detects the problem and dies in retrospect that should
perhaps have warranted a little more investigation. The bug was
introduced by 17635fc900 (mailinfo: -b option keeps [bracketed]
strings that is not a [PATCH] marker, 2009-07-15). I think the reason
it has survived so long is that '-b' is not a popular option and
without it the offset is always zero.

This was found by the address sanitizer while I was cleaning up the
test_todo idea in [1].

[1] https://lore.kernel.org/git/db558292-2783-3270-4824-43757822a389@gmail.com/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    mailinfo -b: fix an out of bounds access
    
    I wonder if instead of dying when an assertion fails in strbuf_splice()
    it should call BUG() instead.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1372%2Fphillipwood%2Fmailinfo-b-fix-out-of-bounds-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1372/phillipwood/mailinfo-b-fix-out-of-bounds-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1372

 mailinfo.c          | 2 +-
 t/t5100-mailinfo.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 9621ba62a39..833d28612f7 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -317,7 +317,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 			pos = strchr(subject->buf + at, ']');
 			if (!pos)
 				break;
-			remove = pos - subject->buf + at + 1;
+			remove = pos - (subject->buf + at) + 1;
 			if (!mi->keep_non_patch_brackets_in_subject ||
 			    (7 <= remove &&
 			     memmem(subject->buf + at, remove, "PATCH", 5)))
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index cebad1048cf..db11cababd3 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -201,13 +201,13 @@ test_expect_success 'mailinfo -b double [PATCH]' '
 	test z"$subj" = z"Subject: message"
 '
 
-test_expect_failure 'mailinfo -b trailing [PATCH]' '
+test_expect_success 'mailinfo -b trailing [PATCH]' '
 	subj="$(echo "Subject: [other] [PATCH] message" |
 		git mailinfo -b /dev/null /dev/null)" &&
 	test z"$subj" = z"Subject: [other] message"
 '
 
-test_expect_failure 'mailinfo -b separated double [PATCH]' '
+test_expect_success 'mailinfo -b separated double [PATCH]' '
 	subj="$(echo "Subject: [PATCH] [other] [PATCH] message" |
 		git mailinfo -b /dev/null /dev/null)" &&
 	test z"$subj" = z"Subject: [other] message"

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
gitgitgadget
