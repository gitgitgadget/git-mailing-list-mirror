Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D3C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC14233FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbhAGSSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAGSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 13:18:15 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F42C0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 10:17:34 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id e20so4099948vsr.12
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VKEXqSsWkXkVK9cEtgRbEQD68J/NSkZdG1FfP0MSHrE=;
        b=EooQH+tYbIBBvYEoGWcdS4L7NPQN8EaAy9k6yKPL41fw1bly0+owLvYpHkMJUP/FLC
         s72GxkDTu8+P3lPKMgCfHzMA4zfCyzQZirY0z4kHWKt5BLdQbVEolPnUr94liEbnBmva
         moQ94MSG0oI4dMfv8aRgeeYp0PDHrA/On59npF6iLCAHULTSpgQ1K0r7OYaqgSlMtxFX
         2mDwNft6l2wk5H9HBsh9TkSbzjN6Vvm9E3RkB9Tg/J2sxqxGMNxJWpv16HFfCugO4sRh
         ygrwpFW9Krt56SO7SPEoEJE3BlgZIxGuKR7VADUbJ4OfbxMdXSVzRbCitWLg/sBz+aMD
         QM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VKEXqSsWkXkVK9cEtgRbEQD68J/NSkZdG1FfP0MSHrE=;
        b=FJ1oV0IDRizietRPWoM+Y16+/oa7AnTyNeqoCfVKqUo3OF0yWoUkbVC4dj8elYIQ44
         CC6/RqqND3pHDbg4VmeyvEUGEoOL2VSu4uKN+i6exPfmw6juQZuvVkOCzQaSsKRiE+hT
         VIvU+RHDJoL23eBPmdqAjHq58IP3xyNkSijt3xPE224GS7IpUQM5BUnaeUkLnhCAv7nq
         rOUsY/kYEAY0DGUIV4f3YDmE2ThJH3GKHWfAitO/J+T+wzqfSFltvvIg1/czbS+YjFdI
         en2Hma4nE+nO8GiBviRQk8opH6z6J8OxTW3FnyR2nI8OT0hhWMeQc5zVPLAooxIjjvMa
         gYAQ==
X-Gm-Message-State: AOAM5302o9Jo5b/adP/Uh6I/ewHuBNShTx/C4d+jqFpADCqucP+ByQG9
        kpwgHeVhK67v57H+ZSkoU/SaZE5ZnxKpq5MrGn11k/EioJc=
X-Google-Smtp-Source: ABdhPJyBKf/u77OOjJKv4gcqsge4PDclrsIQ7usGnhAvMLmiwMxTHAin4S0f8zGYTZtF2LxuyxkST2WNxaskdL5/1EA=
X-Received: by 2002:a67:dc98:: with SMTP id g24mr8434923vsk.29.1610043454204;
 Thu, 07 Jan 2021 10:17:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609874026.git.martin.agren@gmail.com> <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
 <xmqq5z4as2j9.fsf@gitster.c.googlers.com> <xmqqim89pu9k.fsf@gitster.c.googlers.com>
 <8ae92e79-ef13-3faf-2fc2-d4b107e73c36@gmail.com> <CAN0heSqdphJWgG6gLM4a8mrDLh6qGUVq5w2FYAr7g8uePrcd2w@mail.gmail.com>
 <xmqqft3dma54.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft3dma54.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 7 Jan 2021 19:17:23 +0100
Message-ID: <CAN0heSoK21Qx_x-69KtmuScU6cN1SqB45ptgDwV8qpeh1iTC0Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Jan 2021 at 09:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > I could add a remark in the commit message of the last patch along the
> > lines of "After this commit, renaming the `tempfile` field only trigger=
s
> > compilation errors in lockfile.[ch] and this one instance that we're
> > intentionally leaving here.".
>
> It would be a nice addition to the log message to help readers to
> feel confident about the conversion.  It is OK if you want to add
> one, and certainly a good trick to have in your toolbox for your
> next conversion, but it may not be worth rerolling only to update
> the log message with such a remark.

Ok, got it. So I'm not planning to reroll this series. Unless something
else shows up, obviously.

Thank you.

Martin
