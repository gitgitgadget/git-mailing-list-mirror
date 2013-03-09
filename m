From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ignore pattern with trailing whitespace in .gitignore is void
 using git 1.8.1.5
Date: Fri, 08 Mar 2013 22:28:22 -0800
Message-ID: <7va9qdf5o9.fsf@alter.siamese.dyndns.org>
References: <CAMn8hCd6_V2Kq_OUgBFAoOkqqmrTpN_ohcP3wM44qWvQB_8R5g@mail.gmail.com>
 <CAMn8hCexsiizsjoXO-ebfpEtZcW7n0dY-jV0q+aLh8U+pbUo9A@mail.gmail.com>
 <7vehfpf8kk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thor Andreas Rognan <thor.rognan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 07:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEDHA-0008Uq-SV
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 07:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab3CIG20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 01:28:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab3CIG2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 01:28:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFE429650;
	Sat,  9 Mar 2013 01:28:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kL6UW9paX+vcTuDvUbRFSnyUrV4=; b=AT0l3T
	K7in46+/ommrdytFy7k9yJelH8ifx7kSMUOE1FhRuJ/MJInjsetT6B57C5K+P28a
	f/l6Sd/IHqSCcVt1WBRISonrVyND5nkFljufOfxywU0gGApSNh8+uHJxwEF5OPop
	6QUktcx/m5y5hIK1/k2Y1e4LSd8S1Lpu4T8II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVy7rT6TNJZRCyVaXcePd1Bpn7m5VI16
	OlZqszgmYQDqc0oW13XslDw/18Ez1uKKjJR6SfXyUOyAxXMZT97cpKLMdOIBRjec
	sRm6twPfmPe3s4KtkxVKOkMcv0uumSXvt4+kSzC30t75ng2WInBIChIEnvPkEoLI
	oL2+G0IL64M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6058964F;
	Sat,  9 Mar 2013 01:28:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C9E2964E; Sat,  9 Mar 2013
 01:28:24 -0500 (EST)
In-Reply-To: <7vehfpf8kk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Mar 2013 21:25:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B9B3974-8882-11E2-A50A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217703>

Junio C Hamano <gitster@pobox.com> writes:

> Thor Andreas Rognan <thor.rognan@gmail.com> writes:
>
>> Maybe I'm doing it wrong, or maybe it's the intended behaviour,
>> but I find that a trailing whitespace after a pattern in .gitignore
>> makes the pattern void with git 1.8.1.5.
>
> I doubt we do anything clever like that.
> ...
> The user tells to ignore anything followed by a dot followed by a
> lowercase Oh followed by a SP.  We ignore "hello. ", but not "hello.o"
> nor "hello.o  " (two SPs at the end), just as told.

Of course, having said all that, I do not think anybody objects too
deeply against a patch that change the behaviour to ignore trailing
whitespaces, as long as the patch leaves an escape hatch to allow
people who do want to specify a pattern that matches with pathnames
with trailing whitespaces.  Without thinking it through, perhaps

	echo '*.o\ ' >.gitignore

or something?

Technically speaking, such a change is a regression, but I doubt
that many people would mind it too much.
