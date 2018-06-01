Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BDA1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbeFACqE (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:46:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54292 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFACqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:46:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so134769wmf.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b0rKimdauZ+SyhVQFaXyM1d7OE8lSkZ0Vjup/stUttk=;
        b=B/UfglooZCclK9FmcTTXfMPn5w0EOccMnqXB6xCslRiP3PgIeuyreJ2zdAUau/YmzV
         7UrkKjl4uw00k1Jt+2S2bW79avvXrRwT689bxO6GTGmsQZ9Qw/Gh7iz4sLL62+z3So8P
         G7KxEdpepI/9DyeS+zA2OpcHcSoF7vf9Fe+t2LHWPTaBmvF+OQ+zOLUtvEVi0EwsT283
         TbyoEMneaEYYTy1jwJnZ83snDlRrtDlWNT3YX96u+DAdDyt801BEDzps4we9U8zjcVHg
         pSQ5LM1B5RAJAwaFyuVMRKEy1vzhZiQEWuXElOWYmSpnFDu/u36pZcSnBIOjurXXxzCX
         g8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b0rKimdauZ+SyhVQFaXyM1d7OE8lSkZ0Vjup/stUttk=;
        b=nMTWXJBwAFG+Sx5BcWBjlV808WTueyP7Rn1vp0y2Mo7Pg4ymymc4cnq1NGIyPOylrc
         /3DmEx9lYE2R9+cgGcUl/50/lOi/J94omMymiK1WRrY27ZXo4fJqr5IsGfVDxjXfGePM
         Pc8h+gLnRhYPht+FpOUbcaawibW3OHdILUs25FUaQegtUA9+PFhihrHmcrnciws3uy5p
         USU3E5TfxXZY2RGrCf+wXZO7Splsjvco7xqkM1g6JaVd6BMNiEkLw/2BZGMgkwRf3G5t
         EvomqmzVUjWXphNHJKLREtvz4pdlqmpREorFtOAAIES0AiGzLylbDSXyl0VH0mLxSIht
         P5Iw==
X-Gm-Message-State: APt69E3VjbIgBNaPK4BOAAQ768ewy2ZtK4+AZZUtik64ea5/RwTKoUah
        e/P6JSFa8m7EwCo0zRWtfA0=
X-Google-Smtp-Source: ADUXVKLhYLpJzPv/cYAlklKenMfGDM0ZGY/mJxaTEGhiX7+zUulvt1mgbN/tbvuW/VIRpx30/GIi0g==
X-Received: by 2002:a1c:6503:: with SMTP id z3-v6mr1236200wmb.11.1527821162619;
        Thu, 31 May 2018 19:46:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b15-v6sm37079103wri.14.2018.05.31.19.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:46:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH 5/5] refspec.c: use rhs in parse_refspec instead of potentially uninitialized item->dst
References: <20180530170433.191495-1-sbeller@google.com>
        <xmqqzi0f9see.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 01 Jun 2018 11:46:01 +0900
In-Reply-To: <xmqqzi0f9see.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 01 Jun 2018 11:01:29 +0900")
Message-ID: <xmqq8t7z9qc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps a better fisx is to explicitly assign NULL to item->dst when
> we see there is no right-hand-side.

-- >8 --
Subject: [PATCH] refspec-api: avoid uninitialized field in refspec item

When parse_refspec() function was created at 3eec3700 ("refspec:
factor out parsing a single refspec", 2018-05-16) to take a caller
supplied piece of memory to fill parsed refspec_item, it forgot that
a refspec without colon must set item->dst to NULL to let the users
of refspec know that the result of the fetch does not get stored in
an ref on our side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The original before that change filled a callee prepared piece of
   memory that was obtained from xcalloc(), and did not need to
   explicitly assign NULL to the field after noticing that there is
   no colon in the refspec, so it is understandable how this
   misconvesion happened.

 refspec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refspec.c b/refspec.c
index 97e76e8b1d..6e45365a23 100644
--- a/refspec.c
+++ b/refspec.c
@@ -48,6 +48,8 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		size_t rlen = strlen(++rhs);
 		is_glob = (1 <= rlen && strchr(rhs, '*'));
 		item->dst = xstrndup(rhs, rlen);
+	} else {
+		item->dst = NULL;
 	}
 
 	llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
-- 
2.18.0-rc0

