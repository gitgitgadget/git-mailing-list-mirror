Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2A3C33CA9
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C49620CC7
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 02:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzOytT4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgANCtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:49:42 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46731 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgANCtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 21:49:42 -0500
Received: by mail-qv1-f68.google.com with SMTP id u1so5017234qvk.13
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 18:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G3ZBvSpwbocDU1EHBwrvIV3J182r1QPYsR7R3xqKnxg=;
        b=BzOytT4ePkVZsmp/mR3WeHTz9dgNhaopR1lacfm3RoZR3bkl1WvKBvMeB5MG+LpwCx
         3jGX327CAft3fiX0fWzvNGFaF7BL0pSAJLZMV6yAHGQXi6CE/xGUvG+wEReu7T8ro/6Z
         l3oJeM4zhyTUT0+n13ykOgGaSS4avAN3rltCdeDMThB/fdqNrOUSJGCpKZG8258/6CqI
         wOqMMlKCNw5xfQ1NDV56ztEbkVcd+yGGAcTgE77i+ksmz8V/9tAwu4dX0+BzdtSrYajB
         B+BTZK49RjdWKZgmy4R79IS8M0ZApcqp9Sv5uFasVM5dQenJsWJQjnGaEjDHdPpU322K
         tuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G3ZBvSpwbocDU1EHBwrvIV3J182r1QPYsR7R3xqKnxg=;
        b=Mp/JDPjcS0MjUtuvACXYooVsNTG6dq1Neyf+cOa35bDHRfVG00fzaGt0LJ4eqCBzKh
         WRofKuzzgpSUJ5Wh+C3jNc0QSSBtOeEKM4ZphksUfhILXCbeLyalhD9jgv3UxnRQXmKQ
         e1vu4InrrbiQqB1WM8mdrDjfzOm0mZdb/mvG34iS01AUJZdMURib3Fzks9HZI9NEAQGX
         xB+h70HgVeCB6aD3mZSrwsgmEYsoPpYZtmkPmwuf929jd7sWkcsm8TshXSKP/u3Q22QY
         TAdpuXe7e6YWkMKSUM2E0UJFQToKVYmyCR3ugVnZB0tNqNIKhprs3Nr90JLqPtjb6NEd
         02AA==
X-Gm-Message-State: APjAAAX870+MXagtQDQS1LHuwC1lqBuCFCRjBUf4JcH7l+o4yp1rZCdF
        0ZoVT1Epn6MLvBqQs3mh6F0=
X-Google-Smtp-Source: APXvYqznVVIvsfHa2SZLd4B6LPcIqh+jbIjHckuXGReuEzOJP8OQNqqD7CdGlSOlZ5uDw6akr3O90w==
X-Received: by 2002:ad4:4b6d:: with SMTP id m13mr18989511qvx.240.1578970181314;
        Mon, 13 Jan 2020 18:49:41 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id o7sm5930973qkd.119.2020.01.13.18.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 18:49:40 -0800 (PST)
Date:   Mon, 13 Jan 2020 21:49:38 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.25.0
Message-ID: <20200114024938.GA17003@generichostname>
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 11:28:30AM -0800, Junio C Hamano wrote:
> New contributors whose contributions weren't in v2.24.0 are as follows.
> Welcome to the Git development community!
> 
>   Ben Keene, Colin Stolley, Dominic Jäger, Erik Chen, Hariom
>   Verma, Heba Waly, James Coglan, James Shubin, Johannes Schindelin

I was quite surprised to see Dscho's name in here until I realised that
this was just erroneous authorship information. Below is a mailmap patch
to fix this.

>   via GitGitGadget, Jonathan Gilbert, Josh Holland, Kazuhiro
>   Kato, Łukasz Niemier, Manish Goregaokar, Matthew Rogers,
>   Mihail Atanassov, Miriam Rubio, Nathan Stocks, Naveen Nathan,
>   Nika Layzell, pan93412, Paul Menzel, Philippe Blain, Prarit
>   Bhargava, r.burenkov, Ruud van Asseldonk, ryenus, Slavica
>   Đukić, Thomas Menzel, Utsav Shah, Yi-Jyun Pan, and Zoli Szabó.

-- >8 --
Subject: [PATCH] .mailmap: fix erroneous authorship for Johannes Schindelin

In 49e268e23e (mingw: safeguard better against backslashes in file
names, 2020-01-09), the commit author is listed as
"Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>", which
is erroneous. Fix the authorship by mapping the erroneous authorship to
his canonical authorship information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 7c9441837a..fbef813f24 100644
--- a/.mailmap
+++ b/.mailmap
@@ -109,6 +109,7 @@ Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Joachim Jablon <joachim.jablon@people-doc.com> <ewjoachim@gmail.com>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@gmx.de>
+Johannes Schindelin <Johannes.Schindelin@gmx.de> Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
 Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
 Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
-- 
2.25.0.rc1.180.g49a268d3eb

