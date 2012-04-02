From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 02 Apr 2012 23:17:48 +0100
Message-ID: <4F7A258C.5000200@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com> <2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner@student.tugraz.at>
X-From: git-owner@vger.kernel.org Tue Apr 03 00:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEpZW-0001E2-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 00:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab2DBWRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 18:17:54 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:33484 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752619Ab2DBWRw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 18:17:52 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120402221750.KTFA3740.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Mon, 2 Apr 2012 23:17:50 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120402221750.PZNS13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 2 Apr 2012 23:17:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <2487557.B8qfnaixh3@flomedio>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=q0Az1FFTx-w6Jxf5xrIA:9 a=-UiiLsmtVNUip7UKYzYA:7 a=wPNLvfGTeEIA:10 a=KDS-H1m-k2RTesoJ:21 a=Ln5cHK7-V-9lt06r:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194570>

Hey Florian,

Comments below.  The nitpickier ones aren't so much there to help the
proposal as for general information.

On 02/04/12 09:30, Florian Achleitner wrote:
<snip>
> 
> Subversion (svn) [2] was created as a successor of CVS, both follow a strict 
> client-server design, where the repository exclusively lives on the central 
> server and every client only checks out a copy of a single revision at a time. 
> SVN doesn't truly have a concept of branches. SVN branches are a copy of a 
> directory (so are tags).

Just a little nitpick - SVN was primarily inspired by CVS, but there's
no formal connection between the projects - both are developed by
different development teams even to this day.

<snip>
> git-fast-import [4] is a format to serialize a git repository into a text 
> format. It is used by the tools git-fast-import and git-fast-export.
> 
> The remote helper has to convert the foreign protocol and data (svn) to the 
> git-fast-import format.

As discussed on IRC, I'd like to see some discussion of solutions that
use plumbing directly (e.g. git-commit-tree) if you choose to focus on
branch import.

<snip>
> Branches exist due to the convention of having branches/, trunk/, and tags/ 
> directories in a repository, so do tags. But this is not mandatory and 
> therefore there are many different layouts. It follows that in svn it is also 
> possible to commit across branches. This means that a single commit can change 
> files on more than one branch (accidentally or deliberately).

This is basically accurate, but a contrived example might help explain
why fully automatic branch export is impossible in the general case:

Imagine a repository that consists of a single revision with a single
file, "scratchpad/libfoo/foo.c" - how would we decide which directory is
the branch?  Has the author has even decided yet?  For example, he might
be learning version control and not understand what branches are.

Having said that, automatic branch export might be possible in some
important special cases (like repositories that use the standard
layout).  I haven't really looked into this yet.

<snip>
>   - Because generating the branch mapping configuration already requires that 
> you have a dump of the svn repo, the helper should probably be able to read 
> from a file in place of svnrdump too.

It might help if I explain how the SVN branch exporter will work:

First, it will read an SVN dump and create a file containing JSON blobs
summarising each revision - e.g. it specifies which files were changed,
but not the contents of the changes.  As Ram mentioned, downloading the
dump and tee'ing it to both this process and svn-fe makes a lot of sense.

Next, it will read the JSON file and detect trunks.  This turns out to
be extremely fast now it's been freed from the SVN dump format.

Next, the user will have the opportunity to review the detected trunks.
 For example, if somebody put a "README.txt" in the root directory, the
previous step will need to be rerun with that file ignored.

Next, the main branch detection stage will be run using the JSON file
and the previous branch information.

Next, the user has another chance to make changes.  Some users will blow
straight past this stage, but sufficiently fussy users with sufficiently
large repositories could spend several days looping through this and the
previous stage until their branches and merges are just right.

The SBL file is finally complete whenever the user decides - you'll need
to tell them how to restart the import process, in case they restarted
their computer while they were refining the file.

<snip>
> 3. Add output capabilities to vcs-svn. Currently the code in vcs-svn can only 
> convert svn to git. To push to svn we also need conversion and mapping from 
> git to svn. The actual mapping code for branches should also be placed here 
> {??} and called by the remote helper.

I agree with Jonathan and Ram that we're not ready for this yet.  Even
mapping git branches back to a branchless representation won't be
practical until branch import is fairly mature.

	- Andrew

[1]https://github.com/andrew-sayers/Proof-of-concept-History-Converter/blob/master/git-branch-import.pl
[2]git sources git/Documentation/git-commit-tree.txt
