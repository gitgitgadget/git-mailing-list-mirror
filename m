Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD6F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934785AbeB1Uue (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:50:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53326 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934682AbeB1Uua (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:50:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id t74so7612236wme.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ket9aDDsYQ6mjwB0UXyHgXhbkNlekJSV0GqtgGGTUyw=;
        b=uIWtXn61EZiZ+qJ/W0mhSOBow8jUr8F7wKFWSpopPIJFnjdojA4nRS15kak4ikgqCi
         OkJ9m/w1PgtEN/mzAdGfonq8YJJyUoUUUEYXwvg9UpyFKLjk9Oi2JpSDVE2Fajmwu6tM
         PljsbA11mNL2iGHJXXlG11h5SJUDCAO+X91R/hoEbU1f/V052sOVVeGybKXuKrT1697a
         a5pFGtIY6r19qjMrUMa7KaGwiNStgpflgQ2SxfK9y/9CAj4j2VtMj6Lr+Wr4acLCqQgS
         jOA9z97z89V55Br7GmHe8daZiH9Bv3inabASiSjnN5YbBWg4sGP4v9JdRghSpBx/RjLr
         heiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ket9aDDsYQ6mjwB0UXyHgXhbkNlekJSV0GqtgGGTUyw=;
        b=NYVMRQSUcjcoLrCZKYccSv1JXxPB6MhFQ1HFx+OqmbWOFDSI+e+FIaVDnx5BxSE8uM
         HiOpMYu0KN5RL1MVbd9UbSZNTjKEMHYcM7bdublAEkeBNHIZvjmT6GJeQQmVLRhjsIdI
         4uaDKJlcCv0vpdiujwX6GIHa6fZ5rn33aNijlS24LQjF5X+nqpM4DWl4LCZGiFI5ml0a
         pgkVBw/E4YPkQhJDidqoY2CciXWJ0uNBjkYosI7NUKK5b1E9YlaHkgRHlkgJqctWyOPE
         8z+3Y3BJVcba+yRRnySJCbyHp2V7qQiiyG1UwANw5xaOU/8TNeesHYAT9HcIqlfcvUr+
         XuwQ==
X-Gm-Message-State: APf1xPDjRuSkeliCn34XpIT3srEKmPM/B0fCK46Wd/eOgwRJqBjW8I7l
        nCPeCTo00s3gmuAU2NAkp0Q=
X-Google-Smtp-Source: AH8x225+tOxKIi1cKAfCp1Zj10z3Uz6mCl0m094mZ3Zacb8E4LjIGi26oSaAiPKddipRApxR6mxvYA==
X-Received: by 10.28.126.20 with SMTP id z20mr14667902wmc.152.1519851029252;
        Wed, 28 Feb 2018 12:50:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h197sm2149037wmd.17.2018.02.28.12.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 12:50:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v2] sha1_name: fix uninitialized memory errors
References: <20180226204151.GA12598@sigill.intra.peff.net>
        <20180227114704.193145-1-dstolee@microsoft.com>
Date:   Wed, 28 Feb 2018 12:50:28 -0800
In-Reply-To: <20180227114704.193145-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 27 Feb 2018 06:47:04 -0500")
Message-ID: <xmqqy3jckfe3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..a041d8d24f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -547,15 +547,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>  	 */
>  	mad->init_len = 0;
>  	if (!match) {
> -		nth_packed_object_oid(&oid, p, first);
> -		extend_abbrev_len(&oid, mad);
> +		if (nth_packed_object_oid(&oid, p, first))
> +			extend_abbrev_len(&oid, mad);
>  	} else if (first < num - 1) {
> -		nth_packed_object_oid(&oid, p, first + 1);
> -		extend_abbrev_len(&oid, mad);
> +		if (nth_packed_object_oid(&oid, p, first + 1))
> +			extend_abbrev_len(&oid, mad);
>  	}
>  	if (first > 0) {
> -		nth_packed_object_oid(&oid, p, first - 1);
> -		extend_abbrev_len(&oid, mad);
> +		if (nth_packed_object_oid(&oid, p, first - 1))
> +			extend_abbrev_len(&oid, mad);
>  	}
>  	mad->init_len = mad->cur_len;
>  }

I do not think they are wrong, but aren't the latter two somewhat
redundant?  "num" is p->num_objects, and we call (first+1)th element
only after we see (first < num - 1), i.e. first+1 < num, and the
access to (first-1)th is done only when first > 0.  The first one,
i.e. when first points at where we _would_ find it if it existed,
can access "first" that could be p->num_objects, so the change there
makes sense, though.

