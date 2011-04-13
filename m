From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 04:00:37 -0700 (PDT)
Message-ID: <m3sjtm2z8e.fsf@localhost.localdomain>
References: <4DA57183.6040308@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Axel <axel.ml@laposte.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 13:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9xoU-0006aQ-FQ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 13:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355Ab1DMLAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 07:00:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54037 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1DMLAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 07:00:41 -0400
Received: by bwz15 with SMTP id 15so458008bwz.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=v0OOafqd9a8uPfbELTXoHf1C6Dabk3piNZwzQs0OGJo=;
        b=stUuQB4/bGg86X4SS2PpICXXsSDpcoeuf5Nd0B+h4raGOQKw+Nxp4B/e59FP6uhEVv
         r4sUXVn0pFzW903h0TGHylMy5SY/ixb9o7RzYjglfUnzeubmNgLnFX5lkaZ41Sqqmc/g
         ky96+/9ZVi+B1rmMm6NAmLzScRUsqh9blXNAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=IIAyRZr9deOdd6v1Bn5PDksmv2lrGsEKEmocDZGogrubGAEOVe2bWHXVH/z4NfD4gx
         0BFCNdwX0DUuAJHnagRDUHJ3N6hUpxLC61fByxM6a/S6RBJ5LKMAfn4I2xfcmcciSqgS
         Nly7dhL1qmcpbi7KT1DL20FsttoUvZcIDcW+U=
Received: by 10.204.136.213 with SMTP id s21mr1847097bkt.0.1302692439721;
        Wed, 13 Apr 2011 04:00:39 -0700 (PDT)
Received: from localhost.localdomain (abwp92.neoplus.adsl.tpnet.pl [83.8.239.92])
        by mx.google.com with ESMTPS id a23sm265601bkc.4.2011.04.13.04.00.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 04:00:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3DB05YI026814;
	Wed, 13 Apr 2011 13:00:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3DAxjTS026807;
	Wed, 13 Apr 2011 12:59:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4DA57183.6040308@laposte.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171442>

Axel <axel.ml@laposte.net> writes:

> I set up a git server with HTTP authentication with Apache through
> LDAP (Debian Squeeze + Apache 2.2 + mod_authnz_ldap).
> 
> I m using gitweb for browsing the repositories. At this moment, the
> commiter name appears to be the local user who called "git push". The
> username used for HTTP authentication is not used as commiter name,
> though the REMOTE_USER environment variable is defined.
> 
> After a quick look at http-backend.c it looks like the
> GIT_COMMITER_NAME variable should have been defined with the
> REMOTE_USER variable. Is this right ?
> 
> In Apache access logs, the REMOTE_USER appears to be defined in the
> last request of the push :
> 
> 127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "GET
> /git/sandbox/info/refs?service=git-receive-pack HTTP/1.1" 200 467 "-"
> "git/1.7.2.5"
> 127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "POST
> /git/sandbox/git-receive-pack HTTP/1.1" 401 618 "-" "git/1.7.2.5"
> 127.0.1.1 - ldapuser [13/Apr/2011:11:45:08 +0200] "POST
> /git/sandbox/git-receive-pack HTTP/1.1" 200 353 "-" "git/1.7.2.5"
> 
> Is this behaviour expected ?

I don't quite understand.

With push over _any_ transport you transfer commits from your
repository to remote repository *without changing them*.  Committer is
a person who created a commit, i.e. did "git commit" (or "git am", or
"git rebase", or "git merge").

The only place where user who did "git push" can appear in is _reflogs_
(I don't know if it appears or not)... but gitweb doesn't show wny
reflog information.  That of course can be improved...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
