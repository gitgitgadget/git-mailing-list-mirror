From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Wed, 26 Aug 2009 14:05:52 +0200
Message-ID: <81b0412b0908260505m233d9a5cmefdd81e1ef51a299@mail.gmail.com>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
	 <200907300218.40203.johan@herland.net>
	 <200908010436.57480.johan@herland.net>
	 <200908261231.01616.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 14:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgHGM-0006ma-3P
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 14:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870AbZHZMFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 08:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756368AbZHZMFw
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 08:05:52 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46353 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbZHZMFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 08:05:52 -0400
Received: by bwz19 with SMTP id 19so64773bwz.37
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WJCU+/e5rKFB5Ne0RTwkvTWi/oIcW4zT9/IlT36Y6u4=;
        b=ecKx7fuRQ4LNxCL+TnZRICWZpDw9wvYT+FTCOy/OuFc0i3/MjUHdKoVvzUcKsMXk47
         2uGou73Juku3p0nS+9Y98+im6fhdUpMjmbyYrMqAWe4wedi8HpuJs2+lS8DRHUI2ctBQ
         y3tjfKOftpsTNhg90UKY0yIVH+Ht4dutNbvLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ot9SS/QNS3hjeOzeZm3g9S0S4js9TakDKJaLmLxNPjdz4viH+4wKxEbPbUM0Id2+Ec
         muORMJWbQapE8SF8VpJCLlPHor9o2LZOS1Mmd/GXVm7AJmQ1iRF1PkrevQh+6FpdieTB
         rMLcWqXbRWQvTCnbGMtzokLAgeQ0uOew/8IsY=
Received: by 10.204.160.80 with SMTP id m16mr3616296bkx.67.1251288352765; Wed, 
	26 Aug 2009 05:05:52 -0700 (PDT)
In-Reply-To: <200908261231.01616.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127089>

On Wed, Aug 26, 2009 at 12:31, Johan Herland<johan@herland.net> wrote:
> The 256-tree structure is considerably faster than storing all entries in a

This part is confusing. Was 256-tree better (as in "faster") then?

> hash_map. Also, the memory consumption of the 256-tree structure is lower
> than the hash_map, provided that you're only loading a few notes from a
> "properly fanned-out" notes tree (i.e. 100000 notes in a 2/2/36 structure).
> However, in the worst case (loading all 100000 notes), the memory usage of
> the 256-tree structure (62.64 MB) is significantly worse than the hash_map
> approach (10.25 MB).
>
> This patch modifies the 256-tree structure into a 16-tree structure. This
> significantly improves the memory situation. The result uses less memory
> than both the 256-tree structure, and the hash_map approach, with a worst
> case usage of 8.54 MB. Additionally, it seems to slightly improve the
> runtime performance as well (probably because of the improved memory usage).
