Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18F920189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcFVVYb (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:24:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbcFVVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:24:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EE0226CDE;
	Wed, 22 Jun 2016 17:23:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZLOGzV7B44Haq3RHiZIS3P5GXuY=; b=yeVkmH
	C6tklj60laZMAYyBQIO+YnlQ0G5xH/v8x1DoJKycwyxu3otvP29FQkyBda/GnKAZ
	1mBNsCWIL98J6PpB5a4fCpJ+wfW60zJ9IeoLYnqra16AHau38j2ne3jz2LltlDSz
	s3lKPbB8fVm3mZNUGSkRDfajXuDL0VTishwJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OgUlGnI0fsQKjNL2zvAO/UhLOMWF4HKJ
	tcqDHzN49fqEWZi3zE1ffnySKe0zqusQ57lkYQTETWoXtb06Zrhcwcx2CpFekPIS
	jnouAL/nHiGPcDIjqLsQR4EpxskeQYP/ATd7TgW7eQnNM+sjdWnjQv0uD9Ctn8GC
	MK6VZ0xEu7Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4164C26CDD;
	Wed, 22 Jun 2016 17:23:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8B0226CDC;
	Wed, 22 Jun 2016 17:23:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v4 0/8] extend smudge/clean filters with direct file access (for pu)
References: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
Date:	Wed, 22 Jun 2016 14:23:28 -0700
In-Reply-To: <1466629758-8035-1-git-send-email-joeyh@joeyh.name> (Joey Hess's
	message of "Wed, 22 Jun 2016 17:09:10 -0400")
Message-ID: <xmqqeg7olxyn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 913843FE-38BF-11E6-8F52-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <joeyh@joeyh.name> writes:

> This is the same as v3, except rebased on top of tb/convert-peek-in-index
> to fix a build failure in pu.

This is somewhat unfortunate, as tb/convert-peek-in-index probably
needs further rerolls after getting reviewed by somebody (other than
me) and this topic will have to be rebased every time.

Let's see how it goes.

Thanks.

>
> Joey Hess (8):
>   clarify %f documentation
>   add smudgeToFile and cleanFromFile filter configs
>   use cleanFromFile in git add
>   use smudgeToFile in git checkout etc
>   warn on unusable smudgeToFile/cleanFromFile config
>   better recovery from failure of smudgeToFile filter
>   use smudgeToFile filter in git am
>   use smudgeToFile filter in recursive merge
>
>  Documentation/config.txt        |  18 ++++-
>  Documentation/gitattributes.txt |  42 ++++++++++++
>  builtin/apply.c                 |  16 +++++
>  convert.c                       | 147 +++++++++++++++++++++++++++++++++++-----
>  convert.h                       |  11 +++
>  entry.c                         |  53 +++++++++++----
>  merge-recursive.c               |  42 +++++++++---
>  sha1_file.c                     |  44 ++++++++++--
>  t/t0021-conversion.sh           | 115 +++++++++++++++++++++++++++++++
>  9 files changed, 441 insertions(+), 47 deletions(-)
