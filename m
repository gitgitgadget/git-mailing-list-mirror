Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590DAC761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 19:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjC3TNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3TNK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 15:13:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C4A24F
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:13:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u10so19041254plz.7
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680203588;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhJKLnmSicgJRkd4qlw+nDEx5cfMxPAwQBUQEU3GP2g=;
        b=EhjiQRBaN8mF0NFDceW2DejFzIelCnKEDRrREUUZE35vL7FSlg59GsgN0ciSsOeM6r
         4WXbfreWfU5MMVYkAT9mwcaWfTJTY78QM5on5RFUTGGl9APlQVWf/+i2FJV6D4XbuW3M
         g2Fc14/5m4gWyXv3p83Hsmri8kQEtVgEq/Pa7IpMuxmYjdmpHvxE507VE/0t4sUWrXjL
         AUTQq1BNT0KaVaam7lHC1m3OiuTX3Tnvhu606O38tPYEFhQCC4Ujhf7gloyHV8HOXsAC
         aOZymk7zoxWV7YIytq7J01lCmrYLmH31BRaPPstMh7A6HeOzxF+eleyuNCdLMjglhBri
         xB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203588;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZhJKLnmSicgJRkd4qlw+nDEx5cfMxPAwQBUQEU3GP2g=;
        b=EYAhWElDrHKGysz9C7HcchHnO1JBcHn8XusrYHsUmNb7VzD9ZcFRUFdQbHz9ooDdEj
         w9wyu2zQG54sjssWVbqDlEBWi3z8qv+c7FC3GYuyfZ/3aOPxA50BsiYlu95uWdDKH3sk
         7gWTHgKuuv7lGhTPSpNHcvve+IFsT0JgJdL0qHT5FQYP1cwK+GbfYmV5Z8kuQWJijMyA
         59bn+Ce8x+loTmunfd2vSyP9MfQjg9iSA66B8OsV/XQbp+kDTaHjur4JWZwkIcGLqAKt
         Tf64QixqGZws70lPuQhP7GsWjgHjXU+rh2T3yhwlpMZidurFXF/2xBySs8djCN1mW9fE
         Sfpw==
X-Gm-Message-State: AAQBX9euCNq7YUXLUyQogRX+GQ1s73Q8UXRk5l6HUZhJY1ovo796UpdQ
        pmpX0t1JExU7zE330EuQ2ss=
X-Google-Smtp-Source: AKy350aJxbxYcBZzeyWi6rE5QwDiZdRZTbTT9ebESS4gOs3Y+VtrJk6CovYatcDd970dbvA4lrvGzg==
X-Received: by 2002:a17:902:fa10:b0:19f:2b42:5d01 with SMTP id la16-20020a170902fa1000b0019f2b425d01mr21265888plb.9.1680203588421;
        Thu, 30 Mar 2023 12:13:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c30-20020a631c1e000000b0050301521335sm177868pgc.11.2023.03.30.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:13:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?=C3=86?= =?utf-8?Q?var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: How do we review changes made with coccinelle?
References: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 30 Mar 2023 12:13:07 -0700
In-Reply-To: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 30 Mar 2023 11:23:40 -0700")
Message-ID: <xmqqtty2hx30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> - Is it okay to give Reviewed-By on the basis of _just_ the in-tree
>   changes and ignore the .cocci patch?

If they were made in separate steps, sure.  If not, not really.  But
we can still say "I've checked the changes the author made to the
code and they looked good."  But we haven't reviewed the patch in
its entirety in such a case to give a Reviewed-by, I would thihk.

> - What do we do with .cocci after they've been applied?

When we keep .cocci rules in tree, "make coccicheck" would complain
on any new code that matches the preimage pattern of these rules and
adjust them.  Your use of memcpy() may be rewritten to COPY_ARRAY()
when appropriate.  At least that is the theory---an overly wide or
ad-hoc rule that depends too much on heuristic may misconvert future
code, which needs to be caught by reviewers when .cocci files are
added to the tree.

> - Do we care about new patches slowing down coccicheck?

Surely.

We may want to cull rules from time to time.  For example, a rule
that moves callers of an older API function to use a newer API
function has to be kept while the older API function still exists in
the tree to help topics that are still in flight, but eventually
everybody stops using it and the implementation of the older API
function gets removed.  We should make sure we remove the rule that
is now stale.
