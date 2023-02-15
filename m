Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E9DC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBOTKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 14:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBOTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 14:10:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8142A6F7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 11:10:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2850807pjp.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 11:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI9HIepa5MquqaVEzYGCum2D6XyRxWJVDYaQg9Z1s+c=;
        b=o1KXd/wPXn4MWhax7YXPP9YdzHbzm38uynOQQDeICEhPu81+00BbffjXJo2p+wLEWs
         zLdUU62WlQ72RA+xpv/9/W9WYaSdVtqsuN70yi7Qr5OVDk0huRlbXYJSGDB6QxJMQfm1
         vA+Ya1TR17HGH/yihTEDrDd5vzaFdaChixDS2zmIX694g8wFmJcnEiDfqVgkbW66K96b
         7uvrsTGWTx4aTb2/OsNXnU1SLbfrHSB56eP8TzOJlCyiBb3z8VNTNaLGAVmgMiluxWKB
         KL7VsMMhAq9qlvjY0NLni48hGbws85e0o6tp7dSRtS3HQhQ+9F+tJuuuWe5pciOfY0Jc
         kkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GI9HIepa5MquqaVEzYGCum2D6XyRxWJVDYaQg9Z1s+c=;
        b=i19q76rFNCsJuIfMsmPnhKuhnzUofEzRnuwTblUpHaTziqdc7qwytadr1NBwSISYSs
         wW7DzzuqVRW1pCEcxnm8/omTAKTXK4ox7S97RIRtvBb1/yBkEG2n8UcjuRLAl8q1QhPN
         0K0VL052kRuyb4NkzE6WThliPruLaUVKTqeGrkJ9yw8OzGrY75RASgwNkBORKkt6/2uq
         VzLJy8bhxnY2AOeBNFxkF5y6CV3pRIrBr5SaB/3zlPx6oIfERLIAfvCqqwk7ZrJiovNL
         jFnRa09xpEajzNuLd/DnNIw2eLSAE2nhbvjxLgTX32ysT4APP0Ty3c70+OWq942ivqi4
         5j7g==
X-Gm-Message-State: AO0yUKXydXyW2rPjKCtTa8r4dIhLJYlgEnFFJZtI2WcKl6ZogtR/V49V
        z/7pUUvCK482FNnu8OpJFWCz5YlEpvc=
X-Google-Smtp-Source: AK7set8g4vu77swJzjVOfxE9R56+OEz7tAqaMTSVtNL7CTLLpiN5U9eGdS2PGUsGudkFV9AcaX0b/Q==
X-Received: by 2002:a17:90b:4acc:b0:233:a6b7:3770 with SMTP id mh12-20020a17090b4acc00b00233a6b73770mr4069144pjb.14.1676488215685;
        Wed, 15 Feb 2023 11:10:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ml12-20020a17090b360c00b002342ccc8280sm1857920pjb.6.2023.02.15.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:10:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'Git List'" <git@vger.kernel.org>
Subject: Re: [Bug] Test 1450.91 Fails on NonStop
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
        <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
        <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
Date:   Wed, 15 Feb 2023 11:10:14 -0800
In-Reply-To: <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 15 Feb 2023 13:49:50
        -0500")
Message-ID: <xmqqwn4iycbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> So, this looks like we do not have to hold the 2.39.2 release for this problem. I will run the packaging job for the platform release.
>
> + test-tool genzeros 104857601
> fatal: write(): Invalid function argument
>
> That explains it. We had to push the use of xwrite() because of
> issues associated with writing large buffers exceeding through
> write(). We could use MAX_IO_SIZE to limit the write size (at
> least on NonStop) into acceptable chunks.

True.

Curious that this use of write(2) is from late 2021 and its uses in
tests came from the same era (e.g. t1051 has two calls added in the
same timeperiod).  So it is nothing new even to your platform, I
suspect.

There are a handful of raw write() in reftable implementation whose
size I am not sure about (and I am not touching), and a deliberate
use of it in trace2/tr2_dst.c that is well explained (and I do not
think touching is a good idea).  Everything else looks like they are
aware that they are making a short write, but some of them might
still want to become xwrite() to benefit from auto retrying a short
write (which I didn't check).

In any case, I think the attached is a sensible first step to have.

 t/helper/test-genzeros.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/t/helper/test-genzeros.c w/t/helper/test-genzeros.c
index 8ca988d621..9a1d3ee221 100644
--- c/t/helper/test-genzeros.c
+++ w/t/helper/test-genzeros.c
@@ -17,12 +17,12 @@ int cmd__genzeros(int argc, const char **argv)
 
 	/* Writing out individual NUL bytes is slow... */
 	while (count < 0)
-		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
+		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
 			return -1;
 
 	while (count > 0) {
-		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
-			  count : ARRAY_SIZE(zeros));
+		n = xwrite(1, zeros, count < ARRAY_SIZE(zeros) ?
+			   count : ARRAY_SIZE(zeros));
 
 		if (n < 0)
 			return -1;
