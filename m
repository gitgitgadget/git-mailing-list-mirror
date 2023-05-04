Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C6C77B73
	for <git@archiver.kernel.org>; Thu,  4 May 2023 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEDUyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjEDUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 16:54:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666712488
        for <git@vger.kernel.org>; Thu,  4 May 2023 13:54:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so1141244b3a.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683233613; x=1685825613;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li9fQq1vF/0oO2WZU7oCREy8gAIdtyYBxwxAaNRAayQ=;
        b=pL7rMSHZjeVptuLkldhMUofe0tQmqw4iyjfnEFGy0f7DwJSCFES4Dyle/29Xn2kvRP
         QNhoJM2DJs2vSHci7o3xaBBX6Lm+exGom2vEJvHKt/4z5aPegFTwaYwnaHOGgn9p6ykz
         WdfIyBkExwxUnd8awNzefyk9oH0I3F90ts8oiGBZ3+v96NhGDN9vyZAzOfSk9/TtTcc/
         o1KGiJcW8Rf0v37OxwXSUCMIW3f1uWPCNaYHi95R+udkxAHXCETLWXNeZ/EqfPrXSlFs
         /tuVS+h7pCqJU3t0nuwWiMGOdCYaUgoaoDrf9/VE8FohDY69PGzP2PE1RvYc1rYR8xQi
         fY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233613; x=1685825613;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Li9fQq1vF/0oO2WZU7oCREy8gAIdtyYBxwxAaNRAayQ=;
        b=NTsFFh0G3sqn4yfUEcCMuor5AukP5l2J7hXLK6qcDYosfTTK0p/6DVlyXPtsXZ9V+3
         C3ygl8T8ogniISIwN4Dm+v2YiYsK0fPSi1QirGLS2K3DbZCy3U5LnyJdeqL6OlDY0URr
         Xpp8Ryw0Dk2IN8U2f5f7hU5iM3oatFLEucdVq/Sygu9ig9KPkCJs0yKVrLdkt08Pc1uk
         1WKM13bOQ0pz2bhXZ+ZrbJ37P6kwicyRusiLJhibr0r4D6TWH95sziF0HKQxuiZUVPLp
         pGqrGor490Dz4+OEO5jzScfPkwplzQLcEzu7N5cxGw3vpaksYBsPbmsvX7pQZo4Ww1nz
         C79w==
X-Gm-Message-State: AC+VfDxHIqaDwTKF+W1gj1Mto1eOdzJ9Cc7otX3/cjzJmdCtzUPJx6aS
        fwYGphz/SHG3IwD0SvUlYlcHhXFQVVY=
X-Google-Smtp-Source: ACHHUZ7AdLXa3ZwZzUOrKZxKLdBQx63UyGn1YsdQeY9tVf7UMvwCdDXbAMuPXdsJzpJeXPESe7BJBg==
X-Received: by 2002:a05:6a00:240a:b0:63d:47c8:856e with SMTP id z10-20020a056a00240a00b0063d47c8856emr3888149pfh.2.1683233612497;
        Thu, 04 May 2023 13:53:32 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j21-20020aa78015000000b0063b7c42a070sm110874pfi.68.2023.05.04.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:53:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru>
Date:   Thu, 04 May 2023 13:53:30 -0700
In-Reply-To: <87o7n03qgq.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        04 May 2023 21:24:05 +0300")
Message-ID: <xmqqpm7fizsl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> [-s meaning "silent" at that time? If so, making --no-patch a synonym for
> "silent", and then documenting -s a synonym for --no-patch sounds like
> quite a twitch.]

I thought it stood for "squelch", but it turns out that it was
introduced by f4f21ce3 (git-diff-tree: clean up output, 2005-05-06),
as a "silent" mode, way before anything else in the thread has
happened.

In Git v1.8.4, "--no-patch" was added as a synonym for "-s", and
ever since we documented that they are equivalents.

> Anyway, this seems pretty irrelevant to the test case. Even
> if we spell --no-patch as -s,
>
>  git diff -s --raw HEAD^ HEAD
>
> should produce what? To me it should be the same as
>
>  git diff --raw HEAD^ HEAD
>
> as -s turns off everything, and then --raw is turned on.

Ah, yeah, I missed that part of your sample command.  It does seem
quite puzzling, and the bad (or good?) part of the story is that my
fresh build of v1.8.4 behaves exactly the same way.  And with "-s"
we can try versions before v1.8.4 (the only change that version made
was to introduce "--no-patch" as its synonym).  It seems it behaved
that way at least back to v1.5.3 (which happens to be the oldest
version I consider worth comparing with more modern versions).

> Notice that
>
>  git diff -s --patch
>
> does produce the patch output, whereas
>
>  git diff -s --raw
>  git diff -s --stat
>
> produce none.

Yes, you're right.

> Sounds like nonsense.

Sounds like a bug to me.  I wonder how it came about.  Did we forget
to add support of the equivalent of what "-s --patch" does, when we
added "--raw" and "--stat", perhaps?

> I'm afraid the solution I'd come up with won't be welcomed. If I'd start
> to "fix" it, it'd be likely set of independent options:
>
>  --patch --no-patch
>  --raw   --no-raw
>  --stat  --no-stat
>
> and then
>
>  -s being just a shortcut for "--no-raw --no-patch --no-stat"

If I were writing Git from scratch without any existing users, that
would be how I would design it (modulo that I would make sure we
have some mechanism to make it easier for developers who may add
a new output <format> to ensure that "-s" also implies "--no-<format>"
for the new <format> they are adding to the mix).

The fact that this wasn't brought up until now may mean that nobody
would notice if we redefined the definition of "--no-patch" to
behave that way, as long as "-s" keeps its original meaning.  

I dunno.

Thanks.
