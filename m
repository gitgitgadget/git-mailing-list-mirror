From: Andreas Ericsson <ae@op5.se>
Subject: Re: Prepend the history of one git tree to another
Date: Mon, 20 Feb 2006 11:14:28 +0100
Message-ID: <43F99684.5070403@op5.se>
References: <20060220090909.GT6558@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 11:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB83s-0007LO-Ng
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 11:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWBTKOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 05:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWBTKOa
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 05:14:30 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38844 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964832AbWBTKO3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 05:14:29 -0500
Received: from [192.168.1.104] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5123B6BD05; Mon, 20 Feb 2006 11:14:28 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060220090909.GT6558@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16474>

Thomas Glanzmann wrote:
> Hello,
> I have two trees: blastwave and blastwave.old. blastwave.old is the
> BitKeeper -> CVS -> GIT Tree of the project and blastwave is the newer
> one that I started when I stoped using bitkeeper. What I want is to 
> append the history of blastwave to blastwave.old. The problem is that I
> need to create new commit objects for every commit I want to append to
> the old history. Is there a script which does that for me? Or do I have
> to write this script myself?
> 

Something like this might do the trick, depending on how linear your 
ancestry graph is:

$ cd blastwave
$ first=$(git rev-list HEAD | tail -n 1)
$ git format-patch -k --stdout $first..HEAD > ../blw.mbox
$ cd ../blastwave.old
$ git am -k -3 ../blw.mbox

YMMV though, so set an anchor tag at the HEAD of blastwave.old so you 
can return to it if things go awry. If the history is very non-linear I 
think you'll have to do the same for each and every branch, although 
you'd have to use "git merge-base" to figure out how long to go.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
