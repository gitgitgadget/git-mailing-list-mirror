Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FBEC77B7F
	for <git@archiver.kernel.org>; Fri,  5 May 2023 16:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEEQbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjEEQbH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 12:31:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9126B7
        for <git@vger.kernel.org>; Fri,  5 May 2023 09:31:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so1783976a12.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683304266; x=1685896266;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XVF3Qr6Fv/hYW9BASWNIJ50HRujaAbpLJ8t42h233d8=;
        b=VdKS7jMD+AGghmN+2wAvA3inZrZSgGb7RdTNJ8otKYH3TL/LKO7lMnqtmaRdvb7GdB
         Ks7WjZos9Wze4PGVaWugAetoflv3sLSWdGCAB7UhvuN45jiMucVrh3jVQeNe0S3yXAPR
         6FIoQTK2DTyi7UBOl0O6hQAawA2NvNRDxxM1rsRzeT6xgJ6tvSGKBiVVGH2dwpdF7AXZ
         FdCK4CEePrYhyT/Vm+WA7rBAEAuKYezhtJdJzuue4DipXKGNd2hthVTC3HBNULje7DYE
         B3L5zOX2rFEy+CNTD2WOCOlE760lU3s4t7PGTJU+cb/2lOgu9so40kgOikiqqXMfFsG3
         ColQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304266; x=1685896266;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVF3Qr6Fv/hYW9BASWNIJ50HRujaAbpLJ8t42h233d8=;
        b=A5b/HU4i/ePbW9PXTB5kHEm+07J5NoaU22m7LbVQUEvbQ9Q9Wk2VyKm1XpJ81LcJCJ
         SM5cvryt1g6sEAToKhyyPMIjZ692UeSCDe2lYWT3jzbvvaN0BmERpMM2XyuMnfzXYkSj
         40xlP8QxS0FYEd4O2zfUTcseqiU0AUc9hVQf1m93Pbaz/hGUIsFEF9z/94HL8/M++Z4q
         salZwgRGcxkBEpB3ZhEXrTzIW9Xc2MZhODdIsYY/L/m4JFHKwDOPp5RH2m2Fybfi6uWo
         yTRvYUZu8WXYRIWfIKsdxco5M//xKW+IQAUIF3VH3kmTHrwjTEgXCDle0S41BBSC6psB
         35nw==
X-Gm-Message-State: AC+VfDxNB/KzP8c8LH5RWo+1t09j2QE+dbVKM8XvUrNpqx7GLaZ2argy
        CGNVxBILc1UXcnGR7sCPyaI=
X-Google-Smtp-Source: ACHHUZ5eqmB3mRXGRsROo3fI6U1xw9vwEhZ/F3akSAltLmalixaQiOssrPkM+/Q9jHCqSIdB5rfVww==
X-Received: by 2002:a17:903:187:b0:1a9:433e:41d5 with SMTP id z7-20020a170903018700b001a9433e41d5mr2318553plg.56.1683304265643;
        Fri, 05 May 2023 09:31:05 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm1969837plz.227.2023.05.05.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:31:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: fix behaviour of the "-s" option
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
        <xmqqjzxnixqr.fsf_-_@gitster.g> <xmqqfs8bith1.fsf_-_@gitster.g>
        <87sfcbyy8c.fsf@osv.gnss.ru>
Date:   Fri, 05 May 2023 09:31:04 -0700
Message-ID: <xmqq8re2g2pj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>  * Whenever we set DIFF_FORMAT_FOO becasuse we saw the "--foo"
>>    option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
>>    given), we make sure we drop DIFF_FORMAT_NO_OUTPUT.  We forgot to
>>    do so in some of the options and caused (2) above.
>>
>>  * When processing "-s" option, we should not just set
>>    DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits.
>>    We didn't do so and retained format bits set by options
>>    previously seen, causing (1) above.
>
> Sounds good to me. Doesn't this makes DIFF_FORMAT_NO_OUTPUT obsolete as
> well, I wonder, as absence of any output bits effectively means "no
> output"?

Not quite.  The latter is not "set 0 to output_format word", but
"set 0 to output_format word and then flip only NO_OUTPUT bit on".
I've written a bit more on it in a follow-up message to the patch.

Thanks.
