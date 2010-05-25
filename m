From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate subdirectory
Date: Tue, 25 May 2010 06:24:31 +0200
Message-ID: <201005250624.31097.chriscool@tuxfamily.org>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com> <201005250514.39980.chriscool@tuxfamily.org> <AANLkTikaS0m8VJ6hpSA2-pefN1w8Y5J64rr6xNMj1B3q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 06:48:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGm4H-0008JU-CU
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 06:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986Ab0EYEsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 00:48:35 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39194 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab0EYEse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 00:48:34 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C55DF8180B8;
	Tue, 25 May 2010 06:48:27 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Tue, 25 May 2010 06:48:26 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <AANLkTikaS0m8VJ6hpSA2-pefN1w8Y5J64rr6xNMj1B3q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147661>

On Tuesday 25 May 2010 06:30:49 Pavan Kumar Sunkara wrote:
> 2010/5/25 Christian Couder <chriscool@tuxfamily.org>:
> > On Tuesday 25 May 2010 02:37:50 Jakub Narebski wrote:
> >> On Mon, 24 May 2010, Pavan Kumar Sunkara wrote:
> >> > On Tue, May 25, 2010 at 1:35 AM, Christian Couder
> >
> > <chriscool@tuxfamily.org> wrote:
> >> >> On Monday 24 May 2010 17:22:44 Pavan Kumar Sunkara wrote:
> >> >>>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
> >> >>>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
> >> >>>  gitweb/{ => static}/gitweb.css      |    0
> >> >>>  gitweb/{ => static}/gitweb.js       |    0
> >> >>
> >> >> The patch is supposed to move git-favicon.png and git-logo.png into
> >> >> gitweb/static but it doesn't.
> >> >>
> >> >>>  diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
> >> >>> similarity index 100%
> >> >>> rename from gitweb/gitweb.css
> >> >>> rename to gitweb/static/gitweb.css
> >> >>> diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
> >> >>> similarity index 100%
> >> >>> rename from gitweb/gitweb.js
> >> >>> rename to gitweb/static/gitweb.js
> >> >>
> >> >> Only gitweb.css and gitweb.js are moved into gitweb/static [...]
> >> >
> >> > I don't understand why the binary files aren't moving into static/
> >> > dir. I haven't faced this type of problem before. Give me some time to
> >> > figure it out.
> >>
> >> You have found a bug in git.  When you do a pure rename of a binary
> >> file, it doesn't show as a pure rename patch:
> >>
> >>   $ git init
> >>   $ echo foo > foo
> >>   $ echo -e "bar\0" > bar
> >>   $ git add .
> >>   $ git commit -m 'Initial commit'
> >>   [master (root-commit) 4bd35b8] Initial commit
> >>    2 files changed, 1 insertions(+), 0 deletions(-)
> >>    create mode 100644 bar
> >>    create mode 100644 foo
> >>   $ mkdir sub
> >>   $ git mv bar foo sub/
> >>   $ git commit -m 'Moved to sub/'
> >>   [master 00356a5] Moved to sub/
> >>    2 files changed, 0 insertions(+), 0 deletions(-)
> >>    rename bar => sub/bar (100%)
> >>    rename foo => sub/foo (100%)
> >>   $ git show -C -C --raw --binary --stat
> >>   commit 00356a5ec458fa64ab3eca2c23ebc53e9f2d54ba
> >>   Author: Jakub Narebski <jnareb@gmail.com>
> >>   Date:   Tue May 25 02:23:26 2010 +0200
> >>
> >>       Moved to sub/
> >>   ---
> >>
> >>   :100644 100644 080090e... 080090e... R100       bar     sub/bar
> >>   :100644 100644 257cc56... 257cc56... R100       foo     sub/foo
> >>
> >>    bar => sub/bar |  Bin 5 -> 5 bytes
> >>    foo => sub/foo |    0
> >>    2 files changed, 0 insertions(+), 0 deletions(-)
> >>
> >>   diff --git a/foo b/sub/foo
> >>   similarity index 100%
> >>   rename from foo
> >>   rename to sub/foo
> >>
> >> As you can see there is not
> >>
> >>   diff --git a/bar b/sub/bar
> >>   similarity index 100%
> >>   rename from bar
> >>   rename to sub/bar
> >>
> >> and that adding '--binary' option doesn't help
> 
> Jakub is right. It isn't working for me too.
> 
> > I tested current master, next and pu with this script:
> >
> > $ cat test_move_binary.sh
> > #!/bin/sh
> >
> > rm -rf test_binary_dir
> > mkdir test_binary_dir
> > cd test_binary_dir
> >
> > git init
> > echo foo > foo
> > echo -e "bar\0" > bar
> > git add .
> > git commit -m "Initial commit"
> > mkdir sub
> > git mv bar foo sub/
> > git commit -m 'Moved to sub/'
> > git show -C -C --raw --binary --stat
> >
> > And I get:
> >
> > $ ./test_move_binary.sh
> > Initialized empty Git repository in
> > /home/christian/work/git/test_binary_dir/.git/
> > [master (root-commit) e4c2beb] Initial commit
> >  2 files changed, 2 insertions(+), 0 deletions(-)
> >  create mode 100644 bar
> >  create mode 100644 foo
> > [master 4fd23ac] Moved to sub/
> >  2 files changed, 0 insertions(+), 0 deletions(-)
> >  rename bar => sub/bar (100%)
> >  rename foo => sub/foo (100%)
> > commit 4fd23ac43186d31879d7e9dc98b74ce9a7382558
> > Author: Christian Couder <chriscool@tuxfamily.org>
> > Date:   Tue May 25 05:10:00 2010 +0200
> >
> >    Moved to sub/
> > ---
> >
> > :100644 100644 aae0a5b... aae0a5b... R100       bar     sub/bar
> > :100644 100644 257cc56... 257cc56... R100       foo     sub/foo
> >
> >  bar => sub/bar |    0
> >  foo => sub/foo |    0
> >  2 files changed, 0 insertions(+), 0 deletions(-)
> >
> > diff --git a/bar b/sub/bar
> > similarity index 100%
> > rename from bar
> > rename to sub/bar
> > diff --git a/foo b/sub/foo
> > similarity index 100%
> > rename from foo
> > rename to sub/foo
> >
> > so it works fine for me. Which version are you using?
> 
> It's not a problem with the version, it's a problem with your system.
> echo -e didn't create a binary as expected. You can tell it by seeing
> this line:
> 
> bar => sub/bar | 0
> 
> rather than this
> 
> bar => sub/bar | Bin 5 -> 5 Bytes
> 
> Change your script to copy a binary file into bar instead of using
> 'echo -e 'bar\()' and you will see the difference.

Yeah I changed "#!/bin/sh" to "#!/bin/bash" and it does not work now.
It's a problem because /bin/sh is dash on kubuntu.
 
Thanks,
Christian.
