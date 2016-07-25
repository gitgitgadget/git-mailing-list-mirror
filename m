Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB225203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcGYPqL (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 11:46:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752108AbcGYPqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 11:46:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95A122FD1C;
	Mon, 25 Jul 2016 11:46:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XG3G0MKgGZwXqENxiwQYJkF0HD8=; b=XZtvkE
	wOoX0k+jOmn7U1+qK99CtCUNtDdg+80OpJJFUl2l6PZdR0UuDOgClU8dpidPNcBD
	EnRpIIwVFmRajqeNGec8+oTHsIrj5lWzgjMsna9Fz9v3Z2TKdBMhQVxEv9PxZSgI
	EzIjtsCJAnmjSbHk5ccbBWdlvAPqZhiOoN/v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wKpQu3DunKvFpKzlQqf04/asqST7Vp33
	2c+yv4dGC7nofMCYGSKvfIZFwaLByomY5v+RTyh6OUf3fY5YYDLvP8P4BL5m0bF4
	aIXzUba4Pt6BqDeWfp+Ba5mAXfJDrI82EBG176bFGRf8n6fEAbElp9kEOZWXdEEI
	FT68hLN5Jnw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B87F2FD1B;
	Mon, 25 Jul 2016 11:46:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC3F52FD19;
	Mon, 25 Jul 2016 11:46:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
	<20160720172419.25473-1-pclouds@gmail.com>
	<20160720172419.25473-4-pclouds@gmail.com>
	<CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
	<xmqqmvl9boju.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbH=ywi7sXUz5KKyRqo-Eg4RF3W9pf53rzKE-oz5-PW1Q@mail.gmail.com>
Date:	Mon, 25 Jul 2016 08:46:04 -0700
In-Reply-To: <CAGZ79kbH=ywi7sXUz5KKyRqo-Eg4RF3W9pf53rzKE-oz5-PW1Q@mail.gmail.com>
	(Stefan Beller's message of "Fri, 22 Jul 2016 10:40:44 -0700")
Message-ID: <xmqqwpk97mbn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6A76C24-527E-11E6-8BAF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jul 22, 2016 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  * submodule.$name.update, submodule.$name.ignore,
>>    submodule.$name.branch, etc. would need to be all different among
>>    worktrees of the superproject, as that is the whole point of
>>    being able to work on separate branches of the superproject in
>>    separate worktrees.
>
> What do you mean by "would need". The ability to be different or rather
> the veto of an 'inheritance' of defaults from the repository configuration?

They have to be able to represent different settings per worktree
that checks out different branches/commits of superproject.  They
may happen to be set the same, but they do not have to be.

Is what I meant.
