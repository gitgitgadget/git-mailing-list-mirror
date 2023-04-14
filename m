Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A291C77B61
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 01:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDNBjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 21:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDNBjU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 21:39:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8421FF1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 18:39:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-247061537b3so397145a91.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 18:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681436359; x=1684028359;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEI7wjBAn0ERMZQs8XyScf42Uhnj27LOmewVIIkMJa0=;
        b=o3hbzUbTwjKnpMEk6et4d/X42y+amukk5kJyhEjpFiDoCpnX7EVSge+H1GZulF0ocE
         U/iIzQXMeMj3f4QwBsVO6bPjTl6cX8N/EeYcBhvA6P5saCAsr1YDOsur3XkGMItpG6Ti
         ubuoAOCRHEW2+Cx2J7NqDv4EKmGswk/c0apPM/NLifIpWt8S4F3SE0hV3qDCBo7J1tqE
         PZSYx98t30YtjGJamzYFg+rsm6iIdi7ajr71352yOjMquGMxxUWHXXPsaNr8UZhjCfro
         zJFSUtJhi4YMlaNfX6xKI7atGXRrDGuE/rsGr/OdMWYusaSzIXr3qPCk8ei+SB5lTsR4
         aAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681436359; x=1684028359;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEI7wjBAn0ERMZQs8XyScf42Uhnj27LOmewVIIkMJa0=;
        b=BYdMpwsesfjCCXtPbTeVSkXaG3rqs148Fg5llko+tMZEwye6QUdjhpWvXybVLHtUCm
         ilE48mrmmusyrqyRgoXAMm6OjBnZnn5ctSXsrvGSHFsA/wVsW4HhupMTo3XzBmOJOyYc
         5vVkAW2l36rmDthdt3T+JMeZSlq0Jb/1e9EcmFUN7c3acKNPOJwsO4hwTyoRQAQdB0d0
         kQssXw5nItuMHV3a77FxEflOGwL1aSeDKmToyrbfBrzhuT9U89k46GdivppLvWg3XWbi
         BD2gg2bMsozKqFkRyrPhj4L9+8+hAuwZuR8Ur9F1U1wiSrc3d1bDCEmCM4XViIliyhDD
         SB+g==
X-Gm-Message-State: AAQBX9dGo0ogL+8kHKvTLx7sx6C3jEmht2+tlJbiW7IoJvEhvuvr/7+V
        M5jBRFhybN9KUROKl9SI5pA=
X-Google-Smtp-Source: AKy350ZBz3MS9vsTt33bOTCPVPSIPsMdMdnPuSM2wPh7mxeabVMFQW2ipR1i6VpfTv4+0pZGBAof3Q==
X-Received: by 2002:a05:6a00:1a03:b0:63b:62d1:d868 with SMTP id g3-20020a056a001a0300b0063b62d1d868mr2197002pfv.8.1681436359099;
        Thu, 13 Apr 2023 18:39:19 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78c02000000b006395330344esm1984082pfd.29.2023.04.13.18.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 18:39:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] banned.h: mark `strtok()`, `strtok_r()` as banned
References: <cover.1681428696.git.me@ttaylorr.com>
        <1d955f8bc6d2797def516897d019a186e461b648.1681428696.git.me@ttaylorr.com>
Date:   Thu, 13 Apr 2023 18:39:18 -0700
In-Reply-To: <1d955f8bc6d2797def516897d019a186e461b648.1681428696.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 13 Apr 2023 19:31:54 -0400")
Message-ID: <xmqq8revw8c9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   - `strtok_r()` forces the caller to maintain an extra string pointer
>     to pass as its `saveptr` value
>
>   - `strtok_r()` also requires that its `saveptr` value be unmodified
>     between calls.
>
>   - `strtok()` (and by extension, `strtok_r()`) is confusing when used
>     across multiple functions, since the caller is supposed to pass NULL
>     as its first argument after the first call. This makes it difficult
>     to determine what string is actually being tokenized without clear
>     dataflow.

It seems that the only existing users of strtok() are all in
t/helper/ directory, so I personally do not think it is a huge loss
if these two are forbidden.  While I do not see why we should use
strtok(), none of the above sound like sensible reasons to ban
strtok_r().  At best, they may point out awkwardness of the function
to make you try finding an alternative that is easier-to-use before
choosing strtok_r() for your application on a case-by-case basis.

If your application wants to chomp a string into tokens from left to
right, inspecting the resulting token one-by-one as it goes until it
hits a token that satisfies some condition and then terminate
without wasting cycles on the rest, string_list_split_in_place() is
a poor choice.  In such a use case, you do not know upfront where in
the string the sought-after token would be, so you have to split the
string in full without taking an early exit via maxsplit.  Also, you
are restricted to a single byte value for the delimiter, and unlike
strtok[_r](), string_list_split_in_place() does not squash a run of
delimiter bytes into one inter-token delimiter.

One gripe I have against use of strtok() is actually not with
threading but because people often misuse it when strcspn() is what
they want (i.e. measure the length of the "first token", so that
they can then xmemdupz() a copy out), forgetting that strtok[_r]()
is destructive.

So, I dunno.
