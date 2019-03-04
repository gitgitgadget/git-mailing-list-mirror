Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5290120248
	for <e@80x24.org>; Mon,  4 Mar 2019 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCDTTh (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 14:19:37 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53258 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTTh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 14:19:37 -0500
Received: by mail-qt1-f202.google.com with SMTP id k37so5993526qtb.20
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9PlJ3F4rp3jn8/pxBqrcjFvLGFhNV8lnnRLqfkYu1MI=;
        b=Wd7ptqP5ObzedHsGxj2xB0EuZ8yo8CV0Y6aBFM83SkIbRtBYJ7k2kUemdazPpa+pMM
         jOZvtxIwhO7elY97qNTu2KeTui2Rqv7LtrozAVgddWiSRZuV+S3L7l6V6KNTwOOTPuHl
         DZ2gj+O7ftiyTlEIXMillWDsbD7yzaSGkM4IR6ht8puPRzH55CpgtgaeVxmiXidkB8q6
         yYtCSbxQpqz4AeOqbxWfngCb6mN8dMIuV7x6YdLDaO8POVmvFbMqHsh9G5P62Qq6CCYy
         vSXA6cgjjWck6AIqvqENxeeC/oDbwIMkxH+i8hN+/G7ubq3HNhyLpp86F2mVfu2lBe0t
         cB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9PlJ3F4rp3jn8/pxBqrcjFvLGFhNV8lnnRLqfkYu1MI=;
        b=PbzB1RnA6KRVhasnRmp3dWqV3HrPXzdtUhHznYJIS7zerQ18D3w0978wgLQ3WvF8JH
         BmU61+puDeg+F4+77vBm9USx/YLjCKCn3RPOxLJuTJcPDIT4LrWKNnf8DLBn76hrZ5cA
         eCnuhFuO+Fow72xwiBtNqCBudQ9IsIQ3ZhiWeS1cu9R5tsqBqm1kAYWSPcud1a8c83MD
         yXrjxjxI9TUfxviWo+KTXrduZduyYxci1IeMed/YhkM8MO/KAMgScWB9vVl4MpaArExD
         wbkcozCbH1noEHR0zEuoe4D38AG43ocdfaBKiBNicog7ARL7z3fo5R5lkOzCuLeAg2UZ
         MjtA==
X-Gm-Message-State: APjAAAUQxU6sVUZTTqkZsy0aJ2s6V6lr/juRzIwBWxS3ri+dL2mqFR/n
        Uo+CxLyx2UPxbHRtG4sqLyqlKelRfzljRBTQl4kh
X-Google-Smtp-Source: APXvYqwadWAsUEOOPgM+QBErWI2jekAcrFOhI7jK6nE8HE4Vj/PNYwcn39fSkYsXKgpvoWuddtv10GkJLn9mhcc+uk8H
X-Received: by 2002:ae9:e60c:: with SMTP id z12mr11376744qkf.22.1551727176165;
 Mon, 04 Mar 2019 11:19:36 -0800 (PST)
Date:   Mon,  4 Mar 2019 11:19:32 -0800
In-Reply-To: <20190304174053.GA27497@sigill.intra.peff.net>
Message-Id: <20190304191932.105204-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190304174053.GA27497@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] rev-list: allow cached objects in existence check
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     matvore@google.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This patch makes the minimal fix, which is to swap out a direct call to
> oid_object_info_extended(), minus the SKIP_CACHED flag, instead of
> calling has_object_file(). This is all that has_object_file() is doing
> under the hood. And there's little danger of unrelated fallout from
> other unexpected "cached" objects, since there's only one call site that
> ends such a cached object, and it's in git-blame.

Thanks - this patch looks good to me.

> I think we might also consider just having has_object_file() respect
> cached objects. The SKIP_CACHED flag comes from Jonathan Tan's
> e83e71c5e1 (sha1_file: refactor has_sha1_file_with_flags, 2017-06-21).
> But it was just matching the old behavior; it's not clear to me that we
> particularly care about that, and it wasn't simply that nobody bothered
> to put the cached-object check into has_sha1_file().

Making has_object_file() respect cached objects sounds good to me too.

> Some concerns/arguments against it:
> 
>   - we probably would want to make sure we do not short-cut
>     write_sha1_file(). I.e., we should still write it to disk when
>     somebody wants it. But I think that works, because that function
>     uses its own check-and-freshen infrastructure.

write_object_file() (formerly write_sha1_file()) indeed uses its own
check-and-freshen mechanism.

>   - some callers of has_sha1_file() might care about durability between
>     processes. Because it's baked in, the empty tree is safe for that
>     (whatever follow-on process runs, it will also be baked in there).
>     But that's not necessarily true for other "cached" objects. I'm not
>     really that worried about it because we use it sparingly (the only
>     call to pretend_sha1_file() is in git-blame, and if it ever did ask
>     "do we have this object", I actually think the right answer would be
>     "yes").
> 
>     But if this is a concern, we could perhaps have two levels of flags:
>     SKIP_CACHED and SKIP_INTERNAL.

Or teach git-blame to have its own pretend mechanism, and remove the
pretend mechanism from sha1-file.c.

The last time I deeply thought of this was during the partial clone
implementation, so I am probably not completely up-to-date, but it seems
to me that ideally, for reading, we would remove SKIP_CACHED completely
(and always consult the cache), and also remove completely the ability
to pretend (blame will have to do it by itself); and for writing, we
would write the empty tree whenever we do now (for backwards
compatibility with old versions of Git that read what we write). Both
the approach in this patch and making has_object_file() respect cached
objects are steps in that direction, so I'm OK with both.
