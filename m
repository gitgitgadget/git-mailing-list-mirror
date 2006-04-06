From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Wed, 05 Apr 2006 21:13:36 -0700
Message-ID: <7vfykrwdcf.fsf@assigned-by-dhcp.cox.net>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
	<Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
	<Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
	<fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 06:13:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRLsL-0004pl-C6
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 06:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWDFENj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 00:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDFENi
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 00:13:38 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16321 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932144AbWDFENi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Apr 2006 00:13:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060406041337.JAGX25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Apr 2006 00:13:37 -0400
To: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
In-Reply-To: <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com>
	(Kees-Jan Dijkzeul's message of "Wed, 5 Apr 2006 15:24:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18465>

"Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com> writes:

> I'm trying to get Git to manage my companies source tree. We're
> writing software for digital TV sets. Anyway, the archive is about 5Gb
> in size and contains binaries, zip files, excel sheets meeting minutes
> and whatnot. So it doesn't compress very well. The 1.5Gb pack file
> hardly contains any history at all (five commits or so). On the flip
> side, for now I'll be the only one adding to the archive, so at least
> it will not grow that fast ;-)
>
> Anyway, to reconstitute the tree, I need very nearly the entire pack,
> so limiting the pack size won't do much good, as git will still try to
> allocate a total of 1.5Gb memory (which, unfortunately, isn't there
> :-)

Right now we LRU the pack files and evict older ones when we
mmap too many, but the unit of eviction is the whole file, so it
would not help the case like yours at all.  It might be possible
to mmap only part of a packfile, but it would involve fairly
major surgery to sha1_file.c.
