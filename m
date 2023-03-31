Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F84C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 23:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCaXxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjCaXxh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 19:53:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF641C1F7
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 16:53:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-545cb3c9898so369218327b3.7
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680306815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gvndA8wA6cF9BZUPjuliuQWI/KYHtfqNJqLPt6ty2U=;
        b=5Gx/KCUOrUOUarEJw/DS2e1PWKGi9kNGdMVti6G1iqMsTWhSJxt2PND9jrMUlHzZVu
         dzMjH15fdQ2kYkGLpOaCmdi2zy0SgiC5AJf8Do1k4InvZMQYsBI9c0CrJPiNPj58om0y
         APMbi6OCzKhic5SZtNEyIDLjuHIYYcWTpgyh+ni+LmF7AZMF0KZX5EnU6G9ggXSOdTB8
         A0/E2kFN96OGPd7zOCYYhvjABlexV9y3WpCl0KPmsTADCPth2iAF0Jw7LXYwONYM6DRz
         W9vrwsoV6qil8DvfbHRCmE1GUTQ47lrUWYG0ONQDhPU9euli7hTyXIQn+NMIGEL6+h1b
         KLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680306815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gvndA8wA6cF9BZUPjuliuQWI/KYHtfqNJqLPt6ty2U=;
        b=QF+4IyFNLnbalCPbKKtR/YsaacBoEr5S7S3uVjZ3dPwsuiiO5u2u8SmsOSp17Dtv95
         Pz/nN42WmhTtwNBi6qZYolKiRX6BrRA9x6m2PXfAzYj6I9/TGdcNZAAYmp2jPPXFpLdO
         yRt6gIRn225tu0Xbg42bxv2GuTaFdZopTEUbTyFTQC5RdJDxZjAnI/XqOToxqhQVKSre
         Q+8pWwvroEjIRCU/BapH1uWF++i176SjwJjaN5T0AmaiJaZFDZSTY8PVQkblDu5tZ+qD
         nDNHwABJkBHN/uq+kW99dpNl++FkhJJURaN5AplV542txfa4Kfchnmi5xHUiQ2GiWueG
         l3sg==
X-Gm-Message-State: AAQBX9dJR+rg4W4DzJFFiEgYMNOAlYjayxlDKsUWNzl7UL3BhTuRCjgD
        KtAJVW2jMIGIUaj45TnNeU7BxFkSZ5jd/GzEG7AgUg==
X-Google-Smtp-Source: AKy350YyfRv6qeHwV7xt+L0+pfhQlyYhrPmSzzMutBZAsVy0PsskW2XTaqGHZgOsL1SOT05pfaamIw==
X-Received: by 2002:a81:5210:0:b0:546:1d16:d1d3 with SMTP id g16-20020a815210000000b005461d16d1d3mr9057883ywb.19.1680306815008;
        Fri, 31 Mar 2023 16:53:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z62-20020a814c41000000b00545a081848bsm850823ywa.27.2023.03.31.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 16:53:34 -0700 (PDT)
Date:   Fri, 31 Mar 2023 19:53:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: How do we review changes made with coccinelle?
Message-ID: <ZCdyfaiFH5s5eYUc@nand.local>
References: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 11:23:40AM -0700, Glen Choo wrote:
> - When do we introduce .pending.cocci vs .cocci?

The documentation in contrib/coccinelle/README is authoritative. I'll
refer you there for the full details, but the rough idea is that:

- *.cocci patches are used to guard against bad patterns in the code
  (e.g., that we should never write "if (thing != NULL)" and instead "if
  (thing)"). When applying these transformations leads to changes, they
  are designed to break the build to avoid letting these bad patterns
  enter our tree.

- *.pending.cocci patches are used to guide large scale refactorings,
  like Ævar demonstrated in his last series. They don't cause us to fail
  the build in the meantime while the refactoring is in progress.

The latter is useful when the refactoring is either (a) too large to fit
in a single patch, or (b) would cause too many conflicts with in-flight
series.

(FWIW, I think that I'm mixing up my terminology, in that *.cocci files
are typically referred to as "transformations" and the result of running
Coccinelle on them is used to produce a patch. Shows you how much I know
about Coccinelle ;-).)

Thanks,
Taylor
