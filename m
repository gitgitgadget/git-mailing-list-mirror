Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01CF2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbcGFSPe (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:15:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754068AbcGFSPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:15:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C5E5285C0;
	Wed,  6 Jul 2016 14:15:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VGvLK/FTBb0W1vIQdfVOJv7D5FY=; b=f1H0Fb
	KRSrnkJhB4i5oeFD83rAz2pC6UPVc5iKV2mgHsswHBgpFPTmEPbaozu8oe2CqGzU
	sbEBNaEj/RG+H07MSjcu3XpP/Upqnmu2hQCVeGujQqOJzIJSOYBGEKQNYfYovkCA
	APMuJsOq43yAwOjG1WrEK+Nagxoj380kTI54U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z8ltOzrN0sJBZMDXcXXLt2kY6mRhzdjO
	rYGT1g71lBmNHyceSh2IUR6/oay1G6M0+A+JAU1vmkiuiCHXGuhRp4U6HqhgQvCj
	xxU1r/pNjwiLc47jUT+GdwFMFGHsvc3nP4AfhsldDc7A5JiakBO1f8QxeqdKDkHV
	isfilUarb6k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DB76285BF;
	Wed,  6 Jul 2016 14:15:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1446D285BE;
	Wed,  6 Jul 2016 14:15:31 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Christopher Layne <clayne@anodized.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-svn: clone: Fail on missing url argument
References: <20160703053923.GA12956@ns1.signalpunk.com>
	<20160703061553.GA20458@dcvr.yhbt.net>
Date:	Wed, 06 Jul 2016 11:15:29 -0700
In-Reply-To: <20160703061553.GA20458@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 3 Jul 2016 06:15:53 +0000")
Message-ID: <xmqqvb0iske6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FCB5410-43A5-11E6-A9E3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Christopher Layne <clayne@anodized.com> wrote:
>> * cmd_clone should detect a missing $url arg before using it otherwise
>>   an uninitialized value error is emitted in even the simplest case of
>>   'git svn clone' without arguments.
>
> Thanks, this patch looks obviously correct.
>
> I've eliminated the '* ' and space prefix from the version I've
> applied since it's not the convention around here.
>
>> Signed-off-by: Christopher Layne <clayne@anodized.com>
>
> Signed-off-by: Eric Wong <e@80x24.org>
>
> And pushed to "master" of git://bogomips.org/git-svn
> (I'll request for Junio to pull within a few days while
>  other changes pile up).

Thanks.

>>  sub cmd_clone {
>>  	my ($url, $path) = @_;
>> -	if (!defined $path &&
>> +	if (!$url) {
>> +		die "SVN repository location required ",
>> +		    "as a command-line argument\n";
>
> "as a command-line argument" seems like an unnecessary phrase,
> but I see we use it elsewhere; so it's fine here.
>
> I might be tempted to queue up a separate patch
> to eliminate this extra statement from the rest of git-svn,
> though.  Not sure if others feel the same way.

If it _can_ come from somewhere else (perhaps a future enhancement
may allow you to configure where to clone from?  Not likely for
cmd_clone but other places in git-svn may be talking about something
that could be configured in the future), then "as a command-line
argument" is not just unnecessary but actively waiting to harm the
users.

But otherwise I do not think anybody cares either way.
