Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDEC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 06:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A0206D8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 06:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qFQn64Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXGBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:01:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62471 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGXGBe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 02:01:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95A00D80C5;
        Fri, 24 Jul 2020 02:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8hCE+hnvz5P6YFKWIDWbgUVYlxM=; b=qFQn64
        FsjYzJdlmOfFteA57sEb1nBUQXaYS3Qh71NtUu3wHOZMv1MT2CCU8n/0tmWRLb/8
        IJSaJwa66wHJKRllN93KVBk+5CT8MS+9b3v+iPdOlpgGCSlvuXgdlAHWObkf4Ydz
        jFERwjrB9RSiYGZ3MMw4r9mmS5Im32jJwoT3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KmXxvPMAGPTl3yoSIy0GC5BX8hQxJz/9
        dSmZJoX/6SxWAU6ariv/OuAd9VAeniogcJGGfMGnkS7DaKft7Epnf9E9G9Zxuvhx
        WXQMapQPLlFbhQxOai5l+wpVKRMWSF0Aa36a3470iJaNCoEZ756EiA5Q29ivH8/Y
        tH3AoRr4vdM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F03ED80C4;
        Fri, 24 Jul 2020 02:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE55CD80BF;
        Fri, 24 Jul 2020 02:01:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
        <87blk6yrlc.fsf@osv.gnss.ru> <xmqqimedq5c8.fsf@gitster.c.googlers.com>
        <CA+P7+xpPDu900dao08wfYtZ2pqU89D9vmwQPuFT-z5S5b-DXNA@mail.gmail.com>
Date:   Thu, 23 Jul 2020 23:01:30 -0700
In-Reply-To: <CA+P7+xpPDu900dao08wfYtZ2pqU89D9vmwQPuFT-z5S5b-DXNA@mail.gmail.com>
        (Jacob Keller's message of "Thu, 23 Jul 2020 22:15:23 -0700")
Message-ID: <xmqqblk5moxx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F5187C6-CD73-11EA-9EEF-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Jul 23, 2020 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>> If your merge used the merge (as opposed to diff3) style, and seeing
>> that the resulting conflict is not easy to review and you wish you
>> used diff3 style instead, it is way too late for any option to "git
>> merge" to help you.
>>
>> But having an option to "git checkout" lets you move forward from
>> that state, so it also makes 100% more sense than an option to "git
>> merge".
>
> Perhaps the issue is just that it's not discoverable easily because
> it's a different command.

That may be true.

By the way, "git checkout --conflict=<style>" is a short-hand for
"git checkout --merge --conflict=<style>" and it is quite useful not
just in the said case of "oops, I cannot read this conflict with the
'merge' style---let's switch to 'diff3' style".  After starting to
attempt resolving the conflict, sometimes I become unsure if the
resolution I've been working on is correct, and want to start from
scratch.  In such a case, even without switching the style to a
different one, "git checkout --merge" to discard the changes I made
in the working tree file and reproduce the auto-merged state with
conflict markers, is a good tool in your toolbox to know (being able
to give a different conflict style is merely a natural extension of
the feature).

Perhaps in Documentation/git-merge.txt there can be a mention of

	When you really screwed up your resolution, you could use
	"git checkout --merge -- $paths" to revert selected paths
	back to the state just before the auto-merge gave up and
	asked your help in resolving.  The --conflict=<style> option
	can be used instead of the "--merge" option in the command
	to use a different conflict marking style.  See
	git-checkout[1] for details.

or something along that line.  People who are unware of "checkout -m"
in such a situation may run "git reset --hard" and redo the whole
merge from scratch, but you do not have to discard the resolution
you made in other paths successfully only to redo a few files that
you botched.

