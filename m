From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 06 Feb 2008 10:40:34 +0100
Message-ID: <47A98092.2070509@viscovery.net>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>, srp@srparish.netq
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgmH-0006XM-CK
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760686AbYBFJkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760232AbYBFJkk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:40:40 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38025 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760187AbYBFJkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 04:40:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JMglL-0007VD-AK; Wed, 06 Feb 2008 10:40:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8E6066B7; Wed,  6 Feb 2008 10:40:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72784>

Wincent Colaiuta schrieb:
> El 5/2/2008, a las 21:02, Junio C Hamano escribi=F3:
>> Perhaps you did not install git on the PATH processes launched
>> by your inetd implementation would use?
>=20
> I don't know what PATH environment xinetd provides, but I can reprodu=
ce
> this directly as follows from the command line without any involvemen=
t
> from xientd:
>=20
> First, set up PATH with all the standard locations, with directories
> under /usr/local specified first. Git 1.5.4 is installed in /usr/loca=
l/bin:
>=20
>   # export
> PATH=3D/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
>=20
> This fails with the "remote end hung up unexpectedly" error:
>=20
>   # /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah

If you run this from the command line, you can't expect it to do anythi=
ng
useful: It communicates with the client via stdin and stdout.

> Drop the --inetd option and it works with no errors:
>=20
>   # /usr/local/bin/git-daemon --base-path=3D/blah -- /blah

When I run git-daemon with a reduced path similar to this:

   PATH=3D/bin:/usr/bin /usr/local/bin/git-daemon ...

i.e. git is installed in /usr/local/bin, but it is not in PATH, then I
also get "hung up unexpectedly" from a client that connects to this ser=
ver.

Which makes me think that you xinetd doesn't pass a PATH to git-daemon
that includes /usr/local/bin. Add this to your /etc/xinetd.d/git:

    env =3D PATH=3D/bin:/usr/bin:/usr/local/bin

(not tested).

-- Hannes
