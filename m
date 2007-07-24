From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 10:11:42 +0200
Message-ID: <46A5B43E.3030700@fs.ei.tum.de>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <7vd4yjoi2w.fsf@assigned-by-dhcp.cox.net> <46A45EF4.9090305@fs.ei.tum.de> <200707240223.54228.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDFUk-0005OG-OA
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 10:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbXGXILr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 04:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbXGXILq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 04:11:46 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:59285 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbXGXILp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 04:11:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 4D65B2814E;
	Tue, 24 Jul 2007 10:11:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p9pZ0NLfxH0t; Tue, 24 Jul 2007 10:11:43 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-202.dclient.lsne.ch [85.218.11.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id C369628149;
	Tue, 24 Jul 2007 10:11:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <200707240223.54228.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53532>

Robin Rosenberg wrote:
>>> It may be that we may want to fix this inside cvsexportcommit
>>> itself, instead of working it around in the tests.  If somebody
>>> tries to push more than one commit from git using two
>>> cvsexportcommit in a row, he would need to make sure that the
>>> second run happens one or more seconds after the first run,
>>> otherwise he will see the exact corruption in real life.
>> Ah, now I see the problem.  The timestamp in the CVS/Entries is the =
same (because it only has second granularity),=20
>> so cvs commit won't consider it as changed.=20
>>
>> That's the reason why CVS usually waits until the second turns after=
 a "update" (obviously not after a "commit").=20
>> So we could either turn back the timestamp in the Entries file (ugly=
) or simply wait until the second turns.  Given=20
>> the overall cvs performance, this won't be a big issue, I guess.=20
>=20
> CVS sleeps after commit here. Can we bisect it? I have 1.12.3
> (mandriva). The patch below I think would work around the problem,
> rather than trying to fix the test. but I'd like to have the last CVS
>  revision where it does not work for the patch comment

This is a strange thing.  CVS has this in their commit code since 1996.=
  So I wonder why this is getting triggered.

> Since the sleep is per invocation of cvsexportcommit it won't hurt
> too much since it is rarely invoked on a huge number of git commits.

The question also is, why does this happen on two sequential invocation=
s of cvsexportcommit, but not on two cvs commits done by cvsexportcommi=
t?  This should look the same to cvs, no?

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
