From: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Wed, 5 Apr 2006 15:24:05 +0200
Message-ID: <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
	 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
	 <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 05 15:24:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR7zX-0001Us-BT
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 15:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWDENYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 09:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDENYI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 09:24:08 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:58814 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751106AbWDENYG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 09:24:06 -0400
Received: by pproxy.gmail.com with SMTP id i49so1084428pye
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 06:24:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sXki5PoblySGkXOG+GMmTARwxXX+xuMy4LuLYdiMCJca7ufIf1/X5zC7E7cPwqbxAQmUc+RWOWK6p29nhqMYEsoNVCspyeQWHQk26O7S38hmnpezFJHk1SXsJ9EmF9QZu8ACcQejo8WYJcaUZ6Vk7sY0powR91i7QUXEZMtt3EI=
Received: by 10.35.14.1 with SMTP id r1mr458463pyi;
        Wed, 05 Apr 2006 06:24:05 -0700 (PDT)
Received: by 10.35.124.20 with HTTP; Wed, 5 Apr 2006 06:24:05 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18430>

On 4/3/06, Linus Torvalds <torvalds@osdl.org> wrote:
[...]
> That's not hugely fundamental, but I didn't expect people to hit it this
> quickly. What kind of project has a 1.5GB pack-file _already_? I hope it's
> fifteen years of history (so that we'll have another fifteen years before
> we'll have to worry about 4GB pack-files ;)

I'm trying to get Git to manage my companies source tree. We're
writing software for digital TV sets. Anyway, the archive is about 5Gb
in size and contains binaries, zip files, excel sheets meeting minutes
and whatnot. So it doesn't compress very well. The 1.5Gb pack file
hardly contains any history at all (five commits or so). On the flip
side, for now I'll be the only one adding to the archive, so at least
it will not grow that fast ;-)

Anyway, to reconstitute the tree, I need very nearly the entire pack,
so limiting the pack size won't do much good, as git will still try to
allocate a total of 1.5Gb memory (which, unfortunately, isn't there
:-)

Inspired by a patch of Alex Riesen (thanks, Alex), I tried to use the
regular mmap for mapping pack files, only to discover that I compile
without defining "NO_MMAP", so I've been using the stock mmap all
along. So now I'm thinking that the cygwin mmap also does a
malloc-and-read, just like git does with NO_MMAP. So I'll continue to
investigate in that direction.

To be continued...

Groetjes,

Kees-Jan
