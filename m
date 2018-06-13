Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8181F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935355AbeFMSiR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:38:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45391 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935322AbeFMSiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 14:38:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so3768673wrm.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K6jgLwPVwNBNuYuvQFwBa2mjJUL8/LVtpyyBcxV33zM=;
        b=gjSTXHgHZJ0NOEq+9CJh1EsjX3ErIyUbW+r81FPJDHNUIfMf1tNd9tyX65XohUwXsU
         13BwHGC+KN3rUSe3VnkU0ndEDPUWOqfM48I8LrVK5NNSwJPErH98C3UhZQzlRkcw51J+
         bw6vnefWkdedrFd22QBLfqqpPf+bWi8LzjuEKIay4kWkcmiKvZEBbe6LINTLPfq0AZMj
         cWIN8GnFh+6bMLK0RRjBmNczvX8H4nKXJPpH0FVdbF2I8mDItPgw9w298BPBVhnyli0N
         7FZubp+F+lSd+d+ov3FBwZRTBAEIhO6332MKQ/RUJSGZQydcCdU3Ex428KJWWAv8Lkp9
         kWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K6jgLwPVwNBNuYuvQFwBa2mjJUL8/LVtpyyBcxV33zM=;
        b=eY3bZ09vc9sBcJ8+G5WaHVU7++lVoiFWFtAjPylGDi2kmZM2ZoVYVK8SziP7NsLbzv
         RUeN/heIK8CfVved6/LTDhDK+QzQoa4B11z4QH6mGdK0k3jNGYRD3MpU8FjL2GGNJizx
         hTnwOQMW2t+e8HdsF4RtWV1WSjrO5J3Z5/C6CltBDRgEUOJ6Ev2GHILQr7kqAs2YNg2+
         6htL6XXeRM44o2lnlI83i9ru4UxDq5Lx1kvtW7RnRgg5tG5Fm0ElaKEWycyrKkiIFCTm
         q57RqSqGK5brUkxA+XQp6jtJZofk+XoPDZMk8myWGiKdKPkUg9xvmvze42gJBFJq7SP4
         C9+g==
X-Gm-Message-State: APt69E2wwAmeOT3TPPP2dtDsGXKtsCTvvFwwslNMoY3UaNKfJDQ27Akp
        2C3uaFDMhD0hIjcaIv+x0ew=
X-Google-Smtp-Source: ADUXVKKATS97CyZi1d5Ucf/vDkIzbX9xqO+sT7vMSEVeqgF0LNha9S2egfTI523f8ScJGTq0SHDmfw==
X-Received: by 2002:adf:b782:: with SMTP id s2-v6mr4851995wre.247.1528915095175;
        Wed, 13 Jun 2018 11:38:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a14-v6sm2150200wmb.44.2018.06.13.11.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 11:38:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] packfile: Correct zlib buffer handling
References: <20180613142207.14385-1-lintonrjeremy@gmail.com>
        <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com>
Date:   Wed, 13 Jun 2018 11:38:13 -0700
In-Reply-To: <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 13 Jun 2018 13:21:03 -0400")
Message-ID: <xmqqtvq65y7e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       buffer[size] = 0; /* assure that the buffer is still terminated */
>
> I think we normally use '\0' for NUL on this project rather than simply 0.
>
> The comment is also effectively pure noise since it merely repeats
> what the code already states clearly (especially when the code says
> "buffer[size] = '\0';"), so dropping the comment altogether would be
> reasonable.

Actually, I'd prefer to have comment there, but not about "what this
line does" (which is useless, as you pointed out) but about "why do
we do this seemingly redundant clearing".

Here is what I tentatively came up with.

-- >8 --
From: Jeremy Linton <lintonrjeremy@gmail.com>
Date: Wed, 13 Jun 2018 09:22:07 -0500
Subject: [PATCH] packfile: correct zlib buffer handling

The buffer being passed to zlib includes a NUL terminator that git
needs to keep in place. unpack_compressed_entry() attempts to detect
the case that the source buffer hasn't been fully consumed by
checking to see if the destination buffer has been over consumed.

This causes a problem, that more recent zlib patches have been
poisoning the unconsumed portions of the buffer which overwrites
the NUL byte, while correctly returning length and status.

Let's place the NUL at the end of the buffer after inflate returns
to assure that it doesn't result in problems for git even if its
been overwritten by zlib.

Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/packfile.c b/packfile.c
index 4a5fe7ab18..d555699217 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1422,6 +1422,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		return NULL;
 	}
 
+	/* versions of zlib can clobber unconsumed portion of outbuf */
+	buffer[size] = '\0';
+
 	return buffer;
 }
 
-- 
2.18.0-rc1-1-g6f333ff2fb

