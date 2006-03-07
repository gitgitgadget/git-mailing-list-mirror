From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Tue, 7 Mar 2006 17:34:27 +0100
Message-ID: <20060307163427.GB4457@c165.ib.student.liu.se>
References: <20060305110351.GA23448@c165.ib.student.liu.se> <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net> <20060305123800.GD23448@c165.ib.student.liu.se> <7vveuseg2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Mar 07 17:35:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGf8p-0001Pl-Up
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 17:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWCGQe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 11:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWCGQe2
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 11:34:28 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:12416 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750801AbWCGQe2
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 11:34:28 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D89FA4115; Tue,  7 Mar 2006 17:49:54 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FGf8l-0001TF-00; Tue, 07 Mar 2006 17:34:27 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveuseg2u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17342>

On Sun, Mar 05, 2006 at 01:28:57PM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > I find the first format easier to read since everything is aligned (we
> > always output 15 characters for the committer's name padded with
> > spaces if necessary and the line numbers are padded appropriately). It
> > also takes up less space on screen since it doesn't use tabs.
> 
> Careful.  The convention for names is to encode them in UTF-8,
> so if you mean 15 "characters" that might be OK but if it can
> truncate in the middle of a multibyte sequence of UTF-8 encoded
> single character it is a no-no.
> 
> We are talking about "casual" aligning, so I would not bring up
> "proportional fonts", but even on a monospace terminal and
> line-printer output, there still is the issue of byte count not
> matching columns.  In an i18nized environment, aligning columns
> by counting bytes is a lost battle.
> 
> In any case, please make sure you do not chop a character in the
> middle at least [*1*].
> 

I hadn't thought of that. The code as it is now will occasionally do
the wrong thing when encountered with multibyte per code point
encodings. If we can assume that the name is in UTF-8 then the code
posted by "linux@horizon.com" to the list should do the trick.

However, can we assume that the name is in UTF-8? Do
i18n.commitencoding only apply to the commit message, or is it
intended to apply to the author/committer information too?

I am beginning to think that it might be best to, by default, store
the author, committer and commit messages in UTF-8. And then
automatically convert from/to the users locale on input/output. (I
just read the old "Rss produced by git is not valid xml?" thread where
this issue was discussed quite a bit. However, I didn't see the 'store
in UTF-8 by default and convert from/to users locale' method anywhere
in that thread.)

- Fredrik
