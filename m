From: Andreas Ericsson <ae@op5.se>
Subject: Re: Repository Security
Date: Wed, 24 Jan 2007 10:31:32 +0100
Message-ID: <45B72774.1070508@op5.se>
References: <200701221433.13257.andre@masella.no-ip.org> <ep4q5e$ioc$1@sea.gmane.org> <200701230823.20061.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andre Masella <andre@masella.no-ip.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 10:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9eUF-0002aB-E9
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 10:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAXJcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 04:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbXAXJcE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 04:32:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53062 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXAXJcB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 04:32:01 -0500
Received: from [172.27.78.30] (unknown [172.27.76.254])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 25AF36BCBE; Wed, 24 Jan 2007 10:31:59 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <200701230823.20061.andre@masella.no-ip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37614>

Andre Masella wrote:
>>> As I understand it, none of the repository backends allow any per-user
>>> per-branch access control. SSH and HTTP come the closest with the right
>>> hooks, but since the repository is writeable by those users, there is
>>> little to stop them from changing the repository directly.
>> I wonder if it would be enought for SSH (and perhaps HTTP/WebDAV access)
>> just to rely on filesystem write access to refs/heads files (different
>> files having different access rights), and filesystem ACLs.
> 
> It could probably be done, but it would be very complicated. For instance, if 
> a user is allowed to run prune, then they must have permissions to delete 
> files which would include any of the objects.
> 

Pruning is considered a "repository admin task". Since each git developer has
a full copy of the entire project locally, they can prune their local repo
as much as they like without it affecting the mothership repo.

Pruning of the mothership repo should be done by whoever administers the host
where it is hosted, and probably not even by him/her unless diskspace becomes
an issue.

We have 42 mothership repos at our workplace. Combined in those repos we've got
2962 dangling objects. Pruning them would save me 8.5MiB of diskspace. It's
hardly worth even thinking about.

> For DAV, this breaks down completely because all access to the repository will 
> happen as the Apache user.

Indeed. We use real system accounts for pushing/pulling. It's convenient for
those of us who use ssh-agent, and functional for those who don't. It also
allows "fine-grained-enough" access control to the repos.

Normally we have all repos owned by <project-leader>:devel and created with
umask 002. All developers are in the "devel" group and can thus by default
push and fetch from all repositories. Some repos require stricter access
rights. For those we create a group specially.

The "everyone can read" thingie isn't necessary, but it's nice because it
lets our head of development take a look at whatever he wants without us
running any risk of him damaging it (he's a suit after all).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
