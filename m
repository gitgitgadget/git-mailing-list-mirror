Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26252C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0065920866
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B8Qa52kO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHaRpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:45:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54670 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgHaRpK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:45:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6006EF0C26;
        Mon, 31 Aug 2020 13:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xWdeVl398zP5+QXrhd8S2D6OHxo=; b=B8Qa52
        kOIV69w5loSD+r7F/fgZRoTzIzUqDLaZ85AyKcqz49qPPFP5+AR659zMtc92vvFJ
        ueu8tHKzldwwtGjiSgKN7UjJBhylUPxCpy8Srlyf3Hwo+GNTidU3zW79WKm5X3R1
        9/lb340D40ax3RWeGAouIdeZqA7EucntTRX+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HZZdqLusO774H4HW8QCrCd6oLl2n2Zbc
        okq1QyGp8wiZdOzooadx1xOwHpTo34jrf21dfoTvPklmgBEteZztCCy6UUm0ZHnc
        S/MzGU0/pLO8xNYFvhZYD3q3nUJ6Au0VXf8j+EKXrAat/OkMoNmiUhfcpA8ubgpD
        aaoimL707R0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58CE9F0C25;
        Mon, 31 Aug 2020 13:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F709F0C24;
        Mon, 31 Aug 2020 13:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-4-gitster@pobox.com>
        <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet>
        <xmqq1rjqo2bp.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008311156020.56@tvgsbejvaqbjf.bet>
Date:   Mon, 31 Aug 2020 10:45:02 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008311156020.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 31 Aug 2020 11:59:02 +0200 (CEST)")
Message-ID: <xmqqmu2ag15t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3A7B646-EBB1-11EA-8B69-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 28 Aug 2020, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >  git.c  | 3 ++-
>> >  help.c | 5 ++++-
>> >  2 files changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/git.c b/git.c
>> > index 71ef4835b20e..863fd0c58a66 100644
>> > --- a/git.c
>> > +++ b/git.c
>> > @@ -851,7 +851,8 @@ int cmd_main(int argc, const char **argv)
>> >  	 * that one cannot handle it.
>> >  	 */
>> >  	if (skip_prefix(cmd, "git-", &cmd)) {
>> > -		warn_on_dashed_git(argv[0]);
>> > +		strip_extension(&cmd);
>> > +		warn_on_dashed_git(cmd);
>>
>> The argv[0] may have been NULL from the beginning of cmd_main(), and
>> cmd would be "git-help" in such a case. We used to pass NULL to
>> warn_on_dashed_git() in such a case because "git-help" is not what the
>> user typed, but what we internally trigger, so we didn't want
>> warn_on_dashed_git() to do anything based on that internal string.
>
> True. The test suite passes with this, though, which means we haven't
> covered that case.

Yup, it would be a good thing to add to our tests, with or without
this patch.

>> How does your handle_builtin() work, by the way?
>>
>> The original code (even before we added warn_on_dashed_git() in this
>> codepath) did not do any strip_extension(), so handle_builtin() can
>> take commands with ".exe" suffix, but now we are feeding the result
>> of strip_extension() to it, so it can deal with both?
>
> Yes, it can deal with both. It calls `strip_extension()`, which on Windows
> removes the `.exe` suffix, if found.
>
>> Sounds convenient and sloppy (not the handle_builtin's
>> implementation, but its callers that sometimes feeds the full
>> executable name, and feeds only the basename some other times) at
>> the same time.
>
> Right, it does not _require_ the extension. I do not necessarily agree
> that it is sloppy, but I do agree that it is convenient ;-)

Being lenient to its input is not sloppy.  

It just is by being convenient, it allows its callers to be sloppy,
which may hurt them as not all callees they call may not be as
lenient as handle_builtin(), which is the only downside I would be
worried about.  Nothing big.

thanks.
