From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git-gui Error
Date: Tue, 13 Feb 2007 22:53:03 +0100
Message-ID: <20070213215303.GA26716@auto.tuwien.ac.at>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 22:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH5aJ-0007f7-46
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 22:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbXBMVxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Feb 2007 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbXBMVxH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 16:53:07 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37276 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbXBMVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 16:53:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C5F1168009CA;
	Tue, 13 Feb 2007 22:53:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3e-vYgWvwTOI; Tue, 13 Feb 2007 22:53:03 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 6BFD068006AA; Tue, 13 Feb 2007 22:53:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070213074519.GA32687@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39586>

On Tue, Feb 13, 2007 at 02:45:19AM -0500, Shawn O. Pearce wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > Starting git-gui without any parameters display an error message in=
stead
> > of a usage message:
>=20
> Starting it with no parameters (`git-gui` or `git gui`) should
> work just fine.  I do this all of the time on Mac OS X and Windows,
> as it opens a commit window and keeps it running.
> =20
> > Error in startup script: child process exited abnormally
> >     while executing
> > "close $fd"
> >     (procedure "load_all_heads" line 11)
> >     invoked from within
> > "load_all_heads"
> >     invoked from within
> > "if {[is_enabled transport]} {
> >         load_all_remotes
> >         load_all_heads
> >=20
> >         populate_branch_menu
> >         populate_fetch_menu
> >         populate_push_menu
> > }"
>=20
> According to this backtrace, we were trying to startup the UI
> and load the branches, but:
>=20
>   git for-each-ref --format=3D%(refname) refs/heads
>=20
> returned a non-zero exit code or something else with it went wrong.
> Is this maybe a brand new repository?  This is most certainly a bug
> in git-gui, but I'd like to understand more about the environment
> so I can track it down.

My fault, I had only a too old GIT core (1.4.1) in my path.
With the current version, the problem disapears.

Some notes about using git-gui:=20

* Fetching over ssh results in an empty dialog. The password prompt is
only shown in the terminal window, which is likly to be hidden by the
the main window of git-gui.

* It there any reason, why tags are not included in the list of possibl=
e
merge sources in Merge/Local Merge?

It only needs one additional line in do_local_merge:
         set cmd [list git for-each-ref]
         lappend cmd {--format=3D%(objectname) %(refname)}
         lappend cmd refs/heads
         lappend cmd refs/remotes
+        lappend cmd refs/tags
         set fr_fd [open "| $cmd" r]

mfg Martin K=F6gler
