From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Approaches to SVN to Git conversion
Date: Tue, 06 Mar 2012 22:34:35 +0000
Message-ID: <4F5690FB.9060800@pileofstuff.org>
References: <4F536FE9.1050000@pileofstuff.org>	<3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail> <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:34:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S52xy-0006it-GD
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031440Ab2CFWel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:34:41 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:15381 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932377Ab2CFWek (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 17:34:40 -0500
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120306223438.LCYY4985.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Tue, 6 Mar 2012 22:34:38 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120306223438.MWDX13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Tue, 6 Mar 2012 22:34:38 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=UeB0h7Mj1QQA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=ldoSWnGv_9LSegc5pVsA:9 a=altUZwVp51YrHzLX0G0A:7 a=wPNLvfGTeEIA:10 a=xTM7YQ8IwH4A:10 a=cAoI8KDWk3EA:10 a=OUS1r0RBrpP1HfyL:21 a=XM7XWVlp0uZuRnLf:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192406>

I've now added a bit of documentation and uploaded my code to github:
https://github.com/andrew-sayers/Proof-of-concept-History-Converter

I haven't attached it here because the code isn't at a stage where it
would be useful to review line-by-line.  Comments are welcome if you
really want to though :)

svn-branch-export.pl makes heavy use of SVN::Dump.  You may want to get
the latest version from github if speed is important to you:
https://github.com/book/SVN-Dump/ - many thanks to Philippe Bruhat for
accepting my performance patch so quickly.

Here are some particular gripes I have with the code I've uploaded:

git-branch-import.pl gets the revision number by parsing out the
"git-svn-id" in commit messages - as I mentioned earlier, I started off
thinking this script would be closely related to git-svn somehow.  In
hindsight it would be better to read revision numbers from the marks
file exported by git-fast-import.

Branch History Format has some git-specific stuff in the setup section.
 I didn't think about this in too much detail while writing it, but
DVCS-neutrality would be better served by turning these into
command-line options.

As mentioned before, branch detection in svn-branch-export.pl is rather
muddled, as my understanding of the problem evolved significantly while
writing it.

svn-branch-export.pl half-heartedly uses a configure/make/make install
analogy to describe its behaviour - I'm increasingly sure this is
gimmicky and awful, rather than a neat explanatory trick.

svn-branch-export.pl exposes a lot of config values (e.g. "log_style")
that just bulk up the implementation and create space for bugs to creep
in without adding much actual value.  They should be removed.

On 06/03/12 19:29, Nathan Gray wrote:
<snip>
> 
> The problem of specifying and detecting branches is a major problem in
> my upcoming conversion.  We've got toplevel trunk/branches/tags
> directories but underneath "branches" it's a free-for-all:
> 
> /branches/codenameA/{projectA,projectB,projectC}
> /branches/codenameB   (actually a branch of projectA)
> /branches/developers/joe/frobnicator-experiment (also a branch of projectA)
> 
> Clearly there's no simple regex that's going to capture this, so I'm
> reduced to listing every branch of projectA, which is tedious and
> error-prone.  However, what *would* work fabulously well for me is
> "marker file" detection.  Every copy of projectA has a certain file at
> it's root.  Let's call it "markerFile.txt".  What I'd really love is a
> way to say:

This is quite close to the implementation I've got.  The SVN exporter
runs in two stages:

In the first stage, the script treats any non-blacklisted file as a
marker file, but only looks for trunk branches.  It looks all through
the history, traces back through the copyfroms, and tries to find the
original directory associated with the file.  Usually it decides that
the only branch without a copyfrom is /trunk.  Searching just for trunks
with this weak heuristic makes it much easier to hand-verify the result.

In the second stage, the script looks through the history again, tracing
the copies of known branches in a slightly less clever way than
described in my previous e-mail.  There's no need for marker files this
time round, as we just assume any `svn cp /trunk
/directory/not/within/a/branch` is a new branch.  In my experiments this
has been a pretty solid way of detecting branches without too much human
input - I might be missing something (or have mis-explained something),
but I'd be interested to hear examples of where this would go wrong.
Having said that, here's a dodgy example I'd like to pre-emptively defend:

	svn add tronk
	svn ci -m "Created trunk" # r1
	svn cp tronk trunk
	svn ci -m "D'oh" # r2
	svn rm tronk
	svn add trunk/markerFile.txt
	svn ci -m "Double d'oh!" # r3

You could argue that the correct branch history description for the
above would be:

	In r3, create branch "trunk"

In other words, ignore everything that happened before the marker file
was created.  However, I would argue the following representation is
more correct:

	In r1, create branch "tronk"
	In r2, create branch "trunk" from "tronk" r1
	In r3, delete branch "tronk"

The branch history format supports the "delete branch" command (remove
the branch entirely) as well as the more common "deactivate branch"
(keep the branch but don't accept any new commits) specifically to deal
with this sort of weirdness.  Creating a branch then deleting it keeps
the r1 revision log intact as part of the "trunk" branch, without
leaving any useless branches lying around.

	- Andrew
