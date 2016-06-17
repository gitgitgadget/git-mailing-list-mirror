Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE5C1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbcFQVRU (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:17:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750986AbcFQVRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:17:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD7E25AEB;
	Fri, 17 Jun 2016 17:17:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XiTLsZCq9QnVdY0AdciEzCJZXPs=; b=EmdW/t
	wE1O/aGbE1WuwAFaTzeiAfyaN0ktYLn1VfGY+JCaiD2zADv8qAr6zrfjuUU3E7lH
	YWAzYu0VDozU/7AuXOXsrU9k8h7Lv5B68Yai6IQYHoJCZcoqKoKTGLQwZN0ca0ls
	/9P1poS31KL0V68Ig1Y9Qv+9+X8tOEfCwJOjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MQpynh7UzCvlwk8m9TCYbk6W0HkgOW+E
	1+KO5v5pALnQy0mYUdXlDnkfuNhY0xd5stFG/gCFY8E++ZMzBWxCV1zH7iHIwth4
	yEi1gSAzNaQA/YP//YiJHAQJgBtQaOn2XlCL62LafggpwpMlwUNWuvm7WLOVrhLf
	ZstyluatSwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 641D425AEA;
	Fri, 17 Jun 2016 17:17:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFB2E25AE9;
	Fri, 17 Jun 2016 17:17:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] extend smudge/clean filters with direct file access
References: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
Date:	Fri, 17 Jun 2016 14:17:16 -0700
In-Reply-To: <1466195481-23209-1-git-send-email-joeyh@joeyh.name> (Joey Hess's
	message of "Fri, 17 Jun 2016 16:31:17 -0400")
Message-ID: <xmqqshwbzfab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEEC937C-34D0-11E6-B0C3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <joeyh@joeyh.name> writes:

> Reroll of this patch set with changes:

... where is this 4-patch series designed to apply?  The first one
already fails...

Applying: add smudgeToFile and cleanFromFile filter configs
.git/rebase-apply/patch:28: trailing whitespace.
	Similar to filter.<driver>.clean but the specified command 
.git/rebase-apply/patch:30: trailing whitespace.
	receiving the file content from standard input. 
.git/rebase-apply/patch:129: indent with spaces.
                        struct strbuf *dst, const char *cmd)
fatal: sha1 information is lacking or useless (Documentation/gitattributes.txt).
error: could not build fake ancestor
Patch failed at 0001 add smudgeToFile and cleanFromFile filter configs
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


>
> * Renamed the new filter drivers for consistency with other configs.
> * Improved documentation with feedback from Junio and others.
> * Eliminated %p and instead append the filename to the commands
>   (separated by a space).
> * Fixed an FD leak and a space leak.
> * Only use smudgeToFile with regular files, not symlinks.
> * After running the smudgeToFile command, double-check that the
>   expected file is present, in case the command was buggy and deleted it.
> * Added a warning message when the new filter commands are configured
>   but the old ones are not, so that the user knows it's refusing to use
>   their configuration.
>
> There's been good and helpful documentation and interface review,
> but some more code review would be good! Also, git-annex has a
> improved-smudge-filters branch now that demonstrates this interface.
>
> Joey Hess (4):
>   add smudgeToFile and cleanFromFile filter configs
>   use cleanFromFile in git add
>   use smudgeToFile in git checkout etc
>   warn on unusable smudgeToFile/cleanFromFile config
>
>  Documentation/config.txt        |  18 +++++-
>  Documentation/gitattributes.txt |  37 ++++++++++++
>  convert.c                       | 126 +++++++++++++++++++++++++++++++++++-----
>  convert.h                       |  10 ++++
>  entry.c                         |  37 +++++++++---
>  sha1_file.c                     |  42 ++++++++++++--
>  t/t0021-conversion.sh           |  64 ++++++++++++++++++++
>  7 files changed, 304 insertions(+), 30 deletions(-)
