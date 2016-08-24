Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC7F1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbcHXU7c (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 16:59:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59696 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756152AbcHXU6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 16:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92639399B2;
        Wed, 24 Aug 2016 16:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PdiekdvQvB6+feTs0jcGu03DxpI=; b=vk4ZK2
        068EdmMZawsaH45mrqMTVVaXj9EI01Ry53UL3Kj+1OjBwBn25iO9FDEFLpQKcK5m
        VHU7BA8jW0rxZ7UebxiTIgY1t3VDy7ayNnME8kRtTtCDH3BAgZAokMMC5XC9SZbR
        2907wfiSNxBbjxamTy4VPl5DpvLp2wTKMoBuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FyymEJwQS/tv9UdblaRSojjC5i7h/0aM
        Lk8wkA37PVWAevFAGE8AXQSNmzGml7hxWvDLSIAfCuSMPcY9OUG1vYlXHjKbP5HF
        pqyp3YknfwyZ1iSY/O7QKL5JlBGNIJeNqmT1DZFMtvv1koh96AK+12LVOfnWhMY4
        GjJYlTFAMRE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B4D0399B1;
        Wed, 24 Aug 2016 16:58:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FE71399B0;
        Wed, 24 Aug 2016 16:58:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 04/27] bisect--helper: `bisect_clean_state` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe66f-bfad6316-39d4-4577-8f75-d1b4b2031263-000000@eu-west-1.amazonses.com>
Date:   Wed, 24 Aug 2016 13:58:28 -0700
In-Reply-To: <01020156b73fe66f-bfad6316-39d4-4577-8f75-d1b4b2031263-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqd1kxq3yj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 835C19A4-6A3D-11E6-AA06-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Reimplement `bisect_clean_state` shell function in C and add a
> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
>
> Using `--bisect-clean-state` subcommand is a measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired but its implementation  will
> be called by bisect_reset() and bisect_start().
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---

This seems to be where this round diverges from the previous one.
This patch in this round has more stuff that used to be in
builtin/bisect--helper.c in the previous one in bisect.c.  Because I
am not sure if the distinction would make that much of a difference
(after all, I do not think of a good reason why many bisect internals
need to be exposed to anything other than the eventual builtin/bisect.c
that retires git-bisect.sh), I am OK with the change to this patch
between the previous round and this round.

