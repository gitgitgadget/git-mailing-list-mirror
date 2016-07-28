Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777B51F858
	for <e@80x24.org>; Thu, 28 Jul 2016 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcG1VhK (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 17:37:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751129AbcG1VhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 17:37:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16FB03020B;
	Thu, 28 Jul 2016 17:37:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CZX2XEpbLO+rbgAgKLDmuajFPzM=; b=a+kZd0
	IKZgEG6MxC9igc+JScfh+YsH1xGm5y1dTb4iL71+3z+F05e911H2zrufIV+S4+L7
	7Y7e55hH0/8PD7dW5WXd8B0zKFSDHY9nRVs+rVDY6piflA0aeyguxffdL+51IAgL
	kx3ch8Y8klUfhffmjqtZ7OrWmNMP8uRXtSuyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KgOgcbLRZPqx5aUu4ilfacc33s2wjl2g
	tfEN7YwNTVq0DEWWGom3Y7Ugx8tDgXp76SNO0pZhehFQpbQ/Nqnkx4xwlxu/Pg7b
	xxuswvA5uovza+pQzYK6YcKhxfcSp5FEynrTlqvfOHDKTyB3agrfi7sc1snFsqld
	FS1cdWDzC00=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D9073020A;
	Thu, 28 Jul 2016 17:37:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FE3930209;
	Thu, 28 Jul 2016 17:37:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
References: <20160728211149.GA371@x>
Date:	Thu, 28 Jul 2016 14:37:04 -0700
In-Reply-To: <20160728211149.GA371@x> (Josh Triplett's message of "Thu, 28 Jul
	2016 14:11:51 -0700")
Message-ID: <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E49BA72-550B-11E6-B8AC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> I'd like to propose changing the default behavior of git-format-patch to
> --from (and adding a --from-author option to override, and perhaps a
> config setting).  This will not change the output *except* when
> formatting patches authored by someone else.  git-am and git-send-email
> both handle the --from format without any issues.

I see this in "format-patch --help":

           Note that this option is only useful if you are actually
           sending the emails and want to identify yourself as the
           sender, but retain the original author (and git am will
           correctly pick up the in-body header).  Note also that
           git send-email already handles this transformation for
           you, and this option should not be used if you are
           feeding the result to git send-email.

The first one says "only useful", but it seems what it really means
is "it becomes no-op if you are sending your own patch anyway".  So
that one does not worry me.  What is most worrysome is the latter
half of the last sentence.  Is it really "should not be", or is it
merely "use of this option is just a waste of time, as you would get
exactly the same result anyway"?  If it is the latter, that is fine.

One thing I absolutely do not want to see is people to start
repeating their own ident on in-body "From: " header when they send
their own patch.  That would waste everybody's time pointing out
"You do not have to do that, it merely adds noise".  As long as you
can guarantee that your change won't increase the rate of that, I am
fine with the proposal.

Thanks.

