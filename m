From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 11:23:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708241119140.25853@woody.linux-foundation.org>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty> <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
 <86mywhfk17.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
 <1187979317.6357.155.camel@beauty>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Josh England <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOdpB-00049y-HZ
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 20:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623AbXHXSXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756922AbXHXSXp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 14:23:45 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54758 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755689AbXHXSXo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 14:23:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7OINcMo019557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Aug 2007 11:23:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7OINban008523;
	Fri, 24 Aug 2007 11:23:37 -0700
In-Reply-To: <1187979317.6357.155.camel@beauty>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56587>



On Fri, 24 Aug 2007, Josh England wrote:
> 
> Do you think its OK to cache this stuff in the index, though?
> write-tree could then just dump the perms/ownership out as gitattributes
> somewhere.

I'd really prefer not.

The index state - very much by design - matches the filesystem "stat" 
data, not the internal git data. So "ce_size" matches the checked-out 
size, not the native git data size (ie with CRLF conversion, it matches 
not the checked-in data, but the filesystem version). 

And the same really goes for ce_uid/ce_gid: they have to match what's on 
the filesystem, because they are used not to track user information, but 
to verify that the inode data is valid!

Yeah, we could just ignore them for checking "is the inode the same", but 
that would actually end up *defeating* the point of what you want to do: 
at that point, we'd also obviously ignore it when ownership changes!

			Linus
