From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 13:37:12 -0700 (PDT)
Message-ID: <20050925203712.48240.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 22:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJdFb-0008WI-Po
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 22:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVIYUhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 16:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVIYUhP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 16:37:15 -0400
Received: from web26305.mail.ukl.yahoo.com ([217.146.176.16]:21608 "HELO
	web26305.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932284AbVIYUhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 16:37:14 -0400
Received: (qmail 48242 invoked by uid 60001); 25 Sep 2005 20:37:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xRT+aJqz+HbJN+ohKT8G4v6aKSbsabLKzHpr/JyoaUMe9Lo/GVIYTD89im35IR5jmUsazERR5j7OeoVtU144Q3Cf26Jxv4yMBokbllAB+XEnPAYXxFCCfuc2KG3JKiPBQgX62GGVMsvv6+qo644aWuD77y6Ctb1d81TESwU4GnY=  ;
Received: from [151.42.224.4] by web26305.mail.ukl.yahoo.com via HTTP; Sun, 25 Sep 2005 13:37:12 PDT
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9284>

Josef Weidendorfer wrote:

>Hi,
>
>On Sunday 25 September 2005 07:52, Marco Costalba wrote:
>
>>>* The commit time is relative to now, which makes no sense to me. Also,
>>>it is in the second column instead of the last one like in gitk, which
>>>seems better to me. At least, the column is too narrow and then it
>>>blends together with the commit title.
>
>
>I vote for absolute time, and the date column at the end, too.


...and 'date column at the end' wins for 3 votes against 0 ;-)


>Besides, QT allows to reorder the columns with the mouse (the order should be
>saved in a config file at end to be persistant over program runs).
>

Yes, good idea.

>>>* Getting to the diff view was non-obvious for me. It'd be nice to have
>>>some [diff] button as well somewhere. Or you could also show the diff in
>>>the bottom part of screen in the commit view, I think gitk solved this
>>>nicely.
>>
>>I have tought a lot how to pass to the user the information that to see a
>>diff you have to double click on the commit:
>
>
>I like the gitk solution better. 
>What about making the commit list a QDockWindow, which can be docked to either 
>side of the window (default: top as currently), but also made a floating 
>window, so that the commit diff gets the whole main window?
>

Should be nice, but it's a bit of work...maybe I don't know very well QDockWindow.

Peraphs is the commit info pane at the bottom left that could be implemented as a 
QDockWindow with the diff attached below the commit info gitk like.....


>
>I think that diagonal lines as in gitk make it way easier to get an overview.
>What makes drawing of diagonal lines slow?

with diagonal line you cannot draw graphs one rev at the time from left to right but you
need some information from previous one and eventually pass some information to next one.

The fact is diagonal lines are originated in a diffrent line from what you are drawing and
you need to bring with you that piece of information.

More, in qgit pixmaps are precalculated in main view ctor and filled in an array, so only 
array indexing is used to retrive and copy correct pixmap according to proper lane type.

Adding diagonals pixmaps is not obvious and not simple, at least for me. I tell you this 
because I have tried but the design of graph function became overly complex.


>It should be quite fast to subclass QListViewItem for commit entries and
>overwrite QListViewItem::paintCell to use your own drawing; paintCell is 
>called for visible entries only.
>

QListViewItem is already subclassed to paint odd/even lines background and tags/heads colors.
Pixmaps are not painted but, as told before, directly copied from a fixed pixmaps array this 
is also done in paintCell(). See ListViewLogItem::paintCell() in mainimpl.cpp if interested.

Because paintCell() is called for visible entries only, also commit line setup (columns text,
relative time calculation, tagging, etc) is done in paintCell() the first time item became
visible. So to push to the limit the 'lazy setup' policy and gain speed.


>Another wish: The tag/head markers in gitk are really good. In qgit, I only 
>get another background color, and miss the name.

You can see the name in the status bar when you select the item. Also the refs names are 
cumulative, i.e. if you select a tag that is also a branch head and, eventually also another kind
of ref, all this information is shown in the status bar. 

Status bar has more avaiable space then inline marker this is the reason I chose that way.

>
>Yes, really nice.
>

Thanks

Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
