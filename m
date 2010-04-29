From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git cherry(pick) dumps core
Date: Thu, 29 Apr 2010 22:21:39 +0200
Message-ID: <20100429202139.GW10879@inner.home.ulmdo.de>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com> <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com> <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com> <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com> <20100428233758.GA1654@progeny.tock> <20100429191150.GA10526@inner.home.ulmdo.de> <20100429194936.GA31941@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 02:59:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8138-0002jg-EY
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 02:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622Ab0EAA7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 20:59:06 -0400
Received: from continuum.iocl.org ([213.146.114.200]:61028 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab0EAA7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 20:59:01 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o3TKLd830757;
	Thu, 29 Apr 2010 22:21:39 +0200
Content-Disposition: inline
In-Reply-To: <20100429194936.GA31941@progeny.tock>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146072>

On Thu, 29 Apr 2010 14:49:36 +0000, Jonathan Nieder wrote:
> Hi Andreas,
...
> Thanks for the report.  What encoding were you using?  (You can check
> with ???git cat-file commit <revision you were trying to cherry-pick>???.)

Actually, it was both UTF-8, both by the defaults in get_message():

reencode_string (
    in=0x14d500 "tree 97cea0f57e06e719c9e7e38c3fc17022048b4f38\nparent 1ef1bb56e95284e683076f0d0cebe26e8ba02eca\nauthor Andreas Krey <a.krey@gmx.de> 1272557698 +0200\ncommitter Andreas Krey <a.krey@gmx.de> 1272557698 +02"..., out_encoding=0x1003f8 "UTF-8", 
        in_encoding=0x1003f8 "UTF-8") at utf8.c:434

I'd guess that in that case, reencode_string wouldn't need to
fire up iconv at all, and just copy the original string.

There being two different incarnations of iconv on this machine
isn't making anything easier. :-( Will report when I find out
what's wrong here. utf8 should be pretty universally known by now.

> In other words, this patch should fix the segfault, but it does not
> fix the underlying problem which was there before.

I was wondering whether to be or not to be, er, to just use
the raw message or to die in this case.

Andreas
