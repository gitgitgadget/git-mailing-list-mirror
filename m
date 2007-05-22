From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Fwd: Problem: git doesn't update working dir (always) when checkout'ing other branch
Date: Tue, 22 May 2007 09:04:37 +0100
Message-ID: <200705220904.39487.andyparkins@gmail.com>
References: <566574ef0705210157j14cb7c56h62392c6193472a98@mail.gmail.com> <200705211016.58067.andyparkins@gmail.com> <566574ef0705212105k1387cf41n18e076c0bdf47ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stian Haklev" <shaklev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 10:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqPMV-000473-0I
	for gcvg-git@gmane.org; Tue, 22 May 2007 10:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702AbXEVIEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 04:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755780AbXEVIEr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 04:04:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:63132 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbXEVIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 04:04:45 -0400
Received: by wx-out-0506.google.com with SMTP id h29so155160wxd
        for <git@vger.kernel.org>; Tue, 22 May 2007 01:04:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Bf9tWeFRfUFEy5dQ+2jofD1UhttXJeCXRfd+IeSozsKw7Fx/UR+nOyg6Znk3KmekEWeocqpvPWjVhqDnqnhV8zk8boBymVAXhbJ2Rb4agejYkMutylH0dRQBGLXWnoW6NP8czDYwb1PhGW09HZ08596xwbdxMET9ApjahUoxXf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M8c5BTOAN7xN6LHzgzXEsBc84k7biLlkg7w7KDeIA81Fmj/dkwr0nKPwFo79/P9SV8KsZiuP01mZ/Tl8U1rHWH4bvliRWF+3vxyT7VNCxBmlbJelUvhLFjCOtSNmUm/MWC4NutYk3pEi7L7VkSrv9DYoeDy+UlAuZZYcyWdo7FE=
Received: by 10.70.130.19 with SMTP id c19mr8491121wxd.1179821085319;
        Tue, 22 May 2007 01:04:45 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id h9sm1855086wxd.2007.05.22.01.04.44;
        Tue, 22 May 2007 01:04:44 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <566574ef0705212105k1387cf41n18e076c0bdf47ec6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48086>

On Tuesday 2007 May 22, Stian Haklev wrote:

> git --version > ../file1

Good stuff.  The ">" only redirects stdout to file1; stderr would still be 
written to your terminal - did you notice any errors from this script?  Could 
you run again, but append "2>&1" to the end of each redirecting line?

> git status >> ../file1
Seemed fine after this.

> echo checking out works with old >> ../file1
> git checkout works-with-old >> ../file1
Seemed fine after this.

> git status >> ../file1
Seemed fine after this.

> git checkout master >> ../file1
> git status >> ../file1

Kaboom!

> # On branch master 
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       deleted:    NOTES
> #       modified:   display-page.rb
> #       deleted:    eee_darwin
> #       modified:   gui.rb
> #       modified:   htmlshrinker-data.rb
> #       modified:   htmlshrinker.rb
> #       modified:   mongrel-web-gui.rb
> #       modified:   mongrel-web.rb
> #       modified:   zarchive.rb
> #       new file:   zcompress.rb
> #       modified:   zdump-7z.rb
> #       modified:   zdump.rb
> #       modified:   zipdoc.rb
> #       deleted:    zutil.rb

Wow.  I've never seen anything like that.  Neither the index nor the working 
tree has actually been updated - but HEAD now points at master.

What was the output of that last git-checkout (unfortunately it outputs to 
stderr not stdout, so you'll need the "2>&1" at the end of each line in your 
script)?  git-checkout won't change HEAD unless the change of index and 
working tree worked.  I can't see the path through the git-checkout script 
that would have done what you're describing.  I think it's going to need a 
guru on this one, however, we'll keep at it until I can't think of any more 
questions :-)

Do you observe the same behaviour on all repositories or just this one 
particular repository?

What's the form of this repository?  That is to say, is works-with-old a 
branch from master or is it an independent branch?  e.g.

  0 -- * -- * -- * (master)             0 -- * -- * -- * (master)
                                    or        \
  0 -- * -- * -- * (works-with-old)            * -- * -- * (works-with-old)
                     
I assume once you get into this broken state that running "git-reset --hard" 
restores the working tree back to master?

Does changing that last checkout to "git-checkout -f master" improve things?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
