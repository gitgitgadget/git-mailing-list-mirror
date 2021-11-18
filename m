Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67961C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4204461260
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKRTNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:13:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53493 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKRTNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 14:13:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEB51E77AF;
        Thu, 18 Nov 2021 14:10:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iqxt/gG8pmsKyvPDrzbMRE7BtW+Oshp3vQwXQn
        uBF/M=; b=kEgMrlBr25eptstYp7/gbb0kC0EL3Vw3pwAR3JTUTK/0MyZkSHyM9C
        kdTEPKAVQONxsj/IYLqq51j/95eAJTJj6W7bCgE6NN6mQb8OP9SYbiKHy+yRIWFt
        lSMFpwj/koZ8k2bm3ChPDRJ9z7/hh4i7moPzio2rR18SCO/pBckg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FB07E77AE;
        Thu, 18 Nov 2021 14:10:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8640E77AD;
        Thu, 18 Nov 2021 14:10:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99 support
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
        <20211116021241.1565740-1-sandals@crustytoothpaste.net>
        <20211116021241.1565740-2-sandals@crustytoothpaste.net>
        <YZOh370ZMMqSADUE@coredump.intra.peff.net>
        <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
        <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
        <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
        <YZRwpekXlilhOEx4@coredump.intra.peff.net>
        <YZWNumAlsek9Gi22@camp.crustytoothpaste.net>
Date:   Thu, 18 Nov 2021 11:10:49 -0800
In-Reply-To: <YZWNumAlsek9Gi22@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 17 Nov 2021 23:18:18 +0000")
Message-ID: <xmqqy25lwa86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E9E2CCC-48A3-11EC-AD0D-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-11-17 at 03:01:57, Jeff King wrote:
>> Yes, but I'm not at all worried about breaking our CI. That's just a
>> patch away from fixing. I'm much more worried about confused users
>> building from source, because helping them is more difficult to scale.
>
> That's one of the reasons I had proposed the current patch, because it
> pukes in a very noticeable way with directives on where to look to
> continue.  Just using C99 features means that Git breaks in a very
> subtle way where the user compiling may not be familiar with C and may
> not know how to fix it otherwise.  For example, my previous employer
> ships Git, but many of the folks who are doing the package updates are
> not C programmers.

I wonder if this would work, then.

 Makefile   | 3 ++-
 revision.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git c/Makefile w/Makefile
index 201437e9d4..454118d86b 100644
--- c/Makefile
+++ w/Makefile
@@ -1218,7 +1218,8 @@ endif
 # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
 # tweaked by config.* below as well as the command-line, both of
 # which'll override these defaults.
-CFLAGS = -g -O2 -Wall -std=gnu99
+# Older versions of GCC may require adding "-std=gnu99" at the end.
+CFLAGS = -g -O2 -Wall
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
 BASIC_CFLAGS = -I.
diff --git c/revision.c w/revision.c
index 78c1ceea7b..5390a479b3 100644
--- c/revision.c
+++ w/revision.c
@@ -49,7 +49,8 @@ void show_object_with_name(FILE *out, struct object *obj, const char *name)
 	 * This "for (const char *p = ..." is made as a first step towards
 	 * making use of such declarations elsewhere in our codebase.  If
 	 * it causes compilation problems on your platform, please report
-	 * it to the Git mailing list at git@vger.kernel.org.
+	 * it to the Git mailing list at git@vger.kernel.org. In the meantime,
+	 * adding -std=gnu99 to CFLAGS may help if you are with older GCC.
 	 */
 	for (const char *p = name; *p && *p != '\n'; p++)
 		fputc(*p, out);
