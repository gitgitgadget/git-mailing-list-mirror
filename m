From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Fri, 15 Jan 2016 02:12:37 +0100
Message-ID: <20160115021237.Horde.J6jJsRTdZiG5URajzd8kKsn@webmail.informatik.kit.edu>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
 <20151220074559.GF30662@sigill.intra.peff.net>
 <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:12:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJswf-0001Pc-FC
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbcAOBMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 20:12:49 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46570 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753164AbcAOBMs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 20:12:48 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aJswV-0005gO-3S; Fri, 15 Jan 2016 02:12:43 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aJswP-0000R6-Ot; Fri, 15 Jan 2016 02:12:37 +0100
Received: from x4db25559.dyn.telefonica.de (x4db25559.dyn.telefonica.de
 [77.178.85.89]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 15 Jan 2016 02:12:37 +0100
In-Reply-To: <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1452820363.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284128>


Quoting Junio C Hamano <gitster@pobox.com>:

> Actually, we do not even _need_ a sharedness for this ephemeral
> file.  The additional "adjust-shared-perm" is merely a workaround
> for the fact the next person cannot write into it when it is left
> behind, and because we do not want to remove it when we are done.

Do we really want to keep such a file after we are done?

 From all the cases where $GIT_EDITOR is run as part of an operation =20
to edit a temporary file, that temporary file is deleted on success =20
most of the time, except the already mentioned COMMIT_EDITMSG, =20
REPLACE_EDITOBJ for 'git replace --edit', and BRANCH_DESCRIPTION for =20
'git branch --edit-description'.  I don't see why these files should =20
be handled differently than the others and why should they be kept =20
after the operation finished, since at that point the contents is =20
already stored in its proper place (in the commit object, in the =20
replacement object, or in the config file), making these files =20
redundant and unnecessary.

If the operation fails for whatever reason, then that's a different =20
matter, of course.  In that case we definitely want to keep these =20
files to avoid losing whatever the user has written.

G=C3=A1bor
