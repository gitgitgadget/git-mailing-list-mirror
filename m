Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F91C61DA3
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 23:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjCCXOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjCCXOS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 18:14:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E06C65A
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 15:14:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id bd34so2555167pfb.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 15:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T2RZs5SZJNHdEHY+VJZU7pMCPrYx/C70T0z92Bm5cI=;
        b=KpSuYCZCYq0AXi5f32cK5Q37Jv1ONny8EDB8obkO3w469E5WWMDjJ45jU3rx9ICVCk
         wcTUfAyfU41jfZ8zmkoEtSU8Hesiy35FF7ANGseRblnuJ9EfgCjVv6IzOCDYy3OTLpNy
         8kjko6zi1vq/wXo2cPYFIAZR1KU1VXZFsIE7WgsVVOTFigIciIk0sDAUakKZXgRpWGNj
         sO5npr57GnyYgZdgIN4eJ4KSR1zbI/cKDZFNOxt/BnizzobFpbjRLg0pT1Yju153mfet
         G2dyFDP1PQp3c4G4eCZmk53GZICcwODJ0VbecPSjGXCG1tx4mzIqUOEuLpjNsikg+B/z
         n64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0T2RZs5SZJNHdEHY+VJZU7pMCPrYx/C70T0z92Bm5cI=;
        b=eL1UbMBTjdQTDCHjjHIT9hN5WfiUKWtOHsCFnH8UR/RlzuLa3qWmjljfbbP7Hxfhkr
         5IFryoPM+U1QN6ESu8fqeUTlWMnPGhYQ04KqCGxJrKRkUET4Xbbgz5Yj42twZutIQ5Jx
         KwcXXqFHXese6FeSYcyIZ8T7W/mEmh2snpA4olh58Sfx7Zwu8pNzWvUzdEOe0IxYPCwk
         6sv3k48BjQ1Qr8NbK9Dvd6C8DFfBWMr4bnMXs3LS1y1kFZMglwj38lGV7AZBws5eqD5H
         hEBNNhe/a9RsXulyoHCWEwauuEIwMOixkBjwqYUmTuvGx/lozV23zfQ8yqbNSetWUhe6
         BnXw==
X-Gm-Message-State: AO0yUKUV07hF66lpDMSWMwCr1PPstSokNsXZKN5XkTJPGOXIopjT+HnA
        D+XuYE41YO62xY5EEitdibR3HLaOy64=
X-Google-Smtp-Source: AK7set/1kfqhMUwaOsWnKpDtBcmxpOzNtF9I36TYvl38OmjEZssrYIj+RS/DmhExf6OEcJ5qyJR3ew==
X-Received: by 2002:aa7:98de:0:b0:5df:3aa1:10c5 with SMTP id e30-20020aa798de000000b005df3aa110c5mr3601097pfm.14.1677885257111;
        Fri, 03 Mar 2023 15:14:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78059000000b005d503abc8fesm2091634pfm.218.2023.03.03.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 15:14:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 1/2] cat-file: extract printing batch error message
 into function
References: <20230116190749.4141516-1-toon@iotcl.com>
        <20230303191708.77894-1-toon@iotcl.com>
        <20230303191708.77894-2-toon@iotcl.com> <xmqqcz5peg3v.fsf@gitster.g>
Date:   Fri, 03 Mar 2023 15:14:16 -0800
In-Reply-To: <xmqqcz5peg3v.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        03 Mar 2023 12:26:28 -0800")
Message-ID: <xmqqilfhctrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As batch_object_cb() makes a call to batch_object_write() with
> obj_name set to NULL, I do not think this change is defensible,
> though.

This indeed seems to break t5313 when queued on top of 'master'; it
tries to run "git cat-file --batch-all-objects --batch-check" and
hits the exact codepath where a missing object is sent to the error
codepath without obj_name set to anything.

I guess we now have an existing test that you can mimic that
exhibits "missing" error?  I do not know offhand if this test
already qualifies as the test coverage Phillip wanted to make sure
exists.

..... >8 .......... >8 .......... >8 .......... >8 .......... >8 .....

expecting success of 5313.3 'pack/index object count mismatch': 
	do_pack $object &&
	munge $pack 8 "\377\0\0\0" &&
	clear_base &&

	# We enumerate the objects from the completely-fine
	# .idx, but notice later that the .pack is bogus
	# and fail to show any data.
	echo "$object missing" >expect &&
	git cat-file --batch-all-objects --batch-check >actual &&
	test_cmp expect actual &&

	# ...and here fail to load the object (without segfaulting),
	# but fallback to a good copy if available.
	test_must_fail git cat-file blob $object &&
	restore_base &&
	git cat-file blob $object >actual &&
	test_cmp file actual &&

	# ...and make sure that index-pack --verify, which has its
	# own reading routines, does not segfault.
	test_must_fail git index-pack --verify $pack

4+0 records in
4+0 records out
4 bytes copied, 0.000119221 s, 33.6 kB/s
error: packfile .git/objects/pack/pack-67be769e2843d598c78218852612520795998892.pack claims to have 4278190080 objects while index indicates 1 objects
error: packfile .git/objects/pack/pack-67be769e2843d598c78218852612520795998892.pack claims to have 4278190080 objects while index indicates 1 objects
--- expect	2023-03-03 23:11:37.504011940 +0000
+++ actual	2023-03-03 23:11:37.508012250 +0000
@@ -1 +1 @@
-fff0a2476aa5c8e60a3ef21cfc66e0cc670920be missing
+(null) missing
not ok 3 - pack/index object count mismatch
