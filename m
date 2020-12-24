Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03645C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 04:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48B322AAC
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 04:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgLXEs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 23:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLXEs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 23:48:58 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE2C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 20:48:18 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id x16so1916122ejj.7
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 20:47:36 -0800 (PST)
X-Gm-Message-State: AOAM531fas7fTab+WvyHu6/IVsrbpYV35uem2Jvpkz9oZOQLpg5YlS+C
        aZHu5EmYDMaVkge2iO80EE61pLUL2USGzgeNdsA=
X-Google-Smtp-Source: ABdhPJyQdKhNwpYKO8/z76Hu6ywkJuTaWS6yX69TEItV7E1sfTkae+zrYQqIM3xPQ0GEcidet3JGmw0CoTF9PvmzSqk=
X-Received: by 2002:a17:906:154d:: with SMTP id c13mr13988068ejd.471.1608785254035;
 Wed, 23 Dec 2020 20:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20201221034452.307153-1-mattst88@gentoo.org> <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
 <xmqqsg7w8fwx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg7w8fwx.fsf@gitster.c.googlers.com>
From:   Matt Turner <mattst88@gentoo.org>
Date:   Wed, 23 Dec 2020 23:47:22 -0500
X-Gmail-Original-Message-ID: <CAEdQ38En=HrG9A0STgaxFAwqxBjwNGQoV=U26Pia3x=gd-Attg@mail.gmail.com>
Message-ID: <CAEdQ38En=HrG9A0STgaxFAwqxBjwNGQoV=U26Pia3x=gd-Attg@mail.gmail.com>
Subject: Re: [RFC PATCH gentoolkit] bin: Add merge-driver-ekeyword
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gentoo-portage-dev@lists.gentoo.org, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 23, 2020 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matt Turner <mattst88@gentoo.org> writes:
>
> > I want to handle conflicts automatically on lines like
> >
> >> KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
> >
> > where conflicts frequently happen by adding/removing ~ before the
> > architecture names or adding/removing whole architectures. I don't
> > know if I should use a custom git merge driver or a custom git merge
> > strategy.
>
> A merge strategy is about how the changes at the tree level are
> handled.  A merge driver is given three blobs (original, your
> version, and their version) and comes up with a merged blob.
>
> In your case, you'd want a custom merge driver if you want to handle
> word changes on a single line, because the default text merge driver
> is pretty much line oriented.

Thanks, that makes sense. The merge driver I've written seems to work
great for handling the KEYWORDS=... line.

If users could more simply opt into using it (e.g., on the command
line rather than enabling it via ~/.gitattributes) I think it would be
fine to use. Better yet, is there a way git can be configured to
fallback to another merge driver if the first returns a non-zero
status due to unresolved conflicts? For example, if there are changes
to other lines, how can I fall back to another merge driver?

Thank you for your advice!
