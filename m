Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA0C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjEIR6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEIR6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:58:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC04483
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:58:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so42829975ad.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683655114; x=1686247114;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jH6R08BXYtkCRLaYBHGXJJ/dXOuedIeLqDHrF88pC68=;
        b=S0U4GNFyKcn7JwalFsjife5aaCgTSaiS5MwihfkY4rx7O+/uJ/hIMBeq/6D7oWxo/0
         r/RKhCe9nyf1ySCn75MxsPTg+uvNiSVvDxdqVdkoiBUPH+VwpE0g1UEUS/oWtxFJIH3K
         E5wC0L4ouvhB54WL2bCo0FCo/Bj65Tm1HL8VsjAK8hcalcUw9dWTltGOwvqcLsGvRT9A
         GkC3CRrZmWm0bz03Mt2owCZmlQhNGNDOi0JJ1poFDFMEsHkV1FqtJ61ctB5cBRRrqI4T
         7NCmE6zb8aXbs7a/KOmwzP/k0oHLWtythYhva/d1cpOuiTnHBlIk9kYKDfVEluuaAcg/
         5gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655114; x=1686247114;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jH6R08BXYtkCRLaYBHGXJJ/dXOuedIeLqDHrF88pC68=;
        b=kImnN+S+CmsFayKe/8fmFmq+gRKqkO7RIkBUHh8x6noWLs7hkbi68eoYLqWWnj8Oq6
         Wm48QTG5v4gbOCyGXgfbXFmplTLTLQk67qOnO0HLtHmQoFBP/7o0y7CX+6NNOTQdt6g/
         a0gdnJBEtQdtas0XA7HIVjwLw2RDdJSt/eoAbQCRqI4Zkr7PtAP75f1EP2Ou8k0pytiv
         Wfjuk/Em2SI1H3/3WzwIshAR4kBlxpv/H+25/DzJJkpzNZfwd95sPHP4iI8GPTPKAYld
         GLzeBvCOu99UcKDyyXWkVJ6RYNzd9yqkxwQ0Z/ZoZejR61TQwf0B13ehGHC2ZEWux/9C
         JvwA==
X-Gm-Message-State: AC+VfDytlTMQZ0MMwEAmD0Z24BhC6XLFldLOTuu1Pn7+RpG1W24PDTNm
        DvWd/MuVdRN3dEYRGoPVM0iRsVSrQRQ=
X-Google-Smtp-Source: ACHHUZ4+q+SZSpkq4f9E9rzRp60pSK9rGLCXV6Mxrl8ePstx9repdtfrN1C35E6d07/0oZrjrOk4dw==
X-Received: by 2002:a17:902:db06:b0:1ac:712d:2049 with SMTP id m6-20020a170902db0600b001ac712d2049mr10533457plx.6.1683655113604;
        Tue, 09 May 2023 10:58:33 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id be8-20020a170902aa0800b001ac897026cesm1894928plb.102.2023.05.09.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:58:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] fetch: add a test to exercise invalid output
 formats
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
        <006ea93afbef8742a823a9444d2b71785a9b4ec3.1683636885.git.ps@pks.im>
Date:   Tue, 09 May 2023 10:58:33 -0700
In-Reply-To: <006ea93afbef8742a823a9444d2b71785a9b4ec3.1683636885.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 9 May 2023 15:02:11 +0200")
Message-ID: <xmqqv8h1xu7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Add a testcase that exercises the logic when an invalid output format is
> passed via the `fetch.output` configuration.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t5574-fetch-output.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

It makes perfect sense to make sure that invalid input gets rejected
and the command exits with non-zero status, and it is probably a
good thing that the end-user sees a message that explains why the
particular input is rejected (even though it adds one more thing
that needs to be updated when the message gets reworded).

But do we need to insist on no output to the standard output stream
when the command errors out?

Other than that, looking good.

THanks.


> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> index f91b654d38..a09750d225 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -7,6 +7,25 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
> +test_expect_success 'fetch with invalid output format configuration' '
> +	test_when_finished "rm -rf clone" &&
> +	git clone . clone &&
> +
> +	test_must_fail git -C clone -c fetch.output= fetch origin >actual.out 2>actual.err &&
> +	cat >expect <<-EOF &&
> +	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}${SQ}
> +	EOF
> +	test_must_be_empty actual.out &&
> +	test_cmp expect actual.err &&
> +
> +	test_must_fail git -C clone -c fetch.output=garbage fetch origin >actual.out 2>actual.err &&
> +	cat >expect <<-EOF &&
> +	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}garbage${SQ}
> +	EOF
> +	test_must_be_empty actual.out &&
> +	test_cmp expect actual.err
> +'
> +
>  test_expect_success 'fetch aligned output' '
>  	git clone . full-output &&
>  	test_commit looooooooooooong-tag &&
