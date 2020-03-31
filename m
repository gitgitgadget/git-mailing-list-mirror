Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F714C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 00:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF09206F5
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 00:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kUzriYlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgCaATJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:19:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62308 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgCaATI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 20:19:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B14DB46AD9;
        Mon, 30 Mar 2020 20:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YwgkmuJqbtWNuXEuqPPU3fulJ/4=; b=kUzriY
        lR3d3lo5z1LpsYDVU0noxmMwWG9xmDk5eMItO+z8Lg2Juu87WdzuGZQULHRXPqIa
        quFJY6PoA2QRQc6x0fedzTlyHktJ965C+itDV4wlaruoNdgOdfsbfnrHl78196E+
        cQkkBReRaQdXhgXvF3Fk+389NcGVqiFWzJNTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wt6Tvw8V7ef+Z+o5FYo9ChGwtr2EeBgA
        llbTk6h0bRfPeZLetV4PF7mKDhnYVuwG//YCogrDkXhWUMKC9Npro9qBgjshzmAS
        0wmsQWI/USiDGvChHREdHFwFkktHtjm/tjcud/5zQVfdIMMjut3xRMnmukTJFj2k
        ftEaqLyEPeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A96E846AD8;
        Mon, 30 Mar 2020 20:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3275246AD7;
        Mon, 30 Mar 2020 20:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v5 2/6] receive-pack: add new proc-receive hook
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
        <20200330165754.19195-3-worldhello.net@gmail.com>
Date:   Mon, 30 Mar 2020 17:19:05 -0700
In-Reply-To: <20200330165754.19195-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 30 Mar 2020 12:57:50 -0400")
Message-ID: <xmqqy2rh74w6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C4202B8-72E5-11EA-86CC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +	argv[0] = find_hook("proc-receive");
> +	if (!argv[0]) {
> +		rp_error("cannot to find hook 'proc-receive'");

Perhaps discard "to" from here.  Also I notice that other messages
given to rp_error() are marked for _(i18n), but this one is not.

> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	remote: # pre-receive hook
> +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
> +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
> +	remote: error: cannot to find hook "proc-receive"
> +	remote: # post-receive hook
> +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
> +	To ../upstream
> +	 * [new branch] HEAD -> next
> +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
> +	error: failed to push some refs to "../upstream"
> +	EOF
> +	test_cmp expect actual &&

This breaks gettext-poison test.  

See https://travis-ci.org/github/git/git/jobs/669008025 for example.

