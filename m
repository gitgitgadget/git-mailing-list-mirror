From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date  with -f
Date: Thu, 12 Feb 2009 23:15:10 -0800
Message-ID: <7v1vu2g64h.fsf@gitster.siamese.dyndns.org>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
 <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
 <7vhc2zglz4.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902122202r25e2e320m19810097cbb54225@mail.gmail.com>
 <7vd4dmg8k1.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902122251j24696806xb89de3e338d49cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXsI4-000150-4o
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbZBMHPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2009 02:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZBMHPU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:15:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZBMHPS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2009 02:15:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F04E2B074;
	Fri, 13 Feb 2009 02:15:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 59DB42B06F; Fri,
 13 Feb 2009 02:15:12 -0500 (EST)
In-Reply-To: <bd6139dc0902122251j24696806xb89de3e338d49cb@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri, 13 Feb 2009 07:51:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10CDEEA2-F99E-11DD-B3CF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109717>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Feb 13, 2009 at 07:22, Junio C Hamano <gitster@pobox.com> wro=
te:
> ...
>> One more thing. =C2=A0I kept saying "detect --whitespace=3Dfix (or i=
ts synonym
>> strip)" because people can have "apply.whitespace =3D fix" in their
>> configuration file for use with "git am", and countermand the
>> configuration with "git rebase --whitespace=3Dwarn". =C2=A0Such a us=
age should
>> not imply --force.
>
> Ok, so having 'apply.whitespace =3D fix' in your config _should_ impl=
y
> -f, and '--whitespace=3D[no]warn' as commandline option should not
> affect '-f'.

Well, that is actually not quite what I meant.

The intention of the user who runs "git rebase" without an explicit opt=
ion
(-f nor --whitespace) with such a config is ambiguous.

But "git rebase --whitespace=3Dfix" *is* unambiguously "I'd like to fix=
 it",
with or without a config.  It should imply --force.

Similarly "git rebase --whitespace=3Dwarn" *is* unambiguously "I do not=
 want
the rebasing process to touch it, just warn, if necessary".  It should =
not
imply --force.

So I think it would be the most natural to look only at command line
option --whitespace=3D*, and make fix/strip imply --force, without look=
ing
at config.
