Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF557C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjEPRBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjEPRBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:01:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4AA5F5
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:01:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7569A19C552;
        Tue, 16 May 2023 13:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lzP5HozLO0CO4SCaZ9u90As7lTpKZqbgx1Oe6P
        ozIgo=; b=gNh5Pz3lVtfC/sL4ZArz6EOHgfjrjQwE/TiOW/GBkRm4yyjUNsfvbL
        8BKXnstfzl+B2sdvcE85Gw7aG7iBbVnKCzRuXJ4wVi61yAZOfaBTKW+JU/Y5+FZA
        1x0IpoIxPRQdxqBZ8ah1ZJGgVtsPe7mBKT+/NFoCuq58HqZ4uQRQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 658AC19C551;
        Tue, 16 May 2023 13:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B439319C550;
        Tue, 16 May 2023 13:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     code@khaugsbakk.name, avarab@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <2908b005-9478-4c59-ae8e-150be44a15a9@app.fastmail.com>
        <20230512040746.2069-1-tenglong.tl@alibaba-inc.com>
Date:   Tue, 16 May 2023 10:00:26 -0700
In-Reply-To: <20230512040746.2069-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Fri, 12 May 2023 12:07:46 +0800")
Message-ID: <xmqqttwcus7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 285F9648-F40B-11ED-B2D6-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Returning to the issue of -separator = "", my thought is that I want
> --separator="" to behave the same way as
> --separator="<any-string-without-a-trailing-\n'>" when deals a string which does
> not contains a trailing newline. This will eliminate one more implicit logic and
> make behavior more consistent.

An obvious alternative would be to use the string given to the
"--separator" option literally, I guess, and you can add your own
newline if you want to.  But most of the time you would not want to
have an incomplete line, so appending the newline at the end by
default does make sense.

Special casing an empty value to "--separator" as "nothing" does
make sort-of sense.  Using a blank line as the inter-paragraph
separator is the default, and there is not much use in the
"--separator=''" that becomes "--separator=$'\012'" automatically.

> I think --no-separator maybe a better name, means that not any separator will be
> append between two paragraphs even a newline.

It would work as well.  Is it something we can safely add before
merging the topic to upcoming -rc1?

Thanks.
