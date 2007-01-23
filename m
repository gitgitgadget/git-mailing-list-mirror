From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 15:00:33 +0000
Message-ID: <200701231500.34560.andyparkins@gmail.com>
References: <200701221433.13257.andre@masella.no-ip.org> <Pine.LNX.4.63.0701231036400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200701230823.17938.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andre Masella <andre@masella.no-ip.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 23 16:00:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9N8e-0004l2-PV
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXAWPAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbXAWPAl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:00:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:18018 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbXAWPAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:00:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so267736nfa
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 07:00:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tajq8mksn58HkxaTYCw+Fmk5rCza/majvk9iyohO7Kq2DZ9fC9XNNDx/odJ7LbJb86n9qL1pQWFvFnVBJpSl2M8YoiYHy57g2RAcJV8Q+sI/bN8p4S2uQOIIGHwYnNBGCCrS8F3GFCh8wkKPmPVBwhOhsIK4DyHn/BDSqbMu/rQ=
Received: by 10.49.41.18 with SMTP id t18mr1166797nfj.1169564438422;
        Tue, 23 Jan 2007 07:00:38 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id h1sm2833773nfe.2007.01.23.07.00.37;
        Tue, 23 Jan 2007 07:00:37 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200701230823.17938.andre@masella.no-ip.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37529>

On Tuesday 2007 January 23 13:23, Andre Masella wrote:

> Okay, say one regular developer wants share his changes with another
> developer. He either has to mail patches, create an SSH account, or set up
> one of git-daemon or WebDAV. And most of those require knowing the
> workstation name which is inconvienient. I would rather have each user able
> to push to a branch with their name on it on a central server.

So: developer1 is allowed to make changes to central's branch br/developer1, 
say.  How is the central server going to be sure that it is developer1 
connecting?  Probably a username and password.  In which case you have a user 
account - which is what you would have with ssh.  The difference would be 
that with ssh you would have full access to all the authentication and 
authorisation mechanisms of a standard UNIX system; LDAP, NIS, timed-logins, 
etc.  If git were to implement authorisation itself then it would need all 
these modules writing again.

I don't know if this would work with git, but once you had real users, you 
could simply do
 $ mkdir refs/heads/dev1
 $ chown dev1.developers refs/heads/dev1
 $ chmod 755 refs/heads/dev1
 $ chmod u+s refs/heads/dev1
And then only dev1 would be able to write references in refs/heads/dev1.

(The above is untested in git; but with a bit more work I'm sure it could be 
made to operate)

git has a marvellous property that it won't change objects in the object 
database - it will only add new objects.  That makes it more difficult to do 
actual harm over the git-protocol.  For my few users, who already had 
accounts, and are part of a group, I simply made a group-writeable SGID 
directory for git repositories, created the repositories, set the config and 
left them to it.  With reflogs turned on, there is no damage they can do that 
can't be undone.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
