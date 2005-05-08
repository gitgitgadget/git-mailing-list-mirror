From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 08 May 2005 15:40:40 +0400
Organization: Telecom Service, JSC
Message-ID: <427DFAB8.5050000@tls.msk.ru>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de> <427DE086.40307@tls.msk.ru> <1115551204.3085.0.camel@kryten> <12e801c553c1$c454ea20$1225a8c0@kittycat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: James Purser <purserj@ksit.dynalias.com>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 13:34:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUk2v-0008Oi-R5
	for gcvg-git@gmane.org; Sun, 08 May 2005 13:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVEHLkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 07:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVEHLkx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 07:40:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:45152 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262851AbVEHLko (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 07:40:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by hobbit.corpit.ru (Postfix) with ESMTP id 95B80295EA;
	Sun,  8 May 2005 15:40:41 +0400 (MSD)
	(envelope-from mjt@tls.msk.ru)
Received: from [192.168.1.200] (mjt.ppp.tls.msk.ru [192.168.1.200])
	by hobbit.corpit.ru (Postfix) with ESMTP;
	Sun,  8 May 2005 15:40:41 +0400 (MSD)
	(envelope-from mjt@tls.msk.ru)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: jdow <jdow@earthlink.net>
In-Reply-To: <12e801c553c1$c454ea20$1225a8c0@kittycat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

jdow wrote:
> From: "James Purser" <purserj@ksit.dynalias.com>
> 
   while (deflate(&stream, 0) == Z_OK)
-  /* nothing */
+  /* nothing */;
  stream.next_in = buf;
> 
> You guys REALLY do not see the changed semantics here? You are
> changing:
>   while (deflate(&stream, 0) == Z_OK)
>       stream.next_in = buf;
> 
> into
> 
>   while (deflate(&stream, 0) == Z_OK)
>     ;
>   /* Then the data itself.. */
>   stream.next_in = buf;
> 
> I suspect the results of that tiny bit of code would be slightly
> different, especially if "stream.next_in" is volatile, "buf"
> is volatile, or if the assignment to next_in has an effect on
> the "deflate" operation.

As I already said, deflate() in this case does only ONE iteration.
stream.avail_in is NOT changed in the loop (except of the deflate()
itself, where it will be set to 0 - provided out buffer have enouth
room).  So the whole while loop does only ONE iteration, returning
Z_NEED_DATA or something the next one.  So no, the semantics here
(actual semantics) does NOT change.

/mjt
