Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B13FC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1A123A1B
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YSAKo2aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVQ11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 12:27:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51466 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVQ10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 12:27:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D46E88DC5F;
        Tue, 22 Sep 2020 12:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gw/CwIRo5Biraal8YZLLLyeQa0g=; b=YSAKo2
        aaB4NB7MrR7fpztW0ZWiUnWOhObPYIULpka32JuNA0Awi7nnpuFybc0KCyX+3sfp
        cNS1WcnDr7P60JD2f6e+Xr3VV7h13rzuU7pvxlHD4tabsoyUNj6b98UzfsNIn52C
        RnIo44Bh0L+7deP0d/f/x2x03jrVzb+LI2W9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ugvPK1wArT7DztRoECdfEQGjdYaqowJO
        vE0EJ2SFf60WMrvzmyz0JMkibfRczNe9O00jeojHb3cAyjvWCSOgR1mEAlmJpmOf
        fDcHh/zsY6UYL7I1aZJlV05/i0J09LYtdnr12fTSqnTBzF4Coyw2lLJZhHzgODWc
        O2zDINskP6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC9F98DC5E;
        Tue, 22 Sep 2020 12:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D2C08DC5D;
        Tue, 22 Sep 2020 12:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v3] builtin/clone: avoid failure with GIT_DEFAULT_HASH
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
        <20200920223541.1299038-1-sandals@crustytoothpaste.net>
        <xmqq4knrhhzx.fsf@gitster.c.googlers.com>
        <20200922091717.GP67496@camp.crustytoothpaste.net>
Date:   Tue, 22 Sep 2020 09:27:21 -0700
In-Reply-To: <20200922091717.GP67496@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 22 Sep 2020 09:17:17 +0000")
Message-ID: <xmqqa6xhlqty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DEEB39C-FCF0-11EA-B173-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-09-21 at 04:27:14, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > +test_expect_success 'clone with GIT_DEFAULT_HASH' '
>> > +	(
>> > +		sane_unset GIT_DEFAULT_HASH &&
>> > +		git init --object-format=sha1 test-sha1 &&
>> > +		git init --object-format=sha256 test-sha256
>> > +	) &&
>> > +	test_commit -C test-sha1 foo &&
>> > +	test_commit -C test-sha256 foo &&
>> 
>> Unfortunately, the 'foo' commit is created in test-sha1, but the
>> next step to create 'foo' in test-sha256 fails with
>> 
>>         fatal: unknown repository extensions found:
>>                 objectformat
>
> I'm not seeing that with this series based on master
> (385c171a018f2747b329bcfa6be8eda1709e5abd).  I'm doing this:
>
>   make -j6 all && (cd t && GIT_TEST_DEFAULT_HASH=sha256 ./t5601-*.sh --verbose)
>   make -j6 all && (cd t && GIT_TEST_DEFAULT_HASH=sha1 ./t5601-*.sh --verbose)
>
> And getting this output:
>
>   Initialized empty Git repository in /home/bmc/checkouts/git/t/trash directory.t5601-clone/test-sha1/.git/
>   Initialized empty Git repository in /home/bmc/checkouts/git/t/trash directory.t5601-clone/test-sha256/.git/
>   [master (root-commit) 946e985] foo
>    Author: A U Thor <author@example.com>
>    1 file changed, 1 insertion(+)
>    create mode 100644 foo.t
>   [master (root-commit) ff872d8] foo
>    Author: A U Thor <author@example.com>
>    1 file changed, 1 insertion(+)
>    create mode 100644 foo.t
>   Cloning into 'test-clone-sha256'...
>   done.
>   Cloning into 'test-clone-sha1'...
>   done.
>   On branch master
>   Your branch is up to date with 'origin/master'.
>   
>   nothing to commit, working tree clean
>   On branch master
>   Your branch is up to date with 'origin/master'.
>   
>   nothing to commit, working tree clean
>
> Is there something I'm missing here?

I think the issue was because I queued the patch on the same base as
the previous round, which was v2.28.0.  Whe applied to 385c171a
(Fifteenth batch, 2020-09-18), I get the same as the above.

Sorry about the noise.  Will queue again.
