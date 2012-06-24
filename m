From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git pull with submodule
Date: Sun, 24 Jun 2012 20:24:34 +0200
Message-ID: <4FE75B62.9020107@web.de>
References: <1564611.U3XyAbWYKV@toshi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sascha Cunz <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Sun Jun 24 20:25:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SirUx-0006RF-AU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 20:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab2FXSYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 14:24:36 -0400
Received: from mout.web.de ([212.227.15.3]:64269 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab2FXSYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 14:24:36 -0400
Received: from [192.168.178.48] ([91.3.184.208]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MN4Oy-1SpR4E2WyW-00726r; Sun, 24 Jun 2012 20:24:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1564611.U3XyAbWYKV@toshi>
X-Provags-ID: V02:K0:c6tzxwQMGjbmyWYai7b/nctDahccAkbK5jtk/Hcbqvu
 RQ6V6ZlSeolDjsaesprnncGhbXlCQQaXqFnGK0uWuH8B/6bKRc
 P+/lLks5CzUPvuCgooFZ5M3XizbzNfy95Xstw0UuBsCTTSPM51
 VJQDfxt8Vz6wHLR6fTcOWNP1JmlU9uzhJi7MlE2PhB615ZKzhW
 wJi0EkphxowKYoheQfFsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200538>

Am 23.06.2012 15:53, schrieb Sascha Cunz:
> I noticed the following behaviour when pulling a repository that has a 
> submodule.
> 
> I have a standalone checkout of my subproject, which I regulary sync it with 
> its upstream and push the result to github. Then I go to my project where the 
> github repository is setup to be a subproject, 'cd' into the subproject and do 
> 'git pull' there. After that, I commit the subproject blob into the 
> superproject.
> 
> Now i switch OS and/or workstation and do a 'git pull' ( in root directory of 
> superproject ). Git then
> 	-> fetches new objects of superproject
> 	-> fetches new objects of subproject
> 	-> checks out the subproject to the SHA1 currently recorded in
>       the subproject blob. (Am i right on this one?)

No, you have to issue a "git submodule update" to check out the submodule
according to the commit that is registered in the superproject. Only the
SHA1 currently recorded in the superproject will be updated when the merge
succeeds, the submodules work tree and HEAD stays untouched.

> 	-> merges superproject with it's upstream
> 
> After that, i have to cd into the subproject and 'git pull' there again, 
> because it just fetched the objects but did no merge nor checkout.

Hmm, the merge of the submodule commits in the superproject should have
already been done by your pull there (as I understand your use case you
only move the submodules commits forward, so there are no merge conflicts
to be expected). Just doing a "git submodule update" in the superproject
after the pull should do the trick.

> Is this intentional behaviour or am i doing something wrong / have wrong 
> expectations in that "after seeing it recurring into the subproject, i expect 
> i don't need to do further steps in order to have it up to date"?

This is the way things currently work. There is ongoing work to get rid
of the need to run "git submodule update" when the commit recorded in
the superproject changes due to a checkout, pull or whatever, but we're
not there yet.
