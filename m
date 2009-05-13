From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 14:20:27 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905131410260.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net> <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain> <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
 <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain> <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com> <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain> <20090513210425.GD6579@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 23:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Lsb-0005hu-Rs
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbZEMVUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZEMVUe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:20:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57999 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbZEMVUe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 17:20:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DLKSVd021305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 14:20:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DLKRex002512;
	Wed, 13 May 2009 14:20:28 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090513210425.GD6579@mit.edu>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119107>



On Wed, 13 May 2009, Theodore Tso wrote:
> 
> Stupid question --- if we get something that works for Windows and
> MacOS X, is there any reason why we need to solve the general problem
> of case-insentive filesystems?

Qutie frankly, I don't think we're even very close to getting anything 
that works for Windows of OS X.

Case-insensitivity is _hard_.

The "easy" case is to just handle the OS X craxy pseudo-NFD format, and at 
least turn that into NFC (and perhaps add a config option to do latin1 and 
EUC-JP to utf-8 too) and. At that point, we at least handle regular utf-8 
the same way.

Doing the latin1/EUC-JP thing would actually to some degree be more 
interesting than the OS X NFD case, because that really does require 
two-way conversion, and we can "test" that even on sane filesystems (ie 
play at having a Latin1 filesystem).

That said, I suspect there aren't that many people who care about latin1 
filesystems. I dunno about EUC-JP (and variants - for all I know, 
shift-JIS and other cases may be the more common ones).

Of course, if we do everything right, maybe the windows people would 
actually like us to keep the filesystem-native representation in UTF-16LE 
or whatever the crazy format is that Windows really uses deep down.

My point being that all of these things happen even without the added 
worry about case. And in many ways, not worrying about case should 
probably be the first step. We do have some support for worrying about 
case, but trying to solve both things at the same time isn't going to be 
workable, I suspect.

Case insensitivity should never ever involve a _conversion_ (if it does, 
you get all kinds of crazy behavior), it's just purely a _comparison_ 
issue, so the two really are fundamentally different.

Of course, the reason OS-X seems to be so messed up is exactly that the 
morons at Apple didn't understand the difference between conversion and 
comparison, and mixed them up.

		Linus
