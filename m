Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D1C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 02:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbiBUCp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:45:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiBUCpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 21:45:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8BD27169
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:45:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d19so3871648ioc.8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6VpuNWP8JHeVczj99cfLViUtNoYBn2I1XBzDmJ+saP8=;
        b=sJINejDo99QvekM23Eofcj/uD+f/y3CKHun8bB7kte+tb05HJxRnYIMsHm3+K0PLFD
         ins1zIcQoN7n7nvQ/BGhr4y+ODr4wbVR5g7CpoB6tX8O4DHoXgbR4tYPQ8/Fuj+JtNDO
         TmhOMwvutxJsUufbq6PTBHRSUYsthBuwiBqGQqWOl+nSsI5uLyC9oRdvCgwD9vD+R1I/
         JXBwxmJWKMPNArvaeFiTEMnyZheT+5AqCgJkh3NVROkRcN4TViWSSjO6vUGa8Jm0SzuQ
         K1znU5p7fZ9Z/OR1Y/BTjr0k1IvpjOxkXbDC8Qk7UyfvY3RF/tU9qx4jzpZT979klP81
         JwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6VpuNWP8JHeVczj99cfLViUtNoYBn2I1XBzDmJ+saP8=;
        b=xy7SyzEZrZblzawdenLYaWH5p6OKXRUWILek/6oNENuDytF96fcikeU/5PL1Yt5i2q
         E/hiuFDc45Pp3uzO21f9C/Op8xL17cU9aU7J42nbR/eJlixmYPXROrBQP97V1us+SCFa
         B70+iBOdF9SUAkchWTzbLiURFNsgFvOjKV0sfUEyjlXkJw9+nXG7VHDrjEbUbMor2uKN
         IBiF8r+KbpKwyHzc97hXLtAxmdgzT/T+IlUJP9KK1guED/bVNDdQihepOyJleroWVs4z
         Dmp9SQysVdjrKNQ0dPCzGdUY4635IAevJgyyTdL4TVLZ1Epgj2ZcBc+2xYXDflNbcSOA
         EMoQ==
X-Gm-Message-State: AOAM5303e9fQuJgBqo7/AL47coZPG07NmGPRuJhzYFb2aAFYGzr1qzJi
        owxdAFc3+nilb+Yj4heafuXo3IJ8dV5dLVom
X-Google-Smtp-Source: ABdhPJxZmCEQz+XQdHS3UnmyLKDDO2wMOxBh6mpAxViZGQLOc/3aBLXh9XP6WvBfInJO9aoKLzTW4g==
X-Received: by 2002:a02:c6c9:0:b0:308:3586:f407 with SMTP id r9-20020a02c6c9000000b003083586f407mr13964487jan.173.1645411503027;
        Sun, 20 Feb 2022 18:45:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r7sm5195220ilc.24.2022.02.20.18.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:45:02 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:45:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
Message-ID: <YhL8rmsnnLZhMTJL@nand.local>
References: <20220218223212.1139366-1-jonathantanmy@google.com>
 <xmqq35kdugzt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35kdugzt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:48:38PM -0800, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > +test_expect_success '--stage' '
> > +	# In order to test hash abbreviation, write two objects that have the
> > +	# same first 4 hexadecimal characters in their (SHA-1) hashes.
>
> What about linux-sha256 jobs?
> e.g. https://github.com/git/git/runs/5267681569?check_suite_focus=true

Yeah; this is indeed broken. See the discussion beginning at [1] for
some options.

[1]: https://lore.kernel.org/git/220219.868ru7fsad.gmgdl@evledraar.gmail.com/

Thanks,
Taylor
