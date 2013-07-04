From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 22:46:18 -0700
Message-ID: <7va9m2dgid.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
	<CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
	<CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
	<CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com>
	<51D40203.1010100@alum.mit.edu> <51D413BA.6080709@viscovery.net>
	<7vmwq3e7xy.fsf@alter.siamese.dyndns.org>
	<51D50A1E.2030904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 04 07:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UucN8-0007Wi-J3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 07:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077Ab3GDFqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 01:46:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab3GDFqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 01:46:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04A9129C46;
	Thu,  4 Jul 2013 05:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JSET/M5dU+/aZ1EGbKJPsibppmA=; b=yE+WOV
	toVwhXUKrPd2zoXt5RDIxorWDxRsI4FDlX3S4W3S9HZWU3Dg6z87U9Gl4u2B7qTk
	XLglK4W5C5G2EOtLaEsHaMCo4xJZNxkjdroTM4t+r037Js4C6JZ3nRxqGFre8Mp2
	1TZrjBJbR1F3gi5j8Ir+BHRnQ5gE9RPZBbT6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XAbbD3ohvIKsXO20+J2PQqXRynwOgUQd
	/4MgrAxjJUb0OSzn8WpQCjdrxxlBYMOj5bb3aZOd+ECaP4OZF2VeMuwLZ+gO4ZWY
	tsNAiQ5LDnx8q+5yMLt2bKsa83SiYN4Biap58J1u3GI2Ke7bTluMECaMNkJdF4v2
	EI8ADY+vHDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE4829C45;
	Thu,  4 Jul 2013 05:46:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6224D29C43;
	Thu,  4 Jul 2013 05:46:19 +0000 (UTC)
In-Reply-To: <51D50A1E.2030904@viscovery.net> (Johannes Sixt's message of
	"Thu, 04 Jul 2013 07:37:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CFB5E18-E46D-11E2-822E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229555>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/3/2013 21:53, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> I don't think that is necessary. We already have *two* options to
>>> force-push a ref: the + in front of refspec, and --force.
>> 
>> They mean exactly the same thing; the only difference being that "+"
>> prefix is per target ref, while "--force" covers everything, acting
>> as a mere short-hand to add "+" to everything you push.
>
> I know, and I'm saying that we do not have to keep this duplicity.

Of course we do.  If you change + prefix to "push but always require
tracking ref in the opposite direction", you will break existing
setup by (1) making it impossible to loosen the restriction per ref,
and (2) forcing people to have reverse tracking ref.

It is OK to introduce another prefix that mean a new thing.  It is
absolutely not OK to change the semantics of only one and not the
other.
