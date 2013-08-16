From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: [cygwin] Re: Lack of case-sensitive filename handling with git 1.7.9-1 for Cygwin 64-bit
Date: Fri, 16 Aug 2013 07:54:57 -0400
Organization: PD Inc
Message-ID: <4D206B626EE941D28F6CB93E38293863@black>
References: <CAGZiy71u1Ci_2Uw6jgAw3-9gCgwVrS1ae2Bpz9HCbnj2+EZexA@mail.gmail.com> <20130816081743.GC2562@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Git List'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:14:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJrL-0001IJ-2E
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab3HPNOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 09:14:23 -0400
Received: from projects.pdinc.us ([67.90.184.26]:46987 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751942Ab3HPNOV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:14:21 -0400
X-Greylist: delayed 4762 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2013 09:14:21 EDT
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r7GBsgcl001135
	for <git@vger.kernel.org>; Fri, 16 Aug 2013 07:54:42 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20130816081743.GC2562@calimero.vinschen.de>
Thread-Index: Ac6aWWW9C34IxQwHTBWgB7DtkmYsLwAHcrFA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232426>

I just saw this on the cygwin list.

> -----Original Message-----
> From: Corinna Vinschen
> Sent: Friday, August 16, 2013 4:18
> To: cygwin@cygwin.com
> Subject: [cygwin] Re: Lack of case-sensitive filename 
> handling with git 1.7.9-1 for Cygwin 64-bit
> 
> On Aug 16 10:32, Kal Sze wrote:
> > I have been using Cygwin 32-bit on Windows 7 Profession 
> 64-bit. I had 
> > the HKLM\SYSTEM\CurrentControlSet\Control\Session
> > Manager\kernel\ObCaseInsensitive registry key set to DWORD 
> 0x00000000 
> > and case-sensitive filename handling has been fully working 
> in Cygwin 
> > 32-bit (as far as I can tell from my usage anyway).
> > 
> > Now that Cygwin 64-bit has been released, I want to try it. 
> I notice 
> > that git in Cygwin 64-bit does not seem to correctly handle 
> filesname 
> > that differ only by case.
> > 
> > To reproduce, create a repository in Cygwin 32-bit *with the 
> > aforementioned registry key set*:
> > 
> >     $ git init case_sensitivity_test; cd case_sensitivity_test
> > 
> > Create two files of different content with similar filenames that 
> > differ only by case:
> > 
> >     $ echo 'FOO' > FOO.TXT; echo 'foo' > foo.txt
> > 
> > Commit them into the repository:
> > 
> >     $ git add .; git commit -m 'Initial commit'
> >     [master (root-commit) 16d1b59] Initial commit
> >      2 files changed, 2 insertions(+), 0 deletions(-)
> >      create mode 100644 FOO.TXT
> >      create mode 100644 foo.txt
> > 
> > In Cygwin 32-bit, this looks all green:
> > 
> >     $ git status
> >     # On branch master
> >     nothing to commit (working directory clean)
> >     $ ls
> >     FOO.TXT  foo.txt
> > 
> > Now, fire up the Cygwin64 terminal and browse to the 
> repository, then:
> > 
> >     $ ls
> >     FOO.TXT  foo.txt
> >     $ cat FOO.TXT
> >     FOO
> >     $ cat foo.txt
> >     foo
> > 
> > So `ls` and `cat` both recognize the two different files. However:
> > 
> >     $ git status
> >     # On branch master
> >     # Changes not staged for commit:
> >     #   (use "git add <file>..." to update what will be committed)
> >     #   (use "git checkout -- <file>..." to discard changes 
> in working
> > directory)
> >     #
> >     #       modified:   foo.txt
> >     #
> >     no changes added to commit (use "git add" and/or "git 
> commit -a")
> > 
> > "Oops."
> 
> The interesting thing here is, if you try this the other way 
> around, you'll see the exact same effect.  If you created the 
> above git repo with 64 bit git, everything works exactly as 
> in the 32 bit version and the two files are correctly recognized.
> 
> I assume the format of the git database files depends on the 
> architecture.  Therefore it's probably not advisable to use a 
> git repo created under 32 bit git with a 64 bit git and vice versa.

Is this the best explanation for this?

> 
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails 
> regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
> 


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
