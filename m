From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 08:14:31 +0000
Message-ID: <200703240814.35525.andyparkins@gmail.com>
References: <200703231022.00189.andyparkins@gmail.com> <7v648ro3a3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 09:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV1Rg-0005Ma-39
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 09:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992477AbXCXIRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 04:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbXCXIRb
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 04:17:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:55895 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932425AbXCXIR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 04:17:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1206986uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 01:17:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=briT09+VTj60P3G4fzCh0tBlMrj/SyiJyBym/a9Z/NhCJ8q5h/NX1sRJc4LcxrACDbqPrpLi8c6NnokixJKTzQcWKe6jpCg8Fl6LOpOWRgXlxL2R33tVVxqHIeRTHg4OQ5opuYIWtgGWUv2r8MfI/JZDax630r8dtn72pXPVSWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DIWc5dr36a2SKdx1ieP3CLoQACecdpFkknhInXgBMeKS7mDn5v1x3DtAnZzegGN3lxBTF88Wbd5Tl+nv1KmK3f2YBmBHX9SFcvyP1Ev+Bu9GeUgSfdllDj1pX2NwMECGjWtHoN54WP6SEY3l4nncRzw7NceTYdl46/XSs0WVzhM=
Received: by 10.67.26.7 with SMTP id d7mr8172977ugj.1174724245898;
        Sat, 24 Mar 2007 01:17:25 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm5453800ugf.2007.03.24.01.17.24;
        Sat, 24 Mar 2007 01:17:25 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v648ro3a3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42987>

On Saturday 2007, March 24, Junio C Hamano wrote:

> You know what?  I am very tempted to take this patch, while
> dropping the other one.  Well, dropping is probably not quite
> accurate, because being a nice person (and I am good looking,
> too ;-), I would probably end up creating "contrib/mailhook/"
> hierarchy and stash the contents of your second patch there
> myself.

I'm inclined to agree.  This one is obviously good because the hook 
script gets simpler.

> I think I'd better let fancier hooks live in contrib/examples
> hierarchy for people to pick and choose, and keep the default
> templates/ directory lean and clean.

I really wasn't trying to be fancy; just complete.  I hope that with 
this script that every possible type of reference update is caught and 
reported correctly.  Unfortunately that makes the script large and 
uncomfortable to put in a template directory; particularly as it's only 
really useful in a bare repository so every user wouldn't want to have 
it.  (incidentally, I've long thought that there should be two template 
directories - one for bare and one for working)

> The thing is, not many people are interested in sending e-mail
> out from post- any hooks (I don't do so, Linus doesn't either),

I'm not sure that two people is a representative sample for the "not 
many people are interested" case.  The times I think people will use it 
commonly is for internal projects.  I have this script activated on 
every project I work on, but not one of them is open source.  They all 
report to the interested parties so they know when to update their own 
repositories (or for a manager to see when a release is made).

Having said all that; I don't like the idea of putting this in the 
standard git templates; but not (primarily) for the reason of size.  
The problem, I think, is that of bug fixes.  At the moment, I copy the 
script from the templates directory to a projects/git/ directory, then 
for each repository within that I symbolic link the 
projects/git/project.git/hooks/post-receive file to the master script. 
This is still not a good solution because I have to manually copy the 
script if I ever upgrade git (or more likely a package manager upgrades 
it), so any bug fixes in the hook script don't get automatically 
implemented.

So: ideally, what /I/ would like is that git distributes the script in a 
standard location like /usr/share/doc/git/contrib/post-receive-emailer 
with the execute bit already set; that can be easily linked to or 
called from the actual post-receive hook.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
