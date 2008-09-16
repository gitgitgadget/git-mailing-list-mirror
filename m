From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Grafts workflow for a "shallow" repository...?
Date: Tue, 16 Sep 2008 17:09:14 +1200
Message-ID: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 07:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfSr9-0004zg-QD
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 07:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYIPFJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 01:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYIPFJR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 01:09:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:39434 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYIPFJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 01:09:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2368416wfd.4
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 22:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=p9nrIQW5gFeXu1a4V4ORWiEaJpNF14gL0j16DKCVJrs=;
        b=dnNYcFM/zuGZjveAg4l2iprza3Thzf8WGqegA0QI44JmcflReXUQeGM5m28nSCgfma
         z576B4bJqMPY6fvAnemaMf/PBYna5aWnsxfMDBP8WjqNY/Q6vQ3mS4W/Ulv6Pe2YwZrv
         vGGfcjOULb5GzQ1TkE77OKPxKVfjZxwVEqMzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=AqunaeRhXvwnq+MgrqDoyQfrQ0zdldRmYE6Sm1olT9Qq9078PnTzBLhHi5mWtMYbO/
         G0ywz3HbGY/ouQcvc5o/g/j4dokSm4I3YefrzwOMJwy7epyR9CPPFoYI03Zs274YpO06
         UBZlk51OjyxYKpmO36YuCDtSj/vk5ezsk6cQY=
Received: by 10.142.14.20 with SMTP id 20mr189673wfn.149.1221541754910;
        Mon, 15 Sep 2008 22:09:14 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Mon, 15 Sep 2008 22:09:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95971>

Here is my attempt at a "let's publish a shallow repository for branch
of moodle". Let me show you what I did...

 # before we start
 git --version
 git version 1.5.5.1

 cat /etc/redhat-release
 Fedora release 9 (Sulphur)

 # clone the 'full' repo ~200MB fully packed
 git clone git://git.catalyst.net.nz/moodle-r2.git

 # 1.7 was a significant release, anything earlier than that
 # is just not interesting -- even for pickaxe/annotate purposes
 # so add a graft point right at the branching point.
 cd moodle-r2
 echo `git merge-base origin/cvshead origin/MOODLE_17_STABLE` >>
.git/info/grafts

 # push the branches I care about to a newly created repo on a different server
 # this is approx 50MB... (as opposed to 200MB)
 git push git+ssh://dev.laptop.org/home/martin/public_git/moodle.git \
    origin/MOODLE_19_STABLE:refs/heads/MOODLE_19_STABLE
 git push git+ssh://dev.laptop.org/home/martin/public_git/moodle.git \
    origin/cvshead:refs/heads/cvshead
 # fixed up the server-side repo to have HEAD pointing to a new branch...

 # clone to see it works...
 git clone  git://dev.laptop.org/git/users/martin/moodle.git

 # and now gitk bails out on me. Not entirely unexpected...
 gitk --all

Is this kind of workflow (or a variation of it) supported? For this to
work, we should communicate the grafts in some push operations and
read them in clone ops - and perhaps in fetch too.

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
