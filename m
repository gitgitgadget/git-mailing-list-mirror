Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DA81FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbcFPR7r (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 13:59:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754033AbcFPR7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 13:59:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1889C251FC;
	Thu, 16 Jun 2016 13:59:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aWvrZQsqJntuatdDAq5ziDqUElc=; b=DqXlFB
	gZscvv16ALVGaCAyx/nPJUkuZK9psI6cyeoAJXd7yoAj2W896NAe+TS4+LIev37U
	zoWz2CxbRSjbXhcfe/6+HxsFfzteXJ65simndmInsYly3QkmJ2MQ7eXinEL0W9hO
	7BIZYzv1hLj1koKOFa9SCCRkAVvL+rvlIWTSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNIFV7UlkC/H8JCrc+eVNqUOgn/4SH+A
	xwZrmmPS6DuDY71HN4RYjEoCQ1+fClLGjUAZ59VZQpsczHPdrkPikJaEP3xw4sfW
	6ihAWaK3lmeZ01zkWUyLk6SIvfl7EUj2oOlxhqsxk56IiNWFB83/afi8QZVGUxbI
	ZZ+mQXun0pc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10D27251FB;
	Thu, 16 Jun 2016 13:59:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89C78251FA;
	Thu, 16 Jun 2016 13:59:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Chris Packham <judge.packham@gmail.com>
Cc:	GIT <git@vger.kernel.org>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
	<CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
Date:	Thu, 16 Jun 2016 10:59:42 -0700
In-Reply-To: <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
	(Chris Packham's message of "Thu, 16 Jun 2016 17:02:02 +1200")
Message-ID: <xmqqbn31581d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B5D8662-33EC-11E6-A372-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Chris Packham <judge.packham@gmail.com> writes:

> On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi All,
>>
>> I have the git-sh-prompt configured in my .bashrc today I visited an
>> old worktree that I haven't really touched in a few years (sorry can't
>> remember the git version I was using back then). I received the
>> following output when changing to the directory
>>
>> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
>> <= item->len && item->prefix <= item->len' failed.
>>
>> I assume it's one of the git invocations in git-sh-prompt that's
>> hitting the assertion. Any thoughts on what might be triggering it?
>> Any debug I can gather?
>
> A bit more info. The directory in question is a uninitialised
> submodule. It doesn't trigger in the root of the parent project.


Sounds like
http://article.gmane.org/gmane.comp.version-control.git/283549

