From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare repository.
Date: Sun, 31 Dec 2006 11:19:16 -0800
Message-ID: <7vr6ufeuvf.fsf@assigned-by-dhcp.cox.net>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
	<20061231043238.GD5823@spearce.org>
	<7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
	<20061231061122.GB6106@spearce.org>
	<7vk608fq9u.fsf@assigned-by-dhcp.cox.net>
	<20061231124921.GA14286@thunk.org>
	<Pine.LNX.4.63.0612311606330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 20:19:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H16DT-0007vl-H2
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 20:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWLaTTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWLaTTV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 14:19:21 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:57638 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030422AbWLaTTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 14:19:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231191917.PSQR19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 14:19:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5XJW1W00V1kojtg0000000; Sun, 31 Dec 2006 14:18:31 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612311606330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 31 Dec 2006 16:13:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35705>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> While we're talking about potentially deprecating GIT_DIR for users,
>> out of curiosity, what valid workflows would cause users to want to
>> use GIT_INDEX_FILE and GIT_OBJECT_DIRECTORY?  Seems like they would
>> cause more confusion and support problems than anything else.  
>
> Easy, guys.
>
> It is a valid -- indeed, useful -- thing to be able to script nice 
> helpers. For example, in one project I track tar balls. So, I wrote a 
> script which will unpack the tar ball in a directory, build a new index 
> from it, and commit the corresponding tree on top of the tracking branch. 
> This setup relies _heavily_ on being able to redirect GIT_INDEX_FILE and 
> GIT_DIR.

I do agree INDEX_FILE and OBJECT_DIRECTORY are handy things for
the user to muck around.  What I am not sure about is GIT_DIR,
in the sense that I suspect it is not such a pain to do without
for such a script.

> ...  Now, if somebody starts git in a 
> bare repo, where "index" is present, it could die with a helpful message 
> like
>
> 	It seems that this is a bare git repository, but there is an index 
> 	file present, which contradicts that assumption. If the repository
> 	is indeed bare, please remove the index file.

That is probably worse.  

 * there is no reason for non working-tree operations such as
   git-log to fail when you go to a bare repository (or for that
   matter .git in a repository with a working-tree).  we should
   not have to error out nor remove the index we will not use.

 * if you did the above in response to a misguided 'git
   checkout' in a bare repository, the next error message the
   user will get will be 'huh?  you are in a bare repository,
   bozo'.

So I do not think the helpful message should even be necessary.
