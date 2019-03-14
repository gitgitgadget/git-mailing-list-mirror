Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7275D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 01:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCNB3x (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 21:29:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfCNB3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 21:29:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so3521105wre.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pF8uTv+o2h8d/ghw48uH8HlCAVSHqcfV/xpxm06tMS0=;
        b=hXavIddXGr2NrSxrZc5vbgXkVYRn34pWJjm/dGAa09l+MpxVVLS8Wcg7/ZTveJeNHL
         5RgpVDzLFIU+SQzW2a3LUqwaY5O+/o1gK0z4J6AM+VPPpAD/PdR0m73fxUzzIqmix24o
         izYneLDU3VieHEQtxD7C8zjQGbmO53WxCMAt939SYsQCaEK9Sng+SmckvptKjuLaPZnH
         /AO6rCyxD11pTSU4y7fGKAIxDbH2EAjH4vTFsLC3EKU8zM4I5WC8v0hOlGBjX2F5/+jR
         8/lnBVLz9HNFEyyQz2jOvoapXy17Q5ARmTLzZailEsHKp12fMkbgwatAcuQdU8trTnXI
         ZgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pF8uTv+o2h8d/ghw48uH8HlCAVSHqcfV/xpxm06tMS0=;
        b=gNfXirnJnTCqNV2iIM43s0MM0VgHA3Zyh7C8i2iNXS5w+stw3bEx+JGX71HCHM45GX
         gDbPvogW+bT7sRalnuJmPdMOO02faHHcdPbmDLViGbJ4jeTHHv/L2Ff0i61GqpGOfBPj
         Pi4TngttJtUdIWrLfSy4scY3GhGH5RMVxdcMxJ8RZD5DdfaO/UZEwKosIej2THN2CxS5
         UPLvcIhqKX3QtmpkpqJRfPepHzNLjbudUC1KdXxQNUbrPpQeTyCV7xfsy49lVAmfh3vN
         2w6uMlnEDvxKwR798bf8ITIvgUD2utTvkdep2tWLXjSyYIf0uPX69jBe8RXxOuktOLod
         l5dg==
X-Gm-Message-State: APjAAAXsXE8IykAfAC9/JnjMSyLNM8KscMPnctIxeuQXPQ7oquT6TfFc
        RoUoDc9jD62R/P01R39X55c=
X-Google-Smtp-Source: APXvYqx+Z+sk9NI1ePQmlg47F9v72GRQKISzz7yZSUJJHpbXeuJ9gONCMmwQgu3XW5ynNeZMUCht0g==
X-Received: by 2002:adf:efca:: with SMTP id i10mr29560261wrp.265.1552526990902;
        Wed, 13 Mar 2019 18:29:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z12sm403211wmf.31.2019.03.13.18.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 18:29:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
References: <pull.161.git.gitgitgadget@gmail.com>
        <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Mar 2019 10:29:49 +0900
In-Reply-To: <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Mar 2019
        03:16:34 -0700 (PDT)")
Message-ID: <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -442,6 +442,18 @@ static enum get_oid_result get_short_oid(const char *name, int len,
>  	find_short_packed_object(&ds);
>  	status = finish_object_disambiguation(&ds, oid);
>  
> +	/*
> +	 * If we didn't find it, do the usual reprepare() slow-path,
> +	 * since the object may have recently been added to the repository
> +	 * or migrated from loose to packed.
> +	 */
> +	if (status == MISSING_OBJECT) {
> +		reprepare_packed_git(the_repository);
> +		find_short_object_filename(&ds);
> +		find_short_packed_object(&ds);
> +		status = finish_object_disambiguation(&ds, oid);
> +	}
> +

This looks obviously correct, but two things that made me wonder
briefly were:

 1. is reprepare_packed_git() a bit too heavy-weight, if the only
    thing we are addressing is the loose-object cache going stale?

 2. is there a way to cleanly avoid the three-line duplicate?

My tentative answers are (1) even if it is, but get_short_oid() is
already heavy-weight enough; it won't be worth restructuring the
code to make it possible to clear only the loose-object cache, and
(2) a loop that runs twice when the first result is MISSING_OBJECT
and otherwise leaves after once would need an extra variable, its
iniialization, check and increment, which is more than what we might
save with such a restructuring, so it won't be worth pursuing.

But others may have better ideas, as always ;-)
