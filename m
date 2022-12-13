Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A1C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 19:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiLMTfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiLMTfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 14:35:15 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C540AB868
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 11:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670960108; bh=XKtCzFK4RKNHhDz77sbi0Iw+ZuS/7uN6bPpEb+AopMk=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=PT/0IsQWm/movSnoVSqaVTd92SlYwWHy1evf7tufV6JF54+gcFUZZ+qbpi7kHLVyQ
         Zm3h/0p97pPXHZX2IyNEbll7giV39nEF6mY7ZeZ5MGi/RRFeqjPoYzDb8cLVgAo1+N
         fYE/CLeuAso+QddxyDvnphBRG6dacobN45BviY7noZbG28u41Oed8m/cRArrDL+BjE
         S6BrhSevLKGTNgd6xTsJwkQS80GySPkMYmeI908dsQiA29IoW6X0kJyr35yV4WtagA
         /Fyh06GJNeMeMuZqxDG6wkBnF5M41jlklGqS+8MwXgmr5Us07dhsCLMW0zql5I7fFh
         7BuOo5OsWGFSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1oyZLo0Yhc-006tEe; Tue, 13
 Dec 2022 20:35:08 +0100
Message-ID: <94dff140-489c-40b2-7212-201ed3b7d008@web.de>
Date:   Tue, 13 Dec 2022 20:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] object-file: inline write_buffer()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wcvOpCe3RW7GJPsQGcJVdDsQJzLOyr0LDFvuLF8A4iexKTWWYMZ
 v9rxsbRQc3vLkKSKiA8HJe4nOq5vj24deeP8V3YNkSfJyQVDJ4RBINEB0DdVAPRqdosiqHe
 2/y9/CZtjRUxsWL6pMDEPmMaXjp96l9AAeFaN1RFSka3eo4SB8LlmX/zMW5R+d4QVHXSnvr
 JBkxENQrJy/kUbq+syYQQ==
UI-OutboundReport: notjunk:1;M01:P0:Y1ZUWscnvpo=;DFkVRALRPPlV/4qbIyaHKvLJPtx
 uuygfDGL5kRm7DZE5obGAlZy3SabGHmeu3I+QDF3HUvRmCq+72lf7Q/xbA3pkSCdJWe2jbtis
 fwy9UhSlGkohOZ1HOkDtW5cujUBTOx6nudUzAHKBS/hhaGItkt3YLBw8DkmJH/SmG8SzVnDvk
 /92/oOq3hJBhAW/0pZ0QkS8NggdNWd7bh9NYb57GGmUmtshDBycqd3o8DyK7i8LODHC9K6NE4
 jpdE24vuM85DSYqn4ZI+sdVNSmGrT52/B7S6KBorQP/8bgbsrDmJw6p52v0e6Yzf3ByoAPuZP
 OK4b+veJ5hUvHvbGYtvbjIgrCmAjgCKuQEJYO1mZojEnuJUtNE3Tq2/YATZooc4EVklA22i19
 2m6XL3JSw06ex5XyBOYinQqdyHsaIld9dGJ8yQ7EEswBBC2GLTFQPNwMZJy0oJU71fA4lnd9z
 10LTNIeTyAlEHgAbMfRThVsHevY2aGKKi5uP9uvH0yEztPFJW6XIVXvkh4fzNwMHeUy8OPLj0
 KRTpt88y4pyPl2Ch7YwH0tpuLijbp3pN5Zvr1GGLav3SQhXw0UVbwccSJU7ehDfY87g0rjYXi
 rm97WKuvLHa/M1mgvXAmzJpMoythPdXU0qvm/aYvN+ab5eOz5TGOSowY+Nx3ZXg7KJdc/tn5R
 e7fAwoNOv+rftNJnksImi4ox608GvdItjjpR7Ja0wONLPHzy/xUnkMI3xoZHP8qBAetyQaZdB
 aTpQS4kQMkcuteKisIQaj1vb5tDfO3BYKwndPKSvaKeL7k7WmGPZjSKSZunEru+JkIRn9UIQw
 GRQMmgnv8G/GGIWIUM0WR0ddrAEzmPhottkYNX1GsESDl3Co7/VEbvKj/Ly4CEOrP3VdnQ9HF
 10obykP6z2WxC+Tpkor7gOoJ63e/X1uWdIlXIbk6qgvfgE0sIMsANYh3fPpiLMOMJZBnGzclt
 zacvFQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_buffer() reports the OS error if it is unable to write.  Its only
caller dies in that case, giving some more context in its last message.

Inline this function and show only a single error message that includes
both the context (writing a loose object file) and the OS error.  This
shortens the code and simplifies the output.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object-file.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/object-file.c b/object-file.c
index 26290554bb..c1b71c2834 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -1864,13 +1864,6 @@ int finalize_object_file(const char *tmpfile, const=
 char *filename)
 	return 0;
 }

-static int write_buffer(int fd, const void *buf, size_t len)
-{
-	if (write_in_full(fd, buf, len) < 0)
-		return error_errno(_("file write error"));
-	return 0;
-}
-
 static void hash_object_file_literally(const struct git_hash_algo *algo,
 				       const void *buf, unsigned long len,
 				       const char *type, struct object_id *oid)
@@ -2015,8 +2008,8 @@ static int write_loose_object_common(git_hash_ctx *c=
,

 	ret =3D git_deflate(stream, flush ? Z_FINISH : 0);
 	the_hash_algo->update_fn(c, in0, stream->next_in - in0);
-	if (write_buffer(fd, compressed, stream->next_out - compressed) < 0)
-		die(_("unable to write loose object file"));
+	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
+		die_errno(_("unable to write loose object file"));
 	stream->next_out =3D compressed;
 	stream->avail_out =3D compressed_len;

=2D-
2.39.0
