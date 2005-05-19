From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 11:42:09 -0700
Message-ID: <7vy8abys5a.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYpxa-0000cA-GT
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVESSmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVESSmS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:42:18 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6827 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261202AbVESSmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:42:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519184210.SPRY7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 14:42:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 19 May 2005 10:13:01 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Replying to myself.

JCH> Oops,... thanks.  I still had some doubts about it and that's
JCH> why I said it was beta, but that is fine.  My doubts are minor:

Here is another "doubt" point.  I am almost embarrassed to ask
this, but what's the right way to express the following?  I
could not figure out how to silence const warnings from gcc
without using the cast there, which defeats the whole point of
const warnings:

	if (!pid) {
		const char *pgm = external_diff();
		if (pgm) {
			if (one && two) {
				const char *exec_arg[9];
				const char **arg = &exec_arg[0];
				*arg++ = pgm;
				*arg++ = name;
				*arg++ = temp[0].name;
				*arg++ = temp[0].hex;
				*arg++ = temp[0].mode;
				*arg++ = temp[1].name;
				*arg++ = temp[1].hex;
				*arg++ = temp[1].mode;
				if (other)
					*arg++ = other;
				*arg = 0;
				execvp(pgm, (char *const*) exec_arg);
			}

Here, pgm and name are const,  execvp expects char *const argv[]
as its second argument.

