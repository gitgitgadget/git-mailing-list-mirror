Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11266C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F6461206
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFUN60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUN60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 09:58:26 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22664C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 06:56:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso17764830otj.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57EvL9nBk5ulCxaDdypVCPONGY2M2gdZBODEfyPk0+M=;
        b=bDupcl7jY/0rPOWXFBijpqpIc+G4dLFYxdM+JktA8aJ32e0k8Yt9V13mzD2mbp8oGH
         sgPGgv+YY+ID4yevZsUpbBihbwBT6544wur9XdtbfsWFPhlS2UyGBoG3K1mZxq8Gp7W+
         lXjEqBfxrymyVDn3ZidAnot2n5ol8DgRt5QoNsrooQbt6JtDmXA4WmvvyAFTJlGLmidi
         FVjvHD/uuWMzHxVD/dCrASpPSkM7G4XlEsAcpizjW70kIoqMDZfaSmEKw+yqahlhGNoc
         5Oa9Uo+UBw6c+tIoaAN0WY5D3TgIOa8CC55qYho7WRtLMjxEcolRGPwfiB6tIXccNp4T
         c0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57EvL9nBk5ulCxaDdypVCPONGY2M2gdZBODEfyPk0+M=;
        b=ep3iL7Fb5YuHlrJIWcoeVhhLd+WwbRLFsSMFiqsJiUiC49ZAOWbC6UvVFRXPlPZTjw
         S5sB5V3zHU+Ru+Z1ueZ4c4vcXmfUAVUdtR5NeBxBFqm0HNFH+xmCp1LsFRvaQnGujgyg
         nbXzEL94rQXi4Cfwa9Z1K8nLAbZ+P+4HLkLc8l82Y/U5beCZndrTq63xAV4jbpSnjJTd
         EmhpZlUcmFX9+mrAEq992KvCLK9j3UUXteGI/mjMcb775QqxWabW0T8mAcS+M2do2rbW
         LSK0atVibUrXhFNgbe2xz8dvd5WrcfRCRxJscIX9NE+/zzzH4Ahv13DDAvSER2EGONmb
         LTjw==
X-Gm-Message-State: AOAM530QMiKl+/gy841nCHzqR1wydJhNi3bkk2UuVXJvPtzGcM2opzpG
        Ltpgl+dyQ0IMYE4vui4kLnr+yzL5bHoB7/vmmvA=
X-Google-Smtp-Source: ABdhPJxeleFsI4qa8q+dltpbXAycIHbCMgLKmgrAg9E8qRFf7y5lVh0/eSO41U1T/witHgYc9kSu5eDka163jFbaOs4=
X-Received: by 2002:a05:6830:18fc:: with SMTP id d28mr3831561otf.162.1624283771453;
 Mon, 21 Jun 2021 06:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200512214420.36329-1-emilyshaffer@google.com> <871r8w3sxu.fsf@evledraar.gmail.com>
In-Reply-To: <871r8w3sxu.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 06:55:59 -0700
Message-ID: <CABPp-BFDfCqpDGZ1D=U6V5--KkcuCJON5-CcX-PVLcvH4pc5cg@mail.gmail.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 6:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, May 12 2020, Emily Shaffer wrote:
>
> [Replying to a change long-since merged into git.git's "master"]
>
> > Rather than teaching only one operation, like 'git fetch', how to write
> > down throughput to traces, we can learn about a wide range of user
> > operations that may seem slow by adding tooling to the progress library
> > itself. Operations which display progress are likely to be slow-running
> > and the kind of thing we want to monitor for performance anyways. By
> > showing object counts and data transfer size, we should be able to
> > make some derived measurements to ensure operations are scaling the way
> > we expect.
>
> Did you end up using this data for anything?

I know you were asking Emily, but independently, I found it useful
while doing merge-ort and diffcore-rename optimizations.  I thought it
was a clever idea for quickly adding more measurement regions easily,
and wished I had thought of it myself earlier.
