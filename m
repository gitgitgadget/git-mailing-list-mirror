From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: respect core.commentchar
Date: Mon, 11 Feb 2013 13:49:27 -0800
Message-ID: <7va9raldw8.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:50:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U51G6-0006OT-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab3BKVtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:49:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674Ab3BKVta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:49:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E59EBB0AC;
	Mon, 11 Feb 2013 16:49:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yu/lNqm6cGZYjfWuqsqEuxOJ4V8=; b=j1bL+o
	4VzNCC5Ir6ps8Jp4xBLf6d56BhOtmWxg/rk5o2EhynJ+W9ld+sBtclrqIfaYqn5U
	51Kquk6QzKQAHaCdfxHE3tO4RVNpS4IGCeDcjQMxNUNm9vawkhjAc1Kz/1lSC5wu
	gNhzUvLiR4aHx/Q02axr7gADmgqWWhjZYbQJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBIk/kUox3xunOSVrPjghjHPrv0Qr77N
	QYBNp4hUsX7aKFJJrT1PeYmrs5Z5lfB2Mq3+iMhoi6KkXmqXBkdMDkBljrG7uwou
	CNYSNcegQmiVD5scSoMUNa6E58V4U2UDPzUVTDycUvilPy16kztDmcqSG+XKELyx
	OZEuhYZfW9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0C5B0AB;
	Mon, 11 Feb 2013 16:49:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D4C4B0A7; Mon, 11 Feb 2013
 16:49:29 -0500 (EST)
In-Reply-To: <20130211213900.GE2270@serenity.lan> (John Keeping's message of
 "Mon, 11 Feb 2013 21:39:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E969F588-7494-11E2-A9A1-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216096>

John Keeping <john@keeping.me.uk> writes:

>> I do not think we would want to worry about comment_char being a
>> funny character that can possibly interfere with regexp.  Can't we
>> do this with "git stripspace" piped to "wc -l" or something?
>
> I didn't know about "git stripspace",...
>> > -# If you remove a line here THAT COMMIT WILL BE LOST.
>> > +	sed -e "s/^/$comment_char /" >>"$todo" <<EOF
>> 
>> When $comment_char is slash or backslash this will break.
>> Perhaps "stripspace --comment-lines" can be used here.
>
> Not in this case - this is adding the comment char in front of each
> line.  Is there a better option than this?
>
> 	while read -r line
> 	do
> 		printf '%s %s\n' "$comment_char" "$line"
> 	done >> "$todo" <<EOF
> 	...
> 	EOF

Perhaps

	git stripspace --comment-lines <<EOF
        ...
        EOF

is a better option that that loop.
