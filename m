Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091AC77B73
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 05:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjD3FGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 01:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjD3FGk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 01:06:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212692701
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 22:06:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b7b54642cso1010721b3a.0
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 22:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682831190; x=1685423190;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjPxi9rUG5+YpRbDYl/33EC9b2CSHHM8hC6H17m/XZw=;
        b=Kx/++k0sz+hP6aos4/UZpK8ZES38uHkmWfbt87tTD9I3ax74syNTyZOqkKoOSnBZYt
         w8kPmqMTUfoVxyvO4tq/NipxSQH01ZGlhh2wlX+iwP9BIEzTg4B8jOsJPT+6TrWQ8/YB
         uD67fp2n74+1ji9zRJ7he2gKHK+57z64IyR7tcNZaSzV8Xm80+7FG/XYi9AInt/kcVbH
         QPulTlaEQXTecN2tWqjlKdrvNd7lOJGrYh/QPZlt/7rV6VsrTkHk8jekQEF4V+a6V4lm
         rx1YutfIqps6pdjfkIOCduOBr5yBcBRzL58JsCrLwX35lCFl0XoQrPx9FIFUXyUvmBpS
         OedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682831190; x=1685423190;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjPxi9rUG5+YpRbDYl/33EC9b2CSHHM8hC6H17m/XZw=;
        b=dVbUBHwk/k6g7HIrLxlOxiaspUcmeeyFOHpp8XJY70m2ojNPalzZC/QAfQTYWJ0IIF
         MSRlIyeAVZwh2x4SFhwNzbM9qseD5KSUD83cQQ0ZSJN2QsWUpkI91FU04GRLAXMNSPY9
         tT6nqlmH/vDlqRYJ4OlrBVYCRirVNnmHTwqSv/giFAj2lRUvsmaJSGOvMwceaTdYZrFd
         4OAxcZ+Bwdja6RC3Ls1Ab1j55yMMnR6YH4kaKkOXOTsUkgb3kj959TDQpE5Ziqdf1UBU
         zJFsvqM9q5dhS9WAKi+3EuflWHxsMRcHlRX5rVsA1NsQdY4ZM1DGXsdhWNDghwKnyZwo
         M3Nw==
X-Gm-Message-State: AC+VfDwq/ngBUUl1Nrh+/LFB/XGzsEc1BgnESxc8RRXo0a67viKJ5AjQ
        Yo8A9MlyO4wXj3afLbgT1Alp1IENqAE=
X-Google-Smtp-Source: ACHHUZ4/g1fZcqQ7IhRczrVHy8LvNW9X4IVbspKHeHRI7YOfWl3YBcUJ4bofqAKzoUcSIy/3u+Vhvg==
X-Received: by 2002:a05:6a00:181e:b0:624:7c9a:c832 with SMTP id y30-20020a056a00181e00b006247c9ac832mr15684104pfa.8.1682831190385;
        Sat, 29 Apr 2023 22:06:30 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c15-20020a624e0f000000b0063f534f0937sm12758433pfb.46.2023.04.29.22.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 22:06:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] advice: handle "rebase" in error_resolve_conflict()
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
        <xmqqjzxvde6p.fsf@gitster.g> <ZEzErKvmBPwP0Hsp@ugly>
Date:   Sat, 29 Apr 2023 22:06:29 -0700
In-Reply-To: <ZEzErKvmBPwP0Hsp@ugly> (Oswald Buddenhagen's message of "Sat, 29
        Apr 2023 09:18:04 +0200")
Message-ID: <xmqqv8he9cx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Fri, Apr 28, 2023 at 12:01:02PM -0700, Junio C Hamano wrote:
>>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>
>>> This makes sure that we get a properly translated message rather than
>>> inserting the command (which we failed to translate) into a generic
>>> fallback message.
>>
>>Hmph, can this be accompanied with a change to add a test to an
>>existing test script to demonstrate that the function can be called
>>with me set to "rebase" and results in a generic message?
>>
> i suppose it could, but see next paragraph.
>
>>> We now also BUG() out when encountering an unexpected command.
>>
>>This needs to be reviewed by somebody who is more familiar with the
>>rebase/chrry-pick/revert/sequencer codepaths so that they can give a
>>definitive "good--I know that we never call this function with any
>>other value in 'me'" and that person would not be me.
>>
> assuming we care only about in-tree code, i'm just about as confident
> about this as one can reasonably be - because i grepped through the
> code, recursively looking for entry points. there are several calls
> via die_resolve_conflict() which have hard-coded `me`s (none of which
> is rebase), and two from the sequencer, where `me` comes from
> action_name(), which in turn returns one of three hard-coded strings
> (one of which is rebase). the latter is also kinda the test case,
> because it is obvious that this will be actually invoked when the
> situation occurs. it's probably also how i actually ran into the
> problem in the first place (i surely wasn't *looking* for it ...).
>
>>> Arguably, it would be cleaner to pass the command as an enum in the
>>> first place ...
>>
>>True, but that can be left to a different topic, I would think.
>>
> yes, otherwise i'd have already done it. ^^
> i can make it more explicit if you prefer that.
>
> if you agree with the reasoning, i'll prepare an update to the commit
> message and leave the patch as-is.

Yeah, how you arrived the conclusion that just covering "rebase" in
addition to what the code already covers would make the if/elseif
cascade complete is a very helpful addition to the log message.
