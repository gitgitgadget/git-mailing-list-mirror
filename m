Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56036C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 17:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjA0RIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 12:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjA0RID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 12:08:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F38A544
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 09:07:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so5323948pjb.5
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 09:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeYQZNV2BV5sxhqfM/UpqtZKB3PY0oN7FoCCrY7Z5ZQ=;
        b=mZuf2xWcjpqs856Yr6KO8wpgSMBVrhFi9irnLbqOcoHUlStaF0WIchfOQqQEQWvTOm
         2fmoC60WfKyTV1ud3xNE+7J/FGvDcYUYtGSBpG+lh2K7ATUZpih4nc3d0g/xDR8YLVQE
         uhRX6fGh1kP2cARsA15MggIOw7QuFOtOS6hTjTWIXcZQcaxSARZ8ItavNQxOeiMyEPvH
         0Q83qiQys0CIDfpztameFq2sx+kl5QGVX5r+KT1tneSFVIVN1LkKkFGyXD3egRqXmqNL
         E8bEsbNl5LGgZxuBXhSSm3SL5y6NycFWBoMX77wYQ877W8FQE7FpUUrrmhUXZeA0fT9+
         nbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GeYQZNV2BV5sxhqfM/UpqtZKB3PY0oN7FoCCrY7Z5ZQ=;
        b=BaLJBnv1fVMEelNs7PHodaxRYMhUyQSLisTT4aD8f7VwvgpDdhDfO4Mw1DpXcIjizN
         qopuGLwgFnaWPzbDKzRDy8fn5BISyhbmsuDk9yNJNkg9NpPQZ8Exc7nfbrSTMwObsq6V
         4AIdZSnNlHSHLfT89sM/o9qw2WkwBE3eqo62WzOmu+id+dAHpqdcSAtxHJC469Z1s8Qc
         zfoHsLYV8XVroVmv2/amUzbwNMquv9PjkqcTEAcGHRoo1KrTS9fZv8bGdh1wpW0tHA0i
         EIu3rlLUYvRAbZInUKSC2O0VZVT+LgDUPmUCcBDRIcEK+Q7dTfkhRSGNxzaxpjPeKS0E
         g/GQ==
X-Gm-Message-State: AO0yUKU3sf6kPeb1dqK5THVGwTHKifgtouWbmk1NauXJ2spWFWCC2eWG
        xAS6NsyHqkXyR/HLX05mbQk=
X-Google-Smtp-Source: AK7set96P/uIHXkmJLI73U+i4CUstrPn86ulvKc7gRTHdFGLx9UX9jRtw0auhjzH+MmVMumpElkTQA==
X-Received: by 2002:a17:902:da8d:b0:196:3232:f496 with SMTP id j13-20020a170902da8d00b001963232f496mr11054516plx.4.1674839196841;
        Fri, 27 Jan 2023 09:06:36 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902ce0e00b0018c990ce7fesm3085459plg.239.2023.01.27.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:06:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rick van Rein <rick@openfortress.nl>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: Git over HTTP; have flexible SASL authentication
References: <20230127163434.GA784@openfortress.nl>
Date:   Fri, 27 Jan 2023 09:06:36 -0800
In-Reply-To: <20230127163434.GA784@openfortress.nl> (Rick van Rein's message
        of "Fri, 27 Jan 2023 16:34:34 +0000")
Message-ID: <xmqq7cx7aov7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rick van Rein <rick@openfortress.nl> writes:

> Git providers are inventing proprietary extensions to HTTP authentication
> for Git.  It seems smarter to use SASL for this purpose, possibly allowing
> the client a choice and authentication ringback to the client's own domain.

To adopt things like this, the work to extend how to make extensible
what is on WWW-Authenticate in the thread that contains this recent
message https://lore.kernel.org/git/Y9LvFMzriAWUsS58@coredump.intra.peff.net/
may be relevant, perhaps?



    
