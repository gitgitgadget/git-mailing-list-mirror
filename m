From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Tue, 30 Mar 2010 16:14:49 -0700
Message-ID: <7vd3yls8pi.fsf@alter.siamese.dyndns.org>
References: <hoscv7$hmn$1@dough.gmane.org>
 <7vy6h9vhuk.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com>
 <7vr5n1v74x.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1003301517r29aed329j4a5f38fbc9b515ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:15:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkeM-0002Ca-7h
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417Ab0C3XPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 19:15:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab0C3XO6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 19:14:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13BC5A6B78;
	Tue, 30 Mar 2010 19:14:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y7TPZijjsEXp
	q8dTTLqiRgitrJA=; b=bXffNCP1E6i9MzqhrE0XujmDG6CEVk/wweDUmSscvYwv
	VhE1yYKOMo6kqp3ef7WG4k5MVTcEVNroT/fIFVrr4mtuPkUqufkrdk2jWYID2zwP
	8q4HCKW1P9Xzjv5p8fXOE8mQiZzSLJ5n6bgzUGG6Sjglup3ZLPU6WkPD/0aM2eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wp/eFM
	KTwUb2w823ILfvCBDHALdy8Te+CMPrShAW/g8o5EPVciU4K/TKSOlJpPi++ISLp2
	JAhzyo+agThUc7982S2Tcdeqop5bE1YhqPXt1/ilnCWmdimiDTeXM7OVMVruND8n
	xhcly/OwtKEYc/jXO8dRENRlakL0XtuspakcE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC1B0A6B76;
	Tue, 30 Mar 2010 19:14:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC815A6B75; Tue, 30 Mar
 2010 19:14:51 -0400 (EDT)
In-Reply-To: <cb7bb73a1003301517r29aed329j4a5f38fbc9b515ca@mail.gmail.com>
 (Giuseppe Bilotta's message of "Wed\, 31 Mar 2010 00\:17\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D93519E-3C52-11DF-BDDE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143622>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> (-s likely has a single character, -S more than one. -S is likely to
> have * or ?, -s not.)

The value given to -S can just be 'tests', or even "\.", as the regexp
match is not anchored on either side:

		if ($opt_S && $fn =3D~ m/$opt_S/) {
		    print "SKIPPING $fn v $rev\n";
		    ...

And "-s" would likely be one or more (but not too many) non-alphanumeri=
c
characters.

But a bigger question is if you can bet on that heuristics, and when th=
e
heuristics does not work, what you would do.

>> A bigger reason is that, if you have _any_ combination that you cann=
ot
>> reliably guess, you would either need the user to ask for help, or y=
ou
>> need to convert by reading the configuration file case-sensitively
>> yourself to come up with a reliable conversion. =C2=A0I opted for th=
e latter.
>
> Would such a configuration work at all?

What configuration?
