Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E499C636CD
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbjA3UIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 15:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbjA3UIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 15:08:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88587303CF
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 12:08:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso12225555pjb.4
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 12:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmYFxudKeE8mqiOPo3gC3GNCWbQm5R1jBdwwggVM0x0=;
        b=FPtaPgOZ1WXa5S2URfr+iO840niinAxvnPAHoCQstmupLGM+DudFMXK+VXN0/nX5U+
         J5QvTqAyBqlYyJfiKyt62RhJk/yieHYca1ReYO8glYfKi0y7TjUOi/lIHNxUjpNB65X3
         Uq84zk57gbVMCsdcXPY9CG7lGnVYpK9q+2hdFyTP2qF7xUrGTickUAFGQj9kp6ueOw45
         GiCZFnU1r0BPPJvI0RSTt45kmy0Nj0RjY1LGcRyqmDwDb4eBpO5UguBoNvQIFzC8vzW0
         TLliTOX8BA0nLEYza03Fa6KrUEfuK1iXcCRjYo6fgh6XmGZ/CFQeQMFNCvgkDaYyJyT4
         1W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RmYFxudKeE8mqiOPo3gC3GNCWbQm5R1jBdwwggVM0x0=;
        b=u+1WGY9uUveM6KZr9Tnprf+dHlmIPsZg9/xowo5sYZygRYB1XngobRYLjGK2iVrh8r
         ucjtTgmLj8EtEBww/MuaQ0y1RRCWsmN/LBCku54/xMW69L1iI274QuNKUr0PHksoSEiI
         AgPurrCE0oZbHcVvQUR9PQJ6+G9qVIvJeqq3F2+xQBtVwsqWazWZIHGZq8BhHeQFHapX
         dvBay7IlY656meXC7e+mMPgsNiBDzxnQE/r1CBpGyxiBh9OB/rtTaamh+jQwqgZpRSyD
         VkBVTwAGicc4LIkqZZysFPaydWSpYoJvn3b+nLKNP8m056Y8DBBzzOSfMWnEGABMKlOI
         1XTg==
X-Gm-Message-State: AO0yUKUHR7FWUn2W/UhQ7t8cZ011SJZ/39kl86ZTa6ucVQPOZyRLdQ78
        m6bQLwDDYI3y3HGVz5MJABg=
X-Google-Smtp-Source: AK7set+ocm+0PP4y3MpMKq8Q0qcYXXAkB54c73KGrrVKyHglTYojeCcBvBGgf+WtqFuwJyYBNfzV9Q==
X-Received: by 2002:a17:902:e749:b0:193:33d4:d509 with SMTP id p9-20020a170902e74900b0019333d4d509mr11644215plf.30.1675109312571;
        Mon, 30 Jan 2023 12:08:32 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902988f00b00194afa2d4e5sm8238071plp.62.2023.01.30.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:08:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
        <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
        <xmqq357r4zvk.fsf@gitster.g>
Date:   Mon, 30 Jan 2023 12:08:31 -0800
In-Reply-To: <xmqq357r4zvk.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Jan 2023 10:54:23 -0800")
Message-ID: <xmqqlelj3hvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If we were to keep that "die", it is absolutely required, I would
> think.  Users who got their Git with JIT-enabled pcre2 may be
> viewing JIT merely as "a clever optimization the implementation is
> allowed to use when able", without knowing and more importantly
> without wanting to know how to disable it from within their
> patterns.
>
> But can't we drop that die() if we took the v1 route?

Having said all that, I do not mind queuing v2 if the "use *NO_JIT
to disable" is added to the message to help users who are forced to
redo the query.

And in practice, it shouldn't make that much difference, because the
only scenario (other than the SELinux-like situation where JIT is
compiled in but does not work at all) that the difference may matter
would happen when a non-trivial portion of the patterns users use
are not workable with JIT, but if that were the case, we would have
written JIT off as not mature enough and not yet usable long time
ago.  So, in practice, patterns refused by JIT would be a very tiny
minority to matter in real life, and "failing fast to inconvenience
users" would not be too bad.

So while I still think v1's simplicity is the right thing to have
here, I think it is waste of our braincell to compare v1 vs v2.  As
v2 gives smaller incremental behaviour change perceived by end
users, if somebody really wanted to, I'd expect that a low-hanging
fruit #leftoverbit on top of such a patch, after the dust settles,
would be to

 (1) rename pcre2_jit_functional() to fall_back_to_interpreter() or
     something,

 (2) add a configuration variable to tell fall_back_to_interpreter()
     that any form of JIT error is allowed to fall back to
     interpreter().

and such a patch will essentially give back the simplicity of v1 to
folks who opt into the configuration.

Thanks.
