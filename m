From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Sun, 15 May 2011 15:42:18 -0700
Message-ID: <7vei3zoab9.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 00:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLk1I-0006a8-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 00:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab1EOWm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 18:42:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1EOWm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 18:42:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B38B55900;
	Sun, 15 May 2011 18:44:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4spDmgT+f6heEc6z0qsPyTTlBc=; b=S36rS/
	Y7gTNP0Ndaeqq3AQSUmzwiXu6WaKYLzp96Gsl4yuZfuZWyolTeu2o1XufcwC8AJP
	YUxQqIamI6ashNQgKBXlKTz8y0RqadBbTDZm2hcHaFqyevcybSShY2ClotUWmv7C
	bNY1N6FdyO58WN0VKNEFy8Eq4Gapamx/UYA00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCMbIWDOrpboGSP6RVxZIvHQyEtMZpSZ
	BwsDWShO4jWp5Yio3L0BQ+o6ZpG8Pw4eRlF808lxMkBlmLkMqsHQYHbBXXQm8Z6J
	Exb9XeqiYCtNoil9xpKD0WbFjIDk3cjtpfyPZCpKtMK637EQZsfiQz9vpQEGnHOq
	tYN7dYuq9oU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8031058FD;
	Sun, 15 May 2011 18:44:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A0B558FB; Sun, 15 May 2011
 18:44:25 -0400 (EDT)
In-Reply-To: <1305413341-56450-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sat, 14 May 2011 18:49:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4CFB5B8-7F44-11E0-A91E-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173681>

Jay Soffian <jaysoffian@gmail.com> writes:

> @@ -137,6 +139,12 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	    && rev->commit_format == CMIT_FMT_RAW)
>  		decoration_style = 0;
>  
> +	/* ditto for log.abbrevCommit */
> +	if (!rev->abbrev_commit_given && rev->abbrev_commit
> +	    && rev->commit_format == CMIT_FMT_RAW)
> +		rev->abbrev_commit = 0;
> +
> +

I am not entirely happy about this change. The "ditto" refers to an ugly
workaround we had to add with 4f62c2b (log.decorate: only ignore it under
"log --pretty=raw", 2010-04-08) only because it was too late to revert the
change in 72d9b22 (Merge branch 'sd/log-decorate', 2010-05-08) that was
about to become part of 1.7.2-rc0 release. If we knew better, we probably
wouldn't have added the log.decorate variable that requires this hack that
requires us to say that 'log --pretty=raw' is special.

If we stop before adding a new configuration, we do not have to repeat the
same mistake we made earlier.

I dunno.
