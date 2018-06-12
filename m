Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8151F403
	for <e@80x24.org>; Tue, 12 Jun 2018 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeFLQzm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 12:55:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38135 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933419AbeFLQzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 12:55:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so283919wmf.3
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NPdbDkNwfxyCDO3rpJM6PK1nXCyYxsxLWpmR0nt5iDI=;
        b=hcRTsdP5/4hWPlvPYMbibhBCAueaFhtOQHw+eU0Z6nGDkMJkSDCPuOTHaGUUR7ioiy
         AId1DCZd4rauD/3XagUzf0qK/pEnUsD83Q4ScfiSlIQ3s4Tde6npXnmKfI/qUd9jRy+I
         WQFriQzunu+rYiXZayT3rTI2oDSwfqWSvdNSZTljjB8VU/VnFLdHjW88U4BNX9rvo01P
         F9EFDflq0m0dajCDoK7HsgN7PnsgSBeCz1cCzhGfDc2Wfwl5XO5Fgmj7drCbmJXEu8sp
         c2CM9xuYiltcsOpyVdX01DxRELcpN98dTqoOLAMWmKHrjY1NzJXmjekoxuq8YQVKezkn
         5bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NPdbDkNwfxyCDO3rpJM6PK1nXCyYxsxLWpmR0nt5iDI=;
        b=aIR086wW1anQ4JylDfRJ0EoiYyHgT2sd6v8KAyr+CMHkvTQu+kkLeao4ALCkbdkDlc
         fOy+2OxhnP13t7z9BqaG5rzyy6c5/N/0gUfYzu0sBqikUoI6wjqCZoc6A48m3jTwztaT
         CehIlGtPMEJKzOyYvngPH6cRcbpwHvyvYDk6L9JAvzszIVJppGCaFmeVFhub5Hui1cd8
         biN+tU5aHR/Kev+0I61uboYjwY5mZ6FQlqfR67WCSlgQTxxHbfSi+37N6XwoVf4ToibH
         CUIqh1cEuFQk1rPPMEmecRUrjYYnoN7CfpITbSxCBKvAPWhPnWnpoyTCiLYQgoK/HRE/
         9VUA==
X-Gm-Message-State: APt69E0LnZeDmm8LLCSo1Cqy5dvr6d4+Xt7zn8ZI3fOwTnverPd9zS4S
        S6w0T2hNeYOZkG5jDKreKRc=
X-Google-Smtp-Source: ADUXVKJGndA/CveWVCY1ZVXdxg6nGUe3Y+7/Py/E0FD1C+Djla3WxNPCRYLodcfqt/D7vnpx9/HUKQ==
X-Received: by 2002:a1c:9189:: with SMTP id t131-v6mr848657wmd.89.1528822539055;
        Tue, 12 Jun 2018 09:55:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f17-v6sm13371201wmc.2.2018.06.12.09.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 09:55:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>
Subject: Re: [PATCH v6 12/21] commit-graph: verify parent list
References: <20180606113611.87822-1-dstolee@microsoft.com>
        <20180608135548.216405-1-dstolee@microsoft.com>
        <20180608135548.216405-13-dstolee@microsoft.com>
Date:   Tue, 12 Jun 2018 09:55:37 -0700
In-Reply-To: <20180608135548.216405-13-dstolee@microsoft.com> (Derrick
        Stolee's message of "Fri, 8 Jun 2018 13:56:22 +0000")
Message-ID: <xmqqtvq89c6u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2b9214bc83..9a3481c30f 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -269,6 +269,9 @@ GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
>  GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
>  GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_COMMITS))
>  GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
> +GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
> +GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
> +GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))

There seems to depend on having GRAPH_COMMIT_DATA_OFFSET in this
file, but I do not think 'next' or sb/object-store-alloc has one,
and I do not think I saw an earlier patch in this series to add such
a line.

It appears that many messages in this series are sent in
quoted-printable when they do not have to, which made me say fuzzy
things like "I do not think I saw" in the previous paragraph,
instead of being able to be definitive with a simple "grep" result.
Please try to see if you can find a way to tell your MUA not to do
unnecessary mail munging, if you can do so easily.

The worst one was 07/21, which came in base64 and contained a patch
to this file in MS-DOS line ending convention, which made it
impossible to apply.

>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -348,4 +351,19 @@ test_expect_success 'detect incorrect tree OID' '
>  		"root tree OID for commit"
>  '
>  
> +test_expect_success 'detect incorrect parent int-id' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_PARENT "\01" \
> +		"invalid parent"
> +'
> +
> +test_expect_success 'detect extra parent int-id' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_EXTRA_PARENT "\00" \
> +		"is too long"
> +'
> +
> +test_expect_success 'detect wrong parent' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
> +		"commit-graph parent for"
> +'
> +
>  test_done
