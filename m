Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66DCC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16A761028
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhFBTnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBTnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 15:43:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D3C061756
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 12:41:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j189so3656165qkf.2
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VXM916lfkO68AGVYAVVKzngsp7xw6VP9qJatS89TJDQ=;
        b=yom/k1cYjeziEpSAxyhHbN/6wHxOkLzYl9GkEyX+B7jrWcu5LhmKc0tkPmZG2fFBkk
         /Zrq0Y6+DL6WXsZb8pLrLUaPdKlE6MNUZ+u4ROLUtjJdov10nx5BpDeq/lLkXkfJketm
         vgU64ahIht8WmizFhoYxcqsFxXbXmCplgfIjYgpQGGwGxMEAmG0OVZ/GCqvKAT1ayk4+
         CwcgdkRp7p8WdvBdP5pHkJxDXxcSO3unb9ae+55RBucCNm6jaeCT8/ixJ3xqdksSqYqs
         E2UVroA8D6m/2cJHRAWMrF5//1l2n7ZRntnkhJ4I8weaFqTrLvlEf+peS879BZ63za2h
         p02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VXM916lfkO68AGVYAVVKzngsp7xw6VP9qJatS89TJDQ=;
        b=QJrUaN/THadZ8IMlXMZ9GUcow4zL/u0tX2ZnNc59WqcWPovZ1tkPk/kvMxGgJVjfg6
         dvKOOSxgrl985uzjvjzw1lVD6qJOW/zXeTta02YfWAUy3PdnG8AUnX7FzFb7qP6F9fak
         pG2u0dVBrj54Wu8uwVA7jZVzD0E9UqU7Z8I5v9Sh05YOOqyO/lYr2ZxKJWHuR0m29c38
         JzoRjBqq5++4ocUX24pkFs1t/tfidAq2lQh4sFn7BcRYfDZtrr4S359IkQ06njYz12dP
         e1/i/ZqqQEuAwb325i/X2uUvWaWNIuvN2X3b25yqTzwKTnab13eISOcz525Ak8jzVMAO
         45ng==
X-Gm-Message-State: AOAM5329P2tIqwafZdASOboRXzzSHEGxbZzAVtwPPxxdgk7rZ5KbpnnX
        AQ2GeldV5aEAxJLZwTQbRGN4xA==
X-Google-Smtp-Source: ABdhPJw4yhYvmaBRL8dLeKlsAsWvJQFOIDcQgG4nDLcddgPSmgNV9L3kogYtiNmvHaXfaavTMHyAOg==
X-Received: by 2002:a05:620a:2a01:: with SMTP id o1mr4499975qkp.137.1622662906284;
        Wed, 02 Jun 2021 12:41:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id f13sm475634qkk.107.2021.06.02.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:41:45 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:41:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: git feature request: git blame --ignore-cleanup/--ignore-trivial
Message-ID: <YLfe+HXl4hkzs44b@nand.local>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
 <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 03:29:44PM +0000, Al Viro wrote:
> > Any maybe the patterns associated to "cleanup" and "trivial" commits
> > should be something that can be configured through a git config
> > file.
>
> Just an observation: quite a few subtle bugs arise from mistakes in
> what should've been a trivial cleanup.  Hell, I've seen bugs coming
> from rebase of provably no-op patches - with commit message unchanged.
> So IME this is counterproductive...

Yes, I find excluding revisions from 'git blame' to be rarely useful,
exactly for this reason.

You could probably use the '--ignore-revs-file' option of 'git blame' to
exclude commits you consider trivial ahead of time. If you had an
'Is-trivial' trailer, I would probably do something like:

  $ git log --format='%H %(trailers:key=Is-trivial)' |
      grep "Is-trivial: true" | cut -d" " -f1 >exclude
  $ git blame --ignore-revs-file exclude ...

Thanks,
Taylor
