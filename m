From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Filemode is a nuisance
Date: Fri, 22 Jul 2011 14:11:46 -0500
Message-ID: <4E29CB72.6020904@gmail.com>
References: <5B76586FBEB246BDA2F097E21C78E881@rowanlewis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rowan Lewis <me@rowanlewis.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 21:11:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkL8g-00029d-B0
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab1GVTLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 15:11:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39135 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab1GVTLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:11:52 -0400
Received: by yxi11 with SMTP id 11so1464121yxi.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=yc2UotQMJVbJN32InGxk/rYuTk1lXepEq3SmDsssP6Y=;
        b=JySuZA0TEhubrYvr0FNuHLLubkFFPa70L8K2I+lum80rVZZrho5G7EEg4om8D/M0Mj
         2ubnTqVtPBkWbIIilGaSGIly8EISOUHKyBsWCea5asRU3WSVBIsEN3wOfrFF5icWdtir
         Mb9P7v9UnK4CDU33VlWwwPKUqzjNrLQAyzRGA=
Received: by 10.151.117.10 with SMTP id u10mr2342615ybm.93.1311361912127;
        Fri, 22 Jul 2011 12:11:52 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p50sm2393028yhj.14.2011.07.22.12.11.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 12:11:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <5B76586FBEB246BDA2F097E21C78E881@rowanlewis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177658>

On 5/4/2011 6:38 PM, Rowan Lewis wrote:
> Hi,
>
> I work at a web development company, a few years ago we switched from using SVN to using git. Since then a lot of little issues and improvements have been made to git, I have to thank the developers for their hard work.
>
> However, one problem still remains. Our projects are often cloned onto a large variety of computer environments, from Linux servers to OSX and Windows desktops. Each of these environments tends to have its own requirements for file permissions, depending on how Apache and PHP have been configured.
>
> As a result of this we're nearly constantly forced to manually set filemode to false in every repository, including submodules.
>
> The following is the output of git status on one of our repositories with a moderate number of submodules:
>
> # modified:  extensions/asdc (modified content)
> # modified:  extensions/canofspam (modified content, untracked content)
> # modified:  extensions/db_sync (modified content)
> # modified:  extensions/debugdevkit (modified content)
> # modified:  extensions/emailtemplatefilter (modified content)
> # modified:  extensions/export_entry (modified content)
> # modified:  extensions/expressionfield (modified content)
> # modified:  extensions/flexdatefield (modified content)
> # modified:  extensions/globalresourceloader (modified content)
> # modified:  extensions/logsdevkit (modified content)
> # modified:  extensions/mpm/extension.driver.php
> # modified:  extensions/order_entries (modified content)
> # modified:  extensions/profiledevkit (modified content)
> # modified:  extensions/publishfiltering (modified content)
> # modified:  extensions/reflectionfield (modified content)
> # modified:  extensions/selectbox_link_field (modified content)
> # modified:  extensions/subsectionfield (modified content)
>
>  From this list it would appear that each of the 17 items in the extensions directory has been changed, but this is not truly the case. What actually happened was someone running chmod to give Apache access to the files.
>
> It's a real problem, as I cannot tell which of the submodules actually has changes that I need to deal with. I'm also sure that there's probably some script-foo that I could to do automatically change filemode to false; but unfortunately my bash isn't so great, and I'm the most knowledgable in shell scripting at work.
>
> I see three possible solutions to our woes:
>
> 1) It is/becomes possible to disable filemode when repositories are created; so only in the rare case that we need this feature would we have to change the git configuration.
> 2) Submodules defere the filemode preference to the parent repository; so that it only needs to be disabled once per project/repository.
> 3) I'm an idiot and all of my googling has failed to turn up an obvious/easy solution, and someone here points me to it.
>
> Anyhow, thanks for listening, this email has been a long time coming.
>
Here are some puzzle pieces that may help you solve your puzzle. (I'm 
assuming your canonical repository is on Linux.) Git does not track all 
permissions, just whether a file is executable or not.  So in linux a 
file is stored in git, ie. the object store, as either 777 (executable) 
or 666 (non-executable).  Upon checkout, the permissions are modified by 
the umask.  Umask can only take away permissons, not add them.  So if 
you ensure all your files are committed with full permissions 
(executable) then you can modify the checkout to do whatever you want 
with the umask.  Therefore, the changes you're seeing in git status are 
not really saying that permissions changed in general, but specifically 
saying that the permissions changed from not having any executable bits 
at all to having at least one executable bit, or from having at least 
one executable bit to not having any executable bits at all.  See this 
thread for more context and information: 
http://article.gmane.org/gmane.comp.version-control.git/177583
(Although, the git-archive aspect may not apply to you, the git 
permissions and umask aspects do.)  With this info, I was able to do 
what I needed to do with permissions while keeping filemode=true.

I am not an expert on git permissions, umask, and apache, but in my 
scenario (of linux only) I was able to get these to work together and 
avoid unnecessary scripting by getting a better understanding of them. 
My (non-expert) understanding is that apache only needs to read files in 
order to execute them.  It looks like apache may need to write some of 
your stuff, also. (In my scenario it does need to write to the files.) 
Either way, you shouldn't care about executable bits on files for apache 
access, correct?  Of course dirs need to be executable so they can be 
traversed, but I'm guessing they should probably be set correctly in 
your object store and post-checkout worktree already by default without 
you having to script to change it.  IOW, maybe your permissions fixing 
scripts are doing overkill by modding executable bits that don't really 
need to be modified in order to accomplish your apache access.  Just my 
thoughts based on limited (but successful) scenarios, knowledge, and 
experience.  (Maybe I'm missing something here.)

v/r,
neal
