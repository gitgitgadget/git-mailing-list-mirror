Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13356C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BAE20739
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 08:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOo8gsIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFMIws (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFMIws (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 04:52:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA15C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 01:52:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d15so8041140edm.10
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Autvi8PbyBvagKh13SMO/iOZapobG1h+TonbtdCIA0=;
        b=cOo8gsIyJLPKA2IPs0x+tJ8yv3qguNJ3aNE1l37mX7Jl8thwC/azBpIEJyNRKBZjMl
         CdlatvliaW3PAPWDEDtDJ9XgTuXzl7pwassulH2dTJLRCAP6G8rABsLyGdnvOUTTYdG/
         +AoIaj2v8Mp+QOiC/3K32C6/g8509iK+ZRm1NcaP1PfRJbEIbGHnwOogHOAx01nyF3f6
         6sR89AUkF0/1NnJq8sKVvf7eLkWhLgxw0rDdQgmXgHHW+hbTmMz4nj2f6K94AMrkW0Yl
         mJbhl8DcvznDjmuaB1nMd3glFWnP59zSM0DpolJo12+nflK5Cm74yaPWNAp0KKBeIc3m
         p3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Autvi8PbyBvagKh13SMO/iOZapobG1h+TonbtdCIA0=;
        b=pv94UihjqG2yqcq5mYcKABit97MXke7+yTh5l1b5hB2oxEtDaNvhPg0lPRC+tl9D+6
         yFj37U2rf9fOx/qPDpDbVvDktQl/MTZ12YQt4vBxbmSsMeddpUOiIJA+0ZiJDBlb6vJr
         S12/fCaeLDgkyEaQkkMSFU3/IJsN07hzZ7DOW1/AqWADBpikgSDSYgqLHb1Xz47TnUvh
         UQ4IMaPHimCBLBkUCfK760WB8qdbDWaMBHjVJJ12VbSrTJY4LhurYDD+Jq5yG/1sFET+
         bvRhc7fLBliG5TIXhc9MtQA2+6+SYOy2npgtGEJjmfP8oN5C1Je3nmScdJvJJ4yb5oEq
         0Ozw==
X-Gm-Message-State: AOAM532byKoI6yMcOvTmjWzkEFX8JDli1VqwyKVn6ceg/XfIobh1vBUE
        1QlOKprGjxnF3Yy8NCpjzvtroK6J1XyTFPcXu6I=
X-Google-Smtp-Source: ABdhPJwcUmgRjONkAHsHrmklub7i2KFdT9J0uOtfucI5NbcPCpICPrcNiPzksSlfaH65EJ9wG1LvilG9FAEZeOngzbo=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr14967136edw.127.1592038366466;
 Sat, 13 Jun 2020 01:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-3-alban.gruin@gmail.com>
In-Reply-To: <20200505104849.13602-3-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 10:52:34 +0200
Message-ID: <CAP8UFD1aT4dmuNkEz95eDFTE7sY+4eK_TwbTD-Vw8U7KyyZ-DA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/6] stash: remove the second index in stash_working_tree()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This removes the second index used in stash_working_tree() to simplify
> the code.  It also help to avoid issues with the split-index: when

s/help/helps/

> stash_working_tree() is called, the index is at `i_tree', and this tree
> is extracted in a second index for use in a subcommand.  This is not a
> problem in the non-split-index case, but in the split-index case, if the
> shared index file has expired and is removed by a subcommand, the main
> index contains a reference to a file that no longer exists.

As this is fixing a bug and there is no test, it might help if you can
at least give an example of something that used to fail before this
patch and doesn't after it. You are talking about stash subcommands
but it is not very clear which one for example can trigger the bug.

> The calls to set_alternative_index_output() are dropped to extract
> `i_tree' to the main index, and `GIT_INDEX_FILE' is no longer set before
> starting `update-index'.  When it exits, the index has changed, and must
> be discarded.

That makes sense.

> The call to reset_tree() becomes useless:

Your patch doesn't remove any call to reset_tree(), but actually adds
one. So the above is difficult to understand.

Do you want to say that in a later patch it will be possible to remove
the call to reset_tree()? Or do you want to say that the call to
write_index_as_tree() becomes useless?

> the only caller of
> stash_working_tree() is do_create_stash(), which creates `i_tree' from
> its index, calls save_untracked_files() if requested (but as it also
> works on a second index, it is unaffected), then calls
> stash_working_tree().  But when save_untracked_files() will be modified
> to stop using another index, it won't reset the tree, because
> stash_patch() wants to work on a different tree (`b_tree') than
> stash_working_tree().
>
> At the end of the function, the tree is reset to `i_tree'.
