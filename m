Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E1C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 23:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiBBXKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiBBXKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 18:10:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC16C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 15:10:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w14so1685464edd.10
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 15:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+p1NKZe+pnImepVZII0DZuMMvV6wYdyzIRqFRBFtE0=;
        b=iVfQO2gYRqYHEXDsmUreNRJlL6hyAA0nHy/OqPeGia/pjx4UFgR8drYRm6XjjWDqet
         MgR3rRgR1xjOG7FEtprIsHgWzSiwp91ZRc1eCM/z8fBICtZ79WvvGrcqAEU0sKDRPawv
         MkgjxG5Ik1PmznA3JlDAJYc17v7zPFsJO6eriz+25dT0783LhAORKBGyq3I9CNHTxDhd
         uArqrWNQix213glcn0C05XAsovmUQ07q3Hm73fqyJ6dXiDWcpewBufs9Igq1/h3RiqM/
         EXSZ92TYoe765JGCSo09cE8RAA/Xr7pKju5QtZvvq0yNVlnyvxFJZlD08mqJ4oZDcIiL
         j59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+p1NKZe+pnImepVZII0DZuMMvV6wYdyzIRqFRBFtE0=;
        b=AQjSVo5kEK+2jg2wFoVyekQd+ECvNYhhjIxmxYuPyEfdBuAmiynYIMmNKBl/l3HkqX
         EfBUu4eppr5C6ZE1W8u/Lzbi32Dk23RF7c529wx/JIK+v7f6qRkf4xqYaKNJxoT7Cbcg
         PlFKx0XN/8lGuG4bZpX1kfg1kGtSbyCh0B+Fl3DAUI+xJzjsqJf4Jh6eD+i3Fq3p6Pn3
         +jXRmCnGZlj1uOxhIdPZw4jHnFq6+1Yw74GR6L0I114aIoDLke88eVPGWcj+kQ6KCoAJ
         5wTybgKXj2EKW0GEdJRWVtvVeyD2hnkIgA1UfO87BsX30jxa1WrmCzD2B540bYmARZcp
         LdDQ==
X-Gm-Message-State: AOAM530HWrA0/xKLimuwvRK/z7jAigLhdcx53RfGNv9nMzDQCFftfcy7
        HdlMcRfv6LUXKbwUV4/1HcxeUDxlVXlIZxvApyU=
X-Google-Smtp-Source: ABdhPJwP1C0gGlTBlmz+6xwH0AAcVU8Lba+I8dXBpMZPhTJRvGp2XugSOenbTS1EH3K1XAufjWeStIt1VSRQXwIHAFM=
X-Received: by 2002:a05:6402:b8e:: with SMTP id cf14mr32269415edb.196.1643843403842;
 Wed, 02 Feb 2022 15:10:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <d0d30e92ecd9dff6174a39a94a9e7d7e29896fd4.1643479633.git.gitgitgadget@gmail.com>
 <xmqqh79hx8g1.fsf@gitster.g>
In-Reply-To: <xmqqh79hx8g1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Feb 2022 15:09:52 -0800
Message-ID: <CABPp-BHA-w5g5gkVOrxaXEEvDA1jhmge+AA8DOBG-r-o3RwGBQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] merge-tree: support including merge messages in output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 1:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +By default, for a successful merge, the output from git-merge-tree is
> > +simply one line:
> > +
> > +     <OID of toplevel tree>
> > +
> > +Whereas for a conflicted merge, the output is by default of the form:
> >
> >       <OID of toplevel tree>
> > +     <Informational messages>
>
> Sounds useful.  This made me wonder, as the only shuffling of the
> output destination in the past few steps were to send the output to
> some "FILE *", how you send the findings you make while coming up
> with the result _after_ the result.  It turns out that the ORT
> machinery already buffers these findings in a strbuf per path, so
> there is no trouble doing so ;-)

:-)

> It still makes me wonder how the "send rename warnings to the
> standard output stream, instead of the standard error stream" change
> interacts with this change, though.  That needs to be done way
> before you finish computing the result, and it does not seem to be
> buffered in-core, like per-path conflict information messages.

Actually, that's also stashed away in detect_regular_renames() from merge-ort.c:

    if (diff_opts.needed_rename_limit > renames->needed_limit)
        renames->needed_limit = diff_opts.needed_rename_limit;

and then the call to diff_warn_rename_limit() is deferred until after
all the informational messages are printed.  Also, this series
modifies diff_warn_rename_limit() later to allow it to send that
message to a different stream.
