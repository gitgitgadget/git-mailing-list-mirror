Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8085EC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjDRO5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjDRO5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:57:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2CB46E
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:57:00 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54c12009c30so568327817b3.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681829820; x=1684421820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EasCXzX/1xGJwHc5He6AiQqhEyQZoJDWF+nn1/Z+GM=;
        b=QYm1fxVHrBYFsjRnoWHgYTnpvfyTNDNRQ8cnx4DgvtB974u5iHSeJy6UOspfHgCmmK
         5Npp96VA/WFc35MClqXzew6fhg2VToil0AzvUf3kjn8i8L7t/GuxEEv0q+AzcmWc/CSM
         8bLcPUR3rKZ+WeTNxHpcIGOg2HEFirZIWMcPSxDpr5IfxIPEq4Ywk485XA0Enap34SI6
         Iv2ufwgWhB4AIqYauP3Gab/TURLhkkVCGl/wO7pVpsNmh8JFj9RO3xACN03RFi1WZspH
         C0PBNCjWlxrvh+sBM5XZ0H/j3OSsCM3baYwMSxXyfXc8/ft4RJ7X3WV4Yxm/Xg4bnQGE
         Rdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829820; x=1684421820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EasCXzX/1xGJwHc5He6AiQqhEyQZoJDWF+nn1/Z+GM=;
        b=irXeSyS/SNMkkDGAh2Cg8T1FxG/QYMkjl1cpDJVE7pkjIdC7SyDapSYMTLV1fzeIGV
         pMstoj5VpWWTQpnuhIDwuYeCjKCkHDjpfVh7OOIErc/04g7TyEH35H8w+VSNDco4bZC1
         PMqXjrIhMbIqh+TONxUO92fVgXQz8OpN9GPYFiqiOgk72/OZoNA2phkkML+72RLnaWvT
         RYp2DLNnFGz6KZIiooYKgv2QoV/dVVMkTuXxH7R1LknDI7d5F8NmTOmfX+G65LTgJsj7
         8NlCVYwws5bwRmUJqCuAsDk+vHJkE0KAeHQZBsjvOY3KTLbsPBhOfDOnPEhb5nILIdRZ
         DlaA==
X-Gm-Message-State: AAQBX9dN9F+09n705jmVj4xeUkGgbdHilZecQHdYGOKLj29+a/tfiMMS
        V1l/Ec+0urjrZkYWRsoxEI879w==
X-Google-Smtp-Source: AKy350bARM+dAQ/QTv4qnIrC+am7PQ+PqDc7FnwjWyJHazr5ZZIcYAOkux8a6AeBJvhqcgzEdCFRUg==
X-Received: by 2002:a0d:d514:0:b0:54f:a23a:7bd2 with SMTP id x20-20020a0dd514000000b0054fa23a7bd2mr226051ywd.2.1681829820131;
        Tue, 18 Apr 2023 07:57:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 127-20020a810d85000000b005463239c01esm3864099ywn.51.2023.04.18.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:56:59 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:56:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>
Subject: tb/ban-strtok (was: Re: What's cooking in git.git (Apr 2023, #05;
 Mon, 17))
Message-ID: <ZD6vu6H0xzLSF/2w@nand.local>
References: <xmqqfs8xfw25.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs8xfw25.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 01:12:34AM -0700, Junio C Hamano wrote:
> * tb/ban-strtok (2023-04-14) 5 commits
>  - banned.h: mark `strtok()`, `strtok_r()` as banned
>  - t/helper/test-json-writer.c: avoid using `strtok()`
>  - t/helper/test-oidmap.c: avoid using `strtok()`
>  - t/helper/test-hashmap.c: avoid using `strtok()`
>  - string-list: introduce `string_list_split_in_place_multi()`
>
>  Mark strtok() and strtok_r() to be banned.
>
>  source: <cover.1681428696.git.me@ttaylorr.com>

This one needs a reroll to remove `strtok_r()` from the proposed banned
list, and to support slightly different semantics the new
string_list_split_in_place_multi() function. Will send today.

Thanks,
Taylor
