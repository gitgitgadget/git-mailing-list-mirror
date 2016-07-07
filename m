Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E347420705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbcGGVVd (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:21:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751206AbcGGVVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:21:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB3932ABCE;
	Thu,  7 Jul 2016 17:21:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gbQT6OR/DVLIMItNUynFxgrIW08=; b=vCgnSu
	G53LTb0cVlNLDNMWoeDnGIpqesTCcbfFmLlVRejQWN9ktF+BucYsdRvwFfai8vNb
	PTvJz9znJv+Sl2pJU7s3hC129tzWYfcSjs7321YLDXghRQvuoNUITKXGQaIWzP5e
	4limmK6l3QYTfqoYcTyxN7q+XcGYPh6CUHNIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5dxA+e3Y0xpZjx8l0nNyKZjMomdLVpl
	Fepa71EieBYzvgttaMSYxd8yHIMvv/AWaV8f7jnSaUeIQo+snnca11zYQ+EVKXO5
	omet/6ElRbFyIq7bUbRB4+Fh4ZO8USoTTZnh4N9xmCYfyI3iTZG3UuTbzZxjCJCA
	fazEsDl8dQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7AA02ABCD;
	Thu,  7 Jul 2016 17:21:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33A822ABCC;
	Thu,  7 Jul 2016 17:21:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #02; Wed, 6)
References: <xmqqr3b6qwdt.fsf@gitster.mtv.corp.google.com>
	<20160707204002.GA19138@hashpling.org>
Date:	Thu, 07 Jul 2016 14:21:28 -0700
In-Reply-To: <20160707204002.GA19138@hashpling.org> (Charles Bailey's message
	of "Thu, 7 Jul 2016 21:40:02 +0100")
Message-ID: <xmqqshvlnnzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5910620-4488-11E6-A4DF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> I just wanted to clarify what was actually fixed. The actual bug that
> was reported and fixed was the fact that 'git grep' (without --cached)
> wasn't searching the contents of files in the working tree if the index
> entry had the "intent to add" bit set.

Ouch, you are absolutely right.

 Git does not know what the contents in the index should be for a
 path added with "git add -N" yet, so "git grep --cached" should not
 show hits (or show lack of hits, with -L) in such a path, but that
 logic does not apply to "git grep", i.e. searching in the working
 tree files.  But we did so by mistake, which has been corrected.

perhaps?

Thanks.
