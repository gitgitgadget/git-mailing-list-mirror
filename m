Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795ABC48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2DC613B0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 19:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFJTD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhFJTDV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 15:03:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F74C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 12:01:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so7063680wmq.5
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hl+Tp4qxfTjMuXhgJucaYrztBqtJbZnj0tjNlM010ac=;
        b=hM9hJ2Sxe06mGfPaY5ZOJBrm1ZpzE5j0pir2RCcn7x1A1K9lA9o6vm7T2meq8k1tTM
         ixqA82m1gOFY9ktgLeLcc9NTZcxpu4xZGz9CfW7S4EWtg6I+ZMIbE8NN6Y47oH0SA1GN
         UU7MGSCp3JJ8IUpsPM85B0nN+wl5prVHHfPzVDmFg5Z/JtZIEocOW0ZKtDs+DdGpxVnw
         +wjc22pwoc7mjKkVcNyjlKmbrBtmxjdr45DuJUzxLDODnidNRgs1nWrBmPzx6DCUxs/E
         LMhF7ZrZ1qxQys7juq822cuPzjyyHsfdgwCixbI8005tTlg8pq2UZFGuZ6LQ2hu3oJpq
         9I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hl+Tp4qxfTjMuXhgJucaYrztBqtJbZnj0tjNlM010ac=;
        b=Xi00zP9NivQ5i4FaR9KHdsFTWbZwJolFnKlGNMPmX0hS6qyJaj9T4ifTLqqfoaWX2z
         qBgyhVwV2tXt/CmJht+pyxktzbB+ATPYOvO/S9EvL91vLYmqQQHKsOK9SNbeY0oBdbeX
         eaYNurroExNV3TtHe8NKmiOJuCtlkIDq4ZeWfPGhqAzcstrhxYgqcyY0O9aDlaRjS8Hi
         BkINhv6my4SmSebdflWJn1xVOMrNKGWefNEsqwae05a/J34zddKzHX5VOxMg0MsAcG3N
         FWIL03Ut9PMfkHXAMm59KIvmrWgVAsGUsKRVzXAGaxZQBorG0dLF+TEvCk1I7MvwQYPM
         g9Cg==
X-Gm-Message-State: AOAM533uTtT+XvbQH0EM0oUUKtr65NGb2UDN7qidVrbZy5A30WAV4Zi1
        jFHz2eHQVs8MJVqcXCqLUNg=
X-Google-Smtp-Source: ABdhPJyJ3tB88CnlL17V0B2Ywxy1Srb6uqVTxygknK/xi0oPrHmC2Ej3ARSNtmlC8T8VVaiaznAJRA==
X-Received: by 2002:a1c:5457:: with SMTP id p23mr14366583wmi.46.1623351683638;
        Thu, 10 Jun 2021 12:01:23 -0700 (PDT)
Received: from szeder.dev (94-21-146-170.pool.digikabel.hu. [94.21.146.170])
        by smtp.gmail.com with ESMTPSA id o6sm4812755wre.73.2021.06.10.12.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:01:23 -0700 (PDT)
Date:   Thu, 10 Jun 2021 21:01:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrzej Hunt <ajrhunt@google.com>, git@vger.kernel.org,
        Andrzej Hunt <andrzej@ahunt.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: UNLEAK(), leak checking in the default tests etc.
Message-ID: <20210610190121.GD6312@szeder.dev>
References: <87czsv2idy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czsv2idy.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 04:38:52PM +0200, Ævar Arnfjörð Bjarmason wrote:
>     GIT_VALGRIND_MODE=memcheck GIT_VALGRIND_OPTIONS="--leak-check=full --errors-for-leak-kinds=definite --error-exitcode=123" <SOME TEST> --valgrind
> 
> But as t/README notes it implies --verbose so we can't currently run it
> under the test harness (although I have out-of-tree patches to fix that
> in general).

'--valgrind' doesn't imply '--verbose' if '--verbose-log' was given,
and that works with the test harness just fine; see 88c6e9d31c
(test-lib: --valgrind should not override --verbose-log, 2017-09-05).

