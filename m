Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD86C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353896AbiETWUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349163AbiETWUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 18:20:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E3615A
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:20:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 135so6104437qkm.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGT7rEvWcSQz8vcPLMhKS3mkLr7Vijmt4LSD4WiPVtA=;
        b=Gtff0K+uS/SMCqbwohKALlSDWLb7hON5xmWxRe+MVv+KqGXDhR2um3eT4aK0HySZ1L
         Dalc+y9vYqpAFyLGQDWNWk6aBo4WEU7S2J9WJGZfXnJN8kQ30Z5S9gxSHclu697265rO
         NfZ4F5cWaknAl0JMgtCMcpzUYuyxzYxrqcTjH+NjDJ9v9ObceqpjgleRNnrfUoZBLJqx
         Irw2q297FBnd1IrZjFFBKBSy8O5hoIcSSAChM/qLKsuC9by4VJSLrLtiR8wBbvVD0Ej5
         f7LkFGAFA5V4k8hHt4cH5NWWERkTbySNJNUaR7Vv5voz5xLiWJ2PkXZqvatljRI5ikrV
         76MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGT7rEvWcSQz8vcPLMhKS3mkLr7Vijmt4LSD4WiPVtA=;
        b=1hjE2nIBKIwrsrU+gX//aWO924She//wY3lLLVT7hNLTchcud7aU4BTY7D9AQsAFiB
         5vqQkwlkGU/513xBuQFhB1VXlCbS8dZDQ5CNKvq7nw+87skdCm9fdwxoM4i1cQ2Wy8+9
         NDaHpWZdJSIsFzetHnVDHsd/f5axiSx/Z6Dr/rWWipizXEUcNM/aBq3DhHcyvU8NrPoF
         l0u97LBYUF3XhVAqOoO8ZdToUqpdy7Axy+T55oyCwewrT0nwjIdVtOe0/JWcsR01q6q5
         Bw340V3HSAsf5rwJhyrEY3Dfcs9jwFjCjGoUOE95GdVsPEW0YIsUOfDIBtG2e+rGf1dA
         5ruA==
X-Gm-Message-State: AOAM532aSwLtlS6Lg9JV6aHqSVsqJINFvOtV3/+FciHWeSTl0U7RMhbh
        mLalN7UJs20RG9J5PQYwro6nPmrzFtlQMlg5
X-Google-Smtp-Source: ABdhPJxkn8CRJRTP4KEISseY5pyqDw5ge+fdd3wxpuq1NhmcKjnAD/hxBiYIUJBwejBQfTQnZA3klg==
X-Received: by 2002:a05:620a:4310:b0:67e:8460:5a10 with SMTP id u16-20020a05620a431000b0067e84605a10mr7549418qko.636.1653085248488;
        Fri, 20 May 2022 15:20:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cj19-20020a05622a259300b002f39b99f6aasm402578qtb.68.2022.05.20.15.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:20:47 -0700 (PDT)
Date:   Fri, 20 May 2022 18:20:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
Message-ID: <YogUP+K8BL67WOPM@nand.local>
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
 <YofJLv8+x5J7yPmf@nand.local>
 <xmqqr14oey2a.fsf@gitster.g>
 <xmqqee0ng8fj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee0ng8fj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 03:12:32PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> >>> +			/*
> >>> +			 * The pack may be kept via the --keep-pack option;
> >>> +			 * check 'existing_kept_packs' to determine whether to
> >>> +			 * ignore it.
> >>> +			 */
> >
> > OK.  So there are two classes of packs we want to exclude from the
> > geometry repacking.  Those that already have .pack_keep bit set, and
> > those that are _are_ newly making into kept packs that do not yet
> > have .pack_keep bit set.  Makes sense.
>
> And with another topic in-flight combined, we have the third class
> that we would want to exclude here, i.e. the ones that are "cruft".

Indeed. tb/cruft-packs handles this by:

    if (p->is_cruft)
      continue;

since we would never want to roll up the objects in a cruft pack during
geometric repacking.

There is likely a small conflict you had to resolve, but the resolution
on 'seen' looks as-expected to me.

Thanks,
Taylor
