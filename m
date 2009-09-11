From: Daniele Segato <daniele.bilug@gmail.com>
Subject: previously committed file untracked prevent checking out an old 
	tag/branch
Date: Fri, 11 Sep 2009 13:26:35 +0200
Message-ID: <9accb4400909110426v2a42086ema318167e94b2cbc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 13:26:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm4H7-00006K-LY
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 13:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbZIKL0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 07:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbZIKL0e
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 07:26:34 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:47078 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbZIKL0d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 07:26:33 -0400
Received: by fxm17 with SMTP id 17so718057fxm.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=HlWgIU7XL8L0OVuKhPFEbNuWAzwnTstb14Dh1DXmm7o=;
        b=WBaSAhUt4cWoHeJyloa4awYt/8FrBi8+MwAO6X7ubjKhGJsPbyUUKHnKkasTwQ/ubh
         j2kGEuwAWa3Cki2BT5dO+eZ5yttFUwlI6ifHTnRuzDZOm4pnN0L7O20hoULONSLf1giS
         QSvTnAnXzomZNoCFDrtyEK8VM5MIZ2G/eCcG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iDULEdlxlR4KdLwarfDQXhe7aS9GYoTk6CyQYCwLG5Igf+wz/J/z8T76kBc5RW9wzu
         lJ0LXhkSGqsmCHU/KPjMdo76jpH+2rI3qlerbZinX/dDUAc2Q9oBH4Hl5hysJug6ELZ3
         eUBM5zyxe8fznYfc5AcpxfZLYyNczWM6o2xdw=
Received: by 10.204.34.201 with SMTP id m9mr1983274bkd.77.1252668395822; Fri, 
	11 Sep 2009 04:26:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128189>

Hi,

I had this situation:

we used to have a properties file in our project that was used by ant
to build it.
That file was tracked since the beginning of the project (several months ago).

let's call it:
build.properties

(the project is on SVN and I'm the only one to use git)

Since everyone in the project has different directories paths I
decided to untrack the file
create a new template file and track it instead:

so I did something like this:

cp build.properties build.properties.template
vim build.properties.template
echo build.properties >> .git/info/exclude
git rm --cached build.properties
git add build.properties.template
git commit -m "finally we don't overwrite it each other anymore"

Now I had to switch back to a tag that still have that file
(build.properties) tracked to fix some
issue there but when I try I get:

error: Untracked working tree file 'build.properties' would be
overwritten by merge.

How would you handle a situation like this?

I only can think of doing a backup of my build.properties, delete it
and check out the tag or I just delete it and rebuild
it from the template later.

I did it but that made me think on it.

Actually what I really wanted here was the possibility to "locally
track" that file...

something like
git local <file>

that will have that file indexed by git so I can switch to branch that
have that file without loosing it when I go back.
furthermore that would allow me to keep versions of my local file even
if I don't want to commit it.
I could see if I accidentally modified it.

This could be useful, in my opinion.

Is there on git a feature to do something like that?
Do you think it could be useful or do you see any possible problem about that?

Regards,
Daniele
