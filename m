From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 9 May 2005 17:04:38 -0400 (EDT)
Message-ID: <3677.10.10.10.24.1115672678.squirrel@linux1>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
    <2637.10.10.10.24.1115425225.squirrel@linux1>
    <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
    <2721.10.10.10.24.1115425962.squirrel@linux1>
    <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
    <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com>
    <7vll6oz755.fsf@assigned-by-dhcp.cox.net>
    <3087.10.10.10.24.1115656919.squirrel@linux1>
    <427FA5FD.1050000@zytor.com> <7vfywwz11t.fsf@assigned-by-dhcp.cox.net>
    <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVFLi-0005D4-1A
	for gcvg-git@gmane.org; Mon, 09 May 2005 22:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEIVGi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 17:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVEIVGi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 17:06:38 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:21681 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261519AbVEIVGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 17:06:20 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050509210438.ZNTQ1542.simmts12-srv.bellnexxia.net@linux1>;
          Mon, 9 May 2005 17:04:38 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j49L4ZB6010204;
	Mon, 9 May 2005 17:04:35 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 9 May 2005 17:04:38 -0400 (EDT)
In-Reply-To: <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2005 4:05 pm, Junio C Hamano said:
> H. Peter Anvin mentioned that using SHA1_whatever as an
> environment variable name is not nice and we should instead use
> names starting with "GIT_" prefix to avoid conflicts.
>
> Here is a patch, requesting for comments.

Junio,

Look quite good; you made short work of that!

However I don't understand your gitenv_bc, wouldn't the following suffice?

char *gitenv_bc(const char *e)
{
        int i;
        char *val = getenv(e);
        if (val)
                return val;

        for (i=0; i < sizeof(bc_name) / sizeof(bc_name[0]); ++i) {
                if (!strcmp(e, bc_name[i].canonical)) {
                        if (val = getenv(bc_name[i].old))
                                warn_old_environment();
                        return val;
                }
        }
        return NULL;
}


Cheers,
Sean


