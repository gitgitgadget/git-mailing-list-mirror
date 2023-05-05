Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE322C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjEERHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjEERHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:07:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8518DC7
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:07:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f14e499ffcso498510e87.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683306460; x=1685898460;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3H9X3g2gPxxqFCY+19cOG9CHNj60Va1isVphUHRlFo=;
        b=rLp3qrEKe22uv2cr5CJRzy/HyxF2a1q7bqBjKAL7mB+AnCY+7n9U/tx0AIJTMmW2k3
         XszlSr1DgGWHDBHSBUQckedHPCJKIrq1CSkwXmD4wT42MwZnRwizf0hEJ7wPRcNtNfRw
         p2l8wws8BBzVyrxMuAQTXS97A34olKeBE+ANoD9HDmCxhYKKKXZL8pheqvTi5z9mwNKe
         gaGxh9PUc+8AA/zoO31GCuqnE0YaO9fN6qp1ARXWcirVP0t1yQ9nG+cwvPs1nZbOGOFd
         ICu57ErxrFMJRk/twsqRIzOhAdCySCQsX2xd/4wImnvii0qU+bLI1QHt4vXI6GD37BVZ
         8GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683306460; x=1685898460;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3H9X3g2gPxxqFCY+19cOG9CHNj60Va1isVphUHRlFo=;
        b=MJmHmVZby0thwoscQMJogQmOnU0v1cs0G+7NDEOowE6Pyu88+2hfXmxExWrSuC9HBF
         W+h830suBqGpVxwsMD7cU5Q1hajZ6Z27q6h+eB73KIbku3d5dbSrfw816Is3eJ0lKKOw
         dQlCkpYr6VeVsiivNsOtaZn63+KIKU/C65imxo/Q+nNzJYcyPZ8kWj81aAXb48gYUdfV
         gt9+KXmJGsCst+wIf/LYhqY2elhiOKiKgxWvsY+3vEzztmhnxQBRs8sNP37vj7JqwQHi
         puwQKoCdbU66JLrTSILQLMPW8u9nlxJqd0LQIaZaRRkVNaOs15e+IqSyp969F2W1Up65
         zxxA==
X-Gm-Message-State: AC+VfDzJtaddb1CuNd9HL92jjXxBmbQLobXk0caRAozvBPC2fgl7IANq
        lM18xYMxBKIIhzuEn00p1nTg748McWw=
X-Google-Smtp-Source: ACHHUZ5Pyw8+RZ+U5IvWIl/FUYVQEULJ6GN3mP6uWhqbgZf4zO+f45BpJVNdjJoV/19/vDHAdoYw2A==
X-Received: by 2002:a19:7412:0:b0:4eb:c12:df1c with SMTP id v18-20020a197412000000b004eb0c12df1cmr641566lfe.65.1683306460269;
        Fri, 05 May 2023 10:07:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b004e845b49d81sm355438lfl.140.2023.05.05.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:07:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: fix behaviour of the "-s" option
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
        <xmqqjzxnixqr.fsf_-_@gitster.g> <xmqqfs8bith1.fsf_-_@gitster.g>
        <87sfcbyy8c.fsf@osv.gnss.ru> <xmqq8re2g2pj.fsf@gitster.g>
Date:   Fri, 05 May 2023 20:07:38 +0300
In-Reply-To: <xmqq8re2g2pj.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        05 May 2023 09:31:04 -0700")
Message-ID: <87h6sqzoyt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>>  * Whenever we set DIFF_FORMAT_FOO becasuse we saw the "--foo"
>>> option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
>>> given), we make sure we drop DIFF_FORMAT_NO_OUTPUT. We forgot to do
>>> so in some of the options and caused (2) above.
>>> * When processing "-s" option, we should not just set
>>> DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits. We
>>> didn't do so and retained format bits set by options previously
>>> seen, causing (1) above.
>> Sounds good to me. Doesn't this makes DIFF_FORMAT_NO_OUTPUT obsolete
>> as well, I wonder, as absence of any output bits effectively means
>> "no output"?
>
> Not quite. The latter is not "set 0 to output_format word", but "set 0
> to output_format word and then flip only NO_OUTPUT bit on". I've
> written a bit more on it in a follow-up message to the patch.

Yep, I've noticed that post after I sent the question.

Thanks,
-- Sergey Organov
