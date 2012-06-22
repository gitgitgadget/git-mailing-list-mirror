From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 18:47:29 -0500
Message-ID: <4FE50411.8080800@gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com> <4FE4C0F7.2080309@gmail.com> <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 01:48:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiDaG-00064i-04
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 01:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab2FVXrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 19:47:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37308 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab2FVXrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 19:47:32 -0400
Received: by obbuo13 with SMTP id uo13so2643223obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0IkJBi2FcHEE2kn6cZuYzyAcsJDRqbzauZWVM/0tWu8=;
        b=w7p6tZqyj9fyTwKTKcZHCb8XeixfYVLZ8H6IQk6lFA3agGDf5/4Hmc2amv2U72KhMg
         hxmpgwYHat/ojCL0ykSHsTqh/Whn/YcBi2mk8God5eoJlOtc9Y7FtD7mxUA5RIj62tsi
         LCUWZd/PdQ+ZTnurfZ2LuWmnKdAQNHgMEoItALLGAMq+dYhWK1uR8ENxwOcPrysReGmT
         7cV1G/7uq3vA8bXSi+/Pqdk1uohcu+WCXzsdKm43woaxQ4wknD+2+RxvGYKuUy5GjZUz
         1EXmwqpBqfhvprDHE5IvRvsj0bI4bPGWl3yWNPlvJyMzjp5iDUGz0pxFvk0FJHsR4R56
         ftcA==
Received: by 10.182.36.102 with SMTP id p6mr3752709obj.77.1340408851535;
        Fri, 22 Jun 2012 16:47:31 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id vs8sm31993815obb.14.2012.06.22.16.47.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 16:47:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200487>

On 6/22/2012 3:18 PM, Hilco Wijbenga wrote:
>
> On 22 June 2012 12:01, Neal Kreitzinger <nkreitzinger@gmail.com> wrote:
>> On 6/22/2012 12:53 PM, Hilco Wijbenga wrote:
>>>
>>> One of my developers managed to push something that somehow "diverged"
>>> origin/master from everyone else's local master.
>>>
>>> A --> B --> C --> D (everybody's local master)
>>> |
>>> \--> B' --> C' --> D' --> E (origin/master)
>>>
>>> (i.e., A is the commit where things diverged; everyone's local master
>>> points to D but the new commit (E) that was pushed to origin/master
>>> uses different SHA1s for B, C, and D)...
>>>
>>> Now running git pull creates a merge commit joining D and E.
>>>
>>> ...Does anyone have any idea as to what might have happened? Perhaps if I
>>> understand how this happened I might be able to prevent it from
>>> happening again.
>>>
>> Some ways you can prevent it from happening again:
>
>> (2) have your devs do git pull --ff-only
>
> Is this something that can be set in git config? I looked but didn't
> see anything obvious.

OTTOMH, you could change the git fetch config for master and take away 
the leading '+' sign which would not allow non-fastforward fetches of 
master.  That in turn would prevent merging such a non-ff remote 
tracking branch of master into your branch master.

Actually, I guess what I really want is
> something for git push, right?
>
Some ways to do it:
(1) I think you could have rebase and commit hooks locally that prevent 
someone from rewriting history on master.  That in turn would prevent 
someone from pushing a rewritten history.
(2) When merging topic branches to master use git merge --ff-only.  Then 
when you push it to remote master you know it's a fastforward and not a 
history rewrite.

v/r,
neal
