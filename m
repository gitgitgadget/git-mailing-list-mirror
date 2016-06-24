Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF761FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 22:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcFXWB5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 18:01:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbcFXWBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 18:01:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AB9C27C07;
	Fri, 24 Jun 2016 18:01:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ax9dx51b4ca+kVbB9nkoKUripbQ=; b=hE45Je
	dl8BLijWBa66y0E9Y9/ZShHA+RtvVC2WuLNxdtb4aPp2GviWwJl5A+rdeUKEHkLv
	A9uw5qPaxLmxSkD+txVxm5w1kuXBxwrUwu8+VRsoXlQLCWI/mzID828WzOXbNYub
	xIhZpiEQXRhDiEejtPHeaPxbRbfGRnl4Gx2KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iM1ZtfHDSKU78JzmCjs61YSE5jfGu9nQ
	T6VPeTN7i82Fmc0pUcRD3fwF25AbuXHEysHw/uVmUWs59EPfsD5Fg61gc6THV2i8
	UKaUEXADZo165ppEJ0KOogL+FmRmkytGOK/ihvcUSc07sP0Tn+1pPVFP0cGVGOZJ
	UHPLLUBeAjs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82CB927C06;
	Fri, 24 Jun 2016 18:01:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FE4D27C05;
	Fri, 24 Jun 2016 18:01:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/10] format-patch: explicitly switch off color when writing to files
References: <cover.1466505222.git.johannes.schindelin@gmx.de>
	<cover.1466607667.git.johannes.schindelin@gmx.de>
	<c0fdb78fbb7b19e4b367c50a9c0c570193e98fa3.1466607667.git.johannes.schindelin@gmx.de>
Date:	Fri, 24 Jun 2016 15:01:45 -0700
In-Reply-To: <c0fdb78fbb7b19e4b367c50a9c0c570193e98fa3.1466607667.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 22 Jun 2016 17:01:54 +0200
	(CEST)")
Message-ID: <xmqq1t3mfdpy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F590DFE-3A57-11E6-968C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We rely on the auto-detection ("is stdout a terminal?") to determine
> whether to use color in the output of format-patch or not. That happens
> to work because we freopen() stdout when redirecting the output to files.
>
> However, we are about to fix that work-around, in which case the
> auto-detection has no chance to guess whether to use color or not.
>
> But then, we do not need to guess to begin with. As argued in the commit
> message of 7787570c (format-patch: ignore ui.color, 2011-09-13), we do not
> allow the ui.color setting to affect format-patch's output. The only time,
> therefore, that we allow color sequences to be written to the output files
> is when the user specified the --color command-line option explicitly.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

The right fix in the longer term (long after this series lands, that
is) is probably to update the world view that the codepath from
want_color_auto() to check_auto_color() has always held.  In their
world view, when they are asked to make --color=auto decision, the
output always goes the standard output, and that is why they
hardcode isatty(1) to decide.  The existing freopen() was a part of
that world view.

We'd need a workaround like this patch if we want to leave the
want_color_auto() as-is, and as a workaround I think this is the
least invasive one, so let's queue it as-is.

If the codepaths that use diffopt.file (not just this one that is
about output directory hence known to be writing to a file, but all
the log/diff family of commands after this series up to 5/10 has
been applied) have a way to tell want_color_auto() that the output
is going to fileno(diffopt.file), and have check_auto_color() use
that fd instead of the hardcoded 1, the problem this step is trying
to address goes away, and I think that would be the longer-term fix.

Thanks.

>  builtin/log.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 27bc88d..5683a42 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1578,6 +1578,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		setup_pager();
>  
>  	if (output_directory) {
> +		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
> +			rev.diffopt.use_color = 0;
>  		if (use_stdout)
>  			die(_("standard output, or directory, which one?"));
>  		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
