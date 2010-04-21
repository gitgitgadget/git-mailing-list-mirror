From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Add warning when there are changes in the index and using -a with  	git commit
Date: Wed, 21 Apr 2010 17:31:08 -0400
Message-ID: <19407.28316.959251.348645@winooski.ccs.neu.edu>
References: <v2m7fce93be1004211320r9adc0b14j11bd06c3b045e639@mail.gmail.com>
	<q2pfabb9a1e1004211421q80d273ady11f4621284522c46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:31:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hW8-0008Km-5z
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab0DUVbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:31:13 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:35000 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755252Ab0DUVbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:31:12 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O4hVk-00008F-VL; Wed, 21 Apr 2010 17:31:08 -0400
In-Reply-To: <q2pfabb9a1e1004211421q80d273ady11f4621284522c46@mail.gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145461>

On Apr 21, Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Apr 21, 2010 at 22:20, Sylvain Rabot <sylvain@abstraction.fr> wrote:
> > Many times I had the bad reflex of doing a git commit -as -m "blah
> > blah" when I was willing to commit only things I had staged in the
> > index.
> 
> Me too, and I think I brought it up in the past and it was dismissed
> as being too annoying, but I'm not sure. Either way, you can work
> around it by creating your own 'git-co' wrapper that does the check
> and use that instead of 'git commit'.

I recently wrote a very quick script that I think is much better at
doing what svn users expect, but doesn't get in the way of doing more
git-ish things when they learn more git in the future.  IMO it works
much better than the frequent advice I've seen in many places to just
add `-a' to `git commit'.  The only thing that this does is add "." if
there are no other paths mentioned as arguments.  Looks like in this
case git will add all files in the current directory, and commit them
together with staged content in this directory -- which I think covers
everythint that svn does.  I dropped this in my path as `git-ci':

  #!/bin/sh
  seen_path=no; for p; do if [ -e "$p" ]; then seen_path=yes; fi; done
  if [ $seen_path = yes ]; then git commit "$@"; else git commit . "$@"; fi

(Disclaimer: naive check, so if someone uses "git ci -m ." it will get
confused.  But it adds the "." in the beginning, so typos like
"git ci -m" don't get broken.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
