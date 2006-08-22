From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Tue, 22 Aug 2006 00:00:32 -0700
Message-ID: <7vveolqmpb.fsf@assigned-by-dhcp.cox.net>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
	<20060821101346.GA527@diku.dk>
	<59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
	<Pine.LNX.4.63.0608211319180.8662@chino.corp.google.com>
	<59ad55d30608211345k7956a219m8ab450c6f2023461@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 09:00:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFQFb-0002GH-G5
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 09:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWHVHAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Aug 2006 03:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHVHAe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 03:00:34 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9466 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751140AbWHVHAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 03:00:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822070033.ZWHJ2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 03:00:33 -0400
To: =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
In-Reply-To: <59ad55d30608211345k7956a219m8ab450c6f2023461@mail.gmail.com>
	(Kristian =?iso-8859-1?Q?H=F8gsberg's?= message of "Mon, 21 Aug 2006
 16:45:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25835>

"Kristian H=F8gsberg" <krh@bitplanet.net> writes:

> Ok, once more without the spaces.  I have to state that it's against
> my personal beliefs using pointers as boolean values, but I can go
> with the flow here.  For extra bonus, I'm using xrealloc instead of
> plain realloc now.

My preferences (pretty much procedural):

 - Documentation/SubmittingPatches
   - Attachments discouraged;
   - With a proper commit log message;
   - With a proper signed-off line;

 - Names in source encoded in utf8 if needed (I think you got
   this one right, but application/octet-stream does not give
   charset information so I cannot really tell).

 - No spaces between a function name and open parenthesis.

Some nitpicks.

> static void create_reflog(struct ref_lock *lock)
> {
>...
> }

Probably reflog interface should supply ways to create new ones
(and delete or truncate existing ones) to users like this
program.  Please work with Shawn Pearce to refactor this part.

> static void create_branch(const char *name, const char *start,
> 			  int force, int reflog)
> {
> 	struct ref_lock *lock;
> 	unsigned char sha1[20];
> 	char ref[PATH_MAX], msg[PATH_MAX + 20];

You are using snprintf so I think it is safe, but I think using
PATH_MAX for msg length is wrong.  start can be an arbitrary
extended object name expression (HEAD^12~24^2~4^^2~13...) and
does not have much to do with pathname.

> 	snprintf(ref, sizeof ref, "refs/heads/%s", name);

Maybe barf if snprintf steps over the buffer?
