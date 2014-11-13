From: Roger Gammans <roger@gammascience.co.uk>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 12:02:29 +0000
Message-ID: <1415880149.4825.43.camel@knuth.computer-surgery.co.uk>
References: <20141113111444.GA15503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:40:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xothh-0000YE-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 13:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbaKMMkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 07:40:45 -0500
Received: from dsl-217-155-142-77.zen.co.uk ([217.155.142.77]:59558 "EHLO
	turin.computer-surgery.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932562AbaKMMkp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 07:40:45 -0500
X-Greylist: delayed 2288 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Nov 2014 07:40:44 EST
Received: from knuth.computer-surgery.co.uk ([192.168.131.67])
	by turin.computer-surgery.co.uk with esmtp (Exim 4.72)
	(envelope-from <roger@gammascience.co.uk>)
	id 1Xot6c-0003pA-0y; Thu, 13 Nov 2014 12:02:30 +0000
Received: from roger by knuth.computer-surgery.co.uk with local (Exim 4.82)
	(envelope-from <roger@gammascience.co.uk>)
	id 1Xot6b-0002AU-T4; Thu, 13 Nov 2014 12:02:29 +0000
In-Reply-To: <20141113111444.GA15503@aepfle.de>
X-Mailer: Evolution 3.8.5-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2014-11-13 at 12:14 +0100, Olaf Hering wrote:
> How can I reduce the disk usage for multiple copies of the same repo?
> 
> Up to now I just made copies like this, but since .git alone is already
> 2GB it becomes expensive:
> 
>  # git clone git://host/repo.git repo-master
>  # cp -a repo-master repo-branchA
>  # cd repo-branchA
>  # git checkout -b branchA origin/branchA
>  # cd -
>  # cp -a repo-master repo-branchB
>  # cd repo-branchB
>  # git checkout -b branchB origin/branchB
>  # cd -
>  # cp -a repo-master repo-branchB-feature
>  # cd repo-branchB-feature
>  # git checkout -b branchB-feature origin/branchB
>  # cd -
> 
> 
> Since each .git is almost identical I wonder if there is a reliable way
> to "share" it. The "git clone" man page mentions --shared as a dangerous
> way to do things. It does not give an advice how to manage such cloned
> trees.

But you're not using clone you are using cp .

The clone man page also says this:-
      --local, -l
           When the repository to clone from is on a local machine, this flag bypasses the normal "Git aware" transport
           mechanism and clones the repository by making a copy of HEAD and everything under objects and refs directories. The
           files under .git/objects/ directory are hardlinked to save space when possible.

           If the repository is specified as a local path (e.g., /path/to/repo), this is the default, and --local is essentially
           a no-op. If the repository is specified as a URL, then this flag is ignored (and we never use the local
           optimizations). Specifying --no-local will override the default when /path/to/repo is given, using the regular Git
           transport instead.


Note the first sentence of the second paragraph.
 eg:
 # git clone git://host/repo.git repo-master
 # git clone repo-master repo-branchA
 # cd repo-branchA
 # git checkout -b branchA origin/branchA
 # cd -
 # git clone repo-master repo-branchB
 # cd repo-branchB
 # git checkout -b branchB origin/branchB
 # cd -
 # git clone repo-master repo-branchB-feature
 # cd repo-branchB-feature
 # git checkout -b branchB-feature origin/branchB
 # cd -

Should work better for you. And there is probably a way to do it less
commands too.

-- 
Roger Gammans <roger@gammascience.co.uk>
