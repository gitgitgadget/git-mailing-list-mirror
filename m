From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Mon, 16 May 2005 21:15:06 -0700
Message-ID: <7vacmulc8l.fsf@assigned-by-dhcp.cox.net>
References: <7vu0l3puzg.fsf@assigned-by-dhcp.cox.net>
	<7v8y2en4e8.fsf@assigned-by-dhcp.cox.net>
	<7v3bsmn3ia.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 06:15:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXtTs-0005DK-6v
	for gcvg-git@gmane.org; Tue, 17 May 2005 06:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVEQEPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 00:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVEQEPP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 00:15:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:26867 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261200AbVEQEPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 00:15:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517041507.HJEI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 00:15:07 -0400
To: pasky@ucw.cz
In-Reply-To: <7v3bsmn3ia.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 16 May 2005 16:40:45 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

*Blush*.  I sent out a bad copy for this patch.

In run-with-user-path.c, in main():

+	/* We need to special case -- (end of command) followed
+	 * immediately by -- (beginning of paths); otherwise
+	 * "git-run-with-user-path git-update-cache --add -- -- foo"
+	 * would try canonicalize and filter path arguments starting
+	 * from -- (beginning of paths), which is not what we want.
+	 */
+	if (!strcmp(av[command_end + 1], "--")) {
+		exec_param[command_end-1] = av[command_end + 1];
+		command_end++;
+	}

The above if() statement should be:

    if (command_end + 1 < ac && !strcmp(av[command_end + 1], "--")) {

Otherwise "./git-run-with-user-path echo --" would segfault.
Sorry about the noise.


