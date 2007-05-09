From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 14:48:38 -0700
Message-ID: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
References: <20070509.020916.80034730.davem@davemloft.net>
	<7vvef2t36n.fsf@assigned-by-dhcp.cox.net>
	<20070509.130614.15589957.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Wed May 09 23:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlu2A-00038U-Jp
	for gcvg-git@gmane.org; Wed, 09 May 2007 23:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbXEIVss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759316AbXEIVss
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 17:48:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54972 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759128AbXEIVsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 17:48:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509214843.CKSY26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 17:48:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x9oj1W00Q1kojtg0000000; Wed, 09 May 2007 17:48:44 -0400
In-Reply-To: <20070509.130614.15589957.davem@davemloft.net> (David Miller's
	message of "Wed, 09 May 2007 13:06:14 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46794>

David Miller <davem@davemloft.net> writes:

> From: Junio C Hamano <junkio@cox.net>
> Date: Wed, 09 May 2007 08:41:20 -0700
>
>> There is something very wrong.  "-l -s" should never go to the
>> "remote: Generating pack..." codepath.  Is that reproducible?
>
> Every single time on master.kernel.org
>
>> Could you try "sh -x git-clone" it?
>
> Sure:
>
> + unset CDPATH
> + '[' -n '' ']'
> + quiet=
> + local=no
> + use_local=no
> + local_shared=no
> + unset template
> + no_checkout=
> + upload_pack=
> + bare=
> + reference=
> + origin=
> + origin_override=
> + use_separate_remote=t
> + depth=
> + no_progress=
> + test -t 1
> + case "$#,$1" in
> + bare=yes
> + shift
> + case "$#,$1" in
> + no_checkout=yes
> + shift
> + case "$#,$1" in
> + use_local=yes
> + shift
> + case "$#,$1" in
> + local_shared=yes
> + use_local=yes
> + shift
> + case "$#,$1" in
> + break
> + repo=../torvalds/linux-2.6.git
> + test -n ../torvalds/linux-2.6.git
> + test yes = yes
> + test yes = ''
> + no_checkout=yes
> + use_separate_remote=
> + test -z ''
> + origin=origin
> ++ get_repo_base ../torvalds/linux-2.6.git
> + base=

This part puzzles me.  The only way I could reproduce this was:

$ ls -F victim victim.git
ls: victim: No such file or directory
victim.git:
./   HEAD	config	 description	       hooks/  lost-found/  refs/
../  branches/	config~  gitcvs.master.sqlite  info/   objects/     remotes/
$ mkdir j
$ cd j
$ git clone --bare -l -s -n ../victim new.git

That is, I did not have ../victim but I did have ../victim.git/
repository, and I gave the former to "git clone".

But that suggests that you do not have ../torvalds/linux-2.6.git
directory but instead have ../torvalds/linux-2.6.git.git/ which
sound a bit insane.

Puzzled...
