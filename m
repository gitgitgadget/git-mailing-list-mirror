Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D7EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjFVMx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFVMx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:53:58 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDA10F6
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:53:57 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so923863276.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687438437; x=1690030437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFbBxmSDQD0fBArYgEGeYkXIUwBk9IBkDkHca/jWllQ=;
        b=y8VpAjCNgkPac1MiOf8p7+3GRgVH6if89T/OCcbbHuJLNvQaI+KphZ6+fEkgLiKVhn
         rwEKjY20ZjQR4ZROxYY10ehonngEMTRZBHoaW2pKs+dtuCkTScZG4MPyH5ThhdYPYPFq
         mhIHmK6zR2fn4DRTZKq3slj3qNCCcOdfZGTLTE8PPVUbMvbgw1I2lWZABOJp28duwxiL
         9r8aKw7kg0BhkbJNr2JBYpr27308bmGU/sGMqOC3b2SAnNS183r0Uaa30t4yM/VP5qcs
         MvjOwF/QXrDCQcs9gyyAkLGj8bAzv7Gc1j4C6CcmleAATdLCoRqKnAE7kAcSrDi0+dAS
         HpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438437; x=1690030437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFbBxmSDQD0fBArYgEGeYkXIUwBk9IBkDkHca/jWllQ=;
        b=B2Jf4WL/XbC/GaqmT1kgoA9BOXdTy736aqwSp0Sakad2iMeKLL6Cx+88N2cpt/LRue
         j9LlTpW75aw10sMKnWIls/5xBZvdaeCTew4oI8+IxbpGFOnJXAOK/liTcqWKQFDB8BZH
         I5rJkMVE8hJmi2TolLWxD+7H1yFIgSaBK8ZfbH2Yf3TWIHYiXKKEU8K8RZefoz1qdsu1
         wfeCsgS/Dv3t5wkTYhuxg9oDtDyuBvD5szzarIrlcmoaKFwbnOCcekk2ReFx3BGR4njx
         CQokl7JafxAqJyN5RWN0dtDRkdTG+VHow4iIwzDjNTLdJQ5bW1+8uLeuCfGHgqm4khiV
         wnxA==
X-Gm-Message-State: AC+VfDzDFyKXIbaFZxCM8pZpwKp9ZeOVlGtN9TXpckSGMuT3ZQIz72Gd
        +pQcmoM6xmLrCPoZGZGy5K/+Lg==
X-Google-Smtp-Source: ACHHUZ6502barLxJjjGolx2MfXNZiGydevaSM6WoNgvypVFXv6IidrIJNGcO1C6BWoa30f8b+crxvQ==
X-Received: by 2002:a25:32c1:0:b0:bc6:263a:2fe with SMTP id y184-20020a2532c1000000b00bc6263a02femr17795952yby.29.1687438437035;
        Thu, 22 Jun 2023 05:53:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z3-20020a5b0203000000b00bca782fcd6esm1478066ybl.55.2023.06.22.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:53:56 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:53:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Message-ID: <ZJREYU0daKlmfjhr@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
 <ZJRBsDq8NI9EInel@nand.local>
 <ZJRDZ7NhyNpTV8jD@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJRDZ7NhyNpTV8jD@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 08:49:43AM -0400, Taylor Blau wrote:
> I am left wondering: why doesn't the rule pertaining to
> refs/heads/foo/baz show up in the included list? Likewise, what happens
> with refs/heads/bar/baz/quux? It is a child of an excluded rule, so the
> question is which list takes priority.
>
> Mostly, I am wondering if I am missing something that would explain why
> you couldn't modify the above example's excluded list to contain
> something like "!refs/heads/bar/baz/quux", eliminating the need for the
> include list entirely.

Another potential quirk that I just now thought of: what are the rules
for what can go in the include list? Fully qualified references only? Or
can we have patterns (e.g. refs/foo/bar/*). Presumably you'd want to
have the namespace-stripping operator ^, but not !, since negating an
include rule seems to imply that it should be in the exclude list.

Thanks,
Taylor
