Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344EC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjECTtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjECTtv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:49:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA7E7AAD
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:49:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso6487481e87.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683143388; x=1685735388;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQnhfgsaak1oIY6R7PWjZvmrvBgyS/heQqBnG1O9VYU=;
        b=RF+yL4aQDD+hutXvn814OTHc9hzujJtmYU3kzD5UWspL2+S/zZtj8yEw72lalnZNTz
         gQ3E0CnQJoHRmcGVJQCxCMHAyTP27bpKanopILI5D83nX/oNWCtHH7IefV2d/U4g7H7c
         AoPwJDulYl2/8PsrHIUAH2HFzQo+sP6HS/GxQ35fgiCpZglXyzAek9Ffe+JzSMAThWwD
         mVgsET8J3et7k5/L4Vv1lK8GZZGGStXR1hcKeygxQeYav1mxe31xslz1GARlL3kIv+4h
         AfvpZMGeh85UZ7PrGf9ftb2MUKIEXlbFAMhBylX5lh7axoHoolJmxjyCEkZU5y15AxFz
         iEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143388; x=1685735388;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQnhfgsaak1oIY6R7PWjZvmrvBgyS/heQqBnG1O9VYU=;
        b=H6dRDenx6OAPnBxaQPyK9SM3RHhNVrskd3SqLVwvxt37YoERjIzPfF6nIuQ7zPPzdf
         yKLHDUyraIZQXQNsjAQL1vubgIvYPmlxKqZTQ5PeiFYCxBCNWAWgUfuLHajOt0MofT6V
         gre1S6b4B5kr1/mx0sSErHN8bb8UkaS07cluq/ZyGyzLReCh/xS+Vlrt3fmyJNsfBr3L
         QwL+OwPvyQLk06nOPWG8bu/EESetwkxIXiyPHCVHqwqs82hDRyE5Ndu3akfC/R6HgCSH
         Tk9ie2tPj19eUarg4boAxmLZb4j1MdyWOSOqUOEoj/QRBNrYQB4TElvonCAGxDXCbrq2
         ULrA==
X-Gm-Message-State: AC+VfDx7x1koyN+dW1EDaEjsSYgVgMqZ4oEK3Zx1Xmd/5+KY8Px43rCu
        KRxLkCdySJFTbzFJPGqi6VP/aXwZj3k=
X-Google-Smtp-Source: ACHHUZ6sune5voLhybR8FXb5eGfgmR6iC8kr+fVuipzJwf7q4hn0iN0IzAAtW/8f+hP5thYp3tXJbA==
X-Received: by 2002:a2e:9106:0:b0:2a8:a859:b5c7 with SMTP id m6-20020a2e9106000000b002a8a859b5c7mr320839ljg.0.1683143387446;
        Wed, 03 May 2023 12:49:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9d16000000b002ab59a09d75sm2553825lji.120.2023.05.03.12.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:49:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g>
Date:   Wed, 03 May 2023 22:49:46 +0300
In-Reply-To: <xmqqmt2lqofb.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 11:07:20 -0700")
Message-ID: <87ttwtci05.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> No problem from my side, but are you sure?
>
> Absolutely.
>
> I've seen people just say "we document a failed one" and leave it at
> that, without attempting to fix.  I am trying to see if pushing back
> at first would serve as a good way to encourage these known failure
> to be fixed, without accumulating too many expect_failure in our
> test suite, which will waste cycles at CI runs (which do not need to
> be reminded something is known to be broken).  I will try not to do
> this when I do not positively know the author of such a patch is
> capable enough to provide a fix, though, and you are unlucky enough
> to have shown your abilities in the past ;-)

Thanks for the credit, but as my recent attempts to fix 2 obvious
deficiencies in Git CI (one of them being my own) failed quite
miserably, I figure I have no idea how these things in CI are to be
treated, so I prefer to leave a fix to somebody else, who actually groks
what makes sense in the Git UI, and what doesn't.

That said, in case you still need the test with expect_success, below is
one rerolled.

Thanks,
-- Sergey Organov

--- >8 ---

Subject: [PATCH] t4013: add test for "log --patch --no-patch"

--patch followed by --no-patch is to be a no-op according to the "git
log" manual page. In reality this sequence breaks --raw output
though (and who knows what else?)

Add test case for the issue.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759f..32907bf142fc 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -457,6 +457,17 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+# This should succeed as --patch followed by --no-patch sequence is to
+# be a no-op according to the manual page. In reality it breaks --raw
+# though. Needs to be fixed.
+test_expect_success '--no-patch cancels --patch only' '
+	git log --raw master >result &&
+	process_diffs result >expected &&
+	git log --patch --no-patch --raw >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&
-- 
2.25.1

