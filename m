Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B4C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLGA5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGA5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:57:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BBA4E683
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:56:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r72so5852244iod.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WnoHmVHCvWpwZ3TLwOX5Xuy6zbiLTVI+O8CJZLhXcfI=;
        b=Cyix0shr3O6fBAaZiVGsYnlm1+foa738tytcSULZdU+LRRuC+vT20leIXLqHUg2i7I
         588Dss9f2r+eNEMXHQHlRc5o7WQV26g2sSUEXWboug586JoslITRRy/lOfySUnHpCM77
         g/0ip0EYzA2zOBaUrLC1yuCsiVfc0HafRCk74G5DLo1+g7g0CBe+e3MKgYiGJ1ij0K4y
         5M0JB9d3JA+P0hHX+0PH9F+yMvmipd08LBJph8oQCSbBCogXK782au8/T441g57BUXaw
         kvxx2nxs/B0uViB29CDvRJL+WjOimuLKI72PbTqc+cfPeVmrMFg3t0EXfratlqrg4Wpp
         LsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnoHmVHCvWpwZ3TLwOX5Xuy6zbiLTVI+O8CJZLhXcfI=;
        b=IcEHmcT/1QUWXpQfVCr4i/h7ELFH44sfBP5omqcdMmjZIsv6OlLuIoGGHPLumJXBJT
         KLY0IweAs1RCtOhGJfZtfX84jt77Xu0clIPbloH67YIre744QllcKfoFyNLBnbA1LIWo
         inJdX7Omu6GiFVJ0DuBKgDzgNjcpBbSkeR6Rfe98v/nYrHIza6O0h1fkwvsK+qFXQTu8
         W2BFHD3HcIox38Ka3Ac774O0Q12Cb9FSfXKeehuM199zQcsotkr0Hc/OjApgwc0TkEbh
         xzG4DMxOEkEh4N2BXMzzb6oQmI/g1SKMMQskrp6G9E0TCMATaFg6klPH8bL5oQtoNfBt
         nhqA==
X-Gm-Message-State: ANoB5pntHyW2sgHOGi+lGQSVtAFJfylU1BVRR+wfOfFckB5uWFm7H6qZ
        ospoEzZT9i+uiF7UkENleFd5Ig==
X-Google-Smtp-Source: AA0mqf55Bz9pUV7Ra3J9xw5vnkLCdKF+vqi7bhUn30YV+KRqQN7fR1XDVpdM+gqLjr4u4+9z/Z+dKw==
X-Received: by 2002:a02:5103:0:b0:375:3f45:dc94 with SMTP id s3-20020a025103000000b003753f45dc94mr43729490jaa.144.1670374618727;
        Tue, 06 Dec 2022 16:56:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f1-20020a056e0204c100b00300c4b978c9sm6579018ils.29.2022.12.06.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:56:58 -0800 (PST)
Date:   Tue, 6 Dec 2022 19:56:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CI: migrate away from deprecated "set-output" syntax
Message-ID: <Y4/k2TW8Udz4LsaI@nand.local>
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
 <3859f3a7-ade8-4778-be15-b393694435e3@github.com>
 <221206.86fsdsb5os.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.86fsdsb5os.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 10:08:36PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > Should this also be updated for 'l10n.yml'? There are two usages of
> > '::set-output' there as well.
>
> Yes, I just missed that one. I'll fix that, but will wait a bit to see
> if there's any other comments first. Thanks!

No concerns from me. I noticed this warning when I was looking at all of
the CI builds a few weeks ago.

This transition looks obviously correct to me, and as long as we apply
it in the l10n workflow as Victoria mentions, this should be good to go.

Thanks,
Taylor
