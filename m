From: Andrew Wong <andrew.w-lists@sohovfx.com>
Subject: Re: Interactive rebase with pre-built script?
Date: Wed, 12 Sep 2012 12:38:40 -0400
Message-ID: <5050BA90.2010105@sohovfx.com>
References: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:01:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBqJB-0006Nz-1O
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760573Ab2ILRAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:00:25 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:55509 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760501Ab2ILRAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:00:21 -0400
X-Greylist: delayed 1291 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Sep 2012 13:00:21 EDT
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w-lists@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1TBpxZ-000DZd-1L
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta03.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w-lists@sohovfx.com>)
	id 1TBpxZ-000DZd-1L; Wed, 12 Sep 2012 12:38:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205308>

On 09/11/2012 02:32 AM, Peter Krefting wrote:
> Now, to my question. Is there an easy way to run interactive rebase on 
> the upstream branch with this recipe? The best we have come up with so 
> far is
>
>   git checkout master # the upstream branch
>   git rebase -i HEAD~
>
> and then just append everything from the generated recipe.
Instead of rebasing to "HEAD~", you should be able to do:
     git rebase -i HEAD
The default recipe should then just be "noop", and you can replace the 
whole default recipe with your recipe. This should also work even if the 
last commit was a merge.

Instead of appending your own recipe, you could also abuse the EDITOR 
environment variable.
Say your recipe is stored in a file called "my_recipe". Then, you could 
do this:
     env EDITOR="cp my_recipe" git rebase -i HEAD

But this could potentially be dangerous because if "rebase" fires up a 
editor for any other reason (e.g. having a "reword" or "squash" in your 
recipe), then the commit message will be messed up. So you need to make 
sure your recipe won't trigger any editor except for the recipe.
