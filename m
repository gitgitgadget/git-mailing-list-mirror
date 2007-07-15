From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 17:58:21 +0200
Message-ID: <e5bfff550707150858i1825e01clf0897ad4db319373@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	 <20070715093529.GD2568@steel.home>
	 <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	 <20070715104858.GG2568@steel.home>
	 <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	 <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	 <20070715083529.6855a858.seanlkml@sympatico.ca>
	 <e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
	 <20070715110415.33692142.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 17:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA6UW-0004Ft-9Z
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 17:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161AbXGOP6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 11:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759050AbXGOP6X
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 11:58:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:33159 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905AbXGOP6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 11:58:22 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1296496wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 08:58:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGuL20hfZtoikCOpWnDWrb3Qr1uVgcwoiycE5qQB+D8/EEfMR0BrXgNwsI+RL96lcADT3UvMA1NuymsaBBcjivw96SPkj0xEpp3bE+gVwN5fkSPOwtd1e2sl2Q/cn5+6zBsP/j/1olkLTHGcTzn6g8xND9093YhyabjuZDjGRQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VLNZ2Oh0jhj1GFXT/7s0h+6ysctezE1FSuJ5qU8J0cqIqmdGm3Fx5ELCLX9boNbIEoMjUHtB0S9X5AhAm3ivJ8P/DhM4zqSJf/R1NLMABUgMn4IhSCotdcKkvUv6ORozjwJtUL2g8UqC/1r1Gsetx6JcwnBUtxrQhpdcTpWvW6o=
Received: by 10.114.196.1 with SMTP id t1mr3374898waf.1184515101739;
        Sun, 15 Jul 2007 08:58:21 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 08:58:21 -0700 (PDT)
In-Reply-To: <20070715110415.33692142.seanlkml@sympatico.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52567>

On 7/15/07, Sean <seanlkml@sympatico.ca> wrote:
>
> characters are guaranteed to appear somewhere else.  Your current
> test will fail if a "c" happens to follow NUL in the patch text.
>

Yes sir, I agree with you 100%

The real issue IMHO is that a 'delimiting character' should not appear
in the content that it is trying to delimit. That's all the point
around this thing. If a real 'delimiting character' does not exist
because the content is free perhaps we should find a way to understand
when we are at revision boundaries. The simplest (and most efficient)
way is to know the size of the message in advance.

Also if git log filters out the '\0' chars in the content it is
suboptimal because we could miss to see we have a '\0' in content. BTW
the above mentioned patch in Linux tree was all around removing that
garbage '\0'. If diff output was filtered out perhaps the author could
have missed that patch opportunity.

Marco

BTW, perhaps I'm retarded, but I fail to see what to search for with ^\0.

As example if I have this output:


    Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index fd3fd90..36c523d 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -444,7 +444,6 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
 }

 /**
-^@
  * gfs2_ri_total - Total up the file system space, according to the rindex.
  *
  */
^@commit 8fb68595d508fd30ec90939572484b263600376c
fad59c1390045b5adb7c7249ec4e77e0f868aca5
tree 218a457675c111e2224fb57998d38e45d5786bd1
parent fad59c1390045b5adb7c7249ec4e77e0f868aca5


What should I search for to find the revision boundary? "\n\0" ? is
this that you mean with ^\0
