From: "Aaron S. Meurer" <asmeurer@gmail.com>
Subject: git bisect problems/ideas
Date: Sat, 15 Jan 2011 00:33:12 -0700
Message-ID: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 15 08:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe0iD-0001P5-7y
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 08:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab1AOHdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 02:33:24 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53377 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1AOHdX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jan 2011 02:33:23 -0500
Received: by iwn9 with SMTP id 9so3221766iwn.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 23:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=lYViMHSMliUGc9eS94Nc8fsR+yY8Q8GIafOmEr7mNJU=;
        b=anjfN++594KADbj2ryiclkvU2HD8nS5VQqh0BGjGA7o5drNcDyNdKWPZwmkfRueLEq
         dEBWmsdEFIpwAU6094BkaQz6/lZI/3RVBOOLHxvZXxaZJB7d7AH2ibgM0gv3Hsi+XPrz
         9dBl5Smb/Oyks+XTex/bKdZn/2Z9SHjxn5BAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=HpyCfS45EzsQvVN/2odR9AW4o4lfYa/YtQnvqH7f4+2xQNy9htP0oZLFS15EQM5M6J
         kJKxBAGVVPLuO+fc8HPvANc22earbyHJYgyCqjl38w29SCXVuUIjkyQpWoEq3pH8UGEF
         xmJRuYObG+Ob/+HfSvygwxroCERjWpktcFv/w=
Received: by 10.231.17.77 with SMTP id r13mr1697704iba.38.1295076802973;
        Fri, 14 Jan 2011 23:33:22 -0800 (PST)
Received: from [192.168.1.130] (c-68-42-39-41.hsd1.nm.comcast.net [68.42.39.41])
        by mx.google.com with ESMTPS id gy41sm1683953ibb.5.2011.01.14.23.33.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 23:33:22 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165141>

First off, do you guys have an issue tracker?  I asked on IRC, and someone told me that he didn't think you did, and to just post here.  After searching your websites, as far as I can tell he was right, though this is amazing to me that you can handle a project like this without an issue tracker.  If you guys really do, then sorry.  I would rather post this there than here (though if you really do, please make it more findable!)

I just noticed this error/bug:

git checkout test
git bisect start 
<do some bisecting>
git branch -D test
<finish bisecting>
git bisect reset

And it gives an error, because test has been deleted.  This is in 1.7.3.5.  Now, I looked through the log of the current master of git to see if anything has been done about this, and all I noticed was the commit 3bb8cf88247db5, which essentially improves the error message.  

Now, this is good, because it seemed to me above that I was stuck bisecting until I recreated the test branch.  I did not realize the git bisect <commit> syntax until later.  

But this has brought me to bother you guys about something that has been bugging me for a while. I hate git bisect reset.  90% of the time I do not want to go back to where I started bisecting.  I would much prefer to just have a git bisect stop command, which just stops the bisecting process, but leaves me where I am (like a shortcut to git bisect reset HEAD).  This would be much more symmetric with git bisect start.

While we are on the topic of bisecting, I have another issue.  Can we remove the restriction that a "bad" commit come after a "good" commit?  I'd say about 70% of the time I use bisect to find a commit that fixes a bug, not breaks it.  Whenever this happens, I have to bend my mind over backwards to remind myself that the good behavior is really "bad" and the bad behavior is really "good".  Is there a reason that git bisect can't just introspect from which comes earlier and which comes later to see which is "good" or "bad" (instead of just raising an error when they are in the "wrong" order)?

Aaron Meurer