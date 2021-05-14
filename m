Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE76C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDA36144A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhENTy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhENTy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 15:54:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F758C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:53:16 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso272702otn.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=c9JbTFalVgVYgUYFn4HFoCl6ZwWuPWxD3c8DfS0tcSI=;
        b=ppQEB39ZD1HGDUjdVGyp5MFgXrPPk4WMN9tq/9mKIXhM02TtM0SEEg2585QWsRayRj
         LxTPAOqmMqvs8octIZAAEnIunOkN15poxRqBjBtAl85Pbj2zZ6hiVueNg/FfeStiMeE3
         fcd7x4yc/z2cvqfBPD/4yNjJUhA3+SOEOP02tmPuok6QLce9a2s7qM1brAnTkEABoHMq
         IPm3nsF6IB3UrOyY78W/SK2uHB5iVSI0ZlDMuXd5HXfC1lki0JY9FxHqnBm0HkAhz55M
         qaTh+ffwYmr95USB7xniYxxBXHEGaoJnL7pRRN6ArJlezXpcV1/HTUgqpvkkY07oUTy6
         hZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=c9JbTFalVgVYgUYFn4HFoCl6ZwWuPWxD3c8DfS0tcSI=;
        b=OMVDcq0GiWBkc+iQgcfbn4rKa8ZltyY9L9bOLSEU4wybO6+xSzFQdTBhYFWj3FQtA8
         v7SoPebti5NMuVypeVIYkr+VFOuwO/3eTku8wvJJ0M5OL/abIbCx6ucmXgZADWDEQ13a
         xbjq8XEFs62TVXj0UBf3W2154tLDaJsKPC4Z/QlmIN1Ww0KWxPTT72fTsy//KFVEHrhu
         PwmiVzIqK2n7WBikqGya0u7RDNLNLct7g37HEw4CNZYk6pXQUvUpUoe2ArE8bKKxmKI/
         5tL5ZTXvW/GIfBVpQVSz+5nN4mutEp6quKU+xbKbceb/3LLnU9syIQRjRRkZX8MpNE0Q
         ErUA==
X-Gm-Message-State: AOAM531uAEcN4VQAVuyMtz1GZ/qE9fkLE5iJu5gwFCM5EpCHa1zgaSv3
        ZbolIZoyMW5D7KZGGwcH1Chqe7r2I0pI7Q==
X-Google-Smtp-Source: ABdhPJzsXiJYVYR3C9c0KuSAYMKNfhU0cjgs/sKvz9OyqPDPrUv/c+JbMO288FIoEjTylwG/WTNIgg==
X-Received: by 2002:a9d:2de3:: with SMTP id g90mr40842783otb.274.1621021995532;
        Fri, 14 May 2021 12:53:15 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f21sm1465777oou.24.2021.05.14.12.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:53:15 -0700 (PDT)
Date:   Fri, 14 May 2021 14:53:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609ed529e2306_431272087@natae.notmuch>
In-Reply-To: <20210514003104.94644-2-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
Subject: RE: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> Asciidoctor contains a converter to generate man pages.  In some
> environments, where building only the manual pages and not the other
> documentation is desired, installing a toolchain for building
> DocBook-based manual pages may be burdensome, and using Asciidoctor
> directly may be easier, so let's add an option to build manual pages
> using Asciidoctor without the DocBook toolchain.
> 
> We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> contain proper handling of the apostrophe, which is controlled normally
> by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> instead of a Unicode apostrophe in text, so as to make copy and pasting
> commands easier.  These newer versions of Asciidoctor (1.5.3 and above)
> detect groff and do the right thing in all cases, so the GNU_ROFF option
> is obsolete in this case.

I don't see what that paragraph has to do with the patch below.

> We also need to update the code that tells Asciidoctor how to format our
> linkgit macros so that it can output proper code for man pages.

Yes, but why shove it in this patch? Now this is is doing *two*
logically-independent changes.

> Be careful to reset the font to the previous after the change.

This is a third change, since the current man pages already don't do
this:

  % zcat /usr/share/man/man1/git-add.1.gz | grep '\fB'
  you must use the \fBadd\fR command

> We insert \e before each font-change backslash so Asciidoctor doesn't
> convert them into \*(rs, the reverse solidus character, and instead
> leaves them as we wanted them.

Right. So my patch was correct: it is neecessary.

> Additionally, we don't want to use XML-style escapes for the litdd and
> plus macros, so let's only use the XML-style escapes in HTML and XML and
> use something different for our man pages.

That's a fourth change now, and one that complicates the Makefile even
more, when I've been trying to simplify it.

> Because Asciidoctor versions before 2.0 had a few problems with man page
> output, let's default this to off for now, since some common distros are
> still on 1.5.

Can you point what problems are those? I did a doc-diff with my patches
on asciidoctor 1.5.8 and I did not see any major problems.

> If users are using a more modern toolchain or don't care
> about the rendering issues, they can enable the option.

What rendering issues?

Also, the many should not suffer because of the few.

If a few people doing USE_ASCIIDOCTOR=YesPlease have issues (because of
ancient packages in their distribution, and their reluctance to type
`gem install`), then *they* can disable USE_ASCIIDOCTOR_MANPAGE (or just
disable USE_ASCIIDOCTOR altogether). Most people doing
USE_ASCIIDOCTOR=YesPlease should not suffer because of a
minority.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I most definitely do not sign off this.

-- 
Felipe Contreras
