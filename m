Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54545C433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9576103C
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhJZMSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhJZMSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 08:18:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0AC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:16:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d10so14774135wrb.1
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PvL4wU6QC63Z9SZuoIqwGX/AvIhBrH5GPqc6NyyBg9k=;
        b=TiPwBbvah5RNKyvnErRXlKNsEt1CI3n4090Zg2iMpGYPzcmwolhif9ziga0P5PCJoh
         ZzJ6O5cMvHNaTV5q5lgfkrfGHlg0Bpbg/9sLQIsMrMoVUAaSIilxUVX4zWJ0JdPucBcR
         tojAxgkv4dFHy2Bg5J6Du04Uj93Ou3S2Snt/b4Bsf6232sa9dJpAv4rIb6rzllEkPGVL
         qmQNbltQe8FVp6WBmc8ALn6U9fpOESuz0DSUeHSuJGnK5W/3OzOyYCl7Se6AG6Nju4Eo
         zOwdM9uXlB69VfQ8PaB4UVEdCJwfCQEnWYHf+/VF09pC57yww6nKLRazfrcITtrmU9KT
         l+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PvL4wU6QC63Z9SZuoIqwGX/AvIhBrH5GPqc6NyyBg9k=;
        b=OAWlW9AqSn+Xw9i5w/1hHFMlOk4inY0GFBmfcxav5mW0VBPyWfanWS2ZK3OR9nqo4f
         ZQX8vt/D8pUU+1QnHeeOnzp0BJPTAyFV3L0hgeb+fnl7Nne6/JPcS+TWs/dkDzQF5p4V
         HAE50sjWAEV6aleFheGL8uf0jRjlRIVIKXbbfiSMftoesDc+DetE9UnF3NUWnAHE1exw
         Hy7Ja9aXKytJZdyf1TGXVQOi3GxhYRxHrRJwAA1YPt2uRxzpGFyD/FLuYzBst+Rxcpky
         lPzw2QEWLuEfvUe2o8rkIAKM/30wPkYBVvS62C/Aq7l1CR4uCGFLgNhbdJ/sNGFzpE+F
         odEQ==
X-Gm-Message-State: AOAM533hwV7EiWnQWOtlUWSH7ol0DhvwBbtSmdokz1h5nZx6bqcxuPJg
        wbl2WmPGeY2YcsmUo/rQqCiPv6bo2eoHlQ==
X-Google-Smtp-Source: ABdhPJwLzf86RmykjiVksLm1yMgiB3cbrHZkEYkBF5FWmbTozK4PTVDZSP54yokPUa8hSD/HCZT4Rw==
X-Received: by 2002:a05:6000:186c:: with SMTP id d12mr9922467wri.237.1635250576704;
        Tue, 26 Oct 2021 05:16:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c7sm15744026wrp.51.2021.10.26.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:16:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfLNH-001o18-Ux;
        Tue, 26 Oct 2021 14:16:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: tb/plug-pack-bitmap-leaks (was: What's cooking in git.git (Oct
 2021, #06; Mon, 25))
Date:   Tue, 26 Oct 2021 14:13:44 +0200
References: <xmqq5ytkzbt7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq5ytkzbt7.fsf@gitster.g>
Message-ID: <211026.86tuh4yoa8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Junio C Hamano wrote:

> * tb/plug-pack-bitmap-leaks (2021-10-21) 9 commits
>  - pack-bitmap.c: more aggressively free in free_bitmap_index()
>  - pack-bitmap.c: don't leak type-level bitmaps
>  - pack-bitmap.c: avoid leaking via midx_bitmap_filename()
>  - builtin/multi-pack-index.c: don't leak concatenated options
>  - builtin/repack.c: avoid leaking child arguments
>  - builtin/pack-objects.c: don't leak memory via arguments
>  - t/helper/test-read-midx.c: free MIDX within read_midx_file()
>  - midx.c: don't leak MIDX from verify_midx_file
>  - midx.c: clean up chunkfile after reading the MIDX
>
>  Leakfix.
>
>  Will merge to 'next'?

These patches all look good to me.

I see you peeled off 10/11 and 11/11 from Taylor's submitted
patches. The 10/11 re-submitted a patch that's in my
ab/only-single-progress-at-once, and I really preferred 11/11 not going
in, and instead suggested [1].

But since you've peeled off those two (I wouldn't have 10/11 at all) I
think this is definitely ready for 'next'.

1. https://lore.kernel.org/git/patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com/
