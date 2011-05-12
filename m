From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Exit code of git-ls-remote
Date: Thu, 12 May 2011 09:41:42 -0700
Message-ID: <7vk4dvdg6x.fsf@alter.siamese.dyndns.org>
References: <20110512120536.GA22033@camk.edu.pl>
 <7voc37dh4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:41:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKYxY-000103-9o
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023Ab1ELQlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:41:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003Ab1ELQlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:41:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 928F94CCB;
	Thu, 12 May 2011 12:43:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAeilhRvtOF7nhG5zyHoqX1eEww=; b=L2rYZ7
	vPB68PNpPY2iqMYP4hl+uT1lLR3eUimEm4VfvBGllqCLqF5eqKXX/0H3q/h+jHIu
	tQvh5nNLEzS0WtHfPReLIiQQhI1iX8XknDFEWU6cmbLUYD/vQP9BRAmhmd5GAR6N
	cvVIJGLIJn61difz6RUc1rwtcQYNlAdX+UI/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tK+FC7fprqiYHkvLwwpUX6kfMY6XGocD
	VCsXnrSxpOM5RnNaLvKtUQmCNsPjjwTcfHNlBKBIWOZmik4HOygZ5yxQQPO0Yo6Z
	55Pe6VcraUvyLTG4veJOyPf6nxb+f0pJsTOit6OXZ0tNHe1cMX9P2GINbx9mF2Om
	+x0qrg7zUY0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 713C84CC9;
	Thu, 12 May 2011 12:43:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 522984CC8; Thu, 12 May 2011
 12:43:49 -0400 (EDT)
In-Reply-To: <7voc37dh4l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 12 May 2011 09:21:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05799684-7CB7-11E0-88EA-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173482>

Junio C Hamano <gitster@pobox.com> writes:

> Kacper Kornet <draenog@pld-linux.org> writes:
>
>> git-ls-remote behaves differently then git-show-ref when it cannot find
>> any matching refs. While the latter returns non zero exit code in this
>> case, the former always returns 0. Is there any specific reason for this
>> behaviour?
>
> There is no specific reason other than "they happened to be implemented
> like so".  These commands have always behaved that way and people are
> relying on their exit status, so unless there is a compelling reason, they
> will not change.
>
> It is just a matter of opinion to consider that it is an error condition
> or just a normal case to see an empty set for a "List 'em and filter with
> these criteria" request. Outside git, "find /there -name no-such-file"
> exits with zero status, while "grep no-such-pattern file" exits with
> non-zero status.
>
> You can rely on your knowledge of the commands and write your tests like
> this:
>
> 	test $(git ls-remote $there $pattern | wc -l) != 0 || die "none"
> 	git show-ref -q $pattern || die "none"
>
> Alternatively, you can defend yourself against the next person who asks
> the same question by writing the last one as:
>
> 	test $(git show-ref $pattern | wc -l) != 0 || die "none"
>
> Either would work.

Having said all that, I would not oppose if you want to teach ls-remote an
option, e.g. --exit-code, to tell it to indicate if it found any ref with
its exit status. You need to be careful when picking what code to use so
that the caller can tell if the error was because there was no network
connection or there was nothing to be listed, though.
