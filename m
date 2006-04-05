From: Christopher Faylor <me@cgf.cx>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Wed, 5 Apr 2006 17:08:44 -0400
Message-ID: <20060405210844.GN26780@trixie.casa.cgf.cx>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com> <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org> <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org> <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com> <Pine.LNX.4.63.0604051612200.25304@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 05 23:09:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRFFS-0003gi-Gt
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 23:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWDEVIr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 17:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWDEVIr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 17:08:47 -0400
Received: from pool-71-248-179-247.bstnma.fios.verizon.net ([71.248.179.247]:65414
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1751081AbWDEVIr
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 17:08:47 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 6A0AA13C08F; Wed,  5 Apr 2006 17:08:44 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0604051612200.25304@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18454>

On Wed, Apr 05, 2006 at 04:14:20PM +0200, Johannes Schindelin wrote:
>> Inspired by a patch of Alex Riesen (thanks, Alex), I tried to use the
>> regular mmap for mapping pack files, only to discover that I compile
>> without defining "NO_MMAP", so I've been using the stock mmap all
>> along. So now I'm thinking that the cygwin mmap also does a
>> malloc-and-read, just like git does with NO_MMAP. So I'll continue to
>> investigate in that direction.
>
>I think cygwin's mmap() is based on the Win32 API equivalent, which could 
>mean that it *is* memory mapped, but in a special area (which is smaller 
>than 1.5 gigabyte). In this case, it would make sense to limit the pack 
>size, thereby having several packs, and mmap() them as they are needed.

Yes, cygwin's mmap uses CreateFileMapping and MapViewOfFile.  IIRC,
Windows might have a 2G limitation lurking under the hood somewhere but
I think that might be tweakable with some registry setting.

cgf
