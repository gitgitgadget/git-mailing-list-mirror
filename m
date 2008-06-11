From: Pascal Obry <pascal@obry.net>
Subject: Re: git-reflog infinite loop
Date: Wed, 11 Jun 2008 20:58:23 +0200
Organization: Home - http://www.obry.net
Message-ID: <4850204F.50401@obry.net>
References: <484EBD92.8040603@obry.net> <20080611034718.GB7198@sigill.intra.peff.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VYk-0001hj-6B
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762245AbYFKS6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 14:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765996AbYFKS6d
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:58:33 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:25669 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765991AbYFKS6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:58:31 -0400
Received: by gv-out-0910.google.com with SMTP id e6so795194gvc.37
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 11:58:29 -0700 (PDT)
Received: by 10.78.133.2 with SMTP id g2mr215188hud.70.1213210708194;
        Wed, 11 Jun 2008 11:58:28 -0700 (PDT)
Received: from ?192.168.0.100? ( [83.199.33.70])
        by mx.google.com with ESMTPS id y1sm332504hua.41.2008.06.11.11.58.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 11:58:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080611034718.GB7198@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84640>

Jeff King a =C3=A9crit :
> I can't reproduce here, so presumably it is some condition in your
> repository; can you make a tarball of your .git directory available?

Ok, mystery solved.

The problem was that the repository had been imported using git-svn and=
=20
contained something like 86000 reflog entries in=20
=2Egit/logs/refs/remotes/pre/trunk.

Using the debugger I have seen that the loop was not endless... but ver=
y=20
slow as there was many many reflog to process. Don't know if this is=20
expected or not though.

To fix that I have launched:

    $ git-reflog expire --expire=3D10 --all

It has removed all the old reflogs dating from the git-svn initial=20
import lowering the number of enties in .git/logs/refs/remotes/pre/trun=
k=20
to 0 :)

git gc is now working like a charm!

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
