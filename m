Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C6BC47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE464208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="q05AKoqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgEAW11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgEAW10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:27:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5EC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:27:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so2179183pfc.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=53ErFxcHDFCpW+XHVnBcH55W/v2CwRKHHmH+SH+OjF8=;
        b=q05AKoqGjYgYy8hhJxVQhAWGOPzgJRLQmr+CoO5rFvVRDMPOxJuuy6SOEobexApQdg
         vuapW45X6R+80lga1670656Y+wogXilesww5iz26zWvvf8kbiy/c5YYRwGEtKyp9QLEV
         xxy71MBQg0Y/DTg4YvsdlbOmqypDD4W9Ignush6ebJFDbeAiS+AYwOeQoU41Sx9CJ8Ou
         H/UgfJteNyICTOWnH27GXDAFKbB420DJH+kU/COpSYM26K3gwvf8kkHo0uyS6OQdPA/r
         Y/Lb7GEX+sf8/0YhAI7dsxcC323e0JLMDICXFazXUfiUlKPNB4WykJytyfGnYzAizTv2
         Dziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=53ErFxcHDFCpW+XHVnBcH55W/v2CwRKHHmH+SH+OjF8=;
        b=NaYBCl2Z+Q4OutS73KF0dnd0A6dSPoXMP0KJydZmnTPLrj5blOGEn6OmH4vdrQm3Co
         vOfl3B9NtzbGSaZujjcFGtPXOaDJ6s609BOsHKyJQPIK4cp3ZuIrHQfArNqrQ8BXnzgz
         QBbslDkHz9D+B3gk0i/7xld3isILTKYb0l7VdbDz1fdwl3p8y9fYKeCwPDjefG50bAuB
         jmD3awb7u8cALNVR1pIdE63hvelY9nRR0d3Zj8pXmtJDms6gKbKl3TgzoOdoSqvn4WtP
         kZWtDU3AI4/wuW8W+/vmnR8KmNUZsrpcvZxeXmLYEYPBYXNEKPibzcnl4xUMqQ/lqRhf
         WQ0Q==
X-Gm-Message-State: AGi0PuYFvh0OapTodKhKVrK2n5OMb3DsP7hIvcqUqJZ/Y4z2p6xINBzb
        tfTjhVjdm0yl3mVsVN7ORjjQiw==
X-Google-Smtp-Source: APiQypJt35MW4z7yUMYWvlCRnO6DV2lcW0ssQAcE/W/AYpCqbwj3L6XwuBOLt3iBHq/hEOAOHJEu5Q==
X-Received: by 2002:a63:bd42:: with SMTP id d2mr5993825pgp.214.1588372045839;
        Fri, 01 May 2020 15:27:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c28sm3054315pfp.200.2020.05.01.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:27:25 -0700 (PDT)
Date:   Fri, 1 May 2020 16:27:23 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200501222723.GF41612@syl.local>
References: <20200501105131.297457-1-leobras.c@gmail.com>
 <20200501125308.GE33264@Carlos-MBP>
 <xmqqees3odrb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqees3odrb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 08:50:48AM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
>
> >> +of `sendemail.smtpPassCmd`), then a password is obtained using
> >> +'git-credential'.
> >
> > this last part on git credential is just undocumented, since it is already
> > doing so since 4d31a44a08 (git-send-email: use git credential to obtain
> > password, 2013-02-12)
> >
> > and of course, assuming you use a credential helper that keeps the password
> > encrypted you could use that instead of this new feature.
>
> Up to this point I understand your response.
>
> Documenting that "git send-email" can use "git credential" for its
> password store, if it is not already documented, is of course a good
> change.

I agree completely.

> But I am not sure why this is "a good alternative".  Having more
> choices that do not offer anything substantially different is a bad
> thing.  Is this "new mechanism" better in what way?  Simpler to use?
> Faster?  Less error prone?  Something else?

Ditto. I don't think that an increased surface-area of possibilities to
specify your password to 'git send-email' is useful. Put another way:
why *not* use the in-built credential helper, which is already
supported?

Would having it documented eliminate some rationale for invoking a
separate program?

> Thanks.
>
> > having said that, this looks like a good alternative, but might need to
> > make sure if die makes sense below or would be better to see if you can
> > still get a password through git credential even if that fails.
> >
> > maybe the rule of what to do might even need some configuration itself.
> >
> > Carlo

Thanks,
Taylor
