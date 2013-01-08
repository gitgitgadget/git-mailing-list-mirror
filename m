From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] t1402: work around shell quoting issue on NetBSD
Date: Tue, 08 Jan 2013 22:13:11 +0100
Message-ID: <50EC8BE7.2010508@lsrfire.ath.cx>
References: <50EC8025.8000707@lsrfire.ath.cx> <7vr4lvcstt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 22:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsgUS-0003fz-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 22:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab3AHVNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 16:13:17 -0500
Received: from india601.server4you.de ([85.25.151.105]:37221 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab3AHVNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 16:13:15 -0500
Received: from [192.168.2.105] (p4FFDA953.dip.t-dialin.net [79.253.169.83])
	by india601.server4you.de (Postfix) with ESMTPSA id EB128B4;
	Tue,  8 Jan 2013 22:13:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vr4lvcstt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213005>

Am 08.01.2013 21:39, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> 	# on NetBSD with /bin/sh
>> 	$ a() { echo $#-$1-$2; }
>> 	$ t=3D"x"; a "${t:+$t}"
>> 	1-x-
>> 	$ t=3D"x y"; a "${t:+$t}"
>> 	2-x-y
>> 	$ t=3D"x y"; a "${t:+x y}"
>> 	1-x y-
>>
>> 	# and with bash
>> 	$ t=3D"x y"; a "${t:+$t}"
>> 	1-x y-
>> 	$ t=3D"x y"; a "${t:+x y}"
>> 	1-x y-
>>
>> This may be a bug in the shell, but here's a simple workaround: Cons=
truct
>> the description string first and store it in a variable, and then us=
e
>> that to call test_expect_success().
>
> Interesting.  I notice that t0008 added recently to 'pu' has the
> same construct.

A quick check shows that subtests 64-68 and 89-93 of t0008 fail for me=20
on Debian (10 in total) and subtests 64 and 89 fail on NetBSD (2 in=20
total).  Unlike t1402 they don't report "bug in the test script".

t0008 only uses ${:+} substitution on variables that don't contain=20
spaces.  With the test changed to store the description in a variable=20
first I still get the same 2 failures.

There must be something else going on here.  The different results are=20
interesting, especially the higher number of failures on Debian.

Ren=C3=A9
