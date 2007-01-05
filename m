From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC] git-remote
Date: Fri, 5 Jan 2007 13:59:25 +0100
Message-ID: <8aa486160701050459p4da586cdk2c2ddaabda5b4ca7@mail.gmail.com>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 13:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ofX-00040a-U9
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 13:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbXAEM71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 07:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbXAEM71
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 07:59:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:42658 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965156AbXAEM70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 07:59:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5697903uga
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 04:59:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tfqd3NbjHVmC8HZHd15xvTNNeNySywVNasgfaOj/MxW3gOKE6RC9yzTR7OqkcWXwYT7MOazRT5jWyqREe/doM3GGe8T4l7ElYv36oZ0Voe5xrGMn2FFP079gn/nLlC6sOZyUG2uV/Dl4NeTe0PaA+AeIASVToVPhOMC2zvvtpPQ=
Received: by 10.78.205.7 with SMTP id c7mr2942566hug.1168001965205;
        Fri, 05 Jan 2007 04:59:25 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 5 Jan 2007 04:59:25 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36000>

+1. And much better than my RFC for "git clone --add".

Just some comments. I know it's in its early shape, tell me if you
want this kind of comments later.

* I think it is more coherent to list the tracked branches first and
second the "branch merges".

* In "git remote add <name> <remote>": git could use the remote url to
deduce a <name>, like what git-clone does.

* If a branch does not have a branch.<name>.remote git-remote does not
default it to "origin" and sends an:

Use of uninitialized value in string ne at
/home/santi/usr/stow/git/bin/git-remote line 222.

Maybe, in addition to this, git should require a branch.<name>.remote.

* With the config:

[remote "origin"]
        url = git://git2.kernel.org/pub/scm/git/git.git
        fetch = master:refs/remotes/origin/master
        fetch = next:refs/remotes/origin/next
        fetch = +refs/heads/pu:refs/remotes/origin/pu
        fetch = refs/heads/*:refs/remotes/origin/*

[branch "next"]
        merge=next

It outputs something as:
* remote origin
  URL: git://git2.kernel.org/pub/scm/git/git.git
  Tracked remote branches
    html maint man master next pu todo
  Tracked remote branches
    pu

* The first "Tracked ..." is for the wildcards and the second for the
explicit fetch. Maybe it should join the two or mark different as:

  Implicit tracked ...
  Tracked ...

* The next and master branches are missing because they are written
without the refs/heads/ prefix. And for this reason there is no:

Remote branch(es) merged with 'git pull' while on branch next
  next

(and the absence of branch.next.remote).

* In addition I would reformat this as:

Merges with 'git pull' while on branch:
  "next" merges "next"
  "topic" merges "master"
  ...

That's all for today :)

Santi
