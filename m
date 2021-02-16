Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EB4C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9134564E28
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBPSIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBPSIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:08:32 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A77C06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:07:51 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t62so10266577qke.7
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=exmbbUTMAn11JKY8y4yzfVgaHllBSmyX/1M0bEMcOMU=;
        b=EObMDy9aiwgqSrQaCcWk78e+Nu4PReSGXf9a2pXY4t9IKacCuLImyVJLYSzP1bIXx3
         Guq1ngtKFLX8oAt4V3H+ZHpetC8kDiJw2lbXbcxMuK/0IJKJDbi0S4XIJulqsVmin0DI
         mx+4X8XpevmvYXPe5wOUYMZSD2qB2RxVHzQQpvyh/echj27IBjL7I5eQBqqBY5dDnpnl
         iWRVOfCNRDCZN3t749nzVUp+2vGRKI+6pEXUhDxOH8JN9sEoNN7tss1cLDAmxUE56loa
         aVW9ecxVk6OaGgv1jxz4dCG0hTB/nH7Y4sPxM6frfyD1Jh3j2/H9HyaiblYlrE0J/zwT
         NL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exmbbUTMAn11JKY8y4yzfVgaHllBSmyX/1M0bEMcOMU=;
        b=hgH4yf2zD1Szg5jwFwyZ7/Xc0QnkRabgTJYft39zAHNNCjgPxVv7/msfHaL40ineKw
         H7XfIvENDW0B/oGZdISoehNJLrZP5jbBp/71V9E4tdTVF4vnQD9G13/bmIRspjPTnZ87
         G6NrJ3b2fthSJkQjTNXbPFzHU5ID7CrIBJMFYWHxPmeJx7O9oA7mRf0F0YzZOVnCyulL
         FBL27pjGaZLNZbDnKkR+eB+lATHlUTJaaw1f/+zUOsqFJ6+6IQ929vr3bUaqRNfySrLX
         RG2slo3RUof9put0eij1JAmO3zF9qOKLKPnFcCFylpYm7STadiaO3k1Fs8Ak8wxQ93jI
         7Q3Q==
X-Gm-Message-State: AOAM530CxGEkvRXoSx2MDr3x2M0nGbORYIOKmQC5RA7e8eywwoxp8nrx
        iEOktedBNsJoqpOLin11xzUkEQ==
X-Google-Smtp-Source: ABdhPJw3M4kpQwpmZz74cjHR9FH6PMtwI+uf0CcE8hsemWXdz4tZsxLRYJT3SI/MT/WUQc14kIZXFQ==
X-Received: by 2002:a37:52d7:: with SMTP id g206mr20468720qkb.343.1613498871061;
        Tue, 16 Feb 2021 10:07:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id o194sm14819014qke.101.2021.02.16.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 10:07:50 -0800 (PST)
Date:   Tue, 16 Feb 2021 13:07:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
Message-ID: <YCwJ8tORQg2Air4r@nand.local>
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
 <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 06:29:55PM -0800, Junio C Hamano wrote:
> Matthias Buehlmann <Matthias.Buehlmann@mabulous.com> writes:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
>
> Thanks; let's ping our resident trailers expert ;-)

I'm not Christian, but hopefully I'm an OK substitute :).

I originally thought that this was an ambiguous test, since you could
reasonably say the trailers begin after the blank line in the second
"MultiLineTrailer" block. In that case, neither of the following lines
look like a trailer, so 'git interpret-trailers' could reasonably print
nothing.

But I was being tricked, since I looked at "test.txt" in my editor,
which automatically replaces blank lines (zero or more space characters
ending in a newline) with a single newline. In fact, this isn't
ambiguous at all, since the blank lines are continuations (they are a
single space character and then a newline):

		00000090  65 64 20 6d 75 6c 74 69  2d 6c 69 6e 65 0a 20 74  |ed multi-line. t|
		000000a0  72 61 69 6c 65 72 20 77  68 69 63 68 0a 20 0a 20  |railer which. . |

(see the repeated '0a 20' space + newline pair after "which").

I think that this is a legitimate bug in 'interpret-trailers' that it
doesn't know to continue multi-line trailers that have empty lines in
them.

I thought that this might have dated back to 022349c3b0 (trailer: avoid
unnecessary splitting on lines, 2016-11-02), but checking out that
commit's first parent shows the bug (albeit without --parse, which
didn't exist then).

Anyway, I'm pretty sure the problem is that
trailer.c:find_trailer_start() doesn't disambiguate between a blank line
and one that contains only space characters.

This patch might do the trick:

--- 8< ---

Subject: [PATCH] trailer.c: handle empty continuation lines

In a multi-line trailer, it is possible to have a continuation line
which contains at least one space character, terminating in a newline.

In this case, the trailer should continue across the blank continuation
line, but 'trailer.c:find_trailer_start()' handles this case
incorrectly.

When it encounters a blank line, find_trailer_start() assumes that the
trailers must begin on the line following the one it's looking at. But
this isn't the case if the line is a non-empty continuation, in which
the line may be part of a trailer.

Fix this by only considering a blank line which has exactly zero space
characters before the LF as delimiting the start of trailers.

Reported-by: Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7513-interpret-trailers.sh | 23 +++++++++++++++++++++++
 trailer.c                     |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f..af602ff329 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1476,4 +1476,27 @@ test_expect_success 'suppress --- handling' '
 	test_cmp expected actual
 '

+test_expect_success 'handling of empty continuations lines' '
+	tr _ " " >input <<-\EOF &&
+	subject
+
+	body
+
+	trailer: single
+	multi: one
+	_two
+	multi: one
+	_
+	_two
+	_three
+	EOF
+	cat >expect <<-\EOF &&
+	trailer: single
+	multi: one two
+	multi: one two three
+	EOF
+	git interpret-trailers --parse <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index 249ed618ed..7ca7200aec 100644
--- a/trailer.c
+++ b/trailer.c
@@ -846,7 +846,7 @@ static size_t find_trailer_start(const char *buf, size_t len)
 			possible_continuation_lines = 0;
 			continue;
 		}
-		if (is_blank_line(bol)) {
+		if (is_blank_line(bol) && *bol == '\n') {
 			if (only_spaces)
 				continue;
 			non_trailer_lines += possible_continuation_lines;
--
2.30.0.667.g81c0cbc6fd

