Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07DC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 03:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiF3DXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 23:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiF3DXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 23:23:33 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD21FCDC
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 20:23:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z1so10590524qvp.9
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 20:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RaWBS6dPLjUNtleRG405A2KCedg8LcmAg+IMSeRIOjg=;
        b=iRmgecvIkj88LNJNhJ9OJDOJS0wAk2VIZWbmiZqXBeizSI+WTruk1g4TF3MEEYBK+4
         fBpeJxs6gPn83GnQdswqNQoDKyHHv7nc0KxK/LE/BI7ibq16fs9WdgMdc3DR+DFwhkkd
         WFX6dfFFny2SRci+q5WMruJRIeOrPTED0zUfbgR8mHP/Z519RXOy2uAZIjCTpuTlOn8X
         0eK1a6TsDkTFUi4v39njtnSSJrc9kyOa4ILSTluUmfLyzFIF7L7A46mUvdXWZW+vMxHr
         wfvyurSXmDgYK/9N9zk6eyUqI30fzMQNutVfvOdxWfQZemKkwX6odVRQIrh4XjHs5b95
         Sx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RaWBS6dPLjUNtleRG405A2KCedg8LcmAg+IMSeRIOjg=;
        b=BiYI+NHggEdpvr8Ar/EnOHUGSmb/vtmIak9jmn1OluxL6CzgFDJaq9yjTEwgNp54d/
         aiBilGf3HRUz0oLvTAvcoxEe/fkmNKX/Q8TvXdNCJvYwTDtG8Re//xEhx0+0VX1PboWl
         +MfRyQmeAPYAzLHZCOr+e4lXHJ8vtlMsFxSO9x/9H1w5R1hfgnyDwQzPUOrr5WQdUGxD
         DTf+e4IWFJeGkpI5TC1mKuW3GOb6VJobAaj4snbIa/9rlrnlBphbLy7Kkf+H+TCdlfdT
         Eh73sLQCECvLyR2v8vRuMF9+Bw4jrjjgoao3B5JsLmGY0BcwwZ3zgidFv/UHboHs+f9z
         RFBA==
X-Gm-Message-State: AJIora/SryjaqKjd0Ngfz16NQYlhCjUpg63yDlyGfOLP34jrG4cIrP7F
        Xwrn5TbpCMJVoo3++f10WZ28F247wuGJoQ==
X-Google-Smtp-Source: AGRyM1veIcpHINgb0Y92fLDxSWgBGcUVcNVQb9SAqyXxQ+CQbBptK39J2FzR8qzxg4hNOFzdDBRKDQ==
X-Received: by 2002:ac8:5b0d:0:b0:305:2025:c687 with SMTP id m13-20020ac85b0d000000b003052025c687mr5491904qtw.535.1656559410537;
        Wed, 29 Jun 2022 20:23:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f8-20020ac84988000000b002f93ece0df3sm11728899qtq.71.2022.06.29.20.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 20:23:30 -0700 (PDT)
Date:   Wed, 29 Jun 2022 23:23:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: Race condition between repack and loose-objects maintenance task
Message-ID: <Yr0XMWWyD5C9uhlb@nand.local>
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
 <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr0WLebMfBXZ1K7D@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
> > However, I think there is yet another bug at play: running
> > `incremental-repack` appears to be able to repack the cruft packfile.
> > In doing so, it deletes its .mtimes file and the metadata inside.
>
> That sounds like a bug to me. I'll take a look into it and see what I
> can find.

I actually think that there are two bugs here.

One is that we run a MIDX repack and expire, which could lead to us
repacking the entire contents of the cruft pack and then expiring the
metadata file. This is a bug, and we should exclude cruft packs from
this computation.

Another bug can happen when the cruft pack gets written into the MIDX
and is MIDX-expireable (meaning that no objects are selected from the
cruft pack). In that case, the `git multi-pack-index expire` step would
remove the cruft pack entirely, which is also incorrect.

I'll take a look at fixing both of these, and thanks for pointing them
out!

Thanks,
Taylor
