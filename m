Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CCBC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 21:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjARVit (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjARViq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 16:38:46 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A33C24
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:38:43 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i70so103082ioa.12
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wckq57w3Ypm83APNhOxWZWrVID+/gYXJ/CjN4i1nRwU=;
        b=atPnM1PWSwi8+uyGw5rRL0zKQRM8NKoYgKkFEVPj+pMLiyyEcA/Os65PAxqbsGXRkE
         TuFa7sBCyaWqCHxAz3D8L1Sy/NnvCLWwnkTr9pFo0q/2hdtVTNy6IbzMz+1wDnZAFNhr
         30yCr0n7xgmQFl4trj16/cq4zeeF7VCwuhjUix0356GkpxILq+qSQ7PO6bmRfE8VieLe
         PsJg9ytKZAYTJWgdbhv6ZaOqwDyl1hCcgAyHe203vvHTt5bcftTwXuHvGniMrb1rreHB
         9c6mliWkPfHFtO6IfNfL9zF7T73zyVzAwD+f/7HVz7Tt+RW9+YuvCZjs7eLK24AmtaOT
         SnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wckq57w3Ypm83APNhOxWZWrVID+/gYXJ/CjN4i1nRwU=;
        b=IrOmZ+nNDyUoy1s1qeaexb9lTvO0aTuqJwyjGsQaeHV5wUyYwscsGOus2m3sReUmFm
         aww7YMv8JDS8KU3/tvj8XQ3LEwgWrvnkQMup4wT3KKnTIBhg1BcJZJ37y4ogU4nY9lEn
         WXyLL0tAfe/Kci+RouEz9juFV5ZtjREOfVoj7UdUcq/asMIp8TTgC0wHltY2UBZCpCIU
         OR2iDrA9y0g17U2k/ZddsjLnHZIxA0mXylrAjYCFpk7L7k+sI6ovhORb4XY59sS6BAb1
         rjaWPVOFkVmAVaLU2Nx4gk5w0t0jS7RrJWBFpHqw+cQoDGK5f06AXRHmtsSuiBneIQVL
         8Z4A==
X-Gm-Message-State: AFqh2kpAgyoos4qYVtd7npgAp+M3Dj/P9MoATzx8ZcD1gyZ9VkYlNd/q
        KMulLLUjYpJfcmUTWpI3cfSWc5HEYkl4uGsw7tg=
X-Google-Smtp-Source: AMrXdXv9xbv/54gSTWUr5ZGaeUmplcG2teha4l/7TfEGAlmp70JWkRRGu2hMUm5FJWrDK2P/zhrzvw==
X-Received: by 2002:a6b:751a:0:b0:6e3:f1da:fe9a with SMTP id l26-20020a6b751a000000b006e3f1dafe9amr5613908ioh.18.1674077923096;
        Wed, 18 Jan 2023 13:38:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y18-20020a056602049200b006de73a731dbsm865165iov.51.2023.01.18.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:38:42 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:38:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Message-ID: <Y8hm4KKVwguGGrdn@nand.local>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <xmqqmt6f4l03.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt6f4l03.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 12:59:24PM -0800, Junio C Hamano wrote:
> The --literally option was invented initially primarily to allow a
> bogus type of object (e.g. "hash-object -t xyzzy --literally") but I
> am happy to see that we are finding different uses.  I wonder if
> these objects of known types but with syntactically bad contents can
> be "repack"ed from loose into packed?
>
> >   [5/6]: fsck: provide a function to fsck buffer without object struct

It is indeed possible:

--- >8 ---
Initialized empty Git repository in /home/ttaylorr/src/git/t/trash directory.t9999-test/.git/
expecting success of 9999.1 'repacking corrupt loose object into packed':
	name=$(echo $ZERO_OID | sed -e "s/00/Q/g") &&
	printf "100644 fooQ$name" | q_to_nul |
		git hash-object -w --stdin -t tree >in &&

	git pack-objects .git/objects/pack/pack <in

Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
06146c77fd19c096858d6459d602be0fdf10891b
Writing objects: 100% (1/1), done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
ok 1 - repacking corrupt loose object into packed
--- 8< ---

Thanks,
Taylor
