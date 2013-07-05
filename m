From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 05 Jul 2013 11:30:11 -0700
Message-ID: <7vehbc7tcc.fsf@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-3-git-send-email-artagnon@gmail.com>
	<20130705124536.GU862789@vauxhall.crustytoothpaste.net>
	<7vobag7wl0.fsf@alter.siamese.dyndns.org>
	<20130705174730.GM9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jul 05 20:30:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvAlz-0003kS-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 20:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602Ab3GESaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 14:30:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757419Ab3GESaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 14:30:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355302C8EF;
	Fri,  5 Jul 2013 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LSGVCQxEBQ/CprtjP6z9LTqjHpw=; b=Ju9m0u
	wj5YAHVKncZofB+EEKoZB1a2hQvOncMZEaOXj1s28RpfRDr5xL0qKmWKjlyzBDMt
	EMScDUyN8tQJ0RtR38U29uVIfyAM/n/hBeAh9n5o8LH1XhoUwhJCynZbazfbjaXm
	A4pY4lcVQwhytsU1P+cJ5NsYp/m2VEPfV1sUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KCOoz5VwbAI5/JWK+9oJgLo1W8STaIjP
	pyUlgSaGK3YMhX0NxJat0MGKtOA+HjZPNO3HMuJ61B+ncTK+YmIJaW2mQaW3VYQg
	owuy0G3MldecoBdxttOf27p5RKzC418bZJD6uVjGu22iInecb6oqUpuzkt7C3yZo
	awAqTOIWq2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 211112C8EE;
	Fri,  5 Jul 2013 18:30:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 693072C8E5;
	Fri,  5 Jul 2013 18:30:13 +0000 (UTC)
In-Reply-To: <20130705174730.GM9161@serenity.lan> (John Keeping's message of
	"Fri, 5 Jul 2013 18:47:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE8ED056-E5A0-11E2-9748-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229673>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Jul 05, 2013 at 10:20:11AM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > You've covered the STARTTLS case, but not the SSL one right above it.
>> > Someone using smtps on port 465 will still see the warning.  You can
>> > pass SSL_verify_mode to Net::SMTP::SSL->new just like you pass it to
>> > start_SSL.
>> 
>> OK, will a fix-up look like this on top of 1/2 and 2/2?
>
> According to IO::Socket::SSL [1], if neither SSL_ca_file nor SSL_ca_path
> is specified then builtin defaults will be used, so I wonder if we
> should pass SSL_VERIFY_PEER regardless (possibly with a switch for
> SSL_VERIFY_NONE if people really need that).
>
> [1] http://search.cpan.org/~sullr/IO-Socket-SSL-1.951/lib/IO/Socket/SSL.pm

Interesting.  That frees us from saying "we assume /etc/ssl/cacerts
is the default location, and let the users override it".

To help those "I do not want verification because I know my server
does not present valid certificate, I know my server is internal and
trustable, and I do not bother to fix it" people, we can let them
specify an empty string (or any non-directory) as the CACertPath,
and structure the code like so?

        if (defined $smtp_ssl_cert_path && -d $smtp_ssl_cert_path) {
                return (SSL_verify_mode => SSL_VERIFY_PEER,
                        SSL_ca_path => $smtp_ssl_cert_path);
        } elsif (defined $smtp_ssl_cert_path) {
                return (SSL_verify_mode => SSL_VERIFY_NONE);
        } else {
                return (SSL_verify_mode => SSL_VERIFY_PEER);
        }
