Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1745F1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 08:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeGVJwQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 05:52:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39996 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeGVJwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 05:52:16 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so363993ita.5
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXKHF7a4rkF5f66PMQuxZbfNGY7tPvIkcWVIcbVKZIs=;
        b=MJkg4Uisc10zYelvdgYQj1FdBufA0NqNF8YPcXjw1rag4HfsEZNMJ0Z0EgTh2IIDeq
         PAXSiFrWJOgnK0C8k5pgqPiqVR0C5y+TRTmEHJUpLKsa3O6bU5CF+Thu6hwQDxotE31X
         UHZc5vqOZ5SHgwBacgzvvgcuJbxp+zjw2YkaNGERrg2XGPWUiSefSkDpUN0cOMgAp3eF
         rpTrbkqX3tF5gmbRUsaQRWfwCI2/aperQ6IP7l1eJj1aLrWTJkI6mm7rdj0adtaqVeRc
         fefBTLBsO/G3v5UGPG99u0ZGhDnd4tt1VSHgWAFyA15F2tjeXd36igL9z3uAMJyry4Xe
         mmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXKHF7a4rkF5f66PMQuxZbfNGY7tPvIkcWVIcbVKZIs=;
        b=j4e6b4tXZGD5vzTbxYZ8nQ8JpCK0lcCXOwB88ZFSOqkvUcq5rjYMPrcg1yH0R4ARMZ
         c/dt0OnhetmP7xBOCcog3HAC4Unr6VFNHrhe0qgCbxrrhMQTk7yO1lTN1+o4slym7tHZ
         aMzoQgn3VaP9CZcPTLmyQ8nsLxpqynfJ5nIgUQ2r3pFi+/O9qA1aI1SyHMCa0NX++PU5
         p8FU+8YKXgUoSc9YFQfJ/d40nmzvE6BX5yLKvLCcMuXv08Bpet+HrY2S7hmQIMaZtVgy
         lALBo9W4596qfDCLOGpS8xfoK2x023K8YnUva65f4m2ZAA3bUomt+2cHd86lQ+Snl2xI
         4KZQ==
X-Gm-Message-State: AOUpUlHyMfxNYgKW8IkiWNWFMsf25mkU9FL33ksa+h1hteyVB/ObbXyV
        wbAUqybeQqn0z942euli2sAwkQfAwsf/n2CtBvk=
X-Google-Smtp-Source: AAOMgpcQI5JVNsM8ng/agHVZV3AdOLYTTTtnbn16UMLPBsrCvS0RpgL6P/+Y7KxLK5ldrxBK+LWIdC9+VfX87cXUjo0=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr6604136itf.121.1532249777680;
 Sun, 22 Jul 2018 01:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org> <20180722054836.28935-4-chriscool@tuxfamily.org>
In-Reply-To: <20180722054836.28935-4-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 10:55:51 +0200
Message-ID: <CACsJy8CmJt1Wj=e4TNUUxY-Czn+h0BTVAWLY0ujJhgUKC+Y6yw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 7:52 AM Christian Couder
<christian.couder@gmail.com> wrote:
> @@ -700,51 +705,58 @@ static struct object_entry **compute_write_order(void)
>          */
>         for_each_tag_ref(mark_tagged, NULL);
>
> -       /*
> -        * Give the objects in the original recency order until
> -        * we see a tagged tip.
> -        */
> +       if (use_delta_islands)
> +               max_layers = compute_pack_layers(&to_pack);
> +
>         ALLOC_ARRAY(wo, to_pack.nr_objects);
> -       for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
> -               if (objects[i].tagged)
> -                       break;
> -               add_to_write_order(wo, &wo_end, &objects[i]);
> -       }
> -       last_untagged = i;
> +       wo_end = 0;
>
> -       /*
> -        * Then fill all the tagged tips.
> -        */
> -       for (; i < to_pack.nr_objects; i++) {
> -               if (objects[i].tagged)
> +       for (; write_layer < max_layers; ++write_layer) {
> +               /*
> +                * Give the objects in the original recency order until
> +                * we see a tagged tip.
> +                */
> +               for (i = 0; i < to_pack.nr_objects; i++) {
> +                       if (objects[i].tagged)
> +                               break;
>                         add_to_write_order(wo, &wo_end, &objects[i]);
> -       }
> +               }
> +               last_untagged = i;
>
> -       /*
> -        * And then all remaining commits and tags.
> -        */
> -       for (i = last_untagged; i < to_pack.nr_objects; i++) {
> -               if (oe_type(&objects[i]) != OBJ_COMMIT &&
> -                   oe_type(&objects[i]) != OBJ_TAG)
> -                       continue;
> -               add_to_write_order(wo, &wo_end, &objects[i]);
> -       }
> +               /*
> +                * Then fill all the tagged tips.
> +                */

If we move the code in this loop to a separate function, in a separate
patch, first, would it produce a better diff? I think all the
indentation change here makes it a bit hard to read.

> +               for (; i < to_pack.nr_objects; i++) {
> +                       if (objects[i].tagged)
> +                               add_to_write_order(wo, &wo_end, &objects[i]);
> +               }
-- 
Duy
