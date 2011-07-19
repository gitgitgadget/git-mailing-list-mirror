From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: Restricted git push ?
Date: Tue, 19 Jul 2011 16:03:11 +0530
Message-ID: <20110719160311.10f2364d@shiva.selfip.org>
References: <20110719150637.596b9791@shiva.selfip.org>
	<CAMK1S_jsv-pFy6bNPG=EK=4YsJOh3GUZ+_DAq6n36ajWuhyNaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 12:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj7cE-0002tR-Gj
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 12:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab1GSKdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 06:33:16 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:33865
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954Ab1GSKdM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 06:33:12 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id F169D3804001;
	Tue, 19 Jul 2011 12:33:03 +0200 (CEST)
In-Reply-To: <CAMK1S_jsv-pFy6bNPG=EK=4YsJOh3GUZ+_DAq6n36ajWuhyNaQ@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177449>

On Tue, 19 Jul 2011 15:35:42 +0530
Sitaram Chamarty <sitaramc@gmail.com> wrote:

> On Tue, Jul 19, 2011 at 3:06 PM, J. Bakshi <joydeep@infoservices.in> =
wrote:
> > Hello list,
> >
> > I have installed git repo based on http:// =C2=A0protocol and both =
read+write access is based on a htpasswd based authentication. The git =
repo is "bare" so that push is possible. But I like to have push from a=
 limited users only, not from all. For the rest, only pull should be po=
ssible. Is there any way to achieve this type of ACL ?
>=20
> man git-http-backend has an example config described thus:  "To enabl=
e
> anonymous read access but authenticated write access...".  It
> certainly sounds like what you want.
>=20
> Not sure what sort of http access you have setup=20

I have=20

``````````
<Location /git>
AuthType Basic
# Message to give to the committer
AuthName "Write access requires a password"
# File listing users with write (commit) access
AuthUserFile /home/svn/PASSWD
Require valid-user
</Location>
``````````

So authentication is require forman git-http-backend both read and writ=
e. Now to use one more level to restrict push user I have added one mor=
e restriction like

<LocationMatch "^/git/.*/git-receive-pack$">
AuthType Basic
# Message to give to the committer
AuthName "Write access requires a password"
# File listing users with write (commit) access
AuthUserFile /home/git/pushACL
Require valid-user
</LocationMatch>

read access is working fine, but write access not. log reports=20

````````
 user testuser not found: /git/web.git/info/refs
``````````

Don't know why it is searching at /git/web.git/info/refs !!
