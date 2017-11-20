Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7249202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdKTAqg (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 19:46:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53496 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdKTAqf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 19:46:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC934B5274;
        Sun, 19 Nov 2017 19:46:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l0e89KS/NjAXvflLsh+gUYp45qI=; b=EFylHL
        N8JWB2rqbwTXjjNBMX3o2sQGX1r8Wv+mNz3pQj93Lgr42Scu0kpJiwb0H1t/8K4S
        3KZI5U3VgZmw60yfXdOSZNL6j9YMs4bXTflzHgSkhRGzBnA3Yq1+0RjE4DQ1/MjR
        xUSV34OqipGJXTWOOyFYynEK24ynxbx2MT9Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q/58VIdOM5AqzkHuSMbk5HHtwXMpVOFL
        +HkBtDbL58q4zp1EIm0Zg06LVDHjg4T44IpfTDpIbkVFU6dQynsR3jrAFPL6oU0q
        Epdc/inJcl3/3ZgM5wfumc2R5suVr6q7C0wmxQIIRrS1z2jY9TK4eSbXuJ0DhC5P
        3XcvVTR7PpY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4899B5273;
        Sun, 19 Nov 2017 19:46:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32F81B5272;
        Sun, 19 Nov 2017 19:46:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <ilya.a.kantor@icloud.com>
Cc:     =?utf-8?B?0JzQvtC5INCl0L7RgNCy0LDRgtC40Y8=?= <iliakan@gmail.com>,
        git@vger.kernel.org
Subject: Re: Why gc --auto is called so rarely?
References: <C47F730C-18AE-411E-AC57-2DA8625451C4@icloud.com>
Date:   Mon, 20 Nov 2017 09:46:32 +0900
In-Reply-To: <C47F730C-18AE-411E-AC57-2DA8625451C4@icloud.com> (Ilya Kantor's
        message of "Sun, 19 Nov 2017 20:04:21 +0300")
Message-ID: <xmqqa7zhojyv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41DD4C6A-CD8C-11E7-820B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <ilya.a.kantor@icloud.com> writes:

> ...It seems sane to git gc --auto from command that are expected to take time.
>
> That's probably the reason why it's not called on commits and
> called on receive-pack.
>
> But then why call it on merges? Especially on those that have no
> conflicts and should run fast.  Also, merges are not supposed to
> introduce unreachable objects.

The primary thing we want the users get out of running "gc --auto"
during these operations are not the removal of unreachable garbage.
It is primarily run to reduce the number of loose objects and
prevent great many numbers of tiny packfiles from being accumulated,
so the places you see calls to it tend to be after creating new
objects in the repository.


