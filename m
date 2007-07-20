From: Johan Herland <johan@herland.net>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 10:29:10 +0200
Message-ID: <200707201029.10358.johan@herland.net>
References: <85lkdezi08.fsf@lola.goethe.zz> <85d4yqz24s.fsf@lola.goethe.zz> <7vhco28aoq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 10:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBns6-00063b-06
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 10:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935395AbXGTI3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761565AbXGTI3k
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 04:29:40 -0400
Received: from sam.opera.com ([213.236.208.81]:59828 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937180AbXGTI3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 04:29:34 -0400
Received: from pc166.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l6K8TALf023296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 08:29:15 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <7vhco28aoq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3701/Fri Jul 20 00:52:18 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53069>

On Wednesday 18 July 2007, Junio C Hamano wrote:
> Didn't I say I do not have an objection for somebody who wants
> to track empty directories, already?  I probably would not do
> that myself but I do not see a reason to forbid it, either.
> 
> The right approach to take probably would be to allow entries of
> mode 040000 in the index.  Traditionally, we allowed only 100644
> (blobs as regular files) and 120000 (blobs as symlinks).  We
> recently added 160000 (commit from outer space, aka subproject).
> 
> And we do that for all directories, not just empty ones.  So if
> you have fileA, empty/, sub/fileB tracked, your index would
> probably have these four entries, immediately after read-tree
> of an existing tree object:

Sorry for jumping in late...

Why do you want to add _all_ directories, and not just the ones we want to 
explicitly track (independent of whether they're empty or not).

Basically, add a "--dir" flag to git-add, git-rm and friends, to tell them 
you're acting on the directory itself (rather than its (recursive) 
contents). "git-add --dir foo" will add the "040000 123abc... 0 foo" to the 
index/tree whether or not foo is an empty directory. "git-rm --dir foo" will 
remove that entry (or fail if it doesn't exist), but _not_ the contents of 
foo.

Since we're making directory tracking _explicit_, this should all be trivially 
backward-compatible.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
