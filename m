Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223452082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdFXLti (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:49:38 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34558 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdFXLth (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 07:49:37 -0400
Received: by mail-oi0-f52.google.com with SMTP id b6so36929489oia.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DCaMTmsd3N4KCpgCDf79Ha4rRbJWkd5z9wN00yVjchg=;
        b=AlhADzfDx9dgMuyHCSM1z8s9ugctbg7x1EGkMNLNdgFKQTnR9485J/o2ZUKWaQk4RE
         UxqNVnfVDvuRSjOS4f8tdkcf8FYqBus9VeLBCw0vVh7ifWAy8+SrzPWwAur7BLD7qH+j
         B6QWiN317PYuzPrSYo+u8vfNfW6Y5vgZy6QyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DCaMTmsd3N4KCpgCDf79Ha4rRbJWkd5z9wN00yVjchg=;
        b=Wrf6XSndXHMhkumcumMmHlfLGQTFecWTuRzFREr5Hj8L8jdCgtYoolNcanTpH69vui
         prjJJdncZq7/EW+fNf9Bx2VUuXQ4fP1CrZ3Sw6hg+Y6Y5Fdu1m5C8g+7Y0sC3UCFbcUR
         kuW/q7ROyTs5OzqWPkiG53T3+Ari3cbnfKT7zBZ/ExL0Jj6aD+OeemPeWE7CN6yfEKKj
         /K6Sm2ImjwVKHXMcGJEULztBeFQTbp+6s85ygz97EEOe9wtaQdZlZ4Irg8ndndiJcgoL
         Ma1JEh4ne+sIFLk4gzQct+rd0RIdMFeAlOQrILf38XM0LZ7GdJRzO4uRNobmKwZVfVBR
         BzCg==
X-Gm-Message-State: AKS2vOzq2KzXuBdZnEqvOV/4Ft4VKRK6NuUtzmXPG2Xz465qFgWcV+9n
        cepjd+bRSlY9z+WZLPkfkfE+63mViDZU
X-Received: by 10.202.104.147 with SMTP id o19mr6057868oik.114.1498304976940;
 Sat, 24 Jun 2017 04:49:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.134 with HTTP; Sat, 24 Jun 2017 04:49:36 -0700 (PDT)
In-Reply-To: <xmqq4lv8kjxo.fsf@gitster.mtv.corp.google.com>
References: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com> <xmqq4lv8kjxo.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 24 Jun 2017 12:49:36 +0100
Message-ID: <CAE5ih78YFSjcn6RNGzdxsjvn6B7xvHMgKKRqirjW00=9hWpDYA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: changelist template with p4 -G change -o
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Miguel Torroja <miguel.torroja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 June 2017 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
> Miguel Torroja <miguel.torroja@gmail.com> writes:
>
>> The option -G of p4 (python marshal output) gives more context about the
>> data being output. That's useful when using the command "change -o" as
>> we can distinguish between warning/error line and real change description.
>>
>> Some p4 plugin/hooks in the server side generates some warnings when
>> executed. Unfortunately those messages are mixed with the output of
>> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
>> in python marshal output (-G). The real change output is reported as
>> {'code':'stat'}

I think this seems like a reasonable thing to do if "p4 change -o" is
jumbling up output.

One thing I notice trying it out by hand is that we seem to have lost
the annotation of the Perforce per-file modification type (is there a
proper name for this?).

For example, if I add a file called "baz", then the original version
creates a template which looks like this:

   //depot/baz    # add

But the new one creates a template which looks like:

   //depot/baz

Luke
