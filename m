From: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <torarnv@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial branch
Date: Tue, 3 Mar 2009 17:47:09 +0100
Message-ID: <49AD5F0D.8000700@gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXnb-0005U1-0y
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbZCCQrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbZCCQrK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:47:10 -0500
Received: from hoat.troll.no ([62.70.27.150]:42223 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbZCCQrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:47:09 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 793CC20F7E;
	Tue,  3 Mar 2009 17:47:00 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 5BA4920F7B;
	Tue,  3 Mar 2009 17:47:00 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n23GkxSI023610;
	Tue, 3 Mar 2009 17:46:59 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 03 Mar 2009 17:46:59 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0903031004570.6399@intel-tinevez-2-302>
References: <1236040414-19089-1-git-send-email-torarnv@gmail.com>
References: <alpine.DEB.1.00.0903031004570.6399@intel-tinevez-2-302>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112115>

Johannes Schindelin wrote:
> Leaving unnecessary initialization and funny indentation aside for a 
> moment,

I do appreciate the feedback though. C is not my primary language, and
I'm happy to learn from my mistakes :-)

> Keep in mind: your change (as every change) bears the potential to 
> introduce bugs and to complicate the user interface.  The change must be 
> worth those risks.

I fully understand. Here is my rationale for why it's worth the risk:

Imagine you have a project called Foo, which has active development on 
the 'master' branch, and not quite so active development on the more 
stable version branch '1.6' (which v1.6.0 and v1.6.1 was tagged from).

Now, you want to put up info on the project web page / wiki on how to 
contribute to project Foo. This information is for new contributors -- 
who may be unfamiliar with git and it's inner workings. You write:

"To get started contributing to project Foo, please clone using:

   $ git clone git://git.foo.com/project.git

"

This looks nice and inviting.

You also want to provide instructions for those who would like to 
contribute to the more stable branch of project Foo, 1.6:

"If you would like to contribute to the stable 1.6 branch, do:

   $ git clone -n git://git.foo.com/project.git
   $ cd project
   $ git checkout -t origin/1.6
   $ git branch -D master

"

Which is not so nice and inviting. At least not compared to:

"If you would like to contribute to the stable 1.6 branch, do:

   $ git clone git://git.foo.com/project.git --branch 1.6

"

Remember these are new contributors, unfamiliar with git. Presenting 
them with a list of four commands that have to be run to get started 
(commands which incidentally also are the first-ones new users mix up), 
is not ideal. "What does -n do?", "What does -t do?", "What's a tracking
branch?", "Origin? What's that?", "What does -D do?", "Delete?! Will I 
delete the main development line!?", etc.. :)

Also, remember that these commands are not something that can be 
scripted or put into an alias, because these users have not cloned 
anything yet.

I know Subversions is perhaps not the best ideal, but to contrast:

   $ svn import http://svn.foo.bar/project/trunk
   $ svn import http://svn.foo.bar/project/branches/1.6

Easy to get to a different branch without having to dive into the full 
feature set of the SCM.

So, to conclude, I see this as a usability-feature of git-clone, which 
outweighs the possible risk of introducing new bugs. It's not a feature 
I will personally use that often, but it's one that I think new users 
will appreciate.


Tor Arne
