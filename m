From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH] t1503: Fix arithmetic expansion syntax error when
 using dash
Date: Sat, 25 Sep 2010 10:58:23 -0700
Message-ID: <7vbp7logcg.fsf@alter.siamese.dyndns.org>
References: <4C98EF25.4070700@ramsay1.demon.co.uk>
 <7viq1xsi7a.fsf@alter.siamese.dyndns.org>
 <4C9E2CA6.2070805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, jon.seymour@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Sep 25 19:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzZ1B-00046u-Jt
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 19:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab0IYR6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 13:58:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0IYR6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 13:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE293D9ED7;
	Sat, 25 Sep 2010 13:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j633kQZE0yjUYVzduTyNHdKrxds=; b=cWaB7W
	lDjBV5gftHFALJelWi91FETZwKC4E2/gulcXZCovoFIsU2J9+Q8IlFPxgSploVKH
	s8A5798GTemJhZtEytQLzcdQfOR4sq2LHpFdmmXDsAFvTm2V5jX0GPqX5EPSIMfe
	CJeskDRSts2YdW0PyKwCgBKUYj0NyQZtfbEuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KU/k356o4hZIKpl6wA3Km3sqF68WsR5h
	jUys0zsFE3PgcYPMaoV/+XxUooyEfTWIgLOqIo9UPletO55j/p68lylyS5VaCIg6
	fUy2xT/uNCyizQJ5l2GArMRq2Xmd7mdt0CjuNmVPN96uEuOxIx2uYYj6Jpz0MBqa
	PuVLpIQLX+w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3848D9ED6;
	Sat, 25 Sep 2010 13:58:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1B3DD9ED5; Sat, 25 Sep
 2010 13:58:24 -0400 (EDT)
In-Reply-To: <4C9E2CA6.2070805@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat\, 25 Sep 2010 18\:08\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 805D2408-C8CE-11DF-B04B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157172>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
>> POSIX wants shells to support both "N" and "$N" and requires them to yield
>> the same answer to $((N)) and $(($N)), but we should aim for portability
>> in a case like this, especially when the price we pay to do so is so
>> small, i.e. a few extra dollars.
>
> Indeed
>
>> By the way, on my box, I get this:
>> 
>>     $ ls l /bin/dash
>>     -rwxr-xr-x 1 root root 104024 2008-08-26 02:36 /bin/dash*
>>     $ dpkg -l dash | grep '^ii'
>>     ii  dash              0.5.4-12          POSIX-compliant shell
>>     $ /bin/dash -c 'N=20 ; echo $(( N + 3 ))'
>>     23
>
> Ah, yes, I should have checked for this... particularly since I now
> vaguely remember reading that this had been "fixed"... *blush*
> Sorry about that.
>
> For the record, on my system I get:
>
>     $ ls -l /bin/dash
>     -rwxr-xr-x 1 root root 80500 2007-03-05 06:00 /bin/dash*
>     $ dpkg -l dash | grep '^ii'
>     ii  dash           0.5.3-5ubuntu2 The Debian Almquist Shell
>     $ /bin/dash -c 'N=20; echo $(( N + 3 ))'
>     /bin/dash: arith: syntax error: " N + 3 "
>
>> I just left it vague by saying "e.g. older dash" in below, but we may want
>> to be more precise in the documentation.
>
> I found a bug report:
>
>     http://bugs.launchpad.net/ubuntu/+source/dash/+bug/92189
>
> which had a post against it which implied that this was fixed in
> version 0.5.4-3. I went over to packages.debian.org to read the
> ChangeLog for this version, but I could not conclude anything
> from that text. :(
>
> Do we need to be more precise?
>
> Should I re-work the commit message and re-submit?

I don't think so; we now know that dash 0.5.3 or older may have this
problem and that is clear enough for our purpose.

Thanks.
