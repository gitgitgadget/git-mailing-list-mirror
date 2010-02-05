From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 05 Feb 2010 11:36:43 +0100
Message-ID: <201002051136.43738.johan@herland.net>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vaavo90ic.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:37:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdLYX-0000ip-0W
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab0BEKgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 05:36:51 -0500
Received: from smtp.getmail.no ([84.208.15.66]:50081 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753273Ab0BEKgt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 05:36:49 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXD00JPM6TC6840@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 05 Feb 2010 11:36:48 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXD0083R6T8PQ30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 05 Feb 2010 11:36:48 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.5.102122
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139041>

On Friday 05 February 2010, Giuseppe Bilotta wrote:
> On Thu, Feb 4, 2010 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > I expect more ideas from needs by end-user would come, as we gain
> > experience with using notes in real projects.  You will certainly find
> > some other needs of your own, like the "not an environment but a
> > command line option" which Jakub mentioned, and "multiple hierarchies"
> > like both you and I found need for.  Share them and let us together
> > make the notes mechanism nicer to use.
> 
> Collecting those ideas together would also help define some sort of
> roadmap, or at least have a clear idea of what's needed, to help drive
> the design of the features themselves. Maybe we could start a TODO
> page on the wiki collecting these ideas?

I already maintain a TODO list at the end of the cover letter to the notes 
series. Here is a preview of it (I plan to send the next iteration of 
jh/notes as soon as v1.7.0 is released):


- Suggestion by Matthieu Moy and Sverre Rabbelier:
  Add notes support to git-format-patch, where note contents in
  refs/notes/format-patch are added to the "comments section"
  (i.e. following the '---' separator) of generated patches.

- Better integration with rebase/amend/cherry-pick. Optionally bring
  notes across a commit rewrite. Controlled by command-line options
  and/or config variables. Add "git notes move" and "git notes copy"
  to suit. Junio says:
    I used to fix minor issues (styles, decl-after-stmt, etc.) using
    rebase-i long after running "am" in bulk, but these days I find
    myself going back to my "inbox" and fix them in MUA; this is
    only because I know these notes do not propagate across rebases
    and amends -- adjusting the workflow to the tool's limitation is
    not very good.

- Junio says:
  The interface to tell tools to use which notes ref to use should be
  able to say "these refs", not just "this ref" i.e. GIT_NOTES_REF=a:b
  just like PATH=a:b:c...); I am fairly certain that we would want to
  store different kind of information in separate notes trees and
  aggregate them, as we gain experience with notes.

- Junio says:
  There should be an interface to tell tools to use which notes refs via
  command line options; "!alias" does not TAB-complete, and "git lgm"
  above doesn't, either. "git log --notes=notes/amlog --notes=notes/other"
  would probably be the way to go.

- Add a "git notes grep" subcommand: Junio says:
  While reviewing the "inbox", I sometimes wonder if I applied a message
  to somewhere already, but there is no obvious way to grep in the notes
  tree and get the object name that a note is attached to.  Of course I
  know I can "git grep -c johan@herland.net notes/amlog" and it will give
  me something like:

    notes/amlog:65807ee697a28cb30b8ad38ebb8b84cebd3f255d:1
    notes/amlog:c789176020d6a008821e01af8b65f28abc138d4b:1

  but this won't scale and needs scripting to mechanize, once we start
  rebalancing the notes tree with different fan-outs.  The end user (me
  in this case) is interested in "set of objects that match this grep
  criteria", not "the pathnames the notes tree's implementation happens
  to use to store notes for them in the hierarchy".

- Handle note objects that are not blobs, but trees

(- Rewrite fast-import notes code to use new notes API with non-note 
support)


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
