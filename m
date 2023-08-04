Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BEC001DF
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 18:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjHDSgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHDSfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 14:35:16 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49949D7
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 11:34:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58688a0adbbso26087807b3.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691174078; x=1691778878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qUvbP5QP6nS0xUdanWbuTin24alWA6uMPoiDpi62Fy0=;
        b=uTWtnoL2IsLPWebh0ZtUb2zbdqUc668SSfRNlzXgXSR520x5tdTbh8OnG3MGTEeJcZ
         qLon33SxoXDjxedD8l0dmUVUvIQ4A3MSJXUrDDm+QXvGstPGCiQXF0fifAINtabHovya
         YMoGbiPsGNYh9PZkkMuBC9AkKAgD2MceiwuQWd60LREJE1eatuxwZaQO3RKOdv+7PZfI
         4cTOpKYd2y4jT6jS4u9lqhmvYD7LsluVuytcStn69yOm3WSCK7h8jTAib8AThbp/pCL9
         FnupisaFvO5iWVsHC5v5KZB3iVvlfOgBLn6BQ/Q65+ZWg8cXl6GAde/Thbe0w9KypMln
         3DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174078; x=1691778878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUvbP5QP6nS0xUdanWbuTin24alWA6uMPoiDpi62Fy0=;
        b=bQ3LSPMn0hCmHPt+kLDzc3KCzqr0EdK5wjPKlDklEeI7wrFWFaZsgl228Fh2+qXQVB
         MfTOZqIePu0twQts8WZj90w1hEK9jY2yW+UW05ymaf4hxMFnxCiC9s0a+WyAQ3ey6g7C
         DWYsfRQ7dRe4nbFow5+6XTN1KupsRsrCA+Ec60k8MoM75yt9gGK8EO5ZfGVBXa2uSHJH
         CanBfKphEVFnS33GX0vgX5i55pF4K6QomNhw6AEhrLQmYdEUAGTGsIE9QKuHXUyYqwZS
         UW08q2OB8+HIA6RyoIyUkTLQaXQcs1zn17zbYoWXYUWsNhgJGYQ4TrOxrXAYMnsjwxmO
         qHkA==
X-Gm-Message-State: AOJu0YxpwyEpDjEdPS0WmF71aiGDdwNF0CIPszOlnsTnU75ez4ZcjV/v
        F9u5zxTcQPBjoPBMcNtjUehTtHu8/CRB8r9ihfUtwA==
X-Google-Smtp-Source: AGHT+IFsbeM7o8TudtOeOxACE9+X4ufpFHXBhjcYf4BaRXpljqAIstU/exxAFjO9y9zFcnnHwtqUdQ==
X-Received: by 2002:a0d:dcc1:0:b0:583:4f9b:27d7 with SMTP id f184-20020a0ddcc1000000b005834f9b27d7mr2291670ywe.52.1691174078063;
        Fri, 04 Aug 2023 11:34:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m13-20020a819c0d000000b005839a780c29sm868176ywa.102.2023.08.04.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:34:37 -0700 (PDT)
Date:   Fri, 4 Aug 2023 14:34:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [QUESTION] how to diff one blob with nothing
Message-ID: <ZM1EvGVGv2ZYrpuT@nand.local>
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g>
 <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g>
 <ZMKtcaN7xYaTtkcI@nand.local>
 <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
 <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
 <ZMvGsYSystLu6oBY@nand.local>
 <CAOLTT8Tc9NevyUfwiPscEH7BqShSscb=iZP4r+7mjsEwouLeXg@mail.gmail.com>
 <CAP8UFD2GV+1LhZDrSsgQ5=gRgYSTYsS36i2ugoBEHu-Oto-Sow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2GV+1LhZDrSsgQ5=gRgYSTYsS36i2ugoBEHu-Oto-Sow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 04, 2023 at 10:28:53AM +0200, Christian Couder wrote:
> On Fri, Aug 4, 2023 at 6:42 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> > Actually, there is no need to support a default empty blob.
> > For example, with the command "git diff --no-index <file> /dev/null",
> > it can compare a file with /dev/null, but it can only compare <file>
> > and not <oid>.
> > Therefore, using commands like "git diff <oid> /dev/null",
> > "git diff --no-index <oid> /dev/null", or even "git diff <oid> --stdin"
> > could potentially solve this issue.
>
> Maybe it would be clearer to have a new option, called for example
> "--blob-vs-file", for that then. It could support both:
>
> $ git diff --blob-vs-file <blob> <file>
>
> and:
>
> $ git diff --blob-vs-file <file> <blob>

Hmm. This feels like a case of trying to teach 'git diff' to do too
much.

Thanks,
Taylor
