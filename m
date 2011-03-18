From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: same files on different paths on different branches
Date: Fri, 18 Mar 2011 10:20:33 +0100
Message-ID: <1300440036.4261.29.camel@bee.lab.cmartin.tk>
References: <4D82A1F4.4060801@dias.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Raul Dias <raul@dias.com.br>
X-From: git-owner@vger.kernel.org Fri Mar 18 10:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Vrg-0002ck-9J
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 10:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475Ab1CRJUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 05:20:45 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:51806 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384Ab1CRJUo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 05:20:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id C46E11B4B64;
	Fri, 18 Mar 2011 10:20:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSfjJzGnkl4W; Fri, 18 Mar 2011 10:20:36 +0100 (CET)
Received: from [192.168.178.32] (hmbg-5f7777fd.pool.mediaWays.net [95.119.119.253])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CAADF1B4B61;
	Fri, 18 Mar 2011 10:20:35 +0100 (CET)
In-Reply-To: <4D82A1F4.4060801@dias.com.br>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169305>

On jue, 2011-03-17 at 21:06 -0300, Raul Dias wrote:
> Hi,
> 
> I want to know if the following is possible to accomplish with git.
> (please reply to me too)
> 
> A project is composed of many sub-modules (not in git sense).
> These sub-modules are developed independently of the main project.
> They need to be reattached to the projects' tree.
> 
> The problems:
>     1 - a sub-module's tree does not have any projects file.
>     2 - when a sub-module is re-attached to the main project, its files
> are spread in many places (different from the the sub-module layout).
> 
> 
> Ideally the project would understand which files are the same, even on
> different places and apply the changes in the right files.
> This way a merge/cherry picking would keep the history information.
> 
> Is it possible to accomplish something similar to this?
> I understand that this is not how a git super-project works.
> I don't think it is possible with different git repositories.
> 
> I tried with a empty branch technique. 
> Created an empty branch with no history.
> Started a sub-module (non git) there and tried to propagate the changes.
> Git almost did the right thing.
> A change in branch submodule's
>     /foo/a.txt
> should have gone to branch master's
>     /bar/foo/a.txt
> but instead it went to
>     /bar/somethingelse/a.txt (which is the same as /bar/foo/a.txt)

 If the problem you are seeing here is that git reports the physical
path instead of the logical one (compare `pwd -P` and `pwd -l`), then it
shouldn't really represent a problem, as the data is being written in
the right places.

> So is it possible to get closer to this with git  in a way or another?

 git uses almost exclusively physical paths internally, which is why the
user sees them. For example, this also happens:

   carlos@bee:~/apps$ mkdir one
   carlos@bee:~/apps$ ln -s one two
   carlos@bee:~/apps$ ln -s two three
   carlos@bee:~/apps$ cd three
   carlos@bee:~/apps/three$ git init
   Initialized empty Git repository in /home/carlos/apps/one/.git/

 Notice how git is reporting the "right" path.

 Is this the effect you're seeing? Above it's not clear whether you're
using symlinks in your file system or why /bar/somethingelse/a.txt is
the same as /foo/a.txt.

   cmn
