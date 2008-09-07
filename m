From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Sun, 7 Sep 2008 09:58:11 -0400
Message-ID: <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
	 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
	 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
	 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
	 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
	 <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
	 <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 15:59:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcKnV-0000mp-7p
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 15:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbYIGN6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbYIGN6Q
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:58:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:56093 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbYIGN6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 09:58:15 -0400
Received: by wx-out-0506.google.com with SMTP id h27so6355wxd.4
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7/+WPU3rUZ8FJUoitfV7YafbCD7dcCFC0aANleaohC0=;
        b=otEtw+V5Tf6Obx8xMh8Y7PTIXms62iJvLNXtzFkBSdpLCSa3PpGjrYppjrE6fqMZ1S
         bSlMgf2GGVYuZvTMOEGSBiMMKwv+y8vxwZTaUBg06hl603dNhnuKviypn2aGe7PRb5FT
         FMGclsW6fBmk0+hGMXrGd8Fy+UZbnLdJuTD6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LwMyUfHauj6XW51J3en0/jZ0AyB/SPLkTfTj+9wA+DAqtemE4VwzwOE/uipvm3rFwd
         eDtwdtniB8E4unjs5lDZh2JshfKUuSegdaDTe82lx0JA2l1DYX5xrko7veQLc8/ibqfx
         +sMUZLKrU7Z+wDC5JA1NpEbA++X0rViqzgCt4=
Received: by 10.70.75.20 with SMTP id x20mr17566587wxa.29.1220795891944;
        Sun, 07 Sep 2008 06:58:11 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Sun, 7 Sep 2008 06:58:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95140>

On 9/7/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
>  On Sat, 6 Sep 2008, Jon Smirl wrote:
>  >
>
> > When I was playing with those giant Mozilla packs speed of zlib wasn't
>  > a big problem. Number one problem was the repack process exceeding 3GB
>  > which forced me to get 64b hardware and 8GB of memory. If you start
>  > swapping in a repack, kill it, it will probably take a month to
>  > finish.
>
>
> .. and you'd make things much much WORSE?

My observations on the Mozilla packs indicated that the problems were
elsewhere in git, not in the decompression algorithms. Why does a
single 2000 delta chain take 15% of the entire pack time? Something
isn't right when long chains are processed which triggers far more
decompressions than needed.


>
>
>  > Size and speed are not unrelated.
>
>
> Jon, go away.
>
>  Go and _look_ at those damn numbers you tried to point me to.
>
>  Those "better" compression models you pointed at are not only hundreds of
>  times slower than zlib, they take hundreds of times more memory too!
>
>  Yes, size and speed are definitely not unrelated. And in this situation,
>  when it comes to compression algorithms, the relationship is _very_ clear:
>
>   - better compression takes more memory and is slower
>
>  Really. You're trying to argue for something, but you don't seem to
>  realize that you argue _against_ the thing you think you are arguing for.
>
>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
