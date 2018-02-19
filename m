Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E480A1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 19:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeBSTfs (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 14:35:48 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40634 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbeBSTfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 14:35:47 -0500
Received: by mail-wm0-f47.google.com with SMTP id v10so17089201wmh.5
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W2ON866oSNHwPfJh8Kl1F1j08sXp7xsmo7YMY4DdUuU=;
        b=XCFeurmsmbiLEf3TYdCH4UnhzsIFvqbrGPWu+KjEVl/TXt9M8rgzQCk1YZ0Vze2r7Q
         2dn4OhATIz9U5yLcUocJA3u0ogjDNFFV6APXuO1MvNxN+opZ5J6EEOeLJ3Oy1UQE0Xle
         jnG2aj9MkPGF36EO/6Zdlrgwz+2bnoS7s1rAV6IKH8zvKYsenefbAEWt3yvRCGouN4Pc
         h9eBmUBBszOL6FRAnPSdu9Yx+hfIfgUlYoMmlkZp4yaLuYnHBzsbV2vR+2cW8ODJHSIC
         kEFbuUgqnVUE4PmMnQi1zXH6OWDv3PJJ9rQwYB/TqGIiwI0n6whhtwh/S2T9HB3V0Nlv
         OV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W2ON866oSNHwPfJh8Kl1F1j08sXp7xsmo7YMY4DdUuU=;
        b=q0+3ilEyYei6Ao4Try5KUQfjaH9Hhjh7CygApAjbZpKqzWEsfa4byifgz2nMl4BnNj
         Iop4KqOF4Bt3tzBTWpmNm/epnsxdj+Sd8LfXoQJ52Sxw8vjI+yWcWPdH0x1P/VJ6UerU
         y9YUlLlWzQwUY6aHWKyXjpMGTivyJ5hIeBovxuqXTwNwHFaeid8Z2J9NAvoAc0zjtHrv
         Y/RJHpQ+tc4fHb8U/s7kj8GeMXUtAO0M00DFJJ4oBG8SN0MzTmuo5YtjQS56djFfEv4E
         c6d7vGxKa8/0zVC2LgjlGF9KTDVaI4abOVpphxqG8Ryr6lzVxlOozvSyzTCIHKCPUABW
         C05g==
X-Gm-Message-State: APf1xPBcVgoYtBRkKRP4brh3jr95xvmBkIji6WahouKvYbTVMTZYbAGa
        m7HEoeSiIY0a5KXPwUVDWkcfnZfQ8Td/pb6IjMw=
X-Google-Smtp-Source: AH8x224K6jScd/B7MaFUnZRbQv/9ePW1XUmArZ0g/A84SZDbqI0hhUPBi5Z6mifp5pVY0BPNfB+cScKt20iYGQUiM44=
X-Received: by 10.28.114.6 with SMTP id n6mr2083485wmc.70.1519068945984; Mon,
 19 Feb 2018 11:35:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.200 with HTTP; Mon, 19 Feb 2018 11:35:25 -0800 (PST)
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Mon, 19 Feb 2018 11:35:25 -0800
Message-ID: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
Subject: Is there any way to "interrupt" a rebase?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

When maintaining a long running branch, I regularly rebase onto our
active development branch so that my branch stays up-to-date. What
happens fairly often is that during such a rebase, Git will exit
because of rebase/merge conflicts. Nothing unexpected there, of
course, but as it sometimes turns out, the conflict should have been
fixed in an earlier commit. The only way that I know of to fix this,
is to abort the rebase and start over with "git rebase ...
--interactive" then "edit" every commit and go through them
one-by-one. This is often overkill, though. Is there a better way?
Perhaps I could "rewind" the rebase to an earlier commit and restart
from there?

So a scenario like this:

my-branch : X -> A -> B -> C -> D -> E -> F -> G
base-branch : X -> Y

git rebase --onto base-branch HEAD~7
commit A --> conflicts
... lots of work ...
commit B --> conflicts
... lots of work ...
commit C (Git handles conflicts)
commit D (no conflict)
commit E --> conflicts
... er, that should have been fixed in commit C

How do I keep all the work I did for commits A and B? I get the
impression that rerere does not help here because I did not finish the
rebase succesfully (and that makes perfect sense, of course). Is there
a way at this point in the rebase to "go back" to commit C (so without
"git rebase --abort")?

(Surely, it's not as simple as doing a "git reset --hard
sha-of-commit-C" is it?)

Cheers,
Hilco
