From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Fri, 20 May 2005 21:08:57 -0400 (EDT)
Message-ID: <4600.10.10.10.24.1116637737.squirrel@linux1>
References: <Pine.LNX.4.21.0505202045580.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:08:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZITP-0003s9-22
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEUBJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEUBJJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:09:09 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:14486 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261196AbVEUBI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 21:08:58 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521010857.SZZE11463.simmts6-srv.bellnexxia.net@linux1>;
          Fri, 20 May 2005 21:08:57 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4L18qHe012008;
	Fri, 20 May 2005 21:08:55 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 20 May 2005 21:08:57 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.21.0505202045580.30848-100000@iabervon.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2005 8:49 pm, Daniel Barkalow said:
> The version of wc I have (GNU textutils-2.1) puts spaces at the beginning
> of lines. This patch should work for any version of wc.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> Acked-by: Junio C Hamano <junkio@cox.net>
> Index: t/t0000-basic.sh
> ===================================================================
> --- 58741c69570705801db4b785681790d636475695/t/t0000-basic.sh
> (mode:100755 sha1:9a557129d98b499bcd601903d6646de29ba4bfc5)
> +++ uncommitted/t/t0000-basic.sh  (mode:100755)
> @@ -32,7 +32,7 @@
>  find .git/objects -type d -print >full-of-directories
>  test_expect_success \
>      '.git/objects should have 256 subdirectories.' \
> -    'test "$(wc -l full-of-directories | sed -e "s/ .*//")" = 257'
> +    'test $(cat full-of-directories | wc -l) = 257'
>
>  ################################################################
>  # Basics of the basics
>


You can't do "wc -l filename" because some versionso of "wc" then include
the filename in their output and confuse things.   That was the reason to
use "cat" in the first place.  If you're going to use sed, just do away
with wc altogether:

sed -ne '$=' full-of-directories

And that should work everywhere to get a line count.

Cheers,
Sean


