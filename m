Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC5EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFPWhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPWhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:37:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD4EA
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:37:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec9bso10961845e9.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686955059; x=1689547059;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A9/cqK6fz/FkStRv1wSuiNZnfiVhxacsyp8UAHk8PA=;
        b=Wef+ZCwtjXJWIZ/MeGg+CBWvtoJQRWA2GXofK5e9/dXPaUtrXWmJVg9vMEStY6M88I
         e4tBgyOW0mhPIAUt4KGJWn36XC5yvYWQifvZZELOmyh31kYjGaPzqMP2AGkNcSpMlT+F
         DiEYhtP6aPKpoJ+YXTFP4iMcQCBc/VKsZTrmmIxlm431vTZ78cN3YchdBoTnqaMcsTQI
         wzdWbhgMFvEuL/SkJOHsRvZvBeIz19gb4yG0sKKcoaNEb4qaPKmyuCFJRg1El7pWXX55
         7Pa5W7E2qyC3TQy7CnqmilfQpiQ/aN5QslVbMnm/LBlEZOIUsutDqES1xG+Bn4QpK5qN
         H2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955059; x=1689547059;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+A9/cqK6fz/FkStRv1wSuiNZnfiVhxacsyp8UAHk8PA=;
        b=E+B4toTVj7Bov2SGrw+FZJbtVbPEIdiHB/itBAi+0peV7OxUS7+L5iEI0TBwjNPaOf
         1hnLGvdCBHAOpkZn+nL25PBLLHZPGGdQgwObc4rO5WlSCMfpNWNJVgbTe/AMRsMTrd6n
         v1QdUB00mcWtICGq9MYHF5MRE1LvNuvcDSMaipppaXXP2md3eYB0LhDhlEF9BGnWCjt4
         Fi1Yw36aJ57aTHGCBP19ik6SqM7Bq+scGIpjHdwgHRq/9lSw1EXfvhKeRHZIjEGYy2H5
         oYHBCP7c1dOg0gABy6bECB7AOSObvHliwiTCDFu1iefufiudijBQ3QLFZGmbYQWbF2sI
         T37w==
X-Gm-Message-State: AC+VfDwCT/2WX30FpJCv8p6QcUa39BZaTRPl9JdrRUBvXeRM/5fk0qQu
        /g3QZJtU1ikY5C8micK0lDAgxbXVLR0=
X-Google-Smtp-Source: ACHHUZ6UmC7lvsxMOgB0Y5ORpGa+sPSRiFxp0fNZSnrfvOK/FsHA4X/W63vESWyseoM+Kh9k/tqVgw==
X-Received: by 2002:a05:600c:d8:b0:3f4:20ec:7601 with SMTP id u24-20020a05600c00d800b003f420ec7601mr2976360wmm.34.1686955058527;
        Fri, 16 Jun 2023 15:37:38 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id e4-20020adfdbc4000000b0030ada01ca78sm24596987wrj.10.2023.06.16.15.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 15:37:38 -0700 (PDT)
Subject: Re: [PATCH 03/11] remote: fix a leak in
 query_matches_negative_refspec
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <a9b27053-ff2b-7b67-f2ba-5691f4bda961@gmail.com>
 <20230612031732.GC306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <3a675cd7-6847-2a23-561e-5baf513d65e0@gmail.com>
Date:   Sat, 17 Jun 2023 00:37:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612031732.GC306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-jun-2023 23:17:32, Jeff King wrote:
> On Sun, Jun 11, 2023 at 08:49:35PM +0200, Rubén Justo wrote:
> 
> > An interesting point to note is that while string_list_append() is used
> > in the first two cases described, string_list_append_nodup() is used in
> > the third.  This seems to indicate an intention to delegate the
> > responsibility for freeing the string, to the string_list.  As if the
> > string_list had been initialized with STRING_LIST_INIT_DUP, i.e.  the
> > strings are strdup()'d when added (except if the "_nodup" API is used)
> > and freed when cleared.
> > 
> > Switching to STRING_LIST_INIT_DUP fixes the leak and probably is what we
> > wanted to do originally.  Let's do it.
> 
> Ah, clearing a NODUP string-list strikes again. :) I concur with your

Yes.  "_nodup" with NODUP string_list, shows red flags, imo.

> reasoning here; switching it to DUP is the best fix.

Thank you for reviewing the change.
