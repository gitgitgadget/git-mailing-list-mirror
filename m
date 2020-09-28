Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A119C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268F1207E8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fHoez7uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1SqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:46:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55260 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1SqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 14:46:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D026CED999;
        Mon, 28 Sep 2020 14:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7/QUB1UCnEbQt0WBjHcMXCnY360=; b=fHoez7
        uWMBO/7F78PrSMxRsxTtd7hItFqYYO9opXu9a0q/R/DkDdtIqUoTJNrc7qf5Zpbj
        h3mRAf5+f4fqI4t/e7iRC3VOr259InlVF/uoIa/e5zv7aiFUO+1H5jP5ESOHauc4
        VHXt++6oWx3RU9WhXf6k9hwVPCD+9c9YXqTZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=au2qaBswSP6mXSFOLr5/HZJXIZy78k9s
        5TM1hOumSLXEgpu0VKkFvFzNx7mPW3HSKoODq3pCVLj3H86rai7Df2r3lmUrI6z+
        lyjvLMMQTy93WPNvtPTK1CPojNOlTvfJ6hQcH3iW5jkVGWSM5Fjaf8JQg/WOsDYo
        0S/cutZz3PU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7BA9ED995;
        Mon, 28 Sep 2020 14:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16596ED994;
        Mon, 28 Sep 2020 14:46:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Evan Grim <evangrim@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git commit-tree does not honor commit.gpgSign config
References: <CABX4Un0NQV1wkx-AKTFs12agLiBLEe+Y_FDHgQwgxUT=wnFDmA@mail.gmail.com>
Date:   Mon, 28 Sep 2020 11:46:11 -0700
In-Reply-To: <CABX4Un0NQV1wkx-AKTFs12agLiBLEe+Y_FDHgQwgxUT=wnFDmA@mail.gmail.com>
        (Evan Grim's message of "Mon, 28 Sep 2020 10:21:42 -0600")
Message-ID: <xmqqd025n3ik.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1EFD9C4-01BA-11EB-9A7B-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Evan Grim <evangrim@gmail.com> writes:

> Is it a bug that `git-commit-tree` doesn't honor the `commit.gpgSign`
> configuration option?

It would be a bug if it did, as a low level plumbing tool to build
scripts around, it would not want its behaviour to be affected by
end-user configuration (rather, scripts that are written using these
plumbing command do want to handle end-user customization their own
ways).
