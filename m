Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A6C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 03:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiGUD3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGUD25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 23:28:57 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F0461D97
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 20:28:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y18so272111qvo.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=St2kURWmRytDVQuIgRhdq5O4n7adtkXBXc/VbyYwuG0=;
        b=GenUpVMb4BcwCcI23A9d2XhnpNdE5rom0h3WVCkCZHPiLS23adUW76trBeTKUVpfYZ
         HWbZHfdkotPvX2gJ9nNp3J4OBQ4bCgjgcngpkcux2u8qUd46unVaQkeNQADirD0nfXHh
         khw9/VktxwQZW+1mg/IZk4/T/77bNCEUAfaJwvVv1e3MbqG9afe114DVY1QiySamNMX/
         BLo8CFWgySXaNg7z+8Jt+AieUTWIG5AxFIVqFaGFAqHF6L85+kgrtdAGlqJVRoiYP+4b
         CDPhtEigGTVdVctbGgf55cPOlT3Q55l4ExFNlvqRS49ogYQkmIh8pF5+lZerJgSQJ+5L
         0OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=St2kURWmRytDVQuIgRhdq5O4n7adtkXBXc/VbyYwuG0=;
        b=2Mh8wD51DAddCDvztH/rdvonRWQJRg4DOWUV35A4FomJHRQ5pMfl4zpznj+drkkODC
         8e6qGDsggWTzyP6yr6Jp2OxAn1oEg1vom/IpXs12ReFKF5U0zGtPP1UglgrvFCpTE6Bl
         1l7aD3Jusluay7OvlIX4KTaMW4ulvQ0N39JYFh5dDi9XK1OERJBQomtczOzY3sF0ogbC
         5KCL50p3LrJm0MpUwML7Pqy+JPaPVkiN99/D2oelnceV6nVWJIhaUf3ICWm/QVR09NOU
         y/Slw2B8f4/0AavtuEUVr/FcuYxILK8W8gcHHKwgWVxINs1yWVoxXoRXNrJqHSYZ/vF0
         1sVA==
X-Gm-Message-State: AJIora8Q8J7uFMlsIhaLdTUi0LFHncdjOjeZjuJO5f1fQ3+3phsVbgDa
        74pLGWZ4WF77h6fhxfwuYLMQ2VetKrr3DitsSPcJj/8rf/c=
X-Google-Smtp-Source: AGRyM1vvncUerLXcjgyZE1GVKXO/Gk3qQr52TpQFmbWSXwjbQRFYmAeAgFgljFJXqISLUxgyjbTweXQa0rdcVP+eao8=
X-Received: by 2002:ad4:5ae9:0:b0:473:62ef:601a with SMTP id
 c9-20020ad45ae9000000b0047362ef601amr31771663qvh.69.1658374135438; Wed, 20
 Jul 2022 20:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7d471dns.fsf@gitster.g>
In-Reply-To: <xmqq7d471dns.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 20:28:45 -0700
Message-ID: <CABPp-BFUoufmoQx8Oq=3C1ct-7paBs1fqzi8b8jhOadrndGkkg@mail.gmail.com>
Subject: Re: [PATCH] string_list: use the right kind of STRING_LIST_INIT
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Since 4a4b4cda (builtin-remote: Make "remote -v" display push urls,
> 2009-06-13), the string_list that was initialized with 0 in its
> strdup_string member is immediately made to strdup its key strings
> by flipping the strdup_string member to true.  When 183113a5
> (string_list: Add STRING_LIST_INIT macro and make use of it.,
> 2010-07-04) has introduced STRING_LIST_INIT macros, it mechanically
> replaced the initialization to STRING_LIST_INIT_NODUP.
>
> Instead, just use the other initialization macro to make it strdup
> the key from the beginning.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/remote.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git c/builtin/remote.c w/builtin/remote.c
> index d9b8746cb3..c713463d89 100644
> --- c/builtin/remote.c
> +++ w/builtin/remote.c
> @@ -1229,10 +1229,9 @@ static int get_one_entry(struct remote *remote, void *priv)
>
>  static int show_all(void)
>  {
> -       struct string_list list = STRING_LIST_INIT_NODUP;
> +       struct string_list list = STRING_LIST_INIT_DUP;
>         int result;
>
> -       list.strdup_strings = 1;
>         result = for_each_remote(get_one_entry, &list);
>
>         if (!result) {

Makes sense, but shouldn't the subject have s/string-list:/remote:/ ?
