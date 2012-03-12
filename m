From: Zdenek Crha <zdenek.crha@gmail.com>
Subject: Git clone behave strange after active branch change in bare repo
Date: Mon, 12 Mar 2012 11:10:03 +0100
Message-ID: <CA+OUE95+Ux_+hSRJw6MH-kh54JewXx-fbWqBoh-Eh_P1tNwAFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 11:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S72Ch-0008Fw-62
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 11:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab2CLKKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 06:10:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40005 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2CLKKE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 06:10:04 -0400
Received: by gghe5 with SMTP id e5so2345189ggh.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ar9WtN/fkJDUat2yF4QoX1baKUMj/9MOzpWIdFhGxmI=;
        b=xC8zJHpppRQ66KqOqgGwewByM+87FeoQ2OGI7b6/vQ3sJhxn2+lpEatxW0MppvZqz4
         PFUUoopUfBOJmWwxwkC3JG1sQl5TvnyzR9OIo/ekbqCAYFbv+mqw37uz0OVK7lv/cwjH
         l82HmzHJ1GIZ8/AYD8fqE2v2LpVuREfDWjxlf3r/v1kzpx3moxAUYnNHgSIjw7plOuFh
         on+4AVltaWeSbac87SUAGsSIfmLV9ZnTn9pxOaqQ6vdc56yv7YLHXdcBVkhfsMAHu51R
         20P2AJ/Eb+SB7FWLc6PmWjZhukH00oWpdnjqi2VK1ARuzoqt4ATWsvKPXsR94yQWyFJ3
         0czg==
Received: by 10.229.76.139 with SMTP id c11mr2313275qck.1.1331547003831; Mon,
 12 Mar 2012 03:10:03 -0700 (PDT)
Received: by 10.224.202.195 with HTTP; Mon, 12 Mar 2012 03:10:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192850>

Hello,

I'm trying to change active branch on bare repository to force
checkout of different branch than master when directory is cloned. The
git version I'm using is  1.7.9.1 from debian repository.

I've used git-symbolic-ref to change active branch without problem:

$ cd repository.git
$ git branch
* master
$ git branch a_branch
$ git symbolic-ref HEAD refs/heads/a_branch
$ cat HEAD
ref: refs/heads/a_branch

When I run git clone while 'master' and 'a_branch' point to same
commit, I will get clone with default branch 'master' where I would
expect default branch 'a_branch'.

$ cd .. && git clone repository.git repo
$ cd repo && git branch
* master

I've tried to remove master branch and I've got result I've expected -
new clone has one branch checked out, the 'a_branch'.
But then I created another branch on the commit pointed by active
branch and tried to clone:

$ cd repository.git && git branch AAA
$ cd .. && git clone repository.git
$ cd repo && git branch
* AAA

I did few more checks and it seems to me that:

* when active branch is 'master' then default branch in clone is
always master as expected
* when active branch is different from 'master', then the default
branch in clone is a first branch in alfabetically sorted list of
branches that point to same commit as active branch

Is this behaviour correct or did I run into a bug?

Regards,
Zdenek Crha
