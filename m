From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Lightweight tag ?
Date: Mon, 12 Jan 2009 13:55:04 +0100
Message-ID: <496B3DA8.1040308@drmicha.warpmail.net>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>	<7v63klsgf5.fsf@gitster.siamese.dyndns.org> <m2bpucnas2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 13:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMMLL-0001pa-Qx
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 13:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbZALMzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 07:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbZALMzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 07:55:09 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53857 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbZALMzI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 07:55:08 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9AD7820EEA8;
	Mon, 12 Jan 2009 07:55:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 12 Jan 2009 07:55:06 -0500
X-Sasl-enc: wlLodW/5Li/xsj/+vhfuCrJ/l3CPI+Dbxhm+3Rl/9Iu4 1231764906
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A360D2E9EA;
	Mon, 12 Jan 2009 07:55:05 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <m2bpucnas2.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105337>

Francis Moreau venit, vidit, dixit 01/12/09 10:17:
> Hello,
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Don't use explicit --tags blindly.  It says "no matter what kind of tag,
>> transfer everything under refs/tags".  Otherwise you won't see a
>> difference.
> 
> Well:
> 
> 	$ git --version
> 	git version 1.6.0.4
> 	$ mkdir test-tag
> 	$ cd test-tag/
> 	$ date > A
> 	$ git init
> 	Initialized empty Git repository in
> 	/home/fmoreau/tmp/git/test-tag/.git/
> 	$ git add .
> 	$ git commit -a -s -m "Init"
> 	Created initial commit be8750e: Init
> 	 1 files changed, 1 insertions(+), 0 deletions(-)
> 	 create mode 100644 A
> 	$ cd ..
> 	$ git clone --bare test-tag test-tag.git
> 	Initialized empty Git repository in /home/fmoreau/tmp/git/test-tag.git/
> 	$ cd test-tag
> 	$ git tag light
> 	
> 	$ git tag -a -m "Annoted tag" annoted
> 	$ git push ../test-tag.git
> 	Everything up-to-date
> 	$ git push --tags ../test-tag.git
> 	Counting objects: 1, done.
> 	Writing objects: 100% (1/1), 166 bytes, done.
> 	Total 1 (delta 0), reused 0 (delta 0)
> 	Unpacking objects: 100% (1/1), done.
> 	To ../test-tag.git
> 	 * [new tag]         annoted -> annoted
> 	 * [new tag]         light -> light
> 
> It looks like they're no difference for git-push...
> 
> That said the documentation about this is rather cryptic IMHO:
> 
> ,----[ man git-push ]
> | 	--tags
> | 	    All refs under $GIT_DIR/refs/tags are pushed, in
> | 	    addition to refspecs explicitly listed on the command
> | 	    line.
> `----
> 
> From a user point of view, the word lightweight is missing here. Why
> not simply saying:
> 
> ,----
> | All kind of tags are pushed with this option _otherwise_ only annoted
> | tags are pushed
> `----

Your test above confirms that the description is correct and nothing is
missing. "git push" pushes explicitly listed refspecs (or : as a
default). It pushes tags (light and heavy) when asked to.

"git pull" pulls tags if they can be reached from heads which are
pulled. It pulls all tags only when asked to.

In fact, the automatic following of tags (if they can be reached...)
depends on the transport, because typically you want to clone everything
if you clone locally but don't want all tags if you clone/pull from a
remote. There is also a config "tagopt" for overriding this. It's
mentioned but not really explained in "git tag"'s man page.

So, "non-local" tags are the ones which can be reached from heads which
you pull, and local ones are the others. I don't think lightweight tags
are more local than tag objects (please correct me if I'm wrong; I think
this needs more doc). It's just that the latter reside in the object db
store whereas the former are simple refs under refs/tags.

Michael
