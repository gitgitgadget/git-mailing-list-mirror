From: David Deutsch <dd212303@gmail.com>
Subject: Spontaneous "changes" upon checking out a commit
Date: Wed, 3 Jun 2015 07:57:12 -0400
Message-ID: <CAE-vyzgSqqidjsD7XByLY+T4G78yUtO-q3G63au4uNPO=1_tcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 13:57:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z07IN-0007bG-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 13:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbbFCL5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 07:57:16 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34262 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbbFCL5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 07:57:14 -0400
Received: by wibut5 with SMTP id ut5so99919605wib.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=7Z1PuLBksH50gvapj6ygJdKhbD93l2+FXB+inqhqJ5E=;
        b=ThYlnOIpjGDyxhTTBzpiVpd+BMQvb7ozGb3gpp6PUQ0NZak1xdMvNL0jQPJvPYV3Sg
         GnxP8a1aqwuTwB8hrVNveFIdaXqh1hjnhSKLqBqM3wohiVatEOFFpfHC8uAzk2UEITnm
         HJfrRlGLYjBCcyZGaCxrry0Np4aglLM+gZXOzcEhID7hjVSEtOu1DssbNaGtXqsC9LpD
         JNQ305VX42id4qSzwKgoAHiOLugZLgxUabzSkkbWwbsGZWxPftxL9I/OP2khtxJZhSDo
         GTmswhdZlKdLhn7UxyqIqOaUpAlLhwj2EJdMmFGJehxmrD/+fIaqr7zbP7xWpvvgSiHP
         7c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=7Z1PuLBksH50gvapj6ygJdKhbD93l2+FXB+inqhqJ5E=;
        b=Z8k7NDyNHDeaAnQnSK2wznLrf+HSGbvtctpKlnvffUhL5fKw4KUVw6qBvCjoIwT2iO
         nUb4teahUjW/MRe/wstL6q5aj6UDBKDK6dobSR9OjUEGAVNLCNbqClskAZ6N8zLxbq0P
         fi5LJp/FaYIzUfH4Wf0dRF118HbEizhtYjWb0ITEdTqFZt0nqUxW6/nA8rkr5s1Knuy1
         j6whHHH7P0ZZMNtO96cfwmBmJJESjD98teOyBtUmiAiyBkOsPq5bzY/PoPmN+EZlHLEz
         TXrw46y22d7MSpFDKoHuXH5/1Iaqjvnwk7fsCikoRt6L+oEsEPYsem3/++m7wlabL07H
         ML8A==
X-Gm-Message-State: ALoCoQlmMSu+eEi4TtlbuX9nrlj+Yr4hAY5NiYMFHfNqvVpk6r/3A3brqBA2PCCcjrnxb9KU9z2j
X-Received: by 10.194.172.72 with SMTP id ba8mr60502113wjc.136.1433332632743;
 Wed, 03 Jun 2015 04:57:12 -0700 (PDT)
Received: by 10.27.12.170 with HTTP; Wed, 3 Jun 2015 04:57:12 -0700 (PDT)
X-Google-Sender-Auth: uhA-YaULowDZ_r8lQCNRFF5d4Jw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270680>

When I checkout a particular commit in my repo and immediately do a
git status, there is a file that show up as changed. If I look at the
SHAs for my working copy and the copy in the index/repo, they are
indeed different. The working copy has carriage returns, and while I
*suspect* the copy in the index/repo does not have them, the output
from git cat-file on the repo SHA does have them. In fact, if I
redirect that output to a file and do a git hash-object of that file,
I get back the the same SHA as the working copy.

Doing a git checkout on the file changes nothing, i.e. it is still
marked as changed in git status. Trying to checkout another commit
fails, as my "changes" to the file would be overwritten by the
checkout. Doing a git diff on the file returns nothing.

The repo has a .gitattributes file, which starts out with "* text=auto
!eol". Every file in the repo is explicitly listed in .gitattributes
as -text, *except* the file that has the spontaneous "changes". The
file's suffix is .cs, which I thought was automatically considered
text anyway. On my machine, core.autocrlf is false.

This is running on Windows. Git version is 1.9.5.msysgit.1.

Does anyone know what might be going on here? It is almost as if git
is adding the CRs to the file at checkout, but not "realizing" that
when it comes to deciding if there are local changes.


Thanks for any insight.
