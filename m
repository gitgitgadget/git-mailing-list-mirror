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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5371F462
	for <e@80x24.org>; Fri, 14 Jun 2019 12:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfFNMO6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 08:14:58 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:44156 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 08:14:58 -0400
Received: by mail-vk1-f170.google.com with SMTP id w186so466190vkd.11
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GdpCewxJYdnlR2bcpz92/7oxMG9DFQdiO6QKRarmd7s=;
        b=hHn4M6LfP6zdCJqiMNYxeOVOpcf/hCJ/Pt8oL6vpVSeSR6MdBBa3bGXVIrci7wlwmn
         zR7EZCSyO+4FlFeJ3GHp1p1V5kjaRwwc215Rp/wHVZ0Xak4DEgWfiPNmLpxn7N5OCRdQ
         44kxRPYFJY4MOJQ+8n23TV5O6or69ECzDjoiItL5/FixOlthmc5Hz+kBj5/3C6pxeS8/
         AZEGjSIAV/bDtcH90vtMjd8BHUxEPpMQzSnn7E3jcLvHlG3b8QAxXjSzztUOZ2CLcJDv
         YYDd2kkaxDVq4oXUXIb56nccu/qIyCMZN+jGuC0tb0/ri0dwiLDSCh3eoo3fVehVJDdZ
         ndDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GdpCewxJYdnlR2bcpz92/7oxMG9DFQdiO6QKRarmd7s=;
        b=qSZ2iLGxtYy8vI46ToTlSXilA6YkQJvCzYZ3PjmUJFuOcM8kxILvzuCeuTuq2scN4b
         VdZjYtikEgOfXqxqtL4PXswYEqhM128B87ZI/A4nAIBgzeOGETSS1P0hLQXuU0XHIZ8r
         pvdkFWDKbo18BZRHO06Fs7iYJiWqDEzRc67fVoUG19WXGZizbKwU1ol5xZI8T9/qXlqi
         H7yaOk7Aev1G2EjqcoSH0VX7wZF8ABdC/Kia6WXQKuJTJYJUbZHqqOyolp3ury+yaBEq
         1bnBHUafvHaKIL51cTSf/xlfiNFxjTFLvT82tuByoErnMNw3kiNNs16tzaS0yt1xAN8M
         7R0g==
X-Gm-Message-State: APjAAAXGX9+vdUB7CyWTAFuQtLsU8ruPhAdnogtlIqWXeKcvxHttdiLn
        QLnH75uHd1Yp1yWaxPPahD4SLJT7wL7NkMrfGDWbJXDO
X-Google-Smtp-Source: APXvYqymONhfFukzn/WFF3msXFzCEMcKsWQ3U2tIDD/fNHw3uTuQxYPErFj7ChsKX8Xc2LWv/lByknS0wu5+re3As7A=
X-Received: by 2002:a1f:16c9:: with SMTP id 192mr22376026vkw.54.1560514497057;
 Fri, 14 Jun 2019 05:14:57 -0700 (PDT)
MIME-Version: 1.0
From:   Mateusz Krawczuk <krawczukmat@gmail.com>
Date:   Fri, 14 Jun 2019 14:14:46 +0200
Message-ID: <CAK1UviVMx1Q+8BYaLJSh-+UjkugaMr8fgS0EqZec4jmuEKJ8xw@mail.gmail.com>
Subject: [RFC] submodule: display progress by default
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git submodule does not display operation progress unless
explicitly demanded by adding the --progress option to the command.
This makes a bad user experience in cases of initializing a huge
submodule, as one might get an impression that something went
wrong and the execution froze (which was exactly my case recently).

The help page states that this is enabled by default if stderr is directed
to the terminal. This is not true. It is still required to explicitly pass this
option to the command.

My proposition is, instead of updating the documentation, is to set the
--progress flag to true by default, and leave the rest as-is for backward
compatibility. If one does not wish to see the progress, it is possible
to silence it with -q or --quiet option.

Notice that such behavior will be identical for commands like clone,
which display progress unless silenced with -q or --quiet.

Also submodule--helper seems to have trouble handling the --progress
option. For example,
`$ git submodule update --init modulename --progress`
prints
`error: unknown option `progress'`,
but running
`$ git submodule update --init --progress modulename`
works fine.

Also progress is not reported for add subcommand even with
--progress option set.

Note: --progress was added to submodule with commit 6d33e1c2821.

Please let me know what you think about it.

Taking advantage of the opportunity, I would like to greet everyone -
it is my first post to git's mailing list.
