Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00441C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D706561054
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhJDS4O convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 Oct 2021 14:56:14 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44757 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhJDS4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:56:13 -0400
Received: by mail-ed1-f53.google.com with SMTP id v18so67522664edc.11
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 11:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aQyZCpX5DwYDSGRnF6GFLjD7HxOucQPRLsMch8lvQ5U=;
        b=fu4s0sVS2lWAygHI2XNiJcCZ0IcgtrnNfanJWxpOIWePFA+xkXA2mjovfDTxcC+kjA
         Asfb9t5SfS/u0crViTUpHO/BNfxHRnUh0j3zeIg7BgLQmy7RBHMsuNUB7Enfs8Mv4B8U
         b8mBC7+EZ7LmuQHJ02jES3L9fVBl1iSUpBKfo7ivMidzfJDdF3W+omH4bmM82xkxKXWl
         MScyt7GjdQPUdhxyZkg5hrfYIJvc3ikBO4xM/64DD/DKTOMPPPD3YUMftKUUig1Zn+ah
         Os4cUpjs/W3Z9f+YLIQdRoB5zS6eFNkgWF40bcvtMIC0rMld5xLLkG+8kvCSkxvsxLAE
         7TGg==
X-Gm-Message-State: AOAM532nETXhE2QNO72ZNT5oSzMiG6TNmr5lPRuVUpqkr0NgqqEa6cmK
        dQX71HXPWZLdQyBZTnSErAfD+uUZp1c21/UIUTtXMsNdZiJbhw==
X-Google-Smtp-Source: ABdhPJyuTg8iKnMRhPLxUt4+4tv9PU68GpmZEGnDFYoUInhVHHOC45WI8wmfr6UMBN3x6GOqOETTGJHEqyGUG7k85jY=
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr18865337ejc.517.1633373662035;
 Mon, 04 Oct 2021 11:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com> <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Oct 2021 14:54:11 -0400
Message-ID: <CAPig+cQYU+kgJrtP_Y5ZH8NpZywChxkaYjnm8OFrj8VbFWLR1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] object.[ch]: mark object type names for translation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 10:27 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Mark the "commit", "tree", "blob" and "tag" types for translation, and
> add an extern "unknown type" string for the OBJ_NONE case.
>
> It is usually bad practice to translate individual words like this,
> but for e.g. the list list output emitted by the "short object ID dead

"list list"?

> is ambiguous" advice it makes sense.
>
> A subsequent commit will make that output translatable, and use these
> translation markings to do so. Well, we won't use "commit", but let's
> mark it up anyway for consistency. It'll probably come in handy sooner
> than later to have it already be translated, and it's to much of a
> burden to place on translators if they're translating the other three
> object types anyway.

At first I thought you meant s/to much/too much/, but that doesn't
seem to make sense (unless I'm misunderstanding), so perhaps you mean
s/to/not/.

> Aside: I think it would probably make sense to change the "NULL" entry
> for type_name() to be the "unknown type". I've ran into cases where
> type_name() was unconditionally interpolated in e.g. an sprintf()
> format, but let's leave that for #leftoverbits as that would be
> changing the behavior of the type_name() function.
>
> All of these will be new in the git.pot file, except "blob" which will
> be shared with a "cat-file" command-line option, see
> 7bcf3414535 (cat-file --textconv/--filters: allow specifying the path
> separately, 2016-09-09) for its introduction.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
