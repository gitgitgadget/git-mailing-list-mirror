Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29EDC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C95160E8F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhJZTeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhJZTep (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 15:34:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0AC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:32:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e144so757436iof.3
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2daTUbyVdVMjCvi6UJJvoUuOPjcyL0e7/l61Di4s6yU=;
        b=N8Fuw5GERiqd52M/KE1EUYrJn7nej3WUaAeeMAXnNgmYPmwEaTHxs9Pv0kxCysKtW5
         Hx6n4YpTFp2OsQrtG6C7fdCzV6P9KsO2sHHHnLwSP5/P+zTRvs+G8DJ52XNZZZrjnEgM
         rP+xbyM507qyCbxU2mD6bZmj1Ip8Wes6NuMRzRji4cONsiaSdPn+nuzVMJGrLH16ZkMM
         +RFfN4jW4TY24v4fkytxpuXch9EUUhHrM7TsGnn/5E/aCPyN04nhW7DaF0mPyAVwG+5G
         WtRWtSSwNvgx+L4uOEnYsyIuHc/DwLIZVqPk6Gee+fcdsn01OsjVxlOA4d/jw5BwDmkf
         BxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2daTUbyVdVMjCvi6UJJvoUuOPjcyL0e7/l61Di4s6yU=;
        b=Sy0LxKmiZMyw6hpK6hUyxzVijpTnrMEi+yeLz7ybLSZ7g2TLtt6Uwecp0FVj6JzbLG
         k7HJEWKb2zNScoz5+ZqaYIz2cQyX2L8jXNyNixEQZKie+7uRf7M4LDdY9igBqM/eN2jN
         7GnmnBPfFZ8CTUEmHKgVaxU7uM3XjO4eZuMHqylq2Wpit1TEAWhSfg9QIoS6cPKHBGFQ
         x/URsEja/Lkco5UNDUDFSnI7zNNeGvXAnXNS5pPzIfvloKVK4K6WmS4H3a8e39Ddo0qP
         D+E9IW6/Il6ikEiLZfgBd030WQ7iXPLTo6VH+QQdBEC26bScq2YwB6RERDkQTGzPpUJ9
         rRFw==
X-Gm-Message-State: AOAM530B4mOR76LNTXRb33/R4ppJ/550XXN8FvHfxe6wj+1Xa0I+sAAV
        kQkaOCDCs5IEqEEIzMRODPE3aiSnp0eKfxjS8F+ZHaPwTxXtXQ==
X-Google-Smtp-Source: ABdhPJxpaob3iWtCQgAHi8KAPmjNeFBIRUQFq4DjwZaCN3VNX3C8jj/nE4ZLsbgBUSTHC8IOpeg297Q8xYzvUL1MwG0=
X-Received: by 2002:a02:b885:: with SMTP id p5mr13145258jam.81.1635276739995;
 Tue, 26 Oct 2021 12:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
 <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com> <xmqqczobb8jd.fsf@gitster.g>
In-Reply-To: <xmqqczobb8jd.fsf@gitster.g>
From:   Ivan Frade <ifrade@google.com>
Date:   Tue, 26 Oct 2021 12:32:08 -0700
Message-ID: <CANQMx9W_Zt+qy3sppx1qGdf6S9gMSEp_7jjV4hc_aeyR62syrQ@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: redact packfile urls in traces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems I sent my original reply only to the github PR. Sorry for the
confusion:

On Mon, Oct 11, 2021 at 1:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Ivan Frade <ifrade@google.com>
...
>
> It of course is a different matter if the explained idea is
> agreeable, though ;-).  Hiding the entire packet, based on the "it
> might be in some setups" seems a bit too much.
>
> Is it often the case that the whole URI is sensitive, or perhaps
> leading "<scheme>://<host>/pack-<abc>.pack" part is not sensitive at
> all, and what follows after that "public" part has some "nonce"
> material that makes it sensitive?

In the specific case I am working on, the path of the URL is an
encrypted string that shouldn't be completely exposed (exposing part
of it would be fine). In general, I think we can assume that
<scheme>://<host>/ are always "public" but the path could be
sensitive.

We could redact only the path (<scheme>://<host>/REDACTED), or even a
fixed length of the URL? (<scheme>://<host>/pack-<xxREDACTED).

In the next patch version I go with redacting the path.


> > Changes since v1:
...
>  Please write such material below the three-dash line.
Done

> And there is no need to duplicate the log message here ;-)
Done

> So "original_options" is used to save away the reader->options so
> that it can be restored before returning to our caller?
>
> OK (it may be more common in this codebase to call such a variable
> "saved_X", though).

In the latest iteration, the option is enabled for all sections and
there is no need to set/unset the flag.

> > +     grep "clone< <redacted>" log
>
> This checks only that "redacted" string appears, but what the theme
> of the change really cares about is different, no?  You want to
> ensure that no sensitive substring of the URI appears in the log.
>
> Imagine somebody breaking the redact logic by making it prepend that
> string to the payload, instead of replacing the payload with that
> string---this test will not catch such a regression.

Now the tests verify the expected packfile-uri full line is in the log.

Thanks,

Ivan
