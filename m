From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Tue, 15 Apr 2014 09:45:18 -0700
Message-ID: <xmqqeh0ylext.fsf@gitster.dls.corp.google.com>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
	<534985F3.6060501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 15 18:45:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa6UI-000430-9e
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 18:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbaDOQpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 12:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbaDOQpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 12:45:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5B5D7A6A6;
	Tue, 15 Apr 2014 12:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hoq0XtIXNmahwktRSRHWx8GSs3c=; b=trTxbp
	qulWYK6zxt2qVIn/0qVyj/PWFUOlHOEYgLYP3IHlVVpREk7AZBJdKJueML5bBfDQ
	513CnkzRWJClxo3POV1r6bLvwrXkBuwRsEVbWgz2jdoXsFKBwgLWeS1MkYTehfcf
	elcnWSspqQ/4qseBcBUu/7OU98jTz4NrrTRH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHrS/LQr+gg1N+ufxIBNAnBlQTio8AY8
	1ILN7yL34TR07mo/1s9BiIHwBHxmRga88ZvNYrm0U2O4OVKNT0FMJMkQwDAbC53u
	t4YTiRp/dnScYQikWIqbpVX2eJY2jsqKEJERYsTuVMNtZziqe7Dsq/odxoz4cM2G
	p+4DJ1N9oh4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E3107A6A4;
	Tue, 15 Apr 2014 12:45:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E15B7A6A1;
	Tue, 15 Apr 2014 12:45:20 -0400 (EDT)
In-Reply-To: <534985F3.6060501@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 12 Apr 2014 19:29:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 54D20E4A-C4BD-11E3-B6C8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246290>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 11/04/14 23:22, Junio C Hamano wrote:
> [...]
>> [New Topics]
>> 
>> * nd/index-pack-one-fd-per-thread (2014-04-09) 1 commit
>>  - index-pack: work around thread-unsafe pread()
>> 
>>  Enable threaded index-pack on platforms without thread-unsafe
>>  pread() emulation.
>> 
>>  Will merge to 'next' and keep it there for the remainder of the cycle.
>
> The commit message for commit 512ebe5d ("index-pack: work around
> thread-unsafe pread()", 25-03-2014) is a little misleading.

OK.  Can we have a concrete alternative?

    Multi-threaing of index-pack was disabled with c0f8654
    (index-pack: Disable threading on cygwin - 2012-06-26), because
    pread() implementations for Cygwin and MSYS were not thread
    safe.  Recent Cygwin does offer usable pread() and we enabled
    multi-threading with 103d530f (Cygwin 1.7 has thread-safe pread,
    2013-07-19).

    Work around this problem on platforms with a thread-unsafe
    pread() emulation by opening one file handle per thread; it
    would prevent parallel pread() on different file handles from
    stepping on each other.

    Also remove NO_THREAD_SAFE_PREAD that was introduced in c0f8654
    because it's no longer used anywhere.

    This workaround is unconditional, even for platforms with
    thread-safe pread() because the overhead is small (a couple file
    handles more) and not worth fragmenting the code.
