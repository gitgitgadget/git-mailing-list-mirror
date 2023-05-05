Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486DC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjEEQvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEEQvl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 12:51:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A27191FE
        for <git@vger.kernel.org>; Fri,  5 May 2023 09:51:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643ac91c51fso415274b3a.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683305499; x=1685897499;
        h=mime-version:user-agent:message-id:date:references:subject:to:from
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gGKBA0CPQk7QziHWfdCNLTJUGcitUSeFBX+eC6M1mGc=;
        b=o2+/+oMDjF914vRTt41c4r0uboEZ1TvGRd4LwO59pWeHnV9cVOZVHrnYVhEsfJ8EQO
         hS4YjqGo/fEgLn0fZaupUpOKSZxNjjflPQYM7++Lr76ggARiJuj4yvfEZuSOLb4BV3Hq
         VfMGsPWVWh/+0ZwQgpm4VXUD0OgKr/Xh4lNX0ujwh1/GaUFw8Qe8Dkic6tTnZxCRbGKh
         ckJFqeisKyJ5zNj/33vCd1UkxS0vMq7/z3TiWgCGGkSRMcRa0KJAxCrE3YQPDRjSZexQ
         8YNyO9bZDwwYf5fIYexqQ3MzZwisclW7L4SWo3VRbzmwo3nP3P/27CNu51HkzvNKm3kT
         OxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305499; x=1685897499;
        h=mime-version:user-agent:message-id:date:references:subject:to:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGKBA0CPQk7QziHWfdCNLTJUGcitUSeFBX+eC6M1mGc=;
        b=bQc2wzpZXrNJWJS3jzdAH5t9WanC/wJkeLYbPIaR4llD2+y+4DPlotp3vuogYDkUIr
         xii0MoLNGNzD0CcdkSzB0Xws0JOWU/uj7Mu7tJKigleEi9lI/Wi29UP8jLePGVePymQK
         5rcyRIEy5KBPD4Kk0ex3hsbAkija4L1rwWz3oxfnQRfeUR5mIKuNMDA1I/u+l1rvC8/C
         l8bkynh6oVN5sq0vL78EPqLUsFqZoTjNlfer/77XTK4zAAOOkb2rAuzssOfRIkyp+3Lk
         IKytGCwsO2thc0I3WiTc34Q0sowoiBn6ZhdpYK/BSkx9Kb8n/OQCmPppV5coDb4zUYpY
         ggyQ==
X-Gm-Message-State: AC+VfDzfYDScltf35gy1QbG6tiofDgHHEIIyEEu6WAsRDocCOI9w9RSC
        EbxucisZhfXOfrwFJ7hObSC8T0cmGto=
X-Google-Smtp-Source: ACHHUZ5Db/1pHi/SUINwZQHVw/4CvoslfZfy2D7QEuBjgyqj/O8mjJzdtFyBNfCkeVj14I33USS7YQ==
X-Received: by 2002:a05:6a00:1a50:b0:643:59cd:6caa with SMTP id h16-20020a056a001a5000b0064359cd6caamr3303941pfv.7.1683305498926;
        Fri, 05 May 2023 09:51:38 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0062d859a33d1sm1843526pfm.84.2023.05.05.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:51:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] diff: fix behaviour of the "-s" option
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
        <xmqqjzxnixqr.fsf_-_@gitster.g> <xmqqfs8bith1.fsf_-_@gitster.g>
        <xmqq4joribyv.fsf@gitster.g>
Date:   Fri, 05 May 2023 09:51:38 -0700
Message-ID: <xmqqlei2en6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  I think the "historical
> reasons" why we did not do that was because we wanted to be able to
> do a flexible defaulting. ...
> This would almost work, except that it would
> make it hard to tell "no command line options" case and "'-s' cleared
> all bits" case apart (the former wants to default to "--patch",
> while the latter wants to stay "no output"), and it probably was the
> reason why we gave an extra NO_OUTPUT bit to the "-s" option.  In
> hindsight, the arrangement certainly made other things harder and
> prone to unnecessary bugs.
>
> Anyway...

The distinction between the presense of NO_OUTPUT bit and absolutely
empty output_format word indeed is used by "git show", in the
builtin/log.c::show_setup_revisions_tweak() function.

We could lose DIFF_FORMAT_NO_OUTPUT bit, but then we need to replace
it with something else (i.e. DIFF_FORMAT_OPTION_GIVEN bit), and

 * "--patch", "--raw", etc. will set DIFF_FORMAT_$format bit and
   DIFF_FORMAT_OPTION_GIVEN bit on for each format.  "--no-raw", 
   etc. will set off DIFF_FORMAT_$format bit but still record the
   fact that we saw an option from the command line by setting
   DIFF_FORMAT_OPTION_GIVEN bit.

 * "-s" (and its synonym "--no-patch") will set the
   DIFF_FORMAT_OPTION_GIVEN bit on, and clear all other bits.

which I suspect would make the code much cleaner without breaking
any end-user expectations.

Once that is in place, transitioning "--no-patch" to mean the
counterpart of "--patch", just like "--no-raw" only defeats an
earlier "--raw", would be quite simple at the code level.  The
social cost of migrating the end-user expectations might be too
great for it to be worth, but at least the "GIVEN" bit clean-up
alone may be worth it.

Not that I would be starting the process right away...

