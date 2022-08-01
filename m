Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9503C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiHASrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiHASrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:47:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766ED22BC5
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:47:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4F481926F1;
        Mon,  1 Aug 2022 14:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IK2aqo2EeRLs5Upvzq+LpCMrZV/07a0nNpqTms
        5q148=; b=wp9oKg6vZ/Q5+SrpT3WrpjNdq7E7c8gpnlt2d281ZEU1+wP+LFvj5U
        aI5tacsOV0GZRLALQfQumi3M3CjTAfLYMAPWICVdOkNSSBB9Q7owOGqNCI4hS9jP
        ogmFiRkpMM76XX/Uj8O+fyAbOYGUoVX9o8aujmfqZKjFCZC9y7gyo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACE491926F0;
        Mon,  1 Aug 2022 14:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52AC11926EF;
        Mon,  1 Aug 2022 14:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 4/6] serve: advertise object-info feature
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-5-calvinwan@google.com>
        <xmqqk07v7qe4.fsf@gitster.g>
        <CAFySSZAPzO9YzGhsjhG7YRXv+ctTHM2FXzrwRW2bTW4pUt8q7g@mail.gmail.com>
Date:   Mon, 01 Aug 2022 11:47:32 -0700
In-Reply-To: <CAFySSZAPzO9YzGhsjhG7YRXv+ctTHM2FXzrwRW2bTW4pUt8q7g@mail.gmail.com>
        (Calvin Wan's message of "Mon, 1 Aug 2022 11:28:37 -0700")
Message-ID: <xmqqtu6vyf5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 675CBA34-11CA-11ED-A1F2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> And we update the docs to say "type" is now supported by
> object-info. If a user now attempts to request "size" and "type"
> from a server that has not been updated to support "type",
> then the user gets an error message "object-info: unexpected
> line: 'type'", which is another situation that is a bad experience
> for older clients.

Is it?  older clients by definition does not know about "type", no?

I am perfectly happy with the capability advertisement to say not
just "object-info", but also what attributes of objects you can be
queried, by the way.  If clients right now (i.e. without this
series) expect that the other side who advertises "object-info"
without "=<these>,<attributes>,<are>,<supported>" supports only
"size", for example, perhaps treat the bare "object-info" capability
just as a synonym of "object-info=size", or something?

I do not deeply care either way, to be honest, as the deployed
clients with bare "object-info" will not survive for a long time
and will quickly be deprecated anyway.  I just wanted to see the
reasoning behind the decision to ignore them.

Thanks.

