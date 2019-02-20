Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0911F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBTWvz (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:51:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfBTWvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 17:51:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so8046767wmg.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 14:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=a2YkxdqbLHl9BAgJAKOqRbcbrGXE2t8LLAvOTBdYJNs=;
        b=P9gIeuXdR5RdrouytPzHaQ3z2/PXyltNaW4CgD9E9ofYv4UM2liZil6vkK5dIG1luI
         Q3Pw4nD2OMkBJoP6/VD89RehpTEQJX/HCRLNoGcXEgcy00xkc8Nl1wrH1Ecpvpk1QB4W
         fz2NLu8XNw2D2ednRp2OUYBODiv6ZEFZLnV5P1FesTF4Qh3/kC4pM4GNdtgMPNhziJIp
         zvVYyJiNBDugh2iL04499kNNvAa1XRVAPVKKJGBRkHa4G0FkV5/8/VY7oT4cu1htD6Mc
         +yk6n2HZKLefVf7XZORQmZNSnjM08zGixCPGYEsvvwNhplZwnS0M7oYa//yE2+tOmVRe
         r0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=a2YkxdqbLHl9BAgJAKOqRbcbrGXE2t8LLAvOTBdYJNs=;
        b=nayOaDe5rubH/gg9tg88z7P5Ek+wrtez1whTr8zUPiJaaYCnA7PdDlfnpsVdt+xTOv
         KjMkiEp+cKDpU/8VqhmUf+vwxyAAcgZERNZ2sakEVw/L5POWTufim6naoHcwTr4MYRvK
         BRMg/+C/W5K4FdKuCY81bD/3dANIUcyz758B4DaduktDQ7Aqi1a+vlr1PjH9TW5L+DUv
         PMAFq67QkjZUEnKH5CnQPICXCB43Dx/h7OjwpB3M8ZcDWwTCrKHZoIG0VwjH+hQRIZ5g
         vi6GnGJPYGaaT19amGkSAb82beJKXrEMTf59/HqCDhFCNjaXY4LZ6YCPp9h4lrykAgBv
         j0gQ==
X-Gm-Message-State: AHQUAubsN6DSv9ypOuiqWIogRdfobd5zkJbJOUWFgHfABlqIEccxfrBe
        yGLzO/2SBitbw6wpNoYEN60=
X-Google-Smtp-Source: AHgI3IbGxZVTkZK87BbXVeJpKoQ5tfQ9MYOLcp8vcP85WtxMvQpaGD9anJB1skX+QZAOm6L6Hx/kXg==
X-Received: by 2002:a1c:c489:: with SMTP id u131mr7593947wmf.127.1550703113394;
        Wed, 20 Feb 2019 14:51:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 12sm13634723wme.25.2019.02.20.14.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 14:51:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Joe Ranieri <jranieri@grammatech.com>, git@vger.kernel.org
Subject: Re: [BUG] ls-files showing deleted files (unchecked lstat return value)
References: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
        <20190218151725.GL1622@szeder.dev>
Date:   Wed, 20 Feb 2019 14:51:52 -0800
In-Reply-To: <20190218151725.GL1622@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 18 Feb 2019 16:17:25 +0100")
Message-ID: <xmqqh8cyul87.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Sun, Feb 17, 2019 at 08:49:39AM -0500, Joe Ranieri wrote:
>> "git ls-files -m" can show deleted files, despite -d not having been
>> specified. 
>
> To my understanding that's intentional: a deleted file is considered
> modified, because its content clearly doesn't match the tracked
> content.

Hmph, I am not so sure about that.

It seems that b0391890 ("Show modified files in git-ls-files",
2005-09-19) fixes one of its draft version's bugs in
"http://public-inbox.org/git/43179E59.80106@didntduck.org/" by not
letting it use ce_match_stat() directly, but introducing
ce_modified() that inspects the data for actual changes.  The effort
however did not spot the other bug, namely, lstat() returning an
error for ENOENT.

I think the original intent was for "ls-files -d", "ls-files -m" and
"ls-files -d m" all can be used in a meaningful way by keeping these
two selectors independent.  The buggy implementation did not realize
that intent correctly, though.
