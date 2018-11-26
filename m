Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F171F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 04:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeKZPcD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 10:32:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeKZPcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 10:32:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C2451D124;
        Sun, 25 Nov 2018 23:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JKwV2tQHs973obw9EymrOKAinuU=; b=ApycIV
        eUWKhcotoHtvxdQvN5KSYXXXjZOnwwZ1mLKx/AxCr2E4TX41YR8JHywF1mmwXy5m
        pb1bXCenHsqmqaXBHADTwSz98uhupjRkQnEejeHgo8RPvcJtAqtgWbeqHIfWfE25
        fFzsYin37Alrnb2F14IaUe8RZOt0OaZasOR5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xIc/ctLHgNAgljcVJdwFmcS7e2zRcZcv
        TRiuOHC7Gux/+Q4Jc3mREK7PgmRli69FFs8PsbNhmJyQmJjXYum2KYj7QksXUCpO
        vlwZ/EY7UbUP18tH1aoDTaH809UNOrMw4CjL7Drv7kNUsefvnUv9HTVNy0OKVFKG
        maJe8lDQOVk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85A001D122;
        Sun, 25 Nov 2018 23:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F1671D11F;
        Sun, 25 Nov 2018 23:39:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pedrodelyra@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup.c: remove needless argument passed to open in sanitize_stdfds
References: <20181125162008.30065-1-pedrodelyra@gmail.com>
Date:   Mon, 26 Nov 2018 13:39:04 +0900
In-Reply-To: <20181125162008.30065-1-pedrodelyra@gmail.com> (pedrodelyra's
        message of "Sun, 25 Nov 2018 14:20:08 -0200")
Message-ID: <xmqqmupwzc47.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 356C719A-F135-11E8-A8AF-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pedrodelyra@gmail.com writes:

> According to POSIX manual pages, the open() system call's mode
> argument specifies the file mode bits to be applied when a new
> file is created. If neither O_CREAT nor O_TMPFILE is specified,
> then mode is ignored.

Correct.  

While I would say two argument form would have been better if this
were a new code, this change is borderline Meh for existing code,
because passing 0 there already gives a reasonable sign that we know
this parameter does not matter.

If the ignored parameter were 0666 or some other more
plausible-as-perm-bits value, the story would be quite different,
though.

Thanks.

