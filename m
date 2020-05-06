Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C071FC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974D5206B8
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ckNIB6IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgEFRd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:33:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F216C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:33:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so1216956pjb.5
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u3f5dBVRoqhDARAEAtG6K+VgZ88Ko/kxCgzsTA8iP6Q=;
        b=ckNIB6ISPii2l8lQlTayHoHmHITzQbfjDZZ7FOsNyf4/g2bb2EQF9J27T19F8s5RJq
         1YytijPMn+o1rqGBmUjxXqhs+UdW/zViMQ/Vl631xpXokXBpZOG/xcpWfN1jpXE/ovnW
         xlm/Nbw2hkS3psB6e/mj5kW532mI5+mvFKERv7SC/nxW8QvjpSasfhHpu54DNYKHM34N
         VBnJ/2MhraXaFpwBiQ5nqOSQyC6jbXk5Xb7ge3IuPOhtBHlTLS1OyfmPlEwSfxb4gtpE
         1BibFgjBHIv9A4uTLJdc2LnNKFal9zVtYkIbhspHWWiju98Y6vgjXRlOXZOPlnO6Neja
         1irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u3f5dBVRoqhDARAEAtG6K+VgZ88Ko/kxCgzsTA8iP6Q=;
        b=sWsgvuMscvi9lRJZHOBB/LmQAtUuksLJD7acr9xlGfxsoqnKsY3zoWhA3ONPTWtaNI
         Ic6c+CvgkXMKyMddxi+chxxUQRbjjlRWaih8ldQXMPhdc1sfXVGxz+2Lbklw+BBVtr/A
         whbKL3hTalJJS0TiinI+attw5sajeCfVrNRWlvDVIn1356pd17gw2hUz2hdqtaFE9/0+
         KxiqrTxVgKsE/ZOW8uaFQGN5yy0FiEOQPffgcDVadM9FiMyVhNJmTX3impzFwXmHpF3p
         5EIU3LEXdP5e92s3E11S/OCZ/D2cyBQCgqFy5c4slpNL7zxFR3NaKTczUeIOY2t+FZBV
         WfNQ==
X-Gm-Message-State: AGi0PuZJsU00xgi7GL42MG1FqKzZ9EYl96whz3+D/hj/5q+nCOHiwmEv
        7wOlJvPFcUSXiyGC3P+H+9n/CA==
X-Google-Smtp-Source: APiQypK70sb5Ca/pHF7/lLTV7NgD2lVnHs+hWcemnCXwguYyaLqzqW75/CtRwNvddlUchr6rUKzXMw==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr8713274plb.227.1588786437983;
        Wed, 06 May 2020 10:33:57 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w75sm2356018pfc.156.2020.05.06.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:33:57 -0700 (PDT)
Date:   Wed, 6 May 2020 11:33:56 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Pierrick Gaudry <pierrick.gaudry@loria.fr>, git@vger.kernel.org
Subject: Re: option -q not passed from "git commit" to "git gc --auto"
Message-ID: <20200506173356.GC6078@syl.local>
References: <20200506094327.GC31637@rillettes>
 <20200506172823.GB6078@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506172823.GB6078@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 11:28:23AM -0600, Taylor Blau wrote:
> On Wed, May 06, 2020 at 11:43:27AM +0200, Pierrick Gaudry wrote:
> > Hello,
> >
> > It seems that when "git commit" is run with the "-q" option, there are
> > still, from time to time, messages that get printed. With the French
> > locale the message is:
> >   Compression automatique du dépôt en tâche de fond pour optimiser les performances.
> >   Voir "git help gc" pour toute information sur le nettoyage manuel.
> >
> > From what I could guess, this is due to the fact that "git commit" calls
> > "git gc --auto", but does not propagate the "-q" option if present.
> >
> > A similar problem was present some time ago with "git fetch" and was
> > solved in the 2-line patch 6fceed3b . I guess that the same should be
> > done for "git commit".
>
> Yes, I think so. A quick search through the list archive turns up [1],
> which identifies and provides a patch for this issue. If I were
> reviewing that patch today, I'd suggest the following:
>
>   * break the change from a 'char **' to a 'struct argv_array' into a
>     separate, preparatory patch.
>
>   * adjust the commit message of the second commit (which will only pass
>     '-q' to the 'git-gc' sub-process) to indicate that there may be
>     other locations
>
>   * fix those other locations that spawn 'git gc', if they exist, in a
>     similar fashion
>
>   * in each of the previous two steps, add tests in the appropriate
>     files in 't' to demonstrate that '-q' propagation works as expected.

Junio identified a much better way to do this in the email below this
one. Since it appears that there are multiple places that ignore
'--quiet' when running 'git gc' as a sub-process, a helper function is
certainly you want to be using.

> I'm happy to do any and all of this, if you want, but you are also
> welcome to submit the patches yourself.
>
> > Regards,
> > Pierrick
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/20200506140138.650455-1-abhishekkumar8222@gmail.com/
Thanks,
Taylor
