Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30571F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeETVMK (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38229 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeETVMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id 94-v6so14080516wrf.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H4Rw8W7M3roGOp2HBOor3s5Zf6QQleciDUG5qIJnv0o=;
        b=Wj+LQwqY1n57pv0n2hAavGmZIaeXA9gi+EdLRxQlpRdp29kB9UdlsYPLRrwIHGVatU
         inmdt8eevLfjeOYG5e32SPY/o/kzk8wvp/OCwJPZzIwDNwTnK0Bn2V6TUmRWUGewFg3W
         mWdCIWEZSh4eZ63A6gIqE2a8nWvxMfHoJvbrUpfjncfDJZ2AbHqBhif6SVNxkAdSUJvG
         GgsRXGW25BwcpMo46+UqH1lrQ6TJwZ/lN60IsakwXy1PCjcuKT70HqsrM7bs9j57o5yt
         Xa/C76j1YreDv7gveBVnK1cIn/0y0CD8SwfB8s1yW9tRWCVAG+ASbwuuxXiCArd6gOTY
         VaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H4Rw8W7M3roGOp2HBOor3s5Zf6QQleciDUG5qIJnv0o=;
        b=VUJYkYyVpi8udTkMg6hNvyCTUhL1jYxG0Dke+BXpO6JDtYA4hDtZYN3Wae+q6ObHk3
         FPoHRf8hq2mifeKtMc3xJqBLg4K3CT9DsJmJ3Hc2CbYz0TUiLGjclfGL7QT1GWRhqFCS
         p4vY0+KA7gTrZw84FoXY5xKi8wj4OSCBlR9XHX6rwfwku9xr4LsNnsyI65AmIS7OGOLA
         kc+c2NG2tRdPHQpdHH++7HugDGQXieJNYOmjRwDe8HGgIL/v/CSaxUrGze5AKHqHn9WN
         UCGp6vtyHqX5ocD9KshmJSIbTa3wmin5sS0twenqzdnOxQBrPzBjck6OhKNZFI9Jl2p7
         SWTg==
X-Gm-Message-State: ALKqPwcuK62VouAGn3LQkYKUFHihyjnmB1R94/LOwG7rhWI7H1R1MIx1
        crlid3J/qBbB4zkC2UAVPQ8OZZ+l
X-Google-Smtp-Source: AB8JxZofNcULOriUuu+E585JkBaTg0G7qCuMtpuOI3V2rnNAxVM8oAvNUyeTRzGl6z4WwAin7CnDEA==
X-Received: by 2002:adf:9b1a:: with SMTP id b26-v6mr14063269wrc.206.1526850727710;
        Sun, 20 May 2018 14:12:07 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f8-v6sm6852655wrf.67.2018.05.20.14.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 0/7] rerere: handle nested conflicts
Date:   Sun, 20 May 2018 22:12:03 +0100
Message-Id: <20180520211210.1248-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started this whole patch series when I did a git rebase, and was too
lazy to resolve a conflict and just added the file with the conflict
markers and continued.  Once I got nested conflicts in the file, I
decided to abort the rebase with 'git rebase --abort' and got a
segfault in 'git rerere clear'.

Even if we can't handle the conflict, we shouldn't end with crashing
'git rerere clear'.  While trying to understand how 'git rerere' works
internally I noticed some other improvements that could be made, such
as marking the strings for translation and adding some docs on how
rerere works, since I had to find out from the code, and reading some
documentation would definitely have been helpful.

The next patches are more related to the actual problem I encountered,
first fixing the the possible crashing of 'git rerere clear' when we
can't handle conflicts in a file, and then actually trying to handle
nested conflicts.

I don't know if it's actually worth trying to handle nested conflicts,
as they are more than likely a very rare use-case, but on the other
hand resolving such conflicts is especially painful, so only having to
do it once would be much nicer.

This whole patch series is marked as RFC/PATCH, as this is my first
time touching the rerere code, so I may well misunderstand some bits
of the code.

Thomas Gummerer (7):
  rerere: unify error message when read_cache fails
  rerere: mark strings for translation
  rerere: add some documentation
  rerere: fix crash when conflict goes unresolved
  rerere: only return whether a path has conflicts or not
  rerere: factor out handle_conflict function
  rerere: teach rerere to handle nested conflicts

 Documentation/technical/rerere.txt |  43 +++++
 rerere.c                           | 244 ++++++++++++++---------------
 t/t4200-rerere.sh                  |  25 +++
 3 files changed, 186 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

-- 
2.17.0.588.g4d217cdf8e.dirty

