From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: user format ignores i18n.logOutputEncoding
 setting
Date: Mon, 25 Jul 2011 12:45:26 -0700
Message-ID: <7vwrf6qh49.fsf@alter.siamese.dyndns.org>
References: <1311589875-12569-1-git-send-email-zapped@mail.ru>
 <1311589875-12569-2-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Shumkin <zapped@mail.ru>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 21:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlR5r-0005XB-Ha
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 21:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab1GYTpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 15:45:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab1GYTp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 15:45:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1FD3445D;
	Mon, 25 Jul 2011 15:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=evVztauhE4abI9l5trBgb1HCW9s=; b=EUuYZd
	kcNpYdBWl1wd5USBllKcpJ9q2Aoa/OZnPVUxpoOLQLVYuSG2/GNt45pK3bX7S9VA
	8Oozb2/u2NO08DiedX4hfp9wZ1FNw19AIyjEM8w3OjQPoGjKa5/xSbJZcP8EkiKW
	zG0m/kLvkE4y5GiJA+tiIqyTrhcem3P+q0Xpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPqtQv2xaotCyjDBt1IYVHaRt8zWU+cq
	j1ssvSb+b6eoi9mAqAmPRZmO5qAz0mrZ7Q5PexSJH9fh80hchvBDWu2KhX67BLAG
	t2LTi5P1riZbKumEEJEtRIqYquvTOAKRbzq8kelzMA1AKMxnYtutVd+tjHfOQLjh
	iUV3QKF5vCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9369445C;
	Mon, 25 Jul 2011 15:45:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49A49445A; Mon, 25 Jul 2011
 15:45:28 -0400 (EDT)
In-Reply-To: <1311589875-12569-2-git-send-email-zapped@mail.ru> (Alexey
 Shumkin's message of "Mon, 25 Jul 2011 14:31:15 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5ED7A6C-B6F6-11E0-9DF5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177812>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> git log --graph --oneline
> and
> git log --graph --pretty=format:'%C(yellow)%h %Creset%s'
> give different outputs on Linux UTF-8 console
> when commit messages contain non-UTF-8 characters

(content) "different" is not specific enough to describe a problem (in
some cases, difference in command line arguments is the way to obtain
different results), especially if you do not state that they "should" be
the same to begin with, and preferrably under what condition they should
be the same.

(content) Do you really need all of the above options to observe the
breakage, or can you drop --graph?  If so, drop it from the proposed
commit log message, as it is distracting without merit.

(content) Do you really mean SP before %Creset, not after?

(style) Somehow I find this hard to read. Perhaps make the two "sample
commands" stand out more from the surrounding text?  E.g.

-- >8 --
The following two ought to give the same output to a terminal:

	$ git log --oneline
        $ git log --pretty=format:'%C(yellow)%h %creset%s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s". A log
messages written in an encoding i18n.commitEncoding that is not UTF-8
is shown corrupted with the latter even when i18n.logOutputEncoding is set
to convert to UTF-8.

Signed-off-by: ...
-- 8< --

(question) Does this change affect other commands, most notably
format-patch, and if so how?

> diff --git a/log-tree.c b/log-tree.c
> index e945701..39913d7 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -488,6 +488,7 @@ void show_log(struct rev_info *opt)
>  	ctx.preserve_subject = opt->preserve_subject;
>  	ctx.reflog_info = opt->reflog_info;
>  	ctx.fmt = opt->commit_format;
> +	ctx.output_encoding = get_log_output_encoding();
>  	pretty_print_commit(&ctx, commit, &msgbuf);
>  
>  	if (opt->add_signoff)
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 2ae9faa..24e787a 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -11,10 +11,12 @@ test_expect_success 'set up basic repos' '
>  	>bar &&
>  	git add foo &&
>  	test_tick &&
> -	git commit -m initial &&
> +	git config i18n.commitEncoding cp1251 &&
> +	printf "initial \320\272\320\276\320\274\320\274\320\270\321\202" | iconv -t cp1251 -f utf-8 | xargs -I{} git commit -m "{}" &&
>  	git add bar &&
>  	test_tick &&
> -	git commit -m "add bar"
> +	git commit -m "add bar" &&
> +	git config --unset i18n.commitEncoding
>  '
>  
>  test_expect_success 'alias builtin format' '
> @@ -38,6 +40,20 @@ test_expect_success 'alias user-defined format' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'alias user-defined tformat with %s (native encoding)' '
> +	git config i18n.logOutputEncoding cp1251 &&
> +	git log --oneline >expected-s &&
> +	git log --pretty="tformat:%h %s" >actual-s &&
> +	git config --unset i18n.logOutputEncoding &&
> +	test_cmp expected-s actual-s
> +'
> +
> +test_expect_success 'alias user-defined tformat with %s (utf-8 encoding)' '
> +	git log --oneline >expected-s &&
> +	git log --pretty="tformat:%h %s" >actual-s &&
> +	test_cmp expected-s actual-s
> +'
> +
>  test_expect_success 'alias user-defined tformat' '
>  	git log --pretty="tformat:%h" >expected &&
>  	git config pretty.test-alias "tformat:%h" &&
