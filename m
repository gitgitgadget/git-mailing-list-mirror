Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21381FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdBJWoA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:44:00 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36791 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdBJWn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:43:59 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so4020815pgf.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mbj9m1tBnijoZAtHf+hVAI3wS2tE6k3yuRwddGzXe1U=;
        b=ahR/2M+EdDdMiu0pi41WfciLidXDG9/wvDkqTUc5+aN6RMBcrPxm/urZbOQ9h1fyGI
         a+dxg+Jmf3Jllbc2FddlpXd38VqRcUZ+HOs/U+I0NjMnvV9IsF4QKXNzPaYXucci0zMz
         wc7CUs6VMjU1gh6VhE5m+Ae7HEb2UtkEyKzXFQFr6PMi7SBc1GniZ4SBB2Dq4HImM50P
         dolRqSegwvMqksFsm4u28azv/xvpaHC4KQy8pVGkXJ8RcAr3i0R8lg0MhwUJFGtKnAqd
         SQCQb/UDj4Ul640ow1m7rUN2sMiRurKOm6wCU19yzhC7IJOenGuAjsJC1zs/TH+pLJ9+
         ujyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mbj9m1tBnijoZAtHf+hVAI3wS2tE6k3yuRwddGzXe1U=;
        b=r/8Bp6teNbjr4I7CL+T7FopiPmPa/pjCj1T+Au8VnUB11rdDEt92zYHmGfjbb+d+SV
         PVD7/65WHqF0shYGDWKRh7qe/IO3+SVjIBI+KLsyXv49ZBK9LoVvt3oDB418UT/6YakA
         2NULtQ483eZNATBIa8Dzf9Dvnpcp1YFi6anmwphO6ahIX2XDwyLJO0oyiWdnGxunNukN
         p7TWfa/brr9zaMwlVszpNCQPuMx1aAAvrJY+i1++nv4SqOdh7y7FEtL4zzrSuCRLliwj
         NYl/AA/AEXPB60BMDq42U5AkYQCKVy4oH4GsFUwtOJazZ/aJbvdL3Ym9DTFtkic2D9jp
         pmdg==
X-Gm-Message-State: AMke39nlnDTRy+2uU0jzgDsP73lsP+3dLJrKdVVtj4TqJMVHmq4mmlAoy9nV5u0wPSlgyQ==
X-Received: by 10.84.209.203 with SMTP id y69mr14441058plh.115.1486766638898;
        Fri, 10 Feb 2017 14:43:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id 191sm7475123pgd.40.2017.02.10.14.43.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:43:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] preload-index: avoid lstat for skip-worktree items
References: <a1297b9426e7980f41e9e662fc0f30717c576c3e.1486739428.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Feb 2017 14:43:57 -0800
In-Reply-To: <a1297b9426e7980f41e9e662fc0f30717c576c3e.1486739428.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 10 Feb 2017 16:10:39 +0100
        (CET)")
Message-ID: <xmqqpoipis42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Teach preload-index to avoid lstat() calls for index-entries
> with skip-worktree bit set.  This is a performance optimization.
> ...
> diff --git a/preload-index.c b/preload-index.c
> index c1fe3a3ef9c..70a4c808783 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -53,6 +53,8 @@ static void *preload_thread(void *_data)
>  			continue;
>  		if (ce_uptodate(ce))
>  			continue;
> +		if (ce_skip_worktree(ce))
> +			continue;
>  		if (!ce_path_match(ce, &p->pathspec, NULL))
>  			continue;
>  		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))

Because we are only interested in marking the ones that match
between the index and the working tree as "up-to-date", and we are
not doing the opposite (i.e. toggle "up-to-date" bit off by noticing
that things are now different) in this codepath, this change does
make sense.  The ones marked as "skip", even if there were an
unrelated file or directory at the path where the index expects a
regular file, can be safely ignored.

Thanks.

