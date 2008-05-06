From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: how to git-archive ignore some files?
Date: Tue, 06 May 2008 23:23:01 +0200
Message-ID: <4820CC35.3090202@lsrfire.ath.cx>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br> <BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Tue May 06 23:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtUdr-0004be-Lh
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 23:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbYEFVXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 17:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933480AbYEFVXK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 17:23:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:34462 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933567AbYEFVXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 17:23:07 -0400
Received: from [10.0.1.200] (p57B7D12A.dip.t-dialin.net [87.183.209.42])
	by india601.server4you.de (Postfix) with ESMTPSA id 9BAD62F8082;
	Tue,  6 May 2008 23:23:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81380>

Sean Estabrooks schrieb:
> On Tue, 06 May 2008 15:15:31 -0300
> Victor Bogado da Silva Lins <victor@bogado.net> wrote:
>=20
>> I want to use git-archive to create source packages, but my git
>> repository has a .gitignore that I don't want to be pushed into the
>> archive. So is it possible to keep the .gitignore file in the reposi=
tory
>> and create an archive(*) without it?=20
>>
>> *) using git-archive, off course.=20
>>
>=20
> Hi Victor,
>=20
> You can do something like:
>=20
> git archive HEAD  | \
> 	tar --delete .gitignore .mailmap .gitattributes | \
> 	bzip2 -c > archive.tar.bz2

Or, if there is only a small number of files in your repository, you
could do something like this:

   git archive HEAD -- \
      $(git ls-tree -r --name-only HEAD | grep -v '^\.gitignore$')

To really solve this without external tools, git-archive needed to grow
an --exclude option like git-ls-files, though.

Ren=E9
