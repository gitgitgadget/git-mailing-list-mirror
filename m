From: Dan Zwell <dzwell@gmail.com>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Tue, 02 Oct 2007 22:17:41 -0500
Message-ID: <470309D5.702@gmail.com>
References: <47029414.3080100@gmail.com> <7vbqbhl44h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 05:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icukd-0004MB-GG
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 05:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbXJCDSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 23:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbXJCDSK
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 23:18:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:36318 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbXJCDSG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 23:18:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so5252979wah
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 20:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=MbjwF6B2Wf/8jgqDWX0Cn7mXTmtR3X+Ne710NXNDty8=;
        b=qqxz3ucaVuoUY9NYlCWKDQrggRFxyPpwtkOJT7HDVL6Lp6V+IJ8TVOJtuvd3ROSBTD/zcIcon1Aons97JaqARalCZ2YolIbHNJlC8lEpXBz2Cmohr3Hq2iXWzHcGtSVTFJ0ykkz2kIo70IP23UT5ocRkwhgzV1ByKiUOmvLL35E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=npjxpcKpj52Vg2y7rvvYimKKzKf8BQqGR8s17tcZQAZrH5SWYWQrIMIM3pTsw15WQh9j6PXiU8BfW425gjha4LGQUrFBEar9cxLZBzLKwrLq+XX+spZMVDQMaSBFZVZJf3khkCw+h1IuFMIbMxMLXqEQQhuRAJTr7vex3lMlxgI=
Received: by 10.114.12.9 with SMTP id 9mr3843859wal.1191381485880;
        Tue, 02 Oct 2007 20:18:05 -0700 (PDT)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id 38sm144994nza.2007.10.02.20.18.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Oct 2007 20:18:05 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070922)
In-Reply-To: <7vbqbhl44h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59773>

Junio C Hamano wrote:
 > Dan Zwell <dzwell@gmail.com> writes:
 >
 >> ... It is the same after I commit the new changes--at that point,
 >> "git-diff-tree HEAD^ HEAD -p" spits out a nice patch, but "git-diff
 >> HEAD^ HEAD" gives nothing.
 >
 > This part is most interesting.  They are both about comparing
 > two commits and do not interact with anything in the work tree
 > nor your index.
 >
 > ... Can you bisect it?
 >
I bisected twice to be sure, and have CC'd Martin Waitz on this (the 
issue is that some of my changes in a local repo are not being displayed 
by git-diff, either before or after they are committed, but git-status, 
git-whatchanged, and git-diff-tree all see that changes have been 
committed, and git-diff-files does see uncommitted changes).

e88ee2915493213ea0d0be64c542c090fefd4b33 is first bad commit
commit e88ee2915493213ea0d0be64c542c090fefd4b33
Author: Martin Waitz <tali@admingilde.org>
Date:   Tue Oct 10 21:16:25 2006 +0200

     paginate git-diff by default

I discovered this problem on my 64 bit machine, but the problem does not 
occur on my 32 bit machine. That is not the only difference between the 
two computers, but it seems the most obvious culprit. The 64 bit machine 
may have different libraries than the other, as they are running 
different distros.

I noticed that this is a rather old (and very small) patch, and I don't 
quite understand how it could cause this problem. I could not revert the 
patch to fix the problem. I placed a stripped down version of the 
repository here: http://zwell.net/git-error.tar.gz. The problem is very 
easy to observe on my machine, though it looks like some machines do not 
exhibit it. What else can I do to help?

Dan
