Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC68203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcGVTvG (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:51:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751619AbcGVTvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:51:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 065332E168;
	Fri, 22 Jul 2016 15:51:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lgUoMLyxoHG3S85apcWNxo8G7kQ=; b=U56ipQ
	Jaw/RFoYsEznB0fuNscBNuMRjdnj1JO2R3cjPn+r5C3NfH4DJoVV17Hw8PygaTkU
	GCU8A57UCbgltUbJKf/S7SQusNGchnetk5AQvx1U2cGXGjGKY4DRrGN0VHnOs/NR
	6akOFVdjrVfSTFsZD6XyM4kh8IfdJgcbxLcvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YEHg5r6BW7xo0ChiJ4usQCU42GcnYImw
	oisfBnCWChH4+AQMasWIP44QoBCFhd+KkQos+AuJc/DofXS8yLeSe8qBnhIJ+dgM
	AtDeWPBHxPt3EUga1ZfTe6J5+JNVjMiIURFCCPzXUfkddRUx60C0P588aoLXsMXe
	D28i4u0wQzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0D5C2E167;
	Fri, 22 Jul 2016 15:51:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E09B2E166;
	Fri, 22 Jul 2016 15:51:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
	<20160720134211.GA19359@sigill.intra.peff.net>
	<xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
	<20160720205207.GA578@sigill.intra.peff.net>
	<xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
	<20160722192811.GA18079@sigill.intra.peff.net>
Date:	Fri, 22 Jul 2016 12:51:00 -0700
In-Reply-To: <20160722192811.GA18079@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Jul 2016 15:28:11 -0400")
Message-ID: <xmqqa8h9a1uj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E866994-5045-11E6-B5DF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This comes from b22520a3 (grep: allow -E and -n to be turned on by
>> default via configuration, 2011-03-30) back when we didn't have a
>> more generic grep.patternType configuration mechanism in v1.7.5
>> days, and it probably need to be deprecated to maintain our sanity.
>> ...
> I am not even sure we need to deprecate it. Once it becomes merely a
> historical synonym for "grep.patternType=extended" we can live with it
> indefinitely (and I do not think we need a deprecation period to go
> there; the existing behavior is simply buggy).

I grossed over an important detail.

Pretending as if grep.patternType=extended were given when we see
grep.extendedregexp=true and grep.patternType=basic is given when
grep.extendedregexp=false changes the behaviour in a way that can be
seen as the violation of (crazy) expectations t7810 makes.

Any user who depends on that crazy expectation will be broken by
such a change, even if we do not deprecate and remove the
configuration variable.

 grep.c | 4 ++--
 grep.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 394c856..7b1d423 100644
--- a/grep.c
+++ b/grep.c
@@ -73,9 +73,9 @@ int grep_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "grep.extendedregexp")) {
 		if (git_config_bool(var, value))
-			opt->extended_regexp_option = 1;
+			opt->pattern_type_option = GREP_PATTERN_ERE;
 		else
-			opt->extended_regexp_option = 0;
+			opt->pattern_type_option = GREP_PATTERN_BRE;
 		return 0;
 	}
 
diff --git a/grep.h b/grep.h
index cee4357..fc36c2a 100644
--- a/grep.h
+++ b/grep.h
@@ -119,7 +119,6 @@ struct grep_opt {
 	int max_depth;
 	int funcname;
 	int funcbody;
-	int extended_regexp_option;
 	int pattern_type_option;
 	char color_context[COLOR_MAXLEN];
 	char color_filename[COLOR_MAXLEN];
