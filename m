Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13876C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83D620836
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQzslmt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLIKWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:22:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36467 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfLIKWf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 05:22:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so12214218edp.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 02:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JBqaoMKUFPxt940hmjV9FB7doZCN0uiVhnU/dBu6Hg=;
        b=dQzslmt49JvLpiqPMTV/2tq3yGbCdUODj775GsAs53MUxPFsb64R0V2CGwcS9hCdBS
         Vkgt0l7n6ECtrkabGAz4ZjsexHojXOLvi9kmvtqVpZ7C00lU3a5GKjDcW1j8Z153cMZC
         rBNT9LN01f6leUeCJP34m6jbOHODHQB/aTDAUebOfnXw83nCK1vs5pKb1+8fmmn+Bn5A
         I1vSlD/AhoeD6sBru7KGrM8pXUefx3qUFbFIDF2vLqXEGDPAq39oeE/zkRwWqLHKzh+I
         4202O1JeTzZMiRFREW4PX90mgdswTWJCpil1vEAByyWyNzDLu5hoXq7R4T+qKZWv2jhF
         fTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JBqaoMKUFPxt940hmjV9FB7doZCN0uiVhnU/dBu6Hg=;
        b=sZ2ZCWrorONuBEyZuzTI5QIGMZPbiQsAWb3eyPhpPleu7cr6+ezAz/mdAJlf8KoSzB
         ITTv15CY6BqO3CBiMBS8W4gP6cqpkih8cw/PoSpNt5/VSA3+lN/JkFmyuPkz4h5DYWYX
         rkfOUbFCmpwdEVdS0ufIXAt1mL1cooFjuHOZGSvqgVcRucJawWDZCxEXjMpZv9S3Uu3E
         EZg0t127tSjyrFurURQ739Y9Puwhtx1fzoLaJhMN+J992VLagKIYndGWW5FAYE6Xkziv
         XOu7Rf+q47uvm/fLn6tu7+aGxtGe8PA4FhC7YeGQpAXsIYmP7n5dkyPRPTu99jf31UtU
         vkAQ==
X-Gm-Message-State: APjAAAVNa3owRqh1oZmx1EK7iIhf7nxO5CRX6rh/J6Pn4EFzg5fEiMrE
        Hho19iDRVG4OWtF2lRblRLgnvzuK941ZZgMxo3o=
X-Google-Smtp-Source: APXvYqx+YhRNhWtjQoTXfNmkrJ6mpl50tzFfXrwAsgc1NXPtzdYYqPWwIqGcHZA4DKW8SvvwXcEGZ+ETGI+aScVm9+M=
X-Received: by 2002:a50:e00a:: with SMTP id e10mr31660191edl.119.1575886953542;
 Mon, 09 Dec 2019 02:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20191209084022.18650-1-mirucam@gmail.com>
In-Reply-To: <20191209084022.18650-1-mirucam@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Dec 2019 11:22:21 +0100
Message-ID: <CAP8UFD2C0uh+e_tH2H=z2RqDwSC7SEu-JoBx3z2KefVND8OqYQ@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] bisect--helper: avoid free-after-use
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

As Dscho suggests, next time please use [PATCH v2] or [PATCH v3]
instead of [PATCH] if the patch has already been sent, even if the
subject has changed.

On Mon, Dec 9, 2019 at 9:40 AM Miriam Rubio <mirucam@gmail.com> wrote:
>
> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
> 2019-01-02), the `git bisect reset` subcommand was ported to C. When the
> call to `git checkout` failed, an error message was reported to the
> user.
>
> However, this error message used the `strbuf` that had just been
> released already. Let's switch that around: first use it, then release
> it.

Great!

I think keeping Tanushree as the author and changing the commit
message and the subject was the right thing to do.

> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---

Here (after the line starting with "---") you can add comments about
the patch. One useful comment here would be to say that this patch is
a new version of
https://public-inbox.org/git/20191208172813.16518-1-mirucam@gmail.com/
which itself has been sent previously by Tanushree
(https://public-inbox.org/git/64117cde718f0d56ebfa4c30f4d8fe2155f5cf65.1551003074.git.gitgitgadget@gmail.com/).

Thanks,
Christian.
