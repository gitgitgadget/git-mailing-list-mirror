Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC8C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35F5206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJZfNX+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUXXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:23:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45712 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:23:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so2400743pgg.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqVLDLXVaP7c4Y4YWhPNKLer8pKGgKHjaQweb2qy2II=;
        b=lJZfNX+ImvjM4kG5Skn9TOshFNCJ/bek94AAu3WdX3c3xRhIb8xvSk/TJd21SxbyEU
         5V2/11sL9OQcKz/9ZWiMnMr1T0L+E3Pqk2k3Q+hIbuGEbrmkKV3Eip6J7W7gMoTavPeU
         MA0uwr2qda4Ydo+xnjVZk6VTmSUPGHyN2jKzKLhRLSgOUuaS03Dy+BsWQy/7zoHaDJUh
         +Muz9hMMHUy9ybtXZ2WMO032h+Lu3YX2SzY3nh40Fvg/Zsn8uOO9mFCqiZ24MG1hOdL7
         h1PqmXqmIhEuCYz3ND2Cd+lbUuBsns6brUJtzGy3onh8+SLnAdwVIisQXeBe9mAcEAsp
         wuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqVLDLXVaP7c4Y4YWhPNKLer8pKGgKHjaQweb2qy2II=;
        b=gKDDN3jfNYMWhq/WhqgzrQ2nWUJbhGPRAqLchRkbbIVuZs7wkGz+aPvhTjQdIMkFMX
         3u9CQREvaeWrcktQl1K8ayg7d+tRsFLvGoWvDmBL7NY9u2q9M2vLjIhd1WTO6g7DAG7o
         4qC5BtdccXmj2DeG3Ab9mjAXWujp73v64JQ2lnKvCMyA+lzSAyp+Y5dtwNRsnM3i5QCK
         9PTgbolpvbttT7ujxS4ossHBqX5rOOMHTxEwo5qULSzXFBnruv2dyo2ATphLshdi509+
         dqKgUfil/ED6BaIOFjikphIti0avJKeAk+i5w+E0fDWd57V5tPWu0usip8eJXHmtJK4S
         dxqw==
X-Gm-Message-State: APjAAAVv3oSs0sSrUOkyuhDKroOg/ZRtKHJQu9toSHQfVPFdRuKPB0jM
        hfXwuiO8NwqTTtHBNMnNYTk=
X-Google-Smtp-Source: APXvYqxvDWJqVFItUxVbAyeRnr965xy2O/FldHXyMSC5LLl+4N1WNiT6/CHSrVmk1jO33Msx83INfA==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr12711796pgr.419.1574378580993;
        Thu, 21 Nov 2019 15:23:00 -0800 (PST)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id d187sm4180214pgc.1.2019.11.21.15.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:23:00 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:22:58 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 13/21] t5703: simplify one-time-sed generation logic
Message-ID: <20191121232258.GA23376@generichostname>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
 <d5fb60be6bdd5e885c6f830c8c44ba250350538b.1574296987.git.liu.denton@gmail.com>
 <CAPig+cTQapDMZwtOPcSiyu-MSBKxSY2MJ+o9rh3=SC4tFu=u=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTQapDMZwtOPcSiyu-MSBKxSY2MJ+o9rh3=SC4tFu=u=w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, Nov 21, 2019 at 08:12:00AM -0500, Eric Sunshine wrote:
> On Wed, Nov 20, 2019 at 7:46 PM Denton Liu <liu.denton@gmail.com> wrote:
> > In inconsistency(), we had two `git rev-parse` invocations in the
> > upstream of a pipe within a command substitution. In case this
> > invocation ever failed, its exit code would be swallowed up and we would
> > not know about it.
> >
> > Pull the command substitutions out into variable assignments so that
> > their return codes are not lost.
> >
> > Drop the pipe into tr because command substitutions should already strip
> > leading and trailing whitespace, including newlines.
> 
> Saying that command substitution _should_ strip the whitespace leaves
> the reader in doubt as to whether there are situations in which it
> might or might not do so. More accurately, command substitution _does_
> strip the whitespace, so please drop "should" from this sentence
> altogether.

Good point. I think in general, I have a very passive writing style so
I'll make a note to write my commit messages more assertively.

> 
> > Finally, convert the printf into an echo because it isn't necessary
> > anymore.
> 
> This is quite misleading. 'printf' was _never_ necessary; 'echo' was
> an appropriate alternative even before the other changes made by this
> patch. Worse, though, this sentence provides no context about _why_ it
> is safe to change 'printf' to 'echo', so the reader is left with even
> more questions trying to understand the validity of this change than
> if you had merely omitted this sentence. My review email[1] provided
> exact reasoning about why this change is safe. Paraphrasing that
> explanation for this patch's commit message would go a long way toward
> convincing the reader that the change makes sense.

Will do.

Thanks,

Denton

> 
> [1]: https://lore.kernel.org/git/CAPig+cTj5qOCFRoD4cZOg7BjVvetQWTgdRHzSvAfgtX2YgUXPg@mail.gmail.com/
