Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03606C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjDESoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDESoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 14:44:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623E35B1
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 11:44:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so35292574plb.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680720255;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8aR/WwZoYC5Mf7ShdigVuhga8dpmhX6F8EurBUriMw=;
        b=DalDDFBNvTkTFvpRToyVjVWy9BlXS8CACsq4G0KFqkAVSoGfz5C1AjDGybesx8/pTh
         K4F+fzEcYLMRzldBz9ruZDHTzVXZnT7mlg61UqrrC+oQw/hqlchK7ddpjV0xQ6scV+aN
         TgK06baMJas4is6Z4Em+yG39A6HK/Kf3ffc6FgOqTa2yyHsxWi/ocG+h1EB8aJpHydLS
         auE/TukxnTRszBoZYFQy+AVUa89+BFR9Qjyn+ZowBnuJ7wp7j3fAA8vP/zWQSZ3uLtHl
         7FZfcrfTR0Q0uQv3aPeWQNBFt5i5aOJEYf9hDMA0t9hPcI0a0GUKhyIuPiDZhgo/GilV
         DXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720255;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8aR/WwZoYC5Mf7ShdigVuhga8dpmhX6F8EurBUriMw=;
        b=TDOck6UDdDYBiGKA5KH+DAasqOJ/A101FQGNh3MDoFWKEKJm8HCB0RJwhFNCyx+kBL
         EWq8nWQoXcv0V1TaP/z/QZiKXLC60G3EKi5jpxCxI5X1usSJ7BoaeOOCLSBK6Q3HbLWj
         f3LDbGpU23knZiBLVYMmFVukyIO8v57oAA0dkxnHlgv+BPv0LAxs3JJwoW1hhWKhp/dR
         ahUOW4YDJxNSCVJyRj9g1D59HKBmL+x2uPK61+Rl+p6SA04tFDKDDG22xvF8X5ZhG4gh
         10xQo9ocB6Llhy4iQWd0UwFPzVzfKi7ZO7lG6lKLfUVZ9LYNKUwNOaQdqxVcNBYyXqKK
         a5jQ==
X-Gm-Message-State: AAQBX9fTw5hv3r2JXY7tsakzG6S1qR6hRBDH4/TVCHTwJXuo7y5PgFna
        auX2Ke7YvUqyki4TLovkEU8=
X-Google-Smtp-Source: AKy350aCjCuiNYitF2pmGZQ1vS3uqWhh9ajvJaF8KEso3LE5PbEp2O5HPUUpoJrH1xqa9pFIBGs/9Q==
X-Received: by 2002:a17:903:32c1:b0:1a1:dd2a:fe72 with SMTP id i1-20020a17090332c100b001a1dd2afe72mr9128810plr.23.1680720254741;
        Wed, 05 Apr 2023 11:44:14 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902aa4300b0019f2a7f4d16sm10448895plr.39.2023.04.05.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:44:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
        <ZC2I7CfVzY6Tl7Pk@pobox.com> <ZC2LOAwycdaUawxM@ncase>
        <ZC2ZyTTZFbd_gNtw@pobox.com> <ZC2xcDwuhiEn2giX@xps>
Date:   Wed, 05 Apr 2023 11:44:14 -0700
In-Reply-To: <ZC2xcDwuhiEn2giX@xps> (Patrick Steinhardt's message of "Wed, 5
        Apr 2023 19:35:44 +0200")
Message-ID: <xmqqv8iaw4n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> I don't know what the right choice is for upstream Git, it
>> can easily be argued in either direction. :)
>
> I agree, there is no clearly-superior choice -- both have their merits.
> I'll probably send a v2 that only munges internal scripts that are used
> as part of our build and testing infrastructure. That's the area I care
> most about in this context anyway.

My preference is 

 (1) not to touch scripts that are processed by Makefile to use
     $PERL_PATH,

 (2) fix callers of "./foo.pl" to invoke "$PERL_PATH ./foo.pl" where
     the perl () { command "$PERL_PATH" "$@" } wrapper is not
     avialable, and

 (3) fix them to use "perl foo.pl" where the wrapper is visible.

That way, we can wean ourselves away from the assumption that perl
interpreter should exist at /usr/bin/perl without introducing a new
assumption that everybody's env should exist at /usr/bin/env.  There
may already be scripts that assume "#!/usr/bin/env foo" is
acceptable, but fixing them would be outside the scope of this
discussion, I would say.

Thanks all for a good discussion.






