Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA6AC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A068D22CA1
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbhAKTZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 14:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390797AbhAKTZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 14:25:54 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F54C061795
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 11:25:14 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e22so814095iom.5
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vV/cILn8rU491dKwdCJ1cKRiP8h276hZv0g1p5A6YJk=;
        b=Zt8x0hZJDzp7Tc5pnVI0qlHzFNeFl1XMtewrIc18QV9SD9TmI7IGXpebKsAF1zPml5
         gBgTOU7ae2oBn7q1lb3NmU3kjUSC/NOIXJYaMkBLbPa1GJFFsvBXnaui0FfB4QL+L5aq
         ItZjctUKA/s1dXkM3VbHEFkdriToxlI9UvsZC8FsW32vcjlshUsuyXD1UUtxJezWuJSP
         Ysz21e2BHg0tx1onItFRKV/jjSiANnvrlqd4+cX/liPpL599z+6RdJ8EoSJWmsy7FlKx
         zqHCJ08QjW22TuIDtA9cUmyM8i61QjaUck1aaPV6sVW3fr1KtpmNx6K7vS/MXh2cA/YD
         SRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vV/cILn8rU491dKwdCJ1cKRiP8h276hZv0g1p5A6YJk=;
        b=DwTdpsZQj1yIGgl6Hp9WyZrvk0bPGAyys7cbpNyA1+o5ZeqpfIVNKADDGA42jUP3w1
         CvbqQpQlKdY4bwjnrAKFcFpVh2B791ovtrGnFOGCBds/Opvgv3NQtf2gURDwsflnPI/6
         CxDIn9/35/FDHyHVzBZxUrRxxNTSfa28TkTdyT3Z2hhaRZLqW5zfsMFuk0AaXVhVemEI
         3iY01fD8EayYLIdxQnhyOHIqgW7YffaZGLGRfkLaRb1yC0RUllt8I4ZIhuakuWRvalIu
         T4KolJmzOa20gMkDs/hiUDt1zpalm/hU16znzHcAP9mnEzH8DIr47vS7klmUQX55/4Tr
         2SLw==
X-Gm-Message-State: AOAM531cJ3ZKovSmNSz2Ph+/BaKyDmseMipSNDFEHYBUmVXPf6gvS/CQ
        5uZMJNUrEOsHKzGU4XTo0lKDjAP+OtrCFA==
X-Google-Smtp-Source: ABdhPJwbty8JvL+Gnn9bzfZp3LH6UnTed0JH99Rn3ocMpRyoYwY9Wv0hXvUX4UQU0Jxo62R/wJHtcw==
X-Received: by 2002:a5e:c111:: with SMTP id v17mr618106iol.29.1610393113448;
        Mon, 11 Jan 2021 11:25:13 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id k9sm224888iob.13.2021.01.11.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:25:12 -0800 (PST)
Date:   Mon, 11 Jan 2021 14:25:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Adina Wagner <a.wagner@fz-juelich.de>, git@vger.kernel.org
Subject: Re: suspected race between packing and fetch (single case study)
Message-ID: <X/ymFuUPn2POWA/p@nand.local>
References: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
 <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
 <X/ipCPFyW3gAWrHo@nand.local>
 <xmqq35z9g3pw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35z9g3pw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 02:11:55PM -0800, Junio C Hamano wrote:
> So, we probalby should document "git clone --local" that the user
> should expect fallout similar to what may happen when they copy a
> directory hierarchy with "cp -r src dst" and muck with what is in
> "src" while the copy is ongoing.

Mm, good idea. Below the cut line is a patch to do just that. I thought
briefly about documenting it in the pack-protocol page, but it only
mentions the local transport in passing, so it seemed inappropriate to
add that much more detail there.

--- 8< ---

Subject: [PATCH] Documentation/git-clone.txt: document race with --local

When running 'git clone --local', the operation may fail if another
process is modifying the source repository. Document that this race
condition is known to hopefully help anyone who may run into it.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-clone.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 876aedcd47..02d9c19cec 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -57,6 +57,10 @@ repository is specified as a URL, then this flag is ignored (and we
 never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
 Git transport instead.
++
+*NOTE*: this operation can race with concurrent modification to the
+source repository, similar to running `cp -r src dst` while modifying
+`src`.

 --no-hardlinks::
 	Force the cloning process from a repository on a local
--
2.30.0.138.g6d7191ea01

