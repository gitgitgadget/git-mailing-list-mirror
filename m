Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA56920A26
	for <e@80x24.org>; Mon, 25 Sep 2017 03:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdIYDzR (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 23:55:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54075 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752884AbdIYDzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 23:55:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7EA1B244A;
        Sun, 24 Sep 2017 23:55:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U93ImQjmoOxO2vH+bAw4yAGj9Js=; b=BWxasF
        pgcT860tqojNVYM3vEXw60RkAQ2H+ZP8NeeePv521o5iqTK3ruCbR/uPAyo8KAjq
        d9kAPmUItycQa9mAYGqwg69trRs2WIeV5EL2NlKLvmR/80hnRl0rcGcK5HR47Pu+
        EY8f+Vws51NNg+NLn07dFLt7bHZT4V1nydQ0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QzdFT6SyxR1LdYX89YkHbD3RvMo3eopO
        AfYiZdADnuWI5kfvtjn03EID1oKawaD9b8D8HNj1JBDLYN26e1Q1Sq9ua2an61iP
        DwCp3IOLtIdLuLBfipng7+aIsxBDAkA6X34340sRJ3e1QcRjHT9W2mCMNyvcjSTO
        RsOExDAzz/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE923B2449;
        Sun, 24 Sep 2017 23:55:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2924FB2448;
        Sun, 24 Sep 2017 23:55:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     hanwen@google.com, christian.couder@gmail.com, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v5 3/4] submodule: port set_name_rev() from shell to C
References: <20170921161059.11750-1-hanwen@google.com>
        <20170924120858.26813-1-pc44800@gmail.com>
        <20170924120858.26813-4-pc44800@gmail.com>
        <xmqqfubbfnan.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 25 Sep 2017 12:55:13 +0900
In-Reply-To: <xmqqfubbfnan.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 25 Sep 2017 12:51:44 +0900")
Message-ID: <xmqq8th3fn4u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 568D4FC4-A1A5-11E7-AB9B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nicely done.
>
>> +		if (!capture_command(&cp, &sb, 0) && sb.len) {
> ...
> So, while it is not wrong per-se, I do not think we need to check
> revname[0] here.  The helper never returns a non-NULL pointer that
> points at an empty string, right?
>
> On the other hand, if we dropped the "&& sb.len" check in the helper
> function to be more faithful to the original, then we must check
> revname[0] for an empty string.

Ah, ignore all of the above.  This will all be discarded in the next
step [4/4], as far as I can tell.  Perhaps we should drop this step
and get directly to it, making the result a three-patch series
instead, then, no?

