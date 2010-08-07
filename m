From: Richard Braun <rbraun@sceen.net>
Subject: Re: Maildir ordering in git-mailsplit (was: Using mutt as a git
	maintainer)
Date: Sat, 7 Aug 2010 13:21:59 +0200
Message-ID: <20100807112159.GA12015@sceen.net>
References: <20100806222847.GA4240@sceen.net> <20100807024337.GA15410@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 14:13:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiHK-0004JG-4N
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762030Ab0HGL17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 07:27:59 -0400
Received: from dalaran.sceen.net ([91.121.161.122]:60288 "EHLO mail.sceen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617Ab0HGL16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 07:27:58 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Aug 2010 07:27:58 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sceen.net (Postfix) with ESMTP id 0D184224264
	for <git@vger.kernel.org>; Sat,  7 Aug 2010 13:27:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sceen.net
Received: from mail.sceen.net ([127.0.0.1])
	by localhost (mail.sceen.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gtgk1SO3ZsEt for <git@vger.kernel.org>;
	Sat,  7 Aug 2010 13:27:56 +0200 (CEST)
Received: by mail.sceen.net (Postfix, from userid 105)
	id E2E45224286; Sat,  7 Aug 2010 13:27:11 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sceen.net (Postfix) with ESMTP id 4951C224264
	for <git@vger.kernel.org>; Sat,  7 Aug 2010 13:23:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sceen.net
Received: from mail.sceen.net ([127.0.0.1])
	by localhost (mail.sceen.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DOMKZmrvpPhi for <git@vger.kernel.org>;
	Sat,  7 Aug 2010 13:23:56 +0200 (CEST)
Received: by mail.sceen.net (Postfix, from userid 105)
	id 2F612224286; Sat,  7 Aug 2010 13:23:39 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sceen.net (Postfix) with ESMTP id 4E0A9224264;
	Sat,  7 Aug 2010 13:21:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sceen.net
Received: from mail.sceen.net ([127.0.0.1])
	by localhost (mail.sceen.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 59c+ktfuzJTA; Sat,  7 Aug 2010 13:21:59 +0200 (CEST)
Received: by mail.sceen.net (Postfix, from userid 1000)
	id 382E7224286; Sat,  7 Aug 2010 13:21:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100807024337.GA15410@kytes>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152852>

On Sat, Aug 07, 2010 at 08:13:39AM +0530, Ramkumar Ramachandra wrote:
> Hi Richard,
> 
> Ah, it looks like this problem went unnoticed probably because
> everyone uses mboxes. One possible solution would be to teach
> `git-mailsplit` to order the emails correctly. You can reply with an
> RFC patch; I've CC'ed the Git list on this email.

Well, if everybody else has survived for five years with mbox patch
series, I guess I can do that too. With some not-so-difficult work, I
managed to have Mutt do what I wanted (that is, saving patch series in
mbox files in one macro and keep everything else with Maildir folders
untouched).

After some digging in the code, it doesn't look like a git issue. When
a Maildir folder is processed, its entries are actually sorted, unlike
what I first thought. populate_maildir_list() calls string_list_insert()
(in string-list.c) which does insertion sort through its static
add_entry() and get_entry_index() functions which use a bare strcmp() to
compare file names (it was path-list.c back in Git 1.5, same code).
When copying a threaded patch series in a Maildir folder with Mutt, here
are the names created:
1281177008.8677_101.myhostname:2,
1281177008.8677_103.myhostname:2,
1281177008.8677_105.myhostname:2,
1281177008.8677_107.myhostname:2,
1281177008.8677_109.myhostname:2,
1281177008.8677_111.myhostname:2,
1281177008.8677_113.myhostname:2,
1281177008.8677_11.myhostname:2,
1281177008.8677_13.myhostname:2,
1281177008.8677_15.myhostname:2,
1281177008.8677_17.myhostname:2,
1281177008.8677_19.myhostname:2,
1281177008.8677_1.myhostname:2,
1281177008.8677_21.myhostname:2,
1281177008.8677_23.myhostname:2,

And for such names, git am determines that e.g.
"1281177008.8677_107.myhostname:2", should be applied before
"1281177008.8677_17.myhostname:2,", which is obviously wrong.

I'm not sure about what depends on string-list.c, but based on the
output of a raw grep, it doesn't seem like a good idea to change the
way strings are sorted, especially if almost noone uses Maildir for
patch series. The best solution IMO would be a Mutt hook to alter the
file names or something like that. A good workaround is configuring it
to use mbox as the default format and keep existing folders as Maildirs
(that's what I'm doing now). I guess the only file to patch in any case
is Documentation/SubmittingPatches, adding an entry for Mutt in the MUA
hints part (if possible with the renaming hook if someone knows how to
do that - I'll search a bit on my side - or with an explanation of the
issue and the simple mbox workaround).

-- 
Richard Braun
