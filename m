From: Thomas Adam <thomas@xteddy.org>
Subject: Certain git commands fail with "returned error: 128" running via 
	Git.pm under mod_perl
Date: Thu, 15 Apr 2010 10:22:41 +0100
Message-ID: <x2k18071eea1004150222x2980feb5ub9b15ec0522dd5ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 11:23:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2LHr-0000hn-Pv
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 11:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab0DOJW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 05:22:58 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63700 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393Ab0DOJW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 05:22:57 -0400
Received: by wwb24 with SMTP id 24so336706wwb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:received:message-id:subject:to:content-type;
        bh=tVoQ+wNhg1OZRMCn+CxTMG/CEEogiPeRs3uuFRKenbk=;
        b=cTz3hzukM6d1T3PGHasOu+dVK2OpfQU5VGvuzKJy0YH3tacwZyer6st2+jWJnp5MeQ
         CpfLn7MzbpC5E+b1IxdFjiNQQflOhlJmnuWdJ2FSFWz2ANJmlXbS/Zt4pui4EXRfvAtx
         tgBuXvLNQa4lWWzuF50G5OtjSR1rLgkqh3gqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=aVMdc5UsaHfS6ImaZvRVIIJ0KD6uHriE4A3ieJ1ejcHaQGTtSNgQccI62FmslX5s1H
         W6+YqRWT3PVlLWoooloq7zqOT4jGIjBgt++lAYrXi6EGfpku3neZgZPl8wsFVH2Gndv5
         6WhUofYB++y0p0fMHjaCEQNdSV7I5NVwqjTtw=
Received: by 10.216.3.15 with HTTP; Thu, 15 Apr 2010 02:22:41 -0700 (PDT)
X-Google-Sender-Auth: 80715f2eb85fd60b
Received: by 10.216.172.202 with SMTP id t52mr6427272wel.21.1271323376342; 
	Thu, 15 Apr 2010 02:22:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144965>

Hello all,

I've got a problem running certain git commands via Git.pm under
mod_perl.  Specifically so far, these commands are "push" and "fetch"
(by way of "git pull").  Running the same command set without mod_perl
works as expected, including running these commands manually.

I won't bother to describe the application, but most web pages within
it will "git pull" and "git push" various bits of information once
they're entered.  When I initially try this out, these commands work
fine, until a point in time when they stop and error with the
following:

trace: built-in: git 'push'
trace: run_command: 'git-receive-pack '\''/var/repository'\'''
trace: exec: 'sh' '-c' 'git-receive-pack '\''/var/repository'\'''
'git-receive-pack '\''/var/repository'\'''
trace: built-in: git 'receive-pack' '/var/repository'
fatal: read error: Bad file descriptor
fatal: write error: Broken pipe
Git command failure:  push: command returned error: 128

Note that in the environment, I have enabled "GIT_TRACE=1", so that I
could at least make some sense of what's going on.  When this happens
-- git will remain failing on this command until I restart Apache.

I said I am using Git.pm -- I am doing nothing fancy other than calling:

Git::command()

What do people think is happening?  The fact that it's intermittent
would suggest to me there's either some global state running these
commands under mod_perl -- and perhaps the reason push returns error
128 with a broken pipe is that it's trying to write to a file handle
that's since closed (STDOUT or STDERR)?  It's a little tricky knowing
where/how to diagnose this.

So any help/pointers would be greatly appreciated.

Kindly,

-- Thomas Adam
