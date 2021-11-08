Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60EC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC58619E0
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhKHU7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhKHU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:59:10 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52120C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 12:56:25 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x10so6411885ioj.9
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eqfOBWIlrN0DWIBeZzOkbqsGKDr40u6UJmQCoOeKqK4=;
        b=s+QuTfzJlyiGWkFTuJx87Jl4oEVF+ntAWljOuyWPQYv05lNuwCt1M79mFy+XnoZKFV
         YhhrtJVXeEwDesWe+Y5JSR05Z6AjnVgtMPzUEoXfyYXGsLFgCUloniOyHnh/NrxN6Kfq
         aIkzusOCOO1K/KD9YPsfzFB2p4jHlsMKts5YYYbSTEPB/vo/nIjZhxZL3G0F26ia82f/
         cMRbemWftWwTZ+in6DelnHoH8yUDS0u7NVtw0kW+t1I5ik2IlXyE1iBKXQXTvGhsMRpd
         ZCVciXpY7EqV/nJxp65N+8z7kqahmcqMd2+5tKHU0pAqMENUvkcGw6zc0OEnCashYolB
         xiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eqfOBWIlrN0DWIBeZzOkbqsGKDr40u6UJmQCoOeKqK4=;
        b=izN5Wvs9L7IYHRhNwJ0PfI+Mb2NkFejJU/0jiY9wb5QCYa9sHO2IrLytGTcFwWFf8V
         YCf2Z/l8VvGFzJ9BIWSWtIFHa3GyyZNE9NX8+Bw10sd46clbfTLnDHXXxere9kdjB8bQ
         JHmjC4wZyMypY67CEsmaO4xRRWGQkJcAdcc+vwG+DfSpP0FUs0Jc+9rDY7Cj4gSkurnS
         ZSSCjK4TvDdy3D2U8LYotOYFi2h5gqXuS4Kgv2FV6zsAvUma8rE9+VxOT26EyZX2Ehpq
         Iy4Al7wRrSE2ES3APumTTw0Z1rg4oz0ZEx7o/V/ePfPiRPNnvnjl7Dl7bm44LSEROA8U
         xO/w==
X-Gm-Message-State: AOAM5319DBQfCYx5TGrywkCVD5db8ETTUfu4nN0H8MBT+TUMv/LcOvVF
        oCxnIKzOOcSiyF7Pe3gPv7Iq84KePnswVDtD
X-Google-Smtp-Source: ABdhPJzSC60Kd8SGrJvFNnj5fMLGM0SPmXW3XquWx52IrVvxsQNKXcBOTny34fPjQnUE6binNN1CyQ==
X-Received: by 2002:a05:6638:2395:: with SMTP id q21mr1569729jat.48.1636404984746;
        Mon, 08 Nov 2021 12:56:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9sm3607311ilp.60.2021.11.08.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 12:56:24 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:56:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 4/8] grep.c: move "prefix" out of "struct grep_opt"
Message-ID: <YYmO9xlgFGhQlFZg@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-4.8-78298657d69-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.8-78298657d69-20211106T210711Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 10:10:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
> The "struct grep_opt" is a mixture of things that would be needed by
> all callers of the grep.c API, and quite a few things that only the
> builtin/grep.c needs.
>
> Since we got rid of "prefix_length" in the previous commit, let's move
> the "prefix" variable over to "builtin/grep.c" where it's used. To do
> this let's create a "struct grep_cmd_opt", which we'll have a pointer
> to in a new "caller_priv" member in "struct grep_opt" (the existing
> "priv" is used by the top-level "grep.c" itself).

I'm definitely in favor of removing specialized, caller-specific bits
from an internal API. But I'm not sure why grep.c needs to keep track o
this new "caller_priv" field at all.

Among the uses of `prefix` in builtin/grep.c, I see grep_source_name,
and the call to run_pager(). Would it be more straightforward to pass
down prefix from cmd_grep down to its use in grep_source_name?

There are quite a few intermediary functions that we go through to get
from cmd_grep() down to grep_source_name(). For instance, we could reach
it through:

    cmd_grep -> grep_tree -> grep_submodule -> grep_cache -> grep_oid ->
    grep_source_name

But passing prefix from cmd_grep down to grep_source_name without
relying on the internals of grep.c seems like a good direction to me. I
could even buy that (ab)using a static variable in builtin/grep.c to
keep track of a constant prefix value would save you some plumbing
(though I'd rather see the usage spelled out more explicitly).

All of that is to say that I share your motivation for this patch and
think that the direction is good, but I would have preferred to do it
without the caller_priv variable (unless there is something that I am
missing here).

Thanks,
Taylor
