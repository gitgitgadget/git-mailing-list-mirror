From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 16:27:27 +0200
Message-ID: <201104131627.29138.jnareb@gmail.com>
References: <4DA57183.6040308@laposte.net> <m3oc4a2tzf.fsf@localhost.localdomain> <22124707.170284.1302701972329.JavaMail.www@wwinf8403>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Axel <axel.ml@laposte.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 16:29:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA143-0006Xo-6w
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 16:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab1DMO26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 10:28:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34637 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab1DMO25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 10:28:57 -0400
Received: by fxm17 with SMTP id 17so483413fxm.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0FPVy8I/lpix4So7w77CP0NcpAyOpPpXIncNtUkt904=;
        b=m31hGr75Zd4N7fZDKRo445r0vjoFk6D2T5bshhJkSSDz9a90OMyIUFEOWDaxQyoRRl
         JczL5XzfEdXbAecATgDIIJYHiqD0FSqs4lTmWDYkAKBHJzxf06N14Xpa9Sm3LgE1g6rh
         7doifYHvKNI1aNPjkyKhhc13PzUDXaUsjfH+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aD9nBW2ujqPZ0Ubq4yUmxUMA6igEkX4uvzv0ZN7neHzT0VCPWoqkgeHj1HUsqwrqIe
         poVFhZCkczOB/r3RuX5hIocF+MhDN0wrDDis1XktlKWHx8bPwyXsj5muXOgK2u5grszy
         ecmeUFAQ1c9C2MXHnY7UKC2kj9aBo9qTa1IxM=
Received: by 10.223.54.213 with SMTP id r21mr199008fag.54.1302704860729;
        Wed, 13 Apr 2011 07:27:40 -0700 (PDT)
Received: from [192.168.1.13] (abwp92.neoplus.adsl.tpnet.pl [83.8.239.92])
        by mx.google.com with ESMTPS id 21sm201055fav.17.2011.04.13.07.27.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 07:27:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <22124707.170284.1302701972329.JavaMail.www@wwinf8403>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171460>

On Wed, 13 Apr 2011, Axel wrote:
> 
> > Could you explain in more detail _what_ behavior would you like to
> > see? Gitweb does display author and comitter (though in 'log' and
> > 'shortlog' only author is visible).
> > 
> 
> I understand well your explanations about git mechanisms.
> 
> Though git is decentralized, we still use a "central" repository on
> which gitweb is installed, mainly for pratical reasons (you may tell
> "then you don't need git!" :) ) because not only developers browse the
> commits history.

That is quite common in many workflows to have one "central" 
by-convention repository where everybody can view history and get 
latest version of a project.

Note however that there are other possible workflows than SVN-like
one where everybody publish to single "central" repository.  Quite 
common at least for open source project is workflow where one person 
(maintainer) is responsible for getting contributions from other 
developers (via pull, via email, etc.) and pushing them to this 
"central" repository.

I recommend reading chapters "Distributed Git" (for description of 
possible workflows) and "Git on the Server" (among others describing 
configuring access and logging) of free CC-BY-NC-SA  "Pro Git" book:

  http://progit.org/book/

> At this moment we use HTTP authentication more for tracing purposes
> (knowing who pushed data to the repo) than for allowing or not push
> access.  

I'm not sure if it is a best solution.  HTTP authentication is decoupled 
from git itself.  I don't know if you are using older "dumb" HTTP 
transport, or new "smart" HTTP transport (the latter requires git to be 
installed on server), but any git-aware transport can log updates to 
repository via hooks mechanism.

See for example "better logging" issue in Gitolite FAQ:

http://sitaramc.github.com/gitolite/doc/3-faq-tips-etc.html#_better_logging

Gitolite is one of tools to manage git repositories.
 
> If i m not wrong, the AUTHOR field displayed in gitweb comes from the
> git client configuration ($GIT_AUTHOR_NAME). 

Yes it does, though actually modern way is to put

  [user]
  	name  = Joe R. Hacker
  	email = J.Hacker@example.com

in $HOME/.gitconfigure file for user (client).
 
> I would go further : HTTP authentication (for in-house organisation
> of course, not internet-wide access) usefulness is unclear since the
> credentials do not pop up anywhere in git repository. We have to trust
> the client-side configuration. The way to know who pushed something is
> to browse Apache access.log and cross the date/time with the git log.    
> 
> What I'd like to see is that the push authentication credentials
> overwrite an eventually defined author name at the client side in
> order to be displayed while browsing git log.  

This is not possible, and I don't see that it would be changed.  
Changing credentials would require (because of SHA-1 based addressing) 
changing commits.  Note that one is usually pushing more than one 
commit at once with push.
 
What you can do is the REVERSE.  Check on push if committer info matches 
authentication credentials used for publishing, and refuse push if it 
is not true.  But that requires git-aware transport; I think Gitolite
can be configured to do that, and that update-paranoid hook example also
can do this.

> Even better, in the case of LDAP authentication (I m not sure if it
> would be possible for htaccess authentication), email and fullname
> could be extracted from LDAP directory, stored in environment
> variables by Apache, and given to git-http-backend (as is the
> REMOTE_USER variable).    

Because commits are created on client side, in client repository, you 
cannot trust committer and author stored in git commits.

If user.name is not set, and neither are GIT_AUTHOR_NAME / 
GIT_COMMITTER_NAME environmental variables, git tries to take name from 
login information.  I think operating system can be configured to take 
it from LDAP, but git itself doesn't do this -- but it could.
 
> Though I don't know if this request is relevant, I guess that if
> git-http-backend was looking for GIT_AUTHOR_NAME & GIT_AUTHOR_EMAIL
> environment variables that Apache could have defined, it could replace
> the client-side values defined. (Note that I absolutly don't know if
> it would be technically possible to overwrite those variables or even
> if their values are in the push payload).     

Nope, at the time of push commits are already created, and author and 
committer info are already set in stone, and not possible to change 
without rewriting commits.
 
HTH
-- 
Jakub Narebski
Poland
