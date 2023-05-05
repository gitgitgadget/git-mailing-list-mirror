Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B2C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 08:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjEEIde (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 04:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjEEId3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 04:33:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A318FDD
        for <git@vger.kernel.org>; Fri,  5 May 2023 01:32:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so1720486e87.2
        for <git@vger.kernel.org>; Fri, 05 May 2023 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275573; x=1685867573;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUJTMuYTYbXU7sgyl8yC5udp2j8CWnASUSFPtbJFEvc=;
        b=jj/iJ0DsdAfjiFvYwITxBiSALuEMjjDE4sc1LHUS3VuNaXwKe0XKMA3DwNSS2N0ejM
         oI9/0dqYSt0JNXxO18IyamqGsdX3gLkWGW8XQX4OJWsDeFwuGSLUNxaS5trrKD/EYxdz
         P8iEoTO586j2gU/uNPFDCF1IywMPdmDUQfsgoEKcuCk9AQ3i4td/xFAW+ZBGLmh+UpV4
         XjemoekFFDMN6ehkq7nPER34N2mtsguG6/RZFAA4klC+HIh5j8ZsvArv/2quF5tXBX5V
         f74q0l2MOeXnHe675s7OwzKGq/7kSPkLKmo+SZu/2kUnys8+lcLAulX7F9rf2dO6HJbt
         nrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275573; x=1685867573;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUJTMuYTYbXU7sgyl8yC5udp2j8CWnASUSFPtbJFEvc=;
        b=V2jdxFpRjMGgFkvREDWyMIxttNIMRghzgmlsk+7hEXpYN6mxA4kwE6dHoYH1KzFVX9
         aiUjsX810E/eL1Wfa9TfuzOX2PTktId3XA5ptrRQT8x+lCbOr5fMH/VfIDZt0w7gxr5k
         fA/lzSnV1KwfaHesRT77xRfsHHFMhZsSIE/+PQfg199E4QmfCpBwiYn/XKaPvHZsW4hz
         G7sl+KUmwOGQTVVeBW99CiqsE0KgCWmlBwQPGHnhrm1UbNO2PrZnqstKdvgT9aFHwbTV
         1FPPu9OtAuJ8zDTNaxaSY7YaZR5E1wcgcBX8sFO6EbqVGwXfzLodkIMz1Y4TpBjekUBN
         MvJQ==
X-Gm-Message-State: AC+VfDxAvNlR2RbyvRYigh7VnCJl1EpXCx+5FSaA3P0aHwWexzt0ppHl
        O/vDSWJvI7QK0JCSOcTEQVp31+oOF4U=
X-Google-Smtp-Source: ACHHUZ7Z19VuXAFRxJ01kaWniqpESG4sP2Vz9q9to2fukYyST1xTrGYfyUzcxp8ngyBakkE3VTRvGQ==
X-Received: by 2002:ac2:51da:0:b0:4dd:a019:d845 with SMTP id u26-20020ac251da000000b004dda019d845mr335715lfm.18.1683275573370;
        Fri, 05 May 2023 01:32:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d13-20020ac241cd000000b004eff3050e24sm200796lfi.125.2023.05.05.01.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:32:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: fix behaviour of the "-s" option
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
        <xmqqjzxnixqr.fsf_-_@gitster.g> <xmqqfs8bith1.fsf_-_@gitster.g>
Date:   Fri, 05 May 2023 11:32:51 +0300
In-Reply-To: <xmqqfs8bith1.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Thu, 04 May 2023 16:10:02 -0700")
Message-ID: <87sfcbyy8c.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I haven't run any tests (not just your new one, but existing ones)
>> but ...
>
> And of course, not writing tests fails to even realize that the bug
> has two components, "-s" failing to clear the bits previously set,
> and other options not clearing the bit set by "-s".
>
> This version may still be rough, but at least the full test suite
> has been run with it, so I have a bit more confidence than the
> earlier one (which may not mean much).
>
> ------- >8 ------------- >8 ------------- >8 -------------
> Sergey Organov noticed and reported "--patch --no-patch --raw"
> behaves differently from "--raw".  It turns out there are a few
> interesting bugs in the implementation and documentation.
>
>  * First, the documentation for "--no-patch" was unclear that it
>    could be read to mean "--no-patch" countermands an earlier
>    "--patch" but not other things.  The intention of "--no-patch"
>    ever since it was introduced at d09cd15d (diff: allow --no-patch
>    as synonym for -s, 2013-07-16) was to serve as a synonym for
>    "-s", so "--raw --patch --no-patch" should have produced no
>    output, but it can be (mis)read to allow showing only "--raw"
>    output.
>
>  * Then the interaction between "-s" and other format options were
>    poorly implemented.  Modern versions of Git uses one bit each to
>    represent formatting options like "--patch", "--stat" in a single
>    output_format word, but for historical reasons, "-s" also is
>    represented as another bit in the same word.  This allows two
>    interesting bugs to happen, and we have both.
>
>    (1) After setting a format bit, then setting NO_OUTPUT with "-s",
>        the code to process another "--<format>" option drops the
>        NO_OUTPUT bit to allow output to be shown again.  However,
>        the code to handle "-s" only set NO_OUTPUT without unsetting
>        format bits set earlier, so the earlier format bit got
>        revealed upon seeing the second "--<format>" option.  THis is
>        the problem Sergey observed.
>
>    (2) After setting NO_OUTPUT with "-s", code to process
>        "--<format>" option can forget to unset NO_OUTPUT, leaving
>        the command still silent.
>
> It is tempting to change the meaning of "--no-patch" to mean
> "disable only the patch format output" and reimplement "-s" as "not
> showing anything", but it would be an end-user visible change in
> behaviour.  Let's fix the interactions of these bits to first make
> "-s" work as intended.
>
> The fix is conceptually very simple.
>
>  * Whenever we set DIFF_FORMAT_FOO becasuse we saw the "--foo"
>    option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
>    given), we make sure we drop DIFF_FORMAT_NO_OUTPUT.  We forgot to
>    do so in some of the options and caused (2) above.
>
>  * When processing "-s" option, we should not just set
>    DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits.
>    We didn't do so and retained format bits set by options
>    previously seen, causing (1) above.

Sounds good to me. Doesn't this makes DIFF_FORMAT_NO_OUTPUT obsolete as
well, I wonder, as absence of any output bits effectively means "no
output"?

Thanks,
-- Sergey Organov
