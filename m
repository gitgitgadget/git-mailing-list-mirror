Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF8C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 14:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB2420849
	for <git@archiver.kernel.org>; Thu, 21 May 2020 14:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnRjgn5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgEUOXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgEUOW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 10:22:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87DC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 07:22:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs4so6764996edb.6
        for <git@vger.kernel.org>; Thu, 21 May 2020 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9XfjkALIA6JLI5Fi7dZvZkX0J6JehjqubuFPQgJsVSQ=;
        b=bnRjgn5TJNAerDKHwcJhhV63zIvLl5o7R6zpY0aRrpCJZUZCg7/scaSunlqRR4gqx1
         68GivO1RMlvAsq1EIu5HpMwpszx1S01JVAxmCWKg2qwvUD7E3J9aScnkmRaoI+k+WpfU
         aZZNFa+krqHEcHacEqEafx/Lb0RKgvGIybRAqklfaj3vlKvLQCnhFEQpsTVeN/vF1t0P
         YBD3mifH6RJJzs8kzBnxrlGEMNHB9+bD6eZl6xLdEwv4bnYt9jNtzNRZmcKzXawHLpN0
         7wqdkeTKERKhLWYEm/Qw3vfhL6akcK39Sw0M7dcLIhz425PAbX8n788hDNMAq7JWEMte
         wZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=9XfjkALIA6JLI5Fi7dZvZkX0J6JehjqubuFPQgJsVSQ=;
        b=m7vtlAWauoE0nV8+lZ2KuQL/ep+tAIjL9wm/aVqk+hWS3kLb02vEpii7PGiGhLH6pR
         TGAn8pPIerL+EpJYwXhPiBbq7/QbhvNncyV5ZbFsBhllAcds51QVAnxW+EwVnRqGnUXl
         jt6WiVFhynvvKlWH+JJPPnN9X6CKshF1t0F3I9YYDbVxoiNBZOyT3aOoQxqtOyiachGK
         bGG7safvpugCdZEJTQACrrx9M0MbW599svZS7w043CE9ow0rWKG11oEtjQLqZxByKTDW
         l2AR55fEFUl3pDARsHsJKWAoCui7E78zmrQB9q0O3nMfEtAf9Wu1kdm4+YhlzVr+1yLJ
         MnCQ==
X-Gm-Message-State: AOAM5335prPPnfjIH9Q0WoE5cgDVILK3S+uMzjIc9BtM7CAphs33uTzE
        J7UqbzUl6jz60/0SK6u5l5AlD1rG/k8=
X-Google-Smtp-Source: ABdhPJzAUdYDojZn29RolukKWr9AtU4KZ4x/uooeALLQJ/u5/sl6bXomsXvaUAaS4we7aim7R95cRw==
X-Received: by 2002:a50:8dc2:: with SMTP id s2mr8168695edh.318.1590070976052;
        Thu, 21 May 2020 07:22:56 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id d5sm4862540edu.5.2020.05.21.07.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:22:55 -0700 (PDT)
From:   jnareb@gmail.com
X-Google-Original-From: jnare@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [GSoC] Blog post on reachability queries
References: <20200520163653.GA76552@Abhishek-Arch>
Date:   Thu, 21 May 2020 16:16:42 +0200
In-Reply-To: <20200520163653.GA76552@Abhishek-Arch> (Abhishek Kumar's message
        of "Wed, 20 May 2020 22:07:22 +0530")
Message-ID: <85tv09weyd.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Greetings everyone!
>
> I am working on implementing Generation Number v2. I have written an
> article about reachability queries, which I feel is necessary background
> for understanding the project.

Thank you for your introductory work.  It is always nice to have the
problem to be solved well described.

That said, I am not sure if all this theoretical introduction is needed
to understand the reachability labeling that Git is using, and is the
centerpoint of "Generation Number v2", namely the generation number or
topological level.

> Here's the summary of article:
>
>> Reachability refers to the ability to get from one vertex to another
>> within a graph.
>>
>> Reachability queries are an interesting problem, improving performance
>> for many graph operations. Better and more sophisticated solutions are
>> being created as the size of working graphs keeps increasing.

One caveat: the solution that works for the scale-free small-world graph
like citation network might not work for the commit graph, and vice
versa.  Also, not all algorithms for static graph would work well for
constantly growing history graph (for commit graph).

But it is also what makes it interesting, in my opinion.

>>
>> Reachability for the undirected graph can be found in linear
>> preprocessing and constant query time with disjoint set unions. The
>> answer isn't as evident for a directed graph because of differing
>> performance on positive and negative queries, nature and size of graph
>> and other factors. Topological Levels, Post Order DFS Intervals and
>> Contraction Hierarchies are some of the building blocks for such
>> algorithms.

All right.

>
> In a later article, I will talk about the specifics of generation number
> for Git. In particular, how Git uses reachability queries, the need for
> Generation Number v2 i.e., _Corrected Commit Date With Strictly Monotonic
> Offset_ and other interesting tidbits I come across.

Actually, _Corrected Commit Date With Strictly Monotonic Offset_ variant
of generation number v2 is needed to have *backward compatibility*.  It
turned out that there was a bug in implementing versioning for
serialized commit-graph format, namely that unsupported (newer) versions
of file make Git crash, instead of just not using commit-graph file to
speed up operations.

But it seems that there is a workaround. It happens that if commit graph
file is missing the CDAT chunk, then Git wouldn't use it to speed up
operations, but would not hard fail.  So if we put generation number v2
in a chunk with different name, e.g. CDA2, we would not need backward
compatibility.  Then simpler (and benchmarked) variant of _Corrected
Date_ would be enough.

There are advantages and disadvantages of each approach (assuming that
the second one actually works as described).  The first is more complex,
but backward compatibile with respect to reading (using) commit-graph.
The second is simpler, but old Git using new format would get
performance regression.

> You can find the article here:
>
> https://abhishekkumar2718.github.io/programming/2020/05/20/reachability-q=
ueries.html

Regards,
--
Jakub Nar=C4=99bski
