From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: remove unused includes
Date: Fri, 09 Jan 2015 11:52:01 -0800
Message-ID: <xmqq7fwvd95q.fsf@gitster.dls.corp.google.com>
References: <1420798353-12316-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 20:52:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9fbT-0005TE-TR
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 20:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbbAITwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 14:52:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751678AbbAITwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 14:52:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D20FF2EA6F;
	Fri,  9 Jan 2015 14:52:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A7ZuHss+MbvmRzGDn7ZEqrxTpwQ=; b=Q0x7SJ
	zCjlDKuo7HrmDeXJbBqubqHVX2iUBj4NT38Ld7WrkjfN7qVP+PgDIKVracwaVBo9
	8NxWQ+i7Ku1cysiEmAF1JxHTpNGVwKohUjBhspDSZGsiITgWlsSE2n1l6mL72tlj
	ktm8FLm5aySG6fOQT6xzfkCboOTxh07pB/maU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkYXwJvG17V+bZMthyLmLOn9Zhd6cpjZ
	PYmVW36eDKqPQUa615ShWZPOTd8igzoshhvAGA7zDae3GWP2eT6dnGhNdmJW+c11
	A+sJwqRhdt1HZCYHsKvLV2aYPTAyUDlzdS+KtgsPRoXPdMBEKe6NjvbRduIs/Hza
	8+ujJcWoHM4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C91C72EA6E;
	Fri,  9 Jan 2015 14:52:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29A352EA6A;
	Fri,  9 Jan 2015 14:52:03 -0500 (EST)
In-Reply-To: <1420798353-12316-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 9 Jan 2015 16:12:33 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB6D4E6E-9838-11E4-81A9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262243>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> * <cache.h> and <commit.h> already included in <builtin.h>
>
> * <quote.h> was appeared in (6035d6aa GIT_TRACE: show which
> built-in/external commands are executed  25 Jun 2006) and sq_quote_print
> was removed at (82aae5c quote: remove sq_quote_print() Jul 30 2013)

That's not 6035d6aa, though.

We started to include "quote.h" at 575ba9d6 (GIT_TRACE: show which
built-in/external commands are executed, 2006-06-25) that wanted to
use sq_quote_print().

When 6ce4e61f (Trace into a file or an open fd and refactor tracing
code., 2006-09-02) introduced trace.c API, the calls this file makes
to sq_quote_print() were replaced by calls to trace_argv_printf()
that are declared in "cache.h", which this file already includes.
We should have stopped including "quote.h" in that commit, but
forgot to do so.

>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  git.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/git.c b/git.c
> index 09b3bcf..c9bec99 100644
> --- a/git.c
> +++ b/git.c
> @@ -1,10 +1,7 @@
>  #include "builtin.h"
> -#include "cache.h"
>  #include "exec_cmd.h"
>  #include "help.h"
> -#include "quote.h"
>  #include "run-command.h"
> -#include "commit.h"
>  
>  const char git_usage_string[] =
>  	"git [--version] [--help] [-C <path>] [-c name=value]\n"
