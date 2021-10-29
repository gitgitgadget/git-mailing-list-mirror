Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9C3C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F27760C51
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2Uye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:54:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52070 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJ2Uyd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:54:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC647FC49D;
        Fri, 29 Oct 2021 16:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zIN045TdVUJxO1Zz9QSbq5Q3AISpRivsHZZ3v6
        v7aGY=; b=UTH+obzVo4DHq/U4KTHCHOo2LDHFt5BG8DfMTQfI0L+4M0bR3sQwTP
        SOIQFENL2/FuMYUo3cQkUbd+4YCmwN9SkLf2e3m6sA6B8tn87iJiIH6XmLY5nFVC
        24MWYPsz5d/AYCGEgyvmre/R6ZuIB+mgShQS3qb0Jmw8P0UbNrKTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3003FC49C;
        Fri, 29 Oct 2021 16:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39BA0FC49B;
        Fri, 29 Oct 2021 16:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
        <xmqqeeahjxj4.fsf@gitster.g>
        <YSkvNyR4uT52de13@coredump.intra.peff.net>
        <87ily7m1mv.fsf@evledraar.gmail.com>
        <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
        <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
        <871r4umfnm.fsf@evledraar.gmail.com>
        <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
        <211029.86bl38w124.gmgdl@evledraar.gmail.com>
        <YXxcIQQS7GQzRwUa@coredump.intra.peff.net>
        <xmqqk0hvk1bc.fsf@gitster.g>
Date:   Fri, 29 Oct 2021 13:52:02 -0700
In-Reply-To: <xmqqk0hvk1bc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        29 Oct 2021 13:45:11 -0700")
Message-ID: <xmqqee83k0zx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11C1D9F0-38FA-11EC-B087-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> TBH I am not even sure it is worth spending a lot of brain cells on the
>> "and then consider..." part. Over all these years, we've had one report,
>> and it simply misunderstand what "--encoding" was for. I thought it was
>> something we could fix up easily by checking a return value, but IMHO
>> doing it right is quite tricky because of iconv()'s limited interface,
>> and the risk of regression outweighs the potential benefit.
>
> I tend to agree with the above.  Let's not over-engineer things.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 29 Oct 2021 13:48:58 -0700
Subject: [PATCH] Revert "logmsg_reencode(): warn when iconv() fails"

This reverts commit fd680bc5 (logmsg_reencode(): warn when iconv()
fails, 2021-08-27).  Throwing a warning for each and every commit
that gets reencoded, without allowing a way to squelch, would make
it unpleasant for folks who have to deal with an ancient part of the
history in an old project that used wrong encoding in the commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-options.txt | 4 +---
 pretty.c                         | 6 +-----
 t/t4210-log-i18n.sh              | 7 -------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index b3af850608..54d8bb3db0 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -40,9 +40,7 @@ people using 80-column terminals.
 	defaults to UTF-8. Note that if an object claims to be encoded
 	in `X` and we are outputting in `X`, we will output the object
 	verbatim; this means that invalid sequences in the original
-	commit may be copied to the output. Likewise, if iconv(3) fails
-	to convert the commit, we will output the original object
-	verbatim, along with a warning.
+	commit may be copied to the output.
 
 --expand-tabs=<n>::
 --expand-tabs::
diff --git a/pretty.c b/pretty.c
index 73b5ead509..9631529c10 100644
--- a/pretty.c
+++ b/pretty.c
@@ -671,11 +671,7 @@ const char *repo_logmsg_reencode(struct repository *r,
 	 * If the re-encoding failed, out might be NULL here; in that
 	 * case we just return the commit message verbatim.
 	 */
-	if (!out) {
-		warning("unable to reencode commit to '%s'", output_encoding);
-		return msg;
-	}
-	return out;
+	return out ? out : msg;
 }
 
 static int mailmap_name(const char **email, size_t *email_len,
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 0141f36e33..d2dfcf164e 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -131,11 +131,4 @@ do
 	fi
 done
 
-test_expect_success 'log shows warning when conversion fails' '
-	enc=this-encoding-does-not-exist &&
-	git log -1 --encoding=$enc 2>err &&
-	echo "warning: unable to reencode commit to ${SQ}${enc}${SQ}" >expect &&
-	test_cmp expect err
-'
-
 test_done
-- 
2.33.1-1007-g607b33ccc6

