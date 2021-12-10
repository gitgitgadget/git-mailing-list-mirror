Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E6C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhLJQfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 11:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLJQfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 11:35:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03367C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 08:31:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so31227287edd.13
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 08:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pIH8PE1uSSUJyRKeBYOuhJ9SKzfesmvn2j+rZm46lMA=;
        b=an98OT7FbbFSKvPMDXaT9ZS4VikN6USmokoK/Hfl9v8paHxmyz0PF35//c3nvrCEds
         w6zeJWwjjdX+C7hWhbFwpD88i0MI8RRyNyjZnZrzyC+rdipR3xmrlN27HKy/1nud3wys
         DOMP64/SwVNuh9+OpK/IQGbeeRa0CnnBs1w19IDz0k73x1JFiDMiTpkH9cDBC+XJy3c4
         hh8PY2lM36m9aXe2H3AcdVLG4dbWPwDJ/rgyHShZAsdrlnl+wXKbXJYQpBOMX5YMbkpe
         d07TuzwMG8zGzWki5nDGVjwnG6nx5cAXiW2dBMuvNYuQ1OHAvjHuCOp+iDWSgwRzPSnw
         UmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pIH8PE1uSSUJyRKeBYOuhJ9SKzfesmvn2j+rZm46lMA=;
        b=qOt6zw385diicSV10zEZuzRaeSq8lerm+mBnR8KDqb5YPZ0KDhGyDNfKRMN/Aa+H3J
         O466bqBeqIPtXrJ0GbujJLCs9PgUB1CoddugkkLnoKVmemCFQ/lUryyHOV8TpD8iuE8q
         m5F0VxdEFu6CD4glPZ6TCeUaQ1Oujz743SnZrY6BqgOXcuUJCwCiNzW0Gr4gh2+CMr/E
         STJiqMDEl5B7CIyWN5A0bhjU0i4kan8Y111qClTGRGO6FU2nnFV4ufjennyLlw0Bdk1Q
         yuGs0qPvaUI3eg4deXVMG8Zbd6phU/bMaQwm3OVq0nerLXVfYgFwilybevWoJZCu5BdU
         OUNA==
X-Gm-Message-State: AOAM5335N4YzGgUPfz2b8bF4TGJ6VOG0e5RILcUYtSh2nSQoLTewOZb5
        dFVG2q34LO6jxfy5GXiOa2CI6S/Bg0fkjA==
X-Google-Smtp-Source: ABdhPJxXAywIKaBg482sWYV3siPk7hnlVN8ah1qcxyclu8y+WYNiE/azZMItnhTi8nODZd6dzHB2CQ==
X-Received: by 2002:a50:f09b:: with SMTP id v27mr39367346edl.53.1639153916137;
        Fri, 10 Dec 2021 08:31:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e12sm1635744ejs.86.2021.12.10.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:31:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvioM-000OXy-OX;
        Fri, 10 Dec 2021 17:31:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/5] Sparse index: fetch, pull, ls-files
Date:   Fri, 10 Dec 2021 17:16:35 +0100
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
 <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
Message-ID: <211210.86v8zwbev9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Derrick Stolee via GitGitGadget wrote:

> Updates in v3
> =============
>
>  * Fixed typo in commit message.
>  * Added comments around doing strange things in an ls-files test.
>  * Fixed adjacent typo in a test comment.

Yay, I'm happy to see 5/5. Not because I didn't like the helper, but
that sparse is getting mature enough that we're getting ls-files to emit
information about it. Thanks.

There's the small "diff -u" portability issue noted in my just-sent
<211210.86zgp8bi48.gmgdl@evledraar.gmail.com>.

Other than that 2/5 adds this documentation about ls-files --sparse:

	If the index is sparse, show the sparse directories without expanding
	to the contained files.

Shouldn't we at least add:

	Sparse directories will be shown with a trailing slash,
	e.g. "x/" for a sparse directory "x".q

In addition to that I think this may have a buggy/unexpected interaction
with the --eol option:

    040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       i/      w/      attr/                   x/

I.e. should we be saying anything about the EOL state of these? OTOHO I
tried adding a submodule and it says the same, which seems similarly
odd, so maybe it's either correct, or this isn't updated for those
either.

Is the behavior of:

    $ git -C sparse-index ls-files --stage --sparse -- 'folder2/a'
    $ echo $?
    0

Expected? I.e. accepting /a when we'd just print "folder2/" and not
e.g. erroring (probably, just asking)?

How about:

    $ ls -l sparse-index/x
    ls: cannot access 'sparse-index/x': No such file or directory
    $ git -C sparse-index ls-files --stage 'x/*'
    100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
    $ git -C sparse-index ls-files --stage --no-empty-directory 'x/*' 
    100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
    $ git -C sparse-index ls-files --stage --no-empty-directory --sparse 'x/*' 
    040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       x/

The answer is probably "yes that's fine" because I've got no idea how
sparse really works, but just checking..

So it's very nice to have the new diff test in 2/5, but would be much
nicer/assuring to have that split into a trivial function followed by
seeing how the diff looked in combination with each of the other option
that "ls-files" accepts.
