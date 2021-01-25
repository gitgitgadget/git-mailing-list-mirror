Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C876C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 01:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E7A22B4B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 01:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhAYBEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 20:04:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64352 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAYBEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 20:04:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CF35A8F43;
        Sun, 24 Jan 2021 20:03:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=40C8OebPrzjRasJNiSUVwloAdaQ=; b=s7BRMs
        q99lBY1l5gNIXSoo8ZvEblTBCF/6MCGgUvt3wn+gABVjd/+aDqleZHzmQyaPmCph
        8gyK9c0LIYzktCZriuSzNe244VxFsGRbBiUO113M6rpyzIzUlvIcaN8wGP/uyywt
        VxkaHa7CISm0P49WF1gxnVS/i+rnPZbkKlUrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=thTknKDdXyZ3icbA6qX9rT4jvn7Qh8rt
        j+18MkERo4GDO3ReKF+67xB2wYsPQnJOQkmfXajQLhu9XjTsk3Dd+OyMkeBVch3k
        Q7BCzTn3fBqIKNJrqQiNFKzYE9LGWGgW7ljr06TXn82oxS8emqlIK7+VBKxsU3Py
        7MvB+HxDhg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04600A8F42;
        Sun, 24 Jan 2021 20:03:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81793A8F41;
        Sun, 24 Jan 2021 20:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     brooke@alchemists.io, git@vger.kernel.org
Subject: Re: How to Verify Git GPG Signed Downloads?
References: <B6DFB74D-A722-4DBD-A4B2-562604B21CCB@alchemists.io>
        <022601d6f27a$58a97200$09fc5600$@pdinc.us>
        <YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net>
Date:   Sun, 24 Jan 2021 17:03:56 -0800
In-Reply-To: <YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sun, 24 Jan 2021 21:33:52 +0000")
Message-ID: <xmqqh7n5zv2b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33BDB442-5EA9-11EB-A016-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> $ gpg --list-keys -v 96AFE6CB
>> gpg: using PGP trust model
>> gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
>> gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
>> pub   4096R/713660A7 2011-10-01
>> uid                  Junio C Hamano <gitster@pobox.com>
>> uid                  Junio C Hamano <junio@pobox.com>
>> uid                  Junio C Hamano <jch@google.com>
>> sub   4096R/96AFE6CB 2011-10-03 [expired: 2020-07-26]
>> sub   4096R/833262C4 2011-10-01
>> sub   4096R/B3F7CAC9 2014-09-20 [expired: 2020-07-26]
>> 
>> It is possible that Junio forgot to push his refreshed public key.
>
> Yes, I think that's the case.

Hmph, I was fairly sure I pushed it out when I refreshed the expiry
date sometime early last year, but apparently it did not go through.

I just tried recv-keys from keys.gnupg.net into a throw-away
GNUPGHOME and got the output at the end, so it should be OK now.
Sorry about that.


$ gpg --list-keys -v 96AFE6CB
gpg: using pgp trust model
pub   rsa4096 2011-10-01 [SC]
      96E07AF25771955980DAD10020D04E5A713660A7
uid           [ unknown] Junio C Hamano <gitster@pobox.com>
uid           [ unknown] Junio C Hamano <jch@google.com>
uid           [ unknown] Junio C Hamano <junio@pobox.com>
sub   rsa4096 2011-10-01 [E]
sub   rsa4096 2011-10-03 [S] [expires: 2028-01-11]
sub   rsa4096 2014-09-20 [S] [expires: 2028-01-11]
