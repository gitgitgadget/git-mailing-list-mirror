From: Thomas Adam <thomas@xteddy.org>
Subject: git-cvsimport with cvsps output in commit msg breaks imports
Date: Thu, 9 Dec 2010 22:03:49 +0000
Message-ID: <20101209220347.GA3180@shuttle.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: cvsps@dm.cobite.com, smurf@smurf.noris.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 23:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoay-00038f-8U
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 23:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab0LIWEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 17:04:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48879 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0LIWEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 17:04:04 -0500
Received: by wwa36 with SMTP id 36so2980499wwa.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=gra2R9HDavdqqgJtfmp3ea6Xd3s/BpqjsEp+cj3T294=;
        b=U6np6MTEEiVrTzUifknLjnr8kkDiMoI+A8sw1PKd0rzIWZJO30Pa+lnCRCm8Iu2pZT
         z7+lNiZK4H6w42TrFmDHLNEIC9I8SPczPbCFStu+dSTxlCHuJ+Y+JVm4bThKQhEOi1Iv
         dpzwssCz7wxdZ3geeXAKMs2R1CHVVpchJPzx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=NcHUhcH8egCbDVwUJql4vjTFAgdy5ZJ4Jr2NuMLBBvBT57GvGLDA+/D4XrtEQujHvy
         QvhpvyHYOhLrRJ9cDpV2hmF3WZmZirsvmOWK/jc4azeY/lwDRE7FpVryeSXcGNKfKnTB
         zkB7G1HPfEqLHfCcf11D2M0ObtSPZo7V02uHU=
Received: by 10.216.187.133 with SMTP id y5mr2284178wem.110.1291932242114;
        Thu, 09 Dec 2010 14:04:02 -0800 (PST)
Received: from shuttle.home (188-222-193-222.zone13.bethere.co.uk [188.222.193.222])
        by mx.google.com with ESMTPS id b47sm1139473wer.38.2010.12.09.14.03.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 14:04:00 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163352>

Hi all,

[ I've Cced both the cvsps maintainer and the author listed for
git-cvsimport in case it's more relevant to either tool. ]

I am wondering if anyone here is able to shed some light on a problem I=
've
encountered with git-cvsimport.  For ages now, I've had an automatic
conversion of a CVS repository to a Git one, using git-cvsimport to upd=
ate a
repository as commits happen in CVS.

The repository in question is here:

https://github.com/ThomasAdam/tmux

Everything is on the Master branch.

More specifically, the commit which I think introduced the problem, and=
 all
subsequent commits thereafter is here:

https://github.com/ThomasAdam/tmux/commit/f0220a10b01a764e0dc52ea1b2407=
f58600a30eb

Note that from this commit onwards, the commit *message* has a bunch of
cvsps output in it.  I can only surmise that this somehow causes proble=
ms
for cvsimport.

But I can't say for sure.

But if you look at the commit after f0220a10b0:

https://github.com/ThomasAdam/tmux/commit/a7e5b474af93e36e314170e2db18e=
544e34cf7b3

The file cvsimport has imported has actually *reverted* the file in
question.  Confer:

-/*=A0$Id:=A0tmux.h,v=A01.582=A02010/12/06=A021:48:56=A0nicm=A0Exp=A0$=A0=
*/
+/*=A0$Id:=A0tmux.h,v=A01.246=A02009/01/21=A019:38:51=A0nicm=A0Exp=A0$=A0=
*/

Is anyone able to shed some light on this?  Needless to say I am a litt=
le
perplexed that content in the commit message (if that's what it is) wou=
ld
cause a cvsimport to fail.

The net result of this is I can no longer compile the master branch at =
all
because of this.  Oh, and should anyone be thinking it, compiling the C=
VS
repository which the git-cvsimport command is referencing, compiles fin=
e.
So it's definitely a problem with the import.

Any questions or further bits of information I can provide, do shout.

TIA.

-- Thomas Adam

--=20
"Deep in my heart I wish I was wrong.  But deep in my heart I know I am
not." -- Morrissey ("Girl Least Likely To" -- off of Viva Hate.)
