Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0671F453
	for <e@80x24.org>; Tue,  2 Oct 2018 18:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJCBe1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:34:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46198 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJCBe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:34:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so3013118edg.13
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pikYI0NVKnMm/AfLn40xKVvyjASsC/OwNGHgz4SJPxU=;
        b=EiYFDh9TEvDgwG7OHGh8ljsLbmYCwxQlnRiJnvmDQEz7AQj77e3Ft4PuvmRvAJxarl
         HZn1neej7gK5VFmoX+5qnYEUBZLyA/0RDIgIXO1KyVlBpZYjhmiUgWnQHOIhW/bDsvFC
         fPNhD1pzpiHXNGdAjvy88klgacZmLh6ssDG7/5waG0L6XtYnUF4/d8T4iojUXPWn6bce
         /J7VoI5BDgBOIhBheW4RcYM8KxhaZjMhdDe5W27D9IJ98c5a1McqUiSFP5zWZU5CyQ1S
         LQ2HGJM8VcBsFPZcmQAFu6IQXB8ez75AjWzSkDlKULNyV91pmIu7MQoYjk/lDApeasnt
         E0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pikYI0NVKnMm/AfLn40xKVvyjASsC/OwNGHgz4SJPxU=;
        b=bkWOHqtug2G+tcOOdGDqzgpjPxLyK4FwUqyhR/TQQWQ+y//EsRIm/qhxj8A58VwSVo
         OjMf982Z2ipKlhhqAZ9s5lfUWlEbU6EBJvYS+SI7TgTha91/erP0DERV0QN2yG800gRb
         4VlkBve31u6wQATBdPdPzuRs+RKnCetxS48bDunmCtAAJC4Q4MSNYtDt2nyhIRoClBEK
         bviCB0C7JO6aef74gSE/0fTp48Ru1n+P5r1n3ikVzYqj3VHG5CP63z+VwXq1WErS/tii
         yA7QirVl3VGz+IZaOzwvZlfsnUlPIcHLwpWNkITjxqPHR1JV+CHuvXQ+gemc3fnxqCKb
         8Pog==
X-Gm-Message-State: ABuFfohAw06fLcaXO6HllM/5fjLtMInfNKbmw0rjxGuM4GkdA3KwfYUR
        8qTM8R2iDoAnWcBPQs4qlgzLAh27K4n4GE6NcPSVP/1B4XA=
X-Google-Smtp-Source: ACcGV62fRyfIy/iTHlc8WnswnTZW0kxAQMmiybXKqCeUPabTOMOo6Ajadz6X+OeoT5r8x6EuIObavoKO6FcwCf0actM=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr12116347eds.25.1538506179762;
 Tue, 02 Oct 2018 11:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
In-Reply-To: <20181002175514.31495-1-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 11:49:28 -0700
Message-ID: <CAGZ79kYqACgoNShaPBQQSUN1B_dhmdxHxBV6YZoNAd39f6XMjw@mail.gmail.com>
Subject: Re: [PATCH 1/5] diff --color-moved-ws: fix double free crash
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:

> The solution is to store the ws_delta in the array of potential moved
> blocks rather than with the lines. This means that it no longer needs
> to be copied around and one block cannot overwrite the ws_delta of
> another. Additionally it saves some malloc/free calls as we don't keep
> allocating and freeing ws_deltas.

Another solution would be to duplicate the copy-arounds, that it only
fixes the double free, but having another layer of abstraction
(moved block vs line) makes sense as then we don't need to copy
it forward.

With this patch applied the diff as mentioned works and having the
ws deltas with the blocks instead of the

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>



>  static void pmb_advance_or_null_multi_match(struct diff_options *o,
[...]
>         for (i = 0; i < pmb_nr; i++) {
>                 if (got_match[i]) {
>                         /* Carry the white space delta forward */

I would think this comment is obsolete as well with this patch?

With or without that nit addressed, this patch is
Reviewed-by: Stefan Beller <sbeller@google.com>
