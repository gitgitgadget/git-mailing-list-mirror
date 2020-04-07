Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BAC2BB1D
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BD2074B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 13:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFgpJVHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgDGNJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:09:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39830 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGNJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 09:09:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so1492891qkf.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8a400LkG32EwYlXbWqZw/FJ3Ir+MLtb2KIlK2i4M/iE=;
        b=nFgpJVHrZG0UsnMmMm8dRYU1eAf5pa5S6ERk29hpZfbGCsRbC0L5nPWtOoA5hQZp0v
         AtDM/pk3KVvvz/L1L5MZfDM38A09irc66Rf8ciTjJrO2F58LY2pKH0YP4A9Dby5UnZNv
         pJ8D6aqeWWW6dXOSHQr4u02tn74H5qC0ebeeULmtEBm9vDNLIN+ckvdRZFXrJzJFgU4q
         TCq9fp/Qf0TYBPCPiOCljeKh1Pa8Zs7ZX+BLSjJSyirL8hBwNLxN/OXiNZF1IwNVc0gu
         2N+g+RtV3kDsyKVwnAXfcbgE6r72XLRSNAn4PCK0Mk2IhpRvaAn+UwOzKVrB1xpm4kKF
         fFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8a400LkG32EwYlXbWqZw/FJ3Ir+MLtb2KIlK2i4M/iE=;
        b=q0k/ZyUDml60IuEywtEYl92EqvbPTEh8luRDZvesqM9XG7SIfO1IwW94wFX/YL0t3C
         oQl6VFvsH697MG9Fm/6K9LHbnaj6Drskt4sqttqZiKzc1Fb05eLmTxNHNl2oLJsT+JOf
         7UMRijjgfh2QUWkaej0o28PeojV7VwW2nCraUK5GVLkd/bZYRuGmtppKKdq0+g9mFeN5
         GqNaIgr8XTw2rzvytBbl+tc1fWPQKV96jZR4HbboHV6LOd1CRa4fb57zWmLMvAfL2qul
         bG9r9nptYYwwMjtMFPIGg5I6xn4gnvqGbkj6xpO+JPmgf4tUAg9xHCkuzHY+XarGqW0t
         MOmA==
X-Gm-Message-State: AGi0PuaTBDzWzdRvo73oFgRfRFm4+Jwwn4qctB1zJnMI0txY3oCY1b0+
        t+s4KMb0xmWp8SKmzFjuGAQ=
X-Google-Smtp-Source: APiQypIDDjF0O5ZxiZ/98S33CWbY9BOQ2sUCuaH96tlAPzl6Rql/cylbVqoha57mX7sjtaBhz6InWA==
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr2098942qkb.121.1586264989652;
        Tue, 07 Apr 2020 06:09:49 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id q44sm18168636qtq.11.2020.04.07.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 06:09:48 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:09:46 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 21/23] merge: teach --autostash option
Message-ID: <20200407130946.GA2503067@generichostname>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <7adf7941921065fa1a5e68524e2dd3cd28f9a12b.1585962673.git.liu.denton@gmail.com>
 <07ec44b0-1162-aac9-1a07-579a3768cbd1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ec44b0-1162-aac9-1a07-579a3768cbd1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Thanks for the review. The documentation rewordings are particularly
helpful.

On Mon, Apr 06, 2020 at 04:20:24PM +0100, Phillip Wood wrote:
> >   --quit::
> >   	Forget about the current merge in progress. Leave the index
> 
> Should we be saving the stash if the user runs 'git merge --quit'?

Yes, this is its current behaviour, although it's undocumented. In my
next reroll, I've added a test case and documentation for this. This is
similar to how `git rebase --quit` behaves.

Now that I think about it, when `git rebase --quit` happens, the
autostash is just dropped out of existence, which is probably
undesirable behaviour. I'll probably submit a later series to save that
autostash so that it's not lost forever.

Thanks,

Denton
