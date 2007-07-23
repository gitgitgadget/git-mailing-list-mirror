From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Mon, 23 Jul 2007 09:55:32 +0200
Message-ID: <46A45EF4.9090305@fs.ei.tum.de>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>	<11851631511468-git-send-email-jasonsewall@gmail.com> <7vd4yjoi2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICslW-0001nJ-O3
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbXGWHzf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Jul 2007 03:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbXGWHzf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:55:35 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42642 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbXGWHzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:55:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 89ADF280ED;
	Mon, 23 Jul 2007 09:55:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mEceu81NUFbW; Mon, 23 Jul 2007 09:55:33 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-202.dclient.lsne.ch [85.218.11.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 234FA280E7;
	Mon, 23 Jul 2007 09:55:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <7vd4yjoi2w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53408>

Junio C Hamano wrote:
> It may be that we may want to fix this inside cvsexportcommit
> itself, instead of working it around in the tests.  If somebody
> tries to push more than one commit from git using two
> cvsexportcommit in a row, he would need to make sure that the
> second run happens one or more seconds after the first run,
> otherwise he will see the exact corruption in real life.

Ah, now I see the problem.  The timestamp in the CVS/Entries is the sam=
e (because it only has second granularity), so cvs commit won't conside=
r it as changed.

That's the reason why CVS usually waits until the second turns after a =
"update" (obviously not after a "commit").  So we could either turn bac=
k the timestamp in the Entries file (ugly) or simply wait until the sec=
ond turns.  Given the overall cvs performance, this won't be a big issu=
e, I guess.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
