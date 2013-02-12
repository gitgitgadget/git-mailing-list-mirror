From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 09:29:26 -0800
Message-ID: <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
 <20130212095340.GG2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Jg1-00033R-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 18:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933369Ab3BLR3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 12:29:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348Ab3BLR33 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 12:29:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14BF7CC06;
	Tue, 12 Feb 2013 12:29:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bj5eLrXqKukULVmb5HaSVOYgM6c=; b=aJQEhT
	xkot1ro6l9H2lRLy+45ojAUcpro9CJylOqDjXcQWo/zYly7LxQ6by2zNPTIhC1Lp
	YemRKy4wPm61yFHbI/CfBx80GIZG/QoUsTPP649wKsBxgJfJXvLGvHlsEGhe01xb
	KaAS3GONqy68035YuU+YSJSLOYEDbOQBsWCk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQBNTxN/RrkNKu718e+EHDZOYC71TN9q
	JJ7E4+mg9lZgIekK9ewwSHbJRZ2v4bo6388ZQE9bKIaaBBnGiQBIcw/28W/SIO6M
	0BO+mD80BaIn3Lu+6PfHJjqTvG+rgXbmQkvdF+RD4g4aTgjFfiglB7t7dWE3p6T5
	zNp2Gy4mFQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07735CC04;
	Tue, 12 Feb 2013 12:29:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FEB2CC02; Tue, 12 Feb 2013
 12:29:28 -0500 (EST)
In-Reply-To: <20130212095340.GG2270@serenity.lan> (John Keeping's message of
 "Tue, 12 Feb 2013 09:53:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0DFAC8E-7539-11E2-894B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216164>

John Keeping <john@keeping.me.uk> writes:

> ... the following fixup is also needed to avoid relying on the shell
> emitting a literal backslash when a backslash isn't followed by a known
> escape character.
>
> -- >8 --
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index cbe36bf..84bd525 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -947,7 +947,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	test_when_finished "git config --unset core.commentchar" &&
>  	cat >comment-lines.sh <<EOF &&
>  #!$SHELL_PATH
> -sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
> +sed -e "2,\$ s/^/\\\\\\\\/" "\$1" >"\$1".tmp
>  mv "\$1".tmp "\$1"
>  EOF
>  	chmod a+x comment-lines.sh &&

Yeek.  If you used write_script with here-text that does not
interpolate,

	write_script remove-all-but-the-first.sh <<\EOF
	sed -e '2,$s/^/\\/'  <"$1" >"$1.tmp" &&
        mv "$1.tmp" "$1"
	EOF

the above would be much more readable.

I am not sure if I understand what you meant by "literal backslash
blah blah", though.
