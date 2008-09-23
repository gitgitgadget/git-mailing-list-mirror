From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Locking binary files
Date: Wed, 24 Sep 2008 00:46:16 +0400
Message-ID: <20080923204616.GS21650@dpotapov.dyndns.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com> <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se> <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Mario Pareja <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiEnO-0003Ln-5N
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYIWUqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbYIWUqX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:46:23 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:57520 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbYIWUqW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:46:22 -0400
Received: by ey-out-2122.google.com with SMTP id 6so672599eyi.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hJ5voK6SEcjd72xMTg0kVSNCwLHikFwHCCBtuDV3s28=;
        b=IihqpDPAupSRXOpXJbOaU1nXoBPMjLbn54I4djmIs6T2gPMHQ+q3gxUixqpOTMdja9
         QHr7oMLEWtOibNQaVaT/Ozz/yBcYrtsXIsvnWYy1WQj5vs3T9PE5/tJpCK9g5I4rgdld
         ZQ5sWw+KhrDdtPibmPcuYr4RIYRXqi0BwW74w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cWkBzjgZMVWGJwE7IX0ozMKO+ABdFLn4eyUpXDSn8V5PVcmxh+aTBy6L1xjHDyNlj0
         UMsD0J/iVQy7stQyZSC0uPDeSyECX1FMwTVaNT23YMbl8VDln0tTDECW9U66xEUCdlf1
         I14qPpA2k4U9/tpsDJmGfGzSO+gedb5gG48+4=
Received: by 10.210.104.20 with SMTP id b20mr7232192ebc.30.1222202780241;
        Tue, 23 Sep 2008 13:46:20 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id 10sm3504499eyd.6.2008.09.23.13.46.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 13:46:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96592>

On Tue, Sep 23, 2008 at 09:56:57AM -0400, Mario Pareja wrote:
> 
> The SVN client will make locked files read-only until a lock is
> obtained for them.  This helps "remind" you that a lock should be
> obtained before editing such a file. Requiring the developer to obtain
> a lock ensures that nobody else is editing the file and prevents
> wasted work.  Upon commit, the file is marked as unlocked and the
> local file is once again read-only.

The approach that SVN takes is not only impossible for distributed
environment, it does not work even in a _single_ repository where you
have branching and merging. If you have a topic branch then your lock
will have a zero effect on other developers or lock of other developers
on you. Obviously, you are going to have the binary merge conflict at
the end. But it is even worse than that. Somebody locked a file on the
master branch and you clone from it. Now, this somebody unlocked this
file, but this file on your branch remains locked but this person, and
this person may even not aware that about your branch. That is insane!

Dmitry
