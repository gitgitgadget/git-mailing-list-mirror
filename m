Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B85C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 14:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiDMODi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiDMODh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 10:03:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594263B550
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:01:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so2459397edu.10
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=53suk3/5seVn3T3rMx0mTRFoTH1Pzh7YGPynle/wlkg=;
        b=O+IUjfjoGGwzGBqv2+AeD6vmOKPdf6EycivVItmzAg8RBFeA0ZDjP+d+zCyyev6VwT
         +C8/rlxAoQnSmp05PlylZSt/Tf7/iTv0Rx2bQ/LaxEr9AC09RaoxyCxk8El5W20VtV5I
         ToMH06l9vaqNFve2iDnYIj864ZXoXF7vPHW+962YlUrLZ5M7vjslcxR/kLcnvR/diGmw
         KbCSwxsYnpAJnuZQVnsuYTGOlGI4qtMLtfgrT/5AV7N4qjGKFYfeSUUswlfuiUJUFKsS
         CzgWA//dAa7Owm5zh/rwRNSQooS5coewyqlwGvGRJjsPAcyuLAsOJJvbUBOa0H3bHYuj
         IyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=53suk3/5seVn3T3rMx0mTRFoTH1Pzh7YGPynle/wlkg=;
        b=vB/ublet5Lh8mezH5pVFMOEsOjtdIDWcYsm8XDqhqRNa8Yqd/9a0e8weq16wunLOJ3
         OoBasqDkL+Nk6TrPD255If0+8nRKmOAlp0ND8GCCUrBPjZYIFbu27rd6lrfNbH03iARr
         W35kOMliQONq4/j1ZlQU9H00qQmnGY8rD5PDAX8AwdjHkgIERPeyt54+VA4ATIvK4hZ8
         rD37tiCtMcbIFJkozjREBE55GC3ByfsPGCNz1MC4CzAFeG/mur7acpyhK4h9wkbgYg4w
         ntF2FybCMmkXlPGSuiymx/E6QrKFNIll2SSNiXKCmpWMhWqDTu6ZGyk/MUIE0/7eJUsD
         KNag==
X-Gm-Message-State: AOAM531SJdvDfNODmPuhErR5ipyEiYmaBEzXRT7W99Lgl88USYuByrB5
        VtBcC7K7aQk319IVB+x7H9E=
X-Google-Smtp-Source: ABdhPJwC2Lb0IxNwSaPMgmWPcVx53qzSS4bfgjMmJT7wcpboQbIUSGbuGPUo2j+NuA/yH3EM/h1ZWg==
X-Received: by 2002:a05:6402:b57:b0:41d:6d9b:7e0d with SMTP id bx23-20020a0564020b5700b0041d6d9b7e0dmr21704688edb.78.1649858474598;
        Wed, 13 Apr 2022 07:01:14 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm1211216edt.34.2022.04.13.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:01:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nedYW-005422-NP;
        Wed, 13 Apr 2022 16:01:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
Date:   Wed, 13 Apr 2022 15:59:45 +0200
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
Message-ID: <220413.86zgkpf5g7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Tao Klerks via GitGitGadget wrote:

> Under python2, git-p4 "naively" writes the Perforce bytestream into git
> metadata (and does not set an "encoding" header on the commits); this
> means that any non-utf-8 byte sequences end up creating invalidly-encoded
> commit metadata in git.

If it doesn't have an "encoding" header isn't any sequence of bytes OK
with git, so how does it create invalid metadata in git?

Do you mean that something on the Python side gets confused and doesn't
correctly encode it in that case, or that it's e.g. valid UTF-8 but
we're lacking the metadata?
