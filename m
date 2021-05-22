Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C36C4707E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 20:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88F061164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 20:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhEVUv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 16:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhEVUv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 16:51:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E1C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 13:50:01 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10726419otu.10
        for <git@vger.kernel.org>; Sat, 22 May 2021 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=S8Zqxb23DGUeLZe+iFbXR79cwPqxpYgcYIH2x+DQAjs=;
        b=t4H7cxrn6sZStJNO0NtOuvOZCry7ql4StEYgA0eCqPt/B+Rl094NpikGRbxJUAXGOi
         9p6gFIl7VZcugH8n7rfwDcSqB71NPLqHPAJ4bOkpoPILNJlsx6fz7CQh9ti0qklI2QDH
         1RIIKBR+KC9dMT/wC2/BYZNsYW3kXIUVbX1OmekNra7DTQSnQV9EjtxiwJ9unyzI7afk
         BZ9Em1qjm5WTr9EbX5lHYrPj3LGKYJsCPEn95AQssJDmtiD7SBK+KeqB3xjOvm0SEpQs
         jTzHKKbr/Q8hwDOwHTWaLX8fYxoQHB0w9n6/7CwpRgR5L8dak5z6n6bGBaVBus8v6Uuw
         Pj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=S8Zqxb23DGUeLZe+iFbXR79cwPqxpYgcYIH2x+DQAjs=;
        b=R0B34EDEEAjZUabUgpdLyu333/+XB06AY9VtF4z6E/w1wPfoPrr5se+TU6tJywPihm
         0nwhscQz5SKOYzYOZyvDpvCZ4Gm+aWWNk0ioyx7ZLMo7xe8aZHHS2s7b7UlBxPn15UO5
         oGSP4UeB+NsfMgkkyJeLqgpi6hRcIrOXc9EBoW9UNRJlf5oOGoNm0yA5erB5qFGrT8F1
         +3A98ozI2Aq5HD+SkA5uXFGlJp8dU5nVdcfyPInYpxndRlVWQMh36BHZ/kt/G8nrPAIb
         l06JXl2vKH154hJA+z+7qcpZD7ACuIIm+DYIG5TAeTReOpf2o9nnucyhGCmka+0iYB6k
         fc4A==
X-Gm-Message-State: AOAM5329GkcUtWqDKBLXOK97L5RXiLs4V/UjPOyfMUcMP5k2X2Jlphjm
        +QlKLSpYpOCYjMVxN+oItoc=
X-Google-Smtp-Source: ABdhPJyZyoTrcd1NhNQoL6/1UVGruW0ejznLRkQ0OA10cEniFTGyxzjNbdsE/F2FiHM+s43/R3ufaQ==
X-Received: by 2002:a9d:6d88:: with SMTP id x8mr13683303otp.35.1621716600552;
        Sat, 22 May 2021 13:50:00 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i4sm1389713oih.13.2021.05.22.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 13:49:59 -0700 (PDT)
Date:   Sat, 22 May 2021 15:49:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a96e76a4b20_857e92085c@natae.notmuch>
In-Reply-To: <YKjU+/mGzWoqe88V@coredump.intra.peff.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
 <60a7f57fe3301_5503920831@natae.notmuch>
 <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
 <60a828cebd2f1_77e4f208b2@natae.notmuch>
 <YKjU+/mGzWoqe88V@coredump.intra.peff.net>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, May 21, 2021 at 04:40:30PM -0500, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> > > On Fri, May 21, 2021 at 01:01:35PM -0500, Felipe Contreras wrote:
> > > 
> > > > > I still don't understand what we gain by making this a Git feature,
> > > > 
> > > > What do we gain by making `git diff` output color?
> > > 
> > > Huh? Git is outputting the diff. Who else would output the color?
> > 
> > Do you think our users know or care which binary has the final
> > connection to the tty?
> 
> Yes. If we are telling them that "git help git" is using "man", which we
> do, then I think they should expect it to behave like "man".

But we are not telling them.

Software is not in the business of explaining users exactly what it is
doing. Software is in the business of being useful to users, and in
order to do that it must remain as silent as possible while achieving
what the user potentially wants.

Unless we throw an advice("this command runs man"), then we are not
telling them.

If a dilligent user does `git help help` they might learn about this
fact, but we didn't tell them, they found out.

> Moreover, I think that if they like colorized manpages, they'd probably
> want them when running "man" themselves.

This doesn't matter.

The user might have "configured" man like this:

  man() {
      LESS_TERMCAP_md=$'\e[01;31m' \
      LESS_TERMCAP_me=$'\e[0m' \
      LESS_TERMCAP_so=$'\e[01;44;33m' \
      LESS_TERMCAP_se=$'\e[0m' \
      LESS_TERMCAP_us=$'\e[01;32m' \
      LESS_TERMCAP_ue=$'\e[0m' \
      command man "$@"
  }

Git isn't going utilize that.

Arch Linux recommends the above, and so does many online resources.

So even if it's the case what you said, that they want colorized man
pages, *and* they have man configured, that doesn't matter.

In addition, not everyone is a Linux guru. Some might want colorized man
pages, but not know how to get them.

I myself only learned it was possible to configure that about a year ago
when reading Arch Linux's installation guide. Luckily I clicked "Color
output in console", even though I thought I already had most console
software configured.

I have 20 years of experience using Linux. Some people have less.

You presume too much of our users.

And you still haven't explained how they can properly configure
colorized man pages for both man and git, in a way that works in all
distributions.

[1] https://wiki.archlinux.org/title/Color_output_in_console

-- 
Felipe Contreras
