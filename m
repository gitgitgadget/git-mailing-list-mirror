Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C38C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 15:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKPny (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKPnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 11:43:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DFE1731
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 08:43:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id px4so6204385pjb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681227831; x=1683819831;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FO2ZTKmru+cnPtWbDaJn7HWwzBrAfGXDlf+uY0QROWM=;
        b=i7L1lStgBHk8xqQulF3AXAKGN5KbO6kbpY8cD/BhDQrkymNsBgGddETMjbuU4m/eEm
         052jj0RlCXTQtbxHB2prV6a7+EeCWpEc3KlCoGczHzEzUHOB6CG1I4KJfF1aiGWNObfK
         0TalVeAdIEF7YyO2zeu10UhoCQk/R1nr1W+m7o9U+Oe++3dhpbWXNu9GgAKE5XBLAwsn
         JBWH19Khq/S9PqVQnp0P6GL0c65JEE/y0bVN1y4+nWIU9b+cVK7njFQAKdIVu3zkJgqp
         YXDpdO/aNxOYKsul8F8E8FhVjq8gnjKXLYkUtTWcnsD/nOxNllWcMB5PtOurCKkxEIfO
         o9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681227831; x=1683819831;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO2ZTKmru+cnPtWbDaJn7HWwzBrAfGXDlf+uY0QROWM=;
        b=1L9jyTTtZSANa4ioOFyI3NIIgP+95eMnEWK19gwVNR/mZAXbCueolwOzc0TOF6Pp+y
         mketzg0mZA1yW+pdS7iPM7z5gSpm/OUNDDtg3+m8SMCu1NKtBQ1o+hwL1IjIybp33mDy
         KIY/+ZSUoFSUNDo6hZL1ou6suEKUGR+Xm3IGuHVJYCXxf2X10lNSZ8RCN7BlsTuXZSrg
         nuM85BPxE6SgV1DKJRd5Et2G2LAYCjdONq9GZUJQmLXMIUHaSI3KSKuU+93aQy0v7Vbm
         6JqNeCeYNJDIMo5Ir7pJnEPeVO6ZSPsvykULA3Q9v1s2ModrzdAGyODftjtApEFuJFBx
         9zBw==
X-Gm-Message-State: AAQBX9fT+D+GzqoSrI9E+e24Hu4iptDfj5tWeCRqE9So1BMr3F78pGPH
        uy8mSUlF8MjmGY0lO5x/VDw=
X-Google-Smtp-Source: AKy350YbjSd77QyCRvCj02295YbYqK1iz2RH3IukXLuev4sGf/C+6b0glanbXlMEbcv8AFeWX1CJ/w==
X-Received: by 2002:a05:6a20:9298:b0:db:22dc:23d with SMTP id q24-20020a056a20929800b000db22dc023dmr14323654pzg.5.1681227831176;
        Tue, 11 Apr 2023 08:43:51 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c14-20020a655a8e000000b004fb26a80875sm8882859pgt.22.2023.04.11.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:43:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
        <xmqqjzyjemji.fsf@gitster.g>
        <20230410202536.GE104097@coredump.intra.peff.net>
        <xmqqy1mzcus6.fsf@gitster.g>
        <20230411093005.GB398350@coredump.intra.peff.net>
Date:   Tue, 11 Apr 2023 08:43:47 -0700
In-Reply-To: <20230411093005.GB398350@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 11 Apr 2023 05:30:05 -0400")
Message-ID: <xmqqsfd6bf0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Instead, imagine --extra-context='<range>:<path>' were the way to
>> tell Git to include the specified range of lines in the post context
>> even though they may not have been modified.  Then René's patch
>> could have been produced with
>> 
>>     $ git format-patch -1 \
>>       --extra-context='/^timestamp_t approxidate_careful/,/^}$/:date.c'
>> 
>> and would have shown 3 lines of precontext before the removed
>> approxidate_relative(), plus the unchanged approxidate_careful()
>> function in full in the postcontext.
>
> Ooh, I like that very much. In that sense it really feels like an
> extension of --function-context. Would the regexes be searches starting
> from the edge of some context (as they more or less are under the hood
> for function context), or would you search within the whole file for
> ranges (and then presumably use them when a hunk's context is adjacent
> to or overlaps a range)?
>
> If the latter, I guess you could also allow both absolute and relative
> line numbers, similar to how "-L" accepts range input.

We want the latter.

If we further imagine that approxidate_careful() were defined very
far away (in either direction) from approxidate_relative() that
"extending" the patch context to show the removal of the latter to
cover the former would show too much irrelevant information, I think
René would have wanted to show a normal patch plus an extra hunk
that contains the entirety of approxidate_careful() that shows no
modification (i.e. all lines are prefixed with an SP).  The way I
think about this new "feature" is "compute what hunks should be
shown, honoring all other options.  Then pretend no-op hunks to
cover all specified lines in the postimage [*] are also in the
result.  Combine them all, ignoring parts of the made-up no-op hunks
when they contradict the real hunks.".  The end result should show
all specified lines from the postimage plus the usual diff.


[Footnote]

 * There is no need for a similar option to talk about lines in the
   preimage, because a line in the preimage would either appear in
   the postimage (in which case the range in the postimage can be
   used to show it), or otherwise it would appear as deleted line
   (in which case the reader will see it without the new feature.
