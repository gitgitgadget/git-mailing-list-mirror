Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C761CC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8089164EE5
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhBJUWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:22:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61157 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhBJUVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:21:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BB8E105CC2;
        Wed, 10 Feb 2021 15:20:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U5jVq7Hfla1yC9NcBA50FsufXUE=; b=qI8ZTQ
        gGwa1gG2Izx26CYZeT/nv+KXf2Npp77tnMZDzUQxiZPgNd8Y7C6rlu2xI4IL3xvZ
        5JvUh/IknUkd5gE1d5tXzAbOlZ/LS+RzLQPZ/9YzdHKVZuEzn2mGaMMWeXvpsTUo
        FcxNNtWrT3+RtGPKtJniCIgfIKRGRffhGgkno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sxZ+ShNg3fiOsqncOPS+IHUzyI0sgo8D
        zD5qdNU97Gg2yJvvyESiB4a6++er7OMkSx44lG2wfoaGQ4EoQB+6IkUuTuyePNl4
        Obe5sJSnvsgg1ZUOUsB3CUrmpQ5x0XvJ2OhdiDJs4yK9gJemnj4ASUYJaIMlpC/1
        DVMI5A5/+44=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44BE0105CC1;
        Wed, 10 Feb 2021 15:20:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBAF1105CC0;
        Wed, 10 Feb 2021 15:20:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: GC can lose objects pointed to only by notes?
References: <CANiSa6h=S6tHUR4hY85uZ7ZcnDc2mdUzPwyBDakQAa_NP+O0YA@mail.gmail.com>
Date:   Wed, 10 Feb 2021 12:20:45 -0800
In-Reply-To: <CANiSa6h=S6tHUR4hY85uZ7ZcnDc2mdUzPwyBDakQAa_NP+O0YA@mail.gmail.com>
        (Martin von Zweigbergk's message of "Wed, 10 Feb 2021 09:51:16 -1000")
Message-ID: <xmqq35y33c9u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 757A698E-6BDD-11EB-BD34-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> From the "NOTES" section in `git help gc`:
> "[...] it will keep [..] objects referenced by the index,
> remote-tracking branches, notes saved by git notes under refs/notes/"
>
> I had interpreted that as saying that it will keep objects pointed to
> by notes saved under refs/notes.

The documentation needs updating.

There is no reachability from the notes that point at an otherwise
uninteresting objects that are not pointed at by real refs, so a
note that talks about a commit that is pruned will become stale.

It is the reason why we need the "git notes prune" subcommand.

Thanks.
