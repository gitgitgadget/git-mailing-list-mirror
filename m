Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CA7C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7654B23A84
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jl0mMLnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgIVFqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:46:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60198 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgIVFqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 01:46:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36AA4FEFF0;
        Tue, 22 Sep 2020 01:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BSAxx1xaC9x39qYu8axDORpXph0=; b=Jl0mML
        nxrnqY+2c1jhKxf+vRPfID5uAFZDXbP2raOo7VPmfd9GgFX1JW4H+hD6DDH2CakQ
        A794Ly0vfJi5KY8hHg7yZLkVtIlh6JFBzZOoEPVAcvGvd2H25gsM3/i8vVm3XtOj
        e3mXQv+nxdiBNr7dGaxRSl0zy9U4LX+pmVjdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b/0SHlm9LC61IVI2jkNcUTBSclj2RCHZ
        ijXu+sJycsSclZijKlt5w6WPJ48c+oThCJaWqabdMXxzBmx5183TFu/jpUPIQkon
        HCdB5z/FVrNbC5N1TvArJrJs45CQxKZPObDM/eWzXdyBPDJswxYLk/ri6sfDkQCg
        B6BFCokz2g8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EDE7FEFEF;
        Tue, 22 Sep 2020 01:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 264B0FEFEE;
        Tue, 22 Sep 2020 01:46:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/2] fetch: do not override partial clone filter
References: <cover.1600743698.git.jonathantanmy@google.com>
        <070a717aabbac31ae44567dbe54a325029f9931f.1600743698.git.jonathantanmy@google.com>
Date:   Mon, 21 Sep 2020 22:46:18 -0700
In-Reply-To: <070a717aabbac31ae44567dbe54a325029f9931f.1600743698.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 21 Sep 2020 20:03:57 -0700")
Message-ID: <xmqq363acqj9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0B20794-FC96-11EA-A56B-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +test_expect_success 'ensure that filter is written to config' '
> +	FILTER=$(git -C client config --get remote.blah.partialclonefilter) &&
> +	test "$FILTER" == "blob:limit=0"

I'll do s/==/=/ locally because otherwise the test-lint-shell-syntax
will choke on this line.  No need to resend only this line.

Thanks.

> +'
> +
>  test_expect_success 'partial clone: warn if server does not support object filtering' '
>  	rm -rf server client &&
>  	test_create_repo server &&
