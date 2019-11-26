Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC4C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 04:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BC720637
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 04:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXXE/Qr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfKZErH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:47:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42758 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbfKZErH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 23:47:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so8514697pfh.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 20:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdf3Hp7Si7pehe58JeHHfi2fN5ihJ3YZLc+TlCklMLQ=;
        b=pXXE/Qr6KKwrOld5DWjflPMLMcLY6ptBurkuddpXbMZjfTsDUrJ+NFp2QkB53Z8a/x
         jI92t5yLOCqNg2iKDU0qrhTHRD7Evlr/f5XDwHQKAjKTlNlNkC9rhKUMk9PCsKsYKb/U
         RPjjEm3EExJ1j/YLswbCfkQCN/htRBuWUpdOtuLdmOL2bZehuua1LqwXCYbMVpjVNAjm
         UCb7ayQHhmCwFAn+bruDCe0Ssb4A2RtSS+laq5dH3Sypo7oco/elzfzGo21+TkyZJ/Rn
         CWL6W+9T+qmRenDFL0yI2sPgYl+okmA5N1yw8psnyntAjaPi/RrEjlgUMM7uGcP8mZgt
         9+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdf3Hp7Si7pehe58JeHHfi2fN5ihJ3YZLc+TlCklMLQ=;
        b=jsVWqG/k8BFafE/5kEM+8KSU/BQxvHG7pfJgaX4DmbXxZ1h5q/7L+6FGmVh5+9Lq6T
         rWEvtziNzsibDTnEc9U3YR7LrMFnpnSdjq7jSNQ0OQnmVm/Ays7aMmrNT0A9QcszuY5+
         38vpWQ+vBGPd4jYVF+2IDfO66xyIu9wQFyBDJF/wYh/Jc6bXHZjKHdibONrIivA1ayya
         EEy4uOCMorAA5jESatq9kkmFuIlLEszONwk3nxkypRb1ctjrVK+q4J89QwhOVGNLbzSL
         MYBysiw+aS1r4sc4vgUVegTgKidcbsTZg9jTVoMXuciSYknJo2CFiZskhkQZMg3l9iCb
         QYbQ==
X-Gm-Message-State: APjAAAUm7Op4JBOk810DA06Q6SqYc9ZB6LL+fE8XEg0ThlaXLYMtpGf3
        Ti7Pa7EnV48KPkImKAYKHB5Gkdhu
X-Google-Smtp-Source: APXvYqygaaE5gYx2V/LtGuJ+x43I8e2c34nHarXy1iZsdHZ7WdTd+XDKT93Qql5WXA9Px9EOg7sZTQ==
X-Received: by 2002:a63:e653:: with SMTP id p19mr37376580pgj.109.1574743626155;
        Mon, 25 Nov 2019 20:47:06 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id i71sm10203123pfe.103.2019.11.25.20.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 20:47:05 -0800 (PST)
Date:   Mon, 25 Nov 2019 20:47:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 22/22] t7700: stop losing return codes of git commands
Message-ID: <20191126044703.GA3579@generichostname>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
 <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
 <xmqqftif2wg7.fsf@gitster-ct.c.googlers.com>
 <20191125235702.GA6250@generichostname>
 <CAPig+cQqK-HiDjmnBFo-qeE6cZ73EveWg6Ygb-4BX3X_iPSJZA@mail.gmail.com>
 <xmqqlfs3whc7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfs3whc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Eric,

On Tue, Nov 26, 2019 at 10:34:48AM +0900, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > It may not be too much work for you to keep adding more (unrelated)
> > changes to a series, but doing so increases the burden on reviewers
> > unnecessarily, especially for a long patch series such as this one.
> > Generally speaking, each iteration should help the series converge to
> > the point at which it can finally land (be merged to "next"). Thus,
> > ideally, each iteration should have fewer changes than the previous
> > one.

Sorry for expanding the burden I've been putting on you. I really
appreciate the effort both of you have been putting in reviewing my work
and I'll make sure to not make it any harder than necessary for any
reviewers in the future.

> 
> Yup.  It is too easy to paint an ongoing series with a brush that is
> broader than necessary and say "this is to clean up", and fall into
> a never-ending run of scope expansion, as there always is yet
> another thing to clean up.  The focus of the series has been to
> ensure that we catch error exit from "git" and that script conforms
> to the style guidelines, and does not include hash migration.  
> 
> Let's resist the urge to expand the scope.

I see that Eric's already reviewed the changes from this round (thanks,
Eric) so I don't want his work to go to waste. But I won't change the
scope from this point forward.

Sorry again for the extra burden,

Denton

> 
> Thanks.
> 
> 
