From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] submodule: Add --force option for git submodule update
Date: Thu, 31 Mar 2011 20:13:29 +0200
Message-ID: <4D94C449.1040903@morey-chaisemartin.com>
References: <4D92E225.3040602@morey-chaisemartin.com> <4D93773C.2010807@web.de> <4D937B7E.10808@morey-chaisemartin.com> <4D937F09.10000@web.de> <4D93905E.5030806@morey-chaisemartin.com> <7vd3l8mi3m.fsf@alter.siamese.dyndns.org> <4D93E4F1.70103@morey-chaisemartin.com> <4D94BCCC.7090808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5MNI-0001dV-F0
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872Ab1CaSNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:13:34 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:55929 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752280Ab1CaSNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:13:33 -0400
Received: (qmail 14307 invoked by uid 503); 31 Mar 2011 18:02:54 -0000
Received: from b9.ovh.net (HELO mail417.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 31 Mar 2011 18:02:54 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 31 Mar 2011 20:13:30 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 31 Mar 2011 20:13:29 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4D94BCCC.7090808@web.de>
X-Ovh-Tracer-Id: 14143836105977421751
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170507>

On 03/31/2011 07:41 PM, Jens Lehmann wrote:
> We are in a similar situation at my dayjob, but we handled the issue in
> a different way. We were reluctant to check in generated files into our
> repository, so we decided to distribute them via zip files. We have a
> beefy build machine which builds and tests master over night and if
> everything went ok it zips the whole work tree including .git directory,
> build artifacts and submodules into one file. Then each developer just
> has to unpack this file, fetch from the git server and he is all set.
> 

We have something a bit similar for cross project dependencies.
We just store in project a file with the SHA1 to another one and we have a server which stores all the packages ever generated
and a sqliteDB to have the  SHA1 <=> package relation.
It works but it requires to add DB files, CGI script to update/query the DB...
So we limited this only to a few dependencies between otherwise separated projects.
For the rest, it's just easier to commit generated small files.


> 
> Me too agrees that being able to reset a whole work tree including all
> submodules recursively makes a lot of sense. But I would not be so happy
> seeing this functionality being added to the git-submodule.sh script, as
> I believe it belongs into "git reset", so you'll just have to do a "git
> reset --hard --recurse-submodules" and you are done.
> 
Yes it is probably easier and clearer for everyone to put it into the dedicated command.
This way you know it does the same thing it usually does except on all submodules.
Thinking about "git submodule reset" I started wondering about what should be done for indexes, checked out files, ignored files and so on,
and whatever is chosen it will confuse pretty much everyone.
Also a git clean --recurse-submodules would be nice !

> In the branch "git-checkout-recurse-submodules" in my github repo (which
> is at https://github.com/jlehmann/git-submod-enhancements) you can see a
> preliminary implementation of that (it works and I use it every day at my
> job. It has recursion enabled by default at the moment yet still might
> overwrite local changes even if it shouldn't, so use with care ;-).
> 
I'll have a look at it. For the moment I use a bash script which recurse in all submodules doing git clean and git checkout all other the place
(it also works with old gits that lack all the foreach and --recursive features)

>> But I also still think having a --force option to update does too, in the way Jens proposed it (only on submodule that actually needed a checkout), don't you?
> 
> Yes, I still think it makes sense to add the "-f" flag to submodule update.
> 

If Junio agrees with the idea, I'll repost a much simpler version of the path that just add -f for the submodules that needs it.

Nicolas Morey-Chaisemartin
