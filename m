From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Why Git is so fast
Date: Fri, 1 May 2009 09:24:34 +0400
Message-ID: <20090501052434.GA4750@dpotapov.dyndns.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri May 01 07:25:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzlFP-0005tF-7Z
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 07:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbZEAFZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 01:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZEAFZK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 01:25:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:2367 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbZEAFZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 01:25:08 -0400
Received: by fg-out-1718.google.com with SMTP id 16so700225fgg.17
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 22:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pdOY02zjsoFJJU2fqcD9Gtr7Aj0gnJ0JXoHyyGS60M4=;
        b=P4YIuDYGs0HxwU4Jyrf4BpZ/Xm6BuGSIW0qaBGllOMABXYnll3M2u63yZ+ZYRswwGo
         HJU/7ZTSRhf/02AjGFdy49S8ezwxqVfoX7e9q+YbQb/3kdgCGp3MM9NUrjoZ55Agy1Ng
         JJ57KYD/mQD6X/9gesXDHROULFFg07QVdf+LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XviIza3IHwE8cZZdEapQrWXnFcB3oZTdA0JgE6IDYq1XnHj0XZYoUC0gkOuRvDlPFX
         ZVOc4tBp0S/cLJ8rfFxX7SVgbs3SazJ7Kagd1JTUuSVU0U/EJh5PTzlYauhQh9GTyoaF
         N/Uu4+66UdhXEq3Z47kpzpKmeg3blZricYbVk=
Received: by 10.86.59.18 with SMTP id h18mr2559794fga.71.1241155505821;
        Thu, 30 Apr 2009 22:25:05 -0700 (PDT)
Received: from localhost (ppp91-77-226-31.pppoe.mtu-net.ru [91.77.226.31])
        by mx.google.com with ESMTPS id e20sm201483fga.5.2009.04.30.22.25.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 22:25:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <86iqkllw0c.fsf@broadpark.no>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118057>

On Thu, Apr 30, 2009 at 10:36:03PM +0200, Kjetil Barvik wrote:
>      4) The "static inline void hashcpy(....)" in cache.h could then
>         maybe be written like this:
> 
>   static inline void hashcpy(unsigned long sha_dst[5], const unsigned long sha_src[5])
>   {
>        sha_dst[0] = sha_src[0];
>        sha_dst[1] = sha_src[1];
>        sha_dst[2] = sha_src[2];
>        sha_dst[3] = sha_src[3];
>        sha_dst[4] = sha_src[4];
>   }
> 
>         And hopefully will be compiled to just 5 store/more
>         instructions, or at least hopefully be faster than the currently
>         memcpy() call. But mabye we get more compiled instructions compared
>         to a single call to memcpy()?

Good compilers can inline memcpy and should produce more efficient code
for the target architecture, which can be faster than manually written.
On x86_64, memcpy() requires only 3 load/store operations to copy SHA-1
while the above code requires 5 operations.

Dmitry
