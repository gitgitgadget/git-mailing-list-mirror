From: Toby White <tow21@cam.ac.uk>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 13:10:47 +0000
Message-ID: <47442E57.8010004@cam.ac.uk>
References: <47440912.8010800@cam.ac.uk> <20071121112757.GA17231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IupMJ-0006W9-Re
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbXKUNK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbXKUNK5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:10:57 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:45026 "EHLO
	ppsw-8.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbXKUNK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:10:56 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from sloth.niees.group.cam.ac.uk ([128.232.232.33]:52642)
	by ppsw-8.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
	with esmtp id 1IupLw-0003Kk-RQ (Exim 4.67)
	(return-path <tow21@cam.ac.uk>); Wed, 21 Nov 2007 13:10:52 +0000
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <20071121112757.GA17231@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65644>

Jeff King wrote:

> Have you looked at the documentation for GIT_EXTERNAL_DIFF (try git(7))?
> I think it is a cleaner way of doing what you want (although I think you
> will get each file diffed individually, which is perhaps not what you
> want).
> 
> Something like:
> 
> $ cat >merge.sh <<EOF
> #!/bin/sh
> opendiff "$1" "$2"
> EOF
> $ GIT_EXTERNAL_DIFF=./merge.sh git-diff ...

I hadn't seen that, no, but that's not quite right.
(Wincent pointed out its flaws better than me. Basically,
opendiff is not really diff-like enough.)

And in any case, that launches Filemerge repeatedly
on every file separately, which makes reviewing a large diff
time-consuming and not very helpful.

> write-tree? Yikes. If you want to diff against the working tree, then do
> that. If you want to diff against the index, then you probably want to
> git-checkout-index to a tmpdir, and diff against that.

Am I misunderstanding the documentation? From man git-write-tree

"Conceptually, git-write-tree sync()s the current index contents into a
  set of tree files. In order to have that match what is actually in your
  directory right now, you need to have done a git-update-index phase
  before you did the git-write-tree."

So git-write-tree precisely does give you the index not the working tree,
by my reading.

>> git-archive --format=tar $OLD | (cd $TMPDIR1; tar xf -)
> 
> Again, this could be simpler and faster by using git-checkout-index
> (preceded by git-read-tree into a temp index, if you are comparing
> against a tree).

Erm, ok, this is rapidly approaching the limit of my git knowledge,
but while I can see git-read-tree will write a tree-ish into a temp
index,

(so presumably
git-read-tree --index-output=$TMPFILE <commit>
ought to work. Except it doesn't, I get the error message
fatal: unable to write new index file
),

I can't see how to make git-checkout-index read from a temp index.

And I'm assuming I don't want to go stomping all over the current
index just in order to do a diff, which shouldn't change the state
of my repository.

Is there a canonical way to checkout a given commit object into
a fresh directory?

-- 
Dr. Toby O. H. White
Dept. Earth Sciences,
Downing Street,
Cambridge CB2 3EQ
United Kingdom

Tel: +44 1223 333464
Fax: +44 1223 333450
Web: http://uszla.me.uk
