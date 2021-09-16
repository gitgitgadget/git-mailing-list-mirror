Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C91C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95E160F6E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhIPTl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhIPTl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:41:58 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74DC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:40:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d11so3869804ilc.8
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wCIdYT7VjiVtRZglBPr42pYUk1zDO8KyT9C3HB7l6Z8=;
        b=hqlRSXPpTB6HfNgJ7jQAhL0r/PmopRvHSD0Sk0z067Rm97IIeg3yrHv3eT4pGme+rb
         cuH47r5PJYjFKwfIB3i2XFWEYJEKDD8UU8endHwgaP78TZln8TE0n9+Xms4mlj1HivhU
         ahwBMhpwb62SD+GmRHd5XqL7GSWKoDRqMRZbpRLWlU71B/QGUFJ/0HQ3h+39MusTQETe
         wuYNAPI/O6xjLIfbogdMRz2XA28KcWL96a710G4uURYWyHdkEexruefLrcFPQd1AAoMe
         31B5RUQOETLYmRU5t0gRhl/elb2g+wgxL2+gkmEj2jpHZB9ALjxfpOhsagzZmCf2zS2A
         ps4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wCIdYT7VjiVtRZglBPr42pYUk1zDO8KyT9C3HB7l6Z8=;
        b=yeloqE0JRDpjHMEb2RY0nR7nSezEJMn4S2GshkURokiDsuIIA5/2mE8FmQTt3T7A64
         /q6+Hcq53lWVklrNQukQ0WEUHDD2D5zZXlwh8JnIePJBRThcLXqbI5fU+WEArV9BWOlj
         jL9Zi8LnT3e8CDQJw5bxYo6jgh5IH3tJXkMgpsGojox2fSXPoXNFEduQpsh+o2G9mlpS
         DDcnAkQFJp2eWGOVJ3IHhktc/CexFq7s01bw/XS58SVYl6r7K1P2MgHiw8D65q51lQ+d
         E1QcVYPZtw5j2jWp5cOIZrz8AkrzD0uo5CvDouaISu2N4gHuHNCiD+UUYSXwgRM7+Xhi
         FxyA==
X-Gm-Message-State: AOAM530NpNdItB3fUt4Oao9Ca+/o/EFaL/aoP1ZSAssObAKfx0PC7Gri
        W4rPnR9Dor/FCY3m8sTUzZs6rg==
X-Google-Smtp-Source: ABdhPJwuo6sO8LrxoeXZeBe5Do+WRe0AF2cLTm4cX01KXhfwbJTJYolU/5+AyQDZIToAb17EysE6gw==
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr4881780ilv.70.1631821236632;
        Thu, 16 Sep 2021 12:40:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15sm2260107ila.34.2021.09.16.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:40:36 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:40:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 01/22] fsck tests: refactor one test to use a sub-repo
Message-ID: <YUOds4kcHRgMk5nC@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-01.22-ebe89f65354-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-01.22-ebe89f65354-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:57:56PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Refactor one of the fsck tests to use a throwaway repository. It's a
> pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
> teardown of a tests so we're not leaving corrupt content for the next
> test.

OK. I seem to recall you advocating against this pattern elsewhere[1], but
this is a good example of why it can sometimes make writing tests much
easier when not having to reason about what leaks out of running a test.

[1]: https://lore.kernel.org/git/87zgsnj0q0.fsf@evledraar.gmail.com/,
although after re-reading it it looks like you were more focused on the
unnecessary "rm -fr repo" there and not the "git init +
test_when_finished rm -fr" pattern.

> -test_expect_success 'object with bad sha1' '
> -	sha=$(echo blob | git hash-object -w --stdin) &&
> -	old=$(test_oid_to_path "$sha") &&
> -	new=$(dirname $old)/$(test_oid ff_2) &&
> -	sha="$(dirname $new)$(basename $new)" &&
> -	mv .git/objects/$old .git/objects/$new &&
> -	test_when_finished "remove_object $sha" &&
> -	git update-index --add --cacheinfo 100644 $sha foo &&
> -	test_when_finished "git read-tree -u --reset HEAD" &&
> -	tree=$(git write-tree) &&
> -	test_when_finished "remove_object $tree" &&
> -	cmt=$(echo bogus | git commit-tree $tree) &&
> -	test_when_finished "remove_object $cmt" &&
> -	git update-ref refs/heads/bogus $cmt &&
> -	test_when_finished "git update-ref -d refs/heads/bogus" &&
> -
> -	test_must_fail git fsck 2>out &&
> -	test_i18ngrep "$sha.*corrupt" out
> +test_expect_success 'object with hash mismatch' '
> +	git init --bare hash-mismatch &&
> +	(
> +		cd hash-mismatch &&
> +		oid=$(echo blob | git hash-object -w --stdin) &&
> +		old=$(test_oid_to_path "$oid") &&
> +		new=$(dirname $old)/$(test_oid ff_2) &&
> +		oid="$(dirname $new)$(basename $new)" &&
> +		mv objects/$old objects/$new &&
> +		git update-index --add --cacheinfo 100644 $oid foo &&
> +		tree=$(git write-tree) &&
> +		cmt=$(echo bogus | git commit-tree $tree) &&
> +		git update-ref refs/heads/bogus $cmt &&
> +		test_must_fail git fsck 2>out &&
> +		test_i18ngrep "$oid.*corrupt" out
> +	)
>  '

This all looks fine to me. The translation is s/sha/oid and removing all
of the now-unnecessary test_when_finished calls.

But the test_i18ngrep (which isn't new) could probably also stand to get
cleaned up and converted to a normal grep.

Thanks,
Taylor
