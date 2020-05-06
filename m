Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB965C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF4B20746
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="C13AWfZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEFR2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgEFR21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:28:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6FC061A10
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:28:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so1241181pje.5
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ic3dVEbFplDc9ai53BeI4tpwwS7WUc4QcB07zfDEDi4=;
        b=C13AWfZkRKwyZWhL8camyj3TgYW9+Pwoxdk4nY01a7xU6ouHjHye5pEDTYGBJh429d
         e+RyQ6YrOHd22TlCOjCALItg1X8/dGe37HK8WHuOsw5JqhFo+pWjI/KezMuD9ADx+ikI
         rNka83qjUTqMuLxC2FwGlH8d42yG+v+jJFnlDQQM2bssILE7T3foH+quGEA18LCnuDPB
         I3+anIIfBOLSuTpOuoB95fZJgEnH0XP1Hwi+r0uGcjDUOjrtcLgUr4ijjEkjSbAiqnlL
         lR/sCjNdXEDIhbFVYoFYn1VefamX8MbUhFXP7zzfNc55aaRus0aogduayBw0lkTszSOC
         Soqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ic3dVEbFplDc9ai53BeI4tpwwS7WUc4QcB07zfDEDi4=;
        b=nF2qhANo7Y5iF5K7djPiRslywXqgKxVzQOM203lFoMOYTQRBpPpNE9uNVja+tIda1O
         rBD4qJYe8oDn00+gBK1suFb7ErI3mFbsxmyjd1TLHTzxjP3WqamCewes6nqVeNbpnIkZ
         ctzjh6PqomJ3odX6PrZTVkzj8un/5lx6jvFSjITXogHelrLSs6aCuorENbNrIoYScTll
         OY87CcpxbM8p5gJqfFNAXwEgaxRFARLIcn5lOn1RMzTY9jRj/1Fz7aOXm4daSH9g0Qr2
         dfFOrVgvab5Qit4mwxYlWUR4AZkP4MGeTaiR1P0nwpnz7J0coizN1oNWAMGtLbgLZYwj
         qRbA==
X-Gm-Message-State: AGi0Puajkx6qhl78q6/7k3kaBfPyTLdL9eiNbwpP/PNGFmNewvXwQV0G
        2TYhSBj2uo+eNPbhQIt/H1H0MgQjsvg=
X-Google-Smtp-Source: APiQypIQoC2GZaF3idNSDdwzVMtZwIlTc/SCXWwuxgdkMBBpLxvrxV5mB8whg5T6oZc0ES9Jd33lsg==
X-Received: by 2002:a17:902:bd98:: with SMTP id q24mr5790861pls.159.1588786105145;
        Wed, 06 May 2020 10:28:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b7sm2359067pft.147.2020.05.06.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:28:24 -0700 (PDT)
Date:   Wed, 6 May 2020 11:28:23 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Pierrick Gaudry <pierrick.gaudry@loria.fr>
Cc:     git@vger.kernel.org
Subject: Re: option -q not passed from "git commit" to "git gc --auto"
Message-ID: <20200506172823.GB6078@syl.local>
References: <20200506094327.GC31637@rillettes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506094327.GC31637@rillettes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 11:43:27AM +0200, Pierrick Gaudry wrote:
> Hello,
>
> It seems that when "git commit" is run with the "-q" option, there are
> still, from time to time, messages that get printed. With the French
> locale the message is:
>   Compression automatique du dépôt en tâche de fond pour optimiser les performances.
>   Voir "git help gc" pour toute information sur le nettoyage manuel.
>
> From what I could guess, this is due to the fact that "git commit" calls
> "git gc --auto", but does not propagate the "-q" option if present.
>
> A similar problem was present some time ago with "git fetch" and was
> solved in the 2-line patch 6fceed3b . I guess that the same should be
> done for "git commit".

Yes, I think so. A quick search through the list archive turns up [1],
which identifies and provides a patch for this issue. If I were
reviewing that patch today, I'd suggest the following:

  * break the change from a 'char **' to a 'struct argv_array' into a
    separate, preparatory patch.

  * adjust the commit message of the second commit (which will only pass
    '-q' to the 'git-gc' sub-process) to indicate that there may be
    other locations

  * fix those other locations that spawn 'git gc', if they exist, in a
    similar fashion

  * in each of the previous two steps, add tests in the appropriate
    files in 't' to demonstrate that '-q' propagation works as expected.

I'm happy to do any and all of this, if you want, but you are also
welcome to submit the patches yourself.

> Regards,
> Pierrick

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20200506140138.650455-1-abhishekkumar8222@gmail.com/
