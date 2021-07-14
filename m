Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D9C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904B5611C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhGNUOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhGNUOl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:14:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0802C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:11:48 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a7so2834145iln.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=biSlmgy9hFYKI4bXYqsmWQ12VXlA57Mbm/Hhl6tDDXk=;
        b=Dc2L45suDOB8dIb+nsG0t/NRK/lZWARARG7NJkuwF9bb8aOm47iaYUlfq0IV51x8A6
         uN0bUEDVX8m5QxIt8JWdBKwhZnnHm7Ly/PHfOTGBnjr0q/Zqvv9ekb+fq4G1h4g83FCf
         ggAD0VXrMBgaytmkauxO9GcpcEnVVb5QZ3nWlBIpICs75inCBoprRC5Xe7uDnM6uewfB
         RPIkfMZLzkm7Fe8tWzYPq07mGJjjZVNQ0wcaZ6K2eeeoH8VfLoAXoNV54x9BQn0wonkp
         IWv1ZYRXsTWX7iYsLTtFGkj/Wjbf40uolgX/KQLWpQWqlR2h23SGg3MidzQqncwlL5IP
         PyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=biSlmgy9hFYKI4bXYqsmWQ12VXlA57Mbm/Hhl6tDDXk=;
        b=NG2aa0H7cN1NyPo2r+Rg2rct+HrMEP7ebJkFDEMJAni7t97EEC/V/jFJ31d57fxaTj
         aLSMWjLvZtwN8Yi8QJWvbYgUccom0WJTpo36EmBwXhgBdFJapa+ua9+5LvYtANq3l/qI
         HAbq+16VrViNQOowSsphNP7+cuimcR57iXB12aCkBkixgqyVvYI4/V9HQLyERJjO9sMp
         +q+v4dRB3Z03XOpAotsyMy1ZmKJftNBzmXf4y5lGIJhx0Ui5+7RfGGYrM14XqpvtGquj
         OQY8TnVaUS6MmP/oJxjV4mQj438gwHrL5G7JvbJzN7k+A6aSpMIUpBu9YQl8ao074sDz
         Ilpg==
X-Gm-Message-State: AOAM530ociJajjvkA09wxVwSneroob9gzv9b7r62Kp7xFWfvmxGOfUd/
        Vj5LmIymS66nqQ8msZKSaTyZFg==
X-Google-Smtp-Source: ABdhPJzJ3WSRGL2sQ/OyvZE8Q+FdcAL5UW0qve190jeXr+wkJCAyXDeTsglIhJ2chP3GxHupgIejrQ==
X-Received: by 2002:a92:8750:: with SMTP id d16mr8028751ilm.281.1626293508250;
        Wed, 14 Jul 2021 13:11:48 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id w11sm1727973ioj.47.2021.07.14.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:11:47 -0700 (PDT)
Date:   Wed, 14 Jul 2021 16:11:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YO9FAwre6cj958D/@nand.local>
References: <xmqqmtqpzosf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmtqpzosf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> * tb/midx-use-checksum (2021-06-28) 4 commits
>   (merged to 'next' on 2021-07-08 at bbaac9c721)
>  + midx: report checksum mismatches during 'verify'
>  + midx: don't reuse corrupt MIDXs when writing
>  + commit-graph: rewrite to use checksum_valid()
>  + csum-file: introduce checksum_valid()
>
>  When rebuilding the multi-pack index file reusing an existing one,
>  we used to blindly trust the existing file and ended up carrying
>  corrupted data into the updated file, which has been corrected.
>
>  Will merge to 'master'.

Thanks.

I had a moment of panic over my week off that the new code wasn't using
the right hash for non-SHA-1 repositories. But we check that the hash
version the file was written with matches 'the_hash_algo' at runtime,
and we use 'the_hash_algo->rawsz' to determine the end of the contents,
so we're all good here.


> * tb/multi-pack-bitmaps (2021-06-28) 24 commits
> [...]
>
>  The reachability bitmap file used to be generated only for a single
>  pack, but now we've learned to generate bitmaps for history that
>  span across multiple packfiles.
>
>  Comments?

I would definitely appreciate some more comments, but I have only
sporadically been keeping up-to-date with this series. Ævar sent some
suggestions which I've been replying to today as I catch back up, but
they appear mostly cosmetic (at least, the ones that I've read so far).

I think at this point I'd want a deep review from somebody familiar with
bitmaps before re-rolling. Peff and I have both looked over the series
exhaustively within GitHub, but the clean version submitted here should
definitely be checked before merging.

I'm not in a big hurry to merge this, but there are some other good
topics that are built on top (and it makes working on other bitmap
related things kind of a pain since there are two choices for what to
base it on).

Thanks,
Taylor
