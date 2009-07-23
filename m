From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 04:02:38 +0200
Message-ID: <20090723020238.GA8948@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain> <alpine.LFD.2.01.0907221753290.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 04:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTnfC-00029W-Po
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 04:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZGWCD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 22:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbZGWCD6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 22:03:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:32357 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZGWCD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 22:03:57 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1018329fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wzOyQxoCrIbfyUW4QR+VpZYx+rbCVWVMdW6IrA7ZeYo=;
        b=VRTXzA3tY5APz8gPGQyT8PcjK2mRigiIkEofpr71rA/vWshRKtYxOpBEFz4WgotD7M
         foitQZZneP5XFH3BZK44D0o/jpYkie3OO9RfqiQPeEABRFerrPnZYgYC8DZwroMfgSFv
         SGh2+U/DYTe9Qq9XLRjCeClKquaEUcDZmyUYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N3U1E+AT6AjXocm9NdSNyOkGMmF2YxN46WJfAM3AuhQFdm4JmiUUG1vukl1mexrFRR
         tRZFBSLp13U9MOrTRK3ZhWEBfOhPsz/+Q7CbXPt1GZmyqFk/tkzBFkv8H/AWFlWRbzyM
         TnwneAxhxJN8b6HNaU8DMJeqjteVdp0NJtrOA=
Received: by 10.86.84.12 with SMTP id h12mr1394849fgb.21.1248314636578;
        Wed, 22 Jul 2009 19:03:56 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.18])
        by mx.google.com with ESMTPS id d6sm2468284fga.10.2009.07.22.19.03.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 19:03:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907221753290.3352@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123820>

On Wed 22.Jul'09 at 17:55:51 -0700, Linus Torvalds wrote:
> On Wed, 22 Jul 2009, Linus Torvalds wrote:
> > 
> > If you have ext3, you'd do something like
> > 
> > 	tune2fs -O dir_index /dev/<node-of-your-filesystem-goes-here>
> 
> One last email note on this subject. Really. Promise.
> 
> If you do that "tune2fs -O dir_index" thing, it will only take effect for 
> _newly_ created directories. So you'll still need to do that whole 
> "mv+cp+rm" dance, just to make sure that the refs directories are all new.

Ok, now I also did the "dir_index" thing followed by the mv+cp+rm instructions.
It doesn't change the 3.5 secs delay in that single line,

1248313742.355195 lstat(".git/refs/heads/sparse", 0x7fff0c663ab0) = -1 ENOENT (No such file or directory)
1248313742.381178 lstat(".git/refs/heads/stern", 0x7fff0c663ab0) = -1 ENOENT (No such file or directory)
1248313745.804637 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0

Just to double check,

[root@Pilar linux-2.6]# tune2fs -l /dev/sda5 |grep dir_index
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery sparse_super large_file

(and I did the mv+cp+rm after setting "dir_index")

Is there another way to check what is going on with that anomalous lstat()?
[ perhaps I will try 'perf' after I read how to use it ]

Thanks,
Carlos
