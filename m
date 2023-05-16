Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1055EC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 18:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEPSr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjEPSr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 14:47:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC72102
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:47:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-559f1819c5dso210735547b3.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684262874; x=1686854874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iD3pujA9G4rmNIp/JQOFYP60bhluiAN+hVoYglkUx4A=;
        b=tShmb/O4wE4DeDANVx1Y3IHvTe/GOBbiVYH+WepQHbEE1jg2ISkduJ3q7rapbRpZIe
         JMxBiTT18F8md2YaQ8+BGRJTzj/V6lg545kzS4OUi/G4kQhTUTah6jYNv2ojoRB/Z1sF
         OGIAFPrCrFWHK/awRU9tCWcxyvZ2ixlcyM5Dcg5m0+rdqpeS3AEwg8Jh/GrNWZSilQkf
         iJ2XLU74LQdiZvW+6MuXzAZfzOx/uYxtagRB+Ds8CEk2Y891ol4qOrXmadW0MTpWaT+M
         i4cd8MeufSUZ7IQD5jEg3TPUKvRJYM2MrkPDAlDeLPjN4O9kTAkuUtDGJjHj/a0M3Y+g
         8Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262874; x=1686854874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD3pujA9G4rmNIp/JQOFYP60bhluiAN+hVoYglkUx4A=;
        b=YD0d4jkqVWlPrXq0uBQrD5IIMc/uAm2pl2jGXhc3CMZGi29zZxeFTFQI/f6wtFihrt
         DTMJXhMHh8GkLe+fQEg4eNOmBjKZa8O/E9L9/VjmYWvbgTnDBc1JLgTpRz/HsChCfhju
         P389yDP6MjhZYKWdKkf7+qnr77kxhbqiVXAeWhJQINwZn62mGP8CsbgL4N1dmrECZfvH
         HsmrcqeBvkEoZzlvENSgFB91133KRLQQZ5zSH/QehYELtr+WGqXx9nwyf6agN08fPmP0
         wpgHMlVBTFFzKqaFohsBIpHrIomN5sbPjmkWMQXr8fxfrVHjL64OvC8vCM2XCY89D5TH
         Xpfw==
X-Gm-Message-State: AC+VfDwleX5CnX9O3+E8P39JjtZPOMMY/wN8eJnrm5By1XAD0+LHYYwS
        o4dpHYij0FTIo2DYwJk0Arx81Q==
X-Google-Smtp-Source: ACHHUZ4Mh3gMqb8ES+U67xE9Ddi3zM0HPoaCQSQ8mZdar/287eYtlR5sOoJRo45iNV6Fq2KZEp37+A==
X-Received: by 2002:a0d:ccd8:0:b0:55a:9b5a:1d9f with SMTP id o207-20020a0dccd8000000b0055a9b5a1d9fmr36521052ywd.11.1684262873933;
        Tue, 16 May 2023 11:47:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a205-20020a0dd8d6000000b0054c0f3fd3ddsm76418ywe.30.2023.05.16.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:47:53 -0700 (PDT)
Date:   Tue, 16 May 2023 14:47:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: need alloc.h for our own at-exit handler
 emulation
Message-ID: <ZGPP02zYlSM9iRYt@nand.local>
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
 <ZGO4LesPe4A2ftdm@nand.local>
 <xmqqlehourbf.fsf@gitster.g>
 <xmqqh6scur3r.fsf_-_@gitster.g>
 <ZGPEHu2pCYfdNI0h@nand.local>
 <ZGPE9ozRChUJ3NGV@nand.local>
 <xmqq353wune3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq353wune3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 11:44:36AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > OK, having now read both completely, I would say I have a vague
> > preference for my version since it keeps the include at the top and
> > unconditional, and has slightly more information in the patch message.
> >
> > But I do not prefer it so much over yours that I would be sad if you had
> > already queued yours and didn't want to bother shuffling it around.
>
> I do not have much preference between the two, either.  Both lack
> one important description that we are reasonably confident that this
> breakage is limited to run-command.c and no other files.

I believe that mine does:

  (Everything else compiles fine when NO_PTHREADS is defined, so this is
  the only spot that needs fixing).

Thanks,
Taylor
