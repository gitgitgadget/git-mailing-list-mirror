Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDAC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0302074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jd0RRw67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHZQ1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:27:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53679 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgHZQ1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:27:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C3268507;
        Wed, 26 Aug 2020 12:27:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVkiKT9YIVyJW98SVHq0/QAruFc=; b=jd0RRw
        67t4Y3Y/bvH66ImAftO/rxMg0b/fjxgQdRoqlM9FaK5u4NtbqjS7xcN3sIxV5e8r
        EJFrLyIZ8KoCihaRVCDoCBTaqLqMwlz8kdMMggvEZSE0B2YHMZBg5FBjRHqy3waA
        ymJYyY1qzr6KELjXpWGJAVgLAXIgd2U9/caWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CQ8YOOPgTLkhDDU/l8r5wfVPuiaaUaJT
        grI63aX8pcpQXxH9+7TFYCukStKdFCYy16Q7JWPAQLTXveawpG1Bv0wvjGOawXRc
        Xl+EgrbyoOdpMEyDPSUlhnnjllqrDy3QhxbCHRRrDLjDPl+qDqR+XImAnzPhD+Rq
        9+U1zJ6Ml7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EDDA68506;
        Wed, 26 Aug 2020 12:27:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A711768505;
        Wed, 26 Aug 2020 12:27:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] transport-helper: do not run git-remote-ext etc. in dashed form
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-2-gitster@pobox.com>
        <CAPig+cTvLaOD1idfB2M0-QSfXXKBe5-FnWSU9E0PaUMHAoGj1w@mail.gmail.com>
Date:   Wed, 26 Aug 2020 09:27:47 -0700
In-Reply-To: <CAPig+cTvLaOD1idfB2M0-QSfXXKBe5-FnWSU9E0PaUMHAoGj1w@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 25 Aug 2020 21:24:11 -0400")
Message-ID: <xmqqpn7dwews.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13E62D0A-E7B9-11EA-BDD1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Runing them as "git remote-ext" and letting "git" dispatch to
>
> s/Runing/Running/
> s/them/it/

I wrote 'them' because it is not only 'ext' but other helpers are
also run with the same mechanism, but the sentence uses remote-ext
as a single concrete example, so 'it' would be more appropriate.
Thanks.

>> "remote-ext" would just be fine and is more idiomatic.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/transport-helper.c b/transport-helper.c
>> @@ -128,7 +128,8 @@ static struct child_process *get_helper(struct transport *transport)
>> -       strvec_pushf(&helper->args, "git-remote-%s", data->name);
>> +       strvec_push(&helper->args, "git");
>> +       strvec_pushf(&helper->args, "remote-%s", data->name);
>
> Rather than pushing "git" as the first argument, would it instead be
> more idiomatic to set `helper->git_cmd = 1` (or would that not work
> correctly for some reason)?

I was aiming for minimum change and did not think too deeply.  

If .git_cmd=1 works here (and offhand I do not see a reason why
not), then that would be simpler.  Thanks.
