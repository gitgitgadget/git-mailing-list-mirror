From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitk (or tcl/tk) slow to start?
Date: Mon, 17 May 2010 22:27:24 -0400
Message-ID: <19441.64268.762782.215315@winooski.ccs.neu.edu>
References: <19441.8527.606063.296769@winooski.ccs.neu.edu>
	<4BF12DA6.9090709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 18 04:27:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OECWq-0000JW-2D
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 04:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab0ERC10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 22:27:26 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:32999 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149Ab0ERC10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 22:27:26 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OECWi-0003zm-Oy; Mon, 17 May 2010 22:27:24 -0400
In-Reply-To: <4BF12DA6.9090709@drmicha.warpmail.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147270>

On May 17, Michael J Gruber wrote:
> Eli Barzilay venit, vidit, dixit 17.05.2010 12:58:
> > Every time I run gitk when I didn't use it for a while, it takes a
> > long time to start (more than 30 seconds) with no visible cpu load.  I
> > tried to strace it, and the result shows that the time is spent
> > stat()ing my whole /usr/lib directory:
> > 
> >   ...
> >   stat("/usr/lib/libelf-0.131.so", {st_mode=S_IFREG|0755, st_size=87496, ...}) = 0
> >   stat("/usr/lib/libungif.so.4", {st_mode=S_IFREG|0755, st_size=2444, ...}) = 0
> >   stat("/usr/lib/libtiff.so.3.8.2", {st_mode=S_IFREG|0755, st_size=360268, ...}) = 0
> >   ...
> > 
> > Is this expected?  Anything that can be done to avoid it?
> 
> I don't expect stat'ing /usr/lib to take 30s. How large is it (file
> size and count)?

I've done some more counting -- the most number of system calls (as
tracked by strace) are 2968 reads, 4582 lstats, and 6520 stats.  And
it looks like it's recursively scanning /lib, /usr/lib, and /usr/share
for all *.tcl files.  stracing `wish' shows 11000 l/stats -- so I
guess that the problem is there and not in gitk.  Trying wish on a
fedora 12 machine, I see only ~350 {,f,l}stat64 calls, and gitk starts
as fast as I'd expect it to.

Oh well, I was hoping that someone knows some bit that needs flipping
or updating to get it to work faster -- I guess it's one more reason
to finally upgrade the F7 machine...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
