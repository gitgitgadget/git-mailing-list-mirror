Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947151F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 02:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLCyZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 21:54:25 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45420 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfKLCyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 21:54:24 -0500
Received: by mail-pf1-f201.google.com with SMTP id a14so14278871pfr.12
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 18:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0RJOwLotpk4IGkfgAtnIJqNnW0v9qRrt3XaFTbjFRCY=;
        b=vqk6Nan2hAyUzSktcrz4lpTvXnup4TGrMpmcZI31BXXNiXdGj9qYC4KQJCIH3H4I6B
         qUX2mBFr6INt0JKdZEg+kE+sfLrfYKCUPgkwUbs/XNkeehm2ktYzcwtCWJyEOe6WQUCK
         ba3F/RlPlnnuNiOxl9k5hYID1NDn67I7+CYG6PJaPNNQjxKjo7TrD8XYQmoh1BhtbNH4
         BfA0Cx8TSnzGGDTf67R/jcUsosF6jRViFgE3UawxQO7T7mY09PNLQWYR7/cpUfOJxbIx
         gNzjBYmjZqOqACXHHgjaAaBbI0z00417ScH/o7rKJDjm4Op+XdbBvjITuEwsu6A8kast
         B0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0RJOwLotpk4IGkfgAtnIJqNnW0v9qRrt3XaFTbjFRCY=;
        b=KAcTjq+1Zp8iu+IsGLomBeha2vYRA2zF5nhdMIG64xncTKYa2z1J4jIiyuau2MfzDu
         Q2bE4XyjY2+pC3qP+k3NpHoTdqLF9iOFkLsQofy4xSF0SyYutQdEwRyElOiE8jMMjmmx
         xax2QVFBI3wa2iEhmqDWnqxvYqt/7+azKmrmbVJVcG+9ctsOMryIxEMHTrJO64+1MbuB
         pQurhNDS2FDz/EwvDI6hbNWTxCte563bGrT1pWqSacwOtj/YBztQ+6ue200MyG+cvm0+
         C18OaGbqADwF5MgNNkCP/S98U57my9aryRoTxWl6knnZJ2HBlDjtDB4xGGSlQ5lEvxXK
         lMdg==
X-Gm-Message-State: APjAAAVKu1j/qEvhWIpXNhMYPOPj4YlTFdWeXS5kEb+oPWxrF8CzxHoH
        UjjNX4v72Z2BbKjmGOBcIAmvgv4tOy4+ueb6XmOH
X-Google-Smtp-Source: APXvYqzlpxonTUloPEQPhH7fvwlAPtIv2XhRLCWoLF2Gniu73/1h3f8W+wSPtCNeyQpTwtQZkPSasDJ57Ivz17Uji12w
X-Received: by 2002:a63:e407:: with SMTP id a7mr14647754pgi.92.1573527263548;
 Mon, 11 Nov 2019 18:54:23 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:54:18 -0800
In-Reply-To: <4c5652ab34f0989856aba919ca84b2b091dcad98.1569808052.git.matheus.bernardino@usp.br>
Message-Id: <20191112025418.254880-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <4c5652ab34f0989856aba919ca84b2b091dcad98.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object reading
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matheus.bernardino@usp.br
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        jrnieder@gmail.com, stefanbeller@gmail.com,
        jonathantanmy@google.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1580,7 +1585,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
>  	do {
>  		in = use_pack(p, w_curs, curpos, &stream.avail_in);
>  		stream.next_in = in;
> +		obj_read_unlock();
>  		st = git_inflate(&stream, Z_FINISH);
> +		obj_read_lock();
>  		if (!stream.avail_out)
>  			break; /* the payload is larger than it should be */
>  		curpos += stream.next_in - in;

As I see it, the main purpose of this patch set is to move the mutex
guarding object reading from builtin/grep.c (grep_read_mutex) to
object-store.h (obj_read_mutex), so that we can add "holes" (non-mutex
sections) such as the one quoted above, in order that zlib inflation can
happen outside the mutex.

My concern is that the presence of these "holes" make object reading
non-thread-safe, defeating the purpose of obj_read_mutex. In particular,
the section quoted above assumes that the window section returned by
use_pack() is still valid throughout the inflation, but that window
could have been invalidated by things like an excess of windows open,
reprepare_packed_git(), etc.

I thought of this for a while but couldn't think of a good solution. If
we introduced a reference counting mechanism into Git, that would allow
us to hold the window open outside the mutex, but things like
reprepare_packed_git() would still be difficult.

If there's a good solution that only works for unpack_compressed_entry()
and not the other parts that also inflate, that might be sufficient (we
can inflate outside mutex just for this function, and inflate inside
mutex for the rest) - we would have to benchmark to be sure, but I think
that Matheus's main use case concerns grepping over a repo with a
packfile, not loose objects.
