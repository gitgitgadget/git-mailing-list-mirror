Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E41C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCTUhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCTUhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:37:17 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC32E81D
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:36:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o12so6029976iow.6
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679344603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCU4p55uAUV09+1U69YE5PHFZT14ZrhcTNABx1Lftls=;
        b=fMsTG5bBh0m77aoXyrZcSFHYUd76++RAbfeYOeO28jR4oha/nAwai6NNqTyKcxdBe1
         +nVRuNH0pjYFy2u7LIff4uz+pQFAhf2B9vaWteJJW1hUijZ51DyzvIbb61YHHIPQ4xDw
         bKTR6+yUBGIKO0FkIOQruxBUpLWPWtOek6QAGoV9scs9WVC2LvTlh1gH59Tc4MP7gd3/
         n3tDjEGJMamorwoUZaOg5qnKklquRVEy3cqsD5HHDHcSVgtJRZl+xklqOErMSOvHGvVK
         dpMwpsHqPx4/yPy8Ilzl63uNfDMbsLX3ovMII5BO04WylT9EsSjpDfP3kvbBMC+2HWXS
         aKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCU4p55uAUV09+1U69YE5PHFZT14ZrhcTNABx1Lftls=;
        b=hYEbey2LTW/aT+I7R64G91JXCGKEMw5qkqjUZJ3uU1OQk3ZvZ0gDCY2Du4Vm7UpCej
         2zxe7elSQUXgYCl6Xixnu52K0UMadIn0r1HWZ1svLzsdcbOa5nbO3gPUruMSTttVMelV
         j/fRntDKEbMuduqewyUlR7fePrbcLikrR45UiHlePHNFCcj1YM2WWdxZy9VjZtRasYgZ
         9Gu9A4g/nAhOdTIS8QVNwyr2th5M2LwVtccHgkwNa+g5Pg1f4xJGAAcAC1GHwHeuOoWs
         CK4NXzIXNmnvCP4mN59MJhjRGyqwvwlHbZIH3CrQYxZ7OAL8E4i7LRIL1Z9mgybHS9w9
         lUhw==
X-Gm-Message-State: AO0yUKU8EerWffK2o0Y2/NiAsJBnTzopqn4KrnA5hoT3naodslYYZgqc
        gT2YZKByokiSVlQhTznvPVr8Mw==
X-Google-Smtp-Source: AK7set+7OtPYxZSrU/sxvctJu7Ge5taQAJtGg1Whk+cXj25zQRQOtQjbHs4f1AGYRA8kyuzRJq0iEA==
X-Received: by 2002:a5e:8b01:0:b0:74c:a578:e3a0 with SMTP id g1-20020a5e8b01000000b0074ca578e3a0mr160782iok.5.1679344603530;
        Mon, 20 Mar 2023 13:36:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i44-20020a023b6c000000b004054d7eede5sm3504728jaf.22.2023.03.20.13.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:36:43 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:36:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Paul Eggert <eggert@cs.ucla.edu>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
Message-ID: <ZBjD2l5VhW/QhZXH@nand.local>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230319064353.686226-3-eggert@cs.ucla.edu>
 <20230319193449.M629601@dcvr>
 <xmqqh6ufo01u.fsf@gitster.g>
 <xmqqr0tjmk6d.fsf@gitster.g>
 <047178a8-ccf5-1cab-e670-8f1c64f9ca3c@cs.ucla.edu>
 <xmqqfs9zky94.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs9zky94.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 12:40:07PM -0700, Junio C Hamano wrote:
> Paul Eggert <eggert@cs.ucla.edu> writes:
>
> > It might be simpler to use the gettimeofday workaround on all
> > platforms, rather than having an OVERRIDE_TIME flag and complicating
> > config.mak.uname. gettimeofday should be portable, as it's already
> > used elsewhere in Git without configury.
>
> That is an excellent point.

I'd be happy to assume OVERRIDE_TIME is set everywhere and just drop it
entirely (using gettimeofday() unconditionally within git_time()).

An alternative approach might be to leave OVERRIDE_TIME time in place,
but treat it as opt-out instead of opt-in. I can imagine that some
exotic platform might want to use time() instead of gettimeofday() for
one reason or another.

Thanks,
Taylor
