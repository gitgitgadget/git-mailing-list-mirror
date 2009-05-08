From: Jeff King <peff@peff.net>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Fri, 8 May 2009 03:01:19 -0400
Message-ID: <20090508070119.GA12989@coredump.intra.peff.net>
References: <86prekfv7z.fsf@blue.stonehenge.com> <20090508023028.GA1218@coredump.intra.peff.net> <4A03D6E2.2050708@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 08 09:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2K5H-0004DH-33
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbZEHHBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbZEHHBT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:01:19 -0400
Received: from peff.net ([208.65.91.99]:59767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbZEHHBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 03:01:19 -0400
Received: (qmail 16620 invoked by uid 107); 8 May 2009 07:01:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 May 2009 03:01:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2009 03:01:19 -0400
Content-Disposition: inline
In-Reply-To: <4A03D6E2.2050708@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118571>

On Fri, May 08, 2009 at 08:53:22AM +0200, Andreas Ericsson wrote:

>> (2b) is a bit harder, but do-able:
>>
>>   git diff-tree --name-only HEAD $upstream | sort >them
>>   (git diff-files --name-only; git diff-index --name-only) | sort >us
>>   test -z "`comm -12 us them`"
>>
>> (2c) is the trickiest (and of course, therefore probably the one you
>> want ;) ).  I'm not sure there is a simple way to do it short of hacking
>> git-merge to actually try the merge and roll it back. Because you really
>> have to deal not just with merging actual text file content but with
>> custom merge drivers.
>>
>
> The "rolling back" part is about as simple as
> * never touch the worktree (only use in-index merge)
> * preserve the last HEAD commit object name
> * preserve the index

If you are just doing in-index merge, then (2b) works fine. You know you
aren't doing any file-level merging. The advantage of (2c) is that
non-conflicting merges in files would are "safe".

-Peff
