From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Fri, 6 May 2005 20:32:42 -0400 (EDT)
Message-ID: <2721.10.10.10.24.1115425962.squirrel@linux1>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
    <2637.10.10.10.24.1115425225.squirrel@linux1>
    <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:26:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUD9H-0001Hz-Dj
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVEGAdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVEGAcw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:32:52 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:17374 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261361AbVEGAcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 20:32:43 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050507003242.YDFF1542.simmts12-srv.bellnexxia.net@linux1>;
          Fri, 6 May 2005 20:32:42 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j470Wg5h019218;
	Fri, 6 May 2005 20:32:42 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 6 May 2005 20:32:42 -0400 (EDT)
In-Reply-To: <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2005 8:24 pm, Junio C Hamano said:
>>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:
>
> S> has_sha1_file can be reduced to:
>
> S> int has_sha1_file(const unsigned char *sha1)
> S> {
> S>        return (!!find_sha1_file(sha1));
> S> }
>
> Not really.  If you do not have alternates it does not even
> bother to stat so you get the path that supposed to contain the
> data and you need to do the checking yourself.
>
>

Perhaps I'm just missing something in your code, but this fragment makes
it look to me that stat is always called in find_sha1_file even when there
are no alternates:

+        char *name = sha1_file_name(sha1);
[...]
+        if (!stat(name, &st))
+                return name;
+        for (i = 0; i < num_alt; i++) {


Sean


