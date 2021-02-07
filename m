Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14482C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDACF64D9A
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBGSNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:13:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58183 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGSNT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:13:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF74F11300B;
        Sun,  7 Feb 2021 13:12:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g5LfHO6Lxhrh4PMIBmjyDfOLM2s=; b=P1wvMp
        c0hVXgj8Eh572qunGr1ydaKbMbSEQrT6oLWChC+Hxaw0Z7pGsgMh5woKoMunOYbn
        mUD84wY2vBNY0aFEectHtu2DImT7xsAt0YeZtLuWb6tZeY6n9L8OK+FqHhTU4yad
        M2ftOB77DF2EVmCGT8iQEkPabuSGUGorX6K/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BslU3WxwcIM25BVPVX5kwmCEeTHQM2Qy
        9KDd8hb3mZAofbpL/3YqiyQR1ehgU8B8proYfA1BcQycagB5hy63vMIuj8iB9uHi
        Tm95IBXvpofDhXkAIced+bIxVA0OJP2PbpepY4ynU1pdpaCaGxNCKk4N8XKXjROH
        xAiukCT8qT4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E81BB11300A;
        Sun,  7 Feb 2021 13:12:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E845113009;
        Sun,  7 Feb 2021 13:12:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        git@vger.kernel.org
Subject: Re: default editor
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
        <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net>
Date:   Sun, 07 Feb 2021 10:12:33 -0800
In-Reply-To: <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sun, 7 Feb 2021 17:35:45 +0000")
Message-ID: <xmqqlfbz927i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DBD8962-6970-11EB-A23E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> First of all, I don't use Windows and this sounds like a
> Windows-specific problem, so you may have more help at the Git for
> Windows issue tracker.  But I'll try to help anyway.

I don't do Windows, either ;-)

> I don't think the return value is the problem.  Both Unix and Windows
> return 0 on success and nonzero on error, and Git will interpret
> editor return codes that way.

When git spawns an editor, it is asking the editor to give the text
file that has been edited by the end user into a shape that the end
user is happy with.  A non-zero exit is a way for the end user to
tell the editor (and hence git) that, even though the user has ended
the editor session, the resulting contents is not satisfactory and
not to be used.

If the 'ed' in question behaves the same as traditional UNIX 'ed' (I
am guessing so, as even this is on Windows, Cygwin was mentioned),
you can start making changes and attempt to quit without saving by
typing 'q<RET>' twice (the first one will be greeted with '?'
meaning "are you sure you want to quit without saving", and the
second one lets you quit).  'ed' will signal the calling environment
that the editor session was aborted by exiting with a non-zero
status.

