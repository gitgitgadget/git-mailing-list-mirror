Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F190FC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6EB21473
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebpIhieT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHQNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgEHQNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:13:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2B8C061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 09:13:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s9so1169415qkm.6
        for <git@vger.kernel.org>; Fri, 08 May 2020 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdoMKIycEy5M+YUfaHXq0GVTlJN4AVPAKDbECYEL1+g=;
        b=ebpIhieTDsWEG8qwJ4qNh+X2n6VNLCpAmWisr3Mn5uRkl4bPaTyuF2tLnaxaCqQHQb
         cXAIOrIdzmcrtABj5XUWm5CW1JqOvR2g8a+nTdT03zhD4sdabJLc6TM9xzbW6MVwBSfQ
         SndcrwfZ6O32rRHWAWa9cGgV7lQCtxtPDTGeRljFn1tPY+BosUtIyJKTlHp10ICNNFhZ
         mMW9J+8K7tGoFxALGlTZ8W/8t70E/QbeKKdd03ygM+PIqv81Pu9Xo71YuSXJmFnqCqhF
         fmwNJAEXdU8np+qUv7GGPxJ99sz54G183XKVANY8AKRFGgIJZVkVJ4DKi5rmZ9308CGe
         zJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GdoMKIycEy5M+YUfaHXq0GVTlJN4AVPAKDbECYEL1+g=;
        b=TtnXi+XdNfQUGHG7LrwcE9AaJwhHCqVHZ4CcfNRvQ6s8wmGC02fRm3KvhWucGOyitp
         EpvXXsDNzdIqtmoRKhRIOKxZUwY/6hrT4OrXPxzKcaDC7FvWM6KZermU+2hLyxYVmeG/
         GW5bG79yixLt+tAQInnqe90r5nKSkRu+FZzdq/LYgBKbhve0yWysrKFtmMUXe0cLY0mG
         PErpSu7Us03JqxY3x4xPYmu14ncY036UBdDlIdSBt/01hF6M2kRbSCNGiEuYakczrHZb
         XawRhKwh643oC+Z6gnRI6c7zBvDogenZLu6bLHQYAgCSQq9ZBJbQPMEYLlwLV6TakZ2P
         hspQ==
X-Gm-Message-State: AGi0PuaYSkEVj3jBW0H1nVcmcLny5T/jpI8F9rM3TnOFPIPKgi8QlDEW
        wLOAFvkSw++7xy7WQxshIxVxKeQQ
X-Google-Smtp-Source: APiQypKR4qkcbo0G5S8B64GTekZj1Ox9aTR+47qq1KuRGnFvB85pscVOHUjsJ1UX/wXhw8aPRJGx/w==
X-Received: by 2002:a05:620a:13a7:: with SMTP id m7mr1480881qki.498.1588954402821;
        Fri, 08 May 2020 09:13:22 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id d4sm1814422qtc.48.2020.05.08.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 09:13:21 -0700 (PDT)
Date:   Fri, 8 May 2020 12:13:15 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        chrisitan.couder@gmail.com, Denton Liu <liu.denton@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Re* [PATCH v4] submodule: port subcommand 'set-url' from shell
 to C
Message-ID: <20200508161315.GA3504@flurp.local>
References: <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
 <20200506181239.GA5683@konoha>
 <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
 <20200507044028.GA5168@konoha>
 <xmqqv9l849i4.fsf@gitster.c.googlers.com>
 <20200508054728.GA8615@konoha>
 <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
 <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
 <CAPig+cQP_9onrq-z5db1GhXSSHaeKJ+UhNewWP25wLCsMRzSrA@mail.gmail.com>
 <xmqqpnbezaga.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnbezaga.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 08:57:09AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > This talks only about '=='.
> 
> Yup.  The text would need a matching change, though.

Here's a re-roll with the necessary changes.

> >     if (!ptr)
> >         BUG("...");
> >     if (cnt)
> >         foo(ptr, cnt);
> 
> Or more succinctly:
> 
> 	if (!ptr || cnt)
> 		BUG("we must have an empty array at this point");

I considered that but thought it might be too "cute", however, seeing
it written out, it looks fine, so I used it in the re-roll.

> > Also, would you want to talk about not comparing against NUL character?
> 
> Yeah, it might be worth saying it explicitly.  I dunno.

Rather than giving this a separate example in the re-roll, I just
mentioned '\0' in the text.

--- >8 ---

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] CodingGuidelines: do not ==/!= compare with 0 or '\0' or NULL

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/CodingGuidelines | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 390ceece52..6dfc47ed7d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -236,6 +236,18 @@ For C programs:
         while( condition )
 		func (bar+1);
 
+ - Do not explicitly compare an integral value with constant 0 or '\0',
+   or a pointer value with constant NULL.  For instance, to validate a
+   counted array ptr that has cnt elements, write:
+
+	if (!ptr || cnt)
+		BUG("empty array expected");
+
+   and not:
+
+	if (ptr == NULL || cnt != 0);
+		BUG("empty array expected");
+
  - We avoid using braces unnecessarily.  I.e.
 
 	if (bla) {
-- 
2.26.2.717.g5cccb0e1a8
