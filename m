Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F5E1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeB0Wap (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:30:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39190 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeB0Wal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:30:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id i3so124168wmi.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r/r5MwPNpeFFDrhASpgNFUKxNKgHVp4CugCEV1elRU0=;
        b=nkqyufC3VctCa1tS8SuP2FfdF9ykX7z2Is3bitErYthoCOe5MejOYcVUgTkofnfL4J
         NiUx3Mtz1m1yZ9sdgng7nY723kS4wlrEKp1yjac2uIe3F4DTo6geIb5HmtK/Wbw5Xwzq
         mBhM8zjtaKu7gF6T3dLgxPBcquzKWTjk54U/0QPKXBnqNqIPS/dNFE7OhORmUY7l/h/y
         ed2bjPXNd0EXLEEe8zI9P49AkEUTMgiya8oFU9nLuF8XlwfILwtPA6WyXW8NVQIBYUk4
         yGDTEw3EytIyITI+gCOMO2aomLbzQiXRsB/gNn+XUtvROuB2RQS9Oef0NVcNQgZa4yIH
         N6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r/r5MwPNpeFFDrhASpgNFUKxNKgHVp4CugCEV1elRU0=;
        b=ShFbeXEzShFOgA99bZ1Xz8FQuLBeiDF2hlLOO+2hXJ/op+iKm8dQMvb0TA/8Rp9xGt
         oTklB3jG1oKplfBcQ0UEAiIJKNkSORV9ol6jiGQQWodZZUV99RcsbXdJQ68OJR3Uiqbm
         +bFyCTDsnNYLMSNQhPxOxii4k75LcnUlYgQ3GrkBaDJABVD7Rrj5Lqz7PhBEpCzWo1ry
         LZ6KtNPypR1Zh+dxiwjZonFef4Zu7uIPt3jl1ywLKxFBpIc4tYr1tfm0cPmpCMvS5027
         NyPQ06Bx1D9vIgHasDD8IgSzr+EZDyy8BhsokOdAX7SNilFMl/6wv88dl6wGC+hN/bl5
         9O4g==
X-Gm-Message-State: APf1xPBUQTwS2OBJ0eybc8ujNjBK5Un0vS5xgvAnW5tnLVGDhHo5iFdc
        bXhabXqX03bfLTYgikLhAGg=
X-Google-Smtp-Source: AG47ELuMVzuXpcvoda9jWtUIHuS5CY2SwadirYbRnDMb9hkZZCxA/vRLEvguHH+5xc5L9zJ91wOlWw==
X-Received: by 10.28.126.198 with SMTP id z189mr11431281wmc.135.1519770640418;
        Tue, 27 Feb 2018 14:30:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u79sm623833wma.10.2018.02.27.14.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 14:30:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2] sha1_name: fix uninitialized memory errors
References: <20180226204151.GA12598@sigill.intra.peff.net>
        <20180227114704.193145-1-dstolee@microsoft.com>
        <20180227213305.GB6899@sigill.intra.peff.net>
Date:   Tue, 27 Feb 2018 14:30:39 -0800
In-Reply-To: <20180227213305.GB6899@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 27 Feb 2018 16:33:05 -0500")
Message-ID: <xmqqsh9mnjzk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks, this looks good to me.
>
> Semi-related, I wondered also at the weird asymmetry in the if-else,
> ...
> So I think the code is right, but the comment is wrong.



-- >8 --
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 27 Feb 2018 06:47:04 -0500
Subject: [PATCH] sha1_name: fix uninitialized memory errors

During abbreviation checks, we navigate to the position within a
pack-index that an OID would be inserted and check surrounding OIDs
for the maximum matching prefix. This position may be beyond the
last position, because the given OID is lexicographically larger
than every OID in the pack. Then nth_packed_object_oid() does not
initialize "oid".

Use the return value of nth_packed_object_oid() to prevent these
errors.

Also the comment about checking near-by objects miscounts the
neighbours.  If we have a hit at "first", we check "first-1" and
"first+1" to make sure we have sufficiently long abbreviation not to
match either.  If we do not have a hit, "first" is the smallest
among the objects that are larger than what we want to name, so we
check that and "first-1" to make sure we have sufficiently long
abbreviation not to match either.  In either case, we only check up
to two near-by objects.

Reported-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 05a635911b..f1c3d37a6d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -542,20 +542,20 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	/*
 	 * first is now the position in the packfile where we would insert
 	 * mad->hash if it does not exist (or the position of mad->hash if
-	 * it does exist). Hence, we consider a maximum of three objects
+	 * it does exist). Hence, we consider a maximum of two objects
 	 * nearby for the abbreviation length.
 	 */
 	mad->init_len = 0;
 	if (!match) {
-		nth_packed_object_oid(&oid, p, first);
-		extend_abbrev_len(&oid, mad);
+		if (nth_packed_object_oid(&oid, p, first))
+			extend_abbrev_len(&oid, mad);
 	} else if (first < num - 1) {
-		nth_packed_object_oid(&oid, p, first + 1);
-		extend_abbrev_len(&oid, mad);
+		if (nth_packed_object_oid(&oid, p, first + 1))
+			extend_abbrev_len(&oid, mad);
 	}
 	if (first > 0) {
-		nth_packed_object_oid(&oid, p, first - 1);
-		extend_abbrev_len(&oid, mad);
+		if (nth_packed_object_oid(&oid, p, first - 1))
+			extend_abbrev_len(&oid, mad);
 	}
 	mad->init_len = mad->cur_len;
 }
-- 
2.16.2-325-g2fc74f41c5

