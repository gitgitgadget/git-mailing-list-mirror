Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F9C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 19:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCMTSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCMTRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 15:17:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96B34C01
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:17:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i5so14135936pla.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678735047;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVAETOVtNNrqAxgk/hnru9BAntRQ9PACqtZaO9jiEs0=;
        b=QQxs+QTVgpoS0GVOs104fIY2c5aw6aeKiidsSEw7W3E0LKRiGB0xTNxDi+lj0Q2UZF
         bdLDhmfZvapyvcLU+8E+mNre4B+nyz+GF3YXKPo+dk/uL0wxLc6ZpK4vHBUDxWwTapXM
         NlNExQ1fJYoi3Ia4VAAOuqaxfx3SmNycYf0nYZlUGwjwsfXmdsZNfS6OA94r38TUnTJ7
         +AN31G1SCPq2txOm9FM+qFISDitNrjv709ZVRW/REoo4fYkx8ds882XS2abyJGDXKI8Q
         O0laj/yOt7roxDo41ji1J4lY/e1KQfxq4WekF9/azB4NsNEPTw5WuIi9VAnij/gRouoC
         co9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735047;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVAETOVtNNrqAxgk/hnru9BAntRQ9PACqtZaO9jiEs0=;
        b=gDL0lSa8IU5YA8qfYF/dEbmIdKXrpzLgTjd2g0SMvrjIA3tQe76eaZ8URoAai8GOOb
         1BlNq7E0RrW3vRYljGPzA+BfmZMD2tqduGNuE0IwpHJILzWaam+oKDAyNIHXd+t+pJN5
         fCl/qoxjX43mBSQofutNsnt1AB3VOG1cb4tLYt86DCd/9Lp+jrsYciz2QeCSjW7V+sZP
         tI2RvqQr35dd0r16jk0xjnHFs7YPxGUBE0SkdY/BjetAG+SmbXgImIyrMmnuISp17STM
         y/RvCWfcztn8/ubiv308lM+h7QrLIYJtbKfVwkibI2ifXpj8c4LXeMKVN+8U5mAkKSU/
         moVA==
X-Gm-Message-State: AO0yUKWaDHTxWyiNLgCTAmf5tPTiGpcBXtgbE+V+IY9YrC31x7H2rrGU
        5aaDkuazHoG7oK5kcUIXRyM=
X-Google-Smtp-Source: AK7set8oKYeEr9gqCw/oyhFCLgHC8a8nx0yyESUVv6yU5jAITJntf0DTly5EyNuobeCIxOhff2yXLw==
X-Received: by 2002:a17:903:32d0:b0:19a:a810:542 with SMTP id i16-20020a17090332d000b0019aa8100542mr43467780plr.61.1678735047177;
        Mon, 13 Mar 2023 12:17:27 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b0019c2d664869sm184101plz.298.2023.03.13.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:17:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git commit --amend --no-edit --date {date}' sets wrong date
 when the summer daylight saving time is on
References: <35a28f6c-5fe3-3007-63b2-bcfcdd10795a@tsoft.com>
Date:   Mon, 13 Mar 2023 12:17:26 -0700
In-Reply-To: <35a28f6c-5fe3-3007-63b2-bcfcdd10795a@tsoft.com>
        (yuri@rawbw.com's message of "Mon, 13 Mar 2023 11:46:57 -0700")
Message-ID: <xmqqttyotq9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> After the 'git commit --amend --no-edit --date "Mon 13 Mar 2023
> 6:00:00PST"' command 'git log' shows that the last commit was made at
> 07:00:00, not at 06:00:00.

PST vs PDT, perhaps?

> This started happening only now after the switch to the summer
> daylight saving time was made a day ago.
>
>
> In both cases, when the time is set or read, the time correction
> should be applied equally.
>
>
>
> Yuri
