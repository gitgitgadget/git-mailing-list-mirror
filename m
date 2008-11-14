From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 09:31:09 -0500
Message-ID: <f73f7ab80811140631h44f0c712h5656cd6664d91380@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <20081112173651.GA9127@linode.davidb.org>
	 <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
	 <loom.20081113T174625-994@post.gmane.org>
	 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
	 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"James Pickens" <jepicken@gmail.com>,
	"Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 15:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0zii-0000am-QA
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 15:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYKNObN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 09:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYKNObM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 09:31:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:28057 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYKNObL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 09:31:11 -0500
Received: by yx-out-2324.google.com with SMTP id 8so627035yxm.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 06:31:10 -0800 (PST)
Received: by 10.100.128.2 with SMTP id a2mr497905and.93.1226673069948;
        Fri, 14 Nov 2008 06:31:09 -0800 (PST)
Received: by 10.100.38.13 with HTTP; Fri, 14 Nov 2008 06:31:09 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100977>

On Thu, Nov 13, 2008 at 8:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>  - It would be really cool to find some way to automatically notice when
>   the tree is hot-cached and we might as well just be linear. I don't
>   know exactly what it might be, but one of the nice things is that the
>   preloading is _entirely_ optimistic, and we could just stop it in the
>   middle if we notice that there's no upside.

Perhaps, rather... notice when the tree is *cold*-cached.  At that
point you're already in a pseudo-slowpath and starting several threads
won't be noticeable at all compared to the time savings.  You could
probably very easily do that by keeping track of the time as you start
with the normal single-threaded scan of directory entries.  If the
entries are all equally slow/fast, there most likely won't be any
benefit at all to spawning extra threads.  You might use some cutoff
on number of entries to test before you assume everything is hot and
stop worrying about the time.  If there's a lot of variability in the
first few thousand then it means some caches are cold and spawning
extra threads will probably help.

Cheers,
Kyle Moffett
