From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 10:54:12 +0200
Message-ID: <vpqljlguqtn.fsf@bauges.imag.fr>
References: <20090819082423.GA18860@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdgwC-0008Au-MM
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbZHSIyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 04:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbZHSIyX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:54:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37163 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZHSIyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 04:54:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7J8qkvV018370
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 10:52:46 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mdgvs-0003Bo-7t; Wed, 19 Aug 2009 10:54:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mdgvs-0001du-6c; Wed, 19 Aug 2009 10:54:12 +0200
In-Reply-To: <20090819082423.GA18860@atjola.homenet> (=?iso-8859-1?Q?=22Bj?=
 =?iso-8859-1?Q?=F6rn?= Steinbrink"'s message of "Wed\, 19 Aug 2009
 10\:24\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Aug 2009 10:52:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7J8qkvV018370
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251276767.08539@O5UBPZusvhBfayLCW7IwNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126520>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Hi,
>
> ls-files -t seems to always show status H, even if the file was modif=
ied
> or deleted, and thus gets shown by -m and -d respectively.

That's not exactly "always", but I don't know whether it's the desired
behavior:

/tmp/git$ git st
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   modified
#       deleted:    removed
#
no changes added to commit (use "git add" and/or "git commit -a")
/tmp/git$ git ls-files -t=20
H modified
H removed
H unmodified
/tmp/git$ git ls-files -t -m
C modified
C removed
/tmp/git$ git ls-files -t -d
R removed
$ git ls-files -t -d -m
C modified
R removed
C removed

So, you get the C and R flags only when you request explicitely -m and
-d.

I'd say this is a bug, and anyway a testcase should be added to
explicitly state what the behavior should be.

--=20
Matthieu
