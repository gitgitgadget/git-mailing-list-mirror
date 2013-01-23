From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Wed, 23 Jan 2013 12:36:49 -0800
Message-ID: <7v622nhc0u.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
 <CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com>
 <20130123194757.GQ7498@serenity.lan>
 <CAGdFq_jZDUxg7oTL7Z4v5ezYFPfJ8kZR6iHpESw6WnoDCeAy8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty74h-0004fT-8c
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab3AWUhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:37:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532Ab3AWUgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:36:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8729B4A3;
	Wed, 23 Jan 2013 15:36:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hV59TQgcEw8583eQ/qsyFwVi4Z4=; b=XQ46Ee
	Sc/Sg8TxUwFbgkhZ7i30TmLR68dba1QRuKzW4bCK0OJovF2rkiqdiLeMlHeNwXdX
	ZKXYRHnCgOXJFIUCgyfqYzJHU38MX14lnTwigevu1CPOTKOCQ46us00PqxxJ3rW4
	ZcWvDvrKUAVdcs0qtn8nwdnw57oDeGu/sfHRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=StDsLebHv6dVEnGTHIKKDY9KELlttkZH
	3X0m/dN09rV04TAo4d0H+YPIP0R0n9U+JFAZsgezJmDSiqdPQAJoutcC0ZskFpx4
	IMPDaYGV6E0dQ4CpEBv/Q9Aqp2t9tgO3EAhnWIjB5MDwyCQucPEkr1w2sshIJw8b
	TRPDSlM/xgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDEDCB4A2;
	Wed, 23 Jan 2013 15:36:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B83EB4A0; Wed, 23 Jan 2013
 15:36:53 -0500 (EST)
In-Reply-To: <CAGdFq_jZDUxg7oTL7Z4v5ezYFPfJ8kZR6iHpESw6WnoDCeAy8w@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 23 Jan 2013 12:14:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EFCDF94-659C-11E2-A95B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214359>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Jan 23, 2013 at 11:47 AM, John Keeping <john@keeping.me.uk> wrote:
>>> When did we last revisit what minimal python version we are ok with requiring?
>>
>> I was wondering if people would weigh in discussing that in response to
>> [1] but no one has commented on that part of it.  As another datapoint,
>> Brandon Casey was suggesting patching git-p4.py to support Python 2.4
>> [2].
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/213920
>> [2] http://article.gmane.org/gmane.comp.version-control.git/214048
>
> I for one would be happy to kill off support for anything older than
> 2.6 (which had it's latest release on October 1st, 2008).
>
> Junio, how have we decided in the past which version of x to support?

I do not think there was any conclusion.  $gmane/212215 claiming 2.4
support matters for RHEL 5.x users was the last on the topic as far
as I can tell, so it boils down to another question: do users on
RHEL 5.x matter?

I can read from $gmane/212215 that users of the said platform can
safely keep using Python 2.4 under their vendor support contract
until 2017.  But let's focus on what do these users expect of their
system and software they run on it a bit.

When they want to run a piece software that is not shipped with
RHEL, either by writing their own or by importing from elsewhere,
that needs 2.6 features, what are their options?

 (a) The platform vendor optionally supplies 2.6 with or without
     support;

 (b) The users can and do install 2.6 as /usr/local/bin/python2.6,
     which may even be community-supported, but the vendor does not
     support it; or

 (c) The vendor terminates the support contract for users who choose
     to go (b).

I think we can safely discard (c); if that is the case, the users on
the said platform will not choose to update Git either, so it does
not matter where the future versions of Git sets the lower bound of
Python version at.

If we are not talking about the situation (c), then the users can
choose to use 2.6, and more importantly, Python being a popular
software, I would imagine that there are reputable sources of
prepackaged RPMs for them to do so without going too much hassle of
configuring, compiling and installing.

Now how does the decision we make today for releases of Git that
haven't yet happened will affect these users?  As these versions of
newer Git were not shipped with RHEL 5.x, and also I am assuming
that Git is a more niche product than Python is, I would imagine
that it is very unlikely that the vendor gives it the users as an
optional package.  The users will have to do the same thing to be
able to use such versions of Git as whatever they do in order to use
Python 2.6.

Given that, what the vendor originally shipped and officially
supports does not affect the choices we would make today for newer
versions of Git.  The users in a shop where additional third-party
software in /usr/local/bin is strictly forbidden, they are stuck
with the version of Git that the vendor shipped anyway, because they
won't be able to install an updated Git in /usr/local/bin, either.

That is, unless installing 2.6 as /usr/local/bin/python2.6 (or if
you are really paranoid, /usr/local/only-for-git/bin/python2.6 where
nobody's $PATH points at) is impossible.

So personally I do not think dropping 2.4 is a huge problem for
future versions of Git, but I'd like to hear from those working in
IT support for large and slow-moving organizations (aka RHEL 5
customers).
