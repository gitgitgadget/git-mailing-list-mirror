Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CD8CD37B1
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 03:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjIPDKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjIPDJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 23:09:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702661BDA
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:09:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50305abe5f0so69763e87.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694833789; x=1695438589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89/eg6E0CJ+1pqL2r8zcZVUl3Y7ccx3MrpaibYpHZhk=;
        b=MtpVZrOSU/Hzt8YBpfy1SPtFng9r0DmlOI6fnVFWEtkafShAHdef6wG4VfkslacENh
         BZMxUuVYRcNp1inxY8s1V/CLhg7deDpBjZPWfEdmPo7dGQZKzX9YfukYh6sL85fVNU0M
         fF4I+Ku/5w+FZS2GmrqQ/ojm9Hm+wLeg6EOiZ5OhI596EslGp9S3eocmerl4d9Ma+VNB
         AV93zGF6zCj84dJK2M6QzYj6rsyezyPRyJnLXLzchmSyiDHZ0nZXUbfPhUDADU1LlTcg
         ijDv1Owz/u5aMDTBt293xqQ2I98w+fy+4Cs7W3wYjCQpbbRRWpSRqEP3eWGZjweNxjV2
         dF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694833789; x=1695438589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89/eg6E0CJ+1pqL2r8zcZVUl3Y7ccx3MrpaibYpHZhk=;
        b=VM91GLh0bppkLmG1wCS4Ss0Xvf/C+OGr/Gvg+NrqW5KXYncwrrTB+hZcangZyYBf+u
         m8s4vqWy2xIEFCqtmYqKf0fAj2AGaOz/fr0AFP8T8x8rfHt00jePUIozRTPG5GTTuuny
         fkGYYEbQWuFTx/EHT7B+rWNcQ/kbGS9zmiNSBUKnIFVVLUjIlUgH5mZsgFzYa+uqj6oH
         y2mOWcEtK5puPHPgcyi4zFVNzTmNVhP6QkmgZQbrZ0ltDd7Nanz2+cT5FquIo2tC4iRR
         Hza0hWLX4sX+o4QBdOuTCe2EQhQnWl+fihFO+K+TbBBcAXsElIvRrsEDmH0KzFKdpQMK
         XH0g==
X-Gm-Message-State: AOJu0YxdfDeSMTKDhFCd+wulL2eLOhJfjUNOz2+dSx9lnVaxggkZVvxp
        krDaK17QODJwY2PC9r/I+/kgbq57Xpe0iNRyIEjQhICmHjw=
X-Google-Smtp-Source: AGHT+IHGACjafWKcSyW9Z52w+zGX+HxHQJyGKjXM4fQb9Q1qYvO5qyFtG3k7SsaCQRmKdCIq7m+iY6MdNKQfkGQ7w6E=
X-Received: by 2002:a19:5f16:0:b0:501:be3d:8a46 with SMTP id
 t22-20020a195f16000000b00501be3d8a46mr2691314lfb.26.1694833788429; Fri, 15
 Sep 2023 20:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914093409.GA2254811@coredump.intra.peff.net> <20230914094004.GD2254894@coredump.intra.peff.net>
In-Reply-To: <20230914094004.GD2254894@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 20:09:00 -0700
Message-ID: <CABPp-BEi1CSXEE=-dDi_bhtSsGeVWtivfT-jQP+hjWdv4agq=Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] merge-ort: drop unused "opt" parameter from merge_check_renames_reusable()
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 2:40=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> The merge_options parameter has never been used since the function was
> introduced in 64aceb6d73 (merge-ort: add code to check for whether
> cached renames can be reused, 2021-05-20). In theory some merge options
> might impact our decisions here, but that has never been the case so
> far.

Yeah, it was used in some preliminary versions of the code while I was
developing the new algorithm, but there were lots of changes between
when I started working on merge-ort and when it was finally ready to
submit for review.  I must have just overlooked that this parameter
was no longer needed.  Thanks for catching and cleaning up.

> Let's drop it to appease -Wunused-parameter; it would be easy to add
> back later if we need to (there is only one caller).

Yep, makes sense.


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  merge-ort.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 20eefd9b5e..3953c9f745 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4880,8 +4880,7 @@ static void merge_start(struct merge_options *opt, =
struct merge_result *result)
>         trace2_region_leave("merge", "allocate/init", opt->repo);
>  }
>
> -static void merge_check_renames_reusable(struct merge_options *opt,
> -                                        struct merge_result *result,
> +static void merge_check_renames_reusable(struct merge_result *result,
>                                          struct tree *merge_base,
>                                          struct tree *side1,
>                                          struct tree *side2)
> @@ -5083,7 +5082,7 @@ void merge_incore_nonrecursive(struct merge_options=
 *opt,
>
>         trace2_region_enter("merge", "merge_start", opt->repo);
>         assert(opt->ancestor !=3D NULL);
> -       merge_check_renames_reusable(opt, result, merge_base, side1, side=
2);
> +       merge_check_renames_reusable(result, merge_base, side1, side2);
>         merge_start(opt, result);
>         /*
>          * Record the trees used in this merge, so if there's a next merg=
e in
> --
> 2.42.0.628.g8a27295885
