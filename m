Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF6ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiHaW0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiHaW0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 18:26:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A679EE6
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:26:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x19so13922550pfr.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=A0OeSVrIz+5YRCiNaHfk+T+azMqYU+qnnaYE1qcpzkc=;
        b=mNwjh0XD9QadKHn5J51YC16aPtorunfmBcDnqOpMnHKl/1BrmNo1lBpztZSADE4kty
         kPH5updJbWyC78LrbeWpNxaT8UqtGAIvvSspY27i0ucH3xryBuYceOv9yBsK3rfC3yq7
         /8XS9A2Dk8/vpk1svnDAxBfwQCuQyCR0voKo+NVJRtka6YHHO5IjlK4NoxvgeAGMkefY
         6MXEaKWZOyTNepB+OfTIAcg29/NSmcPIiGw2FkaOHTzDd33rN8mo4RrwWcfJcREMX0LP
         /LckFFKxfmzJhg5ENtVwE25fjlx1aO8ow9A7c5/UUUG4faVYfUhdJgNk7VBhHM0DVy+6
         ipJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=A0OeSVrIz+5YRCiNaHfk+T+azMqYU+qnnaYE1qcpzkc=;
        b=JGb1gB6/ooo7HWLqv06lKnjJmUGbqhQgy3zz7f+exTfx/XFCF4DSqCB9u5wlnn9TlJ
         i8QvZBTsczq3tXW8SMJDyrwtpVjtPxRWWADoGArolty6ZfXz/SmHLWuhzutqrE7d1Pqr
         aEkzk+2QfecXxg3AcmrwZwv+DEFjIzQZ/kVADP6kxRMyd8lEaE5G9I1SR3Kw9vvPgU/K
         QAnFDf7L+HKC/6vms6wB06FpAyeb6xwUfpvmv4tlQlZVJZsMss2Mv/HlHGZamsJNaLJQ
         AkNf3Eblk6p2NwoD3UqMGN1cPUAlc2krrLC35Kz8/kdmoBB+Oy0EPvuBzL27uPbsb/Vk
         pSkg==
X-Gm-Message-State: ACgBeo0N8nvqgF+jQfbyDq0A20e5dkolD/DdinygRJOzaWzldRPSWqTb
        D7fnRub2q7vbhhXWUGm+3Lw=
X-Google-Smtp-Source: AA6agR7ytlZUsBx3IKgcxbSJHy4A25nahQ53lsJ2yL7kDe7BmX1aoLI0vyQeLeqw4E9rd3lon/s1GQ==
X-Received: by 2002:a62:1b05:0:b0:537:b60b:cc53 with SMTP id b5-20020a621b05000000b00537b60bcc53mr28956322pfb.66.1661984762097;
        Wed, 31 Aug 2022 15:26:02 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p4-20020a637f44000000b0042b93a2b1e6sm3989416pgn.31.2022.08.31.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:26:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] diff: fix filtering of additional headers under
 --remerge-diff
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <feac97494600e522125b7bb202f4dc5ca020ca99.1661926908.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 15:26:01 -0700
In-Reply-To: <feac97494600e522125b7bb202f4dc5ca020ca99.1661926908.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 31 Aug 2022
        06:21:47 +0000")
Message-ID: <xmqq7d2odp8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Commit 95433eeed9 ("diff: add ability to insert additional headers for
> paths", 2022-02-02) introduced the possibility of additional headers.
> Because there could be conflicts with no content differences (e.g. a
> modify/delete conflict resolved in favor of taking the modified file
> as-is), that commit also modified the diff_queue_is_empty() and
> diff_flush_patch() logic to ensure these headers were included even if
> there was no associated content diff.

In the longer term, I think we may have to redo the way additional
headers are inserted to the diff_queue.  All the diff code I am
familiar with (read: written before this hack was introduced) trusts
that diff_queue.nr is the number of paths that are returned by the
diff frontend, and unless there is diffcore_break involved, there
will be at most one diff_filepair that is about a path.

Why do these need to be separate entries in the queue, not a new
attribute added to an existing filepair?  Are we inserting pieces of
information that are not about any paths that are involved in the
diff?

