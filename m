From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix checkout of large files to network shares under Windows
 XP
Date: Sat, 16 Oct 2010 19:23:10 +0200
Message-ID: <4CB9DF7E.1020203@lsrfire.ath.cx>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx> <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com> <4BCE134C.8090802@lsrfire.ath.cx> <4BD9E58E.8020406@lsrfire.ath.cx> <290b11b5-5dd5-4b83-a6f5-217797ebd5af@t8g2000yqk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	dvornik+git@gmail.com
To: Chad Warner <chad.warner@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 19:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ATr-0004mH-OK
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 19:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab0JPRXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 13:23:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:52225 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab0JPRXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 13:23:33 -0400
Received: from [10.0.1.103] (p4FC57B50.dip.t-dialin.net [79.197.123.80])
	by india601.server4you.de (Postfix) with ESMTPSA id 684A22F80C8;
	Sat, 16 Oct 2010 19:23:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <290b11b5-5dd5-4b83-a6f5-217797ebd5af@t8g2000yqk.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159168>

Hi,

I've cc:'d the mailing lists and the participants of the earlier
discussion to share your findings and to see if someone else may have a=
n
explanation for this behaviour, or a solution.

The patch in question is c8b296450e5148c576697ea4709072b7855aacd5 and
has made it into git versions 1.7.1.1 and 1.7.2 (and up).  It caps
writes at 31MB to fix a problem with network drives in certain versions
of Windows.

Am 14.10.2010 21:26, schrieb Chad Warner:
> I am experiencing issues with the patch you suggested.  I am working
> with a repository via its UNC path and it is failing on large files.
> I first tried lowing to several different values such as 4MB and stil=
l
> had problems.  I eventually got it to work with the following:
>=20
> return write(fd, buf, min(count, 1024 * 27));
>=20
> I didn't notice any real delays with having to call write that many
> more times.  However, I really don't know how to go about fixing this
> issue or validating that this really fixes the problem.

Reducing the write cap to 27KB unconditionally sounds pretty drastic to
me; it could hurt the local case.  I didn't measure it, though, so I
might be wrong.  Depending on that measurement we perhaps need to find =
a
different solution.

Also, 27KB is an odd number.  I take it that 28KB won't fix the issue
for you?

I wonder about the cause of this threshold.  Wild guess: network driver
bug or other network issue?

Which version of Windows do you use on the client?  Which OS runs on th=
e
server?  Do you have any other information that might help in
reproducing the problem?

Thanks,
Ren=E9
