From: Thomas Lord <lord@emf.net>
Subject: Re: arch 2.0 first source available (git related)
Date: Sat, 09 Jul 2005 07:20:13 -0700
Message-ID: <1120918813.4901.27.camel@dev1.seyza.com>
References: <1120867947.5882.2.camel@dev1.seyza.com>
	 <20050709113942.GB26343@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 16:20:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrGBZ-0002tw-Gf
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 16:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVGIOT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 10:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVGIOT5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 10:19:57 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:44960 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261423AbVGIOT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 10:19:56 -0400
Received: (qmail 42363 invoked from network); 9 Jul 2005 14:19:52 -0000
Received: from unknown (HELO adsl-69-236-75-157.dsl.pltn13.pacbell.net) (tom.lord@sbcglobal.net@69.236.75.157 with plain)
  by smtp103.sbc.mail.mud.yahoo.com with SMTP; 9 Jul 2005 14:19:52 -0000
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050709113942.GB26343@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-07-09 at 13:39 +0200, Petr Baudis wrote:
> Dear diary, on Sat, Jul 09, 2005 at 02:12:27AM CEST, I got a letter
> where Thomas Lord <lord@emf.net> told me that...
> > 2.0 is very much git influenced but it brings some (imo significant)
> >   improvements to the table.
> 
> Could you list some of the things interesting for us? What is the
> benefit of a prereq graph compared to just having a single shared object
> database? From the documentation, that's the only interesting thing I
> noticed which is different from git (and things like artificially
> limiting filename length to 256 characters).

Well, partly the statement about improvements was a hint to look
beyond the docs to the code but...

The prereq graph is, indeed, an improvement.  

It:

* speeds up and simplifies blob-db GC

* vastly improves the possibilities for archive integrity
  checking

* can be used for smart, streamy network mirroring of revisions

* allows people to commit the same tree multiple ways: e.g., 
  once optimizing access for users who frequently read incremental
  updates and a second time for users who only update at named
  releases

* helps make the system securable (current code isn't yet) against
  the possibility of multiple files with identical fingerprints but
  different contents in the same or related trees

* helps in a variety of ways when it comes time to make `revc'
  operable over a network -- committing to a remote archive.

Other advantageous (imo) changes from `git' not mentioned in the
original message:

* blobs do not have header lines

  Git blobs all begin with a line of text declaring the "type"
  and size of the blob.   That doesn't increase database 
  verifiability significantly and I found no use for the headers.
  Having the headers makes it needlessly complicated to translate
  a file to or from a blob.

  `revc' does not have blob headers.


* `revc' uses portable file formats

   In working dirs, `git' stores binary files which are 
   endian, word-size, and compiler-environment specific.

   `revc' stores some binary files too (for performance
   and simplicity reasons) but uses only portable formats.

* `revc' is shaping up into much cleaner and more portable code

   (at least compared to the last version of `git' I saw --
    which was extremely *lucid* code but not terribly
    clean and not even attempting to be portable.)

The list goes on and I don't promise to be picking the 
most interesting items from it according to anybody's
particular metric of "interesting".

revc -- probably "strange yet familiar" to git hackers,
-t
