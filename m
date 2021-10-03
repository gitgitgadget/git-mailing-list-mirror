Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E9C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8413961A4F
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 05:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhJCFQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 01:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhJCFQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 01:16:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B8C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 22:14:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 5so3914305iov.9
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qCLfdEMmj+KLkRTpv+OTKHyrix7cNnEiJVCHXkQpXdQ=;
        b=DKdLNGXoxDA2ucjy4Yj5+Sa+ILEfAq7I4s3yddL/Rlm0rUe+IqPvyHS5DJx7UVW9yy
         J8JJeI7LrvmQN2BHkD3gtkdHDzCBe+bnJlbjaWe4Vnr4W+BjCa0ccG0J9P4XYP6W8JtW
         60imvQvVv3kQT/vaZBu3RIjLwXKwCkL2SyadK/h8Cd7gN1voNU2eqlBoyWHrYgSSem42
         8u4jMSih2bHmLuQ9yztxL/57ZEp1y3w0J84XnanFEDTyfz21U10Yfvv8Kt2qL5yVhxgB
         MtFyWZF/I1i0RJFSMxdVZbBXxD6SE1BJkHKfVHOeiTZ082tbhxuQPQoLnyUEkOOaUQy1
         kFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qCLfdEMmj+KLkRTpv+OTKHyrix7cNnEiJVCHXkQpXdQ=;
        b=BssEwVsEARXxRtEQ/VtZFcnsJU0ebEVJsG48zY/9jjYYjLzKGDt0+3OI4L+vrcfCyV
         15wg654gBhobPxcKOQWJ65hjuh3UCun9lbpLyWBh+jarh1wWvhJ7wNFjifoyT9nn3LSe
         NJLa9kjeVFAFC4SAIYU0CX9VLViM4jh6IZEhRwRhGH/axaXD/1BAGokdvD+4No3/RVz8
         K8Q0+ef7n5A7Rezp7V4jevbrcy7sPUjv1uqhsaoxjvNgwdh0nG2tAWfU1Hiaj/9Nrv+2
         opX7rqpCboNl7qz96kZDtzS8LBsvLAurlTuRuwbtUezSTgm3uXgzmI2r1APUYycXEwe2
         RF/Q==
X-Gm-Message-State: AOAM530+2G61rGXMra0pBnTOIsqrczkH6DsB7k75XQEjjYz06Z0HK/w5
        2EA3Cij9T5BIb5AecMOWvTL9nkORzL+qHw==
X-Google-Smtp-Source: ABdhPJyjg52uFe6GWieHnGqln6BVHsUzx4fxkQz/bGNYD0O2MeNxlqHO/kRIL3aCAeDA/NsfPVAR5g==
X-Received: by 2002:a6b:5d19:: with SMTP id r25mr4524575iob.11.1633238090479;
        Sat, 02 Oct 2021 22:14:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b11sm1100902ile.12.2021.10.02.22.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 22:14:50 -0700 (PDT)
Date:   Sun, 3 Oct 2021 01:14:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] p5311: handle spaces in wc(1) output
Message-ID: <YVk8SeuDIWwsrdO0@nand.local>
References: <a682e2c8-fecc-906e-0ff6-93de2b311d14@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a682e2c8-fecc-906e-0ff6-93de2b311d14@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 02, 2021 at 10:33:18PM +0200, René Scharfe wrote:
> Some implementations of wc(1) align their output with leading spaces,
> even when just a single number is requested, e.g. with "wc -c".  p5311
> runs all tests successfully on such a platform, but fails to aggregate
> their results and reports:

This makes sense, and makes me think that wc's platform-specific
implementations are too tricky to use when we are being picky about
leading spaces.

In other words, I think that your fix is absolutely correct, but I
wonder if test_size should be friendlier in what it accepts, and to
chomp off any leading space. So perhaps something like the below would
work without any modification to p5311.

--- 8< ---

Subject: [PATCH] t/perf/aggregate.perl: tolerate leading spaces

When using `test_size` with `wc -c`, users on certain platforms can run
into issues when `wc` emits leading space characters in its output,
which confuses get_times.

Callers could switch to use test_file_size instead of `wc -c` (the
former never prints leading space characters, so will always work with
test_size regardless of platform), but this is an easy enough spot to
miss that we should teach get_times to be more tolerant of the input it
accepts.

Teach get_times to do just that by stripping any leading space
characters.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/aggregate.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 82c0df4553..575d2000cc 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -17,8 +17,8 @@ sub get_times {
 		my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
 		return ($rt, $4, $5);
 	# size
-	} elsif ($line =~ /^\d+$/) {
-		return $&;
+	} elsif ($line =~ /^\s*(\d+)$/) {
+		return $1;
 	} else {
 		die "bad input line: $line";
 	}
--
2.33.0.96.g73915697e6
