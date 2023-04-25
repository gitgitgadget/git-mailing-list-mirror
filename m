Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DEDC77B7C
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 23:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjDYXMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 19:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjDYXMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 19:12:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A4118B91
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 16:12:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso5123573b3a.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682464337; x=1685056337;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/pZ28/cxgq0Jd9Ex+hLssIZW+h0WWy9cyNOcdp+l1s=;
        b=bPMCjepmj17K/JlFSXQ3Dch3sYPt5JF83Qre8fVsW2ymSKjUdZIV33wXS2raKdlLFy
         8z7P8AhvMd9jYwjUcEK4pgKR5uhUfBWl4LzDLBtUIzorUCSD0fM+R64rbZ+qqvkgwiyt
         ODWnIOcwoJAD4O9hd5Y51tDVq0Hv7g1ZnEz6BA5GEbrkbndyGBZlRRoQZXJM4rCBTpLj
         iSBrO4jclrMEuzpaRTzqAh84R59ZE3S+c+frpbgZFIDNbGxiz3nDSAF2NgejOAZBCXm0
         VPBGWuRcur6WkHjK6lpdlE+52hlWO1gbxceX2pjhV+f16lU9KZORRaMxQhy0ZsAjkkAC
         ZLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682464337; x=1685056337;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/pZ28/cxgq0Jd9Ex+hLssIZW+h0WWy9cyNOcdp+l1s=;
        b=lXsMZB+f5g40iSq/99efbR+1Dy5cgRTqfl/8g2ncwU0b42I+cJb3xagNTx8aq7PpUg
         vFpcxgxudGH3npchwu2STEc3EP+u2mFxi4P1Q9qgVDML6Ov6xzTZ9j/fM6Y5DMwvC6vb
         YjjD7PhFtnryBl72fGTcxWR/xYb34kA6MzX698U9RPHyOqSHSJ3VZgxsGV6Iedk5+QkA
         BJGlbXeknDJRWDJ6/J1S9AY3+gGR2C66nDmBnArt+MvJOTpTckYWFGYGQ0tRJW24uo92
         HeJFawJhw+q4EyQ4+HbzZ5/qskpmH/XVOnXVaEqIsXR0NVxzFLg1pRIs8wH9Qn7s6KWR
         yTQg==
X-Gm-Message-State: AAQBX9cftJUDqvEYI52L4CVLpkH/auffSeoEfzwEaRH+JyWT/Ra28Xlx
        E8o7d2DcNiH+M+OFqN18SmA=
X-Google-Smtp-Source: AKy350aRKdOwIaTldQm2H/moeciWg4VpUpIjgGMS8xHRPTFuc29vUCRjZ8oR/i5QlnKPFUy+adKq+w==
X-Received: by 2002:a05:6a00:1582:b0:63d:259b:b5ca with SMTP id u2-20020a056a00158200b0063d259bb5camr24423843pfk.11.1682464336661;
        Tue, 25 Apr 2023 16:12:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v10-20020a62c30a000000b006352a6d56ebsm9612062pfg.119.2023.04.25.16.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 16:12:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
        <xmqqa5zmukp5.fsf@gitster.g> <xmqq355euj2i.fsf@gitster.g>
        <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
Date:   Tue, 25 Apr 2023 16:12:15 -0700
In-Reply-To: <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 25 Apr 2023 21:35:44 +0000")
Message-ID: <xmqqcz3ry2sw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If nobody looks at this, I'll take a look tomorrow and hopefully send a
> patch.  I just wanted to point this out to the list right away in the
> interest of getting it noticed.

Thanks.  

The topic in question has been in 'master' for 2 weeks, since it was
merged at 96f4113a (Merge branch 'jc/clone-object-format-from-void',
2023-04-11), and as I said, what your test demonstrates is not a
regression caused by the topic but "was broken, did not get
addressed, is still broken".  So it does not sound like it needs
"right away" kind of attention.

> +test_expect_success 'clone propagates object-format from empty repo' '
> +	test_when_finished "rm -fr src256 dst256" &&
> +
> +	echo sha256 >expect &&
> +	git init --object-format=sha256 src256 &&
> +	git clone src256 dst256 &&

This needs to be at least "git clone --no-local" for it to be v0/v1
protocol test.  It is testing the local optimization codepath.

We could peek the original repository and copy the hash function
name to the target as part of the local cloning.  That obviously
is outside the scope of the earlier fix that worked only at the
protocol level.

And I think even with "--no-local" to make it about v0/v1 protocol,
the outcome is still pretty much expected.  If we make the above
command line to

	GIT_TRACE_PACKET=1 \
	git clone --no-local src256 dst256 &&

to clone over the on-the-wire protocol, then we see

    Cloning into 'dst256'...
    packet:  upload-pack> 0000
    packet:        clone< 0000
    warning: You appear to have cloned an empty repository.
    packet:        clone> 0000
    packet:  upload-pack< 0000
    --- expect      2023-04-25 22:55:39.771850195 +0000
    ...

in the output of "sh t5700-*.sh -i -v".  Without any ref, v0/v1 can
not carry any capabilities, because there is no ref information to
tuck the capabilities on.

I unfortunately doubt that any solution would exist that does not
break compatibility with the deployed clients that expect the
current v0/v1.

Thanks.
