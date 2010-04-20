From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix checkout of large files to network shares under 
 Windows XP
Date: Tue, 20 Apr 2010 14:57:00 +0200
Message-ID: <4BCDA49C.4090405@viscovery.net>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx> <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 14:57:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4D0s-0002j8-Am
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 14:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab0DTM5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 08:57:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36782 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab0DTM5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 08:57:07 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O4D0e-00062o-QZ; Tue, 20 Apr 2010 14:57:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7F6E21660F;
	Tue, 20 Apr 2010 14:57:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145372>

Am 4/20/2010 14:42, schrieb Sebastian Schuberth:
> On Mon, Apr 19, 2010 at 22:43, Ren=C3=A9 Scharfe <rene.scharfe@lsrfir=
e.ath.cx> wrote:
>> Shouldn't the loop be left in the successful case, too?  write(2) is
>> allowed to write less than requested, so the caller already needs to
>> deal with that case anyway.
>=20
> I prefer to make the wrapper as transparent as possible. If a direct
> call to write would not write less than requested, the wrapper should
> not either.

Sure, but Ren=C3=A9 meant the opposite case: When fewer bytes than requ=
ested
were written, then you shouldn't retry to write more! That is, you shou=
ld
exit the loop when write(fd, buf, n) does not return n.

I still find your code unnecessarily hard to read. In particular, you
should extract the non-problematic case out of the loop. If you followe=
d
my suggestion elsewhere in the thread, you wouldn't have to write any
conditionals that 'break' out of a loop.

-- Hannes
