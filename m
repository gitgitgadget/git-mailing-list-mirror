From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 14:16:01 +0300
Message-ID: <48D8CFF1.8030403@panasas.com>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mario Pareja <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki5tP-0003ft-MZ
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbYIWLQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYIWLQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:16:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:26674 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYIWLQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:16:06 -0400
Received: by ey-out-2122.google.com with SMTP id 6so571699eyi.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=e2Xr3toJpG1raCW1sR/swvKQsMvVOI3TPeXGBdViCV0=;
        b=g+ArsmYZTo42e+NDiBcuwvfndh/7y1zdFXsTikm7SHS1uIs+hHweMiCv89O9N80nHV
         lPdTtxO8HmDQeLG6Ihgvux4O+I0V2ABKrK86WZftFxFuOEMBErAnXIJU7rN56E0F5Wtg
         emQyRAdk1dQPE6p07L5DyNyUmIlVsZ8XfEZ+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=RAdARzpkRtn5vrgVs5GSo/GR7wR3V8l1PpdaLQqdeJo1jJzeG0nQUYTSRZPwiFPFnZ
         girBZmq7ETTplsxaoMDP0++THtv5mSRDySnQDSfKmH7ZXbBfutLish/pms7lUcvQknLw
         6OrxOD36hqtLOkETLB+EB/FfBXSDt5WgJLCJI=
Received: by 10.210.12.18 with SMTP id 18mr6460211ebl.191.1222168564948;
        Tue, 23 Sep 2008 04:16:04 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id 10sm2058502eyd.6.2008.09.23.04.16.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 04:16:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96547>

Mario Pareja wrote:
> Hi,
> 
> For one and a half years, I have been keeping my eyes on the git
> community in hopes of making the switch away from SVN.  One particular
> issue holding me back is the inability to lock binary files.
> Throughout the past year, I have yet to see developments on this
> issue.  I understand that locking files goes against the fundamental
> principles of distributed source control, but I think we need to come
> up with some workarounds.  For Linux kernel development this is may
> not be an issue; however, for application development this is a major
> issue. How else can one developer be sure that time spent editing a
> binary file will not be wasted because another developer submitted a
> change?
> 
> To achieve the effects of locking, a "central" repository must be
> identified.  Regardless of the distributed nature of git, most
> _companies_ will have a "central" repository for a software project.
> We should be able to mark a file as requiring a lock from the
> governing git repository at a specified address.  Is this made
> difficult because git tracks file contents not files?
> 
> In any case, I think this is a crucial issue that needs to be
> addressed if git is going to be adopted by companies with binary file
> conflict potential. I don't see how a web development company can take
> advantage of git to track source code and image file changes.  Any
> advice would be great!
> 
> Regards,
> 
> Mario
> --

It should be easy for a company to set a policy where a couple of scripts
must be run for particular type of files. Given that, the implementation
of such scripts is easy:

For every foo.bin there is possibly a foo.bin.lock file.

Lock-script look for absence of the lock-file at upstream then git-add
the file (With some info that tells users things like who has the file).
If git-push fails, since I'm adding a file and someone already added
it while I was pushing, then the lock is not granted.

Unlock-script will git-rm the lock-file and push.

In both scripts mod-bits of original file can be toggled for
read-only/write signaling to the user. (At upstream the file is always
read-only)

This can also work in a distributed system with more then one tier of
servers. (Locks pushed to the most upstream server)

Combine that with git's mail notifications for commits and you have a
system far more robust then svn will ever want to be

My $0.017
Boaz
