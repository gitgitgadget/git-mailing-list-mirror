From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: 1 patch to two branches
Date: Sun, 06 Mar 2011 18:56:21 -0600
Message-ID: <4D742D35.6080709@gmail.com>
References: <38ac3be3-8d09-4a38-b31e-9365fe0f2992@v11g2000prb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: allstars <allstars.chh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 01:56:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwOkR-0005fi-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 01:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1CGA40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 19:56:26 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43492 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1CGA40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 19:56:26 -0500
Received: by yia27 with SMTP id 27so1439272yia.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 16:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2fQqB7gKHX91Z4eT/NLCQ8iEQVWHZ09Ch3CZiigTJR8=;
        b=x1pK7ILRRk/JvWw+IV0wqbQU+brnTeavyeUg3b0p4CBHUnen/cYfIy9ocLL6BILQOO
         lvMqySl1aNlIZzfHLD5KSB2ra0Bj8RP1DMQRGOS4INfFVUVO5hrxDHzEgxY/945jHFSV
         gnC5oeLNQYHo7XMGCH+0JNN84ZGn0d2ELdysQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=QVwyUUE/kYqczMirdEgYJCJX+ic2eE8AG9H4lKHdwCad59ROwPhAQVScE07q7LBhBL
         3Jk0UIGkzeFH1gUdcyYBv3ji7dt37FGhf2PoiVoo1x6FwrsbG7xEfwldGjYmsEyRlglz
         0wTR41Zxvj7DyG8h97fLAhJln+fatFC92z2fU=
Received: by 10.151.25.4 with SMTP id c4mr3710509ybj.288.1299459385659;
        Sun, 06 Mar 2011 16:56:25 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id q34sm1314105ybk.15.2011.03.06.16.56.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 16:56:24 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <38ac3be3-8d09-4a38-b31e-9365fe0f2992@v11g2000prb.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168562>

On 3/3/2011 6:46 AM, allstars wrote:
> my case is as follows
> I have two branches
> basically they are the same, except they differ from different package
> name(java) and namespace(cpp) due to customer request
>
> but now I have a fix , say a patch
> I want to commit it to both branches
>
> but I am lazy so I just want to do just one 'git commit' and 'git
> push'
>
> so I am thinking using a githook in remote server
> and each commit to branch A can also commit to branch B as well
>
> but I am not quite sure what I should use in the hook
>
> git rebase , git merge or git cherry pick ?
>
> seems these 3 ways all lead to the same result
> but I dont know which is better and why

if by "patch" you mean git-am/git-apply then I'm afraid i don't have any 
suggestions because i don't use those commands.  However, if you use 
git-push then have you thought about having a script on the local side 
that does something like this:

$ git checkout java-branch
(hack hack)
$ git add .
$ git commit
$ bash -v myscript  <--run your script
#!/bin/sh
# script to commit java-branch head to cpp-branch and push them both
git checkout cpp-branch &&
wait
git cherry-pick java-branch &&
wait
git push origin HEAD &&
wait
git checkout java-branch &&
wait
git push origin HEAD &&
wait
exit 0

of course, you need some error checking in there.  this is predicated on 
the assumption that the cherry-pick will not get any conflicts.  if it 
does get conflicts then you will have to resolve them manually and that 
is a big reason to do this on the local side instead of the remote side.

v/r,
neal
