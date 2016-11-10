Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B13D20229
	for <e@80x24.org>; Thu, 10 Nov 2016 22:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbcKJWak (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 17:30:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753386AbcKJWaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 17:30:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 494DD4C8B1;
        Thu, 10 Nov 2016 17:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NiNllgoVvw8qhj/cl15P9xJaauQ=; b=fB7Fig
        B/g8L5qsRv5Iyo3hpqMJQnyl1iBrdfCVuYKzDckbjt9qqNQlGFWxrBGkKLqKv0SD
        UStnLn3zGexKZ4diUo+l7xZ0pEsOGfN0fjeh3zvVdl8qVJ/s555fzfGGl53z72Li
        G+oZrOQYukrQ1HOt3rdD4lr9AI5A0pbT81kvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aqkatv29ehWZEAv8I/KUe5PgY+CKD87U
        pjuDakDW4laWT9zG/sOe7B+tzB9m5d8BZlI1SM1H70+Ms32miJpLBSbDKrW4HdXN
        OSBpvgAxVrgjZJ1JCp9dhbSIgVEw9O7CEaX2xxPHOexu//OjcrkRhgYfmSzRmqzF
        INmYabNJfPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A7914C8B0;
        Thu, 10 Nov 2016 17:30:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C09E4C8AF;
        Thu, 10 Nov 2016 17:30:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Andreas Schwab <schwab@suse.de>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
        <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611091437280.72596@virtualbox>
        <mvmzil8btzb.fsf@hawking.suse.de>
        <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
        <mvm8tsrbusp.fsf_-_@hawking.suse.de>
        <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611102254340.24684@virtualbox>
Date:   Thu, 10 Nov 2016 14:30:36 -0800
In-Reply-To: <alpine.DEB.2.20.1611102254340.24684@virtualbox> (Johannes
        Schindelin's message of "Thu, 10 Nov 2016 22:55:35 +0100 (CET)")
Message-ID: <xmqq60nv55o3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DADD55A-A795-11E6-A646-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> OK.  sleep.pid is a reasonable easy-to-access side effect we can
>> observe to make sure that the sleep-one-second merge driver was
>> indeed invoked, which was missing from the earlier round.
>
> No, this is incorrect. The condition that we need to know applies is that
> the script is still running, and blocking if the bug reappears.

OK, I see what you are saying, and I see a few things wrong in here:

 * First, the test is titled in a misleading way.  In the context of
   a patch that was titled ad65f7e3b7 ("t6026-merge-attr: child
   processes must not inherit index.lock handles", 2016-08-18), it
   might have been clear enough to say "does not lock index", but
   the sleeping is to make sure that we would notice if the fd to
   the index.lock leaked to the child process by mistake, and the
   way to do so is that the child arranges the leaked fd to be kept
   open after it exits (by spawning "sleep").  The test was never
   about "does not lock index" (the driver does not take any lock by
   itself in the first place).

 * There are three possible outcome from this test:

   - 'git merge' fails.

     This is expected to happen only on Windows and if the code gets
     broken and starts leaking the fd.

   - 'git merge' finishes correctly, the sleep is still running when
     test_when_finished goes to cull it.

     In this case, we KNOW there wasn't any fd leak IF we are on
     Windows where a leaked FD would not allow 'git merge' to
     succeed.  But on other platforms, fd leak that may cause
     trouble for Windows friends will not be caught.

   - 'git merge' finishes correctly, the sleep is no longer
     running because the machine was heavily loaded; a workaround is
     to tolerate failure of culling it.

     In this case, we cannot tell anything from the test.  Even if
     the fd was leaked, 'git merge' may have succeeded even on
     Windows.

As everybody knows there is no appropriate timeout value that is
good for everybody.  I wonder if we can replace the sleep 1 with
something like

	( while sleep 3600; do :; done ) &

so that leaked fd will be kept even in any heavily loaded
environment instead?

