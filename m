Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B110C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C861529
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 19:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbhI2TNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:13:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50534 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346459AbhI2TNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 15:13:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A043E2792;
        Wed, 29 Sep 2021 15:11:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j0iaeLgy6SbtmrJOSaykZ38+5/4oRT43AycZLL
        K38AI=; b=MmbkIh9HJGIh7g6KXlSgzCSCxNt/4iyEURWawGaOJLeyp3qdiX74V3
        zGV0PFbUVP0IDR2iRQ9nOvVnjnKTGWSkQaMPe++d4o72Wk2aKPwxdjEZbEbLhbVI
        xCLoeM3zPC46fA045JqGicOw4ZNzkZrlziK3rmAsTXTDGqD7bSX2k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71082E2791;
        Wed, 29 Sep 2021 15:11:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D276EE2790;
        Wed, 29 Sep 2021 15:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        "Dr . Matthias St . Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/2] blame: Describe default output format
References: <20210929124935.41917-1-bagasdotme@gmail.com>
        <20210929124935.41917-2-bagasdotme@gmail.com>
Date:   Wed, 29 Sep 2021 12:11:26 -0700
In-Reply-To: <20210929124935.41917-2-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 29 Sep 2021 19:49:34 +0700")
Message-ID: <xmqq8rzfdwo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C0080D8-2159-11EC-B331-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> While there is descriptions for porcelain and incremental output
> formats, the default format isn't described. Describe that format for
> the sake of completeness.

Sounds quite sensible.  It also is sensible to have it before other
formats, as this is what the users will see most often.

> +THE DEFAULT FORMAT
> +------------------
> +
> +When neither `--porcelain` nor `--incremental` option is specified,
> +`git blame` will output inline annotation for each line with:
> +
> +- abbreviated SHA-1 of the commit the line is attributed to;
> +- author name (or author email if `-e` or `--show-email` is specified);
> +- author date; and
> +- line number
> +

We probably would want to conclude the sentence and tell the readers
that they get the contents of the file as well ;-)  Perhaps like...

    `git blame` will output annotation for each line with:

      <<<these things that we list here>>>

    before the contents of the line.

The second and third items may want to see a bit more careful
thought, though.  I think three presentations are possible for them,
i.e. you can:

    . use -s to suppress the author ident part altogether;
    . accept the default to use the name and date as the author ident; or
    . use -e to replace name with email in the author ident.

Given that, it would be easier to explain if you did not split the
author ident as if they are two independent items.  The most concice
description would be:

    - abbreviated object name for the commit the line came from,

    - author ident (usually the name and the date, but see '-e' 
      and '-s' for how these options may affect it),

    - line number

I also thought we might need to also update description for "-s" and
"-e" to clarify what they affect is "author ident" while trying to
come up with the above suggestion, but after re-reading them, I
think the current text we use to describe them is understandable
enough.

Thanks.
