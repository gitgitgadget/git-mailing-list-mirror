Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9ABC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B104520781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJL08VVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgKJVzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJVzO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:55:14 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B4C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:55:14 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v143so8578202qkb.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c+7xg4fqYQPPbst5OoTvUJVernufegqrHBcJ61FCL/I=;
        b=sJL08VVoMRcS5AEOJWfG//LuUTt4HAYB0EGaQrj0TgXCHqro1jVcFFBqdAKTxWQn6F
         lmQqQeb8zvYB/X/TdQrR3NmdKzf61FVdeIRcczGjA67tZun371OZzrFUZZs4gUgYNU+J
         soV76YjTwf1Jz/dsntyGixCaMgTEQxrSOdR+MuhnFjVjiYxICkXfASrSTUgjwXYOJ0hq
         Aux4S7w1Z/eC5DgY2pJ3w3rhLI9qxsgZiDJV3SxqePFz8mpP0iWc5bIKlt+UkAjyPvut
         zhKZjEUgTlOqUy5OHSJ4knDbkM9X2M3DU4ErQFE39PNqMLCudBhHUeNOehiQ9+3TqGZ2
         1TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c+7xg4fqYQPPbst5OoTvUJVernufegqrHBcJ61FCL/I=;
        b=pK8Pei7qs9SX+mg3+IxU17+YEFWJVr7E3qpKjj/F7qHKOvXnJDQDs/5yO4CG97XUxR
         xIQ/3oDnVw3eYB6PtqMWGU5cy9Vk6/H49cMr4dMTj2iBoQjgX6Eg7ZJyf6Z8y7+mEUQd
         1XYrOiwF5O1Ro5Cvkt2s5KXQ3MwtnzuxK6Sji3liKXwjJQB52IRRRrcOZ0tsWvWVcGdz
         gogGcHq4pNyIYcvJX8SoUdnHCEaut9UXQtYdN8xGbfiy1g3m46tY8YZhqxV2g8hW9HAE
         NQWmQzvXAZTJPvmAPSzQdibDRf7VSy1Md79PuelA7f/NhuZvIPR6Wv3fWkYh3bmifGeC
         QWbg==
X-Gm-Message-State: AOAM533KseQBZlfitoO6RSv8bmEcgWqHRVcvvfoUV6tMoJyLD2xBFpyH
        H3VcQ6Ake/DhXszcD9p9dLGBLQvs/WDKKDv51HZxWp6H6t8WiQ==
X-Google-Smtp-Source: ABdhPJzkuM48ORId9Q2gk6zbrG2cRM36V3g/VcdY4aJnTWWKgvNTjvQUsvRnHB2qP7dLHEodrHZVsLLXI6cyu6TIz4I=
X-Received: by 2002:a37:a3d2:: with SMTP id m201mr12587587qke.203.1605045312982;
 Tue, 10 Nov 2020 13:55:12 -0800 (PST)
MIME-Version: 1.0
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Tue, 10 Nov 2020 17:54:47 -0400
Message-ID: <CAETBDP6d8UwiJEF_pX0p=xLG79pwHeEtectmOnjPiUpjUCPaqw@mail.gmail.com>
Subject: format-patch: "magic" mbox timestamp
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

After submitting a patch internally within our organization today, I
was looking through the `format-patch` output and was curious to see
the strange timestamp on the "From" line. At first glance I thought
the parent commit timestamp might have been off, but that wasn't the
case. I thought it might be a bug but quickly noticed the fixed
timestamp string in `log-tree`.

Reading through the various revisions of `log-tree.c` didn't answer
many questions either, until I turned to the docs and read:

> The patch produced by git format-patch is in UNIX mailbox format, with a fixed "magic" time stamp to indicate that the file is output from format-patch rather than a real mailbox [...]

I find this pretty interesting, and would like to hear more from those
that introduced change. It looks like this was first introduced in
3eefc18917 (Tentative built-in format-patch., 2006-04-18), albeit with
a different "magic" timestamp, and then changed to its current
timestamp value in 698ce6f87e (fmt-patch: Support --attach,
2006-05-20).

Please correct me if I'm wrong, but I'm assuming the "UNIX mailbox
format" referenced in the docs refers to the mbox database format
described in appendix A of RFC-4155. If so, since we use a commit id
in place of the sender email address, would that itself be sufficient
to indicate that the output isn't from a real mailbox? A commit id
will never match the addr-spec in RFC-2822, so I figure that anyone
looking at `format-patch` output could safely assume that it did not
originate from a mailbox.

I could see this as a good opportunity to use a more relevant
timestamp, perhaps the commit timestamp of the first patch in the
series.
