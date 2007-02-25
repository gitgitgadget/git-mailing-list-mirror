From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv3] git-fetch: Split fetch and merge logic
Date: Sat, 24 Feb 2007 21:07:38 -0800
Message-ID: <7vlkimx1t1.fsf@assigned-by-dhcp.cox.net>
References: <87wt29i7hg.fsf@gmail.com>
	<7v1wkfzqgk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 06:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLBbs-0000g5-58
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 06:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbXBYFHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 25 Feb 2007 00:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbXBYFHl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 00:07:41 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38277 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXBYFHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Feb 2007 00:07:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225050740.TSQI6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 00:07:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Th7f1W00A1kojtg0000000; Sun, 25 Feb 2007 00:07:40 -0500
In-Reply-To: <7v1wkfzqgk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 24 Feb 2007 04:32:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40534>

Junio C Hamano <junkio@cox.net> writes:

> Santi B=C3=A9jar <sbejar@gmail.com> writes:
> ...
>> The current merge behaviour is unchanged.
>
> I overlooked your earlier huge testcase patch, but I noticed it
> does not include any test that fetches an annotated tag that
> points at a commit or a non-commit, nor an unannotated tag that
> is a tree or a blob.

A couple of other things I think the users of information in
=46ETCH_HEAD rely on need to be checked by the test suite.

 * Automated following of tags when a branch head is fetched.
   When this happens, I think the users (not just git-pull
   script but end users) expect the branch head to be listed
   first in the FETCH_HEAD file, so that:

	$ git fetch git://some.repo/
	$ git show FETCH_HEAD

   gives stable and useful result.

 * When two refs are listed on the command line explicitly, are
   they listed in the order given by the user in the resulting
   FETCH_HEAD file?

	$ git fetch git://some.repo/ one two
	$ git fetch git://some.repo/ two one

   Again, "git show FETCH_HEAD" after that expects the first one
   to show 'one' and the second one 'two'.  Replacing 'fetch'
   with 'pull' in the example would affect the parent order in
   the resulting Octopus.
