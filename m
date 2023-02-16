Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F5C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 18:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBPSBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjBPSBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 13:01:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577137737
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:01:33 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so2915858plg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aVD03Na274uX8Lbe7awGDT17ZcdDIPaAZlH41uD0VI=;
        b=lXNbeQ3zOk0cTpf+AipQ3yOKhDgRimA26bfgMfkrGWN0rIwqu6DHpfRL/q008+wqSr
         uqAD9flcdUPAQ9d4KyE13/GoPe/gUFHlnilk059irANDASacJ/DkgL05kGgqJEOqPrsr
         1REW26oe1dlPMZu6Fql9ebU8Z9BxU2z27Xp9BveObpeh6xBC/2Laavr0leLpxuu7A+XB
         kTbKx6HgsZSMK79q5/3ZcHB1dprXxZJr9HqRCjpZU89ii0Ch0gZD19xOGYw2n5upruuR
         wNIfi82txU5TkLm3hl0kbo9YTBzv1fhgau4PprrLoZ1iT1xCuuHCAjWVyzSzQJOwXFx1
         nf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6aVD03Na274uX8Lbe7awGDT17ZcdDIPaAZlH41uD0VI=;
        b=L3sqWzb/ppB7vC3BxIDbJ3XYc0hV7k/BjjWfnoSJgv858zND+MetPH4ZOj9Phj3JXa
         qo39eYxCoYvCQka0W1Ntli/B7y3Dh82Jkr8lek0JOiMLcd/SRJEPP9+QsofBB9qLZ80A
         c2ew/H3kZkBxFJNJyiyQ1YryvJBQT418V4tYT77iAUipN45fjpqZGsKSJ5inyT+tJ6z4
         z5diKSjNIdMXCRGATmCGlCb9oTDLTFirwoJzphyNnaXSB01KrOxBzZN//krehN8AIJob
         wF8MqwM75wGWFEFxrTYCleUTnPhjUtg6cbJmF4OwwuSouT9xkatJwh74aWniKwfSxon/
         2kVQ==
X-Gm-Message-State: AO0yUKXBS+28MFL/GVXbTitBGU/q74N5mq9JzcmZ6Yc/AVCJg1Fpn1ZK
        KZVv4lyWmfaLL3fujSxcpEg=
X-Google-Smtp-Source: AK7set+d5IV7hMiC/Agl+QtqidJ9aVhJWHRzf7/8wA6b9OLKaZ91Wck+/UXr3Sdgg+ObLzv2ckbfgw==
X-Received: by 2002:a05:6a20:1f2a:b0:bc:c9a8:6e08 with SMTP id dn42-20020a056a201f2a00b000bcc9a86e08mr5150921pzb.48.1676570492633;
        Thu, 16 Feb 2023 10:01:32 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b005893f281d43sm1595531pfm.27.2023.02.16.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:01:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: fix segfault when freeing island marks
References: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
Date:   Thu, 16 Feb 2023 10:01:31 -0800
In-Reply-To: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 16 Feb 2023 11:29:48 +0100")
Message-ID: <xmqqbkltqykk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> In 647982bb71 (delta-islands: free island_marks and bitmaps, 2023-02-03)
> we have introduced logic to free `island_marks` in order to reduce heap
> memory usage in git-pack-objects(1). This commit is causing segfaults in
> the case where this Git command does not load delta islands at all, e.g.
> when reading object IDs from standard input. One such crash can be hit
> when using repacking multi-pack-indices with delta islands enabled.
>
> The root cause of this bug is that we unconditionally dereference the
> `island_marks` variable even in the case where it is a `NULL` pointer,
> which is fixed by making it conditional. Note that we still leave the
> logic in place to set the pointer to `-1` to detect use-after-free bugs
> even when there are no loaded island marks at all.

There still are unprotected uses of island_marks in delta-islands.c
after this patch, but I think they are safe.

 * The callchain deduplicate_islands() -> mark_remote_island_1() ->
   create_or_get_island_marks() assume island_marks is not NULL, and
   the only caller of deduplicate_islands(), load_delta_islands(),
   initializes island_marks() before calling into it.

 * set_island_marks() assumes island_marks is not NULL.  One of its
   two callers, resolve_tree_islands() ensures island_marks is not
   NULL before proceeding.  The other one, propagate_island_marks(),
   also assumes island_marks is not NULL, and is called only from
   pack-objects.c::show_commit() when use_delta_islands is set.  It
   is not apparent if island_marks has already populated when this
   happens, though.

I think early in the pack-objects process, prepare_pack() calls
resolve_tree_islands() but as we have seen, it just punts when
island_marks is NULL, and not populates.  But get_object_list()
explicitly calls load_delta_islands() when use_delta_islands is
set, and that happens way before prepare_pack() gets called, so we
should be safe.

Thanks.
