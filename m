Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A1DC00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjAQWW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjAQWWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:22:18 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FA9CBB3
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:02:11 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i185so33810918vsc.6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk79af9HN2fsAgq2bxLSK/NrLu0N3csqboyxVwYYnqA=;
        b=bbeUeF9r1ovQyYv38cjDbKxiCvJwgqqipKsXpiZPJ7CIQyvHCUe68ROC2sQ6T6bJej
         fZHJt5nebIx7OuMRw3ICwDoIRS4D1SgwjCazxFAw9tpUVsfO7xby7pKkNzNvU232Wkye
         IauF4Ho7MpFimeJFenHAEBaHWZWuZiFeh8lEdqplavm4ToYGvfyzDevC9CibaEU+n4y1
         hljRZeGhQ3T277UCxmQRbj82eEmdjN3NFict6JypXLTm/UacOf0phtZzdGqsv0BwQJfH
         Xjz+HXnwoEE+M8b1+9Ws0uRa5DTX5m7ah5o0JuSxu1yd8GncowmEArxH6FBzNKp6Nw2v
         1l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk79af9HN2fsAgq2bxLSK/NrLu0N3csqboyxVwYYnqA=;
        b=BGxOGO6B3McwlCU8jYu5DwOuBDxAcKxYK7COwXqwL/G9R2v6IFeLrAXhp9L4qD1Em9
         7BLu2ekCsIBitn+lku2CyqgJd8lZjySHub9xnZUyUh0MfhEHE5gfdfoapbzlls4PzJA0
         bV2yIE6q01+dikBejgRz6gPyuQp5z/9yrId1zKHSClnwF8+CZHJ3tJ5qrrTFZKn3j8Nq
         hQ7FqvsGV9klcFJVgrLti376lQsOLEomMEkhVM0rkk0wb3oD3UuD9ASqoJzk7Ofd7DHR
         v18nfspEendBICKsm411UTazFoKI6NRlmmeMW0WjIV9YXV75P7UwRh4ERry71GZMidVY
         t8Bg==
X-Gm-Message-State: AFqh2koOSoeDySCi2XpSfy1MJbZ6Ja/GcRhRbeCSokB4JH2R013VHyxq
        qAjHoP8x5Fxnfrh9UzVeFxU=
X-Google-Smtp-Source: AMrXdXvvuBAr5x7lWKQNM7mk+8n5/hefxQjomg4uSJYp6QSgVXU5vKe5vt2Pk16fI13lbDeC1xfPhg==
X-Received: by 2002:a05:6102:4405:b0:3b1:299c:d05 with SMTP id df5-20020a056102440500b003b1299c0d05mr3217735vsb.2.1673992929391;
        Tue, 17 Jan 2023 14:02:09 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id q7-20020a67cc07000000b003d0f0323f8fsm1934404vsl.32.2023.01.17.14.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 14:02:08 -0800 (PST)
To:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [BUG?] 'git rebase --update-refs --whitespace=fix' incompatible, but
 not enforced
Message-ID: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com>
Date:   Tue, 17 Jan 2023 17:02:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah and Stolee,

First, Stolee, thanks a lot for adding '--update-refs', it is very useful (I've
added it to my config so I don't forget to use it).

I recently learned that 'git rebase --whitespace=fix' exists, which is also
great but since it uses the apply backend, it can't be used with --update-refs.
I understand this, and the fact that adding '--whitespace=fix' to the merge
backend would be a big task; this is not what this email is about.

I think there is a bug in that the code does not enforce the fact that
both options can't be used together.  Whenever '--whitespace' or '-C' are used,
the code defaults to the apply backend:

```builtin/rebase +1502
        if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
                /* all am options except -q are compatible only with --apply */
                for (i = options.git_am_opts.nr - 1; i >= 0; i--)
                        if (strcmp(options.git_am_opts.v[i], "-q"))
                                break;

                if (i >= 0) {
                        if (is_merge(&options))
                                die(_("apply options and merge options "
                                          "cannot be used together"));
                        else
                                options.type = REBASE_APPLY;
                }
```

but 'is_merge' only checks if 'opts->type == REBASE_MERGE', so the check only
works if --merge was given explicitely, but not when none of '--merge' or '--apply' 
were given (and so the default "merge" backend is used).

I would have expected the code to die telling me --update-refs and --whitespace
are incompatible. But instead it defaulted to --apply, and (of course) did not
update the refs in my history (which I found out later). 

Thanks,

Philippe.
