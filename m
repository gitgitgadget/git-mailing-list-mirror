Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB6C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 20:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjDEUlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjDEUl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 16:41:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09F86B5
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 13:40:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so40754046pjp.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680727223;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RaIcy+2wGtchmMsoruyY+wjsVBozeRUz0H4bVBFwhM=;
        b=V5s2zJABjlm9BNW5CF2RY4wQ6B5BemUBSvXuiNbZgL9vxE/gqIBfGcJLI5vp/pSHp+
         bsjeN403FVe1fM1zi1Apeyeaphk5mUxG2mo/978oilw61p4NQQ/kvnzBaP5aQWQcjxtw
         WMx4VRkTos91O5y4uE07y4zuwS06gK1aaVfomyMcYsjbecI3bqzKC1D6o+wOFn+6beiP
         cXwDrsU0GVLcPca4otMCyq3WbglKFVoCIrfyGwO4HvFZsLoo78AQFMZ0r8wq5llmRCtJ
         zP3Kpx5u8KykHMmAKNDo9M1NjvizeFI5r0+j9MWF/dErRAYCtjeL1lE33vSNJoVO3n8l
         yKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727223;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RaIcy+2wGtchmMsoruyY+wjsVBozeRUz0H4bVBFwhM=;
        b=2ZSl/2K+B9vGg4H0dhN3FVD7gVIgPT1PDrrD0jVzQ0iNkVwS5s6N3kUOWwN/hhy8dL
         8OgeV8J+cIEhPcZbjn24PAn4AuZS8e80wBzdLAta+styFuTNBsW7W8u6iCiJPcIuNdAc
         CDuQkpgEWbHfiNAklP7gMIugA/GVFnO3cGkCziEXG63Tw/vrWGRbIlX3SiNBrqz0usMN
         HSYLXfrCRwToa4inY+dmVV8SWYaWsGVJIzS2pMdp/0pIZh6HYpICkBiCQgjUP5UuXeTG
         nPSx37zBEogCgzPqK6So017e4XoUKRE6wrv2cSpzKUdZXQncJyw/pGcvYCCSEX91vjU/
         J0SA==
X-Gm-Message-State: AAQBX9f6z/qWf03VCaZgPB59DMmPUxwyhFAwcHsIIRz5yLTjgq7C1slD
        uvIg3673ofw2gQG8WIfOmgE=
X-Google-Smtp-Source: AKy350Z6260aQlLYOVDDEqNs469Yv06Vneyoi1GUYDt0oTex0dOntWd6qOSAnvPusYGiouQda99d0Q==
X-Received: by 2002:a17:902:e80d:b0:1a1:dfb6:b804 with SMTP id u13-20020a170902e80d00b001a1dfb6b804mr9039218plg.11.1680727223481;
        Wed, 05 Apr 2023 13:40:23 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b005023496e339sm9366843pgl.63.2023.04.05.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:40:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
Date:   Wed, 05 Apr 2023 13:40:22 -0700
In-Reply-To: <20230405200153.GA525125@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 5 Apr 2023 16:01:53 -0400")
Message-ID: <xmqqa5zmukp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, we send a special capability line in that case. If you do:
>
>   GIT_TRACE_PACKET=1 git clone a b
>
> you can see that upload-pack indicates that ls-refs understands the
> "unborn" capability:
>
>   packet:  upload-pack> version 2
>   packet:  upload-pack> agent=git/2.40.0.824.g7b678b1f643
>   packet:  upload-pack> ls-refs=unborn
>   packet:  upload-pack> fetch=shallow wait-for-done
>   packet:  upload-pack> server-option
>   packet:  upload-pack> object-format=sha256
>   packet:  upload-pack> object-info
>   packet:  upload-pack> 0000
>
> And then clone asks for it say "yes, I also understand unborn":
>
>   packet:        clone> command=ls-refs
>   packet:        clone> agent=git/2.40.0.824.g7b678b1f643
>   packet:        clone> object-format=sha256
>   packet:        clone> 0001
>   packet:        clone> peel
>   packet:        clone> symrefs
>   packet:        clone> unborn
>   packet:        clone> ref-prefix HEAD
>   packet:        clone> ref-prefix refs/heads/
>   packet:        clone> ref-prefix refs/tags/
>   packet:        clone> 0000
>
> And then upload-pack can send us the extra information:
>
>   packet:  upload-pack> unborn HEAD symref-target:refs/heads/maestro
>   packet:  upload-pack> 0000
>
> I think we'd need to do something similar here for object-format.

I guess we only need to touch "git clone" then.  Without being
asked, it advertsizes object-format=sha256 already, and when the
maestro repository is prepared without --object-format=sha256,
upload-pack advertises object-format=sha1 instead.  So it probably
is just the matter of capturing it and using it to populate the
extensions.objectformat with an appropriate value.

