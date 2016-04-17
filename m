From: Andreas Mohr <andi@lisas.de>
Subject: Re: [BUG] git rev-parse :/ "regex" syntax not really regex?
Date: Sun, 17 Apr 2016 17:54:40 +0200
Message-ID: <20160417155440.GA4817@rhlx01.hs-esslingen.de>
References: <20160417133741.GA28931@rhlx01.hs-esslingen.de>
 <87inzgtjfv.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Mohr <andi@lisas.de>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:54:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arp29-0007UO-8I
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 17:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbcDQPym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 11:54:42 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:52104 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcDQPyl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 11:54:41 -0400
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id 28D40456D6; Sun, 17 Apr 2016 17:54:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87inzgtjfv.fsf@linux-m68k.org>
X-Priority: none
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291763>

On Sun, Apr 17, 2016 at 04:10:28PM +0200, Andreas Schwab wrote:
> Andreas Mohr <andi@lisas.de> writes:
> 
> > Unless I happened to misunderstand git's regex flavour, or something else...
> > (hmm, perhaps it's a try-match-single-line vs. multi-line content issue,
> > which perhaps does not work by specifying the trailing $)
> 
> This is exactly the difference.  git log --grep matches individual lines
> (like grep), whereas :/<regexp> matches against the whole commit message
> including embedded (and trailing) newlines, and $ doesn't match an
> embedded newline.  Thus to address the second commit in your example you
> have to use $':/^My commit\n' (using bash's ANSI-C quoting feature).

At first I thought "no way, I already did try trailing \n",
but then I realized that
it's exactly use of that ANSI-C quoting feature
which makes that \n newline be (non-)interpreted correctly here,
and it truly works.

Thank you for a fast and well-inform{ed|ing} response!

Now there's only one question remaining:
do we simply take this as a documentation-supplied-by-mailing-list item ;-),
or should certain parts of the parse-rev :/ documentation
be improved in a certain manner?


No, there's another one:
this syntax seems to be (as indicated) indeed bash-specific,
since a short dash test script (POSIX):
#!/usr/bin/dash

git rev-parse $':/^My commit\n'

simply prints a
$:/^My commit\n
result,
and no amount of syntax fiddling
succeeded in getting the correct commit result on dash.

Well, since that \n simply *is* a newline
(see also
http://unix.stackexchange.com/questions/155367/when-to-use-bash-ansi-c-style-escape-e-g-n ),
a successful way to encode it in dash (all non-bash shells?) is:

git rev-parse :/'^My commit
'

i.e. with an *actual* newline.


BTW, as a (albeit weak) former m68k architecture user,
thank you for your efforts!

Andreas Mohr
