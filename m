Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4822C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5CC207F7
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKGPBbg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775372AbgJZMnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:43:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38123 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775369AbgJZMnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 08:43:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id bc23so9123439edb.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXxhhr36kBiItwA87J3XSksJaGL7WYw/GrT7GwQFlkg=;
        b=pKGPBbg39xnfH8xP3sEqvNIeLRRqePAvSIrAcvjyFTAqcrQB/8e3+Zr9pIsHqEMPnk
         g//0fK58p6QXositY5EZ/haxfTL82rYZsz8BZnERqIJ/fXWZh7raZcjaWu4WzgXoCMD6
         wy4sH9g8UYVb3W8W4fg94ASAOf7rmn+1ZVqx8gtS4RODSkbkcjbcmPOx9dcSRCqJWaeu
         KDOtVQ0BI673zV8j/FVCzq4IVwFVoX9tHmYj007tTHco8K2en+84HtGFVbsYe9aIWbe+
         IDEQQOEs8+Ub55v0sxRBTZHy3L5XW7PkVJWmi12b+GQUGrzvEa5zstaBR12cupTwEKdH
         H2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXxhhr36kBiItwA87J3XSksJaGL7WYw/GrT7GwQFlkg=;
        b=IEVgQeypMEbFvXZtf2+pBqFSW8/LWNZPo6bwAZH6vmIVxVNphEvRFzOSpLqH28HBAD
         v0v1L3JHaGXsYCOAxozOuMCl9t2l7NgMX7/w+FUXQ5B4bbjbU4Xsjp9BX/dDDwzwM3Zv
         mUWIPB6iXOGt1bayJvhvpGFceLBmHyUG5rBIuirqD0WgtYQNpYIYXUCxUra+EGKQm+kz
         XEo1Hlu9TSUTngKIiCvUWclGor0aFIDpSyQBKo01zLYF7M6tHvI9V3RFnFi0baWtSB/5
         kkwCV18C6Ut3azecLp6unfW/XG4825Xk+fL8vi4aSrELViloJHeuHA818dzv2kZDKoyh
         yXcw==
X-Gm-Message-State: AOAM531JpPeBbEG4KmdrXH6IegYnD/X+F9cF67iE2wPu2FaAHz70kyDi
        IBnIqDR9fN5bXiw/kMwfgoBgCC4xx2LkotKBJuQ=
X-Google-Smtp-Source: ABdhPJxFzVd1MjyRHLATc7WR85RpTxkATdlIfoYLwGdWb7qPCZZJkUs/Gg/AQrX2txjWG4Mw39FtTwMTnlCPNL3IxWc=
X-Received: by 2002:aa7:cd98:: with SMTP id x24mr15085896edv.237.1603716220484;
 Mon, 26 Oct 2020 05:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-7-anders@0x63.nu>
In-Reply-To: <20201025212652.3003036-7-anders@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Oct 2020 13:43:29 +0100
Message-ID: <CAP8UFD1nYgqT1k1Mc=Ea3AZkb-TdhPBzXo+N+4nWgYVxEBxzRA@mail.gmail.com>
Subject: Re: [PATCH 06/21] t4205: add test for trailer in log with nonstandard separator
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:
>
> ); SAEximRunCond expanded to false
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>

Why is this new test important?
