From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 09:57:05 -0800
Message-ID: <20090301175705.GE14365@spearce.org>
References: <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org> <49AAC91E.1000401@gmail.com> <20090301174941.GD14365@spearce.org> <49AACB3A.8070809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldpwn-0004xC-EX
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbZCAR5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 12:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbZCAR5I
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:57:08 -0500
Received: from george.spearce.org ([209.20.77.23]:36654 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbZCAR5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:57:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id A62BE38210; Sun,  1 Mar 2009 17:57:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49AACB3A.8070809@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111865>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> Shawn O. Pearce wrote:
> >> Just to be clear, I noticed you left out the global core.excludesf=
ile
> >> (from ~/.gitconfig) here. I guess this intentional?
> >=20
> > No, I didn't.  core.excludesfile is read from the config, the confi=
g
> > is a union of /etc/gitconfig, ~/.gitconfig, and GIT_DIR/config.  Th=
e
> > last setting wins.
>=20
> Ah, I see, I thought each config was read in a separate steps. Thanks
> for clearing that up.

Well, they are.

But in git-core the value is pulled into a single static.  For a
string its often a single static char*.  So the config handle
function is called up to 3 times for foo.bar, and the last one to
be called is the one that finally set the value.  They are read
in the order I described above, so GIT_DIR/config has a chance to
override any prior setting.

In JGit the RepositoryConfig object parses the other direction.
Its a more classical "default" pattern, where if GIT_DIR/config
doesn't have a foo.bar we call to another instance which had parsed
~/.gitconfig, and so on.

Either way produces the same result.

--=20
Shawn.
