Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E86C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9919A64ED6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhCLCh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:37:58 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:44250 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhCLCh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 21:37:56 -0500
Received: by mail-lf1-f50.google.com with SMTP id p21so43191076lfu.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObVbrNF/xjlHuFVMWygIHeeTU3sf9K0GVfioR5C3d3k=;
        b=rHIz1HgSG3VmAzYjlFgqDv3H2up4Dxb3c1Ciql00GzsQEgFd1M5+07MOMvhZ9g/P2t
         zY8lN2HHLyiHK1+uMRK1Co5oETYM6lFJ7f308OXwXh0A3B1OjrTj2nOBNYaCSPrYYHLa
         HsgwSkkFkdpqfAC2ojpYq9QisQjzxTiJEfQceYPXsz/A3Q15lz6nMrGSGy8HB55kz2jf
         hxbw/QYsKxshCKHdG0pec3OCvX0eqH7l3l1PZk3eXIJsITrm2hLnzOsjTwrsxfe68i2B
         F4qtapqPuBguI7lR3B97skFZo1W4qQTnaryo1/NS/zLn9W3+oUTj4m4UuMtmwS3Zrsyp
         ZKkg==
X-Gm-Message-State: AOAM531gT0nc3eEkAVKE2/KUx7BDZOOmKfzDPNeh0dxQCDxXdDWIyunH
        3Dg6coL12XSOfUigLKir6bKqWOhtLAzi4Yj1EkFMa20j
X-Google-Smtp-Source: ABdhPJynsEtQPH4AdxPR3obzWhmLHTmyVSh6azPbvOlENCfF4Et7MMUMGy9FjeGmPPz7jPP7ZXvonIq77m1QIgTMhtE=
X-Received: by 2002:ac2:4d42:: with SMTP id 2mr4149991lfp.51.1615516675264;
 Thu, 11 Mar 2021 18:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20210312004842.30697-1-john@szakmeister.net> <YErEaJ25gY8dzErv@coredump.intra.peff.net>
In-Reply-To: <YErEaJ25gY8dzErv@coredump.intra.peff.net>
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 11 Mar 2021 21:37:44 -0500
Message-ID: <CAEBDL5VynABbrOTupEjx_mT9f8zgWaqmHQOFR-5CFYpe9xsk=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] http: store credential when PKI auth is used
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 8:31 PM Jeff King <peff@peff.net> wrote:
[snip]
> Thanks. Both patches look good to me. I wondered briefly if we needed to
> worry about old versions of curl missing CURLE_SSL_CERTPROBLEM. But it
> seems to have shown up in ~2002, so I think we are fine to assume it's
> there.
>
> It would be nice if we had some tests here, but we currently do not
> cover any of the ssl-cert stuff in the test suite. I suspect adding them
> would be a big pain to configure and maintain, so I'm OK to leave it off
> for now. Hopefully you gave it some basic manual testing with your
> working setup (good password is stored, bad password is rejected).

I did do some manual testing in an environment at work where they have
this set up.  Unfortunately, the way I went about this was not optimal.  I'll
work the issue differently in the future, so I don't have that kind of
translation
issue again.

> Looking at how we generate the server-side cert for our http tests, we
> could _probably_ do something similar for a client-side cert, and just
> configure the server to accept a self-signed certificate. But like I
> said, I'm OK to leave that for another series (though of course if you
> want to work on it, that would be very much appreciated).

I looked at things a little bit, but it was too much to take on right
now.  I could
probably get something together to help make it happen.  I've been down that
road before, so I know it can be involved, but it would be nice to have tests.
I'm not signing up just yet for that, but when a rainy weekend hits, I'll see
about taking a stab at it.

-John
