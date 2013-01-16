From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow custom "comment char"
Date: Wed, 16 Jan 2013 12:30:39 -0800
Message-ID: <7vip6wx440.fsf@alter.siamese.dyndns.org>
References: <1358275827-5244-1-git-send-email-ralf.thielow@gmail.com>
 <1358363928-16729-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:31:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvZdY-0005uX-B1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 21:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3APUao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 15:30:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab3APUan (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 15:30:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD351C781;
	Wed, 16 Jan 2013 15:30:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lbys0mZPkWt4w9+kO6EtdqnggQQ=; b=dDe25s
	z63+1G6r5IeGIvKdXCFR6iaEmNKb2vlrs+RdM4OOo326Q52PTa52NStQrgArI3A4
	RCEkn3W18DjrJg6MQXB2GjmdaBIbCaIyNberk+qUC1FbzzqFmPeLkyYmS+pQ0+8n
	TJnI+ENxcoqwhMbPBSsaifTlejk6EYZt2gFis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dw8AaRuAzb5cl9CNA5WNSms7v5VTN6wb
	KxKXq/Y5mL3if0JYxh9UNG0hH242WwIwy+864YW0Q0b9oG8aaYr6waKHYjcMsoDR
	AqwkKA8gb0l2qVn3z9RzsGnLlEvRl/fZhM/M2JDT8iYzhZm1vUF8uCps5W+Qo0Xu
	3RPNNzW1n9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFBC3C780;
	Wed, 16 Jan 2013 15:30:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8462AC77A; Wed, 16 Jan 2013
 15:30:41 -0500 (EST)
In-Reply-To: <1358363928-16729-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Wed, 16 Jan 2013 20:18:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98C1206C-601B-11E2-BB1C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213810>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Some users do want to write a line that begin with a pound sign, #,
> in their commit log message.  Many tracking system recognise
> a token of #<bugid> form, for example.
>
> The support we offer these use cases is not very friendly to the end
> users.  They have a choice between
>
>  - Don't do it.  Avoid such a line by rewrapping or indenting; and
>
>  - Use --cleanup=whitespace but remove all the hint lines we add.
>
> Give them a way to set a custom comment char, e.g.
>
>     $ git -c core.commentchar="%" commit
>
> so that they do not have to do either of the two workarounds.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Junio, thanks for the code in your reply to the
> first version. It works very well and looks nice.
> I was also unhappy about this "\n%c\n" thing and
> pretty unsure with the code in "git-submodule.sh".
> But with this, it looks good to me. Thanks.
>
> Changes in v2:
> - extend "git stripspace" with an option to make
>   it's input being converted to commented lines
> - teach git-submodule.sh using this
> - rename strbuf_commented_addstr to strbuf_add_commented_lines
>   and improve it's design

Oh, I love it when something like this happens.  Throw a "perhaps
along these lines" patch and then a finished product that fills the
gaps I didn't bother to fill magically appears, even with tests and
updates to comments and documentation.

What good things did I do recently to deserve such a luck? ;-)

> @@ -66,21 +67,52 @@ void stripspace(struct strbuf *sb, int skip_comments)
>  	strbuf_setlen(sb, j);
>  }
>  
> +static void comment_lines(struct strbuf *buf)
> +{
> +	char *msg;
> +	size_t len;
> +
> +	msg = strbuf_detach(buf, &len);
> +	strbuf_add_commented_lines(buf, msg, len);
> +}

This leaks msg (inherited from my "perhaps along these lines"
patch).  I think I can just add free(msg) at the end.

> +	if (strip_comments || mode == COMMENT_LINES)
> +		git_config(git_default_config, NULL);

Nice spotting.  The "along these lines" patch broke "stripspace -s"
under custom comment line char; this fixes it.

Thanks.
