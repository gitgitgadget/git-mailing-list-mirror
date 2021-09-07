Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FE1C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8926112F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbhIGTuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:50:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55944 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbhIGTuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:50:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB034144371;
        Tue,  7 Sep 2021 15:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tz95d7HyVb0D77pMAuI7FopYuNfpFAbCYguZSx
        YkC3g=; b=lnrMdahVXJUkJDDqE5qh75JE1Zi2mNUgV24Bz8wJxifBiIGw1+3CFw
        IjsO88JMcdIzN7XTWuxC1q67cU76fryohnFZRtf8GFoZpvqcfyNzw3phaHNEevPw
        IE253uVzm6ii8mf0b2S56F2P1D8iWryAfsZU/CWXJpKlMM5/NSuGE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3011144370;
        Tue,  7 Sep 2021 15:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02D7D14436E;
        Tue,  7 Sep 2021 15:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: expired key in junio-gpg-pub
References: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
Date:   Tue, 07 Sep 2021 12:49:00 -0700
In-Reply-To: <YTerpXCxYx+f+8ws@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 7 Sep 2021 14:12:53 -0400")
Message-ID: <xmqqbl54b1zn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A67D2F9A-1014-11EC-9A80-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It looks like your signing key is expired, and tag verification fails:
>
>   $ mkdir /tmp/foo
>   $ export GNUPGHOME=/tmp/foo
>   $ git cat-file blob junio-gpg-pub | gpg --import
>   gpg: WARNING: unsafe permissions on homedir '/tmp/foo'
>   gpg: keybox '/tmp/foo/pubring.kbx' created
>   gpg: key 20D04E5A713660A7: 27 signatures not checked due to missing keys
>   gpg: /tmp/foo/trustdb.gpg: trustdb created
>   gpg: key 20D04E5A713660A7: public key "Junio C Hamano <gitster@pobox.com>" imported
>   gpg: Total number processed: 1
>   gpg:               imported: 1
>   gpg: no ultimately trusted keys found
>
>   $ git tag -v v2.33.0
>   object 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
>   type commit
>   tag v2.33.0
>   tagger Junio C Hamano <gitster@pobox.com> 1629141357 -0700
>
>   Git 2.33
>   gpg: WARNING: unsafe permissions on homedir '/tmp/foo'
>   gpg: Signature made Mon Aug 16 15:15:57 2021 EDT
>   gpg:                using RSA key E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB
>   gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [unknown]
>   gpg:                 aka "Junio C Hamano <junio@pobox.com>" [unknown]
>   gpg:                 aka "Junio C Hamano <jch@google.com>" [unknown]
>   gpg: Note: This key has expired!
>   Primary key fingerprint: 96E0 7AF2 5771 9559 80DA  D100 20D0 4E5A 7136 60A7
>        Subkey fingerprint: E1F0 36B1 FEE7 221F C778  ECEF B0B5 E886 96AF E6CB
>
>   $ echo $?
>   1
>
> Have you extended the expiration on it? I wasn't able to find any
> updates on the keyservers I checked. But regardless, we should probably
> ship an updated one via the tag.

I am reasonably sure that I've done update with pgp.mit.edu when I
refreshed the expiration last time, but apparently I didn't update
the in-tree copy.  I doubt that it is a good practice to ship the
public key used to sign things in the repository in the repository
itself, but if are not dropping the tag, I agree I should keep it up
to date.

Thanks.


