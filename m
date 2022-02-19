Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E05C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 03:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiBSDCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:02:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiBSDCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 22:02:52 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DEE2368
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:02:34 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a28so18476468qvb.10
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n6qgx5joB+EetOoAi4cbQ+pxfpkuWsZrUdBayyUY8oE=;
        b=rXgf1D0x7j3KwIQn5we3s5Qrim5X35BNZ1sbUjzTKkTBY/GM76BtcNcw9QDJi1jm1x
         Q3HyfBmRosy25G9mG6Y13M5EDh+HgXaPfgNt0jj5egeC9RsmxdC/eD6nS7XQ6QfsOgxP
         D8ljEpx/aRoJG3psfINecj7rJL3gDOuLhN1PJ+y8cSZikq/tsj0AVEHPsyN6ux0GK/VM
         kH1ux9eEUAe5QFC7p4Sgem8Vi9dcRQNna3gtquMC0Rn28YcM2vMnO5iQ+uso2dAepk/z
         zw8R9U5E15u9A1XHreErnNXLgqdGQT4hx5OlDvmXjTKFdsxTxm64PHhI8m9DvE7QZKIR
         zlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n6qgx5joB+EetOoAi4cbQ+pxfpkuWsZrUdBayyUY8oE=;
        b=HcUJ+7DuT74Bc5yTyer7EZwqOMeSABXz8UbAo7tPsTUfb2jIPARcTIzqbiY+zIvTOD
         uCaLe6fLwV1eCAwIx41i08P7OuOBKJCxkbnC5ZaOWVlncc3hf4NIGavYlIkZiF0hlK38
         jaZeHmOitMmfcHuVZD2UyJb1+YxA9taF2eKuMygZnrsdaDrKosqgcN7SL+7GEyLXxJtq
         53nbL+jyj5NF2mm3VqX7BYhGluKVqhdI/vyaRcQ/Uu4Mm8SsxZJ18ZQ9Lto6i7W7Nu18
         SIe8xeHYWOT9C3UT9VLh9ZDKmenDSwXH6CL7sQqC1NeXU3bbUIp6NXERNlNddi03e3Ow
         PJpQ==
X-Gm-Message-State: AOAM5320YG9bCPzV+7Hgwbx/gzwIKl6qxZCqooMdBnpqn3F2/tt0EkT4
        vYLXHObM4I4pLSfKKH5GPzaQjQ==
X-Google-Smtp-Source: ABdhPJy41GneDV0bLnfunlA/KTHTCoXnwVnYUv1u6hvhmVHeV/ClSD3o+s3vdSdpP13c5rSnnUXLnQ==
X-Received: by 2002:a05:622a:11d2:b0:2d6:8a01:66ef with SMTP id n18-20020a05622a11d200b002d68a0166efmr9270721qtk.38.1645239753802;
        Fri, 18 Feb 2022 19:02:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c3sm19296261qkp.39.2022.02.18.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 19:02:33 -0800 (PST)
Date:   Fri, 18 Feb 2022 22:02:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Message-ID: <YhBdyEQX56IKYlCM@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <xmqqpmnkymfn.fsf@gitster.g>
 <220219.86h78vftsa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220219.86h78vftsa.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 03:53:14AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Feb 18 2022, Junio C Hamano wrote:
>
> > "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> diff --git a/reflog.h b/reflog.h
> >> new file mode 100644
> >> index 00000000000..e4a8a104f45
> >> --- /dev/null
> >> +++ b/reflog.h
> >> @@ -0,0 +1,49 @@
> >> +#ifndef REFLOG_H
> >> +#define REFLOG_H
> >> +
> >> +#include "cache.h"
> >> +#include "commit.h"
> >> +
> >> +/* Remember to update object flag allocation in object.h */
> >> +#define INCOMPLETE	(1u<<10)
> >> +#define STUDYING	(1u<<11)
> >> +#define REACHABLE	(1u<<12)
> >
> > These names were unique enough back when they were part of internal
> > implementation detail inside builtin/reflog.c but it no longer is in
> > the scope it is visible.  builtin/stash.c (and whatever other things
> > that may want to deal with reflogs in the future) is about stash
> > entries and wants to have a way to differentiate these symbols from
> > others and hint that these are about reflog operation.
> >
> > Perhaps prefix them with REFLOG_ or something?
> >
> > Or, do we even NEED to expose these bits outside the implementation
> > of reflog.c?  If these three constants are used ONLY by reflog.c and
> > not by builtin/reflog.c (or builtin/stash.c), then moving them to
> > where they are used, i.e. in reflog.c, without exposing them to
> > others in reflog.h, would be a far better thing to do.  That way,
> > they can stay with their original name, without having to add a
> > differentiating prefix.
>
> No objection to this, but FWIW the general pattern for these object.h
> flags is to use these un-prefixed names:
>
>      git grep -A20 'Remember to update object flag allocation' | grep define
>
> To be fair the only one that's really comparable is the revision.h ones,
> but those are very non-namespace-y, with names like SEEN, ADDED, SHOWN
> etc.
>
> I'd be fine with just leaving these as-is, especially with compilers
> warning about macro re-definitions.

I think I have a mild preference to avoid polluting the set of macros
with something like INCOMPLETE outside of reflog.c's compilation unit
when possible. Though I don't really feel strongly either way.

In any case, let's make sure to update object.h's flag allocation table,
which as of this patch still indicates that these bits belong to
"builtin/reflog.c" (instead of "reflog.h" or "reflog.c", depending on
what the outcome of this discussion is).

Thanks,
Taylor
