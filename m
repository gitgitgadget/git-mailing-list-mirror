Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D58EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 13:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjFTNX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjFTNXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 09:23:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612E213A
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:22:54 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5700401acbeso51216247b3.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687267373; x=1689859373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3wsB9SLKmUwT5mQoYHq/+3aIgWp3P3ocEhBeHXCsXA=;
        b=X8Tz27yBErPih40BsQ6J750MDFbNHpiMEbmnXBLMPF60rL27xJtig3rA/BhbsW8pk+
         8PNy6EHQnwou5vnGrSWLQ20xV54zAUEkQqeQ8zNZ4l8VU94xA2OG0SHYepNV/9h9CZcS
         IP/9rAbKPHXmBFZzRkzmF6NeYhJa6B+6Z0MyI7mJC6hxfdGy+lHaf76WhAzRDfa1TTCe
         0uXcdlxzlv6pu9h845x5QzAvMW5sTYOik4I6iy3Cn/MpSIk7EZMU8CvJFjMDNwRa4oQl
         WsCrWs6f34w6XmwqfcID8CF8VoAMB2WsXoSHy9eBGwDtxk+yxMvFuXOR7EEGqNHv0jCX
         hG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267373; x=1689859373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3wsB9SLKmUwT5mQoYHq/+3aIgWp3P3ocEhBeHXCsXA=;
        b=I0VAsTpJeJpIeH5g2kN6DXUxJ8MGN6PH1qRY7kzqLGWZCTsuyqtYqMjzjhM1lx47OH
         BZS5thZ7Pq3tgXYAIqEXYsxg4QqSqovsImPT+KLX31Ty69lyEa8Cxn1/Cesvd8Ogohy8
         uPUmlLZ3FmmSfl4r3hHPSMRwOtBq+KGc7TzRe8nbxBvXFfZOoair4L7oQeIOzPJFBM/5
         vGH7sruKlx4Ap3zGmvwqTTfQqdW9sv4RVpbJuoHBoIaDxlwLZtMtn3oz2hmns/rP6MBO
         wX5AcErq38ZleU9iGP+5B6oO7fYAqHp+za9ildjlwLApkJ2c3m24tM0bpyU2/xBQq79A
         5NTg==
X-Gm-Message-State: AC+VfDzUZuTWBfib7KuYxuRUvVLLYoJnsgUgH44lucPTp0Be0LKD4DvP
        SJxkx4LfAEab5snH6Ut30Ujs
X-Google-Smtp-Source: ACHHUZ5y3Q92uilmeHMnF3greCuCYyZuSnd6Z/G1U/MkIemUG52H2572+1zuctU4WnQzuCDkh69gnw==
X-Received: by 2002:a81:7308:0:b0:568:8fa1:7a3 with SMTP id o8-20020a817308000000b005688fa107a3mr12261036ywc.5.1687267373051;
        Tue, 20 Jun 2023 06:22:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e8fd:3e8c:8558:4cd? ([2600:1700:e72:80a0:e8fd:3e8c:8558:4cd])
        by smtp.gmail.com with ESMTPSA id p190-20020a0de6c7000000b00568904cc9dcsm490974ywe.18.2023.06.20.06.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:22:52 -0700 (PDT)
Message-ID: <6ab75484-5893-691b-e40d-b4305c889081@github.com>
Date:   Tue, 20 Jun 2023 09:22:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/4] gitformat-commit-graph: describe version 2 of BDAT
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com>
 <a3b52af4c96db9a8164119e8ace0541db47b6815.1686677910.git.jonathantanmy@google.com>
 <xmqqlegn3tz3.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqlegn3tz3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2023 5:58 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:

>> +	in Probabilistic Verification". Version 1 bloom filters have a bug that appears
> 
> "bloom" -> "Bloom", probably, as the name comes from the name of its
> inventor (just like we spell "Boolean", not "boolean").

The ultimate recognition comes from when the term named after you
becomes lower-case ("boolean" is sometimes in this category, but
definitely "abelian" is an example).

In this case, you are right that we should capitalize Bloom.

>> +	when char is signed and the repository has path names that have characters >=
>> +	0x80; Git supports reading and writing them, but this ability will be removed
>> +	in a future version of Git.
> 
> Makes sense.

I also like how you organized this: "We support version 2. 1 is
still around but not for long."
 
> I wonder if we want to mention what the undesired misbehaviour the
> "bug" causes and what we do to avoid getting affected by the bug
> here.  If we can say something like "When querying for a pathname
> with a byte with high-bit set, the buggy filter may produce false
> negative, making the filter unusable, but asking for a pathname
> without such a byte produces no false negatives (even though we may
> get false positives).  When Git reads version 1 filter data, it
> refrains from using it for processing paths with high-bit set to
> avoid triggering the bug", then it would be ideal.  Or "When the
> repository has even a single pathname with high-bit set anywhere in
> its history, version 1 Bloom can give false negative when querying
> any paths and becomes unusable.  You can use $THIS configuration
> variable to disable use of Bloom filter data in such a case" would
> also be fine.  The point is to give actionable piece of information
> to the readers.

This is definitely helpful, but if someone is having issues we
would say "try version 2 and see if it still happens" and not
over-index on the underlying reason.

That's to say, I'm OK with the shorter description of the problem.
Feel free to expand if you're interested, though.

Thanks,
-Stolee
