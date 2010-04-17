From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 00:17:17 -0400
Message-ID: <4BC9364D.7020204@gmail.com>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miguel Ramos <mail@miguel.ramos.name>
X-From: git-owner@vger.kernel.org Sat Apr 17 06:17:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2zTS-0004uR-8A
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 06:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab0DQER0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 00:17:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53375 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab0DQERZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 00:17:25 -0400
Received: by vws5 with SMTP id 5so1163925vws.19
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VIatMDS5LSE9geAU7KlvJ2DQ2i99P9h1RzB/LVof9Rg=;
        b=b7lBjcOkPP7d+dN0Oy7Zbbt2yLu8UT7CetsulFxuCFa2CL/yOi4T80/dK/GDsXBE5B
         vxqGE9MQBJgol+oL7VFJO1uSnBZ+tarLMZJ8OFBxxP7KqD95hv6hS8mHQhw9fo8UkUOK
         Vik/U8wVIkQg2M/nm7eLyYIiJB0Y+YclwGqow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uZABb7veCvBPnhytrtQ1DsKeMT1WEDsUAUUWj8lh0lj/KQZjabtCLV2eJoPoLM+rzo
         c8XAsB9zfaP/+a9D3zYmzVgLHb5X6WTjN3ULGpc0vOOdXdJ2DXjLNtuNweCr2qi7BXZR
         NChY3w6MVMWDGUaCx3xFBbNeSZE2St98fMIwo=
Received: by 10.220.108.76 with SMTP id e12mr1688328vcp.24.1271477843205;
        Fri, 16 Apr 2010 21:17:23 -0700 (PDT)
Received: from [192.168.2.202] (dsl-145-179.aei.ca [66.36.145.179])
        by mx.google.com with ESMTPS id z22sm6583880vco.10.2010.04.16.21.17.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 21:17:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145113>

On 2010-04-16 16:44, Miguel Ramos wrote:
> Hi,
> 
> Is it possible with git to use a git repository on the root directory?
> I'm trying to replace subversion doing this.
> I used this method before to get my home directory versioned with
> success, so far.
> 

Although I'll give comments on the rest, is it really relvant to put all
of the filesystem into a version control system? From a system
administrator's point of view, backing up is more about keeping copies
of what's important in the computer than about versioning every tiny
change in the file system.

One example of something that is weird to backup is /var . It contains
data that will almost certainly always change.

A simpler thing to do if you'd like to be able to reinstall a computer
real quick would be to make an image of the computer (call it a ghost, a
dd of all the disk or whatever) and to establish a backup only for the
sensible data (say, for an LDAP server, you would backup ldap's ldiff
files and configuration). Then, restoring from a crash would just mean
to reinstall with the image of the disk and to restore the latest backup.

> When I'm on the root directory, things seem to work minimally. I do
> git status, etc, and get the expected results.
> However, if I change say to /etc, or any other directory, for that
> matter, then git status tells me that every file in the repository is
> deleted.
> Adding files doesn't work, nothing works at all.
> 

This sounds like an issue with finding the actual .git directory when
you are in /etc. is this directory under a different partition than / ?

> I have a populated repository elsewhere, I can clone this to an empty
> directory and then move .git to / to work around the demand that the
> target directory is empty and at the same time avoid overwriting
> files.

so, you're cloning to some temp dir, then moving temp/.git to / and then
using something like git checkout HEAD some/file/somewhere ?

> I know this is an unforeseen use of git, however, unforeseen might not
> imply forbidden.
> I'm pretty disappointed I couldn't get it working.
> 
> So the motivation for this posting is twofold:
> - Is this possible in some other way, or did I do something wrong (I'm
> new to git) ?

Check out the bup project[1], it uses the packfile format from git to
compress data but its focus is more on keeping versions of arbitrary
data rather than code files. it's still very new and lacks some
important features but it sure is promising.

[1] : http://github.com/apenwarr/bup

-- 
Gabriel Filion
