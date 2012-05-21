From: demerphq <demerphq@gmail.com>
Subject: Is it by design you can create a branch called 'HEAD'?
Date: Mon, 21 May 2012 11:14:58 +0200
Message-ID: <CANgJU+UAbpFvROFynZ-MHzfhEYksM-Mhf5rVjcA6GUhk6BX-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 11:15:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWOhk-0000p7-6I
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 11:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab2EUJPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 05:15:00 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41351 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab2EUJO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 05:14:58 -0400
Received: by gglu4 with SMTP id u4so4098266ggl.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=UvDIkDpwa8NMXOjay4cC7o2b15/kbf3vY1+r0P6fUqw=;
        b=qmcSjsrA+CkZCJoU4eiSocPHDnBdLVi163PhE/0fIVAj4iAc5FeBuZLuBZ6ApmfP5r
         Wfs3XNfgFdTw+43xAnkrR/mdeziq90TMH67lTe/nsffWw9InUT3edWrOjWc7ZowHhoGy
         dR9mfwAMb08hsxLvLciQSMOrY2DwW0nkgioUQzDdOF2HGZKlUGz71acPBuxjIG0snHCB
         cX8aUYxjOM3L05lhB7XLoAlVKYMHQHiy5cVb1H/XWVjSld7Te0u+QC6oFRi8hbaLFO7m
         ON6yByc/TOolf4nzgriwoyYdqF4IEIZq4pyBXd/6gHyvXhgCHmNJvgdQIAWFgzPfES9b
         3IKg==
Received: by 10.236.197.74 with SMTP id s50mr2870660yhn.96.1337591698131; Mon,
 21 May 2012 02:14:58 -0700 (PDT)
Received: by 10.236.152.35 with HTTP; Mon, 21 May 2012 02:14:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198098>

One of our devs managed to push a branch called HEAD into our master
repository, which then caused various failures for people doing pulls.

   c2014aa..cbe0021  trunk      -> origin/trunk
error: Ref refs/remotes/origin/trunk is at
cbe002152fcc917216ad9003037309893f09901d but expected
c2014aa485130013ca7eda1cb4a4eef192f9406d
 ! c2014aa...2bb416b HEAD       -> origin/HEAD  (unable to update local ref)

And warnings like:

$ git log HEAD
warning: refname 'HEAD' is ambiguous.

(we renamed master to 'trunk' long ago for various reasons)

In order to clean it up we found that there was an entry

2bb416bb4a44fbd61f29479d63a95705a7044e32 refs/heads/HEAD

in our master packed-refs file, along with the normal HEAD file:

$ cat HEAD
ref: refs/heads/trunk
$ cat refs/heads/trunk
0752c05e75dd645833fb0ea7ce8e534cbd603f0b

I deleted that line and then we removed these (output of find -ls)

20119672    0 -rw-rw-r--   1 root     cvs             0 May 21 01:26
./logs/refs/remotes/origin/HEAD
20120092    4 -rw-rw-r--   1 root     cvs           162 May 21 01:26
./logs/refs/heads/HEAD

And things seemed to be fine. (yes we hillariously call our git user
group cvs :-)

So I am wondering, did we do the cleanup right?  Is this behavior by
design? What is the most appropriate way to prevent it from happening
again?

I will try to find out from the responsible dev if they have their
command history available to see what they did.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
