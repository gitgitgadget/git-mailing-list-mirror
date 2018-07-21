Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3217B1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 06:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeGUHsL (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 03:48:11 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43125 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeGUHsK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 03:48:10 -0400
Received: by mail-ua0-f196.google.com with SMTP id x24-v6so8798071ual.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7dvtPXH++u2qCgT0W93BD4bmSOWigUhHSmGGowpf4qw=;
        b=T16pwePbi9IHhEqTuEBWPk/X55gtLz6YRVugf6WLrBD52r9coFxq6aKA817kSz7j8w
         osQgMvh306LqbzyapcveFWu2ZnZwUFgXnnlMzhJUzc2GhM3xL94gaXlJkABUxSCFG8qP
         Gj3nreu7/cxtQXjMOx6usd7tlwCs5qwRWfXdkPfSJMXJpuIgH2lv8VN1zklvTAgV15Hx
         roIynSuSZ7LT0m0hhjHy/mPleRhpcC5+fEQGSao89dbf7IdKqQr1wD3fqHfkZcEGHMuj
         5GfRj4a1GJMkDaIc9G4E6iE85uQCni1UiFVzHw7hh1mEsOCwS6+v1U6u+utxpabepuxW
         pPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7dvtPXH++u2qCgT0W93BD4bmSOWigUhHSmGGowpf4qw=;
        b=X3eDB/0Gz328ta0gNMc22BGUb23H3ZrHwOGpP1qdG2nOQ+lAIxdJ/2GTAVjpgrs76W
         mv6kjUSzCiS6G6oCdn+bjAt3IMLbZKa0zb+7OpFjfG3M42IJqGzx8jxuJrisNKky+rsJ
         n5U1MvOXQ5Xnq3J7VPpcYb9crJlRgM8rMCKx5lgVS0OpxviimM5XApLISZG0ViA48KD/
         7kZxPpSsiWwm3hjMTDXUuuy1QoEOPh0SIP7Qte0lONoxDtbOy0TQ66CB0GGaaq5h86pP
         6f7K0Mbs9G6Gpv0aRajSX3QvO8LiaCCm1zigOnggESiG75nXrFvGB9q/BQnHZS10SMlr
         P0lg==
X-Gm-Message-State: AOUpUlH7sVtrHpd47Ne6CFMGt+/fzF4PRkBBQd6UMgxZYmtVt8COECyA
        FIQTTqs7bGW8m3GsUXJ996PBrleMB9iqAYX2azE=
X-Google-Smtp-Source: AAOMgpeYppfdXTFth4kuWcDQPOtsdPAOsPka3eZOAFPJWl0sXuayLqmGB6VUoimBzTpg4AiFNHeIeh4ava77XDsvUlU=
X-Received: by 2002:ab0:4f26:: with SMTP id n38-v6mr3350214uah.29.1532156191103;
 Fri, 20 Jul 2018 23:56:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:10e5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 23:56:30
 -0700 (PDT)
In-Reply-To: <20180721044711.GA31376@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com> <20180721044711.GA31376@duynguyen.home>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 23:56:30 -0700
Message-ID: <CABPp-BG_kYw1fWvq0YTTic7AV=nYuoKe9E4QMYVN0R_16xPKaw@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 9:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jul 20, 2018 at 10:43:25AM -0700, Elijah Newren wrote:

>> Out of curiosity, would it be possible to use the delta_size_ field
>> for deltas that are small enough, and only use an external data
>> structure (perhaps a hash rather than an array) for the few deltas
>> that are large?
>
> We could. And because repack time is still a bit higher in your
> linux.git case. Let's try this. No locking in common case and very
> small locked region when we hit large deltas

Sweet, I'm starting some tests with it...

> -- 8< --
...
> diff --git a/pack-objects.h b/pack-objects.h
> index 9f977ae800..11890e7217 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -15,7 +15,7 @@
...
> @@ -353,37 +354,26 @@ static inline void oe_set_size(struct packing_data *pack,
>  static inline unsigned long oe_delta_size(struct packing_data *pack,
>                                           const struct object_entry *e)
>  {
> -       unsigned long size;
> -
> -       packing_data_lock(pack);
> -       if (pack->delta_size)
> -               size = pack->delta_size[e - pack->objects];
> +       if (e->delta_size_valid)
> +               return e->delta_size_;
>         else
> -               size = e->delta_size_;
> -       packing_data_unlock(pack);
> -       return size;
> +               return pack->delta_size[e - pack->objects];

Should this last line be wrapped with packing_data_lock/unlock calls?
(And similarly in oe_set_delta_size when writing to this array?)

>  }
>
> -uint32_t *new_delta_size_array(struct packing_data *pdata);
>  static inline void oe_set_delta_size(struct packing_data *pack,
>                                      struct object_entry *e,
>                                      unsigned long size)
>  {
> -       packing_data_lock(pack);
> -       if (!pack->delta_size && size < pack->oe_delta_size_limit) {
> -               packing_data_unlock(pack);
> +       if (size < pack->oe_delta_size_limit) {
>                 e->delta_size_ = size;
> -               return;
> +               e->delta_size_valid = 1;
> +       } else {
> +               packing_data_lock(pack);
> +               if (!pack->delta_size)
> +                       ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
> +               packing_data_unlock(pack);
> +               pack->delta_size[e - pack->objects] = size;
>         }
> -       /*
> -        * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
> -        * limit. delta_size_ will not be used anymore. All delta sizes are
> -        * now from the delta_size[] array.
> -        */
> -       if (!pack->delta_size)
> -               pack->delta_size = new_delta_size_array(pack);
> -       pack->delta_size[e - pack->objects] = size;
> -       packing_data_unlock(pack);
>  }
>
>  #endif
