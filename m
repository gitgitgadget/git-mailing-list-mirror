Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458BB1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJROJQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:09:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44764 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbeJROJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:09:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so32150102wra.11
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SEoDeQuiGrIQtr5WOLVu56c0LDMYJ9g96cKNGfXdu+w=;
        b=BMm+oNicoSnW3fxnYJsq/JTdRa+usnEBFl5xGmFZ3tU5JNoNxW8R2jWxlznM1Lhobp
         JhzdRT0+7jQ/itH2rwa0luxM9Z/wxv50Oyl7w+FBYZ0Xi/3vnHZZatG1EycgHIqoZ551
         PjgQkx1v3ZBwO9oqvmXqSYS0neKxEjXs+QPngYkDUgoUTPBCB4t08Ebq/vOpNT3rW1r4
         NvGd/cuJgW5DuD/tqiphM2xZxCfOEHe7A8YDG0aJxzpRsfuZjpQXPw50QF3YCo22nyen
         AQ/55r2FyI3KmLbBzNDue8cuD7xRENOHRi7c70NYY6pWnRS4JzWyYalyXgbXcC3tjgxE
         aLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SEoDeQuiGrIQtr5WOLVu56c0LDMYJ9g96cKNGfXdu+w=;
        b=RVcW1uNrua1/HdcJLU2PjRruL43p6M/p99EmUEL89s0F6/IHehnA8jVG4p3yWdvQzJ
         cXr08VgOmyOEB5nigKBEwvT3R3XISWalTo348JPY2J9kK4K6pymqbaOG+WcyqwRNI4RB
         nfPNYuxHAuGfpSa0JC2G34cRIfIn9wVYL/ZXgR/bllwgrV3/wiFaECUBQ/jLtRVcjOQA
         EXX8ZZjHd1EPcSlXWAfI3Eccq1Dter7N3Vljx7wTYLbP8buuZkpmhlakK1j0Ul6948Hr
         UukYhaD84UyxzcwyQS3t/1nVS4hJCf0W4jok5FXIMRpON/BOkgnitlVdE5OHgiEkJm2U
         rm4g==
X-Gm-Message-State: ABuFfohVHKEs7H0uvGjBD1oRg6HHidOb8vv6DrsbApzhMKCT3c34+TTr
        Qd4XA5vkKdOTFoIjReDzetCs7nAMCvM=
X-Google-Smtp-Source: ACcGV61qkJwPnpAfQvSTn4Jpvil/NJzqHqSP1nNjiNCGuLsiBBxIXFy1MiUI6mZFh6m9+1e49xp4qQ==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr27328717wrq.200.1539842992327;
        Wed, 17 Oct 2018 23:09:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7-v6sm16364628wra.37.2018.10.17.23.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 23:09:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] merge-recursive: avoid showing conflicts with merge branch before HEAD
References: <20181012212551.7689-1-newren@gmail.com>
        <20181016201948.16025-1-newren@gmail.com>
        <20181016201948.16025-3-newren@gmail.com>
Date:   Thu, 18 Oct 2018 15:09:49 +0900
In-Reply-To: <20181016201948.16025-3-newren@gmail.com> (Elijah Newren's
        message of "Tue, 16 Oct 2018 13:19:48 -0700")
Message-ID: <xmqqva5zu6oi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> @@ -1283,6 +1302,18 @@ static int merge_mode_and_contents(struct merge_options *o,
>  				   const char *branch2,
>  				   struct merge_file_info *result)
>  {
> +	if (o->branch1 != branch1) {
> +		/*
> +		 * It's weird getting a reverse merge with HEAD on the bottom
> +		 * side of the conflict markers and the other branch on the
> +		 * top.  Fix that.
> +		 */
> +		return merge_mode_and_contents(o, one, b, a,
> +					       filename,
> +					       branch2, branch1,
> +					       extra_marker_size, result);
> +	}

Will queue with the following squashed in.

Thanks.

 merge-recursive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 16980db7f9..73b5710386 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1310,8 +1310,7 @@ static int merge_mode_and_contents(struct merge_options *o,
 		 */
 		return merge_mode_and_contents(o, one, b, a,
 					       filename,
-					       branch2, branch1,
-					       extra_marker_size, result);
+					       branch2, branch1, result);
 	}
 
 	result->merge = 0;
