Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19DC2D0E8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44C20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aya4E3b1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgCZIdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:33:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46419 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgCZIdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id g7so4525592qtj.13
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D96jcjhVpaC9m72qQAKK+4RL5O8n4rSe+77qJyfq+XQ=;
        b=aya4E3b1x2MivEKSKUe1kacpO+mIZ1PkAnANT9C26FWzalnFbso5kVIrKkEFaxUv+m
         i9ZHZHVuAJF2a/EbV3GNc+Q58jF5OsNfwDhgSTORHK2dkvJqkK+fYPMMQ6FISzZ8Qmfy
         SReVxKXcIwzcbwPNL/Qeeh7t6KuuqvPZ2L/aDWK54efPOuYXKRF/lfdWjKivAsk2PFid
         nxt/ETklLgLGdKuqTljcOt8rYCXUOwVbXhthAZY0p7oq0Cq00k/zZXyYrV+mpmcY74y9
         DaqtmZBjNJ622W59pavJIVC/lOJ7Is9H8Cwxe5i/9lSBpGsH1jFEkO1eiN7j4XUGAaxX
         UA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D96jcjhVpaC9m72qQAKK+4RL5O8n4rSe+77qJyfq+XQ=;
        b=oktzHiMT4hqHZCcn9ptkWbkAAu1Fu6o2Jyv/UT1iJDSKLzoLsuZ55N9roI76A2SHKC
         kgHpR6r0mAd8r3v+7slxjqtb+iCKSqSDqiCekfzcdKIjc5GBiHqQ1F7OR8CS4PuDMot0
         j6qMwxHZRmlSJiFT/3yyIeV3RgWA2DwPMH0fZoR1s8chl5RKebYJJEllOyyjXxDzaisY
         sxO6K4FqAYjGYT04+GkfZSRM4sKnXBNeCEsw8up6FjkM4oB836uu8RsFcK49lu+PDPVV
         AXyotawy0dSjlIbDGMaRpYJtlHGRsr7RG935BKgGDxwJoNNA3hyxbQcTorEbAGp2Yjhj
         u6uQ==
X-Gm-Message-State: ANhLgQ058c2TUVDPr2EPGQMH4XALQrnvj1C8d1mpIvaBiu5/Si7u3Xdh
        1e3bM137Q9wKet9hKqs3VLKnw9ky
X-Google-Smtp-Source: ADFU+vtvZ+dlydO0/EYnjdiR/6iup4z5QoVf7N6hbBtJWb3I0AECRVLUskbsW8EdriFGJRfEprZa1g==
X-Received: by 2002:ac8:499a:: with SMTP id f26mr6852770qtq.71.1585211628402;
        Thu, 26 Mar 2020 01:33:48 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id c14sm1134028qtv.32.2020.03.26.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:33:47 -0700 (PDT)
Date:   Thu, 26 Mar 2020 04:33:46 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/lib-credential.sh: drop shebang line
Message-ID: <20200326083346.GA1891350@generichostname>
References: <20200326082338.GA3611364@coredump.intra.peff.net>
 <20200326082527.GA3611762@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326082527.GA3611762@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 04:25:27AM -0400, Jeff King wrote:
> The purpose of lib-credential.sh is to be sourced into other test
> scripts. It doesn't need a "#!/bin/sh" line, as running it directly
> makes no sense. Nor does it serve any real filetype documentation
> purpose, as the file is cleary named with a ".sh" extension.

s/cleary/clearly/

Patch and message look obviously good otherwise.
