Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9334BC433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiBOIMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:12:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBOIMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:12:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DCEA0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:12:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w2so12092854edc.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02gz8fXnaJpIFVN+eBpBilz/EA78Izm1TfEqx6omKjk=;
        b=QauTPhbkrxp8QH1GUd+op0b0Tz88VwAXM4fHNre8JSKjuid+BZR7Nb2puKL5X+zmlH
         dClbbU/PYrnOPaMNEciDpHbIAUkQppz6V9Vdw+oW7F7uYkHvNQCdSKMPJzbPayKHiEEa
         1b4Z6YerJZ9ocQqu0dKpceRC8lrQduGA5vOQl6DvOjrQ3e/cTeND0X3FwYt7a9BmQFS+
         fjp48JRJJv40T8w7W2XSHBdyOZKjOehXfEskwbjaGkYPix6vKKJSbxOuudSILwaxs21/
         sSlZBquMCLHaRmw1IlWtLSIzblfVWT7tjmgSjnH8de8njZDFoC1+3SPOroPxlcCBOArM
         Bx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02gz8fXnaJpIFVN+eBpBilz/EA78Izm1TfEqx6omKjk=;
        b=we+k8aeOn+wUQsBfupyMhVGl3G2esyh+dus2pYjB/iRZEFxG8fHdd3O3Rj7LcKlCUZ
         hEgGjrlrwyLi7D8SRDp91v9c7ausG5tuVBTYpyJZCGcf0ZkPrsuM/EhQquKp0Oix1mNg
         06TgccaxLB9hj0iZIKLMFwWJUQXd2V93YYmmXvwtUfcuUuRsx19b+w0/HwXu5Q4BtRne
         N7zNIqnTwuqHlKhmTnUHcZZEGLETCsPrzLMw/g5OCUYVgPao+NNCsT3nZspdvqd4GDeh
         +WYQ/CdGPb3G8cJBD9Ts7V6xP9dVGA9Ivpa4ICMv+FBlT1wpLmMT+ajqJKySHVUrbbao
         oghA==
X-Gm-Message-State: AOAM532/sxfZZT4NHr/D52wCpiYUmcmftZYGXFx62llmiiC9ajUaNnvI
        xQqqdsfJjtqk+S95ES69EBMg5nl4kGnegujpj6E16CPeKRU=
X-Google-Smtp-Source: ABdhPJzGUr0IB8JURSCDTuHFCsFRU/DVChN+yI9SyMlrOZonrSxrWHSgY6jSKgiiJ+TfUljmdrUUEWNzNsJ0WSRxxRE=
X-Received: by 2002:aa7:c44b:: with SMTP id n11mr2728050edr.142.1644912726846;
 Tue, 15 Feb 2022 00:12:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
In-Reply-To: <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Feb 2022 09:11:55 +0100
Message-ID: <CAP8UFD1bdLESqzbZcYKYfib836vrDTfyCmYfT-9B-1ToJB0EWg@mail.gmail.com>
Subject: Re: [PATCH 5/6] fetch: make `--atomic` flag cover backfilling of tags
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 10:13 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> When fetching references from a remote we by default also fetch all tags
> which point into the history we have fetched. This is a separate step
> performed after updating local references because it requires us to walk
> over the history on the client-side to determine whether the remote has
> announced any tags which point to one of the fetched commits.
>
> This backfilling of tags isn't covered by the `--atomic` flag: right
> now, it only applies to the step where we update our local references.
> This is an oversight at the time the flag was introduced: its purpose is
> to either update all references or none, but right now we happily update
> local references even in the case where backfilling failed.

Also it looks like the backfilling of tags itself isn't atomic, right?
Some tags could be backfilled while others aren't.

> Fix this by pulling up creation of the reference transaction such that
> we can pass the same transaction to both the code which updates local
> references and to the code which backfills tags. This allows us to only
> commit the transaction in case both actions succeed.

Maybe this could be seen as a regression by users who are mostly
interested in the local references though.

> Note that we also have to start passing the transaction into
> `find_non_local_tags()`: this function is responsible for finding all
> tags which we need to backfill. Right now, it will happily return tags
> which we have already been updated with our local references. But when

s/we have/have/

> we use a single transaction for both local references and backfilling
> then it may happen that we try to queue the same reference update twice
> to the transaction, which consequentially triggers a bug. We thus have

s/consequentially/consequently/

> to skip over any tags which have already been queued. Unfortunately,
> this requires us to reach into internals of the reference transaction to
> access queued updates, but there is no non-internal interface right now
> which would allow us to access this information.

This makes me wonder if such a non-internal interface should be
implemented first. Or if some function to queue a reference update
could check if the same reference update has already been queued.
