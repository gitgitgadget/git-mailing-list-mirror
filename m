Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F06E743CD
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 23:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjI1XQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjI1XQt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3EAAC
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 16:16:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81ff714678so21167795276.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695943007; x=1696547807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=550Km34LlpGiHY13pev9swWj2GrP4I9kvxC9lbntp7s=;
        b=1DoqZCKWOuGfniQ9sXQVqlR02drDxhU9khXBV0zNJl4ezJkuLSuQXzoqszXV0h7jwy
         qnx1rw/s6jZ+gEAYvQ1G8nlQ2ygquAF5r7mUPXcvqkGNPf3iwoEMCBQ0vc7IOhBPwzya
         8rAggH6Ojd2hQRuwi0wt6bglf9X6JNdKZwdNN5fHi7WT8ftf5dvTL/faeylLsUdBnAmb
         0tD6JY2eDQ16jTAin3DbBnD/NbnomolYt0bBcfQrKBbaUFLpBaxVKbYMIhp3wpy1jFzZ
         gjiLb006dqA1HHrOsRWD4dru83mq2tokm3ZD8HvEm1tAEgihxRL5iGIFSReB7y8FwWzt
         BoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695943007; x=1696547807;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=550Km34LlpGiHY13pev9swWj2GrP4I9kvxC9lbntp7s=;
        b=uu1MML949Zch1BdmR+9OQ/CVEbQluC5BLrYvDn90u7rA9lFT6tsUBR9B72HbpMN8LU
         4LkF2O3hkGEjr+yRZVfukxxPwWkfnVxti3FQkJVunckyfHB4ZDp9WI4oaZGb5IgJACQJ
         ZMOjQAgR4AvQehDmsXS2ZJ7nG+A9J3QxbcugtTu4VN1NUJENRGTLdsqsV3KNGYz2EkIA
         PV0Y6zH7KB6cplA+c4+nGR2S5yJ7Mq/Tuwl548P99ZlPoXQSXtpO7QO/yrqiPORNhcXj
         cmmHmEL7sXqlulK/X/C1ubpmIhoEfT6SDnQkJny22bgLDCWXCmuywBbfYF7f5g4R+jVk
         RaZQ==
X-Gm-Message-State: AOJu0YyY3yoIrT2p0eeHAR8COmgpOzYzOgvF+Y2oH7IUM70htzFueCoA
        7Qh9l6CbnXWriX9SMCJ4Dig9dRZ2ja/XsUdxJk5G
X-Google-Smtp-Source: AGHT+IHD8EfNhTGHuMR6Wde32IhLLtaAGhXxppAyaO3IkeD07xKMzYnfJ3RHoWDhTfn5P7Qdwh4a6ReGv1zhiM87NsDe
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4882:f963:8bc4:1871])
 (user=jonathantanmy job=sendgmr) by 2002:a25:6812:0:b0:d13:856b:c10a with
 SMTP id d18-20020a256812000000b00d13856bc10amr35382ybc.3.1695943006952; Thu,
 28 Sep 2023 16:16:46 -0700 (PDT)
Date:   Thu, 28 Sep 2023 16:16:44 -0700
In-Reply-To: <c904caba7e17b6f2784933e9f18634ea66f28537.1695709372.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928231644.3529127-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 2/4] trailer: find the end of the log message
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Linus Arver <linusa@google.com>
> 
> Previously, trailer_info_get() computed the trailer block end position
> by
> 
> (1) checking for the opts->no_divider flag and optionally calling
>     find_patch_start() to find the "patch start" location (patch_start), and
> (2) calling find_trailer_end() to find the end of the trailer block
>     using patch_start as a guide, saving the return value into
>     "trailer_end".
> 
> The logic in (1) was awkward because the variable "patch_start" is
> misleading if there is no patch in the input. The logic in (2) was
> misleading because it could be the case that no trailers are in the
> input (yet we are setting a "trailer_end" variable before even searching
> for trailers, which happens later in find_trailer_start()). The name
> "find_trailer_end" was misleading because that function did not look for
> any trailer block itself --- instead it just computed the end position
> of the log message in the input where the end of the trailer block (if
> it exists) would be (because trailer blocks must always come after the
> end of the log message).

I might be biased since I wrote the text in question in 022349c3b0
(trailer: avoid unnecessary splitting on lines, 2016-11-02), but the
concept of patch_start and trailer_end being where the patch would start
and where the trailer would end (if they were present) goes back to
2013d8505d (trailer: parse trailers from file or stdin, 2014-10-13). I
don't remember exactly my thoughts in 2016, but today, this makes sense
to me.

As it is, the reader still needs to know that trailer_start is where
the trailer would start if it was present, and then I think it's quite
natural to have trailer_end be where the trailer would end if it was
present.

I believe the code is simpler this way, because trailer absence now no
longer needs to be special-cased when we use these variables (or maybe
they sometimes do, but not as often, since code that writes to the end
of the trailers, for example, can now just write at trailer_end instead
of having to check whether trailers exist). Same comment for patch 4
regarding using the special value 0 if no trailers are found (I think
the existing code makes more sense).

> Combine the logic in (1) and (2) together into find_patch_start() by
> renaming it to find_end_of_log_message(). The end of the log message is
> the starting point which find_trailer_start() needs to start searching
> backward to parse individual trailers (if any).

Having said that, if patch_start is too confusing for whatever reason,
this refactoring makes sense. (Avoid the confusing name by avoiding
needing to name it in the first place.)

> -static size_t find_patch_start(const char *str)
> +static size_t find_end_of_log_message(const char *input, int no_divider)
>  {
> +	size_t end;
> +
>  	const char *s;
>  
> -	for (s = str; *s; s = next_line(s)) {
> +	/* Assume the naive end of the input is already what we want. */
> +	end = strlen(input);
> +
> +	/* Optionally skip over any patch part ("---" line and below). */
> +	for (s = input; *s; s = next_line(s)) {
>  		const char *v;
>  
> -		if (skip_prefix(s, "---", &v) && isspace(*v))
> -			return s - str;
> +		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v)) {
> +			end = s - input;
> +			break;
> +		}
>  	}
>  
> -	return s - str;
> +	/* Skip over other ignorable bits. */
> +	return end - ignored_log_message_bytes(input, end);
>  }

This sometimes redundantly calls strlen and sometimes redundantly loops.
I think it's better to do as the code currently does - so, have a big
if/else at the beginning of this function that checks no_divider.

