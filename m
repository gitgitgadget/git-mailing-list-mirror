Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31A8C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiF0StD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiF0StC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:49:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F944EBA
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:49:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so21023148ejb.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KCarzl3kN0wT+kPSKlF1Vn7MylEjENxFa7apfJXwzP8=;
        b=AZ6hJeBx/RYx3SLR4gpTbXKXvjSB1mTNG1EtuuPTwyFG2yLEdzOuiMiZDCFRU+J9Xb
         CwV5KX6TUV/4gfFhaB8yLLnR4QQkWKHinnn9SE+tLjDdOqp+oZ4XyAmefLx3UnjmruSe
         J0kRPNpy3iEvm9FHcd8JIe+bqCnIzWydM1cQ667UBJI5bqe6F7jKsToSfGr/JmBCRF/t
         qi1YpNrT2BR7przIISK8erJqIahlV4pyQh29A4UChxxhMF/LFFdZKBfO6odZLUdPXFnK
         pQ5YD1UfZ0/CWipCOMYf9RR049mcJ526/7+zqgZUw/8CSyIqz14ba04c7VxmHprM9neA
         fZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KCarzl3kN0wT+kPSKlF1Vn7MylEjENxFa7apfJXwzP8=;
        b=dhgjh9xFBhep0mHiLJDvqfci3ntnFcI9VSdM8mks+IaXa64TJtf/Kp61wEySH4HYiV
         JRhgyZz1k86mUXvw/0B2APgP2BhdtpVa6im5XsPD5FuiuJJjG3On9uqwKJQTZYF/H64f
         maV2RvF3oHP8k+PVO/PosJQPQBO6KBPGMmp4w3V5gbL1mZOxSelm1b2MLcosrNwApTPf
         hW2jnpoNrlB/vvRn/81grE4g3+hHKeRJYuNY5y87h+S8bZOg5P6px8bBPzF/VUf0CrT4
         OwcH/kCo+UjqaGSl9ZAx6J4+tLcGx4hEbxSgTbmrwjxqz7Z7zhr3A7be54+cvMmLmjYF
         Vqyg==
X-Gm-Message-State: AJIora/9V8GvSmNw6wtCNayCcQCEpy9WBGClv+YVgb5rbQ35ZCw6rmNY
        RcLrGUoiNumkuJD0mW2fyzJYuSvec10=
X-Google-Smtp-Source: AGRyM1t/kY6X+fQ7FvUWGVFbnrsvSxb6NA4YzpvdhoS+jKSHec8c0qc5scsoGZhiAoUGv9+19++oAQ==
X-Received: by 2002:a17:907:608b:b0:722:fb4c:5675 with SMTP id ht11-20020a170907608b00b00722fb4c5675mr14654522ejc.273.1656355739256;
        Mon, 27 Jun 2022 11:48:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709062ec200b006f4cb79d9a8sm5397596eji.75.2022.06.27.11.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:48:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o5tn7-001chl-Q7;
        Mon, 27 Jun 2022 20:48:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] ls-files: introduce "--format" option
Date:   Mon, 27 Jun 2022 20:34:30 +0200
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
Message-ID: <220627.86v8smgcx2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 26 2022, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Add a new option --format that output index enties
> informations with custom format, taking inspiration
> from the option with the same name in the `git ls-tree`
> command.
>
> --format cannot used with -s, -o, -k, --resolve-undo,
> --deduplicate and --eol.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> [...]
> +test_expect_success 'git ls-files --format with --debug' '
> +	git ls-files --debug >expect &&
> +	git ls-files --format="%(path)" --debug >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done

I'm not sure what to make of this.

In some ways I think this makes more sense than what I suggested in
https://lore.kernel.org/git/220624.86letmi383.gmgdl@evledraar.gmail.com/;
but I had to think for a second about what's going on here.

In my version I suggested having this work with --debug, but not in this
way, in my version you'd always emit the debug output, and the format
output.

But here e.g.:

    git ls-files -t --debug

Will emit "H tag.c" or whatever, but if you add --format the -t option
is silently discarded.

So the test is relying on "%(path)" being the default format.

I think extending this to e.g. test what happens with "-t" would be a
good thing, but also in general does combining --format with -t make
sense, and are there other such options where the combination might not
make sense?

So I'm not 100% sure, but I think I'd prefer my version, but I see how
it would get hairy to support, e.g.:

    git ls-files -s --debug --format=...

Should work, but you'd have to special-case the logic for erroring if -s
is combined with --format.

Anyway, I think it would be fine to leave this in whatever state is
easy, the --debug option "just for debugging".

But re
https://lore.kernel.org/git/CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55OcXTSRA@mail.gmail.com/
I think it might be interesting to get --format to a state where we can
remove --debug entirely.

I.e. in c2a29405105 (t1091/t3705: remove 'test-tool read-cache --table',
2021-12-22) we could replace some similar test-only code with "git
ls-files". I for one wouldn't mind --debug going away entirely, and have
the t3705-add-sparse-checkout.sh tests use --format instead.

Or we could keep --debug, but just have it powerful enough to do what
print_debug() is doing now, possibly without "truly internal" stuff like
"ce_flags".
