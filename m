From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 08:23:44 -0700
Message-ID: <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
References: <nhlqd4$ekr$1@ger.gmane.org>
	<c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
	<c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
	<ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 20 17:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3mHI-0000eu-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 17:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbcETPXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 11:23:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755675AbcETPXs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 11:23:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A4F3116E89;
	Fri, 20 May 2016 11:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KlsRvh+zadMH
	hcNt9z40WDv/sc0=; b=KavHRh5N4fDUuSzVnwpZr5qpooBQgJg3s8pS96Yt8fQw
	uQMYO5C/AX3LmT/wm2Jan5bqLLqLdR/snyZojjdhXRlzdeW/3r3Li8qMiAtvXRrB
	+ww4fK9XnqFB6ffbqvxiISxlKE1WXd+u8/U4RtA4G6/13Ruyz2Kirxc9ex91c04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ABe3Iy
	J8DhcW+0Iuvc+II6kGr3GjqIBQkJ4flp4pstqnR4WfR2f85EHWXJdchxLHiD6VAb
	7AuQJkIHw6stVNHtZjaNro0qrfVA85/xixjy4XnZX60J+BmSiA5Ia1Uz5w92++YX
	5zBJwhpjkGhMxNCiGfvZpYKQm9IlPgEiv7r6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 840B816E88;
	Fri, 20 May 2016 11:23:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB9D216E87;
	Fri, 20 May 2016 11:23:45 -0400 (EDT)
In-Reply-To: <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 20 May 2016 16:19:25
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D803918E-1E9E-11E6-8740-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295175>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>> What does
>>> git diff
>>> say ?
>>=20
>> Great question. For all the unexpected files it says the
>> same thing:
>>=20
>> old mode 100755
>> new mode 100644
>
> So the solution is to run
> git config  core.filemode false

Thanks for asking a great question.  I somehow expected that we
probe in init-db.c::create_default_files() for this when we probe
for case sensitivity, symlinks, etc., but apparently we don't.

I guess we don't because on some filesystems we can't.  IIRC, it
goes something like: chmod immediately followed by lstat pretends
that change to the executable bit stuck, until the in-core buffer at
the vfs layer is flushed to the disk platter that holds the
filesystem without any notion of executable bit.
