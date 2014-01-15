From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Wed, 15 Jan 2014 13:30:27 -0800
Message-ID: <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
	<xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com>
	<7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Igor Gnatenko <i.gnatenko.brain@gmail.com>, git@vger.kernel.org
To: Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 22:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Y2p-0008AG-1V
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 22:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbaAOVaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 16:30:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaAOVad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 16:30:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A983963A92;
	Wed, 15 Jan 2014 16:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hJYcT1Qbdu1U0XEcXvBHrtxZb4o=; b=icyf2O
	FrPzEzuD4TCCD0E992N18NgZUMNLmRwQclp5aZCP+1Bac4+/2DddssOf6dvG1wZi
	nQIHEEfwqIOOlvEqWNnKf6wZOCyvpED9U4i7OoaAdC5HKt3FVm1bE27s1gJbGlyD
	yXoUqRA2z5GqZLuw9eJKX7yhEWoT0FuWzXC2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QU4T89Hy5dMhPQzi6f9BdhY7IwsB4qcj
	B6WYYhiMT6DGm5y6KBZovf4I9k6rfEIdkmGrQqLORYs3aK/A9bOSYZlIBy22xsFJ
	76CDRE0ZQlWOwmuX7ev/db1qLR/39euNSSSjoUvojQ58z5asxpQbkogNJW/8mgVG
	2trXsMV/W2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B5D63A90;
	Wed, 15 Jan 2014 16:30:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2AD63A8E;
	Wed, 15 Jan 2014 16:30:30 -0500 (EST)
In-Reply-To: <7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com> (Ruben
	Kerkhof's message of "Wed, 15 Jan 2014 21:58:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42370F2E-7E2C-11E3-908F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240479>

Ruben Kerkhof <ruben@rubenkerkhof.com> writes:

>> ... because?  Is it because the cert_path on your platform is
>> different from /etc/ssl/certs?  What platform was this anyway?
>
> This is Fedora rawhide, git-1.8.5.2-1.fc21.x86_64, perl-IO-Socket-SSL-1.962-1.fc21.noarch
>> 
>> I see in the original discussion in your bugzilla entry that
>> "/etc/ssl/certs/" _is_ your ssl cert directory, but I wonder why
>> then this part of the existing codepath does not work for you:
>
> Actually, it's not a directory but a symlink to a directory:
>
> [ruben@vm ~]$ ls -l /etc/ssl/certs
> lrwxrwxrwx. 1 root root 16 Jan 11 12:04 /etc/ssl/certs -> ../pki/tls/certs
>
> Just to rule that out I set smtpsslcertpath = /etc/pki/tls/certs,
> but that doesn't work either.

Yeah, I suspect as much, as "-d" test would dereference symlinks and
would see /etc/ssl/certs is a symlink pointing at a directory.

> ...  I posted the patch to Fedora's bugzilla, since this was
> biting me on Fedora, and Igor took the liberty to forward it.  Not
> that I mind of course, but please don't take this patch as a
> proper fix. I don't pretend to fully understand the code and the
> implications, much less the impact on other platforms.

That is fine, and thanks for starting discussion for a proper fix
(the "thanks" go to both of you).

>> Also, if the above observation is correct, i.e. we are calling
>> IO::Socket::SSL with SSL_ca_path set to a correct directory but
>> somehow your platform is misbehaving and not detecting it as a
>> proper SSL_ca_path, then it could be argued that the code before
>> this patch catered people on platforms with one class of breakage,
>> namely "IO::Socket::SSL does not work with default configuration
>> without SSL_ca_file nor SSL_ca_path", and the code with this patch
>> caters people on platforms with another class of breakage, namely
>> "IO::Socket::SSL does not work when told with SSL_ca_path where the
>> certificate directory is" (or it could be "/etc/ssl/certs is a
>> directory that ought to be usable as SSL_ca_path, but it lacks
>> necessary hash symlinks").  Sort of like robbing Peter to pay Paul,
>> which is not very nice in principle.
>
> I suspect that's exactly the case,...

Actually, there is another possibility.  Perhaps on your system,
even though the current code thinks /etc/ssl/certs/ is usable as
SSL_ca_path, the directory is not meant to be usable as such, and
the default OpenSSL uses the equivalent of SSL_ca_file and uses the
single certificate bundle file without consulting other stuff in the
directory.

And that is not a broken installation at all, which is sort of
consistent with your observation here: 

> ...
> As a last check, I set smtpsslcertpath = /etc/pki/tls/cert.pem in
> ~/.gitconfig and git-send-email works fine now.

Which would mean that the existing code, by blindly defaulting to
/etc/ssl/certs/ and misdiagnosing that the directory is meant to be
used as SSL_ca_path, breaks a set-up that otherwise _should_ work.

I see that the original change that introduced the defaulting to
/etc/ssl/certs/, which is 35035bbf (send-email: be explicit with SSL
certificate verification, 2013-07-18), primarily wanted to avoid
letting Net::SMTP::SSL defaulting to no verification and causing it
to emit warnings of the use of the insecure default.  And I think
the same outcome will result with your patch.  By default, we still
insist on using SSL_VERIFY_PEER(), not SSL_VERIFY_NONE(), which
would avoid defaulting to insecure communication and triggering the
warning.  The way to disable the security by setting ssl_cert_path
to an empty string is unchanged.

Ram (who did 35035bbf), with the patch from Ruben in the thread, do
you get either the warning or SSL failure?  Conceptually, the
resulting code is much better, I think, without blindly defaulting
/etc/ssl/certs and instead of relying on the underlying platform
just working out of the box with its own default, and I would be
happy if we can apply the change without regression to existing
users.
