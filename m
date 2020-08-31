Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6716EC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A2220719
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OOlGtKuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgHaEtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:49:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60217 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaEtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 00:49:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61774E2CCA;
        Mon, 31 Aug 2020 00:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kmoB4BCQT7icQY1JUj63xX0P6XE=; b=OOlGtK
        uHi+fm7nLBkRjQ5ra/A4yf4P3LBfHqktvoR+Ct4u7z7euN5Nob88uLS7P4S+jaqG
        jSeFIVoLY+MrixQBYechEK+DONq7QMnLcRFKEBu81wkF50HStBKQ3tiE+o3K7XL5
        0fownRk1wclo7zpjmkIMKYqXFPyN+6mC582lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d6OAKRDSiprUDt1lm3Xm+5F6TJFcn021
        Vauik3MLfRiiPFm1SiGNjZD/RqFXmdvZeCL97xlRaYRb7Rd9EfMGNbWPtsN7mZMs
        Gw8nNBHgxxIiB7yqquUkH2jnOxk7fTMyBYW69D51VGevbAYdDWXkq6y6AsMoSyQe
        bOE/gn8mWGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A598E2CC8;
        Mon, 31 Aug 2020 00:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FA21E2CC7;
        Mon, 31 Aug 2020 00:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] revision: add separate field for "-m" of "diff-index -m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200829201140.23425-1-sorganov@gmail.com>
Date:   Sun, 30 Aug 2020 21:49:32 -0700
In-Reply-To: <20200829201140.23425-1-sorganov@gmail.com> (Sergey Organov's
        message of "Sat, 29 Aug 2020 23:11:40 +0300")
Message-ID: <xmqqo8mrh12b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DC4C474-EB45-11EA-A016-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Historically, in "diff-index -m", "-m" does not mean "do not ignore merges", but
> "match missing". Despite this, diff-index abuses 'ignore_merges' field being set
> by "-m", that in turn causes more troubles.

"causes more troubles"?  When there is no trouble, and no "more"
trouble, concretely mentioned, it is a quite weak justfiication.

There is no reason to say "historically" here, as it has been like
so from beginning of the time, it still is so and it is relied
upon.  "diff-{files,index,tree}" are about comparing two things, and
not about history (where a "merge" might influence "now we are
showing this commit.  which parent do we compare it with?"), so
giving short-and-sweet "-m" its own meaning that is sensible within
the context of "diff" was and is perfectly sensible thing to do.

What is worth fixing is not "-m" in diff-index means "match missing"
while "-m" in log wants to mean "show merges".  It is that, even both
commands use the same option parsing machinery, and the use of these
two options are mutually exclusive so there is no risk of confusion,
the flag internally used to record the presense of the "em" option is
not named neutrally (e.g. "revs->seen_em_option").

	The "log" family of commands and "diff" family of commands
	share the same command line parsiong machinery.  For the
	former, "-m" means "show merges" while for the latter it
	means "match missing".  Tnis is not a problem at the UI
	level, as "show/not show merges" is meaningless in the
	context of "diff", and similarly "match/not match missing"
	is meaningless in the context of "log".

	But there are two problems with this arrangement.

	1. the field the presense of the option on the command line
	   is recorded in has to be given a name.  It is currently
	   called "ignore_merges", which gives an incorrect
	   impression that using it for "diff" family is somehow a
	   mistake, and renaming it to "match_missing" would not be
	   a solution, as it will give an incorrect impression that
	   "log" family is abusing it.  However, naming the field to
	   something neutral, e.g. "em_option", would make the code
	   harder to understand.

	2. because it uses the same command line parser, giving a
    	   default for "diff -m" in a way that is different from the
    	   default for "log -m" is quite cumbersome if they use the
    	   same field to record it.

	Introduce a separate "match_missing" field, and flip it and
	"ignore_merges" when we see the "-m" option on the command
	line.  That way, even when ignore_merges's default is
	affected by end-user configuration, the default for
	"match_missing" would not be affected.

I think the above would be in line with what you wanted to say but
didn't, and I think it supports the split fairly well.

I have a very strong objection against changing the built-in default
of "log -m", but I do agree that this split of the single field into
two is a fairly good idea.  So I do not want to be in the position
that must reject this change because "log -m" and "diff-index -m"
will never be on by default.  Basing the justification of this
change on end-user configurability would be a good way to sidestep
the issue, and avoids taking this change hostage to the discussion
on what should be the built-in default for "log/diff-index -m".
