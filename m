From: Andreas Ericsson <ae@op5.se>
Subject: Re: Pushing into a repository with working directory?
Date: Tue, 09 Jan 2007 10:15:28 +0100
Message-ID: <45A35D30.3070305@op5.se>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org> <7vwt41j1le.fsf@assigned-by-dhcp.cox.net> <20070105193646.GC8753@spearce.org> <45A24CE6.5060201@shadowen.org> <7vd55pt3ts.fsf@assigned-by-dhcp.cox.net> <20070109033213.GC1904@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Andy Whitcroft <apw@shadowen.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 10:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4D4y-0008Pw-8o
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 10:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbXAIJPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 04:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbXAIJPc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 04:15:32 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41024 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbXAIJPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 04:15:30 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A81D56BCBC; Tue,  9 Jan 2007 10:15:28 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070109033213.GC1904@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36333>

Shawn O. Pearce wrote:
> Junio C Hamano <junkio@cox.net> wrote:
>> However, I am not sure if that is easy to understand for the
>> users.  It would be sane to deny pushing into the current branch
>> for a non-bare repositories by default, and if we do allow it
>> (perhaps with 'git-push --force'), then detach the HEAD as you
>> suggest.  On the other hand, pushing into the current branch of
>> a bare repository should just work; the HEAD pointer in a bare
>> repository is not about the commit the index and the working
>> tree are based on, but which branch is the primary branch of the
>> repository.
> 
> But from the working directory management tools' perspective HEAD
> *is* about the current index and the current working directory.
> If HEAD doesn't match the index and working directory closely
> enough then the user is going to do something stupid, like commit
> a negative delta by accident.
> 
> Pushing into the current branch of a repository with a working
> directory probably shouldn't be allowed by default as users probably
> don't want to do that.


I do this all the time. I develop on my laptop and send changes to a 
testserver where I check out the revision I just pushed to the working 
directory attached to it. Doing it the other way around is cumbersome, 
as I've got ssh-authentication installed on the server but don't wish to 
have that on my laptop. I could ofcourse do this with the alternates 
mechanism and pull things from the alternate repo to the one I really 
use, but that seems like I have to work around a limitation in git that 
isn't really there (or at least shouldn't be there for any logical or 
technical reason).

>  But if --force is used then detaching the
> HEAD is probably the best idea.  The user could easily recover by
> doing `git checkout origbranch` (though they may need `git checkout
> -m origbranch` if their working directory was dirty).
> 

Since we can determine if there's a working directory or not, why not 
just allow the fast-forward case if the working directory is clean and 
update the working directory for the user? This can't lose any data and 
would also make it very easy to, fe, keep a website in git and just push 
it straight to the webserver  when there's been modifications in the 
users repo. --force should behave the same way, possibly with an extra 
check to see if the working directory is clean before checking it out.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
