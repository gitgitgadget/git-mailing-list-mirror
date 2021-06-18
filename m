Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A102C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F146161261
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhFRU7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhFRU7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:59:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0EC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:57:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so11053542otl.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2C0rN+YomCGrSX7Zx1ST2Wi5oc2pBrVBDapTmjXafzk=;
        b=RZFeVovy3J0+jjxuusfZxOri4r8eSwTe5+ifeGbiT+m+Qu0aS1kt/lUBOdrN2l5Lnb
         EzhbOsybXAGYUQ5rDN+9Upj5+8lyHAD03fc3lYhIIrLTvgZ1DMXfHUJVCqQYrNRP/KAf
         oHo2Ywqpf63cZxUbkTo1m86UGJNg5RjdjUVgJlXApv76MKRBjjhCl2AZ0zyjuCKwqlEN
         4BgCDz0qtZXdfJ2vhI283ksOFRw3AGCEhPjsC3vGQHthRzd1HCEKkHJkmCpOGBgMZUKD
         qLrAH3IyBmE6UeKykrQu4vbN7UpZ+qlFMI9bYa9MfdfXU0ruAsdvUprUwGoNUCrxp7MS
         ofFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2C0rN+YomCGrSX7Zx1ST2Wi5oc2pBrVBDapTmjXafzk=;
        b=ZapqXyDqa1BiSEwSQl3uN0CZIb7+9xmkrqrRVvjltjhpcXJkQ04p7YjqfkDpOTLZjv
         tquOQFMX4+EKcwpa76XRE+3gjhRc44G5PfVtLK0GrqX4kE7yYuQ3hvijPuWpjRYT2FQi
         fznSm2tCgsl4PA8O0AHPwZqWHE6joNqsjd52olKB+nzJNrcSTNz8GkecR5EY63IBZWF4
         jY9FKtug6dnKYF85bUgccFXjPJTYkhCZXqZDqZiIIK8D+GNC8b32V2dx8Tu3W6WOnEtK
         ou7Y4F9I9KkkhtR0WKHrYc6CQ3ugsSof8bREpgQACLssAsz0QgoLDuaYiKTi9vWxAsEB
         ysFA==
X-Gm-Message-State: AOAM530kaWg4sKoaQ+HGyVCQalaIKNKPuI4pk9A9kyHB1IDrASEYmSHx
        oHAkW0xgDVqFP6p8ddaoxsU=
X-Google-Smtp-Source: ABdhPJxYaPy4wC215qrm5EaZbWf8Kvy8jaQO6kt7u4OWP6NlHr8JZuJ2hjW5VBrK/pmSjAKNSMjuAw==
X-Received: by 2002:a05:6830:22cc:: with SMTP id q12mr10868327otc.202.1624049842758;
        Fri, 18 Jun 2021 13:57:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r74sm1551275oor.2.2021.06.18.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:57:22 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:57:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60cd08a716873_c0ff9208c4@natae.notmuch>
In-Reply-To: <20210618203057.790320-2-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
 <20210618203057.790320-2-felipe.contreras@gmail.com>
Subject: RE: [RFC/NOPATCHv3 1/4] doc: add an option to have Asciidoctor build
 man pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> 
> Asciidoctor contains a converter to generate man pages.  In some
> environments, where building only the manual pages and not the other
> documentation is desired, installing a toolchain for building
> DocBook-based manual pages may be burdensome, and using Asciidoctor
> directly may be easier, so let's add an option to build manual pages
> using Asciidoctor without the DocBook toolchain.

This suffices:

  There's no need to use xmlto to build the man pages when modern
  asciidoctor can do it by itself.

> We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> contain proper handling of the apostrophe, which is controlled normally
> by the GNU_ROFF option.

This isn't true. There's no difference from 1.5, 1.5.3, 2.0.0 or even 2.0.15.

The only fix regarding apostrophes was done by me [1], it's in the
master branch, but not in any release yet.

> This option for the DocBook toolchain, as well
> as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> instead of a Unicode apostrophe in text, so as to make copy and pasting
> commands easier.

That isn't true. GNU_ROFF is only for docbook and doesn't affect
asciidoctor in any way.

> These newer versions of Asciidoctor (1.5.3 and above)
> detect groff and do the right thing in all cases, so the GNU_ROFF option
> is obsolete in this case.

Not true. There's nothing in 1.5.3 or any version that detects groff,
or have anything to do with GNU_ROFF.

> Because Asciidoctor versions before 2.0 had a few problems with man page
> output, let's default this to off for now, since some common distros are
> still on 1.5.

There's nothing from 1.5.8 to 2.0.0 that should be of interest to the
git project.

What are these "few problems"?


The diff is correct, but 1) the original patch was done by me, and 2) I
already have the exact same version here [2].

Cheers.

[1] https://github.com/asciidoctor/asciidoctor/commit/af0ef59538fccfbdec053b82e102a240b15cdda6
[2] https://lore.kernel.org/git/20210521224452.530852-4-felipe.contreras@gmail.com/

-- 
Felipe Contreras
