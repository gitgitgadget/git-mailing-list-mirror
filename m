From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] index-pack: Disable threading on cygwin
Date: Tue, 26 Jun 2012 15:37:24 -0700
Message-ID: <7v62adaee3.fsf@alter.siamese.dyndns.org>
References: <4FE9FD34.5020406@ramsay1.demon.co.uk>
 <7vk3ytc0es.fsf@alter.siamese.dyndns.org>
 <CABPQNSZ7=kqSjXPLior+LXqAt4AzcybOjJ1P8ZLQ+J-9gCgvdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 27 00:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjeO8-00062t-5k
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab2FZWhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:37:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab2FZWhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:37:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3007862C;
	Tue, 26 Jun 2012 18:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DQk+7m9iDzhB/dXRSUz2wCPE29A=; b=YhaoFd
	RcW5DMEwz0p3s1SjLt5JwHNzBUzsSKwW395Y+0pFkxOCCPQClyRCtqA4jxNesloa
	xkTruh8Lgd8F3sJVXmvKSQPV1uGirwzxGC0l5JXmZZnh/SYJK0/OHXnwQaACw918
	DnSjQOt/MT8rSLKI01CVupQ8KGv9bSgyBpXHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z72173ZpQv2ts7X4bM/jOHMLYEQ0vlu9
	FbEvHgO5KQL4Low5YSQZVV4uisLSfmOY6/f2gnJIqY5m/oEIECeaLK53Kd1dr/Ot
	ja+BOlCr+UuQyTsMCCN62VPoEk1Jz/KtCmn59SieRZCy9+3ZATugsee/i22tD2aU
	++oumMS7R+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7FA6862B;
	Tue, 26 Jun 2012 18:37:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 971208629; Tue, 26 Jun 2012
 18:37:26 -0400 (EDT)
In-Reply-To: <CABPQNSZ7=kqSjXPLior+LXqAt4AzcybOjJ1P8ZLQ+J-9gCgvdw@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 26 Jun 2012 23:00:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81558C1A-BFDF-11E1-BB75-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200695>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Tue, Jun 26, 2012 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>>    - renamed FAKE_PREAD_NOT_THREAD_SAFE to NO_THREAD_SAFE_PREAD
>>
>> Sensible.
>>
>>>    - when NO_PREAD, set NO_THREAD_SAFE_PREAD in the Makefile, rather
>>>      than in git-compat-util.h
>>
>> I think it is a bad change.  When compat/ pread gets improved to be
>> thread-safe, this will surely be missed.
>
> But CAN it be fixed? I don't think it could, at least not without
> wrapping ALL calls to functions that perform IO on file handles or
> file descriptors...

Is that relevant?  It may be true that both Erik and Junio are not
being clever enough to come up with a solution offhand.  But is that
a good justification to go against a sound engineering practice?

There may be more than one platforms that want their own different
pread emulations, some safe with thread and some others not.  I
think you would prefer to see something like this:

	#if NO_PREAD
        #if on platform A
	# define NO_THREAD_SAFE_PREAD
        # define pread(fd, buf, count, ofs) git_pread_A((fd), (buf), (count), (ofs))
	#endif
        #if on platform B
        # define pread(fd, buf, count, ofs) git_pread_B((fd), (buf), (count), (ofs))
	#endif

and keep "make -DNO_PREAD" to mean "The platform does not have a
pread, please emulate" and nothing else. The implementation of the
emulation itself would be the one that knows of its thread safeness.

Having said that, I do not care too deeply either way, so the patch
is queued as-is.
