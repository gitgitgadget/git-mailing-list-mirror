Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81764C6FA81
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 17:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiH2RUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 13:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiH2RUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 13:20:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6CEE0A6
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:19:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so3892847pjj.4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Rq5xaKuoM3ff5RPjLRAOM3HrTmXyMOgLmNNxaolMioI=;
        b=Qz7sQYynZy0VDu+0om9ANNzcelr16IHvusZWvv3FdvfQsdEBin/Zv5ZlOjoxF4brAZ
         TZrQrhuk/9MkgoFZx8mZEG79a5YTqGwPR92iIPWbQ/+Fq4SSlPNjLPNJI+6Z4VNu1fMY
         SpI8PP1aKYA8FFukRQhfXkN0P8uHZyGenL0nWuLEP0kZHHgRC8pda7xyafe8lnOX3cWm
         /wNWAvUsqQ42J9W2DxXQB/YBPlhneFGpP0LMVySnimpbdb2FhO7cXGXz4QydXMzNPvzt
         TLFIix4ZuSaXSlOUxg6RREVDu4YgPstQhzYVT5kx8cQDaZ5gkWKBqH3um75bBgRlL6ZA
         HOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Rq5xaKuoM3ff5RPjLRAOM3HrTmXyMOgLmNNxaolMioI=;
        b=ablnj3/KsbwCEEbhYx9CopeM8AavsvwDNhCSC3QmbUPaYU7OPBtr4fI+HHQ7ohjvhO
         LCS8tUkQhXJqDzYKRM/X7sHDrdPZg7aoCVZzax2Lpurhktds8vIysgokMA0lQm8d/OpJ
         lcNStVuiEnntvMz4+04Ji1D/DVqzI8IjeGXPUb6bsJB9MjmfzwVi4MWPXZxZzDrMISI/
         dI/KEjsPvfloRFsWecZz+01KH/C2bf9lryglQQs4ZAXOkYaHgnoPiB2cMTXx8P1Qctdt
         rv1vzgfHWNt93fPmmAJXAFBOa+qQDY9hqjR8l4A/IgDVqt6Qaeodv9okFiC+o7Xk3TeH
         aFnA==
X-Gm-Message-State: ACgBeo0PKfBJk5SEdqwUQz5b6fHMhVhKRaYFvoIhdn4IPa/jBDrZnLS2
        OzpjNXuSjPWWEbT37uAGOVk=
X-Google-Smtp-Source: AA6agR6acxFUhZUpm1Nvhne3pbGJak6gAEwlNa9owepoQEwvln4fTjJlyWFHZEmoeJb9wHsxJsU2wg==
X-Received: by 2002:a17:90a:aa08:b0:1fd:8016:29f1 with SMTP id k8-20020a17090aaa0800b001fd801629f1mr14210895pjq.23.1661793596147;
        Mon, 29 Aug 2022 10:19:56 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k27-20020a635a5b000000b0042aca53b4cesm5456891pgm.70.2022.08.29.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:19:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 3/4] add -p: handle `diff-so-fancy`'s hunk headers
 better
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <9dac9f74d2e19899b3e6c1d28e83878ded4469d6.1661376112.git.gitgitgadget@gmail.com>
        <xmqq5yibqxs0.fsf@gitster.g>
        <0q0psp09-8993-96r6-3r90-q4s368p98510@tzk.qr>
Date:   Mon, 29 Aug 2022 10:19:55 -0700
In-Reply-To: <0q0psp09-8993-96r6-3r90-q4s368p98510@tzk.qr> (Johannes
        Schindelin's message of "Mon, 29 Aug 2022 15:32:24 +0200 (CEST)")
Message-ID: <xmqqilmbotl0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Here is why: in the _regular_ case, i.e. when we have a colored hunk
> header like `@@ -936 +936 @@ wow()`, we manage to parse the line range,
> and then record the offset of the extra part that starts afterwards.
>
> This extra part is non-empty, therefore we add an extra space.
>
> But that part already starts with a space, so now we end up with two
> spaces.

In other words, this breaks because the original code depended on
having the extra whitespace before the "funcname" part.

Stepping back a bit, if the final goal for the UI generation out of
this string is to append the material with a whitespace before it
for better visual separation, then the original should probably have
(at least conceptually) lstrip'ed the leading whitespaces from the
string it found after " @@" and then appended the result to where it
is showing, with its own single whitespace as a prefix.  It would
have prevented this bug from happening by future-proofing, and made
the final output nicer, as any excess whitespaces between the " @@"
and "funcname" would have been turned into a single SP.

The "prepend one iff it does not already begin with a whitespace" is
a (at least mentally to the developer) less expensive approach that
is fine, too.

Thanks.
