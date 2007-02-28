From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Questions about git-rev-parse
Date: Tue, 27 Feb 2007 21:23:37 -0500
Message-ID: <E1HMETh-0004BO-Lw@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 03:23:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMETo-0006uo-A5
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 03:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbXB1CXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 21:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXB1CXl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 21:23:41 -0500
Received: from thunk.org ([69.25.196.29]:42293 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbXB1CXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 21:23:40 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HMEZC-0004Gq-7g; Tue, 27 Feb 2007 21:29:18 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HMETh-0004BO-Lw; Tue, 27 Feb 2007 21:23:37 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40874>


So I was looking at git-rev-parse trying to understand the man page, as
I was trying to understand how various commands can accept lists (or
ranges) of commits, and the man page raised a number of questions.
First of all, the DESCRIPTION section doesn't quite parse as English:

       Many  git  porcelainish commands take mixture of flags (i.e. parameters
       that  begin  with  a  dash  -)  and  parameters  meant  for  underlying
       git-rev-list  command  they use internally and flags and parameters for
       other commands they use as the downstream of git-rev-list. 

But, as best as I can gather that it's a helper function meant to do
some basic options parsing for those git porcelain commands that expect
to take a set of revision ID's.

This raises some additional questions, though.  If the goal of this
command is to parse out those options and arguments which are meant for
git-rev-list, why does it translate tag names to SHA id's:

% git-rev-parse v1.5.0..v1.5.0.1
dedb0faa48787839dbc47b7ca2507bda5924ec2c
^6db027ffe03210324939b3dd655c4223ca023b45

After all, git-rev-list can just as easily accept:

	git-rev-list dedb0faa48787839dbc47b7ca2507bda5924ec2c \
		^6db027ffe03210324939b3dd655c4223ca023b45

as

	git-rev-list v1.5.0..v1.5.0.1

Also, there are a number of options in git-rev-list which make it appear
to be a general dumping ground of miscellaneous options.  

For example, it's not clear what 

	git-rev-parse --show-prefix

and

	git-rev-parse --show-cdup

have to do with the description of git-rev-parse as described in the
DESCRIPTION section.  It seems to be completely miscellaneous extras
that were tacked on.  Or am I missing something?

Finally, it seems rather unfortunate that certain bits of functionality
such as --since and --until were hidden into git-rev-parse, since it
means that some commands which are implemented as shell scripts are more
likely to use git-rev-parse, and will therefore support --since and
--until, where as other commands which are implemented as built-in's,
such as git-log, don't accept --since and --until.

So I'm wondering if I'm missing something about historical context,
since from looking at git-rev-parse, it looks like not a lot of thought
went into its design, and it has a bunch of stuff that grew via
accretion; or maybe I'm not understanding why it was designed the way it
was?

Regards,

						- Ted
