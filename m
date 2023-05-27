Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A1CC77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjE0HRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0HRa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:17:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37489125
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:17:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1351289a12.1
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685171848; x=1687763848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMxnG/Q1Gjkv/PX10PvH9Gx1HtciSsHjipjUbrYNCbI=;
        b=LL6T5Z+AgwgWfOnqojkNyiUtdGFD7OQWsf1pjFxtAxLVPqebC/hKKDC/udjTZlCDXM
         QuyYObm3AkI80A6CqmRmEFDXU5D/2vs8KCY0VZc9gZzJJblQj/+4+VIpgVaUW6nZ9BkN
         qYl46rAXsBaXuHx0Br6gMmyKyJZOws8KcLUCMahr3BmYFRJTKg0pQeB1HpoKN3fH7Z67
         tdr3xCI5Fy/7S1QSi4OsoH0XN0+mS76UfWFm1PLfiFsKjFzJkgXKh0Q74yqacprL9Cq/
         THtQDC74qB989ocpBOpszlJ5qwzQllL6U+jXr78Z/8s0+dJLbwIvN0/WET0FHwsV4yoM
         49Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685171848; x=1687763848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMxnG/Q1Gjkv/PX10PvH9Gx1HtciSsHjipjUbrYNCbI=;
        b=c1haTmtOkEDhKtEc6FSufLSaFgsiqiAxU3ShAbmIbAULvMQ7boYnbv3IAquN/rOXWT
         SN+8ka6dANYSktWX2XEjAR/EcXLPHS+K3EQHecRbKin9StetCFmvyaNZCewm/tGEa6eL
         ZYOFM8gStz+jbiSwQOu3YGDSM5Lsvn/olxMP6626j3twiboERyXtdS/UKT+zdCNYTav1
         vVAQLEvwEp6WcXKuynlIJMVD7Mgd1T6etGMOvigWgqt+OzQ40ZEsjxK0Q7klQm6bsJ/1
         19qVtQL8t5AglTpnKZ0IKsSdIxR/jLAHFvZsiqWsPnSGbWlqHyUPXq5mSaHgAsuU0ysM
         HzdA==
X-Gm-Message-State: AC+VfDz3qrDyp/tgFNwEpUn2QT6KSScSH+sWHXa+KQ72LPBRtFAmTSwA
        2YoLRokWD2K9aTlT6yjVZ62lv+RKQVBmqxhj
X-Google-Smtp-Source: ACHHUZ6bhzWJLYxHBcEuPzzM7bPQNAaER3LcgT0w3QILsDiQCOwEgfjgbkyVpt2zHxjpUtMec6RNNQ==
X-Received: by 2002:a17:902:ee55:b0:1aa:d971:4623 with SMTP id 21-20020a170902ee5500b001aad9714623mr5505464plo.38.1685171848461;
        Sat, 27 May 2023 00:17:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001af98dcf958sm4273225plx.288.2023.05.27.00.17.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:17:27 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
Date:   Sat, 27 May 2023 15:17:21 +0800
Message-ID: <20230527071721.24285-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <20230519005447.GA2955320@coredump.intra.peff.net>
References: <20230519005447.GA2955320@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> > +static void insert_separator(struct strbuf *message, size_t pos)
> > +{
> > +	if (!separator)
> > +		return;
> > +	else if (separator[strlen(separator) - 1] == '\n')
> > +		strbuf_insertstr(message, pos, separator);
> > +	else
> > +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> > +}

> This function causes UBSan to complain on 'next' (though curiously only
> with clang, not with gcc[1]). The version in next seems to be from your
> v9, but it's largely the same except for the "if (!separator)"
> condition.
> 
> The problem is in the middle condition here. If "separator" is non-NULL,
> but is an empty string, then strlen() will return 0, and we will look at
> the out-of-bounds byte just before the string.

You definitely correct, will fix.

> This function causes UBSan to complain on 'next' (though curiously only
> with clang, not with gcc[1]). The version in next seems to be from your
> v9, but it's largely the same except for the "if (!separator)"
> condition.
> 
> The problem is in the middle condition here. If "separator" is non-NULL,
> but is an empty string, then strlen() will return 0, and we will look at
> the out-of-bounds byte just before the string.
> 
> We'd probably want something like this:
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 3215bce19b..a46d6dac5c 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -231,7 +231,8 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
>  
>  static void insert_separator(struct strbuf *message, size_t pos)
>  {
> -	if (separator[strlen(separator) - 1] == '\n')
> +	size_t sep_len = strlen(separator);
> +	if (sep_len && separator[sep_len - 1] == '\n')
>  		strbuf_addstr(message, separator);
>  	else
>  		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> 
> to fix it, though I am not 100% clear on what is supposed to happen for
> an empty separator here.

It's supposed to be the same behaviour with not to specify the option, which
is the default behaviour(to use a '\n' as the separator).

The diff looks good to me, will apply.

> I was also confused that applying the fix on top of the culprit in
> 'next', 3993a53a13 (notes.c: introduce '--separator=<paragraph-break>'
> option, 2023-04-28), still leads to test failures in t3301. But I think
> that is independent of this fix. It fails even without my patch above
> (and without UBSan) in test 66, "append: specify separator with line
> break". But the failure goes away in the following patch, ad3d1f8feb
> (notes.c: append separator instead of insert by pos, 2023-04-28).

Yes, that's a problem which be taken in patch v9 4/6[1] at insert_separator(...)
, we should use strbuf_insert* api here, otherwise will always do append
but not to do insert with the position, finally break the test.

In the v9 5/6 patch[2], I tried to remove the postion to simply the logic from
insert with position to just append, and this patch cover the test case failure
in 4/6.

> I haven't been following this series enough to know what's going on, but
> you may want to figure out where the failure is coming from in
> 3993a53a13. If the change in ad3d1f8feb is merely papering over it, then
> we'd need to find and fix the true cause. If the bug is really fixed by
> ad3d1f8feb, we might want to squash those two together to avoid broken
> bisections.

Sure, we should avoid that, will fix.

> [1] To reproduce, I did:
> 
>       git checkout 3993a53a13
>       make SANITIZE=address,undefined CC=clang
>       cd t && ./t3301-notes.sh -v -i
> 
>     I'm using clang-14 on a Debian machine.

Do you always do the 'make' with 'SANITIZE=address,undefined', should I
follow that approach, may I ask you to give some advices about it?

Thanks.

[1] https://public-inbox.org/git/ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com/
[2] https://public-inbox.org/git/eea2246f44a3adfc4888db93975854448271032b.1682671758.git.dyroneteng@gmail.com/
