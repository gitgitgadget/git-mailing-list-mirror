Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E8CD8CAC
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 17:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjJJRHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjJJRH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 13:07:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E4182
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:07:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4EE7270F1;
        Tue, 10 Oct 2023 13:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=6qq79tdHNSHQKDbEFYK6lPNwH/NubQFQ+8hZo5
        UIWcM=; b=b6TQtIMvvmqZ7J56W/BoUXoCqY1LCZPpzhKCw60uM7hkF8nbnL5PMx
        OJOlHIldKwNZF8t3hnT8nQS0gZNYttHN9ObvXbVglFbED3WMMQzClxNOypILJHkp
        r7cGGRSThTr8dj6tLe8KmZnyAh88amd7wPAJXU09xVbjdFbWb0sXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB03F270ED;
        Tue, 10 Oct 2023 13:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E04C270D5;
        Tue, 10 Oct 2023 13:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Sebastian Thiel <sebastian.thiel@icloud.com>,
        git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <ZSVbUSRUQlNy0bj-@localhost> (Josh Triplett's message of "Tue, 10
        Oct 2023 22:10:25 +0800")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
        <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
        <ZSVbUSRUQlNy0bj-@localhost>
Date:   Tue, 10 Oct 2023 10:07:08 -0700
Message-ID: <xmqqo7h6tnib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72A77CA0-678F-11EE-B53B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> While I'd love for it to default to that and require an extra option to
> clean away precious files, I'd expect that that would break people's
> workflows and finger memory. If someone expects `git clean -x -d -f` to
> clean away everything, including `.config`, and then it leaves some
> files in place, that seems likely to cause problems. (Leaving aside that
> it might break scripted workflows.)

I thought the point of introducing the new "precious" class of
paths, in addition to the current "tracked", "ignored, untracked,
and expendable", "not ignored and untracked", is so that people can
do "git clean -x -d -f" and expect the ".config" that is marked as
"precious" to stay.  Before their Git learned the precious class, if
they marked ".config" as "ignored, untracked, and expendable", then
such an invocation of "clean" would have removed it, but if they add
it to the new "precious" class, their expectation ought to be that
precious ones are not removed, no?  Otherwise I am not quite sure
what the point of adding such a new protection is.
