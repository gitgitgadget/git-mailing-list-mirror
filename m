From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in the process)
Date: Fri, 17 Aug 2007 09:39:46 +0100
Message-ID: <200708170939.47214.andyparkins@gmail.com>
References: <200707021356.58553.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 10:40:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILxNE-0002pk-Ea
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 10:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405AbXHQIjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 04:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbXHQIju
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 04:39:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:33333 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707AbXHQIjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 04:39:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so315699ugf
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 01:39:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qe3v5JKYqU4ssKIA4WOCd6vfz/m18E9/6af4ZVlz7RxlfgjliRjJNVO3DeV34zqCTnKjZCI9AAyzVqcOCw3VAFOBvAjTdoDTr/YqVqXrKSocU30QWIq6WFxF/z3XF5gHqce8SuBlX50mp1t2bJkdQLiZy7SGLP+G2Y2CTRpqH3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XwtLkATLu7guEgAsTgFBoMFO3WtDKKj+kUs4BAANTYf6Ql2frHgFPEfQMBc12xYKrELMSm9DC6DgZayQurLnc2TbGWJ6mejdH88CMfIL//jMLE/oLEFvHLu+oaCjLRqxCuwGynerETP8awF1ARhXeAlEEttxVpqqG9AJonVfnpM=
Received: by 10.66.243.4 with SMTP id q4mr2858392ugh.1187339987122;
        Fri, 17 Aug 2007 01:39:47 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id d26sm1268173nfh.2007.08.17.01.39.44
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2007 01:39:45 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <200707021356.58553.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56052>

On Monday 2007, July 02, Andy Parkins wrote:

> This repository was a strange one in that it was being used to provide
> its own submodule.  That is, the repository was cloned into a
> subdirectory, an independent branch checked out in that subdirectory,
> and then it was marked as a submodule.  git-prune then failed in the
> above manner.

I think I've stumbled on another place where this is happening.  
git-upload-pack is crashing for me with a similar "Object is commit not 
blob" error just before.

I'm happy to try and track it down, but I'm having difficulty because I 
think the crash is happening in the process on the remote system, so I'm 
not getting a core dump I can use.

Could any of the guru's give me a guide to upload-pack.c?  I assume the 
problem is going to be the same as it was for git-prune, the hash for the 
gitlink object in the tree is being assumed to be an object in the ODB; 
which isn't the case with gitlink entries.  Where would that be happening 
in git-upload-pack?  The fix is going to be..

 if( S_ISGITLINK(mode))
      continue;

But I've got no idea where to put it :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
