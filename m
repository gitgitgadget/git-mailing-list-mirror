Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA605C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjECQ5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECQ5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:57:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC555AD
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:57:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6436e075166so166242b3a.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683133037; x=1685725037;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zbbwzX8ipK4V4HcOlTiT+Aji/muOp4XeHbRsesbbDQ=;
        b=oGKtvkasMoi711s+a4scB6j29lMdsAHTu1GHaaa5dFAzl7FAQRcS9dFHwylECoHarG
         ATl8WajkiH3gzWe0SxsDAs3yzUQMduY8LFAhlZlU1kRRWWgPgDOfVnmvua2oY/QpOz7Q
         kuugB/pD7a1h0U5RrWn0T59xkxJ5Sb3HjexL3GSRV8LwGTEckwnlHk3D5OH4JzJ3irvV
         goWo4Rmufot7fFl6WRof8eJZW/lS28nOKa8qyJjEsM/9dlQYKrTxIbR420jfS90wZj74
         LCulwwADcZCCbZiSJj8SXTdL6qXAKVQOQ8kNPOQir2r4g+x7L0gqv7eOo4CpPhAy4Dzv
         PRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133037; x=1685725037;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7zbbwzX8ipK4V4HcOlTiT+Aji/muOp4XeHbRsesbbDQ=;
        b=T6Q3sm5E+Oa9mS7CDIYKQwk9ygTOKe36kwK/vwA70yCkWrxVpa79+vrXhSnbdxO6Vm
         vXyJd1O5/w37Y+Pygu4NGSmBR4Uwu5l16W0ryWzSM8cUDGBdcJ58X3kqvEcHP9m7sChS
         HG6vzSnN84v3ft35EpJhG5h60jiHXdIxb9bTiuf5kS5WRGk+WgpduXYql5FQgja4z4rA
         jE9oQSErsstLlWboHpTqsDCMgwwlJ06WhvlRnbOI6HKTOs9t2+COO2VKBrUruVW/jbIw
         8Ay9njU05KauATsexbfqt0KGxnDBazpXB8Aa8xsaWvvylsnBbH9gnRxh1i49O7O59o7C
         cQsA==
X-Gm-Message-State: AC+VfDxa+gFtjGSekUl0bOk+0Aq1PWvRXOZnTTgRvcpulrUJXkNZTQgx
        2FOXj1Afg+DiuyD6tausOuE=
X-Google-Smtp-Source: ACHHUZ7pC6V7BRMn4hI4RUcjHyGipA1uZHfnJyUJ+tNg5ySfwOBTscZpgatbdFfhC+fHDAOb9Fdafg==
X-Received: by 2002:a05:6a20:6f06:b0:cd:5334:e25e with SMTP id gt6-20020a056a206f0600b000cd5334e25emr20737440pzb.17.1683133036563;
        Wed, 03 May 2023 09:57:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w22-20020a63f516000000b0052873a7cecesm2916444pgh.0.2023.05.03.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:57:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
Date:   Wed, 03 May 2023 09:57:15 -0700
In-Reply-To: <20230503134118.73504-1-sorganov@gmail.com> (Sergey Organov's
        message of "Wed, 3 May 2023 16:41:18 +0300")
Message-ID: <xmqqsfcdtkt0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> --patch followed by --no-patch is to be a no-op according to the "git
> log" manual page.

I briefly wondered if it is a bug in the documentation.  But it is
clear (at least to me) that "git log -p --stat --no-patch" wants to
show only "--stat", and when "git log -p --raw" shows both patch and
raw, I do not think of a reason why "git log -p --raw --no-patch"
should not behave similarly.

> Add a test_expected_failure case for the issue.

That is unsatisfactory, though.  Can you back-burner it and send in
a fix with the same test flipping expect_failure to expect_success
instead?

Thanks.

>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  t/t4013-diff-various.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5de1d190759f..f876b0cc8ec3 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -457,6 +457,17 @@ diff-tree --stat --compact-summary initial mode
>  diff-tree -R --stat --compact-summary initial mode
>  EOF
>  
> +# This should succeed as --patch followed by --no-patch sequence is to
> +# be a no-op according to the manual page. In reality it breaks --raw
> +# though. Needs to be fixed.
> +test_expect_failure '--no-patch cancels --patch only' '
> +	git log --raw master >result &&
> +	process_diffs result >expected &&
> +	git log --patch --no-patch --raw >result &&
> +	process_diffs result >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'log -m matches pure log' '
>  	git log master >result &&
>  	process_diffs result >expected &&
