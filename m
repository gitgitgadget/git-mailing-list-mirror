Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD8C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 18:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAPSmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjAPSmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 13:42:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B24298F8
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 10:35:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jn22so31108080plb.13
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8abCDpS7EZvDRBi4o6EbsdOWD88SJ8Vq4/Fngl3QaY=;
        b=I4T6oCfv1kuduxOcwFjMMRcQE8SXuvwpMv2NZT4yO8qwcPCaGvXwjAOMnajriOHmw5
         Vs5lkbeTR/ddPc2bZxP+RSn5jA0HRCwJx7Zb0oiKuGeZcXo3ZzriwDL+Rb3KJN0kawCk
         mLC1mNyGAZEf8I1DDevBGuJzJQI3xECh2vLo1KgbwmcIsKE6kPkpeopHxe25cgfToJcb
         YTpnQi0o6e/CHZ4952mE4j1fOh1vyExiz2ujuukp9ecrzfAr62vQWADgmEUIp4ZlD/GZ
         jlxSsdsBEAD6xAJLPUCpXpfZJdH8YxnHxoavmYfzM7wP2K044JlKKdTNkc7vT83og9bD
         q39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y8abCDpS7EZvDRBi4o6EbsdOWD88SJ8Vq4/Fngl3QaY=;
        b=s+JK95Smbjf3DFnexAxVbK8yL4B6ZE9zILm4YIDo8Rvw3qLjMwpPVb2NrwhN5oDiH4
         SRb12vLGoLbtHSXpHdmAF9EUXCnytgzKN2SMrMoka6XMA+xbLxgdQbf19XNlc2BTPApd
         Lz6VapvHBQ8K2s6f25aiey9fCMRTQnAAYDjQri39AVTvVdxkL0O1Z6N1+PCO4GmHGndP
         gFbjxICUaWNfZ7VOug3ZJl5JbAmZTjrb74lYOiP6gVYvXiTX/v/bXRPUEMxxFsyq/qto
         iXE1dy2yykE0UrSxpQxWRA1h2rWUQaVMWMidQE+4PMAcGbAoNDBHHjoT78FZJYAqNp1F
         8Eww==
X-Gm-Message-State: AFqh2kp+zcfVLHfNSJGkwQ+6799vEQ/OUd+CGI9hy23YNEcoBA7QCAbt
        vM0xLaSrAb53gczgiH2E21c=
X-Google-Smtp-Source: AMrXdXvCKhi7JXJu/6HHHYD/Do3k4757t+5vUl97vjKMIiQBwmA7ot+7BP/rvhM2TRQPNzeLXlZBog==
X-Received: by 2002:a17:903:40c4:b0:194:7ca9:70a7 with SMTP id t4-20020a17090340c400b001947ca970a7mr742287pld.3.1673894154129;
        Mon, 16 Jan 2023 10:35:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b00192fdd3af5dsm19625767plx.181.2023.01.16.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:35:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: unleak "-v <num>"
References: <xmqqv8l8gr6s.fsf@gitster.g>
        <Y8WJnGHs5nM5GwBM@coredump.intra.peff.net>
Date:   Mon, 16 Jan 2023 10:35:53 -0800
In-Reply-To: <Y8WJnGHs5nM5GwBM@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 16 Jan 2023 12:30:04 -0500")
Message-ID: <xmqqpmbecoom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jan 15, 2023 at 12:03:39AM -0800, Junio C Hamano wrote:
>
>> The "subject_prefix" member of "struct revision" usually is always
>> set to a borrowed string (either a string literal like "PATCH" that
>> appear in the program text as a hardcoded default, or the value of
>> "format.subjectprefix") and is never freed when the containing
>> revision structure is released.  The "-v <num>" codepath however
>> violates this rule and stores a pointer to an allocated string to
>> this member, relinquishing the responsibility to free it when it is
>> done using the revision structure, leading to a small one-time leak.
>> 
>> Instead, keep track of the string it allocates to let the revision
>> structure borrow, and clean it up when it is done.
>
> FWIW, this looks obviously correct to me.
>
> The word "unleak" in the subject made me think about UNLEAK(), so this
> is a small tangent. This is exactly the kind of case that I designed
> UNLEAK() for, because the solution really is "while you are assigning to
> X, also keep a copy of the pointer in Y to be freed later".

Yup.  I was originally planning to use UNLEAK(), but it felt ugly to
UNLEAK(rev.subject_prefix), as it stores borrowed pointer sometimes
and owned pointer some other times, which is the exact reason why I
started looking for a clean way to plug this leak.  So I ended up
with declaring that the member should only store a borrowed pointer.

> And UNLEAK() is just "keep a copy of the pointer in Y to know that we
> _could_ free it later". And of course "do nothing if we are not
> leak-detecting". But since we seem to be moving away from UNLEAK(), and
> since it would not even save any lines here, I'm perfectly happy with
> this solution.

The first sentence needs to be rephrased, as it does not make much
sense to have something usually be X and always be X at the same
time (I'd just remove "always" from there).

Thanks.

