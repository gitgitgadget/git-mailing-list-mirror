From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Wed, 4 Apr 2007 13:56:46 +0100
Message-ID: <200704041356.47123.andyparkins@gmail.com>
References: <1175686583.19898.68.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Alex Bennee <kernel-hacker@bennee.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 14:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ53Y-0001l2-Ql
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 14:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966332AbXDDM50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 08:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbXDDM50
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 08:57:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:3917 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966332AbXDDM5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 08:57:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so651060uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 05:56:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sRzcRhGVXaU51n5p9o1gWt4dp66ZWeysPlui16IXnum/Ulw3peSvzlaR1YOChTizmsOLF53fGBW2/15c8uljNxB8C0WQNPAtQj5hLafd44xqVF1GMWZ8a9+DllrORwf2UeBVXijTY0B8fwwKxSYAYLGqo9aBXq81GNRaZEu0f1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SspaOmjnc2WMKKl1VHwW5pcjNHybyzcmOu/ZNn9VdSaqOCN86HWOoUM5ab2ZFIZOXt28ifrW8E7wfSDEQOtUnDBGIK0tF+rbLR3DthHSNI/C2Cgu1c327ycxeYVBtMFzvb0YkOLwdT1c/FzTOAf+HT7iN8XXT8klQwOjWGjq0yY=
Received: by 10.66.218.15 with SMTP id q15mr1419707ugg.1175691410600;
        Wed, 04 Apr 2007 05:56:50 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm1187930ika.2007.04.04.05.56.49;
        Wed, 04 Apr 2007 05:56:49 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <1175686583.19898.68.camel@okra.transitives.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43734>

On Wednesday 2007 April 04 12:36, Alex Bennee wrote:

> What I need to do is check that my commits that I submitted for the
> baseline have been correctly merged. Of course if I do "git-diff
> master..mywork" I'll see all the other code that has been added in (or
> more usually is missing from my branch).
>
> Is there an invocation of git-diff or another tool that can tell me all
> my diffs are present in the big uber-commit of my master branch baseline
> release?

Kind of.  Try git-cherry (I like to use -v as well).  This will compare the 
hash of the diff of each of the revisions in your current branch with those 
of an upstream branch.

 * -- O -- * -- * -- C' -- * (upstream)
       \
        A -- B -- C -- D (yourbranch)

With something like the above, were C has been accepted into upstream as 
revision C', runing git-cherry on yourbranch would give:

 $ git-cherry upstream
 +A
 +B
 -C
 +D

The "-" in front of C means that you can remove C from yourbranch - it's been 
accepted.

However, this relies on the applied patch matching exactly (not the log 
message - that can be anything), so if a typo got fixed by the maintainer, it 
would show up as not having been accepted.

Another good way of telling is to rebase yourbranch onto the current 
upstream - a patch that doesn't need applying (because it's already there) 
get's dropped automatically by git.  This is really handy because git 
effectively filters those patches that you don't need to worry about any more 
in yourbranch.  This would cope with a typo fix as well, because git-rebase 
would note a conflict which you would then see as being a minor typo and 
would do "git rebase --skip" which would manually drop the patch from 
yourbranch.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
