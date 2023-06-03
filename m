Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E773C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 02:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjFCCDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 22:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCCC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 22:02:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBE197
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:02:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-651e298be3fso2320166b3a.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 19:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685757777; x=1688349777;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7kO7PKx4tT1x4sUZ64t8vdsqET+A3KXN5t34lKWGbA=;
        b=Jq+D+sVEXv9XGnXvsdctT57lFEPihfKeYlpe35EbXdePTfRZJhc2OKrA7YcI1ERrKD
         njiO0f216qJihcHd0OjQxkMD5Ry+wLchLp7hClGaI7OyDV3kY/gMU2WtWqdFCrAtTcn5
         d+jmhH4jkY74u558ByC0JMk0ziI4Y7FfAbbthGnxsave8XEJbfZMecSyqEbSLUmkdLwO
         h2innolp6YmcLzALGblHHlypej4rb/OK1rwqW0kjW1e5BC+Yjz+Jurh622e1Y2txifKC
         6gc2qiUpO5cfK3LmiO4sXxEv4ZrR/n6taV0Skbjn41BsRg/UJtUn+Ah4k5hiauCC/q5V
         PpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685757777; x=1688349777;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w7kO7PKx4tT1x4sUZ64t8vdsqET+A3KXN5t34lKWGbA=;
        b=lGnLgp8TkpriMwVSMeIXP7b7s1E4EAm4Ifp/GsPQukg4NhPUMSD2iKbBP3n8h4RWPF
         XnUjleMIbwaGwaNhcl5LYabop5IVKjHaiQj29aMEZa6QHSiAhRPd50wyE2+FCPbBcb5U
         4LTMbuWkP1pLbWJis/XxxrIEEauTC2REaP02lkdQ3yzxt/GnWyD+pfjk/38qtVQExqNi
         ZxYuSkEcvneFRXmw6Me+XaiUlGWvgzUSM28PXEQ8UgHB3h3CiFEA2w/OXxp5gIdokly9
         z8zj98SBEiPezKJKBHDRVof1f/NF92nizdDI+hjycK9Arc6JqElYAO0MguMHWt8lefCJ
         Z99w==
X-Gm-Message-State: AC+VfDwMUx3i5RDwq4NptdMkIHox2gq2SqlV6H3iBmrHaRWGbZcjAK2g
        ooPvV3a9fuPwkKmEVxafeVQ=
X-Google-Smtp-Source: ACHHUZ7RiWF+PFU8TMqtChNm5XVu7TUwenxXFwveZS+fqGBZv+gHaXqGM494oj+Ys7zwD7decO+oag==
X-Received: by 2002:a05:6a00:2ea9:b0:64c:4f2f:a235 with SMTP id fd41-20020a056a002ea900b0064c4f2fa235mr17272959pfb.30.1685757777501;
        Fri, 02 Jun 2023 19:02:57 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79250000000b0064ccfb73cb8sm1551856pfp.46.2023.06.02.19.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 19:02:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
References: <20230603002819.1122129-1-mh@glandium.org>
Date:   Sat, 03 Jun 2023 11:02:56 +0900
In-Reply-To: <20230603002819.1122129-1-mh@glandium.org> (Mike Hommey's message
        of "Sat, 3 Jun 2023 09:28:19 +0900")
Message-ID: <xmqqedmt7167.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

As most lines in the affected function seems to come from your
fcb2c076 (commit-reach: implement get_reachable_subset, 2018-11-02),
I'll redirect the review of this patch to you.

Thanks.

>  commit-reach.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 70bde8af05..f15d84566b 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -944,6 +944,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>  		}
>  	}
>  
> +	clear_prio_queue(&queue);
> +
>  	clear_commit_marks_many(nr_to, to, PARENT1);
>  	clear_commit_marks_many(nr_from, from, PARENT2);
