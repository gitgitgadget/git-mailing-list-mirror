From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Teach tree->raw to not require the hash of the blob
Date: Tue, 11 Jul 2006 23:16:40 -0700
Message-ID: <7v64i31h6f.fsf@assigned-by-dhcp.cox.net>
References: <20060712034345.14009.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 08:17:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Y2F-0004OV-Pe
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 08:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWGLGRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 02:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWGLGRS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 02:17:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53390 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751162AbWGLGRS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 02:17:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712061649.TIRL12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 02:16:49 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060712034345.14009.qmail@web31802.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 11 Jul 2006 20:43:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23765>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Teach tree->raw to not require the hash of the blob, but to
> figure it out from the file name.  This allows to externally
> link to files into the repository, such that the hash is not
> required.  I.e. the file obtained would be as of the HEAD
> commit.
>
> In contrast tree->blob for binary files passes the hash, as
> does tree->blob->plain for "text/*" files.
>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---
>  gitweb/gitweb.cgi |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)

This has exactly the same line number problem.

@@ -1678,8 +1690,7 @@ sub git_tree {
 			      $cgi->a({-href => "$my_uri?" . esc...
 #			      " | " . $cgi->a({-href => "$my_uri...
 			      " | " . $cgi->a({-href => "$my_uri...
-			      " | " . $cgi->a({-href => "$my_uri...
+			      " | " . $cgi->a({-href => "$my_uri...
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
 			print "<td class=\"list\">" .

You are removing one line and adding one line, so the number of
old and new lines better match.

Hand-applied, tried, got confused and dropped.

I think _allowing_ to accept filename not hash is a sane change,
and would be useful if you want to allow linking to always the
HEAD version from external sites, but I do not think listing the
raw link in the tree view without the hash is a good idea.  It
makes things quite confusing that "blob" link in its
neighbourhood gives the blob from that specific version, but
"raw" gives the version from HEAD, even when you are browsing
something other than HEAD.

BTW, can somebody volunteer to be a gitweb/ "subsystem
maintainer"?
