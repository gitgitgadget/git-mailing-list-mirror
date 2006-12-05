X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Mon, 04 Dec 2006 23:14:07 -0300
Message-ID: <200612050214.kB52E7mG027926@laptop13.inf.utfsm.cl>
References: <cworth@cworth.org>
NNTP-Posting-Date: Tue, 5 Dec 2006 02:14:35 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Carl Worth <cworth@cworth.org> 
   of "Mon, 04 Dec 2006 17:18:43 -0800." <87zma316oc.wl%cworth@cworth.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 04 Dec 2006 23:14:11 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33285>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrPpJ-0002rW-8r for gcvg-git@gmane.org; Tue, 05 Dec
 2006 03:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968027AbWLECOU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 21:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968030AbWLECOU
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 21:14:20 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41259 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968027AbWLECOT (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 21:14:19 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kB52E8Ux010164 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Mon, 4 Dec 2006 23:14:10 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kB52E7mG027926; Mon, 4
 Dec 2006 23:14:07 -0300
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> On Mon, 04 Dec 2006 21:52:38 -0300, "Horst H. von Brand" wrote:
> > >     Commits the content of the working tree for the given paths, (or
> > >     all tracked paths). Untracked files can be committed for the first
> > >     time by specifying their names on the command-line or by using
> > >     "git add" to add them just prior to the commit. Any rename or
> > >     removal of a tracked file will be detected and committed
> > >     automatically.

> > Edit somefile with, e.g, emacs: Get backup called somefile~
> > Realize that somefile is nonsense, delete it(s edited version)
> > commit-working-tree-contents: Now you have the undesirable somefile~ saved

> The semantics I intended to describe for commit-working-tree-content
> would not add this file. That's a "new file" so would have to be
> mentioned either explicitly on the command-line or in a git-add
> command before it would be committed.

How do you distinguish a "new file, same contents as old file" from "old
file, renamed"? What is the difference between:

  mv somefile newfile

and

  cp somefine newfile
  rm somefile

?

How should

  cp somefile newfile
  vi somefile

be handled? How about

  cp somefile oldfile
  vi somefile

or just

  mv somefile oldfile

? Or

  cp somefile somefile.my-own-bakup
  vi somefile

?

The whole problem is your description based on "file renaming" and
such. AFAIU git has a list of file names it is tracking, and for those
names it keeps track of what the contents for each are at each commit. That
the name somefile had some contents that later show up as newfile (both
names tracked) is recorded just as that. You could /interpret/ this as a
"rename" if somefile is then gone, but it could well be something else.
Besides, you'd have to search for the old somefile contents among /all/
newfiles just to find out it was renamed. Better don't mix facts with
interpretation (== guesses on what operations came in between the snapshots
git takes). Note that it should never matter what strange ideas a random
user gets for naming her temporary backup files, or their git configuration.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
