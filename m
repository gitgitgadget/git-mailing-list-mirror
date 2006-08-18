From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] introduce inline is_same_sha1
Date: Thu, 17 Aug 2006 21:09:07 -0700
Message-ID: <7vejveelcs.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
	<81b0412b0608170459if099fcane9d9e91a3fdac9e6@mail.gmail.com>
	<Pine.LNX.4.63.0608171152110.22819@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 18 06:09:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvfW-0002HL-PO
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWHREJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHREJL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:09:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33008 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030391AbWHREJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:09:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818040908.YNGT23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 00:09:08 -0400
To: David Rientjes <rientjes@google.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25620>

David Rientjes <rientjes@google.com> writes:

> On Thu, 17 Aug 2006, Alex Riesen wrote:
>
>> Why not just sha1cmp? And if you're aiming at hash-type independence,
>> why not hashcmp?
>
> hashcmp is a very good suggestion.
>
> 		David
> ---
> Introduces global inline:
> 	hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>
> Uses memcmp for comparison and returns the result based on the length of 
> the hash name (a future runtime decision).
>
> Signed-off-by: David Rientjes <rientjes@google.com>

Looks very very good.  Much cleaner.

Also, I retract my previous comment that the parameters should
be (void*).  Looking at the call sites that need casts, they
would need either (unsigned char*) or (char*) cast regardless of
the type of the argument hashcmp() function takes anyway.

Thanks.  Will apply.

Oh, by the way, two minor procedural requests.

Pick a good one-line description of the patch; as it was sent,
the commit would have shown (in "git shortlog" output):

	Introduces global inline:

which does not make much sense to the first time readers.

Please use something other than '---' as the delimiter after the
cover letter, if you write one _before_ the commit log message.
E-mailed patch acceptance tools consider anything after '---' is
patch and does not contribute to the commit log, so it is lost
from the resulting commit.

A short cover letter like this is better placed _after_ the real
separator '---' that comes after your commit log message, like
this:

From: David Rientjes <rientjes@google.com>
Subject: Do not use memcmp(sha1_1, sha1_2, 20) with hardcoded length.

Introduces global inline:

	hashcmp(const unsigned char *sha1, const unsigned char *sha2)

Uses memcmp for comparison and returns the result based on the length of 
the hash name (a future runtime decision).

Signed-off-by: David Rientjes <rientjes@google.com>
---

 On Thu, 17 Aug 2006, Alex Riesen wrote:

 > Why not just sha1cmp? And if you're aiming at hash-type independence,
 > why not hashcmp?

 hashcmp is a very good suggestion.  Please ack the following.

 builtin-commit-tree.c    |    2 +-
 builtin-diff-stages.c    |    2 +-
 ...
