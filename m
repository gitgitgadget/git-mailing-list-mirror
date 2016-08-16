Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D611F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbcHPUfv (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:35:51 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34387 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbcHPUft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:35:49 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so5775883pac.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 13:35:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=h0tGQ1aKznR53tn7VUoNaittBgSORWjddGf4r8XPHGw=;
        b=wOrKMtKsiK78MW0ENbIa0yScxEDjAuxPxX6KLpxAnbvgAeua9fWoz+Enyq1ksKxMSn
         vsYdHb731YvesZwv4BDx/U9m6irjS3Os1rEiDegV+wLdPW8PYOjpBLNPBEwg9jvASy/j
         c/Vjrj4HD2dML7R6UDzoTQU0llp40NJUaFRL3D6EAr+ofd/VJV61rc4P1ekyVGrHID4B
         +dTv2/C6AXf74bgP1Recnd1pk7K+q6oWtER0y3gjI6JzQ3zW+dWiE1k6ygudWSTKKbEP
         hIr8Djc2kbh/Zrjai8TvUjHLCEVSHjYA7qYKnP3YPhRQ9rGAXhLS9RYVutqzhwol1vGh
         dUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=h0tGQ1aKznR53tn7VUoNaittBgSORWjddGf4r8XPHGw=;
        b=cyfvr4OrFueuX96ApdEi2VZJ/srbBVWRqQy5XygafCHAkuhamMEnnkR+QFnTuAOum9
         xYCfjjPL9pn6jWzvjKIlfiEvFE/bw+7fqOayFVFsywW6RQ9BzylS72NxATyZ7t8+zeEC
         LjsUAzCHJKPh8nuO4p9kowX90V21TvkiKvRX4rg3xqa6LhViRG3tU8PaQlpfgTjulujT
         EXsoZxT8vS63qadPJk9x1lFNt4lFKUgluySR9lAXueV0MloROnWx3lJiwBVYy+Z/ldQD
         ifRnuQoQi4dqiVhiRcmvgb2SgJqwjd28COHLIGC7KK/De5NvllSkAEzy5SGYPCxf9lJx
         F+Bw==
X-Gm-Message-State: AEkoouuygWJshndiFtIxdsFj4Bq9GpwcR5NNfp6kwn/Jsg33mNDdnW3bI3L9hR19PTK1SA==
X-Received: by 10.66.72.40 with SMTP id a8mr10977992pav.15.1471379748383;
        Tue, 16 Aug 2016 13:35:48 -0700 (PDT)
Received: from i7 (c-67-168-201-187.hsd1.or.comcast.net. [67.168.201.187])
        by smtp.gmail.com with ESMTPSA id dz13sm41520481pac.44.2016.08.16.13.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2016 13:35:46 -0700 (PDT)
Date:	Tue, 16 Aug 2016 13:35:46 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7
To:	Junio C Hamano <gitster@pobox.com>
cc:	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Prefer "long" key format output when verifying pgp
 signatures
Message-ID: <alpine.LFD.2.20.1608161309350.14878@i7>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Aug 2016 13:10:24 -0700
Subject: [PATCH] Prefer "long" key format output when verifying pgp signatures

Yes, gpg2 already uses the long format by default, but most
distributions seem to still have "gpg" be the older 1.x version due to
compatibility reasons.  And older versions of gpg only show the 32-bit
short ID, which is quite insecure.

This doesn't actually matter for the _verification_ itself: if the
verification passes, the pgp signature is good.  But if you don't
actually have the key yet, and want to fetch it, or you want to check
exactly which key was used for verification and want to check it, we
should specify the key with more precision.

In fact, we should preferentially specify the whole key fingerprint, but 
gpg doesn't actually support that.  Which is really quite sad.

Showing the "long" format improves things to at least show 64 bits of
the fingerprint.  That's a lot better, even if it's not perfect.

This change the log format for "git log --show-signature" from

    commit 2376d31787760af598db23bb3982a57419854e5c
    merged tag 'v2.9.3'
    gpg: Signature made Fri 12 Aug 2016 09:17:59 AM PDT using RSA key ID 96AFE6CB
    gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
    gpg:                 aka "Junio C Hamano <jch@google.com>"
    gpg:                 aka "Junio C Hamano <junio@pobox.com>"
    Merge: 2807cd7b25af e0c1ceafc5be
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Fri Aug 12 10:02:18 2016 -0700

to

    commit 2376d31787760af598db23bb3982a57419854e5c
    merged tag 'v2.9.3'
    gpg: Signature made Fri 12 Aug 2016 09:17:59 AM PDT
    gpg:                using RSA key B0B5E88696AFE6CB
    gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
    gpg:                 aka "Junio C Hamano <jch@google.com>"
    gpg:                 aka "Junio C Hamano <junio@pobox.com>"
    Merge: 2807cd7b25af e0c1ceafc5be
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Fri Aug 12 10:02:18 2016 -0700

(note the longer key ID, but also the reflowing of the text) and also 
changes the format in the merge messages when merging a signed 
tag.

If you already use gpg2 (either because it's installed by default, or 
because you have set your gpg_program configuration to point to gpg2), 
that already used the long format, you'll also see a change: it will now 
have the same formatting as gpg 1.x, and the verification string looks 
something like

    gpg: Signature made Sun 24 Jul 2016 12:24:02 PM PDT
    gpg:                using RSA key 79BE3E4300411886
    gpg: Good signature from "Linus Torvalds <torvalds@linux-foundation.org>" [ultimate]

where it used to be on one line:

    gpg: Signature made Sun 24 Jul 2016 12:24:02 PM PDT using RSA key ID 79BE3E4300411886
    gpg: Good signature from "Linus Torvalds <torvalds@linux-foundation.org>" [ultimate]

so there is certainly a chance this could break some automated scripting.  
But the 32-bit key ID's really are broken. Also note that because of the 
differences between gpg-1.x and gpg-2.x, hopefully any scripted key ID 
parsing code (if such code exists) is already flexible enough to not care.

This was triggered by the fact that the "evil32" project keys ended up
leaking to the public key servers, so now there are 32-bit aliases for
just about every open source developer that you can easily get by
mistake if you use the 32-bit short ID format.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

That's a very long commit message for a very trivial patch.

I'm not particularly happy with the 64-bit long format either, but it's 
better than what we have now, and appears to be as good as it gets.

 gpg-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 08356f92e7b3..8672edaf4823 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -217,6 +217,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
 			 "--status-fd=1",
+			 "--keyid-format=long",
 			 "--verify", temp.filename.buf, "-",
 			 NULL);
 
-- 
2.10.0.rc0.dirty

