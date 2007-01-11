From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 18:43:55 +0100
Message-ID: <81b0412b0701110943s274bfbcbkfea0fcb294ccb820@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	 <20070107163112.GA9336@steel.home>
	 <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
	 <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
	 <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 18:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H53y3-0004Dz-PB
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 18:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbXAKRn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 12:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXAKRn5
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 12:43:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:50915 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXAKRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 12:43:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so546052uga
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 09:43:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bdPKkonc2lWIuGvCGq3G100kynRUou0M8bihbH4rChmsbzOjG8rUv36+dKDz/hmRroXZel/bO+Awb6xXjeWwOdcrCUB9L8SJxcuq0k5JksynXj/IoNfFugB7BStoSVpk0afnZ8BVBgSeMAICIErRnaT9RjI2VQ3L9+cGTU2/jA0=
Received: by 10.78.149.15 with SMTP id w15mr613794hud.1168537435065;
        Thu, 11 Jan 2007 09:43:55 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 11 Jan 2007 09:43:55 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36599>

On 1/11/07, Linus Torvalds <torvalds@osdl.org> wrote:
> That said, I think we actually have another problem entirely:
>
> Look at "write_cache()", Junio: isn't it leaking memory like mad?

Unless it is used in some corner case not covered by tests - it
looks like it does leak memory like mad. With the patch the
memory usage for 44k-merge is more than halved!
