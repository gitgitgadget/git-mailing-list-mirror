Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC9C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD1A20781
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLaWXp5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405480AbgFYOzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405406AbgFYOzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 10:55:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6EC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 07:55:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so6154047wrq.8
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsyZJGBJp3xqLfS1+rozlUIsZaffYaNclN7I4MohBJo=;
        b=YLaWXp5wrk3n8D2hVGmMqWQev5Ifu7ibzk7nkfpiJpMeolxcsC5Hg5sWrxKs5Q9DDG
         kcEHGbQO7KnPbbHK8BsRUe2UkrGV7+4+Qj/pWkGTsSSD7tnSh+fA8hlDlEPI3XzmmucK
         /mgTMSmF3P4lCq9qFfsBCrQDSZyW1qQKyTc+pD2xdNEDPmfuFGc36bN5r32a+qXpvOdK
         wT1KqcWVkwfP30NVjo9OKJWH04uAYAM9G46BLM4QHdCH+Kl7EJN2020bwG23UYKJJj+8
         J2/rAvP+xlYVZYNVcpo7qQC5Mkna/esRxtbyvjV4YqGrAAhl+5aIT17nsQ8AhIXRy1/y
         aMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsyZJGBJp3xqLfS1+rozlUIsZaffYaNclN7I4MohBJo=;
        b=AY/0Hi3lOX5MFOcd13S4fr39ULYIdp1nvDlztYwTSoo9PrY+8OKaOz5UR+DgoFE38e
         EBKN3gjK+xCarHEQ7YZVjL1lgd4Yl4w7SiyVKjUzRnqKOgQ7Sw19mFem1OFLGslo0ZFd
         I7C1ywC/vJA9e/thUiucUBHvYTlPBFodq/ZugeOgFiovA1qA5DTOHnkiVGOe0l6F+y3f
         ii9YgLssjpFLzflUlzmS+PzZ77NS0/9RgfvXn9O1Lke27A26PMi6Ns1IxUEc6wPoNMtZ
         zMMXFba0Eqkcr9KcmKUuCVt8PBc0Go79E2gcIe2+nCzn13dN4Ejd48ehk5m8O3ZWW9Rj
         4LAw==
X-Gm-Message-State: AOAM530sLvAr7md1yW/IjU1gdqIZ8W7hxWFVp6yNy6yrNI+ABWGhZplH
        PLLfY4ngKevrJOZsoWKdr0hKk5dcbsgFWVCEP9k+NSV6
X-Google-Smtp-Source: ABdhPJzlMOEhJIeyz//zezOqmaKiQnj+MT8mP5b6WczDACxmDAG2uqXVIZyOZ04CVF2Z/2r9dPDakn0ieD3kzvmvtdA=
X-Received: by 2002:adf:aa94:: with SMTP id h20mr35337186wrc.327.1593096935719;
 Thu, 25 Jun 2020 07:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200625121953.16991-1-alban.gruin@gmail.com> <20200625121953.16991-3-alban.gruin@gmail.com>
In-Reply-To: <20200625121953.16991-3-alban.gruin@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 25 Jun 2020 07:55:25 -0700
Message-ID: <CAPx1GvdoVf-yFmbCuFc3ZtPvQ=PjuFrum_mijsQ9u8uf61SOHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 02/17] merge-one-file: rewrite in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

much snippage below, keeping just enough context to see which file,
function, etc:

On Thu, Jun 25, 2020 at 5:49 AM Alban Gruin <alban.gruin@gmail.com> wrote:
> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> new file mode 100644
> index 0000000000..4992a6cd30
> --- /dev/null
> +++ b/builtin/merge-one-file.c
> @@ -0,0 +1,275 @@

> +static int do_merge_one_file(const struct object_id *orig_blob,
> +                            const struct object_id *our_blob,
> +                            const struct object_id *their_blob, const char *path,
> +                            unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
> +{
> +       int ret, source, dest;

> +       source = open(src1.buf, O_RDONLY);
> +       dest = open(path, O_WRONLY | O_TRUNC);
> +
> +       copy_fd(source, dest);
> +
> +       close(source);
> +       close(dest);
> +
> +       unlink(orig.buf);
> +       unlink(src1.buf);
> +       unlink(src2.buf);

Some of this goes away in subsequent patches, but most of these calls
should be checked for error returns, especially the two `open`s in case
someone has messed with permissions.

Chris
