Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D719520C11
	for <e@80x24.org>; Wed,  6 Dec 2017 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdLFRWY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 12:22:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751208AbdLFRWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 12:22:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FA6FAE465;
        Wed,  6 Dec 2017 12:22:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J9K54dW6RAzC7HbG42QLLiu1e3c=; b=E517W+
        USnf+J+mh/U4LkPqRzX1RHfAPiBKZtbG1+gPYi+MpriHAI4a5J7RpY6jyFfsoPgN
        Fijmffavs/jpKW2yhmqswBfcsi6kIazA9Vsb3SFyUcA1J3u8d9qiHy6+Jb69RWi/
        ytKI3hDZJxSjS8rBzZF2AYT83py6BjE20Rwzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J0kGnCHte6y71JB0A/E2yXG1o1hfZwBN
        YFpLlk8PqptSKQBhrhQyvQb/qNb0dhkRT1aDm7dGSzpKXb+64K1Uq/WoqF/PyhMN
        b88IOi/qHWeAYKD++keezgr69fGQf6w064jYtdsj8dawvifFQhTAeDcnrLlK+v7U
        3H1rz8GmjaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 686F9AE464;
        Wed,  6 Dec 2017 12:22:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9E05AE463;
        Wed,  6 Dec 2017 12:22:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nick Snyder <nick@sourcegraph.com>
Cc:     git@vger.kernel.org
Subject: Re: git blame --reverse doesn't find line in HEAD
References: <CA+SQVf1W6BhNyB6bGxh7WfCwb6+E3pNjHLeS4xDYPJ6BLT8cng@mail.gmail.com>
        <CA+SQVf24rcQ1iKAQBW0Ky7Qm8zuF3Esw8qMKvG+KCbCA-mCcfA@mail.gmail.com>
Date:   Wed, 06 Dec 2017 09:22:21 -0800
In-Reply-To: <CA+SQVf24rcQ1iKAQBW0Ky7Qm8zuF3Esw8qMKvG+KCbCA-mCcfA@mail.gmail.com>
        (Nick Snyder's message of "Wed, 6 Dec 2017 07:40:35 -0800")
Message-ID: <xmqqh8t3hiuq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05774E30-DAAA-11E7-8B9D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nick Snyder <nick@sourcegraph.com> writes:

> This can be reproduced on Linux and Mac. This behavior seems to be a bug.

Can you bisect to see when the feature stopped working as you expect?

Unlike a forward blame, where the command tries to find a commit
that is responsible for a line being in the final result (i.e.
typically, HEAD), a reverse blame is not about finding a commit
that is responsible for a line (that used to be in the oldest
commit) not being in a more recent codebase.  It finds up to which
commit each line survived without getting touched since the oldest
commit in the range.

