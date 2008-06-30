From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 13:44:09 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200806301344.09938.J.Wielemaker@uva.nl>
References: <200806301149.18115.J.Wielemaker@uva.nl> <200806301230.38980.J.Wielemaker@uva.nl> <200806301326.12140.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDHoi-00061P-TY
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 13:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536AbYF3LoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 07:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756381AbYF3LoM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:44:12 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:31359 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806AbYF3LoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:44:11 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 13:44:09 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200806301326.12140.jnareb@gmail.com>
Content-Disposition: inline
X-OriginalArrivalTime: 30 Jun 2008 11:44:09.0994 (UTC) FILETIME=[9C30F6A0:01C8DAA6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86908>

Hi Jakub,

Summarising, I think the conclusion is that git pack-refs has somehow
been run on this repository, and being a bare one this is not a
particulary good idea right now. I have the impression I should `unpack'
them by putting the appriate files in heads (done) and tags (now still)
and (re)move packed-refs.

	Cheers --- Jan

On Monday 30 June 2008 13:26, Jakub Narebski wrote:
> Jan Wielemaker wrote:
> > On Monday 30 June 2008 12:10, Jakub Narebski wrote:
> >> Jan Wielemaker <J.Wielemaker@uva.nl> writes:
> >>> I'm a bit puzzled. I have a bare repository, somehow without any files
> >>> in refs/heads.
> >>
> >> Do you have .git/packed-refs file?
> >
> > Its a bare repo, so I'll forget the .git.  Yes, I have that file and
> > it contains nice references,  I checked a few by hand, and they have
> > the same SHA1 as the files I copied.
>
> That is where the refs are instead of being in individual files under
> refs/ - those are so called "packed refs".
>
>   When a ref is  missing from  the traditional $GIT_DIR/refs hierarchy,
>   it is looked up in $GIT_DIR/packed-refs and used if found.
>
> I'm not sure why branches are also packed, because git used to pack
> only tags and refs which were packed already.
>
> >> How do you have gc.packrefs set ("git config --get gc.packrefs")?
> >
> > This gives no output, so I guess the answer is 'no'.
>
> In git-config(1) you can find the following:
>
>   gc.packrefs::
>         `git gc` does not run `git pack-refs` in a bare repository by
>         default so that older dumb-transport clients can still fetch
>         from the repository.  Setting this to `true` lets `git
>         gc` to run `git pack-refs`.  Setting this to `false` tells
>         `git gc` never to run `git pack-refs`. The default setting is
>         `notbare`. Enable it only when you know you do not have to
>         support such clients.  The default setting will change to `true`
>         at some stage, and setting this to `false` will continue to
>         prevent `git pack-refs` from being run from `git gc`.
>
> Unless something changed (and git Documentation was not updated) git
> should not pack refs by default.
>
> >> What are the git version on the
> >> clients that have trouble accessing repository, and what protocol
> >> (transport method) do they use: "file", http(s)/ftp, git, ssh?
> >
> > I could reproduce the problem using the same git that maintains the bare
> > repository, which started as git-1.5.3.4 and is now 1.5.6.rc3. It
> > reproduces both using local file access and ssh. Other people have a
> > variety of versions. I know of concrete problems using the stable 1.5.5
> > over ssh.
> >
> > The problem that I can't even clone is indeed after running a git-gc.
>
> Hmmm... strange. I know that there can be problems with older clients
> (those which do not understand packed-refs format) accessing
> repositories with packed refs (without loose refs) via "dumb"
> protocols.  Problems with accessing repositories locally and via ssh
> might point to some troubles with permissions and ownership of
> $GIT_DIR and $GIT_DIR/packed-refs.
>
> git-gc can pack refs, that is what running it causes problems.
>
> > So, now I have all branch head refs double (in packed-refs and in
> > refs/heads). That explains ar least where they come from, but it fails
> > to explain why doing exactly the same using the same git on the same
> > repo as two users yields a different result. Of course, besides the
> > desire to understand how his works, I'm mostly interested in how to fix
> > this :-)
>
> Unfortunately as it is not caused by the issue I thought about I cannot
> help you further...
