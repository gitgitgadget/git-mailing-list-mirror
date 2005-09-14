From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 14:15:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509141411510.26803@g5.osdl.org>
References: <20050914124206.GC24405@master.mivlgu.local>
 <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509141641290.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sergey Vlasov <vsu@altlinux.ru>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 23:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFebd-0004BD-3O
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 23:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVINVPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 17:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbVINVPi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 17:15:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932417AbVINVPh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 17:15:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8ELFOBo019179
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 14:15:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8ELFJYc026639;
	Wed, 14 Sep 2005 14:15:21 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509141641290.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8566>



On Wed, 14 Sep 2005, Daniel Barkalow wrote:
> 
> It's not about the refs at all. The issue is that, when it reaches a 
> commit that we already have, it assumes that we have everything that 
> commit references and stops there. It really ought to not do that, but I 
> think it might be too slow if it goes through everything all the time.

No, you don't need to go through everything all the time.

Do what the pack-sending stuff does: it assumes that it has everything
that is reachable from the _old_ refs. It doesn't walk all the way to the 
root, it "just" walks far enough that it can ignore anything that was 
reachable from the old refs.

Yes, it's slightly more complex than assuming "oh, I have this object, so
I must have all of its ancestors", but it's a lot safer. Then the rule
just becomes: only update refs once you've fetched all the objects.

		Linus
