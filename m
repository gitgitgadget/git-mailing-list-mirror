Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7D5201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934986AbdBQVRJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:17:09 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36418 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934861AbdBQVRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:17:08 -0500
Received: by mail-pg0-f67.google.com with SMTP id a123so3019641pgc.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=00TFnhc/8JBK7nVAB7ilO6APxs3eiy3+Y6D/0g0R6C0=;
        b=M7wyVS8RJqH7pe+MPDwrjeuSu0nFBinzfxoVeLBGPOTDjowr/LZ6X2vzgmEGYFOM1D
         whcNGbxL5BKhHkkNn2xeGs8C8NC7/vvXW2ICbFKp0vpNxa3qeYzDw3kz6I67fbLMvPXu
         l6+N8QfNUiXLr1JKHtUhSN8SMQ43EPGvKpNjkNux76GuE72gb2XU/M1PZRh4eI7j5wSm
         rgFvHT6IHjNBLDLFJ1R63ZYPtsV2oUU8MUks5WuB3G8gfifZoX6A0ter1Z51s/2vaFdq
         /ayqlGomh465Phx3m3E4TchzLUXRu7XbFO3r9bZiuREIHiliJ9n7BEmvNpL0PJRlW72T
         jSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=00TFnhc/8JBK7nVAB7ilO6APxs3eiy3+Y6D/0g0R6C0=;
        b=LCdKtoQHC5q9ecW73cAhoDY2jD180C+M1A73OEsf7ii2IcYYpuopZfDA1h6NpFImf3
         61sXspnEO5PDnh+Jr6sOzvkqew8Y/spsKxZ3Tfkg1Ycfy7HfYVY/kOXxLxBRMSPUH3Lb
         ipn4oY/g65taCOQrVAnltCrDWvshKVxB6fr7noB/PdB1BhYTEBKKlYaOENakct7e8SZP
         +dyGnrsnUHFZhdCF3NU6In7I0H6zkF1Y1vDZSaObwmYA8wJtAX+o0zR3fQ//DXPOnPQF
         715efgqrKtKlA4T7Xr+RGEXV9BRMf1SW+ehameJIM0UlzlCaNkZpcOk/0XadtoUez6Hg
         NRMA==
X-Gm-Message-State: AMke39mouvJADvsp2ZfoFF44MVmyxCAcBVgAd45vUHdzKvzuRQgIezvPVN9mVzk9JSdsYg==
X-Received: by 10.84.160.197 with SMTP id v5mr13999103plg.161.1487366227552;
        Fri, 17 Feb 2017 13:17:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id n28sm21479733pgd.5.2017.02.17.13.17.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 13:17:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
References: <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
        <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
        <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
        <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
        <87tw7uv439.fsf@linux-m68k.org>
        <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
        <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
        <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
        <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
        <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
        <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 13:17:06 -0800
In-Reply-To: <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 15:54:42 -0500")
Message-ID: <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 17, 2017 at 11:42:25AM +0100, Michael Haggerty wrote:
>
>> On 02/17/2017 09:07 AM, Jeff King wrote:
>> > [...]
>> > That's similar to what I wrote earlier, but if we don't mind overwriting
>> > errno unconditionally, I think just:
>> > 
>> >   errno = EIO; /* covers ferror(), overwritten by failing fclose() */
>> >   err |= ferror(fp);
>> >   err |= fclose(fp);
>> > 
>> > does the same thing.
>> 
>> True; I'd forgotten the convention that non-failing functions are
>> allowed to change errno. Your solution is obviously simpler and faster.
>
> I guess we are simultaneously assuming that it is OK to munge errno on
> success in our function, but that fclose() will not do so. Which seems a
> bit hypocritical. Maybe the "if" dance is better.

Yes.  When both ferror() and fclose() are successful, we would
prefer to see the original errno unmolested, so the "if" dance,
even though it looks uglier, is better.  The ugliness is limited
to the implementation anyway ;-)

But it does look ugly, especially when nested inside the existing
code like so.

Stepping back a bit, would this be really needed?  Even if the ferror()
does not update errno, the original stdio operation that failed
would have, no?

-- >8 --
Subject: close_tempfile(): set errno when ferror() notices a previous error

In close_tempfile(), we may notice that previous stdio operations
failed when we inspect ferror(tempfile->fp).  As ferror() does not
set errno, and the caller of close_tempfile(), since it encountered
and ignored the original error, is likely to have called other
system library functions to cause errno to be modified, the caller
cannot really tell anything meaningful by looking at errno after we
return an error from here.  

Set errno to an arbitrary value EIO when ferror() sees an error but
fclose() succeeds.  If fclose() fails, we just let the caller see
errno from that failure.

---
 tempfile.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index ffcc272375..d2c6de83a9 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -247,8 +247,20 @@ int close_tempfile(struct tempfile *tempfile)
 	tempfile->fd = -1;
 	if (fp) {
 		tempfile->fp = NULL;
-		err = ferror(fp);
-		err |= fclose(fp);
+		if (ferror(fp)) {
+			err = -1;
+			if (!fclose(fp))
+				/*
+				 * There was some error detected by ferror()
+				 * but it is likely that the true errno has
+				 * long gone.  Leave something generic to make
+				 * it clear that the caller cannot rely on errno
+				 * at this point.
+				 */
+				errno = EIO;
+		} else {
+			err = fclose(fp);
+		}
 	} else {
 		err = close(fd);
 	}
