From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Mon, 11 Apr 2011 09:55:52 -0700
Message-ID: <7vd3ksybfr.fsf@alter.siamese.dyndns.org>
References: <201103191528.34646.tboegi@web.de>
 <7vsjuitk59.fsf@alter.siamese.dyndns.org> <4DA144A5.2080103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 11 18:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9KPR-0002ni-3q
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 18:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab1DKQ4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 12:56:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab1DKQ4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 12:56:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79D76450E;
	Mon, 11 Apr 2011 12:58:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YWSBxAB8wR7c
	P1I3hBoh6mqT1fs=; b=mIpwmrP5Z+EF/2NXROsRlrpnT/1uO0/Sh8vhXi6EBGHq
	0SoWMSxZHCeakaX79pCn9bmkNQ/zShXVeH1pRSgDvJ2IqqNi49Pcb4BiS6V/15la
	a+yN3zUYDBaVURsffAwVr8OzosMGzQIwdqHbeUoGGDM2i/JQ3Sx6lpt1c6vQ11M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sFgetK
	ljSo1RK9gXDUEdJruXANWJXZKJlkYuDfnnk5FUejx5K7n2pEKD/IO+tUE5S0iy2w
	VIIc6Xuuv86HeizJTd1YkaEVy719/iWD2JraGjYvx7aGt6vDylkkYcjRePTvbZO1
	BzLqB4gyqn11aw3WViCCznQTqU3g4IgBZnicE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DB5E450D;
	Mon, 11 Apr 2011 12:57:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A16C450B; Mon, 11 Apr 2011
 12:57:52 -0400 (EDT)
In-Reply-To: <4DA144A5.2080103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sun, 10 Apr 2011 07:48:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D99B83D2-645C-11E0-AD0D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171336>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>When two different _names_ "A" and "a" refer to a single file, the on=
ly
>>thing that should happen for "git mv A a" is for the cache entry for =
"A"
>>to be moved to cache entry for "a", and no rename("A", "a") should be=
 run,
>>but I don't see any such change in the code. It may happen to work (o=
r be
>>a no-op) on Windows, but because builtin/mv.c is supposed to be gener=
ic
>>(and that is the reason you introduced the is_same_file() abstraction=
 in
>>the first place), I'd still see this as a breakage.
>>
> Why shouldn't the rename() be done?
> "git mv A B" changes both the indes and the file system.
> Isn't it natural to have file name  "a" both in the index and in the=20
> file system after "git mv A a"?
> Note: Windows and MAC OS X allow "mv A a" from command line,=20
> while Linux on VFAT gives an error "'A' and 'a' are the same file".

Yeah, I forgot about the primary thing we are trying to do in this
discussion.  Sorry about that.  My thinking stopped at 'if we rename "A=
"
to "a in the index, that is sufficient.  We already know that we can st=
ill
open("A") because the filesystem is case insensitive.'

In fact, we want both the index entry "A" renamed to "a" _and_ also we
want to see next "/bin/ls" to show "a", not "A".  For the latter, we do
want to run rename(2) on them.

There was another thing that made me worry about running rename(2) on t=
wo
equivalent filenames.  You said on Linux VFAT "mv A a" fails.  Does the
underlying rename(2) fail when you do this?

	status =3D rename("A", "a");

If old and new resolve to the same existing directory entry or differen=
t
directory entries for the same existing file, POSIX says that rename(ol=
d,
new) should succeed and perform no other action, so the above should
succeed on correctly implemented case insensitive filesystems.

But we know not all FS implementations are perfect.  If this can result=
 in
an unnecessary failure, it would be far better if we are careful to avo=
id
running rename("A", "a") and just rename the index entry to make sure "=
git
mv A a" succeeds, than trying to fulfil the "we want to see next '/bin/=
ls'
to show 'a' not 'A'" wish and make the whole "git mv A a" fail.

But of course we can always blame the breakage on filesystems.  I am
leaning to prefer running rename("A", "a") unconditionally.

Thanks.
