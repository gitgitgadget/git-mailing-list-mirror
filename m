Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4311F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbcHLRww convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 13:52:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752915AbcHLRwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:52:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 483B43374E;
	Fri, 12 Aug 2016 13:52:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Cl108lQXT/Gw
	Yaz7UfoR1MAAJ2c=; b=aUlUwzrs0FDEaFs8/SV0bnVIyHZ+LnJI5h2Zm/ACsgn8
	xOwdQgEBeV604t5m0tfMSYBuZ/KoFtXJWDu6HKg3bB8EUb8JaJE2Zo2UslN8w2nu
	Jz+zqjtsmmVDbWJyZ3pByYpxlEVdBcRkbZyDYyRLTeU6kuRFqVXxWOdrMLWJkUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=avX8Q3
	8p8azeZSxqRsURsNuWYT7ZG9AkibS2stplWSnezhqc8SEPFpZVw0WOZHTKgyD5Ok
	B0ch6yVgD7VtS4g5tj2viziNzQIaCK1DYMpZs6OiBGYMWbsn5x+ueAhTDS/Clgol
	JT7LyW2crR7GG4nONjauwVSRrgrfaIP7dUd2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EA933374D;
	Fri, 12 Aug 2016 13:52:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B001F3374C;
	Fri, 12 Aug 2016 13:52:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	tboegi@web.de
Cc:	git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 2/2] convert: missing `LF will be replaced by CRLF
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
	<1471020664-20784-1-git-send-email-tboegi@web.de>
Date:	Fri, 12 Aug 2016 10:52:46 -0700
In-Reply-To: <1471020664-20784-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 12 Aug 2016 18:51:04 +0200")
Message-ID: <xmqqeg5tyivl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95A48038-60B5-11E6-8570-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> When the "new safer autocrlf-handling" was introduced in c4805393, the logic
> around check_safe_crlf() should have been changed:

Should have been changed from what to what?  And instead it was
changed to which other logic?  What is the difference between the
ideal this change tries to bring in and what c4805393 did?

> Once a file has been commited with CRLF (and core.autocrlf is true),
> line endings are no longer converted by "git add" or "git checkout".
> The line endings will not normalized by Git.

s/will not/& be/;

> The user may run e.g. dos2unix and commit the file.

It is unclear what this sentence wants to say.  The user may overwrite
the file with random contents and commit it, too.  So what?

What is missing from this statement is what problem is being worked
around.  Do you mean: "Because Git does not normalize once CRLF is
in the index, if the user wants to have a normalized content in the
repository to correct that mistake, the user needs to do dos2unix to
fix it and commit the fixed result"?

> Factor out will_convert_lf_to_crlf() which returns when LF are converted
> into CRLF at checkout.
>
> Update the logic around check_safe_crlf() and do the possible CRLF-LF
> conversion in "git add".
> Simulate the checkout (and a possible LF-CRLF conversion) with help of
> will_convert_lf_to_crlf().

These two paragraphs are all "what I did to solve X", but what X is
is not very clear.

> ---

Missing sign-off.

>  convert.c            | 97 ++++++++++++++++++++++++++++++----------------------
>  t/t0027-auto-crlf.sh |  6 ++--
>  2 files changed, 60 insertions(+), 43 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 67d69b5..077f5e6 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -189,33 +189,25 @@ static enum eol output_eol(enum crlf_action crlf_action)
>  }
>  
>  static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
> -                            struct text_stat *stats, enum safe_crlf checksafe)
> +			    struct text_stat *old_stats, struct text_stat *new_stats,
> +			    enum safe_crlf checksafe)
>  {
> -	if (!checksafe)
> -		return;
> -
> -	if (output_eol(crlf_action) == EOL_LF) {
> +	if (old_stats->crlf && !new_stats->crlf ) {

Space before ")"
