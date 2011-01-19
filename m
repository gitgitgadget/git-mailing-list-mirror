From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Per-branch receive.* settings
Date: Tue, 18 Jan 2011 16:12:27 -0800
Message-ID: <7vbp3dkaz8.fsf@alter.siamese.dyndns.org>
References: <AANLkTimt8BPKsiyVEO+7i+so8337LaUu4A4jpywvJ-Ar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 01:12:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfLfP-0007De-O8
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 01:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab1ASAMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 19:12:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1ASAMf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jan 2011 19:12:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B955353A;
	Tue, 18 Jan 2011 19:13:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZVFGBGKzP+rc
	ne0p3ML5Uy+kuVg=; b=xhcrgJdbyegZQ6Q8bBX+Nt425vfFNjfzw3AuOLAzJ0O8
	dfQcfDl8JtN6LDQqp3A+cy5K2BpWlt9cvG+oZIB9F+mMqZThJWAReVeOzfTgs+v8
	Z0/RHJ+Xr2onoIFXlDZ6ZLZExtslF2kiB2+9cuujF1Roy0n53WNmffDfh6SJBsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NFbWBi
	XibW9JNQtTYfE6+UTNjtIdqLDWdK7jg26D/mfaKEx2+JYdY/9GBgzbOXdQNdJiv6
	CK9UplIzhDtAuDoxEcZS3Hg9RUXJmOxPlIjT3AP5nAOIGf9Rc0Ttr5vl9rLVSpFL
	NSFKMnA7nqqt8Mk4r1Dv+e/Bb6z9REFWTDMeg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B1053539;
	Tue, 18 Jan 2011 19:13:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65AF63537; Tue, 18 Jan 2011
 19:13:15 -0500 (EST)
In-Reply-To: <AANLkTimt8BPKsiyVEO+7i+so8337LaUu4A4jpywvJ-Ar@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\, 19 Jan
 2011 00\:07\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EAB5471C-2360-11E0-9454-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165233>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Currently you can do in your server's git config:
>
>     [receive]
>         denyDeletes =3D true
>         denyNonFastForwards =3D true
>
> But for most servers that's not what you want, you actually want to
> deny those things to the master branch, but allow people to have thei=
r
> private topic branches that they can reset. So how about allowing:
>
>     [receive]
>         denyDeletes =3D false
>         denyNonFastForwards =3D false
>
>     [branch "master"]
>         denyDeletes =3D true
>         denyNonFastForwards =3D true

While this would not be better than having no such feature, if you are
talking about allow(ing) "people", I doubt this would scale very well.

I wonder some globbing with site-specific naming convention would be mo=
re
scalable:

	[receive]
        	denyDeletes =3D refs/heads/* && !refs/heads/*/*
                denyNonFastForwards =3D refs/heads/* && !refs/heads/*/*

And in the meantime, of course you can use your update hook, mimicking
various examples, ranging from contrib/hooks/update-paranoid,
Documentation/howto/update-hook-example.txt, and hooks/update.sample.
