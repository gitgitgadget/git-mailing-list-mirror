Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA78AC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8D620738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyS3FzD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgGGWV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGWV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:21:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24675C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 15:21:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so39700247qkb.8
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T60J5bju2xCPTWB64gE3GpQ6UrYtxxMyG7yXtCazAAc=;
        b=JyS3FzD7LGDxgjSvd9y/26J+yDrafqVmZ1INghvENHjxYUUX/9Qu6x9B+v97vK6eIA
         5O9DR6K3cXUQC3mNwTiD75XGbTdCQ5oZawdgGyOs+aZ8hiFrewSIwlAq3atOUNm6QBPH
         fuK3XVGVk3RuKwF2mr/e/lYtJzbfNx+j4y797JfjRRWXo6qVlQd/quWTrmkh+ZQZVDQH
         /+/K5cTPqlvv+eMe5k+KmwUlqt4Afyt5wk8d9Sd9I6SDm7CQHt6SJDxiqfvzXuLom2NX
         5bJqL0ob5krJtRVBdsHk58NJ5Y7wE9oRYpjgeYr02WnSSMDdO1C5USdxv8SpNcpkztAm
         gIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T60J5bju2xCPTWB64gE3GpQ6UrYtxxMyG7yXtCazAAc=;
        b=p05TLVCjbtYTDMXxoIzxw601VcXl/KkhL4pO98JUczcH/Z3Cn1JtBz2JVgfRRh1Poe
         dcSDrm3AisfYO+YB+MyU/a5wtVJalrm4aFvBMYXv0UuaDGnwWChR2gDpgYS6r2RYbz2p
         GAHoDtZfjGQG3NL6px4vQmG6fDqszfjok08X0cSoDORbPUmi5OqDZkNHoFXjWAXOdcPi
         NBSyJAgvlp59NcPXCPm2Qc570vNB3RzEMplxvCyvX9CpPna1fWibjF2wFBmX8N2zZZ0u
         K1aDquhTRVJSZOWVTBHPzy9XEY9VHQvbN0VM9X444zXTjJVfvYQFoGM4QXcCbKNT6B6e
         Y4jw==
X-Gm-Message-State: AOAM53154Orbk/XOLlKLcV6zcquIzofTsL/Y6IEOKewjiy0f8QAyhRq3
        zXYn30eJ0gUegwNve5qEeb0=
X-Google-Smtp-Source: ABdhPJzRKQOGEoveBVvjZoeuI9ieonBq5ngHyjSt4Z1DmN9tLyncNZrRKvJEq8vrRG0xFsncZu++zA==
X-Received: by 2002:a37:b341:: with SMTP id c62mr52440111qkf.128.1594160518264;
        Tue, 07 Jul 2020 15:21:58 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p29sm27439809qtu.15.2020.07.07.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:21:57 -0700 (PDT)
Date:   Tue, 7 Jul 2020 18:21:55 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RESEND PATCH v2 0/5] t: replace incorrect test_must_fail usage
 (part 6)
Message-ID: <20200707222155.GA27311@generichostname>
References: <cover.1593576601.git.liu.denton@gmail.com>
 <cover.1594101831.git.liu.denton@gmail.com>
 <xmqqblkr3x6q.fsf@gitster.c.googlers.com>
 <xmqq7dvf3uwc.fsf@gitster.c.googlers.com>
 <xmqqwo3f2cx6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo3f2cx6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Jul 07, 2020 at 03:11:33PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > It seems that the patch series lacks coverage for t9400 where we
> > have
> >
> > test_expect_success 'cvs server does not run with vanilla git-shell' '
> > 	(
> > 		cd cvswork &&
> > 		CVS_SERVER=$WORKDIR/remote-cvs &&
> > 		export CVS_SERVER &&
> > 		test_must_fail cvs log merge
> > 	)
> > '
> >
> > which obviously needs to be converted before we declare that it is a
> > hard error to feed a non-git command to test_must_fail.
> 
> For today's integration cycle, I added a fix-up at the tip of the topic
> 
> https://github.com/git/git/commit/dde09ce2b7dd62eafda6339c1c31ccfeb0f39cee

Thanks. For the final version of this series, we should either queue
your patch or the one I just sent[0] just after the patch for t7107 so
that it comes before the we flip the switch on test_must_fail and also
so that the patches show up in increasing numerical order.

[0]: https://lore.kernel.org/git/4ca5e1f9c06ed509fc3165c550d0d665dd5b69c0.1594159495.git.liu.denton@gmail.com/
