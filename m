Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD9C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278CB61965
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFYQXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFYQXn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:23:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1921EC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:21:21 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t40so11859704oiw.8
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=N9VnS0R60eJAZsYRt6bPedHQAZIqjZhrIuoHDit5YXw=;
        b=djR1xPUMa1IHSwc+Vtwh/Q4JJb1hixOrmKkER1Oh2OSVI/pCFIanQQK/yFGWrmvRDd
         +LpFDL8uvJZMlq2U93XfJIWfsL1r8kobEzY1qMkUsRGEuT0QoOzKlOmFbgIAw5kdtHnb
         ejrecNHgSydNSWmT9M2fzhZcEWGGrlooo6jwrC25dTsVivZeQ2dV1kRj/bGKbmO69yKh
         M6Q4sIahSMwY0D4St/qtiRNJdO+8kpbH6kyE3A/lBqu0ZrwAlFoi/woiHW9B/8xoWznY
         3OKmVcYdXhAqGNPGs2YenfXxryS6IH625W8JI+NNpOV9aPqHjzN7dHzC3uP0byHxwAEm
         efLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=N9VnS0R60eJAZsYRt6bPedHQAZIqjZhrIuoHDit5YXw=;
        b=EI2IHZmHH4wIlus8f6Cpg0tvferVWJOWXlcpOIGh6GS+Wy7T2IiVVkKOVO66ULfxB8
         SqGdXMArMtxixXVTQmx733ryBH/29aqxoSOWfvU/RXF8e9XaQ0r62S9HYR7fHdXNLAa7
         p6mRJLoFmpejb0cEEEySW+/0I4uK1l7bdzb1hlgAc42omHrzDyzmWFcWuvyH5Kd1Aoev
         AotwzibT5aFtNic0k8qJzVmj9npJcH0Fj5UGqYpYQzQ8XunP3TggwffhQqMYM86esqB/
         70imd69zhRB/ugytjao+F/5D82P6eJ4FToJJAeFHMPfN63B2YK9deVZ6iqPTUFW6Cb8l
         PIIw==
X-Gm-Message-State: AOAM5338VejzA958OoMLyWeJrpBce1AZnTEw6j16rmo3CZi+NTsbroJb
        W3BvwOepZwZ54gnMFA3PbsVxNU7jlGceBQ==
X-Google-Smtp-Source: ABdhPJy0UsVrUMdBkw3Zl/OF0nUTUIqqC4Ip2kgl0yobWhHWk12yLbVv+/VvnsIviR6Md3GzX5KxsQ==
X-Received: by 2002:aca:4813:: with SMTP id v19mr8781499oia.132.1624638080305;
        Fri, 25 Jun 2021 09:21:20 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id t21sm1487611otd.35.2021.06.25.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:21:19 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:21:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d6027e6cf05_c746208af@natae.notmuch>
Subject: [ANN] git-branch-list 0.1 released
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current version of `git branch --list` mostly works, but it's slow and
cumbersome. While this could easily be fixed in git itself, every patch
that tries to improve the user interface is de facto rejected [1].

An external command `git branch-list` is the solution.

Why is `git branch-list` better?

 1. It provides useful information at all verbosity levels
 2. It does not clutter the output with unhelpful characters
 3. It provides a more consistent output
 4. It sorts branches by default
 5. It filters branches more conveniently
 6. It tracks branches in a simpler way
 7. It's way faster

== Verbosity levels ==

At level 0:

 * master origin/master

At level 1:

 * master [origin/master] The first batch post Git 2.32

What about the tracking information? That's orthogonal in
`git branch-list`, and simplified:

 % git branch-list -t
 * master origin/master=

== Performance ==

Using 100 random branches on Linux with random commits over the past
decade:

 % git branch --list --verbose
 21.611 seconds

 % git branch-list
 0.106 seconds

Grab it from my GitHub repository:

https://github.com/felipec/git-branch-list

Cheers.

[1] https://lore.kernel.org/git/YL8KiiGXF8LdGmQ2@coredump.intra.peff.net/

-- 
Felipe Contreras
