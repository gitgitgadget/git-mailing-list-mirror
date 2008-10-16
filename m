From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Thu, 16 Oct 2008 22:32:56 +0200
Message-ID: <48F7A4F8.2080600@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>	 <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>, git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:34:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZXy-0002do-QK
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbYJPUdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYJPUdB
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:33:01 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:49946 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753943AbYJPUdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:33:00 -0400
Received: (qmail 3519 invoked from network); 16 Oct 2008 20:32:58 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 16 Oct 2008 20:32:58 -0000
Received: (qmail 27701 invoked from network); 16 Oct 2008 20:32:57 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 16 Oct 2008 20:32:57 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98421>

Richard Hartmann wrote:
> On Thu, Oct 16, 2008 at 13:56, Garry Dolley <gdolley@arpnetworks.com> wrote:
>
>   
>> I know from an external point of view, it seems pulling a subdir
>> wouldn't be a big deal; but if you look at git internals, you start
>> to realize why it's an option that isn't on the table.
>>     

Hm, I don't see a fundamental technical problem which would prevent one 
from implementing the ability to checkout only a subdirectory into the 
working directory (i.e. to add options to Git to make it reflect the 
working directory as being a subdirectory of what is in Git's database). 
At this level I don't see anything inherently different from SVN--except 
maybe for directory renames: if someone else is renaming the directory 
you've checked out, what should happend with your checkout? Git's 
filebased rename tracking would just lead to everything vanishing from 
your checkout. I don't know what happens in SVN, maybe it keeps track of 
the directory rename and still sends you the changes of the directory 
you've checked out even if it has now a different name on the server?

Anyway, an unavoidable difference is that you have to always clone the 
whole Git *database*. With SVN the database stays on the server, with 
Git it is being cloned. Just as I expect SVN to need the whole database 
to be able to work (tracking renames across directories etc.), Git needs 
the whole database too. So implementing subdirectory workingdir 
checkouts wouldn't help reduce the bandwidth and storage necessary for 
getting at the database.

>
> That's my understanding as well. And you can simply branch
> out a subdir when you want to work on it.
>   

I guess what you are referring to is

 $ git clone git://foo.com/bar.git
 $ cd bar
 $ rm -rf *
 $ git checkout somesubdir

Now you've got only somesubdir/ below bar/. This solves the rename 
problem insofar, as somesubdir will just be renamed if someone else 
commits a "git mv somesubdir somethingelse" and you pull that change. 
But there's also another caveat: "git status" will of course report the 
other files as deleted, which is an accident waiting to happen when you 
next run "git commit -a".

(In any case, this is just thinking louder than I deserve, as there's no 
code at all in Git written by me.)

Christian.
