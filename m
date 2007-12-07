From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 19:01:57 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net> 
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>  <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com> <1196995353.22471.20.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 04:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0TUe-0003OM-0q
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 04:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbXLGDCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 22:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbXLGDCo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 22:02:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44895 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754745AbXLGDCm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 22:02:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB731w6G018385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Dec 2007 19:01:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB731vNI026873;
	Thu, 6 Dec 2007 19:01:58 -0800
In-Reply-To: <1196995353.22471.20.camel@brick>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67370>



On Thu, 6 Dec 2007, Harvey Harrison wrote:
> 
> I've updated the public mirror repo with the very-packed version.

Side note: it might be interesting to compare timings for 
history-intensive stuff with and without this kind of very-packed 
situation.

The very density of a smaller pack-file might be enough to overcome the 
downsides (more CPU time to apply longer delta-chains), but regardless, 
real numbers talks, bullshit walks. So wouldn't it be nice to have real 
numbers?

One easy way to get real numbers for history would be to just time some 
reasonably costly operation that uses lots of history. Ie just do a 

	time git blame -C gcc/regclass.c > /dev/null

and see if the deeper delta chains are very expensive.

(Yeah, the above is pretty much designed to be the worst possible case for 
this kind of aggressive history packing, but I don't know if that choice 
of file to try to annotate is a good choice or not. I suspect that "git 
blame -C" with a CVS import is just horrid, because CVS commits tend to be 
pretty big and nasty and not as localized as we've tried to make things in 
the kernel, so doing the code copy detection is probably horrendously 
expensive)

			Linus
