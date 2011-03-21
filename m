From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 09:15:58 -0700
Message-ID: <7voc54sb41.fsf@alter.siamese.dyndns.org>
References: <1300700704-22674-1-git-send-email-bebarino@gmail.com>
 <1300700704-22674-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hmB-00019w-1M
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab1CUQQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:16:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab1CUQQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:16:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B006E4507;
	Mon, 21 Mar 2011 12:17:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGXfLj+x2USNHQTQfUDuHqtMeJc=; b=tc/q4O
	7vXcdp94LThL/eZyYoVblX6vaYNawNQCfDksxe79rxjNuRbKQN+d5Do7hmc5uorP
	pJTb8I+4wnRUMhDBq/D9ZzjaqB0olKIwAH2RcmgRSDLwugM9c+43c6BVC9Gf62NC
	csoE3Kw6PJiQ+tJ0iBo/i1EtI7nl9qn4m5+Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aaPld1nUU5xpeuCdlp4SsltwKey/8wFy
	5IX/Fh6msrUDOt7lsNzPnjXwSVuCxyGjVIpra1eRmxc1SLUWrC0fht0zS7p9p1mG
	l0ERKDZv+jpee0A4B95W3OuvJhShHFbvCM1fBNyppTytl8Fia4BnTTbpxgzPk9ga
	invXKq1xKYs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EA454503;
	Mon, 21 Mar 2011 12:17:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48D0A44FC; Mon, 21 Mar 2011
 12:17:38 -0400 (EDT)
In-Reply-To: <1300700704-22674-2-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon, 21 Mar 2011 02:45:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFAD2FCA-53D6-11E0-9694-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169608>

Stephen Boyd <bebarino@gmail.com> writes:

> Fix warnings from 'make check'.
>
> diff.c:631:25: warning: symbol 'diff_words_styles' was not declared.
> Should it be static?
> notes-merge.c:362:73: warning: Using plain integer as NULL pointer
> parse-options.c:564:6: error: symbol 'usage_with_options' redeclared
> with different type (originally declared at parse-options.h:158) -
> different modifiers
> parse-options.c:571:6: error: symbol 'usage_msg_opt' redeclared with
> different type (originally declared at parse-options.h:161) - different
> modifiers
> ...

Yuck.  Could you summarize the errors by grouping them by type or
something in the log?  One mega-patch we can swallow, but the log is
unreadble.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 02547ad..53ea012 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -23,6 +23,7 @@
>  #include "branch.h"
>  #include "remote.h"
>  #include "run-command.h"
> +#include "builtin.h"

Documentation/CodingGuidelines suggests to move this to the top, probably
replacing '#include "cache.h"' we have there:

 - The first #include in C files, except in platform specific
   compat/ implementations, should be git-compat-util.h or another
   header file that includes it, such as cache.h or builtin.h.
