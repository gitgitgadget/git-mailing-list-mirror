From: linux@horizon.com
Subject: Re: Cygwin can't handle huge packfiles?
Date: 6 Apr 2006 23:05:48 -0400
Message-ID: <20060407030548.22399.qmail@science.horizon.com>
References: <7vk6a2uupy.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 05:06:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRhIY-0001W0-RB
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 05:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWDGDF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 23:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDGDF5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 23:05:57 -0400
Received: from science.horizon.com ([192.35.100.1]:11597 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932301AbWDGDF5
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 23:05:57 -0400
Received: (qmail 22400 invoked by uid 1000); 6 Apr 2006 23:05:48 -0400
To: junkio@cox.net, linux@horizon.com
In-Reply-To: <7vk6a2uupy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18490>

> I do not think that would help the original poster's situation
> where only 5 revs result in a 1.5G pack.  I would _almost_ say
> "do not pack such a repository", but there is the initial
> cloning over git-aware transports which always results in a
> repository with a single pack.

Huh?  Why not?  That repository has a lot of files.  For compression,
you want all versions of a file in one pack, and with few versions that
makes it easier to split up, not harder.

As for network transport of packs, I haven't studied the details,
but if you allow "thin packs" that have deltas relative to
objects not in the pack, then breaking up the pack anywhere
should be legal.

Or, if necessary, you can stuff an arbitrarily large file through
git-unpack-objects, which reads a stream from stdin without
attempting to mmap it.


(Speaking of unpack-objects.c, what's that "static unsigned long eof"
variable in there?  It never seems to be set to a non-zero value.)
