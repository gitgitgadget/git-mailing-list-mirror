From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 05:53:53 -0700 (PDT)
Message-ID: <m3oc4a2tzf.fsf@localhost.localdomain>
References: <4DA57183.6040308@laposte.net>
	<m3sjtm2z8e.fsf@localhost.localdomain>
	<5222475.65704.1302693678918.JavaMail.www@wwinf8226>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Axel <axel.ml@laposte.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9za8-0005YH-HT
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab1DMMx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 08:53:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61373 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab1DMMx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 08:53:58 -0400
Received: by bwz15 with SMTP id 15so540099bwz.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=xvu/wc1nPB2OTEZ8YT7HrscGTCew/v03Fl2Jp/LsMr8=;
        b=OgXPN/yqvB0Pd4lrgCDaQv3CtkrZjOGuB83C2Ay6wgk8e+WABI4y4J2t/curhc1rW4
         vwFaOzlWIufK71NGo5FcwECvdqsmnQ30POHWTVCDcTPCRMHrCSTxSZlmZwWV9iRzttCT
         qLfyE12xRdWmI7mg9pMFaZklYzEeHOmG0o6II=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=J5HJRCV3meTKLr9IkDATz+tR1ooO0fqAN5yoM7fcS7BR+chfaps3Z96DMNLBwZas8Q
         3y5Ggi8ctbkNlsq0T6rgsKFQ69N80TuhkawyReerON2h7ZttIkLfNLxIEpuuSBwZefoE
         cYBgs9gqRG1bRddhyrJUfAudGMoWI3m5H9svk=
Received: by 10.204.75.22 with SMTP id w22mr7509137bkj.65.1302699236690;
        Wed, 13 Apr 2011 05:53:56 -0700 (PDT)
Received: from localhost.localdomain (abwp92.neoplus.adsl.tpnet.pl [83.8.239.92])
        by mx.google.com with ESMTPS id 16sm327869bkm.6.2011.04.13.05.53.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 05:53:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3DCrQ8B027926;
	Wed, 13 Apr 2011 14:53:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3DCr8Ne027919;
	Wed, 13 Apr 2011 14:53:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5222475.65704.1302693678918.JavaMail.www@wwinf8226>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171451>

axel.ml@laposte.net writes:
> Jakub Narebski wrote:
> > Axel  writes:
> > 
> > > I set up a git server with HTTP authentication with Apache through
> > > LDAP (Debian Squeeze + Apache 2.2 + mod_authnz_ldap).
> > > 
> > > I m using gitweb for browsing the repositories. At this moment, the
> > > commiter name appears to be the local user who called "git push".

The comitter name is local user who created a commit (as specified in
his/her configuration file, fallback to GECOS).

> > > The username used for HTTP authentication is not used as
> > > commiter name, though the REMOTE_USER environment variable is
> > > defined.
> > > 
> > > After a quick look at http-backend.c it looks like the
> > > GIT_COMMITER_NAME variable should have been defined with the
> > > REMOTE_USER variable. Is this right ?

No, it isn't.

> > > In Apache access logs, the REMOTE_USER appears to be defined in the
> > > last request of the push :
> > > 
> > > 127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "GET
> > > /git/sandbox/info/refs?service=git-receive-pack HTTP/1.1" 200 467 "-"
> > > "git/1.7.2.5"
> > > 127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "POST
> > > /git/sandbox/git-receive-pack HTTP/1.1" 401 618 "-" "git/1.7.2.5"
> > > 127.0.1.1 - ldapuser [13/Apr/2011:11:45:08 +0200] "POST
> > > /git/sandbox/git-receive-pack HTTP/1.1" 200 353 "-" "git/1.7.2.5"
> > > 
> > > Is this behaviour expected ?
> > 
> > I don't quite understand.
> > 
> > With push over _any_ transport you transfer commits from your
> > repository to remote repository *without changing them*. Committer is
> > a person who created a commit, i.e. did "git commit" (or "git am", or
> > "git rebase", or "git merge").
> > 
> > The only place where user who did "git push" can appear in is _reflogs_
> > (I don't know if it appears or not)... but gitweb doesn't show wny
> > reflog information. That of course can be improved...
> > 
> 
> Indeed I wrongly used the "commit" word. I'm switching from
> SVN/WebDAV, and the HTTP authentication name is usually used as the
> commiter name in the SVN repository. This name was informative only
> but useful when browsing repository and logs.

This is because Subversion is CENTRALIZED version control system:
creating a commit involves contacting central server that holds
repository.  If you use HTTP(S) to contact this central server, then
of course HTTP authentication name will be used for "committer" name
(IIRC Subversion has only _author_ name, not separate author and
committer names like in Git[1]).

Git on the other hand is DISTRIBUTED version control system.  Here the
act of creating a commit is decoupled from the act of publishing[2].
User creates commit in his/her local clone (copy) of repository, using
their local configuration, and then push to some distribution point
(depending on workflow).

For git-aware push transports (ssh, "smart" http, IIRC also file) you
can configure git via hook mechanism to check comitter and reject
pushes if there are commits that were not made by the person who is
doing the push.  See e.g. update-paranoid in contrib/hooks/ area of
git.git repository, Gitosis and Gitolite git repository management
solutions.


[1] Author is usually the same as committer -- it can be different
    if for example you are applying (with "git am") patch from somebody
    else you got e.g. via email.

[2] Credentials used for authentication when pushing doesn't need to
    have anything in comon with configured user identity.

> 
> I would have enjoy to reproduce this behavior with git/http, since
> it's common (in our organisation at least) that the commiter is the
> pusher. In fact until today the authentication was almost only used
> as tracing commiters in logs and not really for security
> considerations.
> 
> So I assume that it s cannot be done for the moment :)
> Thanks for your answer !

Could you explain in more detail _what_ behavior would you like to
see?  Gitweb does display author and comitter (though in 'log' and
'shortlog' only author is visible).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
