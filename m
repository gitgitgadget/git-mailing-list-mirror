Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E83C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 23:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD720740
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 23:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO47m++r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKYX5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:57:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37511 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYX5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 18:57:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id bb19so3821544pjb.4
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EO63Y2YVDoDUEc8hXStrWGQX+JE7slxM+JBjODMLltU=;
        b=kO47m++rTAsRLzQXjvbwwqNuyIQOXwt3r9jBbU4KZozWs+iM2KdYAHwNrMjOA23afl
         9+130a9QyCwMa6zck0CXbV5zc6M5tmAHYWPMuSf72DHV67s4tUs8SXAr/4VrHPwAxuk+
         4QOzhaN0K4U4onLCTBqsqRpqoJWDYTp9f2gqwnCE3os4Aak3r1uzQJWTH/OmtrFDjxpA
         IOqKOorsN2fNB07Wi+M9orCrRCpXusp70z1dX/+59O/pyIh4hWimkYm6KvYzMscbWO5E
         mu/0hOmbAIOIdxyxsRA8Ipg1/RkqDjATyod59zhc//UQHLE3SFvdhIweVmZCLGKz1SxR
         a8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EO63Y2YVDoDUEc8hXStrWGQX+JE7slxM+JBjODMLltU=;
        b=a8kyFZLm02Jz5E8YWaD5pt3VCuIZ0xkNU3P1ITs+IbJI3sCMaYgk9jNR9UccC4jr3u
         QHq/FFCRS/NFfxVb544U8UmHsuBLIlGNix7JkUXKKu8Oh/bzhZvdY/udaOe1681JVHuV
         YCKy7XvCA15xqNupr+Plro+NS09NO1K/Hw8hwWqoa/ONZXi2tlh7oL0gOsGCOD/J0lNK
         Un4IqNlouI0aUio+0iMMj6IQUIM4P13r6Pp1XN6u6UasFnEAElyBtV3+zEgpqJ3zB0eB
         zwGkbr/m1aOHTKQbc79Ktryc8YpDAJNW6h9KlZo98S6sSVwxXh4Gf7ovNwWsE/QASpvk
         knOg==
X-Gm-Message-State: APjAAAXQKKV9gKP8TY/cvpVWGxljjIfu1OkAzsnNDEcjVkx1vwLLpijN
        6lz1GmkfqDzy63e7Y4CtzOc=
X-Google-Smtp-Source: APXvYqzlWDoeEdz7KR9vBkF8bD6zroNaPWk4RseR+Az2P6tILHGe/NHpU/hFdmawQLCmLYihvRZKZg==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr29547282plk.231.1574726225679;
        Mon, 25 Nov 2019 15:57:05 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id t27sm9897142pfq.169.2019.11.25.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 15:57:04 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:57:02 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 22/22] t7700: stop losing return codes of git commands
Message-ID: <20191125235702.GA6250@generichostname>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
 <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
 <xmqqftif2wg7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftif2wg7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, Nov 23, 2019 at 10:49:44AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > -	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
> > -		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
> > +	git verify-pack -v pack-$packsha1.idx >packlist &&
> > +	objsha1=$(head -n 1 packlist | sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
> 
> We probably should lose reference to SHA-1 and use $OID_REGEX; this
> is obviously a #leftoverbits material that is outside the scope of
> this series.

Since the theme of this series is test cleanup, I believe that it's
probably appropriate to roll these changes (and the ones below that I
omitted) into the current series. Since it isn't too much work, I'll
send them out in my next reroll.
