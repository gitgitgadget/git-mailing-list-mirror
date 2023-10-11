Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A2CCD6E59
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 10:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjJKKhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKhg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 06:37:36 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E698
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 03:37:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dcfb2a3282so4569219fac.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697020654; x=1697625454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9WZfNFO07OhrASA8oGiODBLZZim49iDDXTYeRrmKhY=;
        b=PhSHXLyZKWqKA/sLZYLytakvhlD7pOakCzfqar/JsLWqR7PbkIdQp1B2rrStOb1804
         e90iinwoJsRp/GbD/mV3UzYfJD/MZHxrVSZIiK1Uc1OnfDEljaMH4fEkQOJvgIXfEowa
         k/t7+rmu1nUwFytxtQg4Hjr/xsSSKIrJCNkCYqK16RYbSOGXCdozaQsB6uyZ7+4H2lXW
         9cf4wH7qdU1AN+OSzgtQA+itmI+pYNoeRTTonqW1qk1n/hcmE8xjVMWichmTuWfjfhEs
         CsaRLEhrweRrUfjtDah/R0CbvX00Qyv6ZwU8ioBftC/liT42wbnYeLEzWx+T+ADG37wu
         T4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020654; x=1697625454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9WZfNFO07OhrASA8oGiODBLZZim49iDDXTYeRrmKhY=;
        b=c3H2kqh1xYIRofPcvlxFN0kFEaDz2IlGSKR2FBC0nB9jFjpRlnewu92mmxiMbQH8hF
         Gogl9JSllU17ynv0ac0N4v95ITOPEYH+3wT8TIHPQQ7yQtQnn2WPFV7ZPqszAsr9CwQ2
         ttoUyg+IPwmvFYB2f3D2R8xzywhP2HiX/9AHxNFemw6XgG3dUolnVWbw2ge0oRYNt/oP
         nUKkIRCPtLP9UQ/1vVv4/sJB3TFaRyiYMWCpuQvHEXnmm6MSB45Emw7nU5P0V3qsDUNb
         /+zPZlZUso6KYWtbXEk0WxVCP32V/mrGGLVPfagoEOBs7bBb5jS/qyow0pR0Oo2roFXn
         rNsA==
X-Gm-Message-State: AOJu0YwcNANcAeescdrz5XKg05ndERORtVegkT8w4qur4kJxDcRKNDXq
        t2F+bQsxtOOAUmQsjxu6SQUsj5Bk0+rxoanXvos=
X-Google-Smtp-Source: AGHT+IHtQqI8Vjb5w4V/PzVNrPPH/dhy/dTQLjXx5bzRsSNRSGOuLfE6pueVaWv4kC+wOMGQPXFN1SPrREeZKWmJdoc=
X-Received: by 2002:a05:6870:1682:b0:1d0:f5bd:6fe with SMTP id
 j2-20020a056870168200b001d0f5bd06femr25677515oae.50.1697020649773; Wed, 11
 Oct 2023 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231009105528.17777-1-karthik.188@gmail.com> <ZSTs3BUVtaI9QIoA@tanuki>
 <xmqqil7etndo.fsf@gitster.g>
In-Reply-To: <xmqqil7etndo.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 11 Oct 2023 12:37:03 +0200
Message-ID: <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 7:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I had already reviewed the patches internally at GitLab, so for what
> > it's worth please feel free to add my Reviewed-by.
>
> Great.  It seems that 'seen' with this series fails to pass the
> tests, though.
>
> https://github.com/git/git/actions/runs/6462854176/job/17545104753

Seems like this is because of commit-graph being enabled, I think the
best thing to do here
would be to disable the commit graph of these tests.

This should do:

    diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
    index bbff66e4fc..39a8402682 100755
    --- a/t/t6022-rev-list-missing.sh
    +++ b/t/t6022-rev-list-missing.sh
    @@ -5,6 +5,11 @@ test_description=3D'handling of missing objects in rev=
-list'
     TEST_PASSES_SANITIZE_LEAK=3Dtrue
     . ./test-lib.sh

    +# Disable writing the commit graph as the tests depend on making parti=
cular
    +# commits hidden, the graph is created before that and rev-list
would default
    +# to using the commit graph in such instances.
    +GIT_TEST_COMMIT_GRAPH=3D0
    +
     # We setup the repository with two commits, this way HEAD is always
     # available and we can hide commit 1.
     test_expect_success 'create repository and alternate directory' '

Thanks for reporting. I'll wait for a day or two (for reviews) and
will add this to the second version
of this series.
