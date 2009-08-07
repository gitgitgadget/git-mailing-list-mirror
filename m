From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Fri, 07 Aug 2009 06:16:50 +0200
Message-ID: <4A7BAAB2.8040807@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 06:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZGt4-0000Ob-8A
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 06:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbZHGEQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 00:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZHGEQw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 00:16:52 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:64412 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbZHGEQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 00:16:52 -0400
Received: by bwz9 with SMTP id 9so1159281bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 21:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=KcyC6bd3tE07g9a1p/t7xiiCOXhqKWCRtHKVvjGzKvQ=;
        b=iGpbsaWHhuzgWTeXSDcAqkmNom4MqdyqfG/3qhqXmfyhbwy0uJdhmQGM7UvOIO/qzE
         dHdRSkSHWRcttJTQ5tnB3MO2a0qwySXI6oT7ZcxgcVDk96GOle0io9zGhRNTSrROjuqu
         QJIngpUfbuTc/lWicYphX0ka8PRFYxQ3KdbXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=OBEwc/ltYBs/aOzlYbXWwUTS8gfnWp9rV5Eydoh1tYDr9rJeUTEuxWzYcEa9oYHpwM
         JUP8RsFXIA014um0Jl/ocxV5oytvzm+/4sp0q661jnx1Jiqm/IIjr6yU0Nir+i9QBWjm
         TWaL0hfh6DLQqPzQClc8/QBlw5GXfvHBUgzUY=
Received: by 10.204.115.130 with SMTP id i2mr2753286bkq.162.1249618611859;
        Thu, 06 Aug 2009 21:16:51 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-120-213.multimo.pl [89.174.120.213])
        by mx.google.com with ESMTPS id c28sm1714158fka.49.2009.08.06.21.16.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 21:16:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125172>

Linus Torvalds wrote:
> 
> Here's the plain "linus" baseline (ie the "Do register rotation in cpp") 
> thing, with the fixed "E += TEMP .." thing):

> 	linus          0.4018       151.9

> and here it is with your patch:

> 	linus          0.4653       131.2

> (ok, so the numbers aren't horribly stable, but the "plain linus" thing 
> consistently outperforms here - and underperforms with your patch).

Well, I'd be surprised if one C version would always be the winner on
every single cpu; that 13% loss[1] I think would be an acceptable compromise,
if the goal is to have one implementation that does reasonably well on all
cpus.

That's why i asked how the change did on nehalem; if it's a measurable loss
on anything modern (core2+), then of course the P4s must suffer; and one
could always blame the compiler ;)
It's not like the difference in sha1 overhead will be noticeable in normal
git use.

artur

[1] I suspect the old gcc is a factor (4.0.4 does <100M/s here).
