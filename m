Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA14AC636CC
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 03:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBQDMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQDMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 22:12:21 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B753832
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 19:12:20 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-169ba826189so5055878fac.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 19:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tc3BSfFv4jm6ZON0bkUkHTaiTZD0dKResQSXOaxUDVI=;
        b=Em0ixzvmedQ0xFiF/y0E9WgQS85rHNR+MZqCAHHjfX2VlYKf9tEHqYsP5mv5hmIbeK
         2kMMq260blP7dXyhhm+YJy6HJfW3VlROEYKo08XRLA9dph0O50/mmr/g5foXCISmmIQS
         LTM22kCFJyt2Xz/yfP6yL9ZmROVXaJK6+fn+r+fMcb6CbpXZilrtohanFo5I77nydSzR
         z3psf99i54sPkUZgZmOR761GkxH+vjqEV2Yrp2Owyn+fGtV4v4gEK3UMu0MqjmlqoZUL
         nhJ22MIlYL5zZrwaScikXSyijbR5Ncptv4w8IJX3pABDB+WOjB4cmrj7yKREanrD8ITI
         rbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tc3BSfFv4jm6ZON0bkUkHTaiTZD0dKResQSXOaxUDVI=;
        b=XVc93HQWk/QkDo8QuxLh2IbFnEzEiI8AlWENMsS0RXbAyMmtI2u9UKVv5JZO9QPQXK
         vGYG/W98v+fLovTF+2Fx9E75AS+aohhUwLIwFCvAbXJ6b5Km4xh60TbAvZfr9eAxi2TU
         Bqqym1ZS1WOMFKTMadLknZm6JauxbJ5vZgTOXItV7EgzSJxzX3GCrhmzypXuLsYK3Cic
         PDJ9acNJV45sZ0NQvjdM0ohEUnQsa5r1zWsog0vWgCqQADxlj6w3tctYq+t6EHQ8J+ie
         J7Hiv+8VswRmVedLPjwoPUaYLog3HHwESKx1mqg04/obi1CKaTnUgss2iALFsiji+0U3
         VAJw==
X-Gm-Message-State: AO0yUKUyU6m6LtlNUWRnV2nimmgfuOKgc98dmjh4Z+B3FKTJu1ms09DO
        pW+1JnZuZ3OBhgp7vxvGu7B0RXTRMPBWjc3KGhIJ4joL9vw=
X-Google-Smtp-Source: AK7set91igHt8WxI9NEroESccpUSLJru8PA+kLTl+n3ppQS4n3VRbHSiFgzqNEEaUW6p6IGTSaZEq+mbAD4FVpDwdH4=
X-Received: by 2002:a05:6870:5d06:b0:16e:4b62:df20 with SMTP id
 fv6-20020a0568705d0600b0016e4b62df20mr301004oab.141.1676603539751; Thu, 16
 Feb 2023 19:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20230216193210.6yj24zhhdhoozpr3@carbon> <xmqq1qmpp7bh.fsf@gitster.g>
In-Reply-To: <xmqq1qmpp7bh.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 16 Feb 2023 20:12:08 -0700
Message-ID: <CAMMLpeQgxPCTsWGr58rutSDnRuGAGcTXTvHLcgWAfzZjZGxakg@mail.gmail.com>
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 3:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Konstantin Khomoutov <kostix@bswap.ru> writes:
>
> > Alex Henrie <alexhenrie24@gmail.com> writes:
> >
> >> GitHub and GitLab have features to create a branch using the web
> >> interface, then delete the branch after it is merged. That results in a
> >> lot of "gone" branches in my local clone, and I frequently find myself
> >> typing `git branch -v | grep gone`. I don't want `git branch --merged`
> >> because that would include branches that have been created for future
> >> work but do not yet have any commits.
> >
> > Possibly a rather silly remark, but you could make a habit of periodically
> > running
> >
> >   git remote prune <remotename>
> >
> > or fetching with "--prune".
>
> Likely to be a silly question, but isn't doing that, to actively
> remove the remote tracking branches that correspond to branches that
> no longer exist at the remote, exactly what gives Alex many local
> branches that are marked as "gone" (i.e. forked from some upstream
> sometime in the past, but the upstream no longer exists)?

Yes, the branches are marked [gone] precisely because I configured
fetch.prune to true. So fetching automatically deletes the local
copies of the upstream branches, but the local branches that track
them are still there.

-Alex
