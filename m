Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00181F403
	for <e@80x24.org>; Thu,  7 Jun 2018 12:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeFGMHx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 08:07:53 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40556 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeFGMHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 08:07:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id q6-v6so9523998qtn.7
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eV0X5C6S4Ddxc8Q+V4bdf7y+6MNHvJmzNFIvbcy++c=;
        b=R5/plBmSw1poWJWO59GrvGSAz4v1i7f+HccITBphIwSZk85WSOonT+1TePwuABYcgT
         qtnZ0mFqwmPAPxw7Ydf+lzJBcaQ5sAVGi23UZtGQXR6sS76TWZTtIbv/HrIbmOuFgFSb
         DM3uSWw79XpcI78z992aqXE1uFrDegGYOIFoXqpObZzytgN0LULDCfPZ1snjxZZnbZMI
         J7NZezjj1F29edP8si79H47Nb7Omfd4rUihqxk6YPN3hU0tGrTlNXGctL6SiGvOpMn6I
         yktJBKgnMSJIj3GNq3LxPwU8V6jKNHsG800Ne3nVzE3y9+Z7IPXCcct9mnfYHr2+7NGN
         LfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eV0X5C6S4Ddxc8Q+V4bdf7y+6MNHvJmzNFIvbcy++c=;
        b=q7Ay7Yf6p//Btd/ZftIfTIWrax00xk6Off8QTeUxQDAKQWSU8bmiUEukekZuD4osw3
         4I8nioSgY14uo5GmsQCKERulXCMP90Hut263AaOlSpDTB4g0DbUwkbzkT5F4Is9KpOU5
         1KKJga4wrcAZlZJdy261/ytHhLl6YcQoZuOO2A0FJbSysygTz0ObdjiQGWI8+yhkUUm6
         DsTCanVjyXomRCuR28Hv1spjtTQTB1CBmAzyno6bQ5bmpd2vUYQX2kv1Lq/HjSXezy4k
         C1cnqLOYRU2SJzcO76g5wjJxmY5NVjD+2kSo/V4A17VNeg5gXqWLpTB1xOrmjjLfddOT
         4hxw==
X-Gm-Message-State: APt69E0+9JN8oY5UbjdnquKov5uEg6eWMPkUlXnPurr0pIRvqd4n4tse
        E5aiELWDjUpi2Dnuf2hz/KCgsgB3bHNFiK3mA/M/eg==
X-Google-Smtp-Source: ADUXVKLx9jOBeRbbpduDi562YB7Pn25nLSDxxaGCGdrjImyiVoz8sWXOzTQu0SNqbXetR2p9fH+VX+6KfHKSN7hCDNk=
X-Received: by 2002:ac8:2351:: with SMTP id b17-v6mr682652qtb.304.1528373271222;
 Thu, 07 Jun 2018 05:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com>
In-Reply-To: <20180607054834.GB6567@aiede.svl.corp.google.com>
From:   Dave Borowitz <dborowitz@google.com>
Date:   Thu, 7 Jun 2018 08:07:40 -0400
Message-ID: <CAD0k6qS_VoX-Pzfh5MDgcUzAyARy13WHKvNqLShzafWL9JMkgw@mail.gmail.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     szeder.dev@gmail.com, Junio C Hamano <gitster@pobox.com>,
        matt@1eanda.com, theonestep4@gmail.com, pclouds@gmail.com,
        jnareb@gmail.com, git <git@vger.kernel.org>, wolph@wol.ph
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 1:48 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Whatever
> I try, I end up with one of two results: either it uses zsh's standard
> completion, or it spews a stream of errors about missing functions
> like compgen.  What am I doing wrong?

Try adding to the top of your .zshrc:
autoload -U compinit; compinit
autoload -U bashcompinit; bashcompinit

Those are both in my .zshrc, and I think they are sufficient magic to
define compgen.
