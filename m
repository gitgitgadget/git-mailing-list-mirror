Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08FE11F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 01:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbdKHBE2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 20:04:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752207AbdKHBE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 20:04:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F660AFB49;
        Tue,  7 Nov 2017 20:04:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N13/kywaJexb4ObjVojS0BkQFEI=; b=WDv/5F
        +Av/WUPqtRPw0EFC+zEXKJK8QImFxcE03EA+G6BaCSfKQebANKPofqzVYGz7NO6M
        DZCbCGQi/gVkrbiOSUNdkSlVxf3QIo/+6dSVaNX7Mv2W8kaZ74XZzuigAvFSvng9
        W1oj4atAbIRC8zrPoT5utVmJQtdlfrnKyaOSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a9ucrEoWtTmsLWG4krRwlkxTcSOGUord
        O4Q6KVuKcWQcnD1aYczKoUnMB9lz4DpQ1vvSJLaJXtEtxRQYLHBeVsLqzrUoDgSl
        mDRW2AAlrBwQHsOEba+Wbhg3Z1jd68755Dhgv9cQZXJMnZnsHtygy8gWW5sqn6Ei
        Q/r/+WhMaAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 773E1AFB47;
        Tue,  7 Nov 2017 20:04:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D771AAFB46;
        Tue,  7 Nov 2017 20:04:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 4/8] commit: move print_commit_summary() to libgit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-5-phillip.wood@talktalk.net>
        <xmqqlgjig3lv.fsf@gitster.mtv.corp.google.com>
        <7849f0e9-24eb-89db-3524-dffdb00d82ad@talktalk.net>
Date:   Wed, 08 Nov 2017 10:04:25 +0900
In-Reply-To: <7849f0e9-24eb-89db-3524-dffdb00d82ad@talktalk.net> (Phillip
        Wood's message of "Tue, 7 Nov 2017 14:32:40 +0000")
Message-ID: <xmqq4lq5oa1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C445666C-C420-11E7-A4DC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 07/11/17 03:38, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>> 
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Move print_commit_summary() from builtin/commit.c to sequencer.c so it
>>> can be shared with other commands. The function is modified by
>>> changing the last argument to a flag so callers can specify whether
>>> they want to show the author date in addition to specifying if this is
>>> an initial commit.
>> 
>> A movement of a long function like this one really is easier if you
>> did not make any other unnecessary change in the same patch and then
>> made the change as a follow-up.
>
> I'm not sure what you mean by unnecessary, the original code called a
> file-local function author_date_is_interesting().

Yes, sorry, I missed the fact that author_date_is_interesting() is
not moving (and it is not moving for obvious reasons).

