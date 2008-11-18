From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-submodule/before-rebase hook
Date: Tue, 18 Nov 2008 08:47:32 +0100
Message-ID: <49227314.4080709@op5.se>
References: <CC8B9B47-4985-4B96-B8DB-0B351633C849@justinbalthrop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: justin <juddhuck@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 08:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2LKN-0002De-Or
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 08:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYKRHrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 02:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbYKRHrh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 02:47:37 -0500
Received: from mail.op5.se ([193.201.96.20]:53537 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbYKRHrg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 02:47:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 400021B8116A;
	Tue, 18 Nov 2008 08:42:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zQNp3pjepPH; Tue, 18 Nov 2008 08:42:25 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 55B8B1B81169;
	Tue, 18 Nov 2008 08:42:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <CC8B9B47-4985-4B96-B8DB-0B351633C849@justinbalthrop.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101263>

justin wrote:
> I just discovered git-submodule today, and already I can see it making 
> my life a lot easier. I develop several modules that are used in two 
> different projects, and being able to check in changes from the 
> submodule in either project is something I have been wanting to do for a 
> while. But there is one shortcoming in git-submodule that I haven't 
> figured out how to overcome... yet.
> 
> When I make a change to a submodule and push that change to the parent 
> repository, the change appears to all other users of the repository as a 
> modification to the submodule commit version.

It shouldn't, unless you push the change into a non-bare copy of a checked
out submodule, but that would be rather insane as the submodule rather
than the superproject then gets to decide which version of the submodule
to use.

> A few people at our 
> company use 'git ci -a' to add all of their changes, and I'm afraid they 
> are going to unknowingly revert the submodule back to a previous 
> version.

Ah, now I see where you're coming from. After you issue "git pull" in
the submodule you have to sync the new version of the submodule to the
superproject using "git submodule sync".

> So my plan was to add a post-pull hook that does 'git submodule 
> update --init', so that people who don't do development on the submodule 
> will get updates every time they pull.

Ok, I didn't. Why do you pull into the submodules if you don't want to
sync the code so the superproject gets the benefit of the changes?

> Unfortunately though, there is no 
> such hook in git. I thought post-merge was going to work, but most 
> people at our company use 'git pull --rebase', and post-merge isn't 
> called in that case. The post-checkout hook is called, but the pull 
> hasn't been completed at that point, so updating the submodule doesn't 
> work. Alas, if only there was a post-rebase hook.
> 
> Any ideas other than patching every employee's git source to add a 
> post-rebase hook?
> 

Yes. Only pull in submodules if you intend to sync them afterwards.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
