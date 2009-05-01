From: Ben Armstrong <BArmstrong@dymaxion.ca>
Subject: Re: jgit standalone client on OpenVMS works (somewhat)
Date: Fri, 1 May 2009 07:08:38 -0300
Message-ID: <3f1ae6620905010308u44be6aefl5dccf0901424c292@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 12:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzpfx-0002RV-FQ
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 12:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZEAKIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 06:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZEAKIl
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 06:08:41 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:63511 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbZEAKIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 06:08:40 -0400
Received: by bwz7 with SMTP id 7so2245201bwz.37
        for <git@vger.kernel.org>; Fri, 01 May 2009 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=2zMSHhhK0xxmSyjU7xEhzVZjz8qPzHj/7GQUE7OqX08=;
        b=bZAhS0HtnoGdsHQtYvXLirIgpaLIUtRbIElGypeTMMZ6kMiV83g0FqxfswYqUIzokn
         gwwUQzHiNKZNPAZabEq3+lBgOFtBEWj9T48EuMArdj+m4cUNwt5SUTSqZBY7JTUwDC6K
         2rHIpt/GUpUDX6NQzU8Xg+c4gbNPfWXM9ok34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=W1MFNL1R8sBAiEAM5yzyUVFEH6CDupy9MjX5eVjWjx3C1BUBlpQOiYnUyC2WGaHIld
         rpAplEDX8QF7cjcb4T7fnmcF7yoMZJQ9DWG8X0MVj5bSQj2hITh6l921cHcep5VmzjF8
         UH736yQLaVbTs4GYzYwD7Dqq0aXJhwlFCcrJg=
Received: by 10.204.117.141 with SMTP id r13mr2373010bkq.181.1241172518848; 
	Fri, 01 May 2009 03:08:38 -0700 (PDT)
X-Google-Sender-Auth: 0dd0862e5430cbab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118072>

Shawn O. Pearce wrote:
> > I'm talking to some folks who are trying to put JGit into Maven.
> > They want to move a lot of egit.core down into JGit, which should
> > make it easier to add more commands to the jgit wrapper, making a
> > more functional command line tool.

Certainly without at least commit (and diff would be nice) I can't go
any further with jgit on VMS today.  We will have to use jsvn for the
interim (our repositories are currently in svn anyway, and jsvn is
reasonably full-featured and functional on VMS).  But it's nice to have
a migration path in the offing.

> > Can you write a subclass of our FS class that can identify a
> > VMS host and use that VMS specific subclass?
> >

Should I return to jgit, I could look into this (though I am not a Java
programmer).

> > If so, we could add a method, e.g.:
> >
> >   boolean canBeLooseRef(String name)
> >
> > and on VMS when the name falls into that "ODS-5_Syntax
> > Interpretation_of_Period" rule set above, we could return false.
> > This would then permit a simple change in RefDatabase where we always
> > store such refs in the packed-refs file, instead of as a loose file.
> >
> > It also means we'd have to forgo the ref log, or mangle the reflog
> > name.
> >
> > But it seems to me we could reasonably work around this without
> > too much trouble.
> >

Glad to hear it.  I have taken note in case I revive this effort later.

Before I sign off entirely, I'd like to mention also that I tried using
the ssh protocol without success:

A:BG.WORK> git clone ssh://ben@bgpc.dymaxion.ca/home/ben/git/myrepo.git
Initialized empty Git repository in /DSA0/BG/WORK/myrepo/.git
java.lang.NullPointerException
        at com.jcraft.jsch.Session.disconnect(Session.java)
        at
org.spearce.jgit.transport.SshSessionFactory.releaseSession(SshSessionFactory.java)
        at org.spearce.jgit.transport.SshTransport.close(SshTransport.java)
        at org.spearce.jgit.pgm.Clone.runFetch(Clone.java)
        at org.spearce.jgit.pgm.Clone.run(Clone.java)
        at org.spearce.jgit.pgm.TextBuiltin.execute(TextBuiltin.java)
        at org.spearce.jgit.pgm.Main.execute(Main.java)
        at org.spearce.jgit.pgm.Main.main(Main.java)

$ dir [.myrepo.^.git...]

Directory DSA0:[BG.WORK.myrepo.^.git]

branches.DIR;1      config.;3           HEAD.;1
objects.DIR;1
refs.DIR;1          remotes.DIR;1

Total of 6 files.

Directory DSA0:[BG.WORK.myrepo.^.git.objects]

info.DIR;1          pack.DIR;1

Total of 2 files.

Directory DSA0:[BG.WORK.myrepo.^.git.refs]

heads.DIR;1         tags.DIR;1

Total of 2 files.

Grand total of 3 directories, 10 files.
