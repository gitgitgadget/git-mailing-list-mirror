Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B532C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjD0QU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0QU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 12:20:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD93AB0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:20:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso7204231b3a.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682612455; x=1685204455;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5how5+qDH9s/kk6gOb3Sa5mDD6bqtCtCypbZt+kx5I=;
        b=VaVbdi+rxn/3KxTdjBeo9UcrENMToe+ZwDo/mxbiyIes0LaECKgTTaKmRjmYkYi6Ps
         gKpJ9fmms5eQ5wELOSOmdL1SZUDkeZW0CY+c+szFpIyN9P6wvVOR0m4Eln+/TscZ31W/
         MwySLi4in/z/gUTBvQFGPFytqO9rC9U+9vXjMq24mfJW1v59Ti17HYcWN/xRsEr40fFq
         pii5Kde1ef/xIcXO+SSnYOKPyor9cLwvJT5g0GAVUHa2N1qvGUcNUgvTOW4OBTt2ybEJ
         2T43wDTVBvhChpSDIBF9ti2ADRyL6FsAzpwfOQ1kDDgnGTS5HgNv/mz30AnLL+oLBdH8
         umtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682612455; x=1685204455;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5how5+qDH9s/kk6gOb3Sa5mDD6bqtCtCypbZt+kx5I=;
        b=Cm9cbbHysdKcKqKDuI168myqGUmYG0nQqDgTGwo5m/nyHg8/9hwbyrWyALq678i3NL
         XVeAYHlAjh1pcIYpp34itXMnVb3QniKrbQHqI+dncg6pzJcNfZQaITVq3l4llEAMzHbN
         D9gZLNDMUzsx6MbP2Cb1j1/7xCd4ubHKaA6/Aa+XMp7OlJHb4i2e2/ajttTMUxD3CmLB
         D3ztDIU8ymd7CsIArcE3iveO4xB3WbPwv2R+Q0ud4T9AtD7dIBoFzaZI4t1qCK8pV8by
         iuf+cI6TmvyQYfz8wbuvVDIMUDAt3CjFVbbO0akBfU0npR/Lzc4sm4GxKdmuUPUZ4ZDY
         Go4A==
X-Gm-Message-State: AC+VfDyg8o0U2UoCfyClqBCFpPOtt1DsfFKJIGabjKxg7a+seyyOrP0F
        g65fDwvz0qkwNA+yvj+64ns=
X-Google-Smtp-Source: ACHHUZ73lR1XnczC3x0Wp4xFVWEOgBB1AbBx3qaI+VIETHkAFj/aLSOBn9sYy840SoYKLbLrH+xL1g==
X-Received: by 2002:a17:90a:4b48:b0:24c:1bee:a306 with SMTP id o8-20020a17090a4b4800b0024c1beea306mr1034335pjl.26.1682612454573;
        Thu, 27 Apr 2023 09:20:54 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090acc1700b00240d4521958sm930pju.18.2023.04.27.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:20:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
References: <20230427081330.GA1461786@coredump.intra.peff.net>
        <20230427081715.GA1478467@coredump.intra.peff.net>
        <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com>
Date:   Thu, 27 Apr 2023 09:20:53 -0700
In-Reply-To: <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com> (Phillip Wood's
        message of "Thu, 27 Apr 2023 11:11:12 +0100")
Message-ID: <xmqqpm7pl2je.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I did also allow "-" here, which may be controversial, as we don't
>> currently support negative timestamps. My reasoning was two-fold. One,
>> the design of parse_timestamp() is such that we should be able to easily
>> switch it to handling signed values, and this otherwise creates a
>> hard-to-find gotcha that anybody doing that work would get tripped up
>> on. And two, the status quo is that we currently parse them, though the
>> result of course ends up as a very large unsigned value (which is likely
>> to just get clamped to "0" for display anyway, since our date routines
>> can't handle it).
>
> I think this makes a good case for accepting '-'. The commit message
> is well explained as always :-) This all looks good to me apart from a
> query about one of the tests.

I agree.  I was somewhat surprised that the big comment before that
code did not mention it, but hopefully those who would be tempted to
remove the check for '-' would either be careful enough themselves
or be stopped by reviewers who are careful enough to go back to the
log message of the commit that added the check in the first place,
so it is OK.

