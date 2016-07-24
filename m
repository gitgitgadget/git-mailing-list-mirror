Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A350203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 07:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbcGXHMH (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 03:12:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751258AbcGXHME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 03:12:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8319D24896;
	Sun, 24 Jul 2016 03:12:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AxOV1AS0bwTMuyTXR+eI/YUER7Q=; b=EX8JD3
	kfC+zTmcTMhCmyiFqKxNAhLhWp/j3CA8DhLYxzvnCe4r79zNLlYiHTFBXy9Iaafn
	ymCGew/5uC4+0iFkBkfovAgjVbubYXgNUhegOje3Ig5BK+QKVDGwUlub2EluL+ZI
	Jn3dxH9r6Np3eG+tgJpxdXVZkF4g8tVxZ1VjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCj4/swenMlmTgGgCuvvwrFe7H2k1Fup
	QirdappsCTBMsGs0FHAnSriSl7SXSyEuSwx7twLtHOE5KiOMfrqBjlkGhnwoC68Y
	sdaQH2uzquEVGwUwO+YV8PFHpr/3XYQYMWHmmYzDLm3QvvudyOlvnNCG2/pIoG44
	GJNK3qaMRuo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BF7724894;
	Sun, 24 Jul 2016 03:12:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F400A24890;
	Sun, 24 Jul 2016 03:12:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by mailsplit
References: <20160722224739.GA22961@whir>
Date:	Sun, 24 Jul 2016 00:11:58 -0700
In-Reply-To: <20160722224739.GA22961@whir> (Eric Wong's message of "Fri, 22
	Jul 2016 22:47:39 +0000")
Message-ID: <xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB2B0D08-516D-11E6-A22D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Users have mistakenly copied "From " lines into commit messages
> in the past, and will certainly make the same mistakes in the
> future.  Since not everyone uses mboxrd, yet, we should at least
> prevent miss-split mails by always escaping "From " lines based
> on the check used by mailsplit.
>
> mailsplit will not perform unescaping by default, yet, as it
> could cause further invocations of format-patch from old
> versions of git to generate bad output.  Propagating the mboxo
> escaping is preferable to miss-split patches.  Unescaping may
> still be performed via "--mboxrd".

As a tool to produce mbox file, quoting like this in format-patch
output may make sense, I would think, but shouldn't send-email undo
this when sending individual patches?
