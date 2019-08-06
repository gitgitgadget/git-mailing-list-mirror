Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FE11F731
	for <e@80x24.org>; Tue,  6 Aug 2019 14:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfHFOEL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 10:04:11 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41708 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfHFOEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 10:04:10 -0400
Received: by mail-ot1-f44.google.com with SMTP id o101so92719481ota.8
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dr013+6MSqujYdnikdIF1CuhuBp4YxNg6IGs7tC9Rp0=;
        b=XOA5vc5oRXXAr6nOyeaL357bB2GcNdzqp6EsKHWXtpnLybh5RJYACBkrql2pUqWlmp
         iZBv93LML6c/7qNMOJuNLF8RMRwW6xgYWq2NGV6VKUaiNl543XHQXd41eoNGziwXufx6
         tb6QnygK/DPpLr1Ms3a58h1l7iwqCidbzzbqGgPeUzlqUq1Rnml/wgyu8uq9BfadEP9p
         Cb1H6smmlW7fFZfS5/BRh+PHpwoksnGn8HJIwNQzjogQXaKtHPVl5gNqLACd/QdYGSSq
         hhuHGe9MKWp7FPPC090cJbXrTKXOjZNtxZvFH5kfYhy40wa1RndNpSATHJeyWqioSjoj
         Qizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dr013+6MSqujYdnikdIF1CuhuBp4YxNg6IGs7tC9Rp0=;
        b=jCWunugKqH+81FSCIx2ZGfhCygutlQjK/0Io2OKS9GWYPw2komFfK3MLuCs/V/p4Wy
         H/7TXzlj9EgC5O22X86cgoVy+Y4eOiFAuJkv/Fur+DnNS4SF0JxYd2ZL6eXVu2h9GDIk
         6CEiqiO39KygF7/ObT+yp5s7jkpRkM5jPL5AoLlV2XpooubOBTHdJARv8Pq7pwbOg90X
         Ar0ygcSGz5NrOdYvYVD4UsSBsMRINQuN71RMGqc1DpSdeyEbavWXbqoSkXIfBOwJw7y3
         vUYcoAhLrcTHLARGtxyxOAu9qSCahm7Z64kZrtE4IVIllBQV+AGjduzjKBW8xeh0FYWz
         vNAw==
X-Gm-Message-State: APjAAAWNdS4wfO9J4TvayQknpLp6VTWmuqflVqqttuRYYcu/0BbQeIY2
        Qz7hxBxtBHxIkT3AYJ5kU7kKw9Vdo0prGjOIuGHFeQ==
X-Google-Smtp-Source: APXvYqxVmYtXIl2m3Cmj+XYxy59R2r9LaGixRgFRDQ92arCvuaVLtaKGxgjNjyomBmFxIufIqN2T8V22UNafHFk+I3o=
X-Received: by 2002:a6b:5103:: with SMTP id f3mr3741861iob.142.1565100249691;
 Tue, 06 Aug 2019 07:04:09 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Sewall <jasonsewall@gmail.com>
Date:   Tue, 6 Aug 2019 10:03:57 -0400
Message-ID: <CADqa0D5wVWk2wa-raeVmCEhCqYznpba4TeUW_7UQOA0huR-RAg@mail.gmail.com>
Subject: Suggestion: git clone should warn if repository has submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules are great, and I used them at work. The problem is, people
wind up cloning my repos without --recursive and then nothing works
for them, because  the submodules weren't populated and those
ultimately are needed to build my code.

I can see why --recursive isn't the default for git clone; you don't
want to just blindly follow whatever urls are in .gitmodules without
the user being aware of the possibility. That said, folks that are not
familiar with submodules (which seems to be most of the people I work
with!) wind up confused by this and don't know how to fix it.

While the burden is on the user and should remain so, it seems like
having git print out a message after cloning to the effect of "there
are submodules that are not populated, maybe you should look at them"
would go a long way to eliminating confusion for newer users. Yes, I
have put some documentation in my project that users should fetch the
submodules, but if possible, I'd like lower the number of times I have
to suggest that people RTFM.

Alternatively, is it preferable that I have my build system look at
the submodules and inform the user more helpfully? I'm curious to know
what, if any, is the recommended procedure.

Cheers,
Jason
