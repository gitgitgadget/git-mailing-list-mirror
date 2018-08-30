Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605B71F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeH3Sxw (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:53:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54639 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbeH3Sxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:53:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so2292692wmb.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D0TplLh4XY/iHgYmN2aX6vV2jPSiXL7+29CAdn6lI/Y=;
        b=mr1rKe+PDTPzGWsFFroxmMEzdEu1woJEToFMEDHtqH2jZoh2GmqF+HcFMVVfWlan+D
         fQ1QXoP8gatuvfjnuydiED4yQs7CfHom5vexpL7RL1h11NfJKRihktTRpLX40F7z1pcJ
         AoQGhZu6qU8AIftGi4XMFMLNGw8XCh1SqLO91Yxw8hjnqRjqEBqRRAgW+k2wSoNU3QQt
         SBpn/mjZCAeabH/VluRQxFCyvPpnk3DSJr1dwnpfH/MzbdDkCb7KhWzheoAT6w98hUun
         OTqAzYznul7N04Yy3d/EZzEzs98dpvs2mF68A+bUh4RlfmZgX10bBtPPW/jfY2pCgBp9
         Eq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D0TplLh4XY/iHgYmN2aX6vV2jPSiXL7+29CAdn6lI/Y=;
        b=H06q/S8Ghq1emvJFYOTe1YgNWhmyd5YS/dfe8hycMqXkxaUZc881qEJBs6JyBJnCtM
         KnS2Jt2d5be7MBDH7XVv/nnRO6pv9njtfJq8YxWqfIl2+S0unKX9XcdWxk1K+YZCu19G
         z0YCzlkBAZEJKDH82C+Ff1UX0aLHwe7FrU9YjkzIWwaUN6XB2hJpb+g/3KWgcbcC4168
         5FVUK6nAz/4zoL2R6qccIlJF61XrroQ3la5GvcaqQ+sYeFlEpnq6629Cj9kWPBcRCMXb
         5CiObF/YTzKnB0IbupiMZDFcyJsKBxVbSl7A7b7FuMAugK85cvkA7HP0ef84uOSePlL4
         F+bA==
X-Gm-Message-State: APzg51DIkED4DGoxq1TAOKz2x9X6sczPoxWuigb/w1rMD4HvFS0BfryZ
        Rzq6mDJ36Is5+nzuFkq7UDg=
X-Google-Smtp-Source: ANB0VdYHb/RtjbxNiMaEe29sWEh1b5ocz3ee0j72hWFrfGLhXNggloI2Dx4/NQeC1v9QZKzLX0PegQ==
X-Received: by 2002:a1c:65c4:: with SMTP id z187-v6mr1948908wmb.157.1535640679096;
        Thu, 30 Aug 2018 07:51:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j75-v6sm2184591wmj.8.2018.08.30.07.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:51:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Jochen Sprickerhof <git@jochen.sprickerhof.de>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
        <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
        <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
Date:   Thu, 30 Aug 2018 07:51:17 -0700
In-Reply-To: <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net> (Phillip
        Wood's message of "Thu, 30 Aug 2018 14:47:04 +0100")
Message-ID: <xmqqwos77vru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> When $newhunk is created it is marked as dirty to prevent
> coalesce_overlapping_hunks() from coalescing it. This patch does not
> change that. What is happening is that by calling
> coalesce_overlapping_hunks() the hunks that are not currently selected
> are filtered out and any hunks that can be coalesced are (I think that
> in the test that starts passing with this patch the only change is the
> filtering as there's only a single hunk selected).
>
> This is a subtle change to the test for the applicability of an edited
> hunk. Previously when all the hunks were used to create the test patch
> we could be certain that if the test patch applied then if the user
> later selected any unselected hunk or deselected any selected hunk
> then that operation would succeed. I'm not sure that is true now (but
> I haven't thought about it for very long). We could restore the old
> test condition and coalesce the hunks by copying all the hunks and
> setting $hunk->{USE}=1 when creating the test patch if that turns out
> to be useful (it would be interesting to see if the test still passes
> with that change).
>
> Best Wishes
>
> Phillip

OK, I marked the topic as "will merge to next" but unmark it for
now, as we are not in a hurry to graduate new topics to 'master'
anyway.  Hopefully between Jochen and you, perhaps others, can
explore the issues you raised and come to some conclusion before it
becomes necessary (i.e. when the next cycle begins).

Thanks.

