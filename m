Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12511C3F2CD
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 16:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83FA222C4
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 16:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0jWooJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCAQd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:33:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45983 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAQd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 11:33:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id h62so8134172edd.12
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=km8t3ApvfBgKpWJkIjRl+FwKPYgO+wR3pin+eZb7Zy4=;
        b=Q0jWooJ72x+RMGZSFo3RUadnRSkm2EqmZgNPAmvN8OC5AiFR3lrnbcmcPyGFWcw4Oz
         Kxdr/gGfpLBYfFbLwqZ98KkISqhWcAm3tyVIlZ7m7IACacRT/C5/9l/FOb1pC0Q9OJpy
         Ol7FyIuxsTcV/buKxXNoNH1vLSoHY1wSjVnWT5qntsXJh8nu+uH8nz/cO9OBL/ICn/x3
         csrsgUl4A2RjOoYSLsHjkNSwl2xbWtM0M4jxiVxXDbWIQOrMZdYNaGdEQ/aPNAOlpTPO
         suGdPAWpN+QEAnkHba0tsYXGC3ACm7fQaf+xyb7S5CJhzTs/oFSU0wln63+WHb8cuNYp
         DG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=km8t3ApvfBgKpWJkIjRl+FwKPYgO+wR3pin+eZb7Zy4=;
        b=DoMLspcxoucr7fa7TxN6U6VciutFFDT65D5Ba/RH3d4lQYldBkJP7rYdh8ZL3fTsJl
         iPwtoU5AW5ehUk5xUNCPC9b/H5WNfjRtCODbskaOS/mvdP2JTcsZb4NU0iMba0LHpste
         G6mxmjF7OObszqac9hFVH9HwAm5p/vnH2tDsvjTRXkwdnXG10fhWPQGIFPQr7EoSn14V
         epNRZfHtvV6Z50ceGY+lrq9lmQHB+qE6uW87pPr09pivuhHE3vH/HVswZGr76BuFXWHo
         VozA5w9wKKsG03/f20GeX4o+vLqMYU1WRdwZEyxce38I0IS+54s0dWuibT6/L6k6Empq
         GzJQ==
X-Gm-Message-State: APjAAAXpZIEo41fTHkdhRXC2Xwz2iGQxGnffFrZM62qK6o7H8YQ5VCOd
        2lZ9l5ktoK2mmlkPGGLzEB3v+YwhM0nKNj/bbYG7WmXfKqo=
X-Google-Smtp-Source: APXvYqyGGz+oDP7/kjfa5FwVVeuEIro8At67KOrbxUnrV3/oL/oYqyKSLr+29a251GPV0RwN6tp790y/uEaDi+aqhFs=
X-Received: by 2002:a17:906:8595:: with SMTP id v21mr11958851ejx.28.1583080405714;
 Sun, 01 Mar 2020 08:33:25 -0800 (PST)
MIME-Version: 1.0
References: <CAGdofc=ToWi4fSqT=avfJDdKvTMFVVc90rTunqZ3vzudTCLr9A@mail.gmail.com>
In-Reply-To: <CAGdofc=ToWi4fSqT=avfJDdKvTMFVVc90rTunqZ3vzudTCLr9A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 1 Mar 2020 17:33:13 +0100
Message-ID: <CAP8UFD1XGSmxTCp55xwtQ=jyD0D4s23QUfB6iM_Sypp_A0b1pA@mail.gmail.com>
Subject: Re: How does the Git community test each version of Git?
To:     rm techup1 <rmtechup1@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Mar 1, 2020 at 4:53 PM rm techup1 <rmtechup1@gmail.com> wrote:

> Can someone point out as to where I can find the Regression testing
> scenarios for Git?

All the tests are in the t/ directory.

> I`m also interested in learning more about how Git is tested before
> every [Major] Release.

There is t/README, t/interop/README and t/perf/README.

> I would be glad if I can at least get a starting point to explore the
> answers to above questions.

You might also be interested in https://github.com/chriscool/sharness/
if you want to use a similar test framework.

Best,
Christian.
