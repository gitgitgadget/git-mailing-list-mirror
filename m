Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D67C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 17:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbiHHRoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiHHRnf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 13:43:35 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3EAE0CA
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 10:43:35 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so11313994fac.7
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1gyuqg8u4wnNAdv3ZAZB1sMRvNcQro+gHORjN8IQI78=;
        b=lj2wPR1vYYNoFN01B9FFlN+bylSqKdribrUu2El2WdmXqkl/D2JqSY1xjuNfmjFqVp
         m8F0TtrR6PXg54/65s9kLYKNKxss5UhQ4LbAK4Dp06afQSVdxtU3DIK1UUnKp8v3CTy9
         aSykTP6UkGov70IHPH/b59zh2fa/36TPlgIY0x4tLgW7oBYIib60JHfyYW652utsh4WF
         dAHr4Sw5xIPlFlEltkgGSsIrTzezrRMZU/AhcFaH4bUOEWVLrGRZC3RefOGkRMJ7DklK
         gPRWY6w8pgmRwUt29rc5eU2mHshMs4jyb59VSn3xT17eZmfwLqc3M+BL1KG8kfsODX8R
         P2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1gyuqg8u4wnNAdv3ZAZB1sMRvNcQro+gHORjN8IQI78=;
        b=moeTtMtvmX3vyNP7zhtSFXDgcAiifxP5+hPnxVf2YZiwZVLHkLk3ubkzNQep0hmU8X
         5RNJXZE6VabSsVKBC+t00U3QYerAUej8uR+ScezC9JbTJomM24pW97v1VMYfjs7seaJq
         GNUUtU/e2QSmQQ8dhLSnW4k6VaOkxVSEDk6vgMHhDg/mWaepP0j7Y/yWgCYEZq8DvILx
         SvEhXRnwrtMplsG9ZuiJmAmdntDxSP//oXrQYdLUbrasdWDE5jqGXjuJjxapkj7yxgle
         Av3cCU8dJ193nG7r6rUIdoc5C8WIUdFkEgTJxKa323WGxgV0rVn8GxvIRuICThJUWuui
         nREg==
X-Gm-Message-State: ACgBeo0iQ2Uvln/astwdPGL3Zn7b1m3mMq4drnKTLYB8uyYi3YAKlBzd
        drnlFCvE+hKCl/94Fain29jLoao5lsJdLFG/NHVca5M6qts=
X-Google-Smtp-Source: AA6agR5bosugCigqC1qpqtscozS4V8tWlnZBZY5UEXjEuXZNeOgyZgDBw6xEVhETGzzdRQN2Tl1T3SxG4h3GkCUvn68=
X-Received: by 2002:a05:6870:8328:b0:10c:fdf5:3be2 with SMTP id
 p40-20020a056870832800b0010cfdf53be2mr8977119oae.4.1659980614264; Mon, 08 Aug
 2022 10:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com>
 <20220502170904.2770649-1-calvinwan@google.com> <20220502170904.2770649-9-calvinwan@google.com>
 <CAOLTT8RyDCokvJBaC1CCoT2+3AE1kOn7evjkTMK_V6KWoaH30g@mail.gmail.com>
In-Reply-To: <CAOLTT8RyDCokvJBaC1CCoT2+3AE1kOn7evjkTMK_V6KWoaH30g@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 8 Aug 2022 10:43:23 -0700
Message-ID: <CAFySSZDMwMa-RFLVeAONnySrmsg53G21mXd-BDjyZEpyAVbMbg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info command
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.email>, johncai86@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >  `rest`::
> >         If this atom is used in the output string, input lines are split
>
> Why not forbidden %(rest) here too?

Good catch. This should definitely be forbidden. I thought at first
this was inconsequential, but since I also have remote as part of
the input, this would no longer hold true.

> > +               if (strstr(format, "%(objectsize:disk)"))
> > +                       die(_("objectsize:disk is currently not supported with remote-object-info"));
> > +               if (strstr(format, "%(deltabase)"))
> > +                       die(_("deltabase is currently not supported with remote-object-info"));
>
> %(rest) too?

ditto

> Maybe such code style will be better?
>
>         if (!gtransport->smart_options) {
>                return -1;
>         }
>         ...
>         return transport_fetch_refs(gtransport, NULL);

That does look better!

> > -                       cmd->fn(opt, p, output, data);
> > +                       if (!strcmp(cmd->name, "remote-object-info")) {
> > +                               char *line = xstrdup_or_null(p);
> > +                               parse_remote_info(opt, line, output, data, cmd, NULL);
>
> memory leak: "line".

ack

> > +test_expect_success 'remote-object-info fails on unspported filter option (deltabase)' '
> > +       (
> > +               cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +
> > +               test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
> > +               remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
> > +               EOF
> > +               test_i18ngrep "deltabase is currently not supported with remote-object-info" err
> > +       )
> > +'
> > +
>
> %(rest) too?

ditto

> > +test_expect_success 'batch-command remote-object-info file://' '
> > +       (
> > +               cd server &&
> > +
> > +               echo "$hello_sha1 $hello_size" >expect &&
> > +               echo "$tree_sha1 $tree_size" >>expect &&
> > +               echo "$commit_sha1 $commit_size" >>expect &&
> > +               echo "$tag_sha1 $tag_size" >>expect &&
> > +               git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
> > +               remote-object-info "file://$(pwd)" $hello_sha1
> > +               remote-object-info "file://$(pwd)" $tree_sha1
> > +               remote-object-info "file://$(pwd)" $commit_sha1
> > +               remote-object-info "file://$(pwd)" $tag_sha1
> > +               EOF
> > +               test_cmp expect actual
> > +       )
>
> Can we support <rev> instead of only <oid> here?

Not at the current moment. The server is unable to handle
anything besides oids.

>
> $ git cat-file --batch-check
> HEAD
> 28583b8d8ca72730d7c9e0ea50861ad431a6dea4 commit 3038
> master
> ab336e8f1c8009c8b1aab8deb592148e69217085 commit 281
> origin/master
> 23b219f8e3f2adfb0441e135f0a880e6124f766c commit 282
> origin/master:git.c
> e5d62fa5a92e95e1ede041ebf913d841744c31f8 blob 28398
>
> So cat-file --batch-check can support it.
>
> $git cat-file --batch-commands
> remote-object-info "file://$(pwd)" master:git.c
>
> I guess it cannot work now, right?

Correct.
