Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FCC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEPRG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEPRG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:06:57 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04882272C
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:06:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55d2e87048cso206229507b3.1
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684256816; x=1686848816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3tt+LXxWPAXv169+sDVTCVS8rNkKFka8G6bIV71AYo=;
        b=NPnNXbaqluMrwy/m+EPKFPqve5zZRpWGu68iKoP/94y5IT+iapgX8B2KwkxBPmZlJg
         REaBbb+RiE/4PD+k8Ep+xGAPKug3Uo+n64enBZAinRfubuo9iEAae+WCXstv+6SkZIaj
         CUoz1kQ1Q9rOVyZrow617fUjC/y5asCpw/wzt6Z7hiNtmL+6NilwvtDrRDCaMMQHs0T2
         BT3vHBATqRPI0CU7UX/oGGouTxTPVXBGpc3L3oaTfk3KZ3oZrKsf/4KJFSiiHj8k0lI+
         v6F2vD3IiiizHIWjJe1tLNqfa9zFaoio8k4dUAzgPcNBKSGvxtzPZl77KMnE01hhVoGt
         d4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256816; x=1686848816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3tt+LXxWPAXv169+sDVTCVS8rNkKFka8G6bIV71AYo=;
        b=J0ONLz8jNtH6TlW1iaGTlFtZAFQgjH55oGPSmNi1vYXggMAwE4pwn5mvj/pW2OcLZ0
         Eq8wst5WPu7G96Fy+E4Lz//yxJRqw0zuGAlSajt7XRPiN+20yFC5BJ4pWy+g+Bv+/FQO
         L8ffOsUR2U6XBhFQ+k0X5JVsIXezdkMymHx6LI6Fnfrg4TkMCs2zlJE0bqX0/ju5n4DA
         lFLr47dD7YPkbdEYPQCD8vBhqpkR0LHoDMDeU8RgN987yZgIRDCskNftSxuSTeeeJFON
         DuhywQtKdVf7LeBho7dFhAC9KJpu1oheDlwk0l5Lf+noH/xotmV9Pl5NDG/4OmMnByUq
         p0mw==
X-Gm-Message-State: AC+VfDxkNS94pZzAtnlCr7xYL0aSuE4W0QsJMU65d044NSy5LCkS+cMS
        LPoPq+gNLSaDck2KHeu9HixtkA==
X-Google-Smtp-Source: ACHHUZ6D9O+oZnNgEaJhkrFOVuN/rMCfH9MvkZnPeCjmMi5jK8ENgXL2kPjhEySZnG+itG4SqSJcbg==
X-Received: by 2002:a81:a144:0:b0:561:baab:fd22 with SMTP id y65-20020a81a144000000b00561baabfd22mr182359ywg.3.1684256814179;
        Tue, 16 May 2023 10:06:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t7-20020a81c247000000b00545b02d4af5sm5090ywg.48.2023.05.16.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 10:06:53 -0700 (PDT)
Date:   Tue, 16 May 2023 13:06:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] Git 2.41.0-rc0 - Compile Error ALLOC_GROW
Message-ID: <ZGO4LesPe4A2ftdm@nand.local>
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 12:58:15PM -0400, rsbecker@nexbridge.com wrote:
> Hi Git Team,
>
> I am getting a compile error on rc0:
>
>   	ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1,
> git_atexit_hdlrs.alloc);
>   	^
> "/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/run-command.c
> ", line 1103: error(114): identifier "ALLOC_GROW" is undefined
>
> Any help o nthis?

None of the code in run-command.c has changed much recently, but this
bisects to 36bf195890 (alloc.h: move ALLOC_GROW() functions from
cache.h, 2023-02-24).

Note that it only affects when building with NO_PTHREADS=1 (which I
suspect is the case on NonStop). Here's the bisection:

    $ git bisect start
    $ git bisect bad
    $ git bisect good v2.40.0
    $ git bisect run sh -c 'make DEVELOPER=1 NO_PTHREADS=1 run-command.o'

I'll attach a patch in a separate message.

Thanks,
Taylor
