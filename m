Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C3C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 19:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQTok (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 14:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBQToj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 14:44:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3325E586
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 11:44:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ml23-20020a17090b361700b00234463de251so2448055pjb.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PpEVVLUTqyltBUBpA63/JJo9rl+IwntvwYz2mZmRx8=;
        b=Ln7h/nvEaXXmY02CSEdscRR+uXu6jsJU19JJ45Ud/1OgQ2c/HPacIv+pFC5XdHLX5H
         U0E1jYaT6566blsX3qUiQeP972adrO0jgNYXGbxVcbT5BQdbNOwEPUvqmNjuTru39TOv
         p1Kjxtvj+NmuQ2K6jj+gUJNzkdQI3NrExK1ws3TBcZuSQ/+WF6rWjZ3JP+bFYNr4FemM
         QztFUp9TMAQSDwekI6Byu+61qxpAF/cg3bOVNDyfvBFwjvbhmH0X2SwqaU83P3GUObwJ
         GykUx7SMa4qZ/lZ7XkaDzFO3ykLBySOOl0oyZwJzS5JIW6Dv/HXikDn+4GKKt99ttDYu
         fjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PpEVVLUTqyltBUBpA63/JJo9rl+IwntvwYz2mZmRx8=;
        b=3aR/9RG5k1lcOBlLMM6YeTGcEzOZzrUHesE1PFC0OkzOgWSj6k7dziCVFlnR1ZnW8e
         KibaUUXDNM2BayhCYzvWb4Gaj9N/TPs5cOHkKjLEASBu58Sm2DtQ7l6rEpOiVARiqx5d
         2b+OKZl7tzEF8ffgyXKloQ+UbcIZoKg5vKgnOwk8asn7uVt28qAXDIFTh8o8V+k2pAry
         aRqP0YHrTspGSilpqN91z805FtvjKhoyQofzG52nJmQmx3fPkHwM6MU9v0bwy1HIorpR
         ILB8G6X6wk+U4/kCesqKbAQOHZQuvgH39ejsRoCerv0n2SzhkNs5eSKwohP9VsE3KvqX
         kosQ==
X-Gm-Message-State: AO0yUKX3MOPeFrDdZEySNtqlMbZTwn7YYZI3yOWdYyJN2cmNP6AJ3KsN
        9tnRLDM4djMSJofqOv+ShrY=
X-Google-Smtp-Source: AK7set8y1oJuupNLro/DZRwK8aJAfDCt8jXalhZwYS8tv3ki6gn1PXujpom82KJzjpm1SsxRAmjNig==
X-Received: by 2002:a17:903:247:b0:19c:32b1:185d with SMTP id j7-20020a170903024700b0019c32b1185dmr623012plh.39.1676663077684;
        Fri, 17 Feb 2023 11:44:37 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b0019abb539cddsm3493181plp.10.2023.02.17.11.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:44:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        karthik.188@gmail.com
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone
 options
References: <20230216041432.1668365-1-alexhenrie24@gmail.com>
        <437723a1-284d-e96c-9202-ae7bfcb830a9@dunelm.org.uk>
Date:   Fri, 17 Feb 2023 11:44:35 -0800
In-Reply-To: <437723a1-284d-e96c-9202-ae7bfcb830a9@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 17 Feb 2023 10:50:13 +0000")
Message-ID: <xmqq7cwgm5zw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Rather than adding several new options with hard to understand names I
> wonder if it would be better to add a --filter option that can be
> extended in the future.
>
> --filter upstream[=<pattern>]
>   Limit the output to branches whose configured upstream matches
>   <pattern>. If the optional pattern is omitted list all branches
>   with a configured upstream. To list branches with no configured
>   upstream use an empty pattern i.e. "upstream="
> ...
> If we wanted we could add "--filter contains=<commit>", "--filter
> merged=<commit>" and "--filter points-at=<commit>" and say the
> existing options are alias for those filters.

I do find the above approach much easier to explain and understand,
especially the part that makes it clear to users that the option is
about filtering the list of branches with their upstream status.

> --filter pruneable[=<remote>]
>   Limit the output to branches whose upstream has been removed by
>   "git fetch --prune". If <remote> is given only list those branches
>   whose upstream matches that remote.
>
> We could allow --filter with --delete so one could run
>     git branch --delete --filter pruneable=origin
> to delete all the branches with a missing upstream on the remote origin.

I however do not think "prunable" is an appropriate phrase for the
"gone" stuff.  Your topic may have started by forking from a remote
topic some time ago, and you have accumulated some work on the topic
branch.

    $ git fetch
    $ git checkout -b -t my-topic-Y remotes/origin/their-topic-X
    $ work work work 
    $ git commit

Back when you started your topic, their-topic-X was still work in
progress and was not merged to the mainline of the project, but it
recently graduated to the mainline.  The branch their-topic-X has
become unnecessary at the origin, and they removed the branch.  Then
you updated from the origin:

    $ git fetch --prune

Now, you no longer have remotes/origin/their-topic-X which my-topic-Y
was based on.  Did it make the my-topic-Y branch "prunable"?  Can we
discard it?  I doubt it.

If on the other hand the reason why their-topic-X disappeared as a
remote tracking branch was because it turned out to be a bad idea,
and got rejected without having been merged to anywhere, then, yes,
any new work you made on my-topic-Y is based on the faulty foundation
and may need to be redone completely or discarded.  But still I do
not think "prunable" is a good way to describe it.




