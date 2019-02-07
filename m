Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD09F1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 02:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBGCxy (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 21:53:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33482 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfBGCxy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 21:53:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id a16so9896928wrv.0
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 18:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fGTa3133GKJpU49EM44JtcgK5Rsq6kyZHztv9HfGYWI=;
        b=QIJomqzdXyFU6XydJE+lnD2Ui1G0yrWkymcZ2zH1FBJL4W8ONMLIZLFLW0SdT/cUBG
         vsTyCe+yLltPSl2Whv+3a9oAc8+Q40/NGmnRJRvLi9l5w00O2R1keEUvqWTWsWPRrlYr
         Qfi929/Uln5I4EJC4rspxv5Pe0lzQHp1wo8DwKUQ+dZXHXfK4inOY7jYhchLX/7bJbar
         Rsw1lRVxTCICq55pfopVV4qk9hgX2sJZ0oMwfaEVAy4j0gJWdpLJiBsgnzhEp2ItPfOQ
         NWZ3d8FwtWvBATYGdSRcgbhHSJYIdE7ED2upcVtqDEt2+9yLTYbkPM3IU5oZmE5ysd7D
         ob+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fGTa3133GKJpU49EM44JtcgK5Rsq6kyZHztv9HfGYWI=;
        b=L1Djc+fi1mSs9HBi1gmnUqUbSIRaDljeU+bchzyv79DjyBB0OeeYkdJyb2CkShQi4d
         V1ItXZhgc61XzIvO5FZRmyBZdE8iKA8+nKYsmdAo7OQ3YrGyHjPP6gajBPGX/aDBtTQG
         6Sv8jaErBxx1eONPbHXGykk2nx4FqZjZ/bUac/trM+K4CPrJygkP/RCBvrKnJFDCorWz
         aQXuGJZ3kBN6opwi13wTMogFFZ2vCI5qbCgIhpC7RCnGDGXoG/VCm05Hqifju6ybI0cV
         xAWbPwA2XcLWWDxUQYz/otfON0aSQ7iffLmOPX+coPW8/bznkciHBVc4GbJOHldW+jRn
         aKRw==
X-Gm-Message-State: AHQUAuaFKpOwiMIEzkjm5ooifDtxoRqZb9+0pBGToZCKn76A389n+kkz
        vigFr3dod3kb4yq0pSfpUHM=
X-Google-Smtp-Source: AHgI3Ib01i579OpDXrdngrMHN+SUqGxPEbG3auSZC5UZX/WpDlXdeqHZH5CqFMeL8dmt8b42VURrbg==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr4249164wru.119.1549508032076;
        Wed, 06 Feb 2019 18:53:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12sm39145544wro.18.2019.02.06.18.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 18:53:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] fetch-pack: clear alternate shallow when complete
References: <20190204000650.686175-1-sandals@crustytoothpaste.net>
        <20190206235937.201663-1-sandals@crustytoothpaste.net>
        <CACsJy8Ae0ZZjh8+f+TwbfJ-V9SzrHpDFyfjwScwKJj+kc7FDTQ@mail.gmail.com>
        <xmqq4l9gs49w.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 06 Feb 2019 18:53:50 -0800
In-Reply-To: <xmqq4l9gs49w.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 Feb 2019 18:47:55 -0800")
Message-ID: <xmqqzhr8qpfl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> The patch looks good to me.
>
> Thanks, all.

Oops, spoke a bit too fast.  As the previous one is already in
'next', let's do this instead.

-- >8 --
From: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Wed, 6 Feb 2019 23:59:37 +0000
Subject: [PATCH] fetch-pack: clear alternate shallow in one more place

The previous one did not clear the variable in one codepath,
but we should aim to be complete.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
[jc: made a reroll into incremental, as the previous one already is
 in the next branch]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 2d76287674..a92621a388 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1272,6 +1272,8 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 		args->deepen = 1;
+	} else {
+		alternate_shallow_file = NULL;
 	}
 }
 
-- 
2.20.1-519-g8feddda32c

