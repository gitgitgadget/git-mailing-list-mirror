Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430E9C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 22:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCIWU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCIWUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 17:20:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD417E9823
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 14:20:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so7796373pjb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678400368;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7r2pTUpG/kbe++Qms0f6txfEBNHFlEdRVj7bhnq6iE=;
        b=MFtjnz9UcR7Ho7y17AP3wAQuyHj9ows0TzpcWaheDg8vpaGVRIo6GThqZdLtd+Tqor
         JMVnFejOY5EiT6SprZFDMURVGsPF6C7JXi0WwDIxiZBkIvhBaTX1rHXvDflkJzko8z/I
         lZuiohxFmKTlioWoDFRfh+7Cw9+++zXUgX5f2aAa8KFD9aBFkxAmw5vphNEmYQnV3KV5
         M20Eq/sD/D+w5WsSviQJztedUpyb4g/2bYRKnCztIIPzHiEvF8weRjJG9uqO8e0ZRX+k
         um2OnTLEhPOLXvr/9v2IiFr0j7sJHIV2gD6szmCGfkIyJ0eL9JU9LA8tvUuvcOJYfigA
         OK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678400368;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T7r2pTUpG/kbe++Qms0f6txfEBNHFlEdRVj7bhnq6iE=;
        b=St5iVvRQ+X+C4cXcuJqY0I/ImAWAcyYjGdoCzUnqsx3UUpU4scwD9UD6LWxwT+UeMl
         aodbtaTzAyI/47ywR6hBTzZAqo8T7pEaGXr6d8Fb6XnmPrdB9fiocWudA3cO9UPv5rvb
         R21IPqAKnpaGJ7H9hBcaqI8ibfpCkndPN0sq3t5WforvUw58n3gxPj7zJlDtGNNdRdpp
         mJsvT8tlFD8dU2slPNDUfNI9LhFbbM1HxlGQHp1fTkAu+p2wUmGwcyWGVodKyWXfC/FO
         31nboVfrrLELjFMwaYqApPfTKlZhkc5BZaSGnipOKDLr7RX/sp4qRm8kRQsxp2WK0mdC
         8ewg==
X-Gm-Message-State: AO0yUKWGKu+ix6wrnSuSFC3tikAQDDRufrsO95PZErmZlDjOpQBGSenZ
        kJlWue/HwkrbIOIRz7Zo3z1uAuTaJFw=
X-Google-Smtp-Source: AK7set/trEa5EoF5N1SflQx5BLXKpU2ktOxKZHbEaf3MPp4qSWPLM+CBzS4GzcHuIDPweJutuKfoGw==
X-Received: by 2002:a05:6a20:8e28:b0:cd:7fcf:11a6 with SMTP id y40-20020a056a208e2800b000cd7fcf11a6mr23324310pzj.48.1678400367883;
        Thu, 09 Mar 2023 14:19:27 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r8-20020a62e408000000b005e5b11335b3sm82702pfh.57.2023.03.09.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:19:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1678283349.git.gitgitgadget@gmail.com>
        <xmqqmt4nt8k3.fsf@gitster.g> <xmqqilfbt552.fsf@gitster.g>
        <CABPp-BGCgD+9s788YYmzvFHah0kik5QxbYPvWWf6mG--Pd5KPw@mail.gmail.com>
Date:   Thu, 09 Mar 2023 14:19:26 -0800
In-Reply-To: <CABPp-BGCgD+9s788YYmzvFHah0kik5QxbYPvWWf6mG--Pd5KPw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 9 Mar 2023 07:31:37 -0800")
Message-ID: <xmqqbkl18t5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm of the opinion that having sparse-checkout-related functionality
> all fall under the 'sparse-checkout' command makes sense.  In the
> past, all such subcommands happened to require a working tree, but
> William has come up with a reasonable one that doesn't.  So, I'd be in
> favor of this mixing.

Yup, I am OK with that reasoning myself.

> I'll try to get a chance to review these patches soon, perhaps this weekend.

Thanks.
