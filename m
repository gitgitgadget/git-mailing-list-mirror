From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: git svn's performance on cloning mono's branches/tags...
Date: Fri, 26 Jun 2009 01:39:35 +0100
Message-ID: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 02:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJzTs-0002jw-Ad
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 02:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbZFZAjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 20:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZFZAjf
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 20:39:35 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:15594 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbZFZAje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 20:39:34 -0400
Received: by ey-out-2122.google.com with SMTP id 9so185368eyd.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=rp49pT8/I1nZZzYu8QpBaNrHeSD26UHtQWaCbSKXmEk=;
        b=gcV7Lzoyr61AVO41hmKo7/P6gn3cZNI25gnDWWv2HZAR9OqVaEopNFOCMAatHfS/3B
         qcE4n8Po9lFlP5qQwHzPgAoGclk6vql5Z04KbfQWaMMt6ezKS59I8Y207dv8vwO+mijU
         cNXh5TkFzapBL3mG1qrM/mXTtNQVp/0IGToRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cnapwyoAZ+7706eg5KJGg17AUSKe6Sg1+VuW67CY/vs+SST/BA/SunCfcgCLpr6VDE
         U1sW7P+0LHaOgaKEnA6AzI4CH85qMJPGwTLou1ulXGsB3s1yEqDH7UBXdctFoiG3Ha50
         DGHVvfT5rqXuz1L8BXSb25C1zgw0Yekfd2ylk=
Received: by 10.216.73.193 with SMTP id v43mr991330wed.157.1245976775787; Thu, 
	25 Jun 2009 17:39:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122263>

(I'm not on list so please CC) - I am trying to git svn clone mono's
repository, and for some strange reason it is doing a complete check
out from revision 1 all the way to each branch/tag . Is this normal or
am I doing anything wrong? I have git svn clone a few other things
recently (R, ghostscript) and I don't remember git doing this, but R
is quite a normal svn layout and I think I only have ghostcript trunk
(no branch/tag).

What I did was this: I started out with just git-svn clone trunk
(which generated the first two [now-commented out] lines), then I
thought I also want 2.4 branch so I added the next commented-out
section, and ran 'git svn fetch --all'. Then I thought I like the
whole thing - so I commented out most of it and added the 4 lines as
blow - which is also my current git config.

The problem is that it seems to treat every tag as a branch, and also
seem to want to check out every revision from r1 up to r3382 for
MONO_0_10, etc.
to mono/tags/MONO_0_10@3382 , and r1 to r2598 for mono/tags/MONO_0_9@2598 , etc.

--------------------------------------------------------------------
[svn-remote "svn"]
#	url = svn://anonsvn.mono-project.com/source/trunk/mono
#	fetch = :refs/remotes/git-svn
  url = svn://anonsvn.mono-project.com/source
  tags = tags/*/mono:refs/remotes/mono/tags/*
  branches = branches/*/mono:refs/remotes/mono/branches/*
  trunk = trunk/mono:refs/remotes/git-svn
#[svn-remote "mono24"]
#	url = svn://anonsvn.mono-project.com/source/branches/mono-2.4/mono
#	fetch = :refs/remotes/git-svn-mono24
--------------------------------------------------------------------

I guess my ultimate question is, how does one modify git config to
track tags and branches, etc as well, *after* having already svn
clone'd trunk?, without burning too much bandwidth?
