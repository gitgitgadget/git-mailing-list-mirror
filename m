Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876C720372
	for <e@80x24.org>; Wed, 11 Oct 2017 06:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbdJKG0q (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 02:26:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57596 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932583AbdJKG0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 02:26:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54225A97BD;
        Wed, 11 Oct 2017 02:26:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ewuac0ds1lGCyBqNxcy/SApiBLI=; b=n6ZvDF
        jv75yghVejzzdVcQ4Ot7CArvVFMZV0HY82VMQPakyg/KxsxuiKo/L2fli0LmtJVp
        pd2EBJkLXSgx+wK/BwlxtZ9j93kqHJdoakLQ8dIwMZm2ErzN6N7y0SDCUc5EWgcI
        0W2s5Qr1h4BWUBhRzWdstOVjJyk8inIAYzoFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YeLRcfRiblSGEC7n8tClor7j+TuQ70uu
        OHMk3IV1LmTjMjSdmqV03SIaVgENubtKU8DDKzf7TqzPAFEMm9yrg3ECourdSjyz
        sgHdbSwqLR/jmbvSYtGlRmMBAJq7U8/0UzYhBopQSYIQDQ0aH7XiYBW8PMsw14E2
        +l5wb0nFy/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CFFAA97BC;
        Wed, 11 Oct 2017 02:26:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF8E4A97BB;
        Wed, 11 Oct 2017 02:26:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Subject: Re: [PATCH v3] run-command: add hint when a hook is ignored
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
        <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
        <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 11 Oct 2017 15:26:43 +0900
In-Reply-To: <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 10 Oct 2017 13:21:16 +0900")
Message-ID: <xmqqmv4ymc7w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26FE3D04-AE4D-11E7-8634-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Quite honestly, I do not particulary think this is confusing, and I
> expect that this change will irritate many people by forcing them to
> either set the advise config or move the ones that they deliberately
> left unexecutable by renaming them by adding ".disabled" at the end.
>
> But these remedies are easy enough, so let's see how well it works
> by merging it to 'next' and cooking it there for a while.

Well, it turns out that I am among those who are irritated, as all
the repositories I work with were rather old, dating back to 2005,
back when it was a norm to have these sample files installed without
executable bit, to make it easy for those who choose to use them
as-is to enable them by flipping the executable bit.

And I do not find the advice.ignoredhook is giving particularly a
good piece of advice.  I suspect that it would be a better practice
to rename a disabled foo-hook to foo-hook.disabled if the user wants
to squelch the warning.  It gives them a final chance to review what
they left disabled for all these years, and then choose to either
remove it, or rename it to foo-hook.disabled.  "ls .git/hooks/" will
then make it clear which ones are disabled without the "-F" option,
which is an additional benefit.

Anyway, I am not merging this topic to the upcoming release, so
hopefully we'll hear from others who try 'next'.

Thanks.
