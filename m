Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C566E743C4
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 21:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjI1VkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 17:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1VkP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 17:40:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57AF3
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 14:40:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d848694462aso20419084276.3
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695937213; x=1696542013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJnihAWhg+XWHRvV0urQSh4sjdCGgaSjBjlvbtuPSD4=;
        b=u4oEqM7vQ/GRUaJ/TjwLaz3iStgbs5YPbCyEsaTaUCiCS2i7zLzX5ZAaU7MBtVj2EA
         lf9FDf1+wW0WnjcillsjA6+7/pYt2lkMqzNGXvXcVJN0FLyEwGJAk1UJVdWi3EXGZfVc
         ElavfvSmzbhYqLr0HaVassP8gRgQ6j0FXZqRyTsBpjwGmGCDLznlgSSPh+tkuRIfpLbk
         FCEOo7dB0gOtt7JVXX4/A/pF9yfNblUQMq44XGbKL3t69c4gZB5ED/lDPg6OhJtyAzz/
         JGH2K0e9Ni9yow3IfrT0kE74FlbCXIz9kOuFGqNUt19iFjzVCjmrTcqLSxVkLjNuBYW8
         qbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937213; x=1696542013;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJnihAWhg+XWHRvV0urQSh4sjdCGgaSjBjlvbtuPSD4=;
        b=rpRpu3JsouWANgS/EWxzCz4hjc/4E8IxrLd5u6xY/3wUxkop8zbTxBSHLa5TZO3/0D
         x0SaBfH8e+s9b/fZFgDqiI1mVH4v8et3szR5HUxbeieDeKCKludnJ41g7kz46jAlskv0
         NxaL662OBRvT6BVO3c6lT8Dk3uIZ2rmNzknZnLI2abt38vEmv/grbEtguZ5KwHx8LNsp
         +d00b4Jzw4r76QDh104KXlPdTFX9lXxuwu+MWOb2s0IDaBHRJ8b3YiuqEH85YURxoouy
         B9NbFwLXxZx9I5JfpZkkdt5UFFoNAUZjiRxYjfXTXGzBoAjXpw8SNtmO0piyF+KS+wWi
         wIeQ==
X-Gm-Message-State: AOJu0Yx4ZM7Qvo8VpVtnUtULS6zIV+w+1PANAmttgm/j9ww1+lZiHkE6
        R/QVoMp1nPSLO7iXLS426xc3I7qaQBqINmHqzGQD
X-Google-Smtp-Source: AGHT+IGYjbQNTiGllTHU8a/8IpB/TCkyDEmfzL4sBhyaXS5qrq82//l3vFenSQgjsFvzZmi7OyR7d69aLrEtUzIwBJO4
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4882:f963:8bc4:1871])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d18c:0:b0:d85:3ef:a9d3 with SMTP
 id i134-20020a25d18c000000b00d8503efa9d3mr34150ybg.0.1695937212757; Thu, 28
 Sep 2023 14:40:12 -0700 (PDT)
Date:   Thu, 28 Sep 2023 14:40:10 -0700
In-Reply-To: <xmqqbkdometi.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928214010.3502838-1-jonathantanmy@google.com>
Subject: Re: [silly] loose, pack, and another thing?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Just wondering if it would help to have the third kind of object
> representation in the object database, sitting next to loose objects
> and packed objects, say .git/objects/verbatim/<hex-object-name> for
> the contents and .git/objects/verbatim/<hex-object-name>.type that
> records "blob", "tree", "commit", or "tag" (in practice, I would
> expect huge "blob" objects would be the only ones that use this
> mechanism).
> 
> The contents will be stored verbatim without compression and without
> any object header (i.e., the usual "<type> <length>\0") and the file
> could be "ln"ed (or "cow"ed if the underlying filesystem allows it)
> to materialize it in the working tree if needed.

This sounds like a useful feature. We probably would want to use the
"ln" or "cow" every time we use streaming (stream_blob_to_fd() in
streaming.h) currently, so hopefully we won't need to increase the
number of ways in which we can write an object to the worktree (just
change the streaming to write to a filename instead of an fd).

> "fsck" needs to be told about how to verify them.  Create the object
> header in-core and hash that, followed by the contents of that file,
> and make sure the result matches the <hex-object-name> part of the
> filename, or something like that.

Yeah, this sounds like what index-pack is doing - the hash algo can take
the contents of one buffer (a header that we synthesize ourselves), and
then take the contents of another buffer (the file contents).
