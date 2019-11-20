Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B0DC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B512068F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rAg6BIdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKTDs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:48:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64536 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKTDs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:48:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 836F72A314;
        Tue, 19 Nov 2019 22:48:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qyon7TEdT0qhZsz2CGE9jyHM69g=; b=rAg6BI
        dSq8MUD9fEjMxBu5Ep+zi+XSzGmeGLC+IG3WGoFsr0My5zKiUNZfwKzn8qTCNtYd
        zQNX21d7qFHNoJM3zAvS58ZeMMleWAroamDJVEUhubU+vMCmYVVRRXgv6kji8i0q
        G0QaLLFhA/XzFbydekJ0imy5Gwzhr8HjU5DQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sv1y4mRnCe9yKiSWaKFJeLqjbdm6iAHu
        KB320Rzd8dORZZwSI5Huz4cXEfhjtdBxajKuE5qh199C8lohC/JPyS7mUFWjDhkR
        6H48wVfZRQ32p9jVoKZ0AS/d6YlTbrwsLAfS7ivGSwmZiOzrlp8RHZv4NZBVWzjC
        ODLBtUwJmU0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78B042A313;
        Tue, 19 Nov 2019 22:48:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE0742A311;
        Tue, 19 Nov 2019 22:48:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     marat@seldon.slonopotamus.org
Cc:     git@vger.kernel.org
Subject: Re: git check-ignore returns 0 for negated masks
References: <20191119140135.GA7389@seldon.slonopotamus.org>
Date:   Wed, 20 Nov 2019 12:48:54 +0900
In-Reply-To: <20191119140135.GA7389@seldon.slonopotamus.org>
        (marat@seldon.slonopotamus.org's message of "Tue, 19 Nov 2019 17:01:35
        +0300")
Message-ID: <xmqqmucrcimx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD2DD2AE-0B48-11EA-BFE1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

marat@seldon.slonopotamus.org writes:

> I believe this is a bug because it contradicts check-ignore documentation:
>
>   0 - One or more of the provided paths is ignored.
>   1 - None of the provided paths are ignored.

I think the doc was written with primarily positive entries in mind
(it might even predate the introduction of the feature to allow
negative entries in the file), so it might need to be adjusted with
something like s/be ignored/match the pattern/, perhaps?

