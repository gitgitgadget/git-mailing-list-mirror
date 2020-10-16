Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05619C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928B1207DE
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbN/2Cvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408070AbgJPNHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408068AbgJPNHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 09:07:16 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D9C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:07:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i5so2274520edr.5
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIZH9B9jqnkKpb6CRwo1DksxMrU7O4288gtRbG8S7UQ=;
        b=WbN/2CvbomQD0a+so3aBYQfuIS8Y2/dOmcc9+CrZEIkKGx5Cl9ry5rIi1v94DZFP5Z
         zvDDC9e69mrjQaBqKK0YOYpOYVyptk5XLp9N6vhdscHG3h2tKGIs4+ISffwC+VcsMN1+
         b5XwIvjDrKLjAifq7GFSewh8IareF2pioDud3aE8EtmIUA4F/k6kmLKvhMorh4EqSp7p
         76GrE3yD0SUAe0I2kxW8+vC8JEbP0DmYJ/naaSgPDfGTazh7nYuNH/93DdHTGBJeZUKq
         Dq7f2QiIc9YKeB+TtkqmeSZEcY9HdDNRaB5rAzxxzGSB8GoqZGhFTpknhm1mGSDasEaj
         dFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIZH9B9jqnkKpb6CRwo1DksxMrU7O4288gtRbG8S7UQ=;
        b=qrAujkPKeSEDJ+5G/5vhOUGYsiNnfTPKzwu7Z7/vc/m7/c1xJ5ZrR0zapHj52kWTQn
         DEjOKKuxgRwAYcOLEsU5tSO2aQk0efGP+6Cax+33ZNX4bcAwMNkw52oGU+uTkHSfJJXa
         QLRvgEcVIWzYiEhAGp6pVb5hY85uhkDMAkVRwAcSFzhdigVB8GOm9kNzDTJhpRwTYg/x
         kz6DNfJcu0HzLiSpgwHXhebUgKO80BG1Rbll7EvlhirN0QEXFSQntTdDEjStHSRuP/Ww
         yH+CVZdINJLwkPAKmSDq/FqesD+Ydl2pbr6E99ATHbd84yv7nhVvP0TmddW4r7sKSOCX
         Hw3w==
X-Gm-Message-State: AOAM5339GReeXbP88qi6CUJY2asPQWVgep5oGBd24LZ4ZylL8IB5hgL2
        qmnPDrQ3b+9NJLL+QGd5HHBNPfK/xG3fhd56LcURhIVBKOQEew==
X-Google-Smtp-Source: ABdhPJytc513yaYjQJJQlSX/N0IcluXu4qg5lRsQZ7lDY9TXI5OwEeISh88oMmQaye8kZG80nqVeIWcR30wXnzIi8Y0=
X-Received: by 2002:a05:6402:2073:: with SMTP id bd19mr3653613edb.127.1602853635105;
 Fri, 16 Oct 2020 06:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <20201015175709.20121-2-charvi077@gmail.com>
In-Reply-To: <20201015175709.20121-2-charvi077@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Oct 2020 15:07:03 +0200
Message-ID: <CAP8UFD0BhN_e_HRd1NHvjxH6ipD59XVDV6WWUtT-b10L4VFBqw@mail.gmail.com>
Subject: Re: [PATCH 1/5][Outreachy] t7101,t7102,t7201: modernize test formatting
To:     charvi-077 <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>, phillip.wood123@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 7:58 PM charvi-077 <charvi077@gmail.com> wrote:
>
> Some tests in this script are formatted using a very old style:

s/this script/these scripts/

as this patch is modifying more than one test script.

>         test_expect_success \
>             'title' \
>             'body line 1 &&
>             body line 2'
>
> Updating the formatting to the modern style:
>         test_expect_success 'title' '
>             body line 1 &&
>             body line 2
>         '
> Signed-off-by: charvi-077 <charvi077@gmail.com>

As Junio already mentioned we request that contributors use their full
real name as the author name (which is by default the sender of the
email) and in the "Signed-off-by: "
