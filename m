Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D41C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 07:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB2D2078C
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 07:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=elijahlynn.net header.i=@elijahlynn.net header.b="Ak5OoV1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTHeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTHeJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 03:34:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033BC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 00:34:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id q17so7698333qtp.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elijahlynn.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=eE224xKcx8c75uq38tUR2eYczxY1pNkDTgJIUMVzs/4=;
        b=Ak5OoV1T4qKUPrSqz16Y0pPfmIB0bKfuw4N/fTt9nIV4mQUyvwouUrdUsG9JH9FiyJ
         m4ZdOBqg46grJERzaUwHPFwAoyiEb0/U4P30r3YCkPMSxG9+sU8szlIMU2Wb1t1xKVLl
         DHZ9Czufls6SqkAu5jBTKYBG6i96l+/4kP8fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eE224xKcx8c75uq38tUR2eYczxY1pNkDTgJIUMVzs/4=;
        b=uhkML6I4vVUWYr3JfY/SeQNU40JOnGIl+PIqUnzuJjmq3tYEUHLIcGtvFKjGNo1DhE
         cD2ANEGvJtNugS1vlV6kjx7ZBFHQQKDIuhnfUqGJrDJdZsMyFdf0nH6W35HoCBqQuf4H
         wbJG1TP85zAS2HUMRd4hmI9gtcdK/rcOGUfpeYpX/0Ta+bFvbZlSnqEoEKwrsWq5OQdB
         ktkbu1ElBa6ioWAz3E/uG3bktHRSkccLUmPVZqdWvmS7A60BO9Rj7rv4B41lZq4ls5gV
         H/KtSnElQ/2JtH+o1bpkW2sOVujh1kWKB2PjP2tW362ffv0BIRL9sWhmy9pKZlBZWnUV
         9Z7g==
X-Gm-Message-State: AGi0PuaD5EGcho9mtaRm5rEH4ydCZdvKm0k+4D3AvqVx6iQOgnslGwip
        M+/BbUypdUye+ze/Tvc6LmggMRHZYns=
X-Google-Smtp-Source: APiQypJ8ZD0+RnwotoUg03n3rO8sgXaQVDSD9hV9nsh1/vWfJYy8XdZ1dG5wcpWojNLWRKo95V2org==
X-Received: by 2002:aed:34a5:: with SMTP id x34mr13909425qtd.216.1587368048022;
        Mon, 20 Apr 2020 00:34:08 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id o6sm98250qkd.113.2020.04.20.00.34.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 00:34:07 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id j4so9518137qkc.11
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 00:34:07 -0700 (PDT)
X-Received: by 2002:a37:82c1:: with SMTP id e184mr3747024qkd.186.1587368047511;
 Mon, 20 Apr 2020 00:34:07 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Lynn <elijah@elijahlynn.net>
Date:   Mon, 20 Apr 2020 00:33:51 -0700
X-Gmail-Original-Message-ID: <CAJ9KuXwmk377rEPVrwwpWmwzyO8N20OZUkUTBRoQoo3OuVYbGw@mail.gmail.com>
Message-ID: <CAJ9KuXwmk377rEPVrwwpWmwzyO8N20OZUkUTBRoQoo3OuVYbGw@mail.gmail.com>
Subject: [docs] git stash show also accepts -p|--patch option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Was reading `git help stash`and noticed the --patch option says:

> This option is only valid for `push` and `save` commands.

But this isn't true, the `git stash show` command also accepts the
--patch command and is very useful as it shows the diff of the stash
whereas without --patch it just shows the filenames that changed. I
see this text in master too
https://github.com/git/git/blob/master/Documentation/git-stash.txt.

I can gladly submit a patch if this will be acceptable to update the
docs to state that -p|--patch is applicable to the `show` command as
well.

Elijah Lynn
www.elijahlynn.net
